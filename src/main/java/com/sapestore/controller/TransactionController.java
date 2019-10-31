package com.sapestore.controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.BookService;
import com.sapestore.service.TransactionService;
import com.sapestore.vo.Transaction;

@Controller
@SessionAttributes("checkMe")
public class TransactionController {

	private List<BookCategory> catList;
	private String categoryName;
	private boolean checkMe;

	@Autowired
	TransactionService transactionService;

	private List<Book> bookList;

	@Autowired
	private BookService bookService;

	public BookService getBookService() {
		return bookService;
	}

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(TransactionController.class.getName());

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

	@RequestMapping("/transactionHistory")
	String transactionHistory(HttpSession session, Model model) throws SapeStoreException, ParseException {

		User user = new User();
		user.setUserId((String) session.getAttribute("userId"));
		LOGGER.debug("TransactionController : Calling Service");
		List<Transaction> transactionList = transactionService.getTransactions(user);
		if (transactionList.size() == 0) {
			LOGGER.debug("TransactionController : No transactions");
			return "transactionEmpty";
		} else {
			LOGGER.debug("TransactionController : Returning Transactions");
			model.addAttribute("transactionList", transactionList);
			return "transactionHistory";
		}
	}

}
