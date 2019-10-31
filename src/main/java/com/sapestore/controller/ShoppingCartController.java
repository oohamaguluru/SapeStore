package com.sapestore.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sapestore.common.ApplicationConstants;
import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.service.ShoppingCartService;
import com.sapestore.vo.ShoppingCartVO;
import com.sapestore.vo.UserVO;

/**
 * This is a controller class for the shopping cart.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Controller
@SessionAttributes("ShoppingCart")
public class ShoppingCartController {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(ShoppingCartController.class.getName());

	@Autowired(required = true)
	public ShoppingCartService shoppingCartService;

	/**
	 * Processes the Add to Cart requests.
	 * 
	 * @param categoryId
	 * @param categoryName
	 * @param checkMe
	 * @param isbn
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addToShoppingCart", method = RequestMethod.GET)
	public String addToShoppingCart(@RequestParam("categoryId") int categoryId,
			@RequestParam("categoryName") String categoryName, 
			@RequestParam(value = "checkMe", required = false) boolean checkMe, @RequestParam("isbn") String isbn,
			ModelMap modelMap, HttpServletRequest httpServletRequest, HttpSession httpSession) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: START");
		}
		
		ShoppingCartVO shoppingCart = null;
		String forwardStr = null;

		try {

			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			shoppingCart = shoppingCartService.addBookToCart(shoppingCart, isbn, "p");
			modelMap.addAttribute("ShoppingCart", shoppingCart);
			modelMap.addAttribute("userlogin", new UserVO());
			if (categoryName.equalsIgnoreCase("Top Rated")) {
				forwardStr = "redirect:/bookListByCat?categoryId=0&categoryName=Top Rated&checkMe="
						+ httpSession.getAttribute("checkMe");
			} else {
				forwardStr = "redirect:/bookListByCat?categoryId=" + categoryId + "&categoryName=" + categoryName
						+ "&checkMe=" + httpSession.getAttribute("checkMe");
			}
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("addToShoppingCart method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: END");
		}
		return forwardStr;

	}

	@RequestMapping(value = "/addDetailsToShoppingCart", method = RequestMethod.GET)
	
	public String addDetailsToShoppingCart(@RequestParam("categoryId") int categoryId,
			@RequestParam("categoryName") String categoryName,
			@RequestParam(value = "checkMe", required = false) boolean checkMe, @RequestParam("isbn") String isbn,
			@RequestParam("purchaseType") String purchaseType, ModelMap modelMap, HttpServletRequest httpServletRequest,
			HttpSession httpSession) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: START");
		}
		
		ShoppingCartVO shoppingCart = null;
		String forwardStr = null;

		try {

			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			shoppingCart = shoppingCartService.addBookToCart(shoppingCart, isbn, purchaseType);
			modelMap.addAttribute("ShoppingCart", shoppingCart);
			modelMap.addAttribute("userlogin", new UserVO());
			forwardStr = "redirect:/viewBookDetails?isbn=" + isbn;
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("addToShoppingCart method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: END");
		}

		return forwardStr;

	}

	@RequestMapping(value = "/deleteFromShoppingCart")
	public String deleteFromShoppingCart(@RequestParam(value = "isbn") String isbn,
			@RequestParam("purchaseType") String purchaseType, ModelMap modelMap) throws Exception {
		LOGGER.info("delete controller..");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: START");
		}
		ShoppingCartVO shoppingCart = null;
		String forwardStr = null;
		try {
			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			shoppingCart = shoppingCartService.deleteFromCart(shoppingCart, isbn, purchaseType);
			modelMap.addAttribute("ShoppingCart", shoppingCart);
			forwardStr = "DisplayShoppingCart";

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("addToShoppingCart method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: END");
		}
		return forwardStr;

	}

	@RequestMapping(value = "/updateQuantity")
	public String updateQuantityInCart(@RequestParam("isbn") String isbn, @RequestParam("purchaseType") String purchaseType,
			ModelMap modelMap) throws Exception {

		LOGGER.info("update controller..");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updatingCart method: START");
		}
		ShoppingCartVO shoppingCart = null;
		ShoppingCartVO checkCart = null;
		String forwardStr = null;
		try {
			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			checkCart = shoppingCartService.updateCart(shoppingCart, isbn, purchaseType);

			if (checkCart == null) {
				LOGGER.info("cannot add more quantity");
				forwardStr = "DisplayShoppingCart";
			} else {
				shoppingCart = checkCart;
				forwardStr = "DisplayShoppingCart";
				LOGGER.info("updated in controller..");
				modelMap.addAttribute("ShoppingCart", shoppingCart);

			}

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("updating method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updating method: END");
		}
		return forwardStr;
	}

	@RequestMapping(value = "/reduceQuantity")
	public String reduceQuantityInCart(@RequestParam("isbn") String isbn, @RequestParam("purchaseType") String purchaseType, ModelMap modelMap) throws Exception {

		LOGGER.info("reducing controller..");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("reducingCartQuantity method: START");
		}
		ShoppingCartVO shoppingCart = null;
		ShoppingCartVO checkCart = null;
		String forwardStr = null;
		try {
			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			checkCart = shoppingCartService.reduceCart(shoppingCart, isbn, purchaseType);

			if (checkCart == null) {
				LOGGER.info("cannot reduce more quantity");
				forwardStr = "DisplayShoppingCart";
			} else {
				shoppingCart = checkCart;
				forwardStr = "DisplayShoppingCart";
				LOGGER.info("Reducing controller..");
				modelMap.addAttribute("ShoppingCart", shoppingCart);
			}

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("Reducing method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Reducing method: END");
		}
		return forwardStr;
	}

	@RequestMapping("/updateType")
	public String changeTypeinCart(@RequestParam("isbn") String isbn, @RequestParam("purchaseType") String purchaseType,
			ModelMap modelMap) throws Exception {

		LOGGER.info("updating the type of Purchase");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("changeTypeinCart method: START");
		}
		ShoppingCartVO shoppingCart = null;
		ShoppingCartVO checkCart = null;
		String forwardStr = null;
		try {
			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			checkCart = shoppingCartService.updateType(shoppingCart, isbn, purchaseType);
			shoppingCart = checkCart;
			forwardStr = "DisplayShoppingCart";
			LOGGER.info("Updating the type controller..");
			modelMap.addAttribute("ShoppingCart", shoppingCart);

		} catch (SapeStoreSystemException ex) {
			LOGGER.error("Updating type method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Reducing method: END");
		}

		return forwardStr;
	}
	
	@RequestMapping(value = "/addToShoppingCartRent", method = RequestMethod.GET)
	public String addToShoppingCartRent(@RequestParam("categoryId") int categoryId,
			@RequestParam("categoryName") String categoryName, 
			@RequestParam(value = "checkMe", required = false) boolean checkMe, @RequestParam("isbn") String isbn,
			ModelMap modelMap, HttpServletRequest httpServletRequest, HttpSession httpSession) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: START");
		}
		
		ShoppingCartVO shoppingCart = null;
		String forwardStr = "redirect:/wishlistcontroller";

		try {

			shoppingCart = (ShoppingCartVO) modelMap.get("ShoppingCart");
			shoppingCart = shoppingCartService.addBookToCart(shoppingCart, isbn, "r");
			modelMap.addAttribute("ShoppingCart", shoppingCart);
			modelMap.addAttribute("userlogin", new UserVO());
			/*if (categoryName.equalsIgnoreCase("Top Rated")) {
				forwardStr = "redirect:/welcome?checkMe="
						+ httpSession.getAttribute("checkMe");
			} else {
				forwardStr = "redirect:/bookListByCat?categoryId=" + categoryId + "&categoryName=" + categoryName
						+ "&checkMe=" + httpSession.getAttribute("checkMe");
			}*/
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("addToShoppingCart method: ERROR: " + ex);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addToShoppingCart method: END");
		}
		return forwardStr;

	}

}