package com.sapestore.dao;

import java.text.DateFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.BasicConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.Country;
import com.sapestore.hibernate.entity.OrderInfo;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.ShoppingCart;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.DispatchSlip;
import com.sapestore.vo.ShoppingCartVO;
import com.sun.mail.iap.ConnectionException;

/**
 * DAO class for order management module
 */
@Repository
@Transactional
public class OrderDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;

	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(OrderDao.class.getName());

	/**
	 * gets the rented status of the book
	 * 
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.setAutoGrowCollectionLimit(850);
	}

	@SuppressWarnings("unchecked")
	public List<OrderItemInfo> getRentedOrders() throws SapeStoreException {
		LOGGER.debug("InventoryDao.getBookDetails method: START");
		List<OrderItemInfo> orderItemInfoList = null;
		orderItemInfoList = (List<OrderItemInfo>) hibernateTemplate
				.findByNamedQuery("OrderItemInfo.findByPurchaseType");
		return orderItemInfoList;
	}

	@SuppressWarnings("unchecked")
	public List<OrderItemInfo> getPurchasedOrders() throws SapeStoreException {
		LOGGER.debug("InventoryDao.getBookDetails method: START");
		List<OrderItemInfo> orderItemInfoList = null;
		orderItemInfoList = (List<OrderItemInfo>) hibernateTemplate.findByNamedQuery("OrderItemInfo.findPurchaseBooks");
		return orderItemInfoList;
	}

	public void deletePurchaseOrder() {
		hibernateTemplate.findByNamedQuery("OrderItemInfo.deletePurchasedBooks");
	}

	/**
	 * update dispatch update the status of dispatched books
	 * 
	 * @param orgListDispatch
	 * @param orgListReturn
	 * @param newListDispatch
	 * @param newListReturn
	 * @param orderNums
	 * @return
	 */
	public List<Integer> updateDispatch(List<Boolean> orgListDispatch, List<Boolean> orgListReturn,
			List<Boolean> newListDispatch, List<Boolean> newListReturn, List<Integer> orderNums) {

		List<Integer> ordersToBeDispatched = null;
		List<Integer> ordersReturned = null;

		if (orderNums != null && orderNums.size() > 0) {
			ordersToBeDispatched = new ArrayList<Integer>();
			ordersReturned = new ArrayList<Integer>();
			for (int i = 0; i < orderNums.size(); i++) {
				if (orgListDispatch.get(i) == false && newListDispatch.get(i) == true) {
					ordersToBeDispatched.add(orderNums.get(i));
					if (newListReturn.get(i) == true) {
						ordersReturned.add(orderNums.get(i));
					}
				}
			}
		}
		return ordersToBeDispatched;
	}

	/**
	 * @param orgListDispatch
	 * @param orgListReturn
	 * @param newListDispatch
	 * @param newListReturn
	 * @param orderNums
	 */
	public void updateReturn(List<Boolean> orgListDispatch, List<Boolean> orgListReturn, List<Boolean> newListDispatch,
			List<Boolean> newListReturn, List<Integer> orderNums) {

		List<Integer> ordersReturned = null;
		if (orderNums != null && orderNums.size() > 0) {
			ordersReturned = new ArrayList<Integer>();
			for (int i = 0; i < orderNums.size(); i++) {
				System.out.println("inside dao");
				System.out.println(orgListDispatch.get(i) + "1");
				System.out.println(newListReturn.get(i) + "2");
				if (orgListDispatch.get(i) == true && newListReturn.get(i) == true) {
					ordersReturned.add(orderNums.get(i));
				}
			}
		}
		System.out.println(ordersReturned);
		Date date = new Date();
		// String d = new SimpleDateFormat("dd-MMM-yy").format(date);

		/*
		 * Update return_status and actual_return_date for list of orders
		 * returned : ordersReturned
		 */System.out.println(date);
		// OrderItemInfo orderItemInfo = new OrderItemInfo();
		List<OrderItemInfo> orderlist = new ArrayList<OrderItemInfo>();

		for (Integer orderId : ordersReturned) {

			String query1 = "from OrderItemInfo o where o.orderId='" + orderId + "'";
			System.out.println(query1);
			orderlist = (List<OrderItemInfo>) hibernateTemplate.find(query1);
			System.out.println(orderlist);
		}
		// Integer orderId1=orderlist.get(0).getOrderId();
		// Integer orderItemId=orderlist.get(0).getOrderItemId();
		for (int i = 0; i < orderlist.size(); i++) {

			OrderItemInfo orderItemInfo = orderlist.get(i);
			orderItemInfo.setReturnStatus("true");
			orderItemInfo.setActualReturnDate(date);
			orderItemInfo.setCreatedDate(date);
			orderItemInfo.setDispatchDate(date);

			/*
			 * orderItemInfo.setReturnStatus("true");
			 * orderItemInfo.setActualReturnDate(date);
			 * orderItemInfo.setOrderId(orderId1);
			 * orderItemInfo.setCreatedDate(date);
			 * orderItemInfo.setDispatchDate(date);
			 * orderItemInfo.setOrderItemId(orderItemId);
			 */

			hibernateTemplate.saveOrUpdate(orderItemInfo);
		}
	}

	public void updatePurchase(List<Boolean> orgListDispatch, List<Boolean> orgListPurchase,
			List<Boolean> newListDispatch, List<Boolean> newListPurchase, List<Integer> orderNums) {

		List<Integer> ordersPurchased = null;
		if (orderNums != null && orderNums.size() > 0) {
			ordersPurchased = new ArrayList<Integer>();
			for (int i = 0; i < orderNums.size(); i++) {
				if (orgListDispatch.get(i) == true && newListPurchase.get(i) == false) {
					ordersPurchased.add(orderNums.get(i));
				}
			}
		}
		// String d = new SimpleDateFormat("dd-MMM-yy").format(date);

		/*
		 * Update return_status and actual_return_date for list of orders
		 * returned : ordersReturned
		 */
		System.out.println(ordersPurchased);
		OrderItemInfo orderItemInfo = new OrderItemInfo();
		for (Integer orderItemId : ordersPurchased) {
			orderItemInfo = hibernateTemplate.get(OrderItemInfo.class, orderItemId);
			orderItemInfo.setPaymentStatus("true");
			// orderItemInfo.setActualReturnDate(date);
			hibernateTemplate.saveOrUpdate(orderItemInfo);
		}
	}

	/*
	 * public void updatePayment(List<Boolean> orgListDispatch, List<Boolean>
	 * orgListPayment, List<Boolean> newListDispatch, List<Boolean>
	 * newListPayment, List<Integer> orderNums) {
	 * 
	 * List<Integer> ordersPaid = null; if(orderNums!=null &&
	 * orderNums.size()>0) { ordersPaid = new ArrayList<Integer>(); for (int i =
	 * 0; i < orderNums.size(); i++) { System.out.println("in order dao loop");
	 * if (orgListDispatch.get(i) == true && newListPayment.get(i) == true) {
	 * ordersPaid.add(orderNums.get(i)); } } } /* Update return_status and
	 * actual_return_date for list of orders returned : ordersReturned
	 * 
	 * System.out.println(ordersPaid); OrderItemInfo orderItemInfo = new
	 * OrderItemInfo(); for (Integer orderItemId : ordersPaid) {
	 * System.out.println("elp"); orderItemInfo =
	 * hibernateTemplate.get(OrderItemInfo.class, orderItemId);
	 * System.out.println(orderItemInfo);
	 * orderItemInfo.setPaymentStatus("true");
	 * hibernateTemplate.saveOrUpdate(orderItemInfo); } }
	 */
	/**
	 * This method sets dispatch slip.
	 * 
	 * @param list1
	 *            List of all the ordersIds to be dispatched
	 * @return List of all the orders to be dispatched
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	@SuppressWarnings("unchecked")
	public List<DispatchSlip> returnDispatchedSlips(List<Integer> list1) throws SapeStoreException {
		LOGGER.debug("returnDispatchedSlips method: START");
		List<DispatchSlip> dispatchSlipBeans = new ArrayList<DispatchSlip>();

		try {
			for (Integer i : list1) {
				String query = "select m.name,a.address_line1,a.address_line2,c.city_name,d.country_name from sapestore_members_info m,"
						+ "sapestore_members_address a,sapestore_cities c,sapestore_countries d "
						+ " where a.user_id in (select user_id from order_info "
						+ "where order_id in (select order_id from order_item_info where order_item_id='" + i
						+ "'))AND m.user_id in (select user_id from order_info "
						+ "where order_id =(select order_id from order_item_info " + "where order_item_id='" + i
						+ "')) AND a.city_id=c.city_id AND" + " a.country_id=d.country_id";
				List<Object[]> list = null;
				list = hibernateTemplate.getSessionFactory().getCurrentSession().createSQLQuery(query).list();
				DispatchSlip dispatchSlipBean = new DispatchSlip();
				for (Object[] aRow : list) {
					if (list.size() != 0) {
						String name = (String) aRow[0];
						String address = (String) aRow[1] + "," + (String) aRow[2] + "," + (String) aRow[3] + ","
								+ (String) aRow[4];
						dispatchSlipBean.setOrderNumber(i);
						dispatchSlipBean.setCustomerName(name);
						dispatchSlipBean.setShippingAddress(address);
						dispatchSlipBeans.add(dispatchSlipBean);

						System.out.println(dispatchSlipBeans);
						System.out.println("abcd");
					}

					System.out.println("abcgder");

					for (Integer orderId : list1) {
						OrderItemInfo orderItemInfo = null;
						orderItemInfo = hibernateTemplate.get(OrderItemInfo.class, orderId);
						orderItemInfo.setOrderStatus("true");
						orderItemInfo.setDispatchDate(new Date());
						hibernateTemplate.saveOrUpdate(orderItemInfo);
						LOGGER.debug("Orders are updated");
					}
				}
			}
		}

		// Integer orderId1=orderlist.get(0).getOrderId();
		// Integer orderItemId=orderlist.get(0).getOrderItemId();

		catch (SapeStoreSystemException se) {

			LOGGER.fatal("A DB exception occured while getting the dispatch orders list", se);
		}
		LOGGER.debug("returnDispatchedSlips method: END");
		return dispatchSlipBeans;
	}

	public List<OrderItemInfo> orderStatusTracker(Integer orderId) {
		// String sql = "from OrderInfo O where O.order_id = :orderId";
		/*
		 * boolean flag; OrderInfo orderInfo =
		 * hibernateTemplate.get(OrderInfo.class, orderId);
		 */
		LOGGER.debug("orderStatusTracker in OrderDao: START");
		OrderInfo orderInfo = hibernateTemplate.get(OrderInfo.class, orderId);

		String query = "FROM OrderItemInfo o where o.orderId='" + orderId + "'";
		List<OrderItemInfo> itemsList = (List<OrderItemInfo>) hibernateTemplate.find(query);
		System.out.println(itemsList);
		System.out.println("3");
		/*
		 * String sql = "from OrderItemInfo where order_id = :orderId";
		 * List<Map<String, Object>> list = null; list = (List<Map<String,
		 * Object>>) hibernateTemplate.getSessionFactory().getCurrentSession().
		 * createSQLQuery(sql);
		 */

		System.out.println("4");
		LOGGER.debug("orderStatusTracker in OrderDao: END");

		return itemsList;
	}

	public List<List<OrderItemInfo>> orderStatusTrackerbyType(String orderType, String userId) {
		List<OrderItemInfo> itemsList = null;
		List<List<OrderItemInfo>> listOflist = new ArrayList<>();
		String query = "from OrderInfo o where o.userId = '" + userId + "'";
		List<OrderInfo> orderList = (List<OrderInfo>) hibernateTemplate.find(query);
		String orderType2 = orderType.toLowerCase();
		System.out.println(orderList);
		for (OrderInfo o : orderList) {
			Integer orderId = o.getOrderId();
			String query2 = "from OrderItemInfo o where o.orderId = '" + orderId + "' and (o.purchaseType = '"
					+ orderType + "' or o.purchaseType = '" + orderType2 + "')";
			itemsList = (List<OrderItemInfo>) hibernateTemplate.find(query2);
			listOflist.add(itemsList);
		}
		System.out.println(listOflist);
		return listOflist;
	}

	public Address getShippingAddress(String userId) throws SapeStoreException {
		LOGGER.debug("getShippingAddress in OrderDao: START");
		User user = hibernateTemplate.get(User.class, userId);
		System.out.println("User iser obj :" + user);
		// System.out.println("User "+user);
		// Address address= (Address)
		// hibernateTemplate.findByNamedQueryAndNamedParam("Address.findByAddressId",
		// "addressId", user.getAddressId());
		// Integer addressId=43600;
		System.out.println("user address Id:" + user.getAddressId());
		Address address = hibernateTemplate.get(Address.class, user.getAddressId());
		// System.out.println("in order dao get shipping address");
		// System.out.println(address);
		LOGGER.debug("getShippingAddress in OrderDao: END");
		// System.out.println("in order dao end shipping address");
		return address;
	}

	public City getCityById(Integer cityId) throws SapeStoreException {
		LOGGER.debug("getCityById in OrderDao: START");
		List<City> cityList = (List<City>) hibernateTemplate.findByNamedQueryAndNamedParam("City.findByCityId",
				"cityId", cityId);
		City city = cityList.get(0);
		LOGGER.debug("getCityById in OrderDao: END");
		return city;
	}

	public List<String> getCityNames() throws SapeStoreException {
		LOGGER.debug("getCityNames in OrderDao: START");
		List<City> cityList = (List<City>) hibernateTemplate.find("from City");
		List<String> cityNames = new ArrayList<String>();
		for (City city : cityList) {
			String cityName = city.getCityName();
			cityNames.add(cityName);
		}
		LOGGER.debug("getCityNames in OrderDao: END");
		return cityNames;
	}

	public List<String> getStateNames() throws SapeStoreException {
		LOGGER.debug("getStateNames in Order Dao: START");
		List<State> stateList = (List<State>) hibernateTemplate.find("from State");
		List<String> stateNames = new ArrayList<String>();
		for (State state : stateList) {
			String stateName = state.getStateName();
			stateNames.add(stateName);
		}
		LOGGER.debug("getStateNames in OrderDao: END");
		return stateNames;
	}

	public State getStateById(Integer stateId) throws SapeStoreException {
		LOGGER.debug("getStateById in OrderDao: START");
		List<State> stateList = (List<State>) hibernateTemplate.findByNamedQueryAndNamedParam("State.findByStateId",
				"stateId", stateId);
		State state = stateList.get(0);
		LOGGER.debug("getStateById in OrderDao: END");
		return state;
	}

	public Integer getCityIdByName(String cityName) throws SapeStoreException {
		LOGGER.debug("getCityIdByName in OrderDao: START");
		List<City> cityIdList= (List<City>) hibernateTemplate.findByNamedQueryAndNamedParam("City.findByCityName", "cityName", cityName);
		if(cityIdList.size()==0) {
			return -5;
		} 
		City city = cityIdList.get(0);
		Integer cityId = city.getCityId();
		LOGGER.debug("getCityIdByName in OrderDao: END");
		return cityId;
	}

	public Integer getStateIdByName(String stateName) throws SapeStoreException {
		LOGGER.debug("getStateIdByName in OrderDao: START");
		List<State> stateIdList = (List<State>) hibernateTemplate.findByNamedQueryAndNamedParam("State.findByStateName",
				"stateName", stateName);
		State state = stateIdList.get(0);
		Integer stateId = state.getStateId();
		LOGGER.debug("getStateIdByName in OrderDao : END");
		return stateId;
	}

	public Integer getCountryIdByName(String stateName) throws SapeStoreException {
		LOGGER.debug("getCountryIdByName By OrderDao: START");
		List<State> stateList = (List<State>) hibernateTemplate.findByNamedQueryAndNamedParam("State.findByStateName2",
				"stateName", stateName);
		State state = stateList.get(0);
		Integer countryId = state.getCountryId();
		LOGGER.debug("getCountryIdByName By OrderDao: END");
		return countryId;
	}
	
	public Country getCountryById(Integer countryId) throws SapeStoreException{
		LOGGER.debug("getCountryById in OrderDao: START");
		List<Country> countryList=  (List<Country>) hibernateTemplate.findByNamedQueryAndNamedParam("Country.findByCountryId1", "countryId", countryId);
		Country country=countryList.get(0);
		System.out.println("in country doa"+country);
		LOGGER.debug("getCountryById in OrderDao: END");
		return country;
	} 

	public State getStateByName(String stateName) throws SapeStoreException {
		LOGGER.debug("getStateByName: START");
		List<State> stateIdList = (List<State>) hibernateTemplate
				.findByNamedQueryAndNamedParam("State.findByStateName3", "stateName", stateName);
		State state = stateIdList.get(0);
		LOGGER.debug("getStateByName: END");
		return state;
	}

	public List<String> getCityNamesByState(Integer stateId) throws SapeStoreException {
		LOGGER.debug("getCityNames: START");
		List<City> cityList = (List<City>) hibernateTemplate.findByNamedQueryAndNamedParam("City.findByStateId",
				"stateId", stateId);
		List<String> cityNames = new ArrayList<String>();
		for (City city : cityList) {
			String cityName = city.getCityName();
			cityNames.add(cityName);
		}
		LOGGER.debug("getCityNames: END");
		return cityNames;
	}

	public List<Book> getItemsInOrder(Integer orderId) throws SapeStoreException {
		LOGGER.debug("getItemsInOrder in OrderDao: START");
		String query = "FROM OrderItemInfo o where o.orderId='" + orderId + "'";
		List<OrderItemInfo> itemsList = (List<OrderItemInfo>) hibernateTemplate.find(query);
		List<Book> bookList = new ArrayList<Book>();
		Book book = new Book();
		for (OrderItemInfo item : itemsList) {
			book = new Book();
			book = hibernateTemplate.get(Book.class, item.getIsbn());
			bookList.add(book);
		}
		LOGGER.debug("getItemsInOrder in OrderDao: END");
		return bookList;
	}

	public List<OrderItemInfo> getOrderInfo(Integer orderId) throws SapeStoreException {
		LOGGER.debug("getOrderInfo in OrderDao: START");

		String query = "FROM OrderItemInfo o where o.orderId='" + orderId + "'";
		List<OrderItemInfo> itemsList = (List<OrderItemInfo>) hibernateTemplate.find(query);
		LOGGER.debug("getOrderInfo in OrderDao: END");
		return itemsList;
	}

	public Book getBookByISBN(String isbn) throws SapeStoreException {
		LOGGER.debug("getBookByISBN method in OrderDao: START");
		Book book = hibernateTemplate.get(Book.class, isbn);
		LOGGER.debug("getBookByISBN method in OrderDao: END");
		return book;
	}

	public Address getAddressByUser(String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		BasicConfigurator.configure();
		LOGGER.debug("getAddressByUser method in OrderDao: START");
		String query1 = "from Address a where a.userId='" + userId + "'";
		List<Address> addressList = (List<Address>) hibernateTemplate.find(query1);
		Address address = addressList.get(0);
		LOGGER.debug("getAddressByUser method in OrderDao: END");
		return address;
	}

	public void editAddress(Address address) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("editAddress method in OrderDao: START");

		hibernateTemplate.update(address);
		LOGGER.debug("editAddress method in OrderDao: END");
	}

	public Integer giveOrder(ShoppingCartVO shoppingCart, String userId) throws SapeStoreException {
		LOGGER.debug("giveOrder method in OrderDao: START");

		OrderInfo orderInfo = new OrderInfo();
		Date date = new Date();
		Integer orderId = null;
		orderInfo.setUserId(userId);
		orderInfo.setOrderDate(date);
		orderInfo.setCreatedDate(date);
		orderInfo.setUpdatedDate(date);
		orderInfo.setOrderStatus("NOT_DISPATCHED");
		orderInfo.setTotalPayment(shoppingCart.getTotalPrice());
		orderInfo.setPaymentMode("Cash");
		orderInfo.setIsActive("Y");
		orderId = (Integer) hibernateTemplate.save(orderInfo);
		Integer itemId = null;
		Book bookObj = null;
		for (BookVO book : shoppingCart.getBooksInCart()) {
			if (book.getPurchaseType().equalsIgnoreCase("P")) {
				OrderItemInfo itemInfo = new OrderItemInfo();
				itemInfo.setOrderId(orderId);
				itemInfo.setIsbn(book.getIsbn());
				itemInfo.setBookPrice(book.getBookPrice());
				itemInfo.setOrderQuantity(book.getCartQuantity());
				itemInfo.setCreatedDate(date);
				itemInfo.setUpdatedDate(date);
				itemInfo.setIsActive("Y");
				itemInfo.setPurchaseType("PURCHASED");
				itemInfo.setReturnStatus("false");
				itemInfo.setOrderStatus("false");
				itemInfo.setPaymentStatus("false");
				itemId = (Integer) hibernateTemplate.save(itemInfo);
				bookObj = hibernateTemplate.get(Book.class, book.getIsbn());
				bookObj.setQuantity(bookObj.getQuantity() - book.getCartQuantity());
				hibernateTemplate.update(bookObj);
			} else if (book.getPurchaseType().equalsIgnoreCase("R")) {
				OrderItemInfo itemInfo = new OrderItemInfo();
				itemInfo.setOrderId(orderId);
				itemInfo.setIsbn(book.getIsbn());
				itemInfo.setBookPrice(book.getBookPrice());
				itemInfo.setOrderQuantity(book.getCartQuantity());
				itemInfo.setCreatedDate(date);
				itemInfo.setUpdatedDate(date);
				itemInfo.setExpectedReturnDate(book.getReturnDate());
				itemInfo.setIsActive("Y");
				itemInfo.setPurchaseType("PENDING");
				itemInfo.setReturnStatus("true");
				itemInfo.setOrderStatus("false");
				itemInfo.setPaymentStatus("false");
				itemInfo.setExpectedReturnDate(date);
				itemId = (Integer) hibernateTemplate.save(itemInfo);
				bookObj = hibernateTemplate.get(Book.class, book.getIsbn());
				bookObj.setQuantity(bookObj.getQuantity() - book.getCartQuantity());
				hibernateTemplate.update(bookObj);
			}

		}
		System.out.println("getting out of give order function");
		LOGGER.debug("giveOrder method in OrderDao: START");
		return orderId;
	}
	
	public void getNameByUserId(String userId) throws SapeStoreException {
		LOGGER.debug("getNameByUserId method in OrderDao: START");
		String query = "from User u where u.userId='" + userId + "'";
		List<User> userList = (List<User>) hibernateTemplate.find(query);
		User user = userList.get(0);
		String name = user.getName();
		String mobile = user.getMobileNumber();
		String query3 = "from Address a where a.userId='" + userId + "'";
		List<Address> addressList = (List<Address>) hibernateTemplate.find(query3);
		Address address = addressList.get(0);
		address.setMobileNumber(mobile);
		address.setName(name);
		hibernateTemplate.saveOrUpdate(address);
		LOGGER.debug("getNameByUserId method in OrderDao: END");
	}


	public String getEMailById(String userId) throws SapeStoreException {
		LOGGER.debug("getEmailByID method in OrderDao: START");
		String query = "from User u where u.userId='" + userId + "'";
		List<User> userList = (List<User>) hibernateTemplate.find(query);
		User user = userList.get(0);
		LOGGER.debug("getEmailByID method in OrderDao: END");
		return user.getEmailAddress();
	}

	public String getNameByAddressId(Integer addresId) throws SapeStoreException {
		LOGGER.debug("getNameByAddressId method in OrderDao: START");
		String query = "from User u where u.addressId='" + addresId + "'";
		List<User> userList = (List<User>) hibernateTemplate.find(query);
		User user = userList.get(0);
		LOGGER.debug("getNameByAddressId method in OrderDao: END");
		return user.getName();
	}

	public void updatePurchaseStatus(OrderItemInfo orderItemInfo) {
		LOGGER.debug("updatePurchaseStatus method in OrderDao: START");
		hibernateTemplate.saveOrUpdate(orderItemInfo);
		LOGGER.debug("updatePurchaseStatus method in OrderDao: END");
	}

	public void updateReturnStatus(OrderItemInfo orderItemInfo) {
		LOGGER.debug("updateReturnStatus method in OrderDao: START");
		hibernateTemplate.saveOrUpdate(orderItemInfo);

		LOGGER.debug("updateReturnStatus method in OrderDao: END");
	}

	public void email(OrderItemInfo o) {

		OrderInfo orderInfo = hibernateTemplate.get(OrderInfo.class, o.getOrderId());

		String email = orderInfo.getEmailAddress();
		String name = orderInfo.getName();
		System.out.println(email);

		String from = "admin@sapestore.com";
		String host = "inrelaymail.sapient.com";
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", host);
		Session session = Session.getInstance(properties);
		String mess = "Dear " + name + " Your Book Has Been Returned";

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("return confirmation");
			message.setText("Your return is confirmed! \n" + mess);

			Transport.send(message);

		} catch (MessagingException mex) {
			mex.printStackTrace();

		}

	}

	@SuppressWarnings("unchecked")
	public List<OrderItemInfo> getPendingOrder() throws SapeStoreException {
		List<OrderItemInfo> orderItemInfoList1 = null;
		orderItemInfoList1 = (List<OrderItemInfo>) hibernateTemplate
				.findByNamedQuery("OrderItemInfo.findByPurchaseType1");
		System.out.println("in order dao" + orderItemInfoList1);
		return orderItemInfoList1;
	}

	public void approveOrder(String orderItemId) {
		if (orderItemId.length() != 0) {
			List<OrderItemInfo> orderItemInfoList = (List<OrderItemInfo>) hibernateTemplate
					.find("from OrderItemInfo o where o.orderItemId = '" + orderItemId + "'");
			OrderItemInfo orderItemInfo = null;

			orderItemInfo = orderItemInfoList.get(0);

			orderItemInfo.setPurchaseType("RENTED");
			orderItemInfo.setReturnStatus("false");

			hibernateTemplate.saveOrUpdate(orderItemInfo);

			OrderItemInfo order = hibernateTemplate.get(OrderItemInfo.class, orderItemInfo.getOrderItemId());

			Integer orderId = orderItemInfo.getOrderId();
			String query = "from OrderInfo o where o.orderId='" + orderId + "'";
			List<OrderInfo> orderList = (List<OrderInfo>) hibernateTemplate.find(query);
			OrderInfo orderInfo = orderList.get(0);
			String userId = orderInfo.getUserId();
			String query1 = "from User u where u.userId='" + userId + "'";
			List<User> userList = (List<User>) hibernateTemplate.find(query1);
			User user = userList.get(0);
			LOGGER.debug("getEmailByID method in OrderDao: END");
			String email = user.getEmailAddress();
			System.out.println(email);

			String isbn = orderItemInfo.getIsbn();
			String query2 = "from Book b where b.isbn='" + isbn + "'";
			List<Book> bookList = (List<Book>) hibernateTemplate.find(query2);
			Book booknew = bookList.get(0);
			String bookname = booknew.getBookTitle();

			String from = "admin@sapestore.com";
			String host = "inrelaymail.sapient.com";
			Properties properties = System.getProperties();
			properties.setProperty("mail.smtp.host", host);
			Session session = Session.getInstance(properties);

			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
				message.setSubject("Rent confirmation");
				message.setText("Your rent is accepted for:" + bookname);

				Transport.send(message);

			} catch (MessagingException mex) {
				mex.printStackTrace();

			}
		}

	}

	public void disapproveOrder(String orderItemId) {
		if (orderItemId.length() != 0) {
			List<OrderItemInfo> orderItemInfoList = (List<OrderItemInfo>) hibernateTemplate
					.find("from OrderItemInfo o where o.orderItemId = '" + orderItemId + "'");
			OrderItemInfo orderItemInfo = null;
			if (orderItemInfoList != null) {
				orderItemInfo = orderItemInfoList.get(0);
				orderItemInfo.setPurchaseType("REJECTED");

				hibernateTemplate.saveOrUpdate(orderItemInfo);

				Integer orderId = orderItemInfo.getOrderId();
				String query = "from OrderInfo o where o.orderId='" + orderId + "'";
				List<OrderInfo> orderList = (List<OrderInfo>) hibernateTemplate.find(query);
				OrderInfo orderInfo = orderList.get(0);
				String userId = orderInfo.getUserId();
				String query1 = "from User u where u.userId='" + userId + "'";
				List<User> userList = (List<User>) hibernateTemplate.find(query1);
				User user = userList.get(0);
				LOGGER.debug("getEmailByID method in OrderDao: END");
				String email = user.getEmailAddress();

				String isbn = orderItemInfo.getIsbn();
				String query2 = "from Book b where b.isbn='" + isbn + "'";
				List<Book> bookList = (List<Book>) hibernateTemplate.find(query2);
				Book booknew = bookList.get(0);
				String bookname = booknew.getBookTitle();

				String from = "admin@sapestore.com";
				String host = "inrelaymail.sapient.com";
				Properties properties = System.getProperties();
				properties.setProperty("mail.smtp.host", host);
				Session session = Session.getInstance(properties);

				try {
					MimeMessage message = new MimeMessage(session);
					message.setFrom(new InternetAddress(from));
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
					message.setSubject("Rent confirmation");
					message.setText("Your rent is rejected for:" + bookname);

					Transport.send(message);

				} catch (MessagingException mex) {
					mex.printStackTrace();

				}

			}
		}
	}

	public OrderInfo orderStatusTrackerDispatcher(Integer orderId) {
		System.out.println("Dispatch : DAO");
		OrderInfo orderInfo = hibernateTemplate.get(OrderInfo.class, orderId);
		System.out.println(orderInfo);
		return orderInfo;
	}

	public List<OrderInfo> orderStatusTrackerbyTypeDispatcher(String orderType, String userId) {
		List<String> dispatchStatus = new ArrayList<>();
		String query = "from OrderInfo o where o.userId = '" + userId + "'";
		List<OrderInfo> orderList = (List<OrderInfo>) hibernateTemplate.find(query);
		System.out.println(orderList);
		return orderList;
	}

}
