package com.sapestore.controller;

import java.io.StringWriter;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.OrderDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;
import com.sapestore.service.BookService;
import com.sapestore.service.OrderService;
import com.sapestore.service.ProductService;
import com.sapestore.service.impl.AccountServiceImpl;
import com.sapestore.vo.EditUserVO;
import com.sapestore.vo.ShoppingCartVO;

/**
 * This is a controller class for the login functionality.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Controller
@SessionAttributes(value = { "userId", "username", "ShoppingCart","isAdmin"  })
public class AccountController {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AccountController.class.getName());

	@Autowired
	private AccountService accountService;

	@Autowired
	private BookService bookService;

	@Autowired
	private ProductService productService;
	@Autowired
	private OrderDao orderDao;

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private VelocityEngine velocityEngine;

	private List<Book> bookList;
	private List<BookCategory> catList;
	private String categoryName;
	private boolean checkMe;

	public AccountService getAccountService() {
		return accountService;
	}

	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}

	public void setVelocityEngine(VelocityEngine velocityEngine) {
		this.velocityEngine = velocityEngine;
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

	public boolean isCheckMe() {
		return checkMe;
	}

	public void setCheckMe(boolean checkMe) {
		this.checkMe = checkMe;
	}

	Integer flag;

	@RequestMapping(value = "/beforelogin", method = RequestMethod.GET)
	public String beforeLogin(ModelMap modelMap) throws SapeStoreException {
		LOGGER.debug(" AccountController.beforeLogin method: START ");
		modelMap.addAttribute("user", new User());
		LOGGER.debug(" AccountController.beforeLogin method: END ");
		return "home";
	}

	@RequestMapping(value = "/shopMore", method = RequestMethod.GET)
	public String shopMore(ModelMap modelMap,
			HttpServletRequest httpServletRequest, HttpSession httpSession) throws SapeStoreException {
		LOGGER.debug("login method: START");

		LOGGER.debug("login method: END");
		String forwardStr = "redirect:/welcome";
		return forwardStr;
	}

	/**
	 * Processes the login requests
	 * 
	 * @param userlogin
	 * @param modelMap
	 * @return
	 * @throws SapeStoreSystemException
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register() {
		System.out.println("In register controller");
		return "register";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@ModelAttribute("user") User user, ModelMap modelMap, HttpServletRequest httpServletRequest,
                  HttpSession httpSession) throws SapeStoreException {
           LOGGER.debug("login method: START");
           String forwardStr = null;
           User localUserlogin = null;
           User userLogin = (User) user;
           System.out.println(user + "IN ACCOUTN CONTROLLER!!!!");
           List<Book> topList = null;
           localUserlogin = accountService.authenticate(userLogin);
           System.out.println("ankita " + localUserlogin);
           if (localUserlogin != null) {
                  if (localUserlogin.getIsAdmin() == null) {
                        System.out.println(1);
                        flag = 0;
                        checkMe = false;
                        modelMap.addAttribute("checkMe", checkMe);
                        List<Book> bookList = null;
                        try {
                               this.setCatList(getCategoryList());
                               bookList = getBooksList(checkMe);
                               this.setBookList(bookList);
                               modelMap.addAttribute("categoryName", getCategoryName());
                               this.setCategoryName("Top Contents");
                               modelMap.addAttribute("categoryId", 1);
                               topList = bookService.getTopRatedBooks();
                               modelMap.addAttribute("bookList", topList);
                               modelMap.addAttribute("catList", this.getCatList());
                        } catch (SapeStoreSystemException e) {
                               LOGGER.error("welcome method: ERROR: " + e);
                               modelMap.addAttribute("errorMessage", "Error in opening the start page.");
                               return "redirect:/errorPage";
                        }
                        System.out.println(2);
                        modelMap.addAttribute("flag", flag);
                        System.out.println(flag + "RETURNING USER CORRECT CREDS");
                        forwardStr = "redirect:/welcome";

                  } else if (localUserlogin.getIsAdmin().equalsIgnoreCase("Y")) {
                        forwardStr = "redirect:/manageInventory";
                  } else {
                        System.out.println(1);
                        flag = 0;
                        checkMe = false;
                        modelMap.addAttribute("checkMe", checkMe);
                        List<Book> bookList = null;
                        try {
                               this.setCatList(getCategoryList());
                               bookList = getBooksList(checkMe);
                               this.setBookList(bookList);
                               modelMap.addAttribute("categoryName", getCategoryName());
                               this.setCategoryName("Top Contents");
                               modelMap.addAttribute("categoryId", 1);
                               topList = bookService.getTopRatedBooks();
                               modelMap.addAttribute("bookList", topList);
                               modelMap.addAttribute("catList", this.getCatList());
                        } catch (SapeStoreSystemException e) {
                               LOGGER.error("welcome method: ERROR: " + e);
                               modelMap.addAttribute("errorMessage", "Error in opening the start page.");
                               return "redirect:/errorPage";
                        }
                        System.out.println(2);
                        modelMap.addAttribute("flag", flag);
                        System.out.println(flag + "RETURNING USER CORRECT CREDS");
                        forwardStr = "redirect:/welcome";
                  }
                  String userId = localUserlogin.getUserId();
                  System.out.println(3 + userId);
                  modelMap.addAttribute("userId", userId);
                  ShoppingCartVO shoppingCartVO = productService.getShoppingCart(userId);
                  modelMap.addAttribute("ShoppingCart", shoppingCartVO);
                  modelMap.addAttribute("username", localUserlogin.getName());
                  modelMap.addAttribute("isAdmin", localUserlogin.getIsAdmin());
           } else {

                  flag = 1;
                  checkMe = false;
                  modelMap.addAttribute("checkMe", checkMe);
                  List<Book> bookList = null;
                  try {
                        this.setCatList(getCategoryList());
                        bookList = getBooksList(checkMe);
                        this.setBookList(bookList);
                        modelMap.addAttribute("categoryName", getCategoryName());
                        this.setCategoryName("Top Contents");
                        modelMap.addAttribute("categoryId", 1);
                        topList = bookService.getTopRatedBooks();
                        modelMap.addAttribute("bookList", topList);
                        modelMap.addAttribute("catList", this.getCatList());
                  } catch (SapeStoreSystemException e) {
                        LOGGER.error("welcome method: ERROR: " + e);
                        modelMap.addAttribute("errorMessage", "Error in opening the start page.");
                        return "redirect:/errorPage";
                  }
                  System.out.println(flag + " WRONG FLAG");
                  modelMap.addAttribute("flag", flag);
                  return "redirect:/welcome";

           }
           LOGGER.debug("login method: END");
           return forwardStr;

    }


	/**
	 * Processes the Logout requests
	 * 
	 * @param request
	 * @param status
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(WebRequest request, SessionStatus status, ModelMap modelMap,
                  HttpServletRequest httpServletRequest, HttpSession httpSession) throws SapeStoreException {
           LOGGER.debug("logout method: START");
           String userId = (String) httpSession.getAttribute("userId");
           ShoppingCartVO shoppingCartVO = (ShoppingCartVO) httpSession.getAttribute("ShoppingCart");
           double total=shoppingCartVO.changeTotal(shoppingCartVO.getBooksInCart());
           shoppingCartVO.setTotalPrice(total);
           System.out.println(shoppingCartVO);
           productService.saveShoppingCart(userId, shoppingCartVO);
           status.setComplete();
           request.removeAttribute("userId", WebRequest.SCOPE_SESSION);
           request.removeAttribute("ShoppingCart", WebRequest.SCOPE_SESSION);
           request.removeAttribute("checkMe", WebRequest.SCOPE_SESSION);

           LOGGER.debug("logout method: END");
           return "redirect:/";
    }


	@RequestMapping("/editProfile")
	public String showProfileForm(HttpSession session, ModelMap map) {
		String userId = (String) session.getAttribute("userId");
		System.out.println(userId);
		User user = new User();
		user = accountService.getUserInfo(userId);
		String addressLine1 = accountService.getAddressLine1(user);
		String addressLine2 = accountService.getAddressLine2(user);
		String postalCode = accountService.getPostalCode(user);
		Address address = new Address();
		address.setAddressId(user.getAddressId());
		address.setAddressLine1(addressLine1);
		address.setAddressLine2(addressLine2);
		address.setPostalCode(postalCode);
		List<String> stateNames = accountService.getStateNames();
		Address stateCityAddress = accountService.getAddress(user.getAddressId());
		Integer stateId = stateCityAddress.getStateId();
		State actualState = accountService.getState(user);
		String actualStateName = actualState.getStateName();
		int i = 0;
		for (String states : stateNames) {
			if (states.equals(actualStateName)) {
				String temp = stateNames.get(0);
				stateNames.set(0, actualStateName);
				stateNames.set(i, temp);
			}
			i++;
		}
		List<String> cityNames = accountService.getCityNames();

		cityNames = accountService.getCityByState(actualStateName);

		City actualCity = accountService.getCity(user);
		String actualCityName = actualCity.getCityName();

		i = 0;
		for (String cities : cityNames) {
			if (cities.equals(actualCityName)) {
				String temp = cityNames.get(0);
				cityNames.set(0, actualCityName);
				cityNames.set(i, temp);
			}
			i++;
		}

		EditUserVO editUserVO = new EditUserVO();
		editUserVO.setAddress(address);
		editUserVO.setUser(user);
		editUserVO.setCityNames(cityNames);
		editUserVO.setStateNames(stateNames);
		map.addAttribute("editUserVO", editUserVO);
		return "editProfile";
	}

	@RequestMapping("personalInformation")
	public String showPersonalInformation(HttpSession session, ModelMap map) throws SapeStoreException {
		String userId = (String) session.getAttribute("userId");
		System.out.println(userId);
		User user = new User();
		user = accountService.getUserInfo(userId);
		String addressLine1 = accountService.getAddressLine1(user);
		String addressLine2 = accountService.getAddressLine2(user);
		String postalCode = accountService.getPostalCode(user);
		Address address = new Address();
		address.setAddressId(user.getAddressId());
		address.setAddressLine1(addressLine1);
		address.setAddressLine2(addressLine2);

		address.setPostalCode(postalCode);
		List<String> stateNames = accountService.getStateNames();
		List<String> cityNames = accountService.getCityNames();
		Address address2 = orderDao.getAddressByUser(userId);
		State state = orderDao.getStateById(address2.getStateId());
		City city = orderDao.getCityById(address2.getCityId());
		map.addAttribute("stateName", state.getStateName());
		map.addAttribute("cityName", city.getCityName());
		EditUserVO editUserVO = new EditUserVO();
		editUserVO.setAddress(address);
		editUserVO.setUser(user);
		editUserVO.setCityNames(cityNames);
		editUserVO.setStateNames(stateNames);
		map.addAttribute("editUserVO", editUserVO);
		return "personalInformation";
	}

	@RequestMapping("/editProfileSubmit")
	public String editUserConfirm(@ModelAttribute("editUserVO") EditUserVO editUserVO, HttpSession session,
			BindingResult result, @RequestParam("stateNames") String stateName,
			@RequestParam("cityNames") String cityName, Model model) throws AddressException, MessagingException {

		if (result.hasErrors()) {
			return "editProfile";
		} else {

			String userId = (String) session.getAttribute("userId");
			User tempuser = new User();
			tempuser = accountService.getUserInfo(userId);
			User user = editUserVO.getUser();
			user.setGenderId(tempuser.getGenderId());
			user.setIsActive(tempuser.getIsActive());
			user.setAddressId(tempuser.getAddressId());
			user.setCreatedDate(tempuser.getCreatedDate());
			user.setUpdatedDate(tempuser.getUpdatedDate());
			System.out.println(stateName + cityName + "CONTROLLER BROOOOOOOOOOO");
			List<Integer> stateAndCity = accountService.getStateAndCityIds(cityName);

			Address tempaddress = new Address();
			tempaddress = accountService.getAddress(tempuser.getAddressId());
			Address address = editUserVO.getAddress();
			address.setAddressId(tempaddress.getAddressId());
			address.setCityId(tempaddress.getCityId());
			address.setCountryId(tempaddress.getCountryId());
			address.setUserId(tempaddress.getUserId());
			address.setMobileNumber(tempaddress.getMobileNumber());
			address.setIsActive(tempaddress.getIsActive());
			address.setName(tempuser.getName());
			address.setUpdatedDate(tempaddress.getUpdatedDate());
			address.setCreatedDate(tempaddress.getCreatedDate());
			address.setCityId(stateAndCity.get(1));
			address.setStateId(stateAndCity.get(0));
			editUserVO.setUser(user);
			editUserVO.setAddress(address);
			boolean b = accountService.editProfile(editUserVO);
			if (b) {
				System.out.println("USERNAAAAMMEEEEEEEE" + editUserVO.getUser().getName());
				session.removeAttribute("username");
				session.setAttribute("username", editUserVO.getUser().getName());
				String from = "admin@sapestore.com";
				String host = "inrelaymail.sapient.com"; // 10.150.4.99
				Properties properties = System.getProperties();
				System.out.println("hai");
				properties.setProperty("mail.smtp.host", host);
				MimeMessage message = new MimeMessage(Session.getDefaultInstance(properties, null));
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(editUserVO.getUser().getEmailAddress()));
				message.setSubject("Editing Account with SapeStore Online Book Store!!!");

				Template template = velocityEngine.getTemplate("emailtemplateedit.vm");

				VelocityContext velocityContext = new VelocityContext();
				velocityContext.put("userId", editUserVO.getUser().getUserId());
				StringWriter stringWriter = new StringWriter();

				template.merge(velocityContext, stringWriter);
				message.setText(stringWriter.toString());

				Transport.send(message);
			orderService.sendSms(editUserVO.getUser().getMobileNumber(),"Profile Edited Successfully!\n"+"Have a Nice Day :)");
				//session.removeAttribute("username");
				//session.setAttribute("username", editUserVO.getUser().getName());
				model.addAttribute("flag", flag);

				return "redirect:/";
			} else {
				model.addAttribute("editUserVO", editUserVO);
				return "editProfile";
			}
		}

	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String signUp(@ModelAttribute("user") User user, ModelMap modelMap, HttpServletRequest httpServletRequest,
			HttpSession httpSession) throws SapeStoreException {
		checkMe = false;
		modelMap.addAttribute("checkMe", checkMe);
		List<Book> bookList = null;
		this.setCatList(getCategoryList());
		bookList = getBooksList(checkMe);
		this.setBookList(bookList);
		modelMap.addAttribute("categoryName", getCategoryName());
		this.setCategoryName("Top Contents");
		modelMap.addAttribute("categoryId", 1);
		modelMap.addAttribute("bookList", this.getBookList());
		modelMap.addAttribute("catList", this.getCatList());

		EditUserVO editUserVO = new EditUserVO();
		try {
			modelMap.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			modelMap.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		List<String> stateNames = accountService.getStateNames();
		List<String> cityNames = accountService.getCityNames();
		editUserVO.setCityNames(cityNames);
		editUserVO.setStateNames(stateNames);
		modelMap.addAttribute("editUserVO", editUserVO);
		return "signUp";

	}

	@RequestMapping("/getCities")
	public String getCities(@RequestParam("statename") String state, @RequestParam("password") String password,
			@RequestParam("confpassword") String confpassword, HttpSession session, ModelMap model) {
		String userId = (String) session.getAttribute("userId");
		System.out.println(userId);
		System.out.println(state + "STATE CONTROLLER + ++++++++++");
		User user = new User();
		user = accountService.getUserInfo(userId);
		String addressLine1 = accountService.getAddressLine1(user);
		String addressLine2 = accountService.getAddressLine2(user);
		String postalCode = accountService.getPostalCode(user);
		Address address = new Address();
		address.setAddressId(user.getAddressId());
		address.setAddressLine1(addressLine1);
		address.setAddressLine2(addressLine2);
		address.setPostalCode(postalCode);
		List<String> stateNames = accountService.getStateNames();
		List<String> cityNames = accountService.getCityByState(state);
		System.out.println(cityNames + "IN CONTROLLER GET CITIES");
		EditUserVO editUserVO = new EditUserVO();
		editUserVO.setAddress(address);
		editUserVO.setUser(user);
		editUserVO.setCityNames(cityNames);
		int i = 0;
		for (String swapState : stateNames) {
			if (swapState.equals(state)) {
				String temp = stateNames.get(0);
				stateNames.set(0, swapState);
				stateNames.set(i, temp);
			}
			i++;
		}
		editUserVO.setStateNames(stateNames);
		model.addAttribute("editUserVO", editUserVO);
		model.addAttribute("pass", password);
		model.addAttribute("cpass", confpassword);
		model.addAttribute("flag", 2);
		return "editProfile";
	}

	@RequestMapping("/getCitiesSignUp")
	public String getCitiesSignUp(@RequestParam("statename") String state, @RequestParam("name") String name,
			@RequestParam("userId") String userId, @RequestParam("password") String password,
			@RequestParam("confpassword") String confpassword, @RequestParam("email") String email,
			@RequestParam("add1") String addressLine1, @RequestParam("add2") String addressLine2,
			@RequestParam("postalcode") String zipcode, @RequestParam("phone") String phone,
			@RequestParam("mobile") String mobile, HttpSession session, ModelMap model) {
		checkMe = false;
		model.addAttribute("checkMe", checkMe);
		List<Book> bookList = null;
		try {
			this.setCatList(getCategoryList());
		} catch (SapeStoreException e1) {
			e1.printStackTrace();
		}
		try {
			bookList = getBooksList(checkMe);
		} catch (SapeStoreException e1) {
			e1.printStackTrace();
		}
		this.setBookList(bookList);
		model.addAttribute("categoryName", getCategoryName());
		this.setCategoryName("Top Contents");
		model.addAttribute("categoryId", 1);
		model.addAttribute("bookList", this.getBookList());
		model.addAttribute("catList", this.getCatList());

		try {
			model.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			model.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		Address address = new Address();
		address.setAddressLine1(addressLine1);
		address.setAddressLine2(addressLine2);
		address.setPostalCode(zipcode);
		List<String> stateNames = accountService.getStateNames();
		List<String> cityNames = accountService.getCityByState(state);
		EditUserVO editUserVO = new EditUserVO();
		User user = new User();
		user.setName(name);
		user.setUserId(userId);
		user.setPassword(password);
		user.setEmailAddress(email);
		user.setPhone(phone);
		user.setMobileNumber(mobile);
		editUserVO.setUser(user);
		editUserVO.setAddress(address);
		editUserVO.setCityNames(cityNames);
		int i = 0;
		for (String swapState : stateNames) {
			if (swapState.equals(state)) {
				String temp = stateNames.get(0);
				stateNames.set(0, swapState);
				stateNames.set(i, temp);
			}
			i++;
		}
		editUserVO.setStateNames(stateNames);
		model.addAttribute("editUserVO", editUserVO);
		model.addAttribute("cpass", confpassword);
		model.addAttribute("pass", password);
		model.addAttribute("flag", 2);
		return "signUp";
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

	@RequestMapping("/changePassword/{emailid}")
	public String changePassword(@PathVariable("emailid") String emailid, ModelMap model) {
		model.addAttribute("emailid", emailid);
		return "changePassword";
	}

	@RequestMapping(value = "/changePasswordSubmit", method = RequestMethod.POST)
	public String changePasswordSubmit(@RequestParam("email") String emailid, @RequestParam("password") String password,
			ModelMap model) {
		Integer passwordChange = 0;

		checkMe = false;
		model.addAttribute("checkMe", checkMe);
		List<Book> bookList = null;
		try {
			this.setCatList(getCategoryList());
			bookList = getBooksList(checkMe);
			this.setBookList(bookList);
			model.addAttribute("categoryName", getCategoryName());
			this.setCategoryName("Top Contents");
			model.addAttribute("categoryId", 1);
			model.addAttribute("bookList", this.getBookList());
			model.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException | SapeStoreException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			model.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}

		if (accountService.changePassword(emailid, password)) {
			passwordChange = 1;
			model.addAttribute("passwordChange", passwordChange);
		} else {
			passwordChange = 2;
			model.addAttribute("passwordChange", passwordChange);
		}

		return "home";

	}

	@RequestMapping(value = "/notLoggedIn", method = RequestMethod.GET)
	public String notLoggedIn(ModelMap model) throws SapeStoreException {
		LOGGER.debug("Not Logged in");
		checkMe = false;
		model.addAttribute("checkMe", checkMe);
		List<Book> bookList = null;
		List<Book> topList = null;
		try {
			this.setCatList(getCategoryList());
			/*
			 * bookList = getBooksList(checkMe); this.setBookList(bookList);
			 */
			model.addAttribute("categoryName", getCategoryName());
			this.setCategoryName("Top Contents");
			model.addAttribute("categoryId", 1);
			topList = bookService.getTopRatedBooks();
			model.addAttribute("bookList", topList);
			// modelMap.addAttribute("bookList", this.getBookList());
			model.addAttribute("catList", this.getCatList());
		} catch (SapeStoreSystemException e) {
			LOGGER.error("welcome method: ERROR: " + e);
			model.addAttribute("errorMessage", "Error in opening the start page.");
			return "redirect:/errorPage";
		}
		model.addAttribute("message", "Log in first as an admin");
		return "home";
	}

	@RequestMapping(value = "/checkLoggedIn", method = RequestMethod.GET)
	public String checkLoggedIn(@RequestParam("userId") String userId) {
		LOGGER.debug("Check whether Logged in as a user or an admin");

		AccountService as = new AccountServiceImpl();
		User user = as.getUserInfo(userId);
		if (user.getIsAdmin() != null) {
			if (user.getIsAdmin().equals("Y")) {
				return "ManageOrders";
			} else {
				return "login";
			}
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/signUpSubmit")
	public String signUpConfirm(@ModelAttribute("editUserVO") EditUserVO editUserVO, HttpSession session,
			BindingResult result, @RequestParam("stateNames") String stateName,
			@RequestParam("cityNames") String cityName, ModelMap model)
			throws AddressException, MessagingException, SapeStoreException {

		if (result.hasErrors()) {
			return "signUp";
		} else {
			User user = editUserVO.getUser();
			System.out.println("CHECKING PASSWORD !    " + editUserVO.getUser().getPassword());
			String password = editUserVO.getUser().getPassword();
			List<Integer> stateAndCity = accountService.getStateAndCityIds(cityName);
			Integer stateId = stateAndCity.get(0);
			Integer cityId = stateAndCity.get(1);
			Integer addressId = accountService.getAddressId(stateId, cityId);
			Address address = new Address();
			editUserVO.getAddress().setAddressId(addressId);
			editUserVO.getAddress().setCityId(cityId);
			editUserVO.getAddress().setStateId(stateId);
			editUserVO.getAddress().setUserId(editUserVO.getUser().getUserId());
			editUserVO.getAddress().setIsActive("Y");
			Date createdDate = new Date();
			editUserVO.getAddress().setCreatedDate(createdDate);
			editUserVO.getAddress().setUpdatedDate(createdDate);
			editUserVO.getUser().setAddressId(addressId);
			editUserVO.getUser().setCreatedDate(createdDate);
			editUserVO.getUser().setIsActive("Y");
			editUserVO.getUser().setIsAdmin("N");
			editUserVO.getUser().setUpdatedDate(createdDate);
			editUserVO.getUser().setGenderId(1);
			boolean b = accountService.addProfile(editUserVO);
			if (b) {
				String from = "admin@sapestore.com";
				String host = "inrelaymail.sapient.com"; // 10.150.4.99
				Properties properties = System.getProperties();
				properties.setProperty("mail.smtp.host", host);
				MimeMessage message = new MimeMessage(Session.getDefaultInstance(properties, null));
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(editUserVO.getUser().getEmailAddress()));
				message.setSubject("Creating Account with SapeStore Online Book Store!!!");
				/*
				 * message.setText(" Welcome To SapeStore! " + "\n" + "Your ID:"
				 * + editUserVO.getUser().getUserId() + "\n" + "Your Password:"
				 * + editUserVO.getUser().getPassword());
				 */

				Template template = velocityEngine.getTemplate("emailtemplateregister.vm");
				VelocityContext velocityContext = new VelocityContext();
				velocityContext.put("userId", editUserVO.getUser().getUserId());
				StringWriter stringWriter = new StringWriter();
				template.merge(velocityContext, stringWriter);
				message.setText(stringWriter.toString());
				
				//orderService.sendSms(editUserVO.getUser().getMobileNumber(),"Welcome to SapeStore!\n"+"Hi "+editUserVO.getUser().getUserId());
				try {
					orderService.sendSms(editUserVO.getUser().getMobileNumber(),"Welcome to SapeStore!\n"+"Hi "+editUserVO.getUser().getUserId());
					Transport.send(message);
				} catch (Exception e) {
					e.printStackTrace();
				}

				checkMe = false;
				model.addAttribute("checkMe", checkMe);
				List<Book> bookList = null;
				List<Book> topList = null;
				try {
					this.setCatList(getCategoryList());
					/*
					 * bookList = getBooksList(checkMe);
					 * this.setBookList(bookList);
					 */
					model.addAttribute("categoryName", getCategoryName());
					this.setCategoryName("Top Contents");
					model.addAttribute("categoryId", 1);
					topList = bookService.getTopRatedBooks();
					model.addAttribute("bookList", topList);
					// modelMap.addAttribute("bookList", this.getBookList());
					model.addAttribute("catList", this.getCatList());
				} catch (SapeStoreSystemException e) {
					LOGGER.error("welcome method: ERROR: " + e);
					model.addAttribute("errorMessage", "Error in opening the start page.");
					return "redirect:/errorPage";
				}

				System.out.println("USERRRR!!!!! " + user);

				// LOGIN HERE

				LOGGER.debug("login method: START");
				String forwardStr = null;
				User localUserlogin = null;
				user.setPassword(password);
				User userLogin = (User) user;
				System.out.println(user + "IN ACCOUTN CONTROLLER!!!!");
				topList = null;
				localUserlogin = accountService.authenticate(userLogin);
				System.out.println("ankita " + localUserlogin);
				if (localUserlogin != null) {
					if (localUserlogin.getIsAdmin() == null) {
						System.out.println(1);
						flag = 0;
						checkMe = false;
						model.addAttribute("checkMe", checkMe);
						bookList = null;
						try {
							this.setCatList(getCategoryList());
							bookList = getBooksList(checkMe);
							this.setBookList(bookList);
							model.addAttribute("categoryName", getCategoryName());
							this.setCategoryName("Top Contents");
							model.addAttribute("categoryId", 1);
							topList = bookService.getTopRatedBooks();
							model.addAttribute("bookList", topList);
							model.addAttribute("catList", this.getCatList());
						} catch (SapeStoreSystemException e) {
							LOGGER.error("welcome method: ERROR: " + e);
							model.addAttribute("errorMessage", "Error in opening the start page.");
							return "redirect:/errorPage";
						}
						System.out.println(2);
						model.addAttribute("flag", flag);
						System.out.println(flag + "RETURNING USER CORRECT CREDS");
						forwardStr = "home";

					} else if (localUserlogin.getIsAdmin().equalsIgnoreCase("Y")) {
						forwardStr = "redirect:/manageInventory";
					} else {
						System.out.println(1);
						flag = 0;
						checkMe = false;
						model.addAttribute("checkMe", checkMe);
						bookList = null;
						try {
							this.setCatList(getCategoryList());
							bookList = getBooksList(checkMe);
							this.setBookList(bookList);
							model.addAttribute("categoryName", getCategoryName());
							this.setCategoryName("Top Contents");
							model.addAttribute("categoryId", 1);
							topList = bookService.getTopRatedBooks();
							model.addAttribute("bookList", topList);
							model.addAttribute("catList", this.getCatList());
						} catch (SapeStoreSystemException e) {
							LOGGER.error("welcome method: ERROR: " + e);
							model.addAttribute("errorMessage", "Error in opening the start page.");
							return "redirect:/errorPage";
						}
						System.out.println(2);
						model.addAttribute("flag", flag);
						System.out.println(flag + "RETURNING USER CORRECT CREDS");
						forwardStr = "home";
					}
					String userId = localUserlogin.getUserId();
					System.out.println(3 + userId);
					model.addAttribute("userId", userId);
					ShoppingCartVO shoppingCartVO = productService.getShoppingCart(userId);
					model.addAttribute("ShoppingCart", shoppingCartVO);
					model.addAttribute("username", localUserlogin.getName());
				} else {

					flag = 1;
					checkMe = false;
					model.addAttribute("checkMe", checkMe);
					bookList = null;
					try {
						this.setCatList(getCategoryList());
						bookList = getBooksList(checkMe);
						this.setBookList(bookList);
						model.addAttribute("categoryName", getCategoryName());
						this.setCategoryName("Top Contents");
						model.addAttribute("categoryId", 1);
						topList = bookService.getTopRatedBooks();
						model.addAttribute("bookList", topList);
						model.addAttribute("catList", this.getCatList());
					} catch (SapeStoreSystemException e) {
						LOGGER.error("welcome method: ERROR: " + e);
						model.addAttribute("errorMessage", "Error in opening the start page.");
						return "redirect:/errorPage";
					}
					System.out.println(flag + " WRONG FLAG");
					model.addAttribute("flag", flag);
					return "home";

				}
				LOGGER.debug("login method: END");
				return forwardStr;

			} else {
				System.out.println("profile not added");
				Integer flag = 1;
				model.addAttribute(editUserVO);
				model.addAttribute("flag", flag);
				return "signUp";
			}
		}

	}

	@RequestMapping(value = "/loginwish", method = RequestMethod.POST)
	public String loginwish(@ModelAttribute("user") User user, ModelMap modelMap, HttpServletRequest httpServletRequest,
			HttpSession httpSession) throws SapeStoreException {
		LOGGER.debug("login method: START");
		String forwardStr = null;
		User localUserlogin = null;
		User userLogin = (User) user;
		System.out.println(user + "IN ACCOUTN CONTROLLER!!!!");
		List<Book> topList = null;
		localUserlogin = accountService.authenticate(userLogin);
		System.out.println("ankita " + localUserlogin);
		if (localUserlogin != null) {
			if (localUserlogin.getIsAdmin() == null) {
				System.out.println(1);
				flag = 0;
				checkMe = false;
				modelMap.addAttribute("checkMe", checkMe);
				List<Book> bookList = null;
				try {
					this.setCatList(getCategoryList());
					bookList = getBooksList(checkMe);
					this.setBookList(bookList);
					modelMap.addAttribute("categoryName", getCategoryName());
					this.setCategoryName("Top Contents");
					modelMap.addAttribute("categoryId", 1);
					topList = bookService.getTopRatedBooks();
					modelMap.addAttribute("bookList", topList);
					modelMap.addAttribute("catList", this.getCatList());
				} catch (SapeStoreSystemException e) {
					LOGGER.error("welcome method: ERROR: " + e);
					modelMap.addAttribute("errorMessage", "Error in opening the start page.");
					return "redirect:/errorPage";
				}
				System.out.println(2);
				modelMap.addAttribute("flag", flag);
				System.out.println(flag + "RETURNING USER CORRECT CREDS");
				forwardStr = "redirect:/wishlistcontroller";

			} else if (localUserlogin.getIsAdmin().equalsIgnoreCase("Y")) {
				forwardStr = "redirect:/manageInventory";
			} else {
				System.out.println(1);
				flag = 0;
				checkMe = false;
				modelMap.addAttribute("checkMe", checkMe);
				List<Book> bookList = null;
				try {
					this.setCatList(getCategoryList());
					bookList = getBooksList(checkMe);
					this.setBookList(bookList);
					modelMap.addAttribute("categoryName", getCategoryName());
					this.setCategoryName("Top Contents");
					modelMap.addAttribute("categoryId", 1);
					topList = bookService.getTopRatedBooks();
					modelMap.addAttribute("bookList", topList);
					modelMap.addAttribute("catList", this.getCatList());
				} catch (SapeStoreSystemException e) {
					LOGGER.error("welcome method: ERROR: " + e);
					modelMap.addAttribute("errorMessage", "Error in opening the start page.");
					return "redirect:/errorPage";
				}
				System.out.println(2);
				modelMap.addAttribute("flag", flag);
				System.out.println(flag + "RETURNING USER CORRECT CREDS");
				forwardStr = "redirect:/wishlistcontroller";
			}
			String userId = localUserlogin.getUserId();
			System.out.println(3 + userId);
			modelMap.addAttribute("userId", userId);
			ShoppingCartVO shoppingCartVO = productService.getShoppingCart(userId);

			modelMap.addAttribute("ShoppingCart", shoppingCartVO);
			modelMap.addAttribute("username", localUserlogin.getName());
		} else {

			flag = 1;
			checkMe = false;
			modelMap.addAttribute("checkMe", checkMe);
			List<Book> bookList = null;
			try {
				this.setCatList(getCategoryList());
				bookList = getBooksList(checkMe);
				this.setBookList(bookList);
				modelMap.addAttribute("categoryName", getCategoryName());
				this.setCategoryName("Top Contents");
				modelMap.addAttribute("categoryId", 1);
				topList = bookService.getTopRatedBooks();
				modelMap.addAttribute("bookList", topList);
				modelMap.addAttribute("catList", this.getCatList());
			} catch (SapeStoreSystemException e) {
				LOGGER.error("welcome method: ERROR: " + e);
				modelMap.addAttribute("errorMessage", "Error in opening the start page.");
				return "redirect:/errorPage";
			}
			System.out.println(flag + " WRONG FLAG");
			modelMap.addAttribute("flag", flag);
			return "redirect:/wishlistcontroller";

		}
		LOGGER.debug("login method: END");
		return forwardStr;

	}

}
