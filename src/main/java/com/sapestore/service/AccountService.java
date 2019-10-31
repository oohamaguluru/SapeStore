package com.sapestore.service;

import java.util.List;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.EditUserVO;

/**
 * Service interface for user login functionality.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

public interface AccountService {

	/**
	 * Performs user login authentication.
	 * @param userLogin
	 * @return
	 * @throws SapeStoreSystemException
	 */
	
	User authenticate(User user) throws SapeStoreException;
	public boolean editProfile(EditUserVO editUserVO);
    public State getState(User User);
    public City getCity(User user);
    public String getAddressLine1(User user);
    public String getAddressLine2(User user);
    public String getZipCode(User user);
    public List<String> getStateNames();
    public List<String> getCityNames();
    User getUserInfo(String userId);
	Address getAddress(Integer addressId);
	String getPostalCode(User user);
	List<String> getCityByState(String state);
	boolean changePassword(String emailid, String password);
	List<Integer> getStateAndCityIds(String cityName);
	Integer getAddressId(Integer stateId, Integer cityId);
	boolean addProfile(EditUserVO editUserVO);
	boolean checkEmail(String email);

	
}
