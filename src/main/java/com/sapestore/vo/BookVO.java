package com.sapestore.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

/**
 * Bean class for adding a book.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */
public class BookVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3972545417811168092L;

	@NotEmpty
	private String isbn;

	@NotEmpty
	private String publisherName;

	@NotEmpty
	private String categoryId;

	private String categoryName;

	@NotEmpty
	private String bookTitle;

	@NotNull
	private int quantity;

	private int cartQuantity=1;
	
	private String purchaseType;
	

	public String getPurchaseType() {
		return purchaseType;
	}

	public void setPurchaseType(String purchaseType) {
		this.purchaseType = purchaseType;
	}

	@NotEmpty
	private String bookAuthor;

	@NotNull
	private double bookPrice;

	@NotEmpty
	private String bookShortDesc;
	
	@NotEmpty
	private String bookDetailDesc;

	private String active;

	private MultipartFile thumbImage;

	private MultipartFile fullImage;

	private String thumbPath;

	private String fullPath;

	private Date returnDate;
	
	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	@NotEmpty
	private String rentAvailable;
	

	private double rentPrice;

	private String oldIsbn;

	private Long averageRating;

	
	
	public Long getAverageRating() {
		return averageRating;
	}

	public void setAverageRating(Long averageRating) {
		this.averageRating = averageRating;
	}

	/**
	 * @return the cart quantity
	 */
	public int getCartQuantity() {
		return cartQuantity;
	}

	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}

	/**
	 * @return the isbn
	 */
	public String getIsbn() {
		return isbn;
	}

	/**
	 * @param isbn
	 *            the isbn to set
	 */
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	/**
	 * @return the publisherName
	 */
	public String getPublisherName() {
		return publisherName;
	}

	/**
	 * @param publisherName
	 *            the publisherName to set
	 */
	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}

	/**
	 * @return the categoryId
	 */
	public String getCategoryId() {
		return categoryId;
	}

	/**
	 * @param categoryId
	 *            the categoryId to set
	 */
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	/**
	 * @return the categoryName
	 */
	public String getCategoryName() {
		return categoryName;
	}

	/**
	 * @param categoryName
	 *            the categoryName to set
	 */
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	/**
	 * @return the bookTitle
	 */
	public String getBookTitle() {
		return bookTitle;
	}

	/**
	 * @param bookTitle
	 *            the bookTitle to set
	 */
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	/**
	 * @return the quantity
	 */
	public int getQuantity() {
		return quantity;
	}

	/**
	 * @param quantity
	 *            the quantity to set
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	/**
	 * @return the bookAuthor
	 */
	public String getBookAuthor() {
		return bookAuthor;
	}

	/**
	 * @param bookAuthor
	 *            the bookAuthor to set
	 */
	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}

	/**
	 * @return the bookPrice
	 */
	public double getBookPrice() {
		return bookPrice;
	}

	/**
	 * @param bookPrice
	 *            the bookPrice to set
	 */
	public void setBookPrice(double bookPrice) {
		this.bookPrice = bookPrice;
	}

	/**
	 * @return the bookShortDesc
	 */
	public String getBookShortDesc() {
		return bookShortDesc;
	}

	/**
	 * @param bookShortDesc
	 *            the bookShortDesc to set
	 */
	public void setBookShortDesc(String bookShortDesc) {
		this.bookShortDesc = bookShortDesc;
	}

	/**
	 * @return the bookDetailDesc
	 */
	public String getBookDetailDesc() {
		return bookDetailDesc;
	}

	/**
	 * @param bookDetailDesc
	 *            the bookDetailDesc to set
	 */
	public void setBookDetailDesc(String bookDetailDesc) {
		this.bookDetailDesc = bookDetailDesc;
	}

	/**
	 * @return the active
	 */
	public String getActive() {
		return active;
	}

	/**
	 * @param active
	 *            the active to set
	 */
	public void setActive(String active) {
		this.active = active;
	}

	public MultipartFile getThumbImage() {
		return thumbImage;
	}

	public void setThumbImage(MultipartFile thumbImage) {
		this.thumbImage = thumbImage;
	}

	public MultipartFile getFullImage() {
		return fullImage;
	}

	public void setFullImage(MultipartFile fullImage) {
		this.fullImage = fullImage;
	}

	/**
	 * @return the thumbPath
	 */
	public String getThumbPath() {
		return thumbPath;
	}

	/**
	 * @param thumbPath
	 *            the thumbPath to set
	 */
	public void setThumbPath(String thumbPath) {
		this.thumbPath = thumbPath;
	}

	/**
	 * @return the fullPath
	 */
	public String getFullPath() {
		return fullPath;
	}

	/**
	 * @param fullPath
	 *            the fullPath to set
	 */
	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	/**
	 * @return the rentAvailable
	 */
	public String getRentAvailable() {
		return rentAvailable;
	}

	/**
	 * @param rentAvailable
	 *            the rentAvailable to set
	 */
	public void setRentAvailable(String rentAvailable) {
		this.rentAvailable = rentAvailable;
	}

	/**
	 * @return the rentPrice
	 */
	public double getRentPrice() {
		return rentPrice;
	}

	/**
	 * @param rentPrice
	 *            the rentPrice to set
	 */
	public void setRentPrice(double rentPrice) {
		this.rentPrice = rentPrice;
	}

	/**
	 * @return the oldIsbn
	 */
	public String getOldIsbn() {
		return oldIsbn;
	}

	/**
	 * @param oldIsbn
	 *            the oldIsbn to set
	 */
	public void setOldIsbn(String oldIsbn) {
		this.oldIsbn = oldIsbn;
	}

	@Override
	public String toString() {
		return "BookVO [isbn=" + isbn + ", publisherName=" + publisherName + ", categoryId=" + categoryId
				+ ", categoryName=" + categoryName + ", bookTitle=" + bookTitle + ", quantity=" + quantity
				+ ", cartQuantity=" + cartQuantity + ", purchaseType=" + purchaseType + ", bookAuthor=" + bookAuthor
				+ ", bookPrice=" + bookPrice + ", bookShortDesc=" + bookShortDesc + ", bookDetailDesc=" + bookDetailDesc
				+ ", active=" + active + ", thumbImage=" + thumbImage + ", fullImage=" + fullImage + ", thumbPath="
				+ thumbPath + ", fullPath=" + fullPath + ", returnDate=" + returnDate + ", rentAvailable="
				+ rentAvailable + ", rentPrice=" + rentPrice + ", oldIsbn=" + oldIsbn + ", averageRating="
				+ averageRating + "]";
	}

	

}