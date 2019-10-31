package com.sapestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.AccountDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;
import com.sapestore.vo.EditUserVO;

/**
 * Service class for user login functionality.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

@Service("accountService")
public class AccountServiceImpl implements AccountService{
	
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AccountServiceImpl.class.getName());
	
	@Autowired
	private AccountDao accountDao;

	@Override
	public User authenticate(User userLogin) throws SapeStoreException {
		LOGGER.debug("authenticate method: START");
		System.out.println("service layer : " + userLogin.getUserId() + userLogin.getPassword());
	    User user = accountDao.getUserDetails(userLogin.getUserId(), userLogin.getPassword());
	 
		LOGGER.debug("authenticate method: END");
		return user;
	}
	public boolean editProfile(EditUserVO editUser){
        LOGGER.debug("edit method:START");
        boolean val=accountDao.editProfile(editUser);
        LOGGER.debug("edit method:END");
        return val;
 }
 public State getState(User user) {
        LOGGER.debug("getState method:START");
 State state=accountDao.getState(user);
 LOGGER.debug("getState method:END");
        return state;
 }

 public City getCity(User user) {
        LOGGER.debug("getState method:START");
        City city=accountDao.getCity(user);
        LOGGER.debug("getState method:END");
               return city;
 }
 @Override
 public String getAddressLine1(User user) {
        LOGGER.debug("getAddressLine1 method:START");
        String addressLine1=accountDao.getAddressLine1(user);
        LOGGER.debug("getAddressLine1 method:END");
        return addressLine1;
 }
 @Override
 public String getAddressLine2(User user) {
        LOGGER.debug("getAddressLine2 method:START");
        String addressLine2=accountDao.getAddressLine2(user);
        LOGGER.debug("getAddressLine1 method:END");
        return addressLine2;
 }
 @Override
 public String getZipCode(User user) {
        LOGGER.debug("getZipCode method:START");
        String zipCode=accountDao.getZipCode(user);
        LOGGER.debug("getZipCode method:STOP");
        return zipCode;
 }
 @Override
 public List<String> getStateNames() {
        LOGGER.debug("getStateNames method:START");
        List<String> stateNames=accountDao.getStateNames();
        LOGGER.debug("getStateNames method:STOP");
        return stateNames;
 }
 @Override
 public List<String> getCityNames() {
        LOGGER.debug("getCityNames method:START");
        List<String> cityNames=accountDao.getCityNames();
        LOGGER.debug("getCityNames method:STOP");
        return cityNames;
 }
 @Override
 public User getUserInfo(String userId) {
        return accountDao.getUser(userId);
 }
@Override
public Address getAddress(Integer addressId) {
	return accountDao.getAddress(addressId);
}
@Override
public String getPostalCode(User user) {
	return accountDao.getZipCode(user);
}
@Override
public List<String> getCityByState(String state) {
	return accountDao.getCityByState(state);
}
@Override
public boolean changePassword(String emailid, String password) {
	return accountDao.changePassword(emailid, password);
}
@Override
public List<Integer> getStateAndCityIds(String cityName) {
	return accountDao.getStateAndCityIds(cityName);
}
@Override
public Integer getAddressId(Integer stateId, Integer cityId) {
	return accountDao.getAddressId(stateId, cityId);
}
@Override
public boolean addProfile(EditUserVO editUserVO) {
	return accountDao.addProfile(editUserVO);
}

@Override
public boolean checkEmail(String email) {
       return accountDao.checkEmail(email);
}

       


}
