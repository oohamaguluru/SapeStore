<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <script
  src="https://code.jquery.com/jquery-1.12.4.min.js"
  integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
  crossorigin="anonymous"></script>
  <script>
  function populateYearSelect() 
  { 
    d = new Date(); 
 
    curr_year = d.getFullYear(); 
 
    for(i = 0; i < 25; i++) 
    { 
        document.getElementById('year').options[i] = new Option(curr_year+i,curr_year+i); 
    } 
    
  document.forms[0].month.selectedIndex = d.getMonth();
   } 
   
   function submit()
   {
   document.forms[0].target="_self";
   document.forms[0].submit();
 
   }
   
 
   
   window.onload=function() { 
        populateYearSelect();
     
}
function proceed(){

		 var flag = 0;
		 var ph = $("#card").val();
		 var cvv = $("#cvv").val();
		 var month = $("#month").val();
		 var year = $("#year").val();
		 var amount = $("#amount").val().trim();
		
	         if(ph.length!=16){
	       	  $("#pherror1").show();
						flag=1;
	          }else {
						$("#pherror1").hide();
	          }
	         if(cvv.length!=3){
		       	  $("#pherror2").show();
							flag=1;
		          }else {
							$("#pherror2").hide();
		          }
	         if(amount<5){
		        
		       	  $("#pherror3").show();
							flag=1;
		          }
	         else if(amount>50000){
	        	 $("#pherror3").show();
					flag=1;
	         }
	         else {
							$("#pherror3").hide();
		          }
	     if(flag==0) {
		$.ajax({
			
			url:"paybanking",
			data: ($("input").serialize()+"&exdate="+month+'-'+year),
			success: function(data){
				$("#bank").html(data);
			}
		})
	     }
	
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>
</head>
<body>
<h2>Payment by Card</h2>
Welcome <b>${user.name}</b>
<div id="bank">
<table>
<tr><td>Card Number:</td><td><input id="card" type="text" name="card" onkeypress="return isNumber(event)"></td><br><td><span id="pherror1" style="color: red; display: none;">Please
                                                       Enter 16 digits!</span></td></tr>
<tr><td>Expiry Date:</td><td> <select id="month" size="1" name="month" >
      <option value="01" >01</option>
 
      <option value="02">02</option>
 
      <option value="03">03</option>
 
      <option value="04">04</option>
 
      <option value="05">05</option>
 
      <option value="06">06</option>
 
      <option value="07">07</option>
 
      <option value="08">08</option>
 
      <option value="09">09</option>
 
      <option value="10">10</option>
 
      <option value="11">11</option>
 
      <option value="12">12</option>
    </select><select id="year" style="WIDTH: 100px" name="year"></select></td></tr>
<tr><td>CVV:</td><td><input id="cvv" type="password" name="cvv"></td><td><span id="pherror2" style="color: red; display: none;">Please
                                                       Enter 3 digit cvv!</span></td></tr>
<tr><td>Amount:</td><td><input type="text" name="cash" id="amount" required></td><td><span id="pherror3" style="color: red; display: none;">
                                                       Enter amount between 5$-50,000$!</span></td></tr>
</table>
<button id="proceed" type="button" onclick="proceed()">Proceed</button>&nbsp&nbsp<a href="payProfile"><button type="button">Cancel</button></a>
</div>
</body>
</html>