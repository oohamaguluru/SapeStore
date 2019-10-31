package com.sapestore.controller;

import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sapestore.common.ApplicationConstants;
import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.OrderDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.AddressComplete;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.Country;
import com.sapestore.hibernate.entity.OrderInfo;
import com.sapestore.hibernate.entity.OrderItemInfo;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;
import com.sapestore.service.OrderService;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.DispatchSlip;
import com.sapestore.vo.PurchaseUpdate;
import com.sapestore.vo.PurchaseUpdateForm;
import com.sapestore.vo.RentedUpdate;
import com.sapestore.vo.RentedUpdateForm;
import com.sapestore.vo.ShoppingCartVO;

@Controller
@SessionAttributes({ "dispatchList", "userId", "username", "address", "ShoppingCart", "dispatchLista",
		"shippingAddress", "orderId","totalPrice" })
public class OrderController {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(OrderController.class.getName());

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.setAutoGrowCollectionLimit(850);
	}

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private OrderService orderService;

	@Autowired
	private AccountService accountService;
	
	private List<DispatchSlip> dispatchSlipBeans;

	public List<DispatchSlip> getDispatchSlipBeans() {
		return dispatchSlipBeans;
	}

	public void setDispatchSlipBeans(List<DispatchSlip> dispatchSlipBeans) {
		this.dispatchSlipBeans = dispatchSlipBeans;
	}

	private static List<RentedUpdate> rentedUpdates = new ArrayList<RentedUpdate>();
	private static List<PurchaseUpdate> paymentUpdates = new ArrayList<PurchaseUpdate>();

	/**
	 * Redirects to manage orders page
	 * 
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/manageOrders", method = RequestMethod.GET)
	public String manageOrders(ModelMap modelMap) {
		LOGGER.debug(" OrderController.manageOrders method: START ");
		return "ManageOrders";
	}

	@RequestMapping(value = "/rentedOrders", method = RequestMethod.GET)
	public String getRentedOrders(ModelMap modelMap) throws Exception {
		LOGGER.debug(" OrderController.getRentedOrders method: START ");
		modelMap.addAttribute("rentedOrdersList", orderDao.getRentedOrders());
		modelMap.addAttribute("rentedUpdateBeans", new ArrayList<RentedUpdate>());
		LOGGER.debug(" OrderController.getRentedOrders method: END ");
		return "RentedOrders";
	}

	@RequestMapping(value = "/purchaseOrders", method = RequestMethod.GET)
	public String getPurchasedOrders(ModelMap modelMap) throws Exception {
		LOGGER.debug(" OrderController.getPurchasedOrders method: START ");
		modelMap.addAttribute("purchasedOrdersList", orderDao.getPurchasedOrders());
		modelMap.addAttribute("purchaseUpdateBeans", new ArrayList<PurchaseUpdate>());
		LOGGER.debug(" OrderController.getPurchasedOrders method: END ");
		return "PurchaseOrders";
	}

	/**
	 * Processes the rent updation requests.
	 * 
	 * @param rentedUpdateArr
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateRent", method = RequestMethod.POST, params = "dispatch")
	public String dispatchOrder(@ModelAttribute("rentedUpdateForm") RentedUpdateForm rentedUpdateArr, ModelMap modelMap)
			throws Exception {
		System.out.println("hello");
		LOGGER.debug("dispatchOrder method: START");
		List<Integer> dispatchedOrders = null;
		if (rentedUpdateArr != null) {
			List<RentedUpdate> rentedUpdateList = rentedUpdateArr.getRentedUpdateList();
			OrderController.rentedUpdates = rentedUpdateList;
			dispatchedOrders = orderService.updateDispatch(rentedUpdateList);
		}
		modelMap.addAttribute("dispatchList", dispatchedOrders);
		LOGGER.debug("dispatchOrder method: END");
		return "redirect:/dispatchSlip";
	}

	@RequestMapping(value = "/updateRent", method = RequestMethod.POST, params = "return")
	public String returnOrder(@ModelAttribute("rentedUpdateForm") RentedUpdateForm rentedUpdateArr, ModelMap modelMap)
			throws SapeStoreException {
		System.out.println("hello");
		LOGGER.debug("returnOrder method: START");
		if (rentedUpdateArr != null) {
			System.out.println(rentedUpdateArr);
			List<RentedUpdate> rentedUpdateList = rentedUpdateArr.getRentedUpdateList();
			System.out.println(rentedUpdateList);
			orderService.updateReturn(rentedUpdateList);
		}
		LOGGER.debug("returnOrder method: END");
		return "redirect:/manageOrders";
	}

	@RequestMapping(value = "/updatePurchase", method = RequestMethod.POST, params = "dispatcha")
	public String dispatchpurchaseOrder(@ModelAttribute("purchaseUpdateForm") PurchaseUpdateForm purchaseUpdateArr,
			ModelMap modelMap) throws Exception {
		System.out.println("hello");
		LOGGER.debug("dispatchOrder method: START");
		List<Integer> dispatchedOrders = null;
		if (purchaseUpdateArr != null) {
			List<PurchaseUpdate> purchaseUpdateList = purchaseUpdateArr.getPaymentUpdateList();
			System.out.println(purchaseUpdateList);
			OrderController.paymentUpdates = purchaseUpdateList;
			dispatchedOrders = orderService.updatePurchaseDispatch(purchaseUpdateList);
			System.out.println(dispatchedOrders);
		}
		modelMap.addAttribute("dispatchLista", dispatchedOrders);
		LOGGER.debug("dispatchOrder method: END");
		return "redirect:/dispatchSlipa";

	}

	@RequestMapping(value = "/updatePurchase", method = RequestMethod.POST, params = "purchase")
	public String purchaseOrder(@ModelAttribute("purchaseUpdateForm") PurchaseUpdateForm purchasedUpdateArr,
			ModelMap modelMap) throws SapeStoreException {
		System.out.println("hello");
		LOGGER.debug("purchaseOrder method: START");
		if (purchasedUpdateArr != null) {
			System.out.println(purchasedUpdateArr);
			List<PurchaseUpdate> purchasedUpdateList = purchasedUpdateArr.getPaymentUpdateList();
			System.out.println("malvika");
			System.out.println(purchasedUpdateList);
			orderService.updatePayment(purchasedUpdateList);
		}
		LOGGER.debug("returnOrder method: END");
		return "redirect:/manageOrders";
	}

	@RequestMapping(value = "/dispatchSlipa", method = RequestMethod.GET)
	public String dispatchSlipi(@ModelAttribute("dispatchLista") List<Integer> dispatchLista, ModelMap modelMap)
			throws SapeStoreException {
		LOGGER.debug("dispatchSlip method: START");
		List<Integer> lista = dispatchLista;
		List<DispatchSlip> dispatchSlipsa = null;
		try {
			dispatchSlipsa = orderService.getDispatchedOrders(lista);
			System.out.println(dispatchSlipsa);
		} catch (SapeStoreSystemException e) {
			LOGGER.error("dispatchSlip method: ERROR: " + e);
			return ApplicationConstants.FAILURE;
		}
		modelMap.addAttribute("dispatchSlipsa", dispatchSlipsa);
		this.setDispatchSlipBeans(dispatchSlipsa);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("dispatchSlip method: END");
		}
		return "DispatchResultpurchase";
	}

	@RequestMapping(value = "/rentApprovals", method = RequestMethod.GET)
	public String getRentOrders(ModelMap modelMap) throws Exception {
		modelMap.addAttribute("rentedOrdersList1", orderDao.getPendingOrder());
		return "RentApproval";
	}

	@RequestMapping(value = "/approveRent", method = RequestMethod.POST)
	public String approveOrder(@RequestParam("acceptList") String accept, @RequestParam("rejectList") String reject,
			ModelMap modelMap) throws Exception {

		String a[] = accept.split(" ");
		String r[] = reject.split(" ");

		if (a.length != 0) {
			orderService.approveReturn(a);
		}
		if (r.length != 0) {
			orderService.disapproveReturn(r);
		}

		return "ManageOrders";
	}

	/*
	 * @RequestMapping(value = "/updatePurchase", method = RequestMethod.POST,
	 * params="dispatch") public String
	 * dispatchPurchasedOrder(@ModelAttribute("purchaseUpdateForm")
	 * PurchaseUpdateForm paymentUpdateArr,ModelMap modelMap) throws Exception {
	 * LOGGER.debug("dispatchOrder method: START"); List<Integer>
	 * dispatchedOrders = null; if (paymentUpdateArr != null) {
	 * List<PurchaseUpdate> paymentUpdateList =
	 * paymentUpdateArr.getPaymentUpdateList(); OrderController.paymentUpdates =
	 * paymentUpdateList; dispatchedOrders =
	 * orderService.updatePurchaseDispatch(paymentUpdateList); }
	 * modelMap.addAttribute("dispatchList", dispatchedOrders); LOGGER.debug(
	 * "dispatchOrder method: END"); return "redirect:/dispatchSlip"; }
	 * 
	 * @RequestMapping(value = "/updatePurchase", method = RequestMethod.POST,
	 * params="purchase") public String
	 * purchaseOrder(@ModelAttribute("purchaseUpdateForm") PurchaseUpdateForm
	 * paymentUpdateArr,ModelMap modelMap) throws SapeStoreException {
	 * LOGGER.debug("paymentOrder method: START"); if(paymentUpdateArr != null){
	 * //System.out.println("Ello" + paymentUpdateArr.getPaymentUpdateList());
	 * List<PurchaseUpdate> paymentUpdateList =
	 * paymentUpdateArr.getPaymentUpdateList(); for(PurchaseUpdate
	 * p:paymentUpdateList){ System.out.println(p); }
	 * System.out.println("malu");
	 * orderService.updatePayment(paymentUpdateList); } LOGGER.debug(
	 * "returnOrder method: END"); return "redirect:/manageOrders"; }
	 */
	/**
	 * Processes the requests for Dispatch Slip.
	 * 
	 * @param dispatchList
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dispatchSlip", method = RequestMethod.GET)
	public String dispatchSlip(@ModelAttribute("dispatchList") List<Integer> dispatchList, ModelMap modelMap)
			throws SapeStoreException {
		LOGGER.debug("dispatchSlip method: START");
		List<Integer> list = dispatchList;
		List<DispatchSlip> dispatchSlips = null;
		try {
			dispatchSlips = orderService.getDispatchedOrders(list);
		} catch (SapeStoreSystemException e) {
			LOGGER.error("dispatchSlip method: ERROR: " + e);
			return ApplicationConstants.FAILURE;
		}
		modelMap.addAttribute("dispatchSlips", dispatchSlips);
		this.setDispatchSlipBeans(dispatchSlips);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("dispatchSlip method: END");
		}
		return "DispatchResult";
	}

	@RequestMapping(value = "/getStatusPage", method = RequestMethod.GET)
	public String getStatusPage() {
		LOGGER.debug("getStatusPage method: START");
		LOGGER.debug("getStatusPage method: END");
		return "orderstatus";
	}

	@RequestMapping(value = "/trackOrder", method = RequestMethod.GET)
	public String trackOrder(@RequestParam("orderId") Integer orderId, Model model) throws SapeStoreException {
		LOGGER.debug("trackOrder method: START");
		List<OrderItemInfo> itemsList = orderService.orderStatusTracker(orderId);
		OrderInfo orderDispatch = orderService.orderStatusTrackerDispatcher(orderId);
		System.out.println(orderDispatch);
		if (itemsList.size() != 0) {

			model.addAttribute("orderId", orderId);
			model.addAttribute("itemsList", itemsList);
			model.addAttribute("dispatchStatus", orderDispatch.getOrderStatus());
			LOGGER.debug("trackOrder method: END");
			return "statussuccess";

		} else {
			model.addAttribute("orderId", orderId);
			LOGGER.debug("trackOrder method: END");
			return "statuserror";
		}

	}

	@RequestMapping(value = "/trackOrderType", method = RequestMethod.GET)
	public String trackOrderType(HttpSession session, @ModelAttribute("orderType") String orderType, Model model)
			throws SapeStoreException {
		LOGGER.debug("trackOrderType method: START");
		String userId = (String) session.getAttribute("userId");
		int f = 0;
		if (userId == null) {
			return "redirect:/";
		} else {
			List<List<OrderItemInfo>> listOflist = orderService.orderStatusTrackerbyType(orderType, userId);
			for (List<OrderItemInfo> orders : listOflist) {
				for (OrderItemInfo order : orders) {
					if (order.getOrderStatus().equals("true")) {
						order.setOrderStatus("DISPATCHED");
					} else if (order.getOrderStatus().equals("false")) {
						order.setOrderStatus("NOT_DISPATCHED");
					} else {
						order.setOrderStatus("PARTIALLY_DISPATCHED");
					}
				}
			}
			System.out.println(listOflist);
			for (List<OrderItemInfo> il : listOflist) {
				for (OrderItemInfo oi : il) {
					if ((oi.getPurchaseType().toLowerCase()).equals(orderType.toLowerCase()))
						f = 1;
				}
			}

			if (f == 1) {
				model.addAttribute("orderType", orderType);
				model.addAttribute("listOflist", listOflist);
				return "statussuccess1";

			} else {
				model.addAttribute("orderType", orderType);
				return "statuserror1";
			}

		}

	}

	/*
	 * @RequestMapping(value = "/orderConfirmation", method = RequestMethod.GET)
	 * public String orderConfirm(@ModelAttribute("username")String
	 * username,@ModelAttribute("orderId")Integer
	 * orderId,@ModelAttribute("ShoppingCart")ShoppingCartVO
	 * shoppingCart,HttpSession session,BindingResult result,ModelMap modelMap)
	 * throws SapeStoreException{ if(result.hasErrors()){ return "addressPage";
	 * } String userId=null; Address address=null;
	 * 
	 * userId=(String) session.getAttribute("userId"); List<Book>
	 * items=orderService.getItemsInOrder(orderId);
	 * 
	 * address=orderService.getShippingAddress(userId);
	 * 
	 * City city=orderService.getCityById(address.getCityId()); State
	 * state=orderService.getStateById(address.getStateId());
	 * List<OrderItemInfo> itemsInfo=orderService.getOrderInfo(orderId);
	 * modelMap.addAttribute("itemsInfo", itemsInfo);
	 * modelMap.addAttribute("items", items);
	 * modelMap.addAttribute("shippingAddress", address);
	 * modelMap.addAttribute("username", address.getName());
	 * modelMap.addAttribute("city", city); modelMap.addAttribute("state",
	 * state);
	 * 
	 * return "orderConfirmation"; }
	 */

	@RequestMapping("/shippingAddressForm")
	public String editAddressForm(HttpSession session, ModelMap model) throws SapeStoreException {

		LOGGER.debug("editAddressForm method in Order Controller: START");
		String userId = (String) session.getAttribute("userId");
		if(userId==null){
			userId="111";
		}
		Address address = null;
		orderDao.getNameByUserId(userId);
		address = orderDao.getAddressByUser(userId);
		City city = new City();
		State state = new State();
		Country country = new Country();
		city = orderDao.getCityById(address.getCityId());
		state = orderDao.getStateById(address.getStateId());
		country = orderDao.getCountryById(state.getCountryId());
		AddressComplete addressComplete = new AddressComplete();
		
		addressComplete.setAddress(address);
		addressComplete.setCity(city);
		addressComplete.setState(state);
		addressComplete.setCountry(country); 

		populateForm(model, state);
		model.addAttribute("addressComplete", addressComplete);
		LOGGER.debug("editAddressForm method in Order Controller: END");
		return "addressPage";
	}

	@RequestMapping("/shippingAddress")
	public String editAddress(@ModelAttribute("addressComplete") AddressComplete addressComplete, HttpSession session,
			BindingResult result, ModelMap modelMap) throws SapeStoreException {
		LOGGER.debug("editAddress method in Order Controller: START");
		if (result.hasErrors()) {
			return "DisplayShoppingCart";
		} else {
			Address address = new Address();
			address = addressComplete.getAddress();
			
			String cityName = addressComplete.getCity().getCityName().toUpperCase();
			Integer cityIdInteger = orderDao.getCityIdByName(cityName);
			if(cityIdInteger==-5) {
				modelMap.addAttribute("wrongCity1", 1);
				return "addressPage";
			}
			address.setCityId(cityIdInteger);
			String stateName = addressComplete.getState().getStateName();
			

			address.setStateId(orderDao.getStateIdByName(stateName));
			address.setCountryId(orderDao.getCountryIdByName(stateName));
			Address address2 = orderDao.getAddressByUser(address.getUserId());
			address2.setName(orderDao.getNameByAddressId(address2.getAddressId()));

			address.setName(address2.getName());
			address.setCreatedDate(address2.getCreatedDate());
			address.setUpdatedDate(address2.getUpdatedDate());
			address.setIsActive(address2.getIsActive());
			orderDao.editAddress(address);

			String userId = (String) session.getAttribute("userId");
			if(userId==null)
				userId="111";
			ShoppingCartVO shoppingCart = (ShoppingCartVO) session.getAttribute("ShoppingCart");

			Integer orderId = (Integer) session.getAttribute("orderId");
			if (shoppingCart.getTotalQuantity() != 0) {
				orderId = orderService.giveOrder(shoppingCart, userId);
			}
			if (shoppingCart.getTotalQuantity() != 0) {
				orderService.sendMail(userId, shoppingCart, address);
				User user=accountService.getUserInfo(userId);
				String message="Your order is confirmed.\n"+"Order No: "+orderId+"\nTotal Amount: "+shoppingCart.getTotalPrice()+"\nThank you for shopping with us.\nSapeStore Co.";
				orderService.sendSms(user.getMobileNumber(), message);
			}
			modelMap.addAttribute("totalPrice",shoppingCart.getTotalPrice());
			shoppingCart.makeCartNull();
			modelMap.addAttribute("orderId", orderId);
			List<Book> items = orderService.getItemsInOrder(orderId);
			address = orderService.getShippingAddress(userId);
			address.setName(orderDao.getNameByAddressId(address.getAddressId()));

			City city = orderService.getCityById(address.getCityId());
			State state = orderService.getStateById(address.getStateId());

			List<OrderItemInfo> itemsInfo = orderService.getOrderInfo(orderId);

			modelMap.addAttribute("itemsInfo", itemsInfo);
			modelMap.addAttribute("items", items);
			modelMap.addAttribute("shippingAddress", address);
			// modelMap.addAttribute("postalCode", address.getPostalCode());
			modelMap.addAttribute("username", address.getName());
			modelMap.addAttribute("city", city);
			modelMap.addAttribute("state", state);
		
			session.setAttribute("itemsInfo", itemsInfo);
			session.setAttribute("items", items);

			LOGGER.debug("editAddress method in Order Controller: END");
			return "orderConfirmation";
		}
	}

	@RequestMapping("/getCitiesShippingAddress")
	public String getCitiesSignUp(@RequestParam("cusName") String cusName, @RequestParam("statename") String stateName,
			@RequestParam("addrId") Integer addrId, @RequestParam("userId") String userId,
			@RequestParam("add1") String addressLine1, @RequestParam("add2") String addressLine2,
			@RequestParam("postalcode") String zipcode, @RequestParam("mobile") String mobile,
			@RequestParam("phone") String phone, HttpSession session, ModelMap model) throws SapeStoreException {

		Address address = new Address();
		address.setName(cusName);
		address.setAddressLine1(addressLine1);
		address.setAddressLine2(addressLine2);
		address.setPostalCode(zipcode);
		address.setAddressId(addrId);
		address.setUserId(userId);
		address.setMobileNumber(mobile);
		address.setPhone(phone);
		address.setStateId(orderDao.getStateIdByName(stateName));
		address.setCountryId(orderDao.getCountryIdByName(stateName));
		Address address2 = orderDao.getAddressByUser(address.getUserId());
		address2.setName(orderDao.getNameByAddressId(address2.getAddressId()));
		address.setName(address2.getName());
		address.setCreatedDate(address2.getCreatedDate());
		address.setUpdatedDate(address2.getUpdatedDate());
		address.setIsActive(address2.getIsActive());

		AddressComplete addressComplete = new AddressComplete();
		addressComplete.setState(orderDao.getStateByName(stateName));

		List<String> stateNames = new ArrayList<String>();
		stateNames = orderDao.getStateNames();
		List<String> cityNames = new ArrayList<String>();
		State state = new State();
		state = orderDao.getStateByName(stateName);
		Integer stateId = state.getStateId();
		cityNames = orderDao.getCityNamesByState(stateId);

		String cityN = cityNames.get(0);
		addressComplete.setCity(orderDao.getCityById(orderDao.getCityIdByName(cityN)));
		addressComplete.setAddress(address);

		model.addAttribute("cityValues", cityNames);
		model.addAttribute("stateValues", stateNames);
		model.addAttribute("addressComplete", addressComplete);
		return "addressPage";
	}

	private void populateForm(ModelMap model, State state) throws SapeStoreException {
		// TODO Auto-generated method stub
		LOGGER.debug("populateForm method in Order Controller: START");

		List<String> stateName = new ArrayList<String>();
		stateName = orderDao.getStateNames();
		model.addAttribute("stateValues", stateName);

		Integer stateId;
		stateId = state.getStateId();

		List<String> cityName = new ArrayList<String>();
		cityName = orderDao.getCityNamesByState(stateId);

		model.addAttribute("cityValues", cityName);
		LOGGER.debug("populateForm method in Order Controller: END");
	}
}
