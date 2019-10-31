package com.sapestore.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.Book;
import com.sapestore.hibernate.entity.City;
import com.sapestore.hibernate.entity.Login;
import com.sapestore.hibernate.entity.ShoppingCart;
import com.sapestore.hibernate.entity.State;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.BookVO;
import com.sapestore.vo.EditUserVO;
import com.sapestore.vo.ShoppingCartVO;
import com.sun.mail.iap.ConnectionException;

/**
 * DAO class to fetch user's login details
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */
@Repository
public class AccountDao {

	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AccountDao.class.getName());
	
	public static final String SALT = "my-salt-text";
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	/**
	 * Method to fetch user login details based on the parameters provided.
	 * 
	 * @param userName
	 * @param password
	 * @return
	 * @throws ConnectionException
	 * @throws TransactionExecutionException
	 */
	@SuppressWarnings("unchecked")
	public User getUserDetails(String userId, String password) throws SapeStoreException{		
		LOGGER.debug("");
		String[] namedParams = {"userId","password"};
		String saltedPassword = SALT + password;
		String hashedPassword = generateHash(saltedPassword);
		Object[] paramValues = {userId,hashedPassword};	
		System.out.println(userId + password);
		List<User> listUser = (List<User>) hibernateTemplate.find("from User u where u.userId = ? and u.password = ?", paramValues);
		
		System.out.println("hello");
		
		
		if(listUser.size()!=0){
		User user = listUser.get(0);
		System.out.println("bye");
		System.out.println(user);
		return user;
		}
		else
		{
			System.out.println("cdjsbk");
		   return null;
			
	}}
	
	public static String generateHash(String input) {
		StringBuilder hash = new StringBuilder();

		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-1");
			byte[] hashedBytes = sha.digest(input.getBytes());
			char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
					'a', 'b', 'c', 'd', 'e', 'f' };
			for (int idx = 0; idx < hashedBytes.length; ++idx) {
				byte b = hashedBytes[idx];
				hash.append(digits[(b & 0xf0) >> 4]);
				hash.append(digits[b & 0x0f]);
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return hash.toString();
	}

	
    public boolean editProfile(EditUserVO editUserVO){
        User user = new User();
        
        user = editUserVO.getUser();
        String password = user.getPassword();
        String saltedPassword = SALT + password;
		String hashedPassword = generateHash(saltedPassword);
		user.setPassword(hashedPassword);
        Address address = new Address();
        address = editUserVO.getAddress();
        LOGGER.debug("In EditProfile DAO");
        hibernateTemplate.update(user);
        hibernateTemplate.update(address);
        return true;
 }
 public State getState(User user) {
        LOGGER.debug("In getState DAO");
        Address address=hibernateTemplate.get(Address.class, user.getAddressId());
        State state=hibernateTemplate.get(State.class,address.getStateId());
        return state;
 }
 public City getCity(User user) {
        LOGGER.debug("In getCity DAO");
        Address address=hibernateTemplate.get(Address.class, user.getAddressId());
        City city=hibernateTemplate.get(City.class,address.getCityId());
        return city;
 }
public String getAddressLine1(User user) {
 LOGGER.debug("In getAddressLine1 DAO");
 System.out.println(user);
 
 System.out.println(user.getAddressId());
 Address address=hibernateTemplate.get(Address.class, user.getAddressId());
 String addressLine1=address.getAddressLine1();  
 return addressLine1;
 }
