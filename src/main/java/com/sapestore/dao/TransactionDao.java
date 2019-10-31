package com.sapestore.dao;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.OrderInfo;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.Transaction;

/**
 * DAO class for admin report.
 * 
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 User Transactions
 */

@Repository
public class TransactionDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;

	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(TransactionDao.class.getName());

	public List<Transaction> getTransactions(User user) throws SapeStoreException, ParseException {
		String userId = user.getUserId();
		List<Transaction> transactionHistoryList = new ArrayList<>();
		String query = "from OrderInfo o where o.userId ='" + userId + "' order by o.orderId desc";
		LOGGER.debug("TransactionDAO : QUERY FIRING");
		@SuppressWarnings("unchecked")
		List<OrderInfo> orderList = (List<OrderInfo>) hibernateTemplate.find(query);
		LOGGER.debug("TransactionDAO : QUERY FIRED");
		for (OrderInfo orderInfo : orderList) {
			for (OrderItemInfo orderItemInfo : orderInfo.getOrderItemInfoList()) {
				String isbn = orderItemInfo.getIsbn();
				Book book = hibernateTemplate.get(Book.class, isbn);
				Long rentPrice = (long) book.getRentPrice();
				Long lateFee = null;
				String penalty = null;
				Date updatedDate = orderItemInfo.getUpdatedDate();
				Date expectedReturnDate = null;
				Transaction transaction = new Transaction();
				transaction.setBook(book);
				transaction.setOrderId(orderInfo.getOrderId());
				if (orderItemInfo.getPurchaseType().equals("PURCHASED")) {
					transaction.setBookPrice(book.getBookPrice());
					transaction.setExpectedDate("NA");
					transaction.setPenalty("NA");
					transaction.setType("Purchased");
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
					String stringUpdatedDate = sdf.format(updatedDate);
					transaction.setUpdatedDate(stringUpdatedDate);
				} else if (orderItemInfo.getPurchaseType().equals("RENTED")) {
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
					String stringUpdatedDate = sdf.format(updatedDate);
					transaction.setUpdatedDate(stringUpdatedDate);
					expectedReturnDate = orderItemInfo.getRealExpectedReturnDate();
					String stringExpectedReturnDate = sdf.format(expectedReturnDate);
					transaction.setExpectedDate(stringExpectedReturnDate);
					transaction.setBookPrice(book.getRentPrice());
					transaction.setType("Rented");
					if (orderItemInfo.getActualReturnDate() == null) {
						DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
						Date date = new Date();
						System.out.println(book.getBookTitle() + "book title");
						if(book.getLateFee()!=null)lateFee = book.getLateFee().longValue();
						else lateFee=0L;
						long difference = date.getTime() - expectedReturnDate.getTime();
						long days = difference / 86400000;
						Long pen = days * lateFee;
						if (pen <= 0) {
							penalty = "NA";
						} else {
							penalty = "$" + String.valueOf(pen);
						}
						transaction.setPenalty(penalty);
					} else {
						String actualDate = orderItemInfo.getActualReturnDate();
						Date date = new SimpleDateFormat("dd-MMM-yyyy").parse(actualDate);
						long difference = date.getTime() - expectedReturnDate.getTime();
						long days = difference / 86400000;
						if(book.getLateFee()!=null)lateFee = book.getLateFee().longValue();
						else lateFee=0L;
						Long pen =  days * lateFee;
						if (pen <= 0) {
							penalty = "NA";
						} else {
							penalty = "$" + String.valueOf(pen);
						}
						transaction.setPenalty(penalty);

					}

				} else if (orderItemInfo.getPurchaseType().equals("PENDING")) {
					transaction.setBookPrice(book.getRentPrice());
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
					String stringUpdatedDate = sdf.format(updatedDate);
					transaction.setUpdatedDate(stringUpdatedDate);
					transaction.setExpectedDate("NA");
					transaction.setType("Pending");
					transaction.setPenalty("NA");
				} else {
					transaction.setBookPrice(book.getBookPrice());
					transaction.setExpectedDate("NA");
					transaction.setPenalty("NA");
					transaction.setUpdatedDate("NA");
					transaction.setType("Rejected");
					
				}
				
				
				transactionHistoryList.add(transaction);
			}
		}
		LOGGER.debug("TransactionDAO : RETURNING");
		return transactionHistoryList;
	}

}
