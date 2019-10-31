package com.sapestore.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.ProductDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.service.ShoppingCartService;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.ShoppingCartVO;

/**
 * Service class for Add to Cart functionality.
 * 
 * CHANGE LOG VERSION DATE AUTHOR MESSAGE 1.0 20-06-2014 SAPIENT Initial version
 */

@Service("shoppingCartService")
public class ShoppingCartServiceImpl implements ShoppingCartService {

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(ShoppingCartServiceImpl.class.getName());

	@Autowired
	private ProductDao productDao;

	@Override
	public ShoppingCartVO addBookToCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType)
			throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addBookToCart method: START");
		}
		BookVO addToCart = null;
		BookVO existingBookBean = null;
		BookVO bookPosition = null;
		BookVO bookOther = null;
		String otherType = null;
		if (purchaseType.equals("p")) {
			otherType = "r";
		} else {
			otherType = "p";
		}
		int quantity = 0;
		int dbQuantity = 0;
		List<BookVO> cartBooks = null;

		addToCart = this.getBookInfo(isbn);
		if(addToCart.getQuantity()<=0){
			return shoppingCart;
		}
		if (shoppingCart != null) {

			cartBooks = shoppingCart.getBooksInCart();
			bookPosition = checkCartList(cartBooks, isbn, purchaseType);
			bookOther = checkCartList(cartBooks, isbn, otherType);
			if (bookPosition == null && bookOther == null) {
				addToCart.setCartQuantity(++quantity);
				addToCart.setPurchaseType(purchaseType);
				shoppingCart.setDate(addToCart);
				shoppingCart.setBooksInCart(addToCart);
			} else if (bookPosition != null && bookOther == null) {
				existingBookBean = bookPosition;
				quantity = existingBookBean.getCartQuantity();
				dbQuantity = existingBookBean.getQuantity();
				if (/*quantity <= 4 &&*/ quantity < dbQuantity) {
					shoppingCart.getBooksInCart().remove(bookPosition);
					existingBookBean.setCartQuantity(++quantity);
					shoppingCart.setDate(existingBookBean);
					shoppingCart.setBooksInCart(existingBookBean);
				}
			} else if (bookPosition == null && bookOther != null) {
				quantity = bookOther.getCartQuantity();
				dbQuantity = bookOther.getQuantity();
				if (quantity < dbQuantity) {
					existingBookBean = this.getBookInfo(isbn);
					existingBookBean.setCartQuantity(1);
					existingBookBean.setPurchaseType(purchaseType);
					shoppingCart.setDate(existingBookBean);
					shoppingCart.setBooksInCart(existingBookBean);
				}
			} else {
				existingBookBean = bookPosition;
				int bookOtherQua = bookOther.getCartQuantity();
				dbQuantity = bookPosition.getQuantity();
				quantity = bookPosition.getCartQuantity();
				int totalQua = quantity + bookOtherQua;
				if (/*quantity <= 4 &&*/ totalQua < dbQuantity) {
					shoppingCart.getBooksInCart().remove(bookPosition);
					existingBookBean.setCartQuantity(++quantity);
					shoppingCart.setDate(existingBookBean);
					shoppingCart.setBooksInCart(existingBookBean);
				}

			}
		} else {
			shoppingCart = new ShoppingCartVO(); 
			addToCart.setCartQuantity(++quantity);
			addToCart.setPurchaseType(purchaseType);
			//shoppingCart.setDate(existingBookBean);
			shoppingCart.setBooksInCart(addToCart);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("addBookToCart method: END");
		}
		return shoppingCart;
	}

	@Override
	public ShoppingCartVO updateType(ShoppingCartVO shoppingCart, String isbn, String purchaseType)
			throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateType method: START");
		}
		BookVO bookPosition = null;
		BookVO bookOther = null;
		BookVO updateBook = null;
		String otherType = null;
		if (purchaseType.equals("p")) {
			otherType = "r";
		} else {
			otherType = "p";
		}
		int quantity = 0;
		int dbQuantity = 0;
		bookPosition = checkCartList(shoppingCart.getBooksInCart(), isbn, purchaseType);
		bookOther = checkCartList(shoppingCart.getBooksInCart(), isbn, otherType);

		if (bookPosition == null) {
			LOGGER.error("Book not found to update type");
			throw new SapeStoreException("Book not found to update type");
		}

		if (bookOther != null) {
			updateBook = bookPosition;
			int bookOtherQua = bookOther.getCartQuantity();
			dbQuantity = bookPosition.getQuantity();
			quantity = bookPosition.getCartQuantity();
			int totalQua = quantity + bookOtherQua;
			if (/*totalQua <= 4 && */totalQua <= dbQuantity) {
				shoppingCart.getBooksInCart().remove(bookPosition);
				bookOther.setCartQuantity(totalQua);
			}/*else {
				shoppingCart.getBooksInCart().remove(bookPosition);
				bookOther.setCartQuantity(5);
				int totalquantity = shoppingCart.getTotalQuantity() + 5- (bookOtherQua + quantity);
				shoppingCart.setTotalQuantity(totalquantity);
			}*/
		} else {
			updateBook = bookPosition;
			shoppingCart.getBooksInCart().remove(bookPosition);
			updateBook.setPurchaseType(otherType);
			shoppingCart.setDate(updateBook);
			shoppingCart.setBooksForUpdate(updateBook);

		}
		
		shoppingCart.changeTotal(shoppingCart.getBooksInCart());
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateType method: END");
		}
		return shoppingCart;
	}

	private BookVO checkCartList(List<BookVO> cartBooks, String isbn, String purchaseType) {
		for (BookVO book : cartBooks) {
			if (book.getIsbn().equals(isbn) && book.getPurchaseType().equals(purchaseType)) {
				return book;
			}
		}
		return null;
	}

	/**
	 * Get book information on the basis of the ISBN provided
	 * 
	 * @param isbn
	 * @return
	 * @throws SapeStoreSystemException
	 */
	private BookVO getBookInfo(String isbn) throws SapeStoreException {
		LOGGER.debug("getBookInfo method: START");
		BookVO addToCartbean = null;
		addToCartbean = productDao.getBookDetails(isbn);
		LOGGER.debug("getBookInfo method: END");
		return addToCartbean;
	}

	@Override
	public ShoppingCartVO deleteFromCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType)
			throws SapeStoreException {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("deleteFromCart method: START");
		}
		BookVO deleteBook = checkCartList(shoppingCart.getBooksInCart(), isbn, purchaseType);
		if (deleteBook == null) {
			LOGGER.error("Book not found to delete quantity");
			throw new SapeStoreException("Book not found in cart");
		}

		int delquantity = deleteBook.getCartQuantity();
		int totalquantity = shoppingCart.getTotalQuantity() - delquantity;
		shoppingCart.setTotalQuantity(totalquantity);
		shoppingCart.getBooksInCart().remove(deleteBook);

		if (shoppingCart.getBooksInCart().size() == 0) {
			shoppingCart.makeCartNull();
		}
		
		shoppingCart.changeTotal(shoppingCart.getBooksInCart());
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("deleteFromCart method: END");
		}
		return shoppingCart;
	}

	@Override
	public ShoppingCartVO updateCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType)
			throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateCart method: START");
		}
		BookVO updateBook = null;
		int quantity = 0;
		int dbQuantity = 0;
		BookVO bookOther = null;
	
		String otherType = null;
		if (purchaseType.equals("p")) {
			otherType = "r";
		} else {
			otherType = "p";
		}
		updateBook = checkCartList(shoppingCart.getBooksInCart(), isbn, purchaseType);
		bookOther = checkCartList(shoppingCart.getBooksInCart(), isbn, otherType);

		if (updateBook == null) {
			LOGGER.error("Book not found to update quantity");
			throw new SapeStoreException("Book not found to add quantity");
		}
		quantity = updateBook.getCartQuantity();
		dbQuantity = updateBook.getQuantity();
		if(bookOther!=null){
			int otherQuantity = bookOther.getCartQuantity();		
			int totalQua = quantity + otherQuantity;
			if ((totalQua + 1 > dbQuantity) /*|| (quantity + 1 > 5)*/) {
				LOGGER.info("cannot add a quantity in service");

			} else {
				updateBook.setCartQuantity(++quantity);
				int updateQuantity = shoppingCart.getTotalQuantity() + 1;
				shoppingCart.setTotalQuantity(updateQuantity);
				LOGGER.info("done adding a quantity in service");
			}
		}else{
			if ((quantity + 1 > dbQuantity) /*|| (quantity + 1 > 5)*/) {
				LOGGER.info("cannot add a quantity in service");

			} else {
				updateBook.setCartQuantity(++quantity);
				int updateQuantity = shoppingCart.getTotalQuantity() + 1;
				shoppingCart.setTotalQuantity(updateQuantity);
				LOGGER.info("done adding a quantity in service");
			}
		}
		
		
		shoppingCart.changeTotal(shoppingCart.getBooksInCart());
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("updateCart method: END");
		}
		return shoppingCart;
		
	}

	@Override
	public ShoppingCartVO reduceCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType)
			throws SapeStoreException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("reduceCart method: START");
		}
		BookVO updateBook = null;
		int quantity = 0;
		updateBook = checkCartList(shoppingCart.getBooksInCart(), isbn, purchaseType);
	
		if (updateBook == null) {
			LOGGER.error("Book not found to reduce quantity");
			throw new SapeStoreException("Book not found to reduce quantity");
		}
		quantity = updateBook.getCartQuantity();
		if (quantity - 1 <= 0) {
			shoppingCart = deleteFromCart(shoppingCart, isbn, purchaseType);
			LOGGER.info("cant reduce quantity in service");
			return shoppingCart;
		} else {
			updateBook.setCartQuantity(--quantity);
			int updateQuantity = shoppingCart.getTotalQuantity() - 1;
			shoppingCart.setTotalQuantity(updateQuantity);
			
			shoppingCart.changeTotal(shoppingCart.getBooksInCart());
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("reduceCart method: END");
			}
			return shoppingCart;
		}
	}

}