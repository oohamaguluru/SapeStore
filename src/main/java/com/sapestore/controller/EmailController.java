package com.sapestore.controller;

import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.opensymphony.xwork2.ActionSupport;
import com.sapestore.common.ApplicationConstants;
import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.AccountDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.service.AccountService;
import com.sapestore.service.BookService;
import com.sapestore.service.ProductService;

/**
 * This is a controller class for the email functionality on Defaulters Report page. 
 *
 * CHANGE LOG
 *      VERSION    DATE          AUTHOR       MESSAGE               
 *        1.0    20-06-2014     SAPIENT      Initial version
 */

@Controller
public class EmailController {
	
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(EmailController.class.getName());
	
	/**
	 * Sends email to book return defaulters.
	 * @param ids
	 * @param modelMap
	 * @return
	 */
	
	private List<Book> bookList;
    private List<BookCategory> catList;
    private String categoryName;
    private boolean checkMe;
    
    @Autowired
	ProductService productService;
    
    @Autowired
    BookService bookService;
    
    @Autowired
    AccountService accountService;

	@RequestMapping(value = "/sendEmail", method = RequestMethod.GET)
	public String sendEmail(@RequestParam("emailIds") String ids, ModelMap modelMap) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("sendEmail method: START");
		}
		String sepIds[] = ids.split(":");
		for (int i = 0; i < sepIds.length; i++) {
			String details[] = sepIds[i].split("#");
			String from = "admin@sapestore.com";
			String host = "inrelaymail.sapient.com";
			Properties properties = System.getProperties();
			properties.setProperty("mail.smtp.host", host);
			Session session = Session.getInstance(properties);
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(details[0]));

				if (details[5].equals("RETURNED")) {
					message.setSubject("Dear Customer, Your late book return has levied a late fee!!");
					message.setText("Dear "
							+ details[1]
							+ ",\r\n"
							+ "\r\nYou returned the rented "
							+ details[2]
							+ " post its due date i.e. "
							+ details[3]
							+ ". Hence you have been charged a late fee of $"
							+ details[4]
							+ ".\r\n"
							+ "\r\nNote : In case of any query, please give a call to our customer support at +1 2444448080.\r\n"
							+ "\r\n" + "\r\nHappy Reading!!\r\n"
							+ "Sape Store Admin");

				} else {
					message.setSubject("Dear Customer, Your book return is pending!!");
					message.setText("Dear "
							+ details[1]
							+ ",\r\n"
							+ "\r\nYou have rented "
							+ details[2]
							+ " and its due date for return was "
							+ details[3]
							+ ". We have not received the book and you have been levied a late fee of $"
							+ details[4]
							+ ".\r\n"
							+ "Please return the book at the earliest to avoid further increase in late fee charge.\r\n"
							+ "\r\nNote In case of any query, please give a call to our customer support at +1 2444448080.\r\n"
							+ "\r\n" + "\r\nHappy Reading!!\r\n"
							+ "Sape Store Admin");

				}
				Transport.send(message);
			} 
			catch (MessagingException mex) {
				LOGGER.error("welcome method: ERROR: " + mex);
				return ApplicationConstants.FAILURE;
			}
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("sendEmail method: END");
		}
		return ActionSupport.NONE;
	}
	
	@RequestMapping(value="/forgot",method=RequestMethod.GET)
    public String sendemail(@RequestParam("email") String email,ModelMap model) throws SapeStoreException{
           
           Integer flag=7;
                  System.out.println("Controller reached!!!!!!!!!!!!!!!!!!!!!!");
                  String from = "admin@sapestore.com";
                  String host = "inrelaymail.sapient.com";
                  Properties properties = System.getProperties();
                  properties.setProperty("mail.smtp.host", host);
                  System.out.println("Mapped");
                  Session session = Session.getInstance(properties);  
    try{
                  MimeMessage message = new MimeMessage(session);
                  message.setFrom(new InternetAddress(from));
                  message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                  message.setSubject("Password reset");
                  message.setText("Please click on this link to change your password :  http://10.150.16.224:8081/SapeStore/changePassword/" + email);
                  System.out.println(message);
                  boolean bool = accountService.checkEmail(email);
                  System.out.println("BOOOLEANNNNNN +++++++" + bool);
                  if(bool) {
                        Transport.send(message);
                        System.out.println();
                  }
                  else {
                        checkMe = false;
                        model.addAttribute("checkMe", checkMe);
                        List<Book> topList = null;
                        try {
                               this.setCatList(getCategoryList());
                               model.addAttribute("categoryName", getCategoryName());
                               this.setCategoryName("Top Rated");
                               model.addAttribute("categoryId", 1);
                               topList = bookService.getTopRatedBooks();
                               model.addAttribute("bookList", topList);
                               model.addAttribute("catList", this.getCatList());
                        } catch (SapeStoreSystemException e) {
                               LOGGER.error("welcome method: ERROR: " + e);
                               model.addAttribute("errorMessage", "Error in opening the start page.");
                               return "redirect:/errorPage";
                        }
                        if (LOGGER.isDebugEnabled()) {
                               LOGGER.debug("slash method: END");
                        }
                        
                        model.addAttribute("flag",flag);
                        
                        return "home";
                  }
                  }catch(MessagingException mex){
                        mex.printStackTrace();
                  }
           System.out.println("CONTROLLER EXIT!!!!!!!!!!!!!!!!!!!!");
           model.addAttribute("email",email);
           return "redirect:/";
}
	@RequestMapping(value="/referBook",method=RequestMethod.GET)
	public String sendemailReferBook(@RequestParam("isbn1")String isbn,@RequestParam("emailId")String emailId,@RequestParam("userId")String userId,ModelMap modelMap) throws SapeStoreException{
				productService.referBook(isbn, emailId,userId);
		return "forward:/viewBookDetails?isbn=" + isbn;
}
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
    public void setCatList(List<BookCategory> catList) {
           this.catList = catList;
    }

    public List<Book> getBookList() {
           return bookList;
    }

    public void setBookList(List<Book> bookList) {
           this.bookList = bookList;
    }

    public String getCategoryName() {
           return categoryName;
    }

    public void setCategoryName(String categoryName) {
           this.categoryName = categoryName;
    }

    public boolean isCheckMe() {
           return checkMe;
    }

    public void setCheckMe(boolean checkMe) {
           this.checkMe = checkMe;
    }

    public BookService getBookService() {
           return bookService;
    }

    public void setBookService(BookService bookService) {
           this.bookService = bookService;
    }

    public AccountService getAccountService() {
           return accountService;
    }

    public void setAccountService(AccountService accountService) {
           this.accountService = accountService;
    }

    public List<BookCategory> getCatList() {
           return catList;
    }

}




