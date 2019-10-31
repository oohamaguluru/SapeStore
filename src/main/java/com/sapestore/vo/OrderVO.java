package com.sapestore.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Bean class for Rented orders. 
 *
 * CHANGE LOG
 *      VERSION    DATE          AUTHOR       MESSAGE               
 *        1.0    20-06-2014     SAPIENT      Initial version
 */
public class OrderVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int orderNumber; 			// ORDER_ITEM_ID from ORDER_ITEM_INFO
	private boolean returnReceived;		//RETURN_STATUS from ORDER_ITEM_INFO
	private String itemName;			//BOOK_TITLE from SAPESTORE_BOOKS
	private Double rentAmount;				//RENT_PRICE from SAPESTORE_BOOKS
	private boolean orderStatus;			//ORDER_STATUS from ORDER_INFO
	private String expectedReturnDate;	//EXPECTED_RETURN_DATE from ORDER_ITEM_INFO
	private String actualReturnDate;		//ACTUAL_RETURN_DATE from ORDER_ITEM_INFO
	private BigDecimal lateFee;				//LATE_FEE from SAPESTORE_BOOKS 
	private Double bookPrice;
	private boolean paymentRecieved;
	
	public boolean isPaymentRecieved() {
		return paymentRecieved;
	}
	public void setPaymentRecieved(boolean paymentRecieved) {
		this.paymentRecieved = paymentRecieved;
	}
	/**
	 * @return orderId
	 */
	public int getOrderNumber() {
		return orderNumber;
	}
	/**
	 * @param orderNumber sets orderId
	 */
	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}
	
	/**
	 * @return book title/name
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName sets book title/name
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	/**
	 * @return the rentAmount
	 */
	public Double getRentAmount() {
		return rentAmount;
	}
	/**
	 * @param d the rentAmount to set
	 */
	public void setRentAmount(Double d) {
		this.rentAmount = d;
	}
	/**
	 * @return book return status(returned/pending)
	 */
	public boolean isReturnReceived() {
		return returnReceived;
	}
	/**
	 * @param returnReceived sets book return status(returned/pending) 
	 */
	public void setReturnReceived(boolean returnReceived) {
		this.returnReceived = returnReceived;
	}
	/**
	 * @return order status(dispatched/pending)
	 */
	public boolean isOrderStatus() {
		return orderStatus;
	}
	/**
	 * @param orderStatus sets order status(dispatched/pending)
	 */
	public void setOrderStatus(boolean orderStatus) {
		this.orderStatus = orderStatus;
	}
	/**
	 * @return rented book expected return date
	 */
	public String getExpectedReturnDate() {
		return expectedReturnDate;
	}
	/**
	 * @param expectedReturnDate rented book expected return date
	 */
	public void setExpectedReturnDate(String expectedReturnDate) {
		this.expectedReturnDate = expectedReturnDate;
	}
	/**
	 * @return rented book actual return date
	 */
	public String getActualReturnDate() {
		return actualReturnDate;
	}
	/**
	 * @param actualReturnDate sets rented book actual return date
	 */
	public void setActualReturnDate(String actualReturnDate) {
		this.actualReturnDate = actualReturnDate;
	}
	/**
	 * @return the lateFee
	 */
	public BigDecimal getLateFee() {
		return lateFee;
	}
	/**
	 * @param lateFee the lateFee to set
	 */
	public void setLateFee(BigDecimal lateFee) {
		this.lateFee = lateFee;
	}
	public Double getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(Double bookPrice) {
		this.bookPrice = bookPrice;
	}
	@Override
	public String toString() {
		return "OrderVO [orderNumber=" + orderNumber + ", returnReceived=" + returnReceived + ", itemName=" + itemName
				+ ", rentAmount=" + rentAmount + ", orderStatus=" + orderStatus + ", expectedReturnDate="
				+ expectedReturnDate + ", actualReturnDate=" + actualReturnDate + ", lateFee=" + lateFee
				+ ", bookPrice=" + bookPrice + ", paymentRecieved=" + paymentRecieved + "]";
	}	
	
}