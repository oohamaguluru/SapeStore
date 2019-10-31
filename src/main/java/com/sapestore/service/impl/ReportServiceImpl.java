package com.sapestore.service.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.dao.ReportsDao;
import com.sapestore.exception.SapeStoreException;
import com.sapestore.service.ReportService;
import com.sapestore.vo.AdminDefaulterReport;
import com.sapestore.vo.LowInventoryBooksVO;
import com.sapestore.vo.ReportVO;

/**
 * Service class for Admin Report functionality.
 * 
 * CHANGE LOG 
 * VERSION 	DATE 		AUTHOR 	MESSAGE 
 * 1.0 		20-06-2014 	SAPIENT Initial version
 */

@Service("reportService")
public class ReportServiceImpl implements ReportService {
	
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(ReportServiceImpl.class.getName());
	
	@Autowired
	private ReportsDao reportsDao;

	@Override
	public List<ReportVO> getAdminReport() throws SapeStoreException {
		LOGGER.debug("getAdminReport method: START");
		List<ReportVO> adminReportList = null;
		adminReportList = reportsDao.getAdminReport();
		LOGGER.debug("getAdminReport method: END");
		return adminReportList;
	}
	
	@Override
	public List<ReportVO> getPurchasedRentedAdminReport() throws SapeStoreException {
		LOGGER.debug("getPurchasedRentedAdminReport method: START");
		List<ReportVO> adminReportsBeanList = null;
		adminReportsBeanList = reportsDao.getPurchasedRentedAdminReport();
		LOGGER.debug("getPurchasedRentedAdminReport method: END");
		return adminReportsBeanList;
	}
	
	@Override
	public List<AdminDefaulterReport> getDefaultersAdminReport() throws SapeStoreException {
		LOGGER.debug("getDefaultersAdminReport method: START");
		List<AdminDefaulterReport> adminReportsBeanList = null;
	adminReportsBeanList = reportsDao.getDefaultersAdminReport();
		LOGGER.debug("getDefaultersAdminReport method: END");
		Collections.sort(adminReportsBeanList, new Comparator<AdminDefaulterReport>(){
	    	   public int compare(AdminDefaulterReport o1, AdminDefaulterReport o2){
	    	      return  (int) (o1.getLateFee() - o2.getLateFee());
	    	   }
	    	});
		return adminReportsBeanList;
	}
	
	@Override
	public int getCategoryCount(int categoryId) throws SapeStoreException {
		LOGGER.debug("getCountAdminEmail method: START");
		int count = 0;
		count = reportsDao.getCategoryCount(categoryId);
		LOGGER.debug("getCountAdminEmail method: END");
		return count;
	}
	
	@Override
	public List<LowInventoryBooksVO> getLowInventoryBooks() {
		LOGGER.debug("LowInventoryBooks Service method: START");
		 List<LowInventoryBooksVO> bookList = null;
		bookList = reportsDao.getLowInventoryBooks();
		LOGGER.debug("LowInventoryBooks Service method: END");
		return bookList;
	}

}
