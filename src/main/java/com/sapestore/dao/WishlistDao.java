package com.sapestore.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.User;
import com.sapestore.hibernate.entity.WishList;
import com.sapestore.service.WishlistService;
import com.sapestore.vo.BookVO;

@Repository
public class WishlistDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(WishlistDao.class.getName());
    

	
	public void addToWishlist(Book book, String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		WishList wishlist = new WishList();
		DateFormat df = new SimpleDateFormat("dd-MMM-yy");
		Date createdDate = new Date();
		if(book==null){
			throw new SapeStoreException("No book selected");
		}
		if(userId==null){
			throw new SapeStoreException("user exception");
		}
		
		List<WishList> wishlistdb=new ArrayList<WishList>();
		try{
		
			String query1="from WishList a where a.userId='"+userId+"'";
			wishlistdb = (List<WishList>) hibernateTemplate.find(query1);
			
		}
		catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
	    }
		int flag=-1;
		String tempisbn= book.getIsbn();
		for(WishList wish : wishlistdb){
			if(wish.getIsbn().equals(tempisbn)){
				flag++;
			}
			
		}
		
		if(flag==-1){
			Random random=new Random();
			Integer wishId=random.nextInt(50000)+1;
			wishlist.setWishId(wishId);
			wishlist.setUserId(userId);
			wishlist.setCreatedDate(createdDate);
			wishlist.setUpdatedDate(createdDate);
			wishlist.setIsbn(book.getIsbn());
			wishlist.setIsActive("y");
			hibernateTemplate.save(wishlist);
		}
		
		
		
		

	}

	
	public List<Book> getWishlist(String userId) throws SapeStoreException {
		//String userId1 = userId;
		List<WishList> wishlist=null;
		try{
		
			String query1="from WishList a where a.userId='"+userId+"'";
			wishlist = (List<WishList>) hibernateTemplate.find(query1);
					}
		catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
	    }
		Book book = null;
		List<Book> booklist= new ArrayList<Book>();
		for(WishList w : wishlist){
			book=null;
			try{
				
				
				book=hibernateTemplate.get(Book.class,w.getIsbn());
				
				
				booklist.add(book);
				
			}
			catch (SapeStoreSystemException se) {
				LOGGER.fatal("A DB exception occured while inserting the book's information", se);
		    }
			
		}
		
		
		
		return booklist;
		// TODO Auto-generated method stub
		
	}
	
	public void deleteFromWishlist(String isbn, String userId) {
		//hibernateTemplate.bulkUpdate("DELETE WishList where userId=? and isbn=?",userId,isbn);
		/*Book book = new Book();*/
		String query1="from WishList a where a.userId='"+userId+"'";
		List<WishList> wishlist1 = (List<WishList>) hibernateTemplate.find(query1);
		
		String query2="from WishList a where a.isbn='"+isbn+"'";
		List<WishList> wishlist2 =  (List<WishList>) hibernateTemplate.find(query2);
		
		System.out.println(wishlist1);
		System.out.println(wishlist2);
		/*for(WishList wish : wishlist){
			if(wish.getIsbn().equals(isbn)){
				book= hibernateTemplate.get(Book.class, wish.getIsbn().trim());
				System.out.println(book);
			}
		}
		hibernateTemplate.delete(book);*/
		WishList wish = wishlist2.get(0);
		hibernateTemplate.delete(wish);
		hibernateTemplate.flush();
	}

}
