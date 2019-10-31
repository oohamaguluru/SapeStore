package com.sapestore.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Bean class for keeping shopping cart information. 
 *
 * CHANGE LOG
 *      VERSION    DATE          AUTHOR       MESSAGE               
 *        1.0    20-06-2014     SAPIENT      Initial version
 */

public class ShoppingCartVO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private List<BookVO> booksInCart;	
	private double totalPrice=0;	
	private int totalQuantity=0;

	/**
	 * Add book to the list of books in shopping cart	
	 * @param book
	 */
	public void setBooksInCart(BookVO book) {
		if (this.getBooksInCart() == null) {
			this.booksInCart = new ArrayList<BookVO>();
		}
		 this.booksInCart.add(book);
		 if (book.getPurchaseType().equals("p")) {
			 this.totalPrice = (int) (this.totalPrice + (book.getBookPrice()));
			} else {
				 this.totalPrice = (int) (this.totalPrice + (book.getRentPrice()));
			}
		 
		 this.totalQuantity ++;
		 
	}
	
	public void setBooksForUpdate(BookVO book){
		this.booksInCart.add(book);
	}
	
	
	public void setDate(BookVO book){
		String type = book.getPurchaseType();
		if (type.equals("r")) {
			Date dt = new Date();
			Calendar c = Calendar.getInstance(); 
			c.setTime(dt); 
			c.add(Calendar.DATE, 7);
			dt = c.getTime();
			
			book.setReturnDate(dt);
			} else {
				book.setReturnDate(null);
			}
	}
	
	public double changeTotal(List<BookVO> booksInCart) {
		double shoppingtotal = 0;
		for (BookVO book : booksInCart) {
			int quantity = book.getCartQuantity();
			double price = 0;

			if (book.getPurchaseType().equals("p")) {
				if (quantity < 5) {
					price = book.getBookPrice();
				}
				if (quantity>= 5) {
					price = (book.getBookPrice() - (book.getBookPrice() * 0.1));
				}

			} else {
				price = book.getRentPrice();
			}
			shoppingtotal = shoppingtotal + (quantity * price);
		}
		this.totalPrice = (int) shoppingtotal;
		return totalPrice;
	}

	public void makeCartNull(){
		booksInCart.clear();
		totalPrice=0;
		totalQuantity=0;
	}
	
	public void setBooksInCart(List<BookVO> booksInCart) {
		this.booksInCart = booksInCart;
	}



	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}



	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}



	/**
	 * 
	 * @return the list of books in shopping cart.
	 */
	public List<BookVO> getBooksInCart() {
        return booksInCart;
    }

	/**
	 * 
	 * @return totalPrice.
	 */
	public double getTotalPrice() {
		return totalPrice;
	}

	/**
	 * 
	 * @return totalQuantity.
	 */
	public int getTotalQuantity() {
		return totalQuantity;
	}

	@Override
	public String toString() {
		return "ShoppingCartVO [booksInCart=" + booksInCart + ", totalPrice=" + totalPrice + ", totalQuantity="
				+ totalQuantity + "]";
	}

	
}
