package com.sapestore.service;

import java.util.List;


import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.OrderInfo;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.State;
import com.sapestore.vo.DispatchSlip;
import com.sapestore.vo.OrderVO;
import com.sapestore.vo.PurchaseUpdate;
import com.sapestore.vo.PurchaseUpdateForm;
import com.sapestore.vo.RentedUpdate;
import com.sapestore.vo.ShoppingCartVO;
import com.sun.mail.iap.ConnectionException;

/**
 * Service interface for updating rent information.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

public interface OrderService {

	/**
	 * Updates dispatch status of books.
	 * @param rentedUpdateList
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	List<Integer> updateDispatch(List<RentedUpdate> rentedUpdateList) throws SapeStoreException;

	public List<Integer> updatePurchaseDispatch(List<PurchaseUpdate> paymentUpdateList) throws SapeStoreException;
	/**
	 * Updates return status of books.
	 * @param rentedUpdateList
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	void updateReturn(List<RentedUpdate> rentedUpdateList) throws SapeStoreException;
	void updatePayment(List<PurchaseUpdate> paymentUpdateList) throws SapeStoreException;
	/**
	 * Returns list of dispatched orders.
	 * @param list
	 * @return
	 * @throws SapeStoreSystemException
	 */
	List<DispatchSlip> getDispatchedOrders(List<Integer> list) throws SapeStoreException;
	 List<OrderVO> setPurchaseOrders(List<OrderItemInfo> orderItemInfoList);
	 public Address getShippingAddress(String userId) throws SapeStoreException;
		public City getCityById(Integer cityId) throws SapeStoreException;
		public State getStateById(Integer stateId) throws SapeStoreException;
		public List<Book> getItemsInOrder(Integer orderId) throws SapeStoreException;
		/*boolean orderStatusTracker(Integer orderId);*/
		
		public List<OrderItemInfo> getOrderInfo(Integer orderId) throws SapeStoreException;
		public List<OrderItemInfo> orderStatusTracker(Integer orderId) throws SapeStoreException;
		public List<List<OrderItemInfo>> orderStatusTrackerbyType(String orderType,String userId);
		public Book getBookByISBN(String isbn) throws SapeStoreException;
		public Integer giveOrder(ShoppingCartVO shoppingCart, String userId) throws SapeStoreException;
		public boolean sendMail(String userId, ShoppingCartVO shoppingCart, Address address)throws SapeStoreException;
		public String getNameByAddressId(Integer addresId) throws SapeStoreException;
		void approveReturn(String[] approveUpdateList) throws SapeStoreException;
		void disapproveReturn (String[] disapproveUpdateList) throws SapeStoreException;
		public OrderInfo orderStatusTrackerDispatcher(Integer orderId) throws SapeStoreException;
		public List<OrderInfo> orderStatusTrackerbyTypeDispatcher(String orderType,String userId)throws SapeStoreException;
		public Boolean sendSms(String mobileNumber,String message);
}
