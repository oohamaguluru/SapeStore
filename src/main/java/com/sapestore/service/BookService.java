package com.sapestore.service;

import java.io.IOException;
import java.util.List;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.BookRatingComments;
import com.sapestore.vo.BookRatingCommentsVO;
import com.sapestore.vo.BookVO;
import com.sun.mail.iap.ConnectionException;

/**
 * Service interface for fetching books information.
 * 
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

public interface BookService {

	/**
	 * Returns list of book belonging to the specified category.
	 * 
	 * @param catId
	 * @param checkMeFromSession
	 * @return
	 * @throws SapeStoreSystemException
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	public List<Book> getBookList(int catId, Object checkMeFromSession) throws SapeStoreException;

	public List<Book> getBookRatingCommentsList() throws SapeStoreException;

	/**
	 * Returns list of categories
	 * 
	 * @return
	 * @throws SapeStoreSystemException
	 */
	public List<BookCategory> getCategoryList() throws SapeStoreException;

	/**
	 * Returns list of books pulled from the partner services
	 * 
	 * @param catId
	 * @return
	 */
	public List<Book> getBookFromWebService(int catId);

	/**
	 * Add new books to the store
	 * 
	 * @param addBooks
	 * @throws SapeStoreSystemException
	 */
	void addBooks(BookVO addBooks) throws SapeStoreException;

	/**
	 * Deletes the book with the specified ISBN
	 * 
	 * @param isbn
	 * @throws SapeStoreSystemException
	 */
	int deleteBook(String isbn) throws SapeStoreException;

	public Book getBookByIsbn(String isbn) throws SapeStoreException;

	public Integer addReview(String comment, Integer rating, String isbn, String userId) throws SapeStoreException;

	public BookVO getBookDetails(String trim) throws SapeStoreException;

	public List<BookRatingCommentsVO> getReviews(String isbn) throws SapeStoreException;

	public List<Book> getBookByAll(String bookAuthor, String bookTitle, String publisherName, String isbn,
			String categoryId, Object checkMeFromSession) throws SapeStoreException;

	public List<Long> getNumberCommentsByDate(String isbn) throws SapeStoreException;

	public List<Long> getTotalRating(String isbn) throws SapeStoreException;

	public List<Book> getTopRatedBooks() throws SapeStoreException;

	public void updateAverageRating(Book book) throws SapeStoreException;
	
	public String checkForAbuse(List<String>words) throws IOException;

}
