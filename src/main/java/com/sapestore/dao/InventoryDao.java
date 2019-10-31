package com.sapestore.dao;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.vo.BookVO;
import com.sun.mail.iap.ConnectionException;

/**
 * DAO class for admin report.
 * 
 * CHANGE 	LOG 
 * VERSION 	DATE 			AUTHOR MESSAGE 
 * 1.0 		20-06-2014 		SAPIENT Initial version
 */
@Repository
public class InventoryDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
		
	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(InventoryDao.class.getName());

	/**
	 * Method to fetch admin report from the database.
	 * 
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	
	@SuppressWarnings("unchecked")
	public List<Book> getAdminInventory() throws SapeStoreException {
		LOGGER.debug("InventoryDao.getBookDetails method: START");
		List<Book> listBook = null;
		listBook = (List<Book>) hibernateTemplate.findByNamedQuery("Book.findAllInventory");		
		return listBook;
	}	
	
	public void updateBooks(BookVO updateInventoryBean) throws SapeStoreException {
		LOGGER.debug(" InventoryDao.updateBooks method: START ");
		try {
			Book book = hibernateTemplate.get(Book.class, updateInventoryBean.getOldIsbn());
			if(book != null){	
				book.setIsbn(updateInventoryBean.getIsbn());
				if(updateInventoryBean.getPublisherName().length()>100)
					book.setPublisherName(updateInventoryBean.getPublisherName().substring(0, 100));
				else
					book.setPublisherName(updateInventoryBean.getPublisherName());
				book.setBookTitle(updateInventoryBean.getBookTitle());
				book.setQuantity(updateInventoryBean.getQuantity());
				if(updateInventoryBean.getBookAuthor().length()>200)
					book.setBookAuthor(updateInventoryBean.getBookAuthor().substring(0, 200));
				else
					book.setBookAuthor(updateInventoryBean.getBookAuthor());
				book.setBookPrice(updateInventoryBean.getBookPrice());
				if(updateInventoryBean.getBookShortDesc().length()>500)
					book.setBookShortDescription(updateInventoryBean.getBookShortDesc().substring(0, 500));
				else
					book.setBookShortDescription(updateInventoryBean.getBookShortDesc());
				book.setRentAvailability(updateInventoryBean.getRentAvailable().substring(0, 1));
				book.setRentPrice(updateInventoryBean.getRentPrice());
				if(updateInventoryBean.getBookDetailDesc().length()>1000)
					book.setBookDetailDescription(updateInventoryBean.getBookDetailDesc().substring(0, 1000));
				else
					book.setBookDetailDescription(updateInventoryBean.getBookDetailDesc());
				if(updateInventoryBean.getThumbPath()!=null)
					book.setBookThumbImage(updateInventoryBean.getThumbPath());
				if(updateInventoryBean.getFullPath()!=null)
					book.setBookFullImage(updateInventoryBean.getFullPath());
				book.setUpdatedDate(new java.util.Date());
				if(!updateInventoryBean.getCategoryId().equals(""))
					book.setCategoryId(Integer.parseInt(updateInventoryBean.getCategoryId()));
				hibernateTemplate.saveOrUpdate(book);
				LOGGER.debug(" Book is updated ");
			}
		}catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
		}
		LOGGER.debug(" ProductDao.updateBooks method: END ");
	}
	
}

