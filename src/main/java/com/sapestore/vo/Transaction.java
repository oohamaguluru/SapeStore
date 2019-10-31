package com.sapestore.vo;


import com.sapestore.hibernate.entity.Book;

/**
 * Bean class for keeping shopping transaction information.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 dashok Initial version
 */

public class Transaction {
	private Book book;
	private String updatedDate;
	private String expectedDate;
	private double bookPrice;
	private String type;
	private String penalty;
	private Integer orderId;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getExpectedDate() {
		return expectedDate;
	}

	public void setExpectedDate(String expectedDate) {
		this.expectedDate = expectedDate;
	}

	public double getBookPrice() {
		return bookPrice;
	}

	public void setBookPrice(double bookPrice) {
		this.bookPrice = bookPrice;
	}

	public void setPenalty(String penalty) {
		this.penalty = penalty;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public String getPenalty() {
		return penalty;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	@Override
	public String toString() {
		return "TransactionHistory [book=" + book + ", updatedDate=" + updatedDate + ", expectedDate=" + expectedDate
				+ ", bookPrice=" + bookPrice + ", type=" + type + ", penalty=" + penalty + "]";
	}

}
