
package com.sapestore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.opensymphony.xwork2.util.logging.Logger;
import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.ProductDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.BookRatingComments;
import com.sapestore.service.BookService;
import com.sapestore.vo.UserVO;
import com.sapestore.vo.BookRatingCommentsVO;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.HomeVO;

/**
 * This is a controller class for landing and post customer login pages.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Controller
@SessionAttributes("checkMe")
public class HomePageController {

	private List<Book> bookList;
	private List<BookCategory> catList;
	private String categoryName;
	private boolean checkMe;

	@Autowired
	private BookService bookService;

	@Autowired
	private ProductDao productDao;
	
	
	public BookService getBookService() {
		return bookService;
	}

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(HomePageController.class.getName());

	public boolean isCheckMe() {
		return checkMe;
	}

	public void setCheckMe(boolean checkMe) {
		this.checkMe = checkMe;
	}

	public List<Book> getBookList() {
		return bookList;
	}

	public void setBookList(List<Book> bookList) {
		this.bookList = bookList;
	}

	public List<BookCategory> getCatList() {
		return catList;
	}

	public void setCatList(List<BookCategory> catList) {
		this.catList = catList;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	/**
	 * Processes the home page requests.
	 * 
	 * @param checkMe
	 * @param modelMap
	 * @return
	 * @throws SapeStoreSystemException
	 */
	@RequestMapping("/")
	public String start(ModelMap modelMap) throws SapeStoreException {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("slash method: START");
		}

		checkMe = false;
		modelMap.addAttribute("checkMe", checkMe);
		List<Book> topList = null;
		try {
			this.setCatList(getCategoryList());
			modelMap.addAttribute("categoryName", getCategoryName());
			this.setCategoryName("Top Rated");
			modelMap.addAttribute("categoryId", 1);
			topList = bookService.getTopRatedBooks();
			modelMap.addAttribute("bookList", topList);
			modelMap.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			modelMap.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("slash method: END");
		}
		return "home";
	}

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(@RequestParam(value = "checkMe", required = false) boolean checkMe, ModelMap modelMap,
			HttpServletRequest httpServletRequest, HttpSession httpSession) throws SapeStoreException {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("welcome method: START");
		}

		List<Book> bookList = null;
		List<Book> topList = null;
		try {
			this.setCatList(getCategoryList());
			Object checkMeFromSession = httpSession.getAttribute("checkMe");
			bookList = getBooksList(checkMeFromSession);

			if (checkMeFromSession != null && (boolean) checkMeFromSession) {
				bookList.addAll(bookService.getBookFromWebService(0));
			}
			// this.setBookList(bookList);
			this.setCategoryName("Top Rated");
			topList = bookService.getTopRatedBooks();
			modelMap.addAttribute("bookList", topList);
			// modelMap.addAttribute("bookList", this.getBookList());
			modelMap.addAttribute("catList", this.getCatList());
			if (httpSession.getAttribute("checkMe") != null) {
				modelMap.addAttribute("checkMe", httpSession.getAttribute("checkMe"));
			} else {
				modelMap.addAttribute("checkMe", false);
			}
			modelMap.addAttribute("categoryName", getCategoryName());
			modelMap.addAttribute("userlogin", new UserVO());
			modelMap.addAttribute("categoryId", 0);
			modelMap.addAttribute("welcome", new HomeVO());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			modelMap.addAttribute("errorMessage", "Error in opening the welcome page.");
			return "redirect:/errorPage";
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("welcome method: ModelMap: " + modelMap);
			LOGGER.debug("welcome method: END");
		}

		return "home";
	}

	private List<Book> getBooksList(Object checkMeFromSession) throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksList method: START");
		}
		List<Book> bookList = null;
		try {
			try {
				bookList = bookService.getBookList(0, checkMeFromSession);
			} catch (SapeStoreSystemException e) {
				LOGGER.error("getBooksList method: ERROR: " + e);
			}
			this.setBookList(bookList);
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("welcome method: ERROR: " + ex);
			return null;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksList method: END");
			// jhkjkh
		}
		return bookList;
	}

	/**
	 * Processes the requests to pull book list by category
	 * 
	 * @param categoryId
	 * @param categoryName
	 * @param checkMe
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/bookListByCat", method = RequestMethod.GET)
	public String getBooksListByCat(@ModelAttribute("welcome") HomeVO welcome,
			@RequestParam("categoryId") int categoryId, @RequestParam("categoryName") String categoryName,
			ModelMap modelMap) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksListByCat method: END");
		}

		List<Book> list = null;
		List<Book>topList=null;
		try {
			this.setCheckMe(welcome.isCheckMe());
			list = bookService.getBookList(categoryId, this.isCheckMe());
			if (this.isCheckMe()) {
				list.addAll(bookService.getBookFromWebService(categoryId));
			}
			this.setBookList(list);
			this.setCatList(getCategoryList());
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("getBooksListByCat method: END" + ex);
			modelMap.addAttribute("errorMessage", "Error in getting book list by category");
			return "redirect:/errorPage";
		}
		topList = bookService.getTopRatedBooks();
		if(categoryId==0)	
		modelMap.addAttribute("bookList", topList);
		else modelMap.addAttribute("bookList", list);
		modelMap.addAttribute("catList", this.getCatList());
		modelMap.addAttribute("categoryName", categoryName);
		modelMap.addAttribute("checkMe", this.checkMe);
		modelMap.addAttribute("userlogin", new UserVO());
		modelMap.addAttribute("categoryId", categoryId);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksListByCat method: END");
		}
		return "home";
	}

	/**
	 * This method returns the category of books.
	 * 
	 * @return
	 */
	private List<BookCategory> getCategoryList() throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getCategoryList method: START");
		}

		List<BookCategory> bookCategoryList = null;

		try {
			bookCategoryList = bookService.getCategoryList();

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("getCategoryList method: ERROR: " + ex);
			return null;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getCategoryList method: END");
		}
		return bookCategoryList;
	}

	@RequestMapping(value = "/viewBookDetails", method = RequestMethod.GET)
	public String viewBookDetails(@RequestParam("isbn") String isbn, ModelMap modelMap, HttpSession session)
			throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("View book details controller: START");
		}
		BookVO book = bookService.getBookDetails(isbn.trim());
		List<BookRatingCommentsVO> reviewList = bookService.getReviews(isbn);
		modelMap.addAttribute("book", book);
		modelMap.addAttribute("reviewList", reviewList);
		try {
			modelMap.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			modelMap.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		List<Long> reviews = bookService.getNumberCommentsByDate(isbn);
		modelMap.addAttribute("reviews", reviews);
		List<Long> avgList = bookService.getTotalRating(isbn);
		if (avgList.size() == 0) {
			avgList = new ArrayList<>(1);
			avgList.add(0l);
		}
		modelMap.addAttribute("ratings", avgList.get(0));
		String userName = (String) session.getAttribute("username");
		modelMap.addAttribute("username", userName);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("View book details end method: END");
		}
		return "bookdetails";

	}

	@RequestMapping(value = "/addReview")
	public String addReview(@RequestParam("stars") String userRating, @RequestParam("comment") String comment,
			@RequestParam("isbn") String isbn, HttpSession session, HttpServletRequest request, Model map) throws IOException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inside add review controller get book by isbn: START");
		}
		String userId = (String) session.getAttribute("userId");
		Integer rating = Integer.parseInt(userRating);
		Book book = null;
		try {
			book = bookService.getBookByIsbn(isbn);
		} catch (SapeStoreException e) {
			LOGGER.error("Error in get book by isbn method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		List<String> abuseList = new ArrayList<>();
		String[] abuse;
		abuse = comment.split(" ");
		for (String abuseIndividual : abuse) {
			abuseList.add(abuseIndividual);
		}
		String cleanComment=bookService.checkForAbuse(abuseList);
		Integer cid = null;
		try {
			cid = bookService.addReview(cleanComment, rating, isbn, userId);
			LOGGER.info("Review added comment Id " + cid);
		} catch (SapeStoreException e) {
			LOGGER.error("Error in add review method method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		List<Long> numberList = null;
		try {
			numberList = bookService.getNumberCommentsByDate(isbn);
		} catch (SapeStoreException e) {
			LOGGER.error("Error in get number of comments by date method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		List<Long> totalRating = null;
		try {
			totalRating = bookService.getTotalRating(isbn);
		} catch (SapeStoreException e) {
			LOGGER.error("Get total rating method " + e);
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		Long total = totalRating.get(0);
		Long numbers = numberList.get(0);
		Long newAvgRating = total / numbers;
		book.setAverageRating(newAvgRating);
		LOGGER.info("Before update average rating method");
		try {
			bookService.updateAverageRating(book);
		} catch (SapeStoreException e) {
			LOGGER.error("Update average rating method " + e);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getCategoryList method: END");
		}
		return "redirect:/viewBookDetails?isbn=" + isbn;
	}

	@RequestMapping(value = "/readAll")
	public String readAllReviews(@RequestParam("isbn") String isbn, Model map) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Before going to read all comments page: START");
		}
		List<BookRatingCommentsVO> reviewList = null;
		try {
			reviewList = bookService.getReviews(isbn);
		} catch (SapeStoreException e1) {
			LOGGER.error("Error read all reviews method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		try {
			map.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			map.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		Book book = null;
		try {
			book = bookService.getBookByIsbn(isbn);
		} catch (SapeStoreException e) {
			LOGGER.error("Error in getting book by isbn method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		List<Long> reviews = null;
		try {
			reviews = bookService.getNumberCommentsByDate(isbn);
		} catch (SapeStoreException e1) {
			LOGGER.error("Error in get Number of comments by date method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		map.addAttribute("reviews", reviews);
		List<Long> avgList = null;
		try {
			avgList = bookService.getTotalRating(isbn);
		} catch (SapeStoreException e) {
			LOGGER.error("Error in Get total rating method");
			map.addAttribute("errorMessage", "Error in opening read all page.");
			return "redirect:/errorPage";
		}
		if (avgList.size() == 0) {
			avgList = new ArrayList<>(1);
			avgList.add(0l);
		}
		map.addAttribute("ratings", avgList.get(0));
		map.addAttribute("book", book);
		map.addAttribute("reviewList", reviewList);
		map.addAttribute("setIsbn", isbn);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getCategoryList method: END");
		}
		return "readAll";

	}
	@RequestMapping(value = "/bookByMaxComments", method = RequestMethod.GET)
	public String bookByMaxComments(@ModelAttribute("welcome") HomeVO welcome,@ModelAttribute("bookList") ArrayList<Book> bookList, ModelMap modelMap) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksListByCat method: END");
		}
		
		List<Book> list = new ArrayList<>();
		try {
			this.setCheckMe(welcome.isCheckMe());
			list = bookService.getBookRatingCommentsList();
		    Book temp=null;
            List<String> listBookRating=new ArrayList<>();
           for (Book book:list)
           {
        	
         	String is=book.getIsbn();
        	listBookRating.add(is);
         
          }
           
          for(int i=0;i<bookList.size();i++)
          {
         	if(productDao.getPosition( listBookRating,bookList.get(i)) > productDao.getPosition(listBookRating,bookList.get(i+1)))
          
         		temp=bookList.get(i);
            	bookList.set(i, bookList.get(i+1));
        	    bookList.set(i+1, temp);
         }
			modelMap.addAttribute("bookList", bookList);

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("getBooksByMaxComments method: END" + ex);
			modelMap.addAttribute("errorMessage", "Error in getting book by max comments");
		}
		try {
			modelMap.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			modelMap.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksByMaxComments method: END");
		}
		return "home";
	}

	@RequestMapping(value = "/Search", method = RequestMethod.GET)
	public String Search(@ModelAttribute("welcome") HomeVO welcome, ModelMap modelMap) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Return search initial view method: Start");
			try {
				bookList = bookService.getBookByAll("", "", "", "", "-1", this.isCheckMe());
				catList = this.getCategoryList();
				this.setCheckMe(welcome.isCheckMe());
				modelMap.addAttribute("checkMe", this.checkMe);
				modelMap.addAttribute("search", "true");
				modelMap.addAttribute("bookList", bookList);
				modelMap.addAttribute("selectList", catList);
				modelMap.addAttribute("catList", catList);
				modelMap.addAttribute("userlogin", new UserVO());
				modelMap.addAttribute("bookAuthor", "");
				modelMap.addAttribute("bookTitle", "");
				modelMap.addAttribute("publisherName", "");
				modelMap.addAttribute("categoryId", "-1");
				modelMap.addAttribute("isbn", "");
				modelMap.addAttribute("message", "");
		
			} catch (SapeStoreSystemException ex) {
				LOGGER.error("Error");
			}
			LOGGER.debug("Return search initial view method: End");
		}
		return "home";
	}



	@RequestMapping(value = "/Search", method = RequestMethod.POST)
	public String Search(@ModelAttribute("welcome") HomeVO welcome, @RequestParam("bookAuthor") String bookAuthor,
			@RequestParam("bookTitle") String bookTitle, @RequestParam("publisherName") String publisherName,
			@RequestParam("isbn") String isbn, @RequestParam("categoryId") String categoryId,
			@RequestParam("desc") String desc, @RequestParam("store") String store, ModelMap modelMap)
			throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksListByAll method: END");
		}
		List<Book> list = null;
		int size = 0;

		list = bookService.getBookByAll(bookAuthor, bookTitle, publisherName, isbn, categoryId, this.isCheckMe());
		List<Book> completeList = bookService.getBookByAll("", "", "", "", "-1", this.isCheckMe());
		size = completeList.size();
		
		if(list!= null){
			if(store.equals("true")){
				
				if(list.size() == size){
					List<Book> retailList = bookService.getBookList(0, this.isCheckMe());
					List<String> retailIsbn = new ArrayList<>();
					for (Book b : retailList) {
						retailIsbn.add(b.getIsbn());
					}
					List<String> listIsbn = new ArrayList<>();
					for (Book b : list) {
						listIsbn.add(b.getIsbn());
					}
					listIsbn.removeAll(retailIsbn);
					list.clear();
					for (String l : listIsbn) {
						Book book = bookService.getBookByIsbn(l);
						list.add(book);
					}
				}
			}else{
				if(list.size()==size){
					modelMap.addAttribute("message", "Please provide at least one of the search filter value.");
				}
				List<Book> retailList = bookService.getBookList(0, this.isCheckMe());
				List<String> retailIsbn = new ArrayList<>();
				for (Book b : retailList) {
					retailIsbn.add(b.getIsbn());
				}
				List<String> listIsbn = new ArrayList<>();
				for (Book b : list) {
					listIsbn.add(b.getIsbn());
				}
				listIsbn.retainAll(retailIsbn);
				list.clear();
				for (String l : listIsbn) {
					Book book = bookService.getBookByIsbn(l);
					list.add(book);
				}
			}
		}
		
		
		this.setCheckMe(welcome.isCheckMe());
		this.setCatList(this.getCategoryList());
		this.setBookList(list);

		
		if (desc.equals("true")) {
			List<Book> finalList = new ArrayList<>();
			if (list != null) {
				List<Book> sortedList = new ArrayList<>();
				List<String> listBookRating = new ArrayList<>();
				sortedList = bookService.getBookRatingCommentsList();
				for (Book book : sortedList) {
					String is = book.getIsbn();
					listBookRating.add(is);
				}
				List<String> listBookAll = new ArrayList<>();
				listBookAll = productDao.getBooksofZeroReviews();
				listBookRating.addAll(listBookAll);
				List<String> la = new ArrayList<>();
				for (Book l : list) {
					la.add(l.getIsbn());
				}
				listBookRating.retainAll(la);
				for (String l : listBookRating) {
					Book book = bookService.getBookByIsbn(l);
					finalList.add(book);
				}
			}
			modelMap.addAttribute("bookList", finalList);
		} else {
			modelMap.addAttribute("bookList", list);
		}
		Set<Integer> categorySet = new HashSet<>();
		List<BookCategory> selectList = new ArrayList<>();

		Integer specialFlag = 0;
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				BookCategory bookCat = new BookCategory();
				bookCat.setCategoryId(list.get(i).getCategoryId());
				categorySet.add(bookCat.getCategoryId());
			}
			List<BookCategory> categoryList = new ArrayList<>();
			for (Integer id : categorySet) {
				for (BookCategory bookCategory : catList) {
					if (id == bookCategory.getCategoryId()) {
						categoryList.add(bookCategory);
					}
				}
			}
			selectList.addAll(categoryList);
			specialFlag = 1;
		}
		
		if (specialFlag != 1)
			selectList = catList;
		modelMap.addAttribute("checkMe", this.checkMe);
		modelMap.addAttribute("userlogin", new UserVO());
		modelMap.addAttribute("bookAuthor", bookAuthor);
		modelMap.addAttribute("bookTitle", bookTitle);
		modelMap.addAttribute("publisherName", publisherName);
		modelMap.addAttribute("categoryId", categoryId);
		modelMap.addAttribute("isbn", isbn);
		modelMap.addAttribute("selectList", selectList);
		modelMap.addAttribute("catList", catList);
		modelMap.addAttribute("search", "true");
		modelMap.addAttribute("desc", desc);
		modelMap.addAttribute("store", store);
		if (list == null) {
			modelMap.addAttribute("message", "No result found.");
		}else if (list.size() == size) {
			modelMap.addAttribute("message", "Please provide at least one of the search filter value.");
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("getBooksListByAll method: END");
		}
		return "home";
	}



	@RequestMapping(value = "/faqs", method = RequestMethod.GET)
	public String faq(ModelMap modelMap,HttpServletRequest httpServletRequest,HttpSession httpSession) throws SapeStoreException {
		LOGGER.debug("contactUsCustomer method: START");
		modelMap.addAttribute("catList", this.getCategoryList());
		LOGGER.debug("contactUsCustomer method: END");
		return "faq";
	}
	
	@RequestMapping("/chat")
	public String chat(Model model, HttpSession session) {
		LOGGER.info("chat method : START");
		
		LOGGER.info("chat method : STOP");
		return "chatPage";
	}
}