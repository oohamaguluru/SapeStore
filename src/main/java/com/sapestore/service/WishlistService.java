package com.sapestore.service;

import java.util.List;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.User;
import com.sapestore.hibernate.entity.WishList;
import com.sapestore.vo.BookVO;

public interface WishlistService {
	
	public void addToWishlist(Book book2, String userId) throws SapeStoreException;
	public List<Book> getWishlist(String userId) throws SapeStoreException;
	public void deleteFromWishlist(String isbn, String userId);
	

}
