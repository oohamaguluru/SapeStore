package com.sapestore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;
import com.sapestore.hibernate.entity.PayUser;
import com.sapestore.hibernate.entity.Transaction;
@SessionAttributes({"number","transaction","user"})
@Controller
public class PaymentController {
	
	@Autowired
	private RestTemplate restTemplate;
	
	@RequestMapping("/payhome")
	public String initialfunctions(ModelMap map,@RequestParam("phone") String phone,@RequestParam("password") String password){
		
		System.out.println("in sape controller");
		String bookurl = "http://10.150.222.109:8080/PaymentApp/logincheck/"+phone+"/"+password;
		
		PayUser loginuser = restTemplate.getForObject(bookurl, PayUser.class);
		System.out.println(loginuser);
		map.addAttribute("number",phone);
		map.addAttribute("user", loginuser);
		Transaction t=new Transaction();
		map.addAttribute("transaction", t);
		if(loginuser.getPhone()==0){
			map.addAttribute("status",1);
			System.out.println("status 1");
			return "payLogin";
		}
		if(loginuser.getName().equals("3")){
			map.addAttribute("status",3);
			System.out.println("status 3");
			return "payLogin";
		}
			return "payTransaction";
	}
	
	
	
	@RequestMapping("/profile")
	public String profilePage(){
		return "profile";
	}
	@RequestMapping("/payhome1")
	public String finalfunctions(){
			return "payHome";
	}
	@RequestMapping("/loginpay")
	public String loginpayfun(ModelMap map){
	return "payLogin";
	}
	@RequestMapping("/paytosomeone")
	public String initialpage(@ModelAttribute("number") String number,ModelMap map){
		Transaction t=new Transaction();
		map.addAttribute("transaction",t);
			return "payTransactionSape";
	}

	@RequestMapping("/sent")
	public String sentFunction(@ModelAttribute("number") String number,ModelMap map){
		String bookurl = "http://10.150.222.109:8080/PaymentApp/sentservice/"+number;
		List<Transaction> sent = restTemplate.getForObject(bookurl, List.class);
		System.out.println(sent);
		map.addAttribute("sentlist",sent);
			return "payShowSentList";
	}
	@RequestMapping("/received")
	public String receivedFunction(@ModelAttribute("number") String number,ModelMap map){
		String bookurl = "http://10.150.222.109:8080/PaymentApp/receiveservice/"+number;
		
		List<Transaction> receive = restTemplate.getForObject(bookurl, List.class);
		System.out.println(receive);
		map.addAttribute("reclist",receive);
			return "payShowRecList";
	}
	@RequestMapping("/payment")
	public String payFunction(@ModelAttribute("transaction")Transaction transaction,ModelMap map){
		System.out.println("in expense pay controller");
		PayUser user=(PayUser)map.get("user");
		System.out.println("user from session "+user);
		String bookurl = "http://10.150.222.109:8080/PaymentApp/payservice/"+transaction.getSender()+"/"+transaction.getReceiver()+"/"+transaction.getAmount();
		
		Integer transId=restTemplate.getForObject(bookurl, Integer.class);
		map.addAttribute("transId",transId);
		System.out.println("transaction id got "+transId);
		if(transId==-1){
			map.addAttribute("status", "number not found");
			System.out.println("number not found");
			
		}
		if(transId==-2){
			map.addAttribute("status","not enough balance");
			System.out.println("not enuf bal");
			
		}
		             
			return "payResult";
	}

	@RequestMapping("/start1")
	public String pay(){
		String bookurl = "http://localhost:8080/PaymentApp/pay";
			return "payShowSentList";
	}
	@RequestMapping("/payProfile")
	public String payProfileFun(){
			return "payProfile";
	}
	@RequestMapping("/addmoney")
	public String addMoneyPage(){
		return "bank";
	}
	@RequestMapping("/backfrompay")
	public String backFromPaying() {
		return "orderConfirmation";
	}	
	@RequestMapping("/paybanking")
	public String bankingPage(ModelMap map,@ModelAttribute("user") PayUser user,@RequestParam("cash") String cash,@RequestParam("card") String card,@RequestParam("exdate") String exdate,@RequestParam("cvv") String cvv){
		System.out.println("amt in bank "+cash);
		System.out.println("exdate"+exdate);
		System.out.println("in banking function"+cash+card);
		String bookurl = "http://10.150.222.109:8080/PaymentApp/banking/"+user.getPhone()+"/"+cash+"/"+card+"/"+exdate+"/"+cvv;
		Integer status = restTemplate.getForObject(bookurl, Integer.class);
			 if(status==1){
				 PayUser pu=user;
				 pu.setAmount(user.getAmount()+Double.parseDouble(cash));
				 map.addAttribute("user", pu);
				 return "bankSuccess";
			 }
			
			 else if(status==0){
				map.addAttribute("status", 0);
				 return "bankfail";
			 }
			 else if(status==-1){
				 map.addAttribute("status", -1);
				 return "bankfail";
			 }else if(status==-2){
				 map.addAttribute("status", -2);
				 return "bankfail";
			 }
			 else{
				 map.addAttribute("status", 2);
				 return "bankfail";
			 }
		
	}
}
