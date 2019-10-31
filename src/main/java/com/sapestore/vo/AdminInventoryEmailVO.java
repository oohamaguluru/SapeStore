
package com.sapestore.vo;

import java.io.StringWriter;
import java.util.List;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.*;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.sapestore.common.SapeStoreLogger;
import com.sapestore.service.ReportService;

public class AdminInventoryEmailVO{ 

	@Autowired
	private ReportService reportService;
	@Autowired
	private VelocityEngine velocityEngine;

	/**
	 * Logger for log messages.
	 */
	private final static SapeStoreLogger LOGGER = SapeStoreLogger.getLogger(AdminInventoryEmailVO.class.getName());

	@Scheduled(fixedRate = 86400000) // fixedDelay = 86400000 to schedule it for
										// a day

	public void perform() {

	LOGGER.debug("Inside Scheduler");

		String isbn[] = new String[100];

		String[] bookTitle = new String[50];

		List<LowInventoryBooksVO> bookList = reportService.getLowInventoryBooks();

		for (int i = 0; i < bookList.size(); i++) {
			isbn[i] = bookList.get(i).getIsbn();
			bookTitle[i] = bookList.get(i).getBookTitle();

		}

		for ( int j=0; j < bookList.size();j++){
    
    LOGGER.debug("The books are low in inventory:"+isbn[j]+ " "+bookTitle[j]);
		sendEmail(isbn[j],bookTitle[j]);
		
		}
		
	}
	 public void setVelocityEngine(VelocityEngine velocityEngine) {
		  this.velocityEngine = velocityEngine;
		 }

		
		public String sendEmail(String isbn, String bookTitle){
		
			String from = "admin@sapestore.com";
			String host = "inrelaymail.sapient.com";

			Properties properties = System.getProperties();
			properties.setProperty("mail.smtp.host", host);
			Session session = Session.getInstance(properties);

			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress("sapestorebook@gmail.com"));
				message.setSubject("Low Inventory Alert");
				Template template = velocityEngine.getTemplate("emailtemplate.vm" );

				  VelocityContext velocityContext = new VelocityContext();
				  velocityContext.put("isbn", isbn);
				  velocityContext.put("bookTitle", bookTitle);
				  
				  StringWriter stringWriter = new StringWriter();
				  
				  template.merge(velocityContext, stringWriter);
				  message.setText(stringWriter.toString());

				Transport.send(message);
			} catch (MessagingException mex) {

				LOGGER.error("Error in sending e-mail");

			}

			return "successmail";

		}
		
	
}