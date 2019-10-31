package com.sapestore.service.impl;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.TransactionDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.hibernate.entity.User;
import com.sapestore.service.TransactionService;
import com.sapestore.vo.Transaction;

@Service
@Transactional
public class TransactionServiceImpl implements TransactionService {

	@Autowired
	TransactionDao transactionDAO;

	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AccountServiceImpl.class.getName());

	@Override
	public List<Transaction> getTransactions(User user) throws SapeStoreException, ParseException {
		LOGGER.debug("TransactionService : Calling DAO");
		return transactionDAO.getTransactions(user);

	}

}
