package com.sapestore.service;

import java.util.ArrayList;
import java.util.List;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.ShoppingCart;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.ShoppingCartVO;

public interface ProductService {
	  public ShoppingCartVO getShoppingCart(String userId) throws SapeStoreException;
	    public void saveShoppingCart(String userId,ShoppingCartVO shoppingCartVO) throws SapeStoreException;
	    public boolean validateisbn(String isbn);
	    public boolean referBook(String isbn,String emailId,String userId) throws SapeStoreException;
		boolean referBookMobile(String isbn, String emailId, String userId) throws SapeStoreException;
}
