package com.sapestore.service;

import java.text.ParseException;
import java.util.List;

import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.User;
import com.sapestore.vo.Transaction;

public interface TransactionService {
	
	List<Transaction> getTransactions(User user) throws SapeStoreException, ParseException;
	
}
