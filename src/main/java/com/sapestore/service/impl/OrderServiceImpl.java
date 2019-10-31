package com.sapestore.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.OrderDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.OrderInfo;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.State;
import com.sapestore.service.OrderService;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.DispatchSlip;
import com.sapestore.vo.OrderVO;
import com.sapestore.vo.PurchaseUpdate;
import com.sapestore.vo.PurchaseUpdateForm;
import com.sapestore.vo.RentedUpdate;
import com.sapestore.vo.ShoppingCartVO;

/**
 * Service class for updating rent information.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(OrderServiceImpl.class.getName());
	
	@Autowired
	private OrderDao orderDao;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    binder.setAutoGrowCollectionLimit(850);
	}

	@Override
	public List<Integer> updateDispatch(List<RentedUpdate> rentedUpdateList) throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateDispatch method: START");
		}
		List<OrderItemInfo> orderItemInfoList = orderDao.getRentedOrders();		
		List<OrderVO> rentedOrderBeans = setRentedOrders(orderItemInfoList);
							
		List<Integer> orderNums = null;
	
		List<Boolean> orgListDispatch = null;
		List<Boolean> orgListReturn = null;
		List<Boolean> newListDispatch = null;
		List<Boolean> newListReturn = null;

		if (rentedOrderBeans != null && rentedOrderBeans.size() > 0) {
			orderNums = new ArrayList<Integer>();
			
			orgListDispatch = new ArrayList<Boolean>();
			orgListReturn = new ArrayList<Boolean>();
			for (OrderVO r : rentedOrderBeans) {
				orgListDispatch.add(r.isOrderStatus());
				orgListReturn.add(r.isReturnReceived());
				orderNums.add(r.getOrderNumber());
				
			}
		}
		if (rentedUpdateList != null && rentedUpdateList.size() > 0) {
			newListDispatch = new ArrayList<Boolean>();
			newListReturn = new ArrayList<Boolean>();
			for (RentedUpdate r : rentedUpdateList) {
				newListDispatch.add(r.getDispatchStatus());
				newListReturn.add(r.getReturnStatus());
			}
		}
		List<Integer> dispatchedOrders = orderDao.updateDispatch(orgListDispatch, orgListReturn, newListDispatch, newListReturn, orderNums);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateDispatch method: END");
		}
		return dispatchedOrders;
	}
	
	@Override
	public void updateReturn(List<RentedUpdate> rentedUpdateList) throws SapeStoreException	{
		System.out.println("in service1111");
		List<OrderItemInfo> orderItemInfoList = orderDao.getRentedOrders();	
		int i=0;
		for(OrderItemInfo o:orderItemInfoList)
		{
			String flag="false";
			if(rentedUpdateList.get(i).getReturnStatus()==true && rentedUpdateList.get(i).getDispatchStatus()==true){
				flag="true";
				o.setActualReturnDate(new Date());
				
				orderDao.email(o);
			}else{
				flag="false";
			}
			o.setReturnStatus(flag);
			
			i++;
			orderDao.updateReturnStatus(o);
		}
		/*
		List<OrderVO> rentedOrderBeans = setRentedOrders(orderItemInfoList);
		System.out.println("after rented order");
		System.out.println(rentedOrderBeans);
		List<Integer> orderNums=new ArrayList<Integer>();		
		List<Boolean> orgListDispatch=new ArrayList<Boolean>();
		List<Boolean> orgListReturn=new ArrayList<Boolean>();		
		List<Boolean> newListDispatch=new ArrayList<Boolean>();
		List<Boolean> newListReturn=new ArrayList<Boolean>();*/
	/*	
		for(OrderVO r:rentedOrderBeans){
			orgListDispatch.add(r.isOrderStatus());
			orgListReturn.add(r.isReturnReceived());
			orderNums.add(r.getOrderNumber());
		}	
		for(RentedUpdate r:rentedUpdateList){
			newListDispatch.add(r.getDispatchStatus());
			newListReturn.add(r.getReturnStatus());
		}		*/
		/*orderDao.updateReturn(orgListDispatch, orgListReturn, newListDispatch, newListReturn, orderNums);		*/
	}
	
	
	/**
	 * set the status of rented books from the admin console
	 * 
	 * @param list
	 * @return beans
	 */
	private List<OrderVO> setRentedOrders(List<OrderItemInfo> orderItemInfoList) {
		List<OrderVO> beans = null;
		
		if (orderItemInfoList != null && !orderItemInfoList.isEmpty()) {
			
			beans = new ArrayList<OrderVO>();
			for (int i = 0; i <orderItemInfoList.size(); i++) {
				System.out.println("inside for");
				OrderVO tempList = new OrderVO();
				tempList.setOrderNumber(orderItemInfoList.get(i).getOrderItemId());
				tempList.setItemName(orderItemInfoList.get(i).getBookTitle());
				tempList.setRentAmount(orderItemInfoList.get(i).getRentPrice());
				
				String sd = orderItemInfoList.get(i).getOrderStatus();
				
				if (sd.equalsIgnoreCase("true")) {
					tempList.setOrderStatus(true);
				} else {
					tempList.setOrderStatus(false);
				}
				String sr = orderItemInfoList.get(i).getReturnStatus();
				System.out.println(i+ " " +sr);
				if (sr.equalsIgnoreCase("true")) {
					tempList.setReturnReceived(true);
				} else {
					tempList.setReturnReceived(false);
				}
				if (orderItemInfoList.get(i).getExpectedReturnDate() == null) {

				} else {
					tempList.setExpectedReturnDate(orderItemInfoList.get(i).getExpectedReturnDate());
				}
				if (orderItemInfoList.get(i).getActualReturnDate() == null) {

				} else {
					tempList.setActualReturnDate(orderItemInfoList.get(i).getExpectedReturnDate());
				}
				tempList.setLateFee(orderItemInfoList.get(i).getLateFee());
				beans.add(tempList);
			}
		}
		return beans;
	}
	
	@Override
	public void updatePayment(List<PurchaseUpdate> purchasedUpdateList) throws SapeStoreException	{
        List<OrderItemInfo> orderItemInfoList = orderDao.getPurchasedOrders();                
        int i=0;
        for(OrderItemInfo o:orderItemInfoList)
        {
                        String flag="false";
                        if(purchasedUpdateList.get(i).getPaymentStatus()==true && purchasedUpdateList.get(i).getDispatchStatus()==true){
                                        flag="true";
                        }else{
                                        flag="false";
                        }
                        o.setPaymentStatus(flag);
                        
                        i++;
                        orderDao.updatePurchaseStatus(o);
        }
        /*
        List<OrderVO> rentedOrderBeans = setRentedOrders(orderItemInfoList);
        System.out.println("after rented order");
        System.out.println(rentedOrderBeans);
        List<Integer> orderNums=new ArrayList<Integer>();                      
        List<Boolean> orgListDispatch=new ArrayList<Boolean>();
        List<Boolean> orgListReturn=new ArrayList<Boolean>();                              
        List<Boolean> newListDispatch=new ArrayList<Boolean>();
        List<Boolean> newListReturn=new ArrayList<Boolean>();*/
/*            
        for(OrderVO r:rentedOrderBeans){
                        orgListDispatch.add(r.isOrderStatus());
                        orgListReturn.add(r.isReturnReceived());
                        orderNums.add(r.getOrderNumber());
        }              
        for(RentedUpdate r:rentedUpdateList){
                        newListDispatch.add(r.getDispatchStatus());
                        newListReturn.add(r.getReturnStatus());
        }                              */
        /*orderDao.updateReturn(orgListDispatch, orgListReturn, newListDispatch, newListReturn, orderNums);                                */
	
	}
	
	
	/**
	 * set the status of rented books from the admin console
	 * 
	 * @param list
	 * @return beans
	 */
	
	@Override
	public List<DispatchSlip> getDispatchedOrders(List<Integer> list) throws SapeStoreException {
		LOGGER.debug("getDispatchedOrders method: START");
		List<DispatchSlip> dispatchList = orderDao.returnDispatchedSlips(list);
		LOGGER.debug("getDispatchedOrders method: END");
		return dispatchList;	
	}

	@Override
	public List<Integer> updatePurchaseDispatch(List<PurchaseUpdate> paymentUpdateList) throws SapeStoreException {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateDispatch method: START");
		}
		List<OrderItemInfo> orderItemInfoList = orderDao.getPurchasedOrders();		
		List<OrderVO>purchaseOrderBeans = setPurchaseOrders(orderItemInfoList);
							
		List<Integer> orderNums = null;
		List<Boolean> orgListDispatch = null;
		List<Boolean> orgListPurchase = null;
		List<Boolean> newListDispatch = null;
		List<Boolean> newListPurchase = null;

		if (purchaseOrderBeans!= null && purchaseOrderBeans.size() > 0) {
			orderNums = new ArrayList<Integer>();
			orgListDispatch = new ArrayList<Boolean>();
			orgListPurchase= new ArrayList<Boolean>();
			for (OrderVO r :purchaseOrderBeans) {
				orgListDispatch.add(r.isOrderStatus());
				orgListPurchase.add(r.isPaymentRecieved());
				orderNums.add(r.getOrderNumber());
			}
		}
		if ( paymentUpdateList!= null &&paymentUpdateList.size() > 0) {
			newListDispatch = new ArrayList<Boolean>();
			newListPurchase = new ArrayList<Boolean>();
			for (PurchaseUpdate r :paymentUpdateList ) {
				newListDispatch.add(r.getDispatchStatus());
				newListPurchase.add(r.getPaymentStatus());
			}
		}
		List<Integer> dispatchedOrders = orderDao.updateDispatch(orgListDispatch,orgListPurchase , newListDispatch, newListPurchase, orderNums);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateDispatch method: END");
		}
		return dispatchedOrders;
	
	}
	

		@Override
		public List<OrderVO> setPurchaseOrders(List<OrderItemInfo> orderItemInfoList) {
			// TODO Auto-generated method stub
			List<OrderVO> beans = null;
			//orderItemInfoList.size()
					if (orderItemInfoList != null && !orderItemInfoList.isEmpty()) {
						beans = new ArrayList<OrderVO>();
						for (int i = 0; i <orderItemInfoList.size() ; i++) {
							OrderVO tempList = new OrderVO();
							tempList.setOrderNumber(orderItemInfoList.get(i).getOrderItemId());
							tempList.setItemName(orderItemInfoList.get(i).getBookTitle());
							tempList.setBookPrice(orderItemInfoList.get(i).getBookPrice());

							String sd =  orderItemInfoList.get(i).getOrderStatus();
							System.out.println("ordeer "+sd);
							if (sd.equalsIgnoreCase("true")) {
								tempList.setOrderStatus(true);
							} else {
								tempList.setOrderStatus(false);
							}
							String sr = orderItemInfoList.get(i).getPaymentStatus();
							System.out.println("payment "+sr);
							if (sr.equalsIgnoreCase("true")) {
								tempList.setPaymentRecieved(true);
							} else {
								tempList.setPaymentRecieved(false);
							}
							beans.add(tempList);
						}
					}
					return beans;
		}
	@Override
    public List<OrderItemInfo> orderStatusTracker(Integer orderId) {
           // TODO Auto-generated method stub
           return orderDao.orderStatusTracker(orderId);
    }

	@Override
	public List<List<OrderItemInfo>> orderStatusTrackerbyType(String orderType,String userId) {
		// TODO Auto-generated method stub
		return orderDao.orderStatusTrackerbyType(orderType,userId);
	}

	@Override
	public Address getShippingAddress(String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getShippingAddress(userId);
	}

	@Override
	public City getCityById(Integer cityId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getCityById(cityId);
	}

	@Override
	public State getStateById(Integer stateId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getStateById(stateId);
	}

	@Override
	public List<Book> getItemsInOrder(Integer orderId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getItemsInOrder(orderId);
	}

	@Override
	public Book getBookByISBN(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getBookByISBN(isbn);
	}

	@Override
	public List<OrderItemInfo> getOrderInfo(Integer orderId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getOrderInfo(orderId);
	}
	

	@Override
	public boolean sendMail(String userId, ShoppingCartVO shoppingCart, Address address) throws SapeStoreException {
		// TODO Auto-generated method stub
		String email=orderDao.getEMailById(userId);
		String from = "admin@sapestore.com";
		String host = "inrelaymail.sapient.com";
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", host);
		Session session = Session.getInstance(properties);
		String mess="";
		Integer size=shoppingCart.getBooksInCart().size();
		for(Integer i=0;i<size;i++)
		{
			BookVO book=null;
			book=shoppingCart.getBooksInCart().get(i);
			String name=book.getBookTitle();
			String author=book.getBookAuthor();
			Double price=book.getBookPrice();
			mess=mess+"Name: "+name.trim()+","+" Author: "+author.trim()+","+" Price: "+price+"\n";
			
		}	
		Integer stateId=address.getStateId();
		State state=orderDao.getStateById(stateId);
		Integer cityId=address.getCityId();
		City city=orderDao.getCityById(cityId); 
		
		try{
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
		message.setSubject("order confirmation");
		message.setText("Your order is confirmed! \n"+
				" List of your order is:\n "+mess+
				"\n"+"Order total is:"+shoppingCart.getTotalPrice()+
				"\n"+"Order quantity:"+shoppingCart.getTotalQuantity()+
				"\n"+"Shipping address: "+address.getAddressLine1()+", "+address.getAddressLine2()+", "+
				city.getCityName()+", "+state.getStateName()+", "+address.getPostalCode()); 
		
		Transport.send(message);
		return true;
		}catch(MessagingException mex){
			mex.printStackTrace();
		 	return false;
		}
		}
	

	@Override
	public Integer giveOrder(ShoppingCartVO shoppingCart, String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.giveOrder(shoppingCart, userId);
	}

	@Override
	public String getNameByAddressId(Integer addresId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.getNameByAddressId(addresId);
	}
	@Override
	public void approveReturn(String[] approveUpdateList) throws SapeStoreException {
		for(String orderItemId : approveUpdateList) {
			orderDao.approveOrder(orderItemId);
		}
	}
	@Override
	public void disapproveReturn(String[] disapproveUpdateList) throws SapeStoreException {
		for(String orderItemId : disapproveUpdateList) {
			orderDao.disapproveOrder(orderItemId);
		}
	}

	@Override
	public OrderInfo orderStatusTrackerDispatcher(Integer orderId) throws SapeStoreException {
		// TODO Auto-generated method stub
		System.out.println("Dispatch : Service");
		return orderDao.orderStatusTrackerDispatcher(orderId);
	}

	@Override
	public List<OrderInfo> orderStatusTrackerbyTypeDispatcher(String orderType, String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return orderDao.orderStatusTrackerbyTypeDispatcher(orderType, userId);
	}

	@Override
	public Boolean sendSms(String mobileNumber, String message) {
		// TODO Auto-generated method stub
		String authkey = "150408A4J1zcIEuLJe59017af7";
        //Multiple mobiles numbers separated by comma
        //Sender ID,While using route4 sender id should be 6 characters long.
        String senderId = "SapeCo";
        //Your message to send, Add URL encoding here.
        //define route
        String route="4";

        //Prepare Url
        URLConnection myURLConnection=null;
        URL myURL=null;
        BufferedReader reader=null;

        //encoding message
        String encoded_message=URLEncoder.encode(message);

        //Send SMS API
        String mainUrl="https://control.msg91.com/api/sendhttp.php?";

        //Prepare parameter string
        StringBuilder sbPostData= new StringBuilder(mainUrl);
        sbPostData.append("authkey="+authkey);
        sbPostData.append("&mobiles="+mobileNumber);
        sbPostData.append("&message="+encoded_message);
        sbPostData.append("&route="+route);
        sbPostData.append("&sender="+senderId);

        //final string
        mainUrl = sbPostData.toString();
        try
        {
            //prepare connection
            myURL = new URL(mainUrl);
            myURLConnection = myURL.openConnection();
            myURLConnection.connect();
            reader= new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
            //reading response
            String response;
            while ((response = reader.readLine()) != null)
            //print response
            System.out.println(response);

            //finally close connection
            reader.close();
        }
        catch (IOException e)
        {
                e.printStackTrace();
        }
        return false;
	}


	
}