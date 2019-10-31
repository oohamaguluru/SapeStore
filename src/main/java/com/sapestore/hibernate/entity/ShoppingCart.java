package com.sapestore.hibernate.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name="SAPESTORE_USER_CART")
@NamedQueries(value = {
		@NamedQuery(name = "ShoppingCart.findByCartId", query = "from ShoppingCart c where c.cartId = :cartId")
 		})
public class ShoppingCart implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1347130875419134578L;

	
	
	
	@Column(name="USER_ID")
	private String userId;
	
	@Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="cart_id_seq")
    @SequenceGenerator(name="cart_id_seq", initialValue=1, allocationSize=1)   
	@Column(name="CART_ID")
	private Integer cartId;
	
	@Column(name="ISBN")
	private String isbn;

	@Column(name="IS_ACTIVE")
	private String isActive;
 
	@Column(name="BOOK_QUANTITY")
	private Integer bookQuantity;
	
	@Column(name="PURCHASE_TYPE")
	private String purchaseType;
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	@Column(name="TOTAL_PRICE")
	private double totalPrice;
	
	
	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * @return the isbn
	 */
	public String getIsbn() {
		return isbn;
	}

	/**
	 * @param isbn the isbn to set
	 */
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	/**
	 * @return the createdDate
	 */
	

	/**
	 * @return the isActive
	 */
	public String getIsActive() {
		return isActive;
	}

	/**
	 * @param isActive the isActive to set
	 */
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	public Integer getCartId() {
		return cartId;
	}

	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}

	public Integer getBookQuantity() {
		return bookQuantity;
	}

	public void setBookQuantity(Integer bookQuantity) {
		this.bookQuantity = bookQuantity;
	}

	public String getPurchaseType() {
		return purchaseType;
	}

	public void setPurchaseType(String purchaseType) {
		this.purchaseType = purchaseType;
	}

	@Override
	public String toString() {
		return "ShoppingCart [userId=" + userId + ", cartId=" + cartId + ", isbn=" + isbn + ", isActive=" + isActive
				+ ", bookQuantity=" + bookQuantity + ", purchaseType=" + purchaseType + "]";
	}



	
	
}
