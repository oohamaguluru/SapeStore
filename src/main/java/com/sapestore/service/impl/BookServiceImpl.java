package com.sapestore.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.ProductDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.BookRatingComments;
import com.sapestore.partner.services.SSPartnerBooksListBean;
import com.sapestore.partner.services.SSPartnerWebService;
import com.sapestore.partner.services.SSPartnerWebServicePortType;
import com.sapestore.service.BookService;
import com.sapestore.vo.BookRatingCommentsVO;
import com.sapestore.vo.BookVO;

/**
 * Service class for fetching books information.
 * 
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Service("bookService")
public class BookServiceImpl implements BookService {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(BookServiceImpl.class.getName());

	@Autowired
	private ProductDao bookDao;

	/**
	 * Returns list of books belonging to the specified category
	 */
	@Override
	public List<Book> getBookList(int catId, Object checkMeFromSession) throws SapeStoreException {
		LOGGER.debug("getBookList method: START");
		List<Book> bookBeanList = null;
		bookBeanList = bookDao.getBookList(catId, checkMeFromSession);

		if (bookBeanList != null && bookBeanList.size() > 0) {
			Collections.sort(bookBeanList, new Comparator<Book>() {
				@Override
				public int compare(final Book arg0, final Book arg1) {
					return arg0.getBookTitle().compareTo(arg1.getBookTitle());
				}
			});
		}
		LOGGER.debug("getBookList method: END");
		return bookBeanList;
	}

	@Override
	public List<Book> getBookRatingCommentsList() throws SapeStoreException {
		// TODO Auto-generated method stub

		return bookDao.getBookRatingCommentsList();
	}

	/**
	 * Returns list of book categories
	 */
	@Override
	public List<BookCategory> getCategoryList() throws SapeStoreException {
		LOGGER.debug("getCategoryList method: START");
		List<BookCategory> bookCategoryBeanList = null;
		bookCategoryBeanList = bookDao.getBookCategoryList();
		if (bookCategoryBeanList.size() > 0) {
			Collections.sort(bookCategoryBeanList, new Comparator<BookCategory>() {

				@Override
				public int compare(final BookCategory arg0, final BookCategory arg1) {
					return arg0.getCategoryName().compareTo(arg1.getCategoryName());
				}
			});
		}
		LOGGER.debug("getCategoryList method: END");
		return bookCategoryBeanList;
	}

	@Override
	public List<Book> getBookFromWebService(int catId) {
		LOGGER.debug("getBookFromWebService method: START");
		SSPartnerWebService service = new SSPartnerWebService();
		SSPartnerWebServicePortType client = service.getSSPartnerWebServiceHttpSoap11Endpoint();
		List<SSPartnerBooksListBean> partnerBookList = client.getBookList(String.valueOf(catId));
		LOGGER.debug("getBookFromWebService method: END");
		return mapToBookListBean(partnerBookList);
	}

	/**
	 * Maps book list collected from partner services to book bean
	 * 
	 * @param partnerList
	 * @return
	 */
	private List<Book> mapToBookListBean(List<SSPartnerBooksListBean> partnerList) {
		List<Book> bookListBeanList = new ArrayList<Book>();
		Book bookBean = null;

		for (SSPartnerBooksListBean partnerBook : partnerList) {
			bookBean = new Book();
			bookBean.setIsActive(partnerBook.getActive());
			bookBean.setBookAuthor(partnerBook.getBookAuthor());
			bookBean.setBookDetailDescription(partnerBook.getBookDetailDesc());
			bookBean.setBookPrice(partnerBook.getBookPrice());
			bookBean.setBookShortDescription(partnerBook.getBookShortDesc());
			bookBean.setBookTitle(partnerBook.getBookTitle());
			bookBean.setCategoryId(partnerBook.getCategoryIdpr());
			bookBean.setBookFullImage(partnerBook.getFullImageUrl());
			bookBean.setIsbn(partnerBook.getIsbn());
			bookBean.setPublisherName(partnerBook.getPublisherName());
			bookBean.setQuantity(partnerBook.getQuantity());
			bookBean.setBookThumbImage(partnerBook.getThumbImageUrl());
			bookListBeanList.add(bookBean);
		}
		return bookListBeanList;
	}

	/**
	 * Add new books to the store
	 * 
	 * @param addBooks
	 * @throws SapeStoreSystemException
	 */
	@Override
	public void addBooks(BookVO addBooks) throws SapeStoreException {
		LOGGER.debug("addBooks method: START");
		if (null != addBooks) {
			bookDao.addNewBooks(addBooks);
		}
		LOGGER.debug("addBooks method: END");
	}

	@Override
	public int deleteBook(String isbn) throws SapeStoreException {
		LOGGER.debug("deleteBook method: START");
		if (null != isbn) {
		//	System.out.println(bookDao.deleteBook(isbn));
			int x = bookDao.deleteBook(isbn);
			System.out.println(x);
			return x;
			
		}
		LOGGER.debug("deleteBook method: END");
		return 0;
	}

	@Override
	public Book getBookByIsbn(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getBookByISbn(isbn);
	}

	@Override
	public Integer addReview(String comment, Integer review, String isbn, String userId) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.addReview(comment, review, isbn, userId);
	}

	@Override
	public BookVO getBookDetails(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getBookDetails(isbn);
	}

	@Override
	public List<BookRatingCommentsVO> getReviews(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getReviews(isbn);
	}

	@Override
	public List<Long> getNumberCommentsByDate(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getNumberCommentsByDate(isbn);
	}

	@Override
	public List<Book> getBookByAll(String bookAuthor, String bookTitle, String publisherName, String isbn,
			String categoryId, Object checkMeFromSession) throws SapeStoreException {
		LOGGER.debug("getBooksListByAll method: START");
		List<Book> bookAllBeanList = null;
		bookAllBeanList = bookDao.getBookByAll(bookAuthor, bookTitle, publisherName, isbn, categoryId,
				checkMeFromSession);
		System.out.println(bookAllBeanList);
		if (bookAllBeanList.size() > 0) {
			LOGGER.debug("getBooksListByAll method: END");
			System.out.println("INSIDE BOOKALLBEANLIST");
			return bookAllBeanList;
		} else {
			LOGGER.debug("getBooksListByAll method: END");
			return null;
		}
	}

	public List<Book> getTopRatedBooks() throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getTopRatedBooks();

	}

	@Override
	public List<Long> getTotalRating(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		return bookDao.getTotalRating(isbn);
	}

	@Override
	public void updateAverageRating(Book book) throws SapeStoreException {
		// TODO Auto-generated method stub
		bookDao.updateAverageRating(book);
	}

	@Override
	public String checkForAbuse(List<String> words) throws IOException {
		// TODO Auto-generated method stub
		return bookDao.checkForAbuse(words);
	}
}
