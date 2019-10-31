package com.sapestore.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.AccountDao;
import com.sapestore.dao.ProductDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;
import com.sapestore.service.OrderService;
import com.sapestore.service.ProductService;
import com.sapestore.vo.ShoppingCartVO;

@Service("productService")
public class ProductServiceImpl implements ProductService {

private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AccountServiceImpl.class.getName());
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private AccountService accountService;
	
	@Override
	public ShoppingCartVO getShoppingCart(String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("populateForm method in Order Controller: START");
		LOGGER.debug("populateForm method in Order Controller: END");
		return productDao.getShoppingCart(userId);		
	}

	@Override
	public void saveShoppingCart(String userId, ShoppingCartVO shoppingCartVO) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("saveShoppingCart method in PrdouctServiceImpl: START");
		productDao.saveShoppingCart(userId, shoppingCartVO);
		LOGGER.debug("saveShoppingCart method in PrdouctServiceImpl: END");
	}
	public boolean validateisbn(String isbn)
	{
	return productDao.validate(isbn);	
	}
	
	@Override
	public boolean referBook(String isbn, String emailId,String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("referBook method in PrdouctServiceImpl: START");
		boolean flag= productDao.referBook(isbn, emailId,userId);
		User user=accountService.getUserInfo(userId);
		Book book = productDao.getBookByISbn(isbn);
		String message="Your Friend "+user.getName()+" has referred the following book to you.\n"+"Book Title : "+book.getBookTitle()+"\nBook Author : "+book.getBookAuthor()+"Book Price : $"+book.getBookPrice()+"\nCheck out the following link : "+"http://10.150.16.224:8081/SapeStore/viewBookDetails?isbn="+ isbn;
	    orderService.sendSms(user.getMobileNumber(), message);
	
		LOGGER.debug("referBook method in PrdouctServiceImpl: END");
		return flag;
	}
	@Override
	public boolean referBookMobile(String isbn, String emailId,String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("referBook method in PrdouctServiceImpl: START");
		boolean flag= productDao.referBook(isbn, emailId,userId);
		User user=accountService.getUserInfo(userId);
		Book book = productDao.getBookByISbn(isbn);
		String message="Your Friend "+user.getName()+" has referred the following book to you.\n"+"Book Title : "+book.getBookTitle()+"\nBook Author : "+book.getBookAuthor()+"Book Price : $"+book.getBookPrice()+"\nCheck out the following link : "+"http://10.150.16.224:8081/SapeStore/viewBookDetails?isbn="+ isbn;
	    orderService.sendSms(user.getMobileNumber(), message);
	
		LOGGER.debug("referBook method in PrdouctServiceImpl: END");
		return flag;
	}
}