public String getAddressLine2(User user) {
 LOGGER.debug("In getAddressLine2 DAO");
 Address address=hibernateTemplate.get(Address.class, user.getAddressId());
 String addressLine2=address.getAddressLine2();  
 return addressLine2;
 
}
public String getZipCode(User user) {
 LOGGER.debug("In getZipCode DAO");
 Address address=hibernateTemplate.get(Address.class, user.getAddressId());
 String zipCode=address.getPostalCode();  
 return zipCode;      

}
public List<String> getStateNames() {
 LOGGER.debug("In getStateNames DAO");
 List<State> stateList=(List<State>) hibernateTemplate.find("from State");
 List<String> stateNames=new ArrayList<>();
 for(State state:stateList)
 {
 String stateName=state.getStateName();
        stateNames.add(stateName);
 }
 return stateNames;
}
public List<String> getCityNames() {
 LOGGER.debug("In getCityNames DAO");
 List<String> cityNames=new ArrayList<>();
 List<City> cityList=(List<City>) hibernateTemplate.find("from City");
 for (City city:cityList)
 {
        String cityName=city.getCityName();
        cityNames.add(cityName);
 }
 return cityNames;
}

public User getUser(String userId) {
 List<User> userList = (List<User>) hibernateTemplate.find("from User u where u.userId = '" + userId +"'");
 User user = userList.get(0);
 return user;
}

public Address getAddress(Integer addressId) {
	return hibernateTemplate.get(Address.class, addressId);
}

public List<String> getCityByState(String state) {
	List<State> stateIds = (List<State>) hibernateTemplate.find("from State where stateName = '" + state + "'");
	State stateActual = stateIds.get(0);
	Integer stateId = stateActual.getStateId();
	List<City> cityList = (List<City>) hibernateTemplate.find("from City where stateId = '" + stateId + "'");
	List<String> cityNameList = new ArrayList<>();
	for(City city : cityList) {
		cityNameList.add(city.getCityName());
	}
	return cityNameList;
}

public boolean changePassword(String emailid, String password) {
	List<User> userList = new ArrayList<>();
	System.out.println(emailid + password + "IN DAAAAAAAAAAOOOOOOOOOOOOOOOOOO");
	emailid = emailid + ".com";
	userList = (List<User>) hibernateTemplate.find("from User u where u.emailAddress = '" + emailid + "'");
	User user = userList.get(0);
	user.setEmailAddress(emailid);
	String saltedPassword = SALT + password;
	String hashedPassword = generateHash(saltedPassword);
	user.setPassword(hashedPassword);
	hibernateTemplate.saveOrUpdate(user);
	return true;
}

public List<Integer> getStateAndCityIds(String cityName) {
	List<Integer> stateAndCity = new ArrayList<>();
	List<City> cityList = (List<City>) hibernateTemplate.find("from City c where c.cityName = '" +cityName + "'");
	City city = cityList.get(0);
	stateAndCity.add(city.getStateId());
	stateAndCity.add(city.getCityId());
	return stateAndCity;
}

public Integer getAddressId(Integer stateId, Integer cityId) {
	List<Integer> addressIdList = new ArrayList<>();
	Address address = new Address();
		List<Address> maxAddressList = (List<Address>) hibernateTemplate.find("from Address a order by a.addressId desc");
		Address maxAddress = maxAddressList.get(0);
		Integer addressId = maxAddress.getAddressId()+1;
		return addressId;
}

public boolean addProfile(EditUserVO editUserVO) {
	User user = editUserVO.getUser();
	Address address = editUserVO.getAddress();
	List<User> listUser = (List<User>) hibernateTemplate.find("from User u where u.userId = '" + user.getUserId() + "'");
	List<User> emailUser = (List<User>) hibernateTemplate.find("from User u where u.emailAddress = '" + user.getEmailAddress()+ "'");
	List<User> phUser = (List<User>) hibernateTemplate.find("from User u where u.mobileNumber = '" + user.getMobileNumber() + "'");
	if(listUser.size()==0 && emailUser.size()==0 && phUser.size()==0) {
		String saltedPassword = SALT + user.getPassword();
		String hashedPassword = generateHash(saltedPassword);
		user.setPassword(hashedPassword);
	hibernateTemplate.save(address);
	hibernateTemplate.save(user);
	return true;
	} else {
		return false;
	}
	
}
public boolean checkEmail(String email){
    
    List<User> emailUser = (List<User>) hibernateTemplate.find("from User u where u.emailAddress = '" + email+ "'");
    if(emailUser.size()==0){
    return false;
    }
    else 
           return true;
}



}
