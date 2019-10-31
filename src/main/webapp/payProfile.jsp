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

#bankpage {
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
    width:200px;
    text-align: center;
    padding-top: 10px;
}

button:hover{
    background-color: #45a049;
    height:10px;
    width:%;
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

<body>
<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]--> 

        

<!-- Add your site or application content here -->
<div id="wrapper"> 
  <!-- header starts-->
    <div id="shoppingCartContainer" style="display: none">
                     <div id="bankpopup" class="popup">
                           <jsp:include page="bank.jsp" flush="true" />
                     </div>
              </div>
  <header>
    <div id="header"> <a href="loginpay" title="SapeStore" class="logo"><img src="img/walletlogo.png" width="231" height="109" alt="SapeStore"></a>
      <nav>
        <ul class="nav">
           <li ><a href='loginpay'>LOGOUT</a></li>
          <li ><a href='payhome1'>HOME</a></li>
          <li><a href='payProfile'>PROFILE</a></li>
          <li ><a href='backfrompay'>EXIT</a></li>
        </ul>
      </nav>
    </div>
  </header>
  <!-- header ends -->
  <div id="mainContent"><br>
 <h1>Profile</h1>
 Name: ${user.name}<br>
Phone: ${user.phone}<br>
Wallet amount: ${user.amount}<br>
<a class='inline' href="#bankpopup"><button name="call">Add money</button></a>

</div>
<br>

  <div class="clearfix"></div>
  <footer style="background:#000; margin:0;height:40px; text-align:right; color:#dfe5e6; font-size:12px; padding:30px 20px;">
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
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')</script>
       <script src="js/plugins.js"></script>
       <script src="js/main.js"></script>
       <script>
       $(document).ready(function(){
              $(".inline").colorbox({inline:true, width:"700px", height:"450px"});
              $(".callbacks").colorbox({
                     onOpen:function(){ alert('onOpen: colorbox is about to open'); },
                     onLoad:function(){ alert('onLoad: colorbox has started to load the targeted content'); },
                     onComplete:function(){ alert('onComplete: colorbox has displayed the loaded content'); },
                     onCleanup:function(){ alert('onCleanup: colorbox has begun the close process'); },
                     onClosed:function(){ alert('onClosed: colorbox has completely closed'); }
              });
       });

</script>
</body>
</html>