<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Error Occurred</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css" type="text/css">
<link rel="stylesheet" href="css/main.css" type="text/css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
<style type="text/css">

h1{
color:white;
font-style:italic;
font-size:70px
}

#xyz {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
    height:200px;
    width:300px;
    margin-left:80px;
    margin-top: 90px;
}
button {
   
    background-color: #4CAF50;
    color: white;
    padding: 20px 20px ;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    height:10px;
    width:100%;
    text-align: center;
    padding-top: 10px;
}

button:hover{
    background-color: #45a049;
    height:10px;
    width:100%;
    text-align: center;
     padding: 20px 20px ;
     padding-top: 10px;
}
input[type=text], select {
  
    padding: 4px 15px;
    margin: 4px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
input[type=password], select {
  
    padding: 4px 15px;
    margin: 4px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
</style>
<script type="text/javascript">
function submitForm() {

	$("#userIerror").text("Please login!");
    $("#userIerror").show();

	
}
</script>
<script>
function validateform(){
	  var flag = 0;
	 var ph = $("#phone").val();
	 var amount = $("#amount").val().trim();
 if(ph==0){
   	  $("#pherror1").show();
					flag=1;
      }else {
					$("#pherror1").hide();
      }
 if(ph.length!=10){
  	  $("#pherror1").show();
					flag=1;
     }else {
					$("#pherror1").hide();
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
			url:"payment",
			data: ($("input").serialize()),
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
<body>
<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]--> 

        

<!-- Add your site or application content here -->
<div id="wrapper"> 
  <!-- header starts-->
   
  <header>
    <div id="header"> <a href="loginpay" title="SapeStore" class="logo"><img src="img/walletlogo.png" width="231" height="109" alt="SapeStore"></a>
      <nav>
        <ul class="nav">
           <li ><a href='loginpay'>LOGOUT</a></li>
          <li ><a href='payhome1'>HOME</a></li>
          <li ><a href='payProfile'>PROFILE</a></li>
          <li ><a href='backfrompay'>EXIT</a></li>
        </ul>
      </nav>
    </div>
  </header>
  <!-- header ends -->
  <div id="mainContent"><br>
 <h2>Pay Someone</h2>
  <form:form commandName="transaction" >
<table>
<tr><td>sender:</td><td> <form:input path="sender" value="${number}" readonly="true"/></td></tr><br><br>
<tr><td>receiver:</td><td><form:input id="phone" path="receiver" onkeypress="return isNumber(event)" /></td></tr> <br><br>
<tr><td>amount:</td><td><form:input path="amount" /><%-- <form:errors path="amount"/> --%></td></tr><br><br>
<c:if test="{transId==-1}">not enough bal</c:if>
<tr><td colspan="3"><button type="button" onclick="validateform()" value="Make Payment">Make Payment</button></td></tr>

</table>
<span id="pherror1" style="color: red; display: none;">Phone number should be 10 Digits for receiver!</span><br>
                                                       <span id="pherror3" style="color: red; display: none;">
                                                       Enter amount between 5$-50,000$!</span>
<%-- not enough balance
${transId} --%>
</form:form>
<br>
<div id="bank">
</div>
</div>

  <div class="clearfix"></div>
  <footer>
  			<div id="footer">
		     	<div style=" float: left; margin-left: 386px;">
		     		<a href="/SapeStore/contactUsCustomer" style="color: #21addd;">Contact Us</a>
		       	</div>
		       	<div style="float: left;margin-left: 6px; color: #21addd"> | </div>
		       	
		       	<div style="float: left;margin-left: 7px;">
		 			<a href="/SapeStore//policyCustomer" style="color: #21addd;">Policy</a>
		  		</div>
		  		<div>Powered by <img src="img/sapient_nitro.jpg" width="78" height="14" alt="sapient nitro"></div>
		  	</div>
  
  </footer>
</div>
</body>
</html>