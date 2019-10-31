package com.sapestore.controller.test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import com.sapestore.controller.TransactionController;

/**
 * The class <code>AddToCartControllerTest</code> contains tests for the class
 * {@link <code>AddToCartController</code>}
 *
 * @pattern JUnit Test Case
 *
 * @generatedBy CodePro at 7/12/14 11:19 AM
 *
 * @author dashok
 *
 * @version $Revision$
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:test-application-context.xml" })
@WebAppConfiguration
public class TransactionControllerTest {
	
	 private MockMvc mockMvc;

	    @Autowired
	    private WebApplicationContext wac;

	    @Before
	    public void setup() {
	        
	    }

		/**
		 * The object that is being tested.
		 *
		 * @see com.sapestore.controller.TransactionController
		 */

	    private TransactionController fixture = new TransactionController();
	    
	    @Test
	    public void displayTransactionsTest() {
	    	try {
	    		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	    		mockMvc.perform(get("/transactionHistory").sessionAttr("userId", "Harsh")).andExpect(status().isOk()).andExpect(forwardedUrl("/transactionHistory.jsp"));
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    }
	    @Test
	    public void displayTransactionsTestFail() {
	    	try {
	    		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	    		mockMvc.perform(get("/transactionHistory")).andExpect(status().isOk()).andExpect(forwardedUrl("/transactionEmpty.jsp"));
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    }
}
