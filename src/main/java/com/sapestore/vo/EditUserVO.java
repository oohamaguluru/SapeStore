package com.sapestore.vo;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Component;

import com.sapestore.hibernate.entity.Address;
import com.sapestore.hibernate.entity.User;

/**
* Bean class for adding a book. 
 *
* CHANGE LOG
*      VERSION    DATE          AUTHOR       MESSAGE               
 *        1.0    20-06-2014     shivagowtham      Initial version
*/
@Component
public class EditUserVO implements Serializable {
       
       /**
       * 
        */
       private static final long serialVersionUID =  -3972545417811168092L;
       User user;
       Address address;
       List<String> stateNames;
       List<String> cityNames;
       
       public List<String> getStateNames() {
              return stateNames;
       }
       public void setStateNames(List<String> stateNames) {
              this.stateNames = stateNames;
       }
       public List<String> getCityNames() {
              return cityNames;
       }
       public void setCityNames(List<String> cityNames) {
              this.cityNames = cityNames;
       }
       public static long getSerialversionuid() {
              return serialVersionUID;
       }
       public User getUser() {
              return user;
       }
       public void setUser(User user) {
              this.user = user;
       }
       public Address getAddress() {
              return address;
       }
       public void setAddress(Address address) {
              this.address = address;
       }
       @Override
       public String toString() {
              return "EditUserVO [user=" + user + ", address=" + address + ", stateNames=" + stateNames + ", cityNames="
                           + cityNames + "]";
       }
       
}

