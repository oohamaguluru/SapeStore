package com.sapestore.vo;


import java.io.Serializable;

public class LowInventoryBooksVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	String isbn;
	String bookTitle;
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	@Override
	public String toString() {
		return "LowInventoryBooks [isbn=" + isbn + ", bookTitle=" + bookTitle + "]";
	}
	

}
