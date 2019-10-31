package com.sapestore.service;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.vo.ShoppingCartVO;

/**
 * Service interface for Add to Cart functionality.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

public interface ShoppingCartService {
	
	/**
	 * Adds books to cart
	 * @param shoppingCart
	 * @param isbn
	 * @return
	 * @throws SapeStoreSystemException
	 */

	ShoppingCartVO addBookToCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType) throws SapeStoreException;

	public ShoppingCartVO deleteFromCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType) throws SapeStoreException;

	ShoppingCartVO updateCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType) throws SapeStoreException;

	ShoppingCartVO reduceCart(ShoppingCartVO shoppingCart, String isbn, String purchaseType) throws SapeStoreException;
	
	ShoppingCartVO updateType(ShoppingCartVO shoppingCart, String isbn, String purchaseType) throws SapeStoreException;

}
