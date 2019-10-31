package com.sapestore.validations;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.sapestore.vo.BookVO;

public class FileValidator implements Validator{

	@Override
	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object arg0, Errors arg1) {


		  BookVO addBooks = (BookVO) arg0;

		  if (addBooks.getThumbPath()==null || addBooks.getThumbPath().equalsIgnoreCase("")) {
			  arg1.rejectValue("thumbImage", "id.thumbImage", new Object[] { "thumbImage" }, "Please provide book thumbnail image."); 
			  
		  }
		  
		  if (addBooks.getFullPath()==null || addBooks.getFullPath().equalsIgnoreCase("")) {
			  arg1.rejectValue("fullImage", "id.fullImage", new Object[] { "fullImage" }, "Please provide book detail image."); 

		  }
		  
		  if(addBooks.getBookTitle().length()>0)
		  {
		  String book1=addBooks.getBookTitle().trim();
		  if(book1.length()<=0)
		  {
			  
			  arg1.rejectValue("bookTitle", "id.bookTitle", new Object[] { "bookTitle" }, "Please provide a valid book title."); 

		  }}
		  if(addBooks.getBookAuthor().length()>0)
		  {
		  String book2=addBooks.getBookAuthor().trim();
		  if(book2.length()<=0)
		  {
			  arg1.rejectValue("bookAuthor", "id.bookAuthor", new Object[] { "bookAuthor" }, "Please provide a valid book author."); 

		  }}
		 
		  if(addBooks.getIsbn().length()>0)
		  {
		  String book3=addBooks.getIsbn().trim();
		  if(book3.length()<=0)
		  {
			  
			  arg1.rejectValue("isbn", "id.isbnab", new Object[] { "isbn" }, "Please provide a valid isbn."); 

		  }}
		  if(addBooks.getPublisherName().length()>0)
		  {
		  String book4=addBooks.getPublisherName().trim();
		  if(book4.length()<=0)
		  {
			  arg1.rejectValue("publisherName", "id.publisherName", new Object[] { "publisherName" }, "Please provide a valid publisherName."); 

		  }}
		  if(addBooks.getBookShortDesc().length()>0)
		  {
		  String book5=addBooks.getBookShortDesc().trim();
		  if(book5.length()<=0)
		  {
			  arg1.rejectValue("bookShortDesc", "id.bookShortDesc", new Object[] { "bookShortDesc" }, "Please provide a valid book short description."); 

		  }}
		  if(addBooks.getBookDetailDesc().length()>0)
		  {
		  String book6=addBooks.getBookDetailDesc().trim();
		  if(book6.length()<=0)
		  {
			  arg1.rejectValue("bookDetailDesc", "id.bookDetailDesc", new Object[] { "bookDetailDesc" }, "Please provide a valid book detail description."); 

		  }}
		  double cd=addBooks.getBookPrice();
		 if(cd<0){
			  arg1.rejectValue("bookPrice", "id.bookPrice", new Object[] { "bookPrice" }, "The price of the book cannot be negetive."); 

		 }
		 
		 double rprice=addBooks.getRentPrice();
		 if(addBooks.getRentAvailable().equalsIgnoreCase("Y")){
		 if(rprice<0){
			 arg1.rejectValue("rentPrice", "id.rentPrice", new Object[] { "rentPrice" }, "The price of the rent cannot be negetive."); 
		 }
		 }
		 if((addBooks.getBookPrice()>0)&&(addBooks.getRentPrice()>0)){
		 if(addBooks.getRentAvailable().equalsIgnoreCase("Y")){
		  if(addBooks.getBookPrice()<addBooks.getRentPrice()){
			  arg1.rejectValue("rentPrice", "id.rentPriceac", new Object[] { "rentPrice" }, "Rent Price cannot be greater than the Selling Price."); 
		  }}}
		     if(addBooks.getRentAvailable().equalsIgnoreCase("Y")){
			if(addBooks.getRentPrice()==0){
				 arg1.rejectValue("rentPrice", "id.rentPricead", new Object[] { "rentPrice" }, "Please provide the rent price."); 
			}}
			  if(addBooks.getBookPrice()==0){
				  arg1.rejectValue("bookPrice", "id.bookPriceab", new Object[] { "bookPrice" }, "Please provide the price of the book"); 
		}
			  if(addBooks.getQuantity()==0){
				  arg1.rejectValue("quantity","id.quantity", new Object[] { "quantity" },"Please provide the quantity of the book."); 
		}
			  if(addBooks.getIsbn().length()>0){
				  
			  
			  if(addBooks.getIsbn().length()!=13){
				/*  arg1.rejectValue("isbn","addBooks.isbn","Isbn should be 13 digits");*/
				  arg1.rejectValue("isbn", "id.isbn", new Object[] { "isbn" }, "isbn should be 13 digits."); 
			  }}
			  
			  double d=addBooks.getBookPrice();
			  String bob=Double.toString(d);
			  String[] convert=bob.split("\\.");
			  if(convert[1].length()>2){
				  arg1.rejectValue("bookPrice", "id.bookPricebcd", new Object[] { "bookPrice" }, "Please provide the price of the book upto 2 decimals"); 
				  
			  }
			  double e=addBooks.getRentPrice();
			  String abc=Double.toString(e);
			  String[] con=abc.split("\\.");
			  if(con[1].length()>2){
				  arg1.rejectValue("rentPrice", "id.rentPriceef", new Object[] { "rentPrice" }, "Please provide the rent price of the book upto 2 decimals"); 
			  }
			  String co=addBooks.getBookAuthor();
			  if(addBooks.getBookAuthor().length()>0){
				 
			  if(!(co.matches("^[a-zA-Z. ]+$"))){
				  arg1.rejectValue("bookAuthor", "id.bookAuthorab", new Object[] { "bookAuthor" }, "please provide a valid author name"); 
			  }}
			 
			  String co1=addBooks.getBookTitle();
			  if(addBooks.getBookTitle().length()>0){
				  if(!(co1.matches("^[ A-Za-z0-9_@.:/#&+-]*$"))){ 
					  arg1.rejectValue("bookTitle", "id.bookTitleab", new Object[] { "bookTitle" }, "please provide a valid book title"); 
				  }
			  }
			  String co2=addBooks.getPublisherName();
			  if(addBooks.getPublisherName().length()>0){
				  if(!(co2.matches("^[ A-Za-z0-9_@./#&+-]*$"))){
					  arg1.rejectValue("publisherName","id.publisherNameab",new Object[] { "publisherName" },"please provide a valid publisher name");
				  }  
			  }
			  String co3=addBooks.getIsbn();
			  if(addBooks.getIsbn().length()>0){
				  if(!(co3.matches("\\d+"))){
					  arg1.rejectValue("isbn", "id.isbnabcd", new Object[] { "isbn" }, "Only numbers are allowed"); 
				  }
			  }
			  double co5=addBooks.getRentPrice();
			  if(addBooks.getRentPrice()>0){
				  if(!(co5==Math.floor(co5))){
					  arg1.rejectValue("rentPrice", "id.rentPriceabcdf", new Object[] { "isbn" }, "please provide a valid rent price"); 
				  }
			  }
			
			  if(addBooks.getIsbn().length()>0){
				  if(!(co3.matches("\\d+"))){
					  arg1.rejectValue("isbn", "id.isbnabcd", new Object[] { "isbn" }, "Only numbers are allowed"); 
				  }
			  }
			  if(addBooks.getRentPrice()>0){
			if( addBooks.getRentAvailable().equalsIgnoreCase("N") && (addBooks.getRentPrice()!=0))
			{
			  arg1.rejectValue("rentPrice", "id.rentPricefcb", new Object[] { "rentPrice" }, "Please enable book for rent."); 
		  }
			  }
			  
		if(addBooks.getQuantity()<0){
			 arg1.rejectValue("quantity", "id.quantityabc", new Object[] { "quantity" }, "Quantity cannot be negetive."); 
		}
	}

}