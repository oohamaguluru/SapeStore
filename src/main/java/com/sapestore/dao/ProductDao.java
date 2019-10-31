package com.sapestore.dao;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.BookRatingComments;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.ShoppingCart;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.BookRatingCommentsVO;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.ShoppingCartVO;
import com.sun.mail.iap.ConnectionException;

/**
 * DAO class for retrieving the book's list from the database.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */
@Repository
public class ProductDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;

	@Autowired
	private VelocityEngine velocityEngine;
	
	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(ProductDao.class.getName());
	 
	public void setVelocityEngine(VelocityEngine velocityEngine) {
		  this.velocityEngine = velocityEngine;
		 }
	/**
	 * Method to fetch the book list from the database.
	 * 
	 * @param categoryId
	 * @param checkMeFromSession
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	private BookVO setBookDetailBean(Book book) {
		BookVO vo = null;
		if (book != null) {
			vo = new BookVO();
			vo.setIsbn(book.getIsbn());
			vo.setBookTitle(book.getBookTitle());
			vo.setBookAuthor(book.getBookAuthor());
			vo.setBookPrice(book.getBookPrice());
			vo.setThumbPath(book.getBookThumbImage());
			vo.setQuantity(book.getQuantity());
			vo.setBookDetailDesc(book.getBookDetailDescription());
			vo.setRentPrice(book.getRentPrice());
			vo.setAverageRating(book.getAverageRating());
			vo.setCategoryId(book.getCategoryId().toString());
			vo.setCategoryName(book.getCategoryName());
			vo.setPublisherName(book.getPublisherName());
		}
		return vo;
	}

	@Transactional
	@SuppressWarnings("unchecked")
	public List<Book> getBookByAll(String bookAuthor, String bookTitle, String publisherName, String isbn,
			String categoryId, Object checkMeFromSession) throws SapeStoreException {
		List<Book> listBook = null;
		Criteria cr = hibernateTemplate.getSessionFactory().getCurrentSession().createCriteria(Book.class);
		int categoryIdInt = Integer.parseInt(categoryId);
		String title1 = '%' + bookTitle + '%';
		String publisher = '%' + publisherName + '%';
		String author1 = '%' + bookAuthor + '%';
		String isbn1 = '%' + isbn + '%';
		if (isbn != null && !"".equalsIgnoreCase(isbn)) {
			cr.add(Restrictions.like("isbn", isbn1));
		}
		if (publisherName != null && !"".equalsIgnoreCase(publisherName)) {
			cr.add(Restrictions.like("publisherName", publisher).ignoreCase());
		}
		if (bookTitle != null && !"".equalsIgnoreCase(bookTitle)) {
			cr.add(Restrictions.like("bookTitle", title1).ignoreCase());
		}
		if (categoryId != null && !"".equalsIgnoreCase(categoryId) && !"-1".equalsIgnoreCase(categoryId)) {
			cr.add(Restrictions.eq("categoryId", categoryIdInt));
		}
		if (bookAuthor != null && !"".equalsIgnoreCase(bookAuthor)) {
			cr.add(Restrictions.like("bookAuthor", author1).ignoreCase());
		}
		// }

		listBook = cr.list();
		return listBook;
	}

	public int getPosition(List<String> booklist, Book book) throws SapeStoreException {
		String isbn = new String();
		isbn = book.getIsbn();

		int m = 0;
		for (int i = 0; i < booklist.size(); i++) {
			if (booklist.get(i).equals(isbn)) {
				m = i;
				break;
			}
		}
		return m;
	}

	@SuppressWarnings("unchecked")
	public List<Book> getBookRatingCommentsList() throws SapeStoreException {
		String query = "from BookRatingComments c";
		List<String> listBookRating = (List<String>) hibernateTemplate.findByNamedQuery("BookRatingComments.findIsbn");

		List<Book> books = new ArrayList<Book>();
		for (String isbn : listBookRating) {
			Book book = getBookByISbn(isbn);
			books.add(book);
		}

		return books;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getBooksofZeroReviews() throws SapeStoreException {
		

          
		List<String> isbnsinBooks= (List<String>) hibernateTemplate.findByNamedQuery("Book.findZeroReviews");
	
         System.out.println(isbnsinBooks);
		return isbnsinBooks;
	}

	public ShoppingCartVO getShoppingCart(String userId) throws SapeStoreException {
		LOGGER.debug("getShoppingCart method: START");
		String query = "FROM ShoppingCart s where s.userId='" + userId + "'";
		List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) hibernateTemplate.find(query);
		ShoppingCartVO shoppingCartVO = new ShoppingCartVO();
		shoppingCartVO.setTotalQuantity(shoppingCarts.size());
		BookVO bookVO = null;
		Double totalPrice = 0d;
		Integer totalQuantity = 0;
		List<BookVO> bookList = new ArrayList<>();
		for (ShoppingCart s : shoppingCarts) {
			bookVO = getBookInfo(s.getIsbn());
			bookVO.setCartQuantity(s.getBookQuantity());
			bookVO.setPurchaseType(s.getPurchaseType());
			bookList.add(bookVO);
			totalQuantity = totalQuantity + bookVO.getCartQuantity();
		//	totalPrice=(Double)shoppingCartVO.changeTotal(shoppingCartVO.getBooksInCart());
			totalPrice=s.getTotalPrice();
			//totalPrice = totalPrice + (s.getBookQuantity() * bookVO.getBookPrice());
		}
		System.out.println("Book vo in cotrnloer while getting"+bookList);
		shoppingCartVO.setBooksInCart(bookList);
		shoppingCartVO.setTotalPrice(totalPrice);
		shoppingCartVO.setTotalQuantity(totalQuantity);
		LOGGER.debug("getShoppingCart method: END");
		return shoppingCartVO;
	}

	public void saveShoppingCart(String userId, ShoppingCartVO shoppingCartVO) throws SapeStoreException {
		LOGGER.debug("saveShoppingCart method: START");
		ShoppingCart shoppingCart = null;
		String query = "FROM ShoppingCart s where s.userId='" + userId + "'";
		List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) hibernateTemplate.find(query);
		for (ShoppingCart s : shoppingCarts) {
			hibernateTemplate.delete(s);
		}
	//	double totalprice=shoppingCartVO.changeTotal(shoppingCartVO.getBooksInCart());
		for (BookVO book : shoppingCartVO.getBooksInCart()) {
			System.out.println("in saveshopping cart book->"+book);
			shoppingCart = new ShoppingCart();
			Double total=(Double)shoppingCartVO.changeTotal(shoppingCartVO.getBooksInCart());
			shoppingCart.setUserId(userId);
			shoppingCart.setIsbn(book.getIsbn());
			shoppingCart.setBookQuantity(book.getCartQuantity());
			shoppingCart.setTotalPrice(total);
			shoppingCart.setIsActive("Y");
			shoppingCart.setPurchaseType(book.getPurchaseType());
			System.out.println("Shopping cart in cotrnloer while saving"+shoppingCart);
			
			hibernateTemplate.save(shoppingCart);
		}
		LOGGER.debug("saveShoppingCart method: END");
	}

	private BookVO getBookInfo(String isbn) throws SapeStoreException {
		LOGGER.debug("getBookInfo method: START");
		BookVO addToCartbean = null;
		addToCartbean = getBookDetails(isbn);
		LOGGER.debug("getBookInfo method: END");
		return addToCartbean;
	}

	@SuppressWarnings("unchecked")
	public List<Book> getBookList(int categoryId, Object checkMeFromSession) throws SapeStoreException {
		List<Book> listBook = null;
		if (categoryId == 0) {
			listBook = (List<Book>) hibernateTemplate.findByNamedQuery("Book.findAll");
		} else
			listBook = (List<Book>) hibernateTemplate.findByNamedQueryAndNamedParam("Book.findByCategoryId",
					"categoryId", categoryId);

		return listBook;
	}

	/**
	 * Method to fetch the book's category list.
	 * 
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	@SuppressWarnings("unchecked")
	public List<BookCategory> getBookCategoryList() throws SapeStoreException {
		List<BookCategory> listBookCategories = (List<BookCategory>) hibernateTemplate
				.findByNamedQuery("BookCategory.findAll");
		return listBookCategories;
	}

	/**
	 * deleteBook method updates the quantity of the selected book to zero in
	 * the database
	 * 
	 * @param isbn
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	
	public int deleteBook(String isbn) throws SapeStoreException {
		LOGGER.debug(" BookDao.deleteBook method: START");
		System.out.println(isbn);
		Book book = hibernateTemplate.get(Book.class, isbn.trim());
		//String isbn1=isbn.trim();
		//int isbn2 =Integer.parseInt(isbn1);
	//	OrderItemInfo i =  hibernateTemplate.find(OrderItemInfo.class, isbn2)
		System.out.println(book.getIsbn());
	
		List<OrderItemInfo> orderItemInfoList = (List<OrderItemInfo>) hibernateTemplate.find("from OrderItemInfo where isbn = "+isbn+"");
		System.out.println("inside the list");
		if(orderItemInfoList.isEmpty()){
			book.setIsActive("N");
			System.out.println(isbn);
			System.out.println("empty list");
			System.out.println(book.getIsActive());
			hibernateTemplate.saveOrUpdate(book);
			return 0;
		}
		else{
		OrderItemInfo orderItemInfo = orderItemInfoList.get(0);
		orderItemInfo.getIsbn();
		System.out.println(orderItemInfo.getPurchaseType());
	//	System.out.println(book);
		System.out.println((book.getIsbn()));
		System.out.println(orderItemInfo.getPurchaseType());
	 if(orderItemInfo.getPurchaseType().equals("PURCHASED") || orderItemInfo.getPurchaseType().equals("PENDING") || orderItemInfo.getPurchaseType().equals("REJECTED")  ){
		book.setIsActive("N");
		System.out.println(isbn);
		System.out.println("skag");
		System.out.println(book.getIsActive());
		hibernateTemplate.saveOrUpdate(book);
		return 0;
		
	}
	 else {
		 System.out.println("rented type book");
		 return 1;
	 }
		}
	
		
	}
	/**
	 * Method to add a new book to the database.
	 * 
	 * @param vo
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	public void addNewBooks(BookVO vo) throws SapeStoreException {
		LOGGER.debug(" ProductDao.addNewBooks method: START");
		try {
			Book book = new Book();
			book.setIsbn(vo.getIsbn());
			book.setPublisherName(vo.getPublisherName());
			book.setCategoryId(Integer.parseInt(vo.getCategoryId()));
			book.setBookTitle(vo.getBookTitle());
			book.setQuantity(vo.getQuantity());
			book.setBookAuthor(vo.getBookAuthor());
			book.setBookThumbImage(vo.getThumbPath());
			book.setBookFullImage(vo.getFullPath());
			book.setBookPrice(vo.getBookPrice());
			double cd=book.getBookPrice();
			BigDecimal b=new BigDecimal(cd);
			BigDecimal b3=new BigDecimal(15);
			BigDecimal b2= b.divide(b3, 2);
			book.setLateFee(b2);
			book.setBookShortDescription(vo.getBookShortDesc());
			book.setBookDetailDescription(vo.getBookDetailDesc());
			book.setRentAvailability(vo.getRentAvailable());
			book.setRentPrice(vo.getRentPrice());
			book.setCreatedDate(new java.util.Date());
			book.setUpdatedDate(new java.util.Date());
			book.setIsActive("Y");
			hibernateTemplate.save(book);
		} catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
		}
		LOGGER.debug(" ProductDao.addNewBooks method: END ");
	}

	/**
	 * Update Book method updates the detail of the corresponding book.
	 * 
	 * @param updateInventoryBean
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	public void updateBooks(BookVO updateInventoryBean) throws SapeStoreException {
		LOGGER.debug(" InventoryDao.updateBooks method: START ");
		try {
			Book book = hibernateTemplate.get(Book.class, updateInventoryBean.getOldIsbn());
			if (book != null) {
				book.setIsbn(updateInventoryBean.getIsbn());
				if (updateInventoryBean.getPublisherName().length() > 100)
					book.setPublisherName(updateInventoryBean.getPublisherName().substring(0, 100));
				else
					book.setPublisherName(updateInventoryBean.getPublisherName());
				book.setBookTitle(updateInventoryBean.getBookTitle());
				book.setQuantity(updateInventoryBean.getQuantity());
				if (updateInventoryBean.getBookAuthor().length() > 200)
					book.setBookAuthor(updateInventoryBean.getBookAuthor().substring(0, 200));
				else
					book.setBookAuthor(updateInventoryBean.getBookAuthor());
				book.setBookPrice(updateInventoryBean.getBookPrice());
				if (updateInventoryBean.getBookShortDesc().length() > 500)
					book.setBookShortDescription(updateInventoryBean.getBookShortDesc().substring(0, 500));
				else
					book.setBookShortDescription(updateInventoryBean.getBookShortDesc());
				book.setRentAvailability(updateInventoryBean.getRentAvailable().substring(0, 1));
				book.setRentPrice(updateInventoryBean.getRentPrice());
				if (updateInventoryBean.getBookDetailDesc().length() > 1000)
					book.setBookDetailDescription(updateInventoryBean.getBookDetailDesc().substring(0, 1000));
				else
					book.setBookDetailDescription(updateInventoryBean.getBookDetailDesc());
				if (updateInventoryBean.getThumbPath() != null)
					book.setBookThumbImage(updateInventoryBean.getThumbPath());
				if (updateInventoryBean.getFullPath() != null)
					book.setBookFullImage(updateInventoryBean.getFullPath());
				book.setUpdatedDate(new java.util.Date());
				book.setCategoryId(Integer.parseInt(updateInventoryBean.getCategoryId()));
				hibernateTemplate.saveOrUpdate(book);
				LOGGER.debug(" Book is updated ");
			}
		} catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
		}
		LOGGER.debug(" ProductDao.updateBooks method: END ");
	}

	/**
	 * Method to get book details from the database.
	 *
	 * @param isbn
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	public BookVO getBookDetails(String isbn) throws SapeStoreException {
		LOGGER.debug(" ProductDao.getBookDetails method: START");
		Book book = null;
		try {
			book = hibernateTemplate.get(Book.class, isbn);

		} catch (SapeStoreSystemException se) {
			LOGGER.fatal("A DB exception occured while inserting the book's information", se);
		}
		LOGGER.debug(" ProductDao.getBookDetails method: END");
		return setBookDetailBean(book);
	}

	/**
	 * Converts the Map representation of book details HashMap to its DO
	 * representation
	 * 
	 * @param hash
	 * @return
	 */

	public Book getBookByISbn(String isbn) throws SapeStoreException {
		LOGGER.debug(" ProductDao.getBookByIsbn method: START");
		Book book = hibernateTemplate.get(Book.class, isbn);
		if (book == null)
			throw new SapeStoreException("Book not found");

		return book;
	}

	public Integer addReview(String comment, Integer review, String isbn, String userId) {
		LOGGER.debug(" ProductDao.addReview method: START");
		// TODO Auto-generated method stub
		Date today = new Date();
		BookRatingComments bookRatingComments = new BookRatingComments();
		bookRatingComments.setBookCommentDate(today);
		bookRatingComments.setBookComments(comment);
		bookRatingComments.setBookRating(review);
		Random random = new Random();
		Integer commentId = random.nextInt(50000) + 1;
		bookRatingComments.setCommentId(commentId);
		bookRatingComments.setIsbn(isbn);
		bookRatingComments.setUserId(userId);
		hibernateTemplate.saveOrUpdate(bookRatingComments);
		LOGGER.debug(" Review is added ");
		return commentId;
	}

	@SuppressWarnings("unchecked")
	public List<BookRatingCommentsVO> getReviews(String isbn) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug(" ProductDao.getReviews method: START");
		String query = "from BookRatingComments c where c.isbn='" + isbn + "' order by c.bookCommentDate desc";
		List<BookRatingCommentsVO> reviewsList = (List<BookRatingCommentsVO>) hibernateTemplate.find(query);
		if (isbn == null)
			throw new SapeStoreException("Isbn cannot be null");
		return reviewsList;
	}

	@SuppressWarnings("unchecked")
	public List<Long> getNumberCommentsByDate(String isbn) throws SapeStoreException {
		LOGGER.debug(" ProductDao.getNumberCommentsByDate method: START");
		String query = "select count(c.bookComments) from BookRatingComments c where c.isbn='" + isbn + "'";
		if (isbn == null)
			throw new SapeStoreException("Isbn cannot be null");
		List<Long> reviews = (List<Long>) hibernateTemplate.find(query);
		return reviews;
	}

	@SuppressWarnings("unchecked")
	public List<Long> getTotalRating(String isbn) throws SapeStoreException {
		LOGGER.debug(" ProductDao.getTotalRating method: START");
		String query = "select sum(c.bookRating) from BookRatingComments c where c.isbn='" + isbn + "' group by c.isbn";
		if (isbn == null)
			throw new SapeStoreException("Isbn cannot be null");
		List<Long> avgList = (List<Long>) hibernateTemplate.find(query);
		return avgList;

	}

	@SuppressWarnings("unchecked")
	public List<Book> getTopRatedBooks() throws SapeStoreException {
		LOGGER.debug(" ProductDao.TopRatedBooks method: START");
		int thrushold=3;
		String query = "from Book c where rownum<16 and averageRating is not null and averageRating >'"+thrushold+"' order by c.averageRating desc";
		List<Book> topList = (List<Book>) hibernateTemplate.find(query);
		if (topList == null)
			throw new SapeStoreException("No books are rated");
		return topList;

	}

	public void updateAverageRating(Book book) throws SapeStoreException {
		LOGGER.debug(" ProductDao.updateAverageRating method: START");
		if (book == null)
			throw new SapeStoreException("Book cannot be null");
		hibernateTemplate.saveOrUpdate(book);
		LOGGER.debug(" Average rating is updated ");
	}

	public String checkForAbuse(List<String> words) throws IOException {
		// TODO Auto-generated method stub
		String badwords = "anal, anus, arse, ass, ballsack, balls, bastard, bitch, biatch, bloody, blowjob, bollock, bollok, boner, boob, bugger, bum, butt, buttplug, clitoris, cock, coon, crap, cunt, damn, dick, dildo, dyke, fag, fap, feck, fellate, fellatio, felching, fuck, fudgepacker, flange, Goddamn, hell, homo, jerk, jizz, knobend, labia, lmao, lmfao, muff, nigger, nigga, omg, penis, piss, poop, prick, pube, pussy, queer, scrotum, sex, shit, sh1t, slut, smegma, spunk, tit, tosser, turd, twat, vagina, wank";
		String[] abuseIndividuals = badwords.split(", ");
		String result = "";

		for (String abuse : words) {
			int flag = 0;
			for (String abuseIndividual : abuseIndividuals) {

				if (abuse.equalsIgnoreCase(abuseIndividual)) {
					abuse = " **** ";
					result = result + abuse + " ";
					flag = 1;
				}
				if (flag == 1)
					break;
			}
			if (flag == 1)
				continue;
			result = result + abuse + " ";

		}
		return result;
	}
	public 	boolean validate(String isbn){
		int flag = 0;
		String query="select b.isbn from Book b ";
		List<String> isbnlist=new ArrayList<String>() ;
		isbnlist=(List<String>) hibernateTemplate.find(query);
		for(String i:isbnlist)
		{
			if(i.equals(isbn)){
	      flag=1;
	      break;
			}}
		if(flag==1){
			return false;
	}else
		return true;
		}
	
	public boolean referBook(String isbn,String emailId,String userId){
		User user = hibernateTemplate.get(User.class, userId);
		Book book =hibernateTemplate.get(Book.class , isbn);
		String from = "admin@sapestore.com";
		String host = "inrelaymail.sapient.com";
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", host);
		Session session = Session.getInstance(properties);
		String mess="";
		
		
		
		try{
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(emailId));
		message.setSubject("Book Referred");
		String url="http://10.150.16.224:8081/SapeStore/viewBookDetails?isbn="+ isbn;
		Template template = velocityEngine.getTemplate("emailtemplaterefer.vm" );

		  VelocityContext velocityContext = new VelocityContext();
		  velocityContext.put("isbn", isbn);
		  velocityContext.put("bookTitle", book.getBookTitle());
		  velocityContext.put("bookDesc", book.getBookDetailDescription());
		  velocityContext.put("bookPrice", book.getBookPrice());
		  velocityContext.put("userName", user.getName());
		  velocityContext.put("url", url);
		  StringWriter stringWriter = new StringWriter();
		  
		  template.merge(velocityContext, stringWriter);
		  message.setText(stringWriter.toString());

		
		
	/*	message.setText("Your friend "+user.getName()+" has referred the following book to you\n"+
				"\n"+"Book Image: "+book.getBookFullImage()+
				"\n"+"Book Title: "+book.getBookTitle()+
				"\n"+"Book Description: "+book.getBookDetailDescription()+
				"\n"+"Book Price: "+book.getBookPrice()+
				"Please click on this link to view the book :  http://10.150.16.224:8081/SapeStore/viewBookDetails?isbn=" + isbn);*/
		
		Transport.send(message);
		return true;
		}catch(MessagingException mex){
			mex.printStackTrace();
		 	return false;
		}
	}
}
