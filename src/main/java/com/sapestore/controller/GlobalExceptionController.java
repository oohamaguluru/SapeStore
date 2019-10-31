package com.sapestore.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.sapestore.exception.HTTPNotFoundException;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.exception.SapeStoreSystemException;


@ControllerAdvice
public class GlobalExceptionController {
	@ExceptionHandler(SapeStoreException.class)
	public String sapestoreExceptionFuntion(SapeStoreException exception){
		return "errorPage";
	}
	@ExceptionHandler(SapeStoreSystemException.class)
	public String sapeStoreSystemExceptionFunction(SapeStoreSystemException exception){
		return "errorPage";
	}

/*	@ExceptionHandler(HTTPNotFoundException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public String processException(HTTPNotFoundException ex){
		return "errorPage";
	}
	
	@ExceptionHandler(HTTPNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String notFound(HTTPNotFoundException ex){
		return "errorPage";
	}
	

@ExceptionHandler(NoResultException.class)
public ResponseEntity<Exception> handleNoResultException(
        NoResultException nre) {
    return new ResponseEntity<Exception>(HttpStatus.NOT_FOUND);
}


@ExceptionHandler(Exception.class)
public ResponseEntity<Exception> handleException(Exception e) {
    return new ResponseEntity<Exception>(e,
            HttpStatus.INTERNAL_SERVER_ERROR);
}*/


	}
