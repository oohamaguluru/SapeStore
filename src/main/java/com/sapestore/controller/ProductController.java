package com.sapestore.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sapestore.common.ApplicationConstants;
import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.BookCategory;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;
import com.sapestore.service.BookService;
import com.sapestore.service.InventoryService;
import com.sapestore.service.ProductService;
import com.sapestore.validations.FileValidator;
import com.sapestore.vo.BookVO;

/**
 * This is a controller class for loading the Add Books page.
 *
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Controller
public class ProductController {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(ProductController.class.getName());

	@Autowired
	private BookService bookService;

	@Autowired
	private ProductService productService;

	@Autowired
	private InventoryService inventoryService;
	
	@Autowired
	private AccountService as;

	@Autowired(required = false)
	ServletContext servletContext;

	/**
	 * Returns the add book page for the admin.
	 * 
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addBooksAdmin", method = RequestMethod.POST)
	public String addBooksAdmin(ModelMap modelMap) throws SapeStoreException {
		LOGGER.debug("addBooksAdmin method: START");
		modelMap.addAttribute("categoryList", bookService.getCategoryList());
		modelMap.addAttribute("addBooks", new BookVO());
		LOGGER.debug("addBooksAdmin method: END");
		return "addBooks";
	}

	/**
	 * Processes the add book requests.
	 * 
	 * @param addBooks
	 * @param bindingResult
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addBooks", method = RequestMethod.POST)
	public String addBooks(@Valid @ModelAttribute("addBooks") BookVO addBooks, BindingResult bindingResult,
			ModelMap modelMap) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addBooks method: START");
		}
		String isbn=addBooks.getIsbn();
        boolean flag=productService.validateisbn(isbn);
        if(addBooks.getThumbImage()!=null && !addBooks.getThumbImage().getOriginalFilename().equalsIgnoreCase(""))
       addBooks.setThumbPath(ApplicationConstants.THUMB_IMG_URL + addBooks.getThumbImage().getOriginalFilename());
        if(addBooks.getFullImage()!=null && !addBooks.getFullImage().getOriginalFilename().equalsIgnoreCase(""))
       addBooks.setFullPath(ApplicationConstants.FULL_IMG_URL + addBooks.getFullImage().getOriginalFilename());
        
		String forwardStr = null;
		String thumbPath = null;
		String fullPath = null;
		/*
		 * String thumbImageFileName = null; String fullImageFileName = null;
		 */
		if(!flag){
			  modelMap.addAttribute("errorsa","Please provide a unique isbn");
			  
					BookVO addBooks2 = (BookVO) addBooks;

					FileValidator fileValidator = new FileValidator();
					fileValidator.validate(addBooks, bindingResult);

					if (bindingResult.hasErrors()) {
						modelMap.addAttribute("categoryList", bookService.getCategoryList());
						modelMap.addAttribute("addBooks", addBooks2);
						
					}
			  
		forwardStr="addBooks";	
		
		}
		
			
		else if(flag){
		File thumbUploadDir = null;
		File fullUploadDir = null;
 
		try {
			BookVO addBooks2 = (BookVO) addBooks;
			FileValidator fileValidator = new FileValidator();
			fileValidator.validate(addBooks, bindingResult);

			if (bindingResult.hasErrors()) {
				modelMap.addAttribute("categoryList", bookService.getCategoryList());
				modelMap.addAttribute("addBooks", addBooks2);
				return "addBooks";
			}
			
			thumbPath = servletContext.getRealPath(ApplicationConstants.THUMB_IMG_URL);
			fullPath = servletContext.getRealPath(ApplicationConstants.FULL_IMG_URL);
			thumbUploadDir = new File(thumbPath);
			fullUploadDir = new File(fullPath);
			if (thumbUploadDir.exists() == false) {
				thumbUploadDir.mkdirs();
			}
			if (fullUploadDir.exists() == false) {
				fullUploadDir.mkdirs();
			}
			if (null != addBooks2) {
				/*
				 * thumbImageFileName = addBooks2.getThumbImageFileName();
				 * fullImageFileName = addBooks2.getFullImageFileName();
				 * 
				 * System.out.println(
				 * "---------------------thumbImageFileName--------------->"+
				 * thumbImageFileName); System.out.println(
				 * "---------------------fullImageFileName--------------->"+
				 * fullImageFileName);
				 */
/*
				if (null != addBooks2.getThumbImage()) {
					File thumbFile = new File(thumbPath, addBooks2.getThumbImage().getOriginalFilename());
					byte[] bytes = addBooks2.getThumbImage().getBytes();
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(thumbFile));
					stream.write(bytes);
					stream.close();
					addBooks2.setThumbPath(
							ApplicationConstants.THUMB_IMG_URL + addBooks2.getThumbImage().getOriginalFilename());
				}
				if (null != addBooks2.getFullImage()) {
					File largeFile = new File(fullPath, addBooks2.getFullImage().getOriginalFilename());
					byte[] bytes = addBooks2.getFullImage().getBytes();
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(largeFile));
					stream.write(bytes);
					stream.close();
					addBooks2.setFullPath(
							ApplicationConstants.FULL_IMG_URL + addBooks2.getFullImage().getOriginalFilename());
				}*/
				bookService.addBooks(addBooks2);
				forwardStr = "success";
			} else {
				forwardStr = ApplicationConstants.FAILURE;
			 }
		} catch (SapeStoreSystemException ex) {
			LOGGER.error("addBooks method: ERROR: " + ex);
			
			forwardStr = ApplicationConstants.FAILURE;
		} catch (Exception e) {
			LOGGER.error("addBooks method: ERROR: " + e);
			forwardStr = ApplicationConstants.FAILURE;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addBooks method: END");
		}
		}
		return forwardStr;
	}
	
	/**
	 * Processes the request for book deletion.
	 * 
	 * @param isbn
	 * @param modelMap
	 * @param redirectAttributes
	 * @return
	 * @throws SapeStoreSystemException
	 */
	@RequestMapping(value = "/deleteBook", method = RequestMethod.GET)
	public String deleteBook(@RequestParam("isbn") String isbn, ModelMap modelMap,
			final RedirectAttributes redirectAttributes, HttpSession session) throws SapeStoreException {
		LOGGER.debug("deleteBook method: START");
		int x1 =bookService.deleteBook(isbn);
		modelMap.addAttribute("testcase",x1);
		modelMap.addAttribute("adminInventoryList", inventoryService.getAdminInventory());
		redirectAttributes.addFlashAttribute("adminInventoryList", inventoryService.getAdminInventory());
		LOGGER.debug("deleteBook method: END");
		
		String userId = (String) session.getAttribute("userId");
        System.out.println(userId);
        
        if(userId == null){
               return "redirect:/";
        }else{
               
               User user = as.getUserInfo(userId);
               System.out.println(user.getIsAdmin());
               
               if(user.getIsAdmin() == null || user.getIsAdmin().equals("N")){
                     return "redirect:/";
               }else{
                     try {
                            modelMap.addAttribute("adminInventoryList",       inventoryService.getAdminInventory());
                     } catch (Exception ex) {
                            LOGGER.error("manageInventory method: ERROR: " + ex);
                            return ApplicationConstants.FAILURE;
                     }
                     LOGGER.debug("manageInventory method: END");
                     return "ManageInventory";
               }
               
        }
        
 }


	@RequestMapping(value = "/manageInv", method = RequestMethod.GET)
	public String deleteBookRedirect(ModelMap modelMap, HttpSession session) throws SapeStoreSystemException {
		
        String userId = (String) session.getAttribute("userId");
        
        
        if(userId == null){
               return "redirect:/";
        }else{
               User user = as.getUserInfo(userId);
               if(user.getIsAdmin() == null || user.getIsAdmin().equals("N")){
                     return "redirect:/";
               }else{
                     return "redirect:/manageInventory";
               }
               
        }

	}

	/**
	 * Processes the request for book edit page and returns the data for the
	 * book selected for edit operation
	 * 
	 * @param updateInventory
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editBooks", method = RequestMethod.POST, params = "editBook")
	public String editBooks(@ModelAttribute("updateBooks") BookVO updateInventory, ModelMap modelMap)
			throws SapeStoreException {
		LOGGER.debug("editBooks method: START");
		/*System.out.println("Update Inventory Object->CategoryName"+updateInventory.getCategoryName());
		System.out.println("Get CategoryList returns "+bookService.getCategoryList());
		
		List<BookCategory> CategoryListSwapped = bookService.getCategoryList();
		int swapIndex1=0;
		for(int i=0;i<CategoryListSwapped.size();i++){
			if(CategoryListSwapped.get(i).getCategoryName().equals(updateInventory.getCategoryName()))
			{
				swapIndex1=i;
			}
		}
		System.out.println(swapIndex1);
		BookCategory temp = new BookCategory();
		temp = CategoryListSwapped.get(0);
		System.out.println("Temp object "+temp);
		System.out.println("Obj to be swapped"+CategoryListSwapped.get(swapIndex1));
		CategoryListSwapped.set(0, CategoryListSwapped.get(swapIndex1));		
		CategoryListSwapped.set(swapIndex1,temp);
		modelMap.addAttribute("categoryList", CategoryListSwapped);*/
		
		List<String> YesNo = new ArrayList<String>();
		if(updateInventory.getRentAvailable().trim().equals("Y")){
			YesNo.add("Yes");
			YesNo.add("No");
		}
		else{
			YesNo.add("No");
			YesNo.add("Yes");
		}
		int catId=0;
		List<BookCategory> CategoryListSwapped = bookService.getCategoryList();
		for(int i=0;i<CategoryListSwapped.size();i++){
			if( CategoryListSwapped.get(i).getCategoryName().trim().equals(updateInventory.getCategoryName().trim()) )
			{
				catId=i;
				break;
			}
		}
		BookCategory obj = new BookCategory();
		obj.setCategoryName(updateInventory.getCategoryName());
		obj.setCategoryId(catId);
		updateInventory.setOldIsbn(updateInventory.getIsbn());
		List<BookCategory> CategoryListUpdated = bookService.getCategoryList();
		CategoryListUpdated.remove(catId);
		modelMap.addAttribute("categoryList", CategoryListUpdated);
		modelMap.addAttribute("updateBooks", updateInventory);
		modelMap.addAttribute("updateInv", new BookVO());
		modelMap.addAttribute("YesNo", YesNo);
		LOGGER.debug("editBooks method: END");
		return "EditResult";
	}

	@RequestMapping(value = "/editBooks", method = RequestMethod.POST, params = "delSubmit")
	public String deleteBooksRedirect(@ModelAttribute("updateBooks") BookVO updateInventory, ModelMap modelMap)
			throws SapeStoreException {
		LOGGER.debug("deleteBooksRedirect method: START");
		bookService.deleteBook(updateInventory.getIsbn());
		modelMap.addAttribute("adminInventoryList", inventoryService.getAdminInventory());
		LOGGER.debug("deleteBooksRedirect method: END");
		return "ManageInventory";
	}

}
