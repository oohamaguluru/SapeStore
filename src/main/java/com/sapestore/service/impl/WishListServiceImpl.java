package com.sapestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.dao.WishlistDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.WishlistService;
import com.sapestore.vo.BookVO;

@Service("wishlistService")
public class WishListServiceImpl implements WishlistService {
	
	@Autowired
	private WishlistDao wishDAO;

	@Override
	public void addToWishlist(Book book, String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		wishDAO.addToWishlist(book, userId);

	}

	@Override
	public List<Book> getWishlist(String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return wishDAO.getWishlist(userId);
	}

	@Override
	public void deleteFromWishlist(String isbn, String userId) {
		wishDAO.deleteFromWishlist(isbn,userId);

		
	}

}
