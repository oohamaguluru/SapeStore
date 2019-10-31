package com.sapestore.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.BookService;
import com.sapestore.service.WishlistService;
import com.sapestore.vo.BookVO;

@Controller
public class WishListController {
	
	private List<Book> bookList;
	private List<BookCategory> catList;
	private String categoryName;
	private boolean checkMe;


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
	
	@Autowired
	BookService bookService;
	@Autowired
	private WishlistService wishservice;
	
	@RequestMapping(value="/addToWishlist",method=RequestMethod.GET)
	public String addToWishList(@RequestParam("isbnNumber") String isbn ,ModelMap map , HttpSession session) throws SapeStoreException{
		String userId = (String) session.getAttribute("userId");
		
		Book book2=bookService.getBookByIsbn(isbn);
		wishservice.addToWishlist(book2, userId);
		return "redirect:/viewBookDetails?isbn="+isbn;
	}
	
	@RequestMapping(value="/wishlistcontroller")
	public String getWishlist(ModelMap map , HttpSession session) throws SapeStoreException{
		
		 try {
             /*map.addAttribute("catList", this.getCatList());*/
			 map.addAttribute("catList",bookService.getCategoryList());
         
      } catch (SapeStoreSystemException e) {
             //LOGGER.error("welcome method: ERROR: " + e);
             map.addAttribute("errorMessage", "Error in opening the start page.");
             return "redirect:/errorPage";
      } 
		
		String userId = (String) session.getAttribute("userId");
		List<Book> b =new ArrayList<Book>();
		b=wishservice.getWishlist(userId);
		
		map.addAttribute("booklist",b);
		return "wishlist";
		
	}
	
	@RequestMapping(value="/deletefromwishlist")
	public String deletefromWishlist(@RequestParam("isbn") String isbn ,ModelMap map , HttpSession session){
		
		
		String userId = (String) session.getAttribute("userId");
		System.out.println("inside deletewishlist isbn is = "+isbn+" userid is = "+userId);
		
		wishservice.deleteFromWishlist(isbn,userId);
		
		return "redirect:/wishlistcontroller";
	}

}
