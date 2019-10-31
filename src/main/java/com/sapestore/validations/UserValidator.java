package com.sapestore.validations;



import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.sapestore.hibernate.entity.User;

@Component

public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> myclass) {

		return User.class.equals(myclass);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		// TODO Auto-generated method stub
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"userId","userID.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"name","name.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"password","password.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"addressId","address.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"mobileNumber","phoneNumber.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"emailAddress","emailAddress.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"userStatus","userStatus.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"createdDate","createdDate.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"updatedDate","updatedDate.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"isAdmin","isAdmin.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"isActive","isActive.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"phone","phone.required");
	}
	

}
