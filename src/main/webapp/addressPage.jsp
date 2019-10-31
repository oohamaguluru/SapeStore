<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Home</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/normalize.css" type="text/css">
<link rel="stylesheet" href="css/main.css" type="text/css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>

<style type="text/css">
.pg-normal {
	color: #de2728;
	font-size: 14px;
	cursor: pointer;
	padding: 2px 4px 2px 4px;
	font-weight: bold
}

.pg-selected {
	color: #fff;
	font-size: 14px;
	background: #de2728;
	padding: 2px 4px 2px 4px;
	font-weight: bold
}

table.yui {
	border-collapse: collapse;
	font-size: small;
}

table.yui td {
	padding: 5px;
}

table.yui .even {
	background-color: #EEE8AC;
}

table.yui .odd {
	background-color: #F9FAD0;
}

table.yui th {
	padding-top: 13px;
	height: auto;
}

table.yui th a {
	text-decoration: none;
	text-align: center;
	padding-right: 20px;
	font-weight: bold;
	white-space: nowrap;
}

table.yui tfoot td {
	background-color: #E1ECF9;
}

table.yui thead td {
	vertical-align: middle;
	background-color: #E1ECF9;
	border: none;
}

table.yui thead .tableHeader {
	font-size: larger;
	font-weight: bold;
}

table.yui thead .filter {
	text-align: right;
}

table.yui tfoot {
	background-color: #E1ECF9;
	text-align: center;
}

table.yui .tablesorterPager {
	padding: 10px 0 10px 0;
}

table.yui .tablesorterPager span {
	padding: 0 5px 0 5px;
}

table.yui .tablesorterPager input.prev {
	width: auto;
	margin-right: 10px;
}

table.yui .tablesorterPager input.next {
	width: auto;
	margin-left: 10px;
}

table.yui .pagedisplay {
	font-size: 10pt;
	width: 30px;
	border: 0px;
	background-color: #E1ECF9;
	text-align: center;
	vertical-align: top;
}

.homeAdmin #mainContent table {
	width: 99%;
}

#pageNavPosition {
	float: right;
	background: #f0f7f8;
	border-right: 1px solid #AAAAAA;
	border-left: 1px solid #AAAAAA;
	border-bottom: 1px solid #AAAAAA;
	padding-left: 774px;
	margin-right: 15px;
	padding-bottom: 0.5em;
	padding-top: 0.5em;
	padding-right: 2px;
}
</style>

<script type="text/javascript">

function Pager(tableName, itemsPerPage) {

this.tableName = tableName;

this.itemsPerPage = itemsPerPage;

this.currentPage = 1;

this.pages = 0;

this.inited = false;

this.showRecords = function(from, to) {

var rows = document.getElementById(tableName).rows;

// i starts from 1 to skip table header row

for (var i = 1; i < rows.length; i++) {

if (i < from || i > to)

rows[i].style.display = 'none';

else

rows[i].style.display = '';

}

}

this.showPage = function(pageNumber) {

if (! this.inited) {

alert("not inited");

return;

}

var oldPageAnchor = document.getElementById('pg'+this.currentPage);

oldPageAnchor.className = 'pg-normal';

this.currentPage = pageNumber;

var newPageAnchor = document.getElementById('pg'+this.currentPage);

newPageAnchor.className = 'pg-selected';

var from = (pageNumber - 1) * itemsPerPage + 1;

var to = from + itemsPerPage - 1;

this.showRecords(from, to);

}

this.prev = function() {

if (this.currentPage > 1)

this.showPage(this.currentPage - 1);

}

this.next = function() {

if (this.currentPage < this.pages) {

this.showPage(this.currentPage + 1);

}

}

this.init = function() {

var rows = document.getElementById(tableName).rows;

var records = (rows.length - 1);

this.pages = Math.ceil(records / itemsPerPage);

this.inited = true;

}

this.showPageNav = function(pagerName, positionId) {

if (! this.inited) {

alert("not inited");

return;

}

if(this.pages>1){
var element = document.getElementById(positionId);

var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> « Prev </span> ';

for (var page = 1; page <= this.pages; page++)

pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next »</span>';

element.innerHTML = pagerHtml;
}

}

}

</script>
<script>
function submitForm() {
	   		  var flag = 0;
              var ad1 = $("#street_number").val();
              var ad2 = $("#route").val();
              var zc = $("#postal_code").val();
              var mob = $("#mob").val();
              var ph = $("#mob1").val();
              var reg= /^\d+$/; 

                  if((mob.length!=10)||(mob.length==0)){
                	  $("#pherror").show();
						flag=1;
                   }else if(!reg.test($("#mob").val())) {
          				$("#pherror").show();
           				flag=1;
           	         }else {
						$("#pherror").hide();
                   }
              if(ph.length!=0){
                  if(ph.length!=10){
                	  $("#pherror1").show();
						flag=1;
                   } else if(!reg.test($("#mob1").val())) {
          				$("#pherror1").show();
           				flag=1;
           	         } else {
						$("#pherror1").hide();
                   }
               }else {
						$("#pherror1").hide();
               }
              if(ad1.length==0) {
                     $("#ad1error").show();
                     flag=1;
              } else {
					$("#ad1error").hide();
              }
              if(zc.length==0) {
                     $("#zcerror").show();
                     flag=1;
              } else {
					$("#zcerror").hide();
              }
               if(zc.length!=5) {
            	  if(zc.length!=6) {
                      $("#zcerror").show();
                      flag=1;
              		 } else {
    					$("#zcerror").hide();
              		 }
          		 } else {
					$("#zcerror").hide();
          		 } 

              if(!reg.test($("#postal_code").val())) {
  				$("#zcerror").show();
  				flag=1;
  	         } else{
				$("#zcerror").hide();
  	  	     } 
   	  	     
              if(flag==0) {
                     $("#mainform").submit();
              }
}
</script>
<script>
	function getcities() {
		var state = $("#administrative_area_level_1").val();
		document.getElementById("statevalue").value = state;
		var addressId = $("#addrId").val();
		var userid = $("#userId").val();
		var name = $("#cusName").val();
		var addrLn1 = $("#street_number").val();
		var addrLn2 = $("#route").val();
		var postCode = $("#postal_code").val();
		var mobNo = $("#mob").val();
		var phNo = $("#mob1").val();
		
		document.getElementById("addrId2").value = addressId;
		document.getElementById("userId2").value = userid;
		document.getElementById("name").value = name;
		document.getElementById("add1").value = addrLn1;
		document.getElementById("add2").value = addrLn2;
		document.getElementById("postalcode").value = postCode;
		document.getElementById("mobile").value = mobNo;
		document.getElementById("phone").value = phNo;

		$("#getCitiesFormSA").submit();
	}

</script>	

<script>

$(document).ready(function(){
	$("#dispatch").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	$("#return").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	
});
</script>
<script>
	
	
	function beforeDispatch() {
		document.updateForm.submit();
	}
	function beforeReturn() {
		document.updateForm.submit();
	}

	function dispatchClick(control) {
		var cid=control.id;
		var substr="dispatchCheckIndex";
		if(cid.lastIndexOf(substr, 0) == 0)
			{
			var str2=cid.substring(18);
			var str1 = "dispatchTextIndex";
			var textI = str1.concat(str2);
			document.getElementById(textI).childNodes[0].nextSibling.value = document.getElementById(cid).checked;
			}
	}
	
	function returnClick(control) {
		var cid=control.id;
		var substr="returnCheckIndex";
		if(cid.lastIndexOf(substr, 0) == 0)
			{
			var str2=cid.substring(16);
			var str1 = "returnTextIndex";
			var textI = str1.concat(str2);
			document.getElementById(textI).childNodes[0].nextSibling.value = document.getElementById(cid).checked;
			}
	}


</script>

</head>

<body>
<script>
	if( ${wrongCity1}==1) {
		alert("sorry we dont deliver here!");
		wrongCity1=0;}

</script>
	<script type="text/javascript">
$(document).ready(function(){
	$("#loginPop").click();
});


function changeVal()
{
var option = $("#account").val();
 
if(option==3) {
$("#transactionForm").submit();
} else if(option ==1) {
	   $("#editProfileForm").submit();
}else if(option ==2) {
	   $("#orderStatusForm").submit();
}else if(option ==-1) {
	   $("#homePageForm").submit();
}
}
</script>
<script>
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>

	<div id="wrapper">
		<div id="shoppingCartContainer" style="display: none">
			<div id="shoppingCart" class="popup">
				<jsp:include page="DisplayShoppingCart.jsp" flush="true" />
			</div>
		</div>
		<form:form name="form"
			action="/SapeStore/bookListByCat?categoryId=${categoryId}&categoryName=${categoryName}&checkMe=false"
			method="GET" commandName="welcome">
			<header>
			<div id="header">
				<a href="/SapeStore/welcome?checkMe=${checkMe}" title="SapeStore"
					class="logo"><img src="img/logo_option 01.png" width="231"
					height="109" alt="SapeStore"></a>

				<ul class="topLinks">
					<li>
						<!--form:checkbox id="checkMe" path="checkMe" value="Include books from Partner Store" onchange="form.submit();"/-->
						<c:choose>
							<c:when test="${welcome.checkMe==false}">
								<input type="checkbox" name="checkMe" id="checkMe"
									style="font-size: 13px;" onclick="form.submit();">
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="checkMe" id="checkMe"
									style="font-size: 13px;" onclick="form.submit();"
									checked="checked">
							</c:otherwise>
						</c:choose> <label for="checkMe" style="font-size: 13px;"><spring:message code="label.header.partnerstore"/></label> <input type="hidden" name="categoryId"
						value="${categoryId}" /> <input type="hidden" name="categoryName"
						value="${categoryName}" />
					</li>
					<li><a class='inline' href="#shoppingCart"><img
							src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a></li>
					<li class="cartNum">${ShoppingCart.totalQuantity}</li>
					<c:choose>
						<c:when test="${not empty userId}">
							<select id="account" name="account" style="font-size: 12px;" onchange="changeVal()">
                                              <option value="-1" style="font-size: 10px;"><spring:message code="label.headerdropdown.welcome"/>
                                                              ${username}</option>
                                                      <option value="1" style="font-size: 10px;"><spring:message code="label.transactionhistory.header"/></option>
                                                       <option value="2" style="font-size: 10px;"><spring:message code="label.headerdropdown.orderstatus1"/></option>
                                                       <option value="3" style="font-size: 10px;"><spring:message code="label.headerdropdown.transactionHistory"/></option>
                                               
                                                </select>
						</c:when>
					</c:choose>
				</ul>
				<nav>
				<ul class="nav">
					<li class="active"><a
						href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.header.home"/></a></li>
					<c:choose>
						<c:when test="${not empty userId}">
							<li><a href="personalInformation"><spring:message code="label.header.account"/></a></li>
						</c:when>

					</c:choose>

					<li><a href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.header.wishlist"/></a></li>
					<jsp:include page="Logout.jsp" flush="true" />
					<li><a href="/SapeStore/welcome?checkMe=${checkMe}"><img
							alt="searchImage" src="img/magnifier-icon.png" height="30"></a></li>

				</ul>
				</nav>
			</div>
			</header>
			<!-- header ends -->
			<section>
			<div class="leftCol">
				<h2>Account</h2>
				<nav> <!-- left navigation -->
				<ul>
					<li><a href="personalInformation" style="color: #cacfd0" style="font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.personalinfo"/></a></li>
                                  <li><a href="transactionHistory"  style="font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.transactionHistory"/></a></li>
                                  <li><a href="orderstatus.jsp" style="font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.orderstatus"/></a></li>
				</ul>
				</nav>
			</div>
		</form:form>

		<div id="mainContent">
			<h2 style="font-family: Sapient Centro Slab; font-size: 22px; color: #040707"><spring:message code="label.shippingAddr.head"/></h2><br>
			<hr>
			 
		<form:form id="mainform" action="shippingAddress" commandName= "addressComplete">
			<table class="wwFormTable">
			
			<tr>		
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message code="label.shippingAddr.name"/></span></td>
			<td><form:errors path="address.name" /></td>
			<td><form:input path="address.name"  id="cusName" readonly="true" style="background-color: gray;"/></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
			
			<tr>
			<td><div id="locationField">
     			 <input id="autocomplete" placeholder="Enter your address"
             	onFocus="geolocate()" type="text" style="width: 400px"></input>
   			 </div></td>
   			 </tr>
   			 
   			 <tr>
   			 <td><br></td>
   			 </tr>
   			
   			<tr> 
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message code="label.shippingAddr.addLine1"/><span
						class="required">*</span></span></td>
			<td><form:errors path="address.addressLine1" /></td>
			<td><form:input path="address.addressLine1" id="street_number"/><span
                                                id="ad1error" style="color: red; display: none;"><spring:message
									code="label.shippingAddr.addLine1Err"></spring:message></span></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
			
			<tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.addLine2"></spring:message></span></td>
			<td><form:errors path="address.addressLine2" /></td>
			<td><form:input path="address.addressLine2" id="route"/></td>
			</tr>
			
			<tr>
			<td><br></td>
			<tr>

			<tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.city"></spring:message><span
						class="required">*</span></span></td>
			<td><form:errors path="city.cityName" /></td>
			<td><form:input path="city.cityName" required="required" id="locality" style="width: 180px;"/></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
				
			<tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.state"></spring:message><span
						class="required">*</span></span></td>
			<td><form:errors path="state.stateName" /></td>
			<td><form:input path="state.stateName" required="required" id="administrative_area_level_1"  /></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
			
			<tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.country"></spring:message><span
						class="required">*</span></span></td>
			<td><form:errors path="country.countryName" /></td>
			<td><form:input path="country.countryName" required="required" id="country" /></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
				
			<tr>			
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.zipCode"></spring:message><span
						class="required">*</span></span></td>
			<td><form:errors path="address.postalCode" /></td>
			<td><form:input path="address.postalCode" id="postal_code" onkeypress="return isNumber(event)"/><span
                                                id="zcerror" style="color: red; display: none;"><spring:message
									code="label.shippingAddr.zipCodeErr"></spring:message></span></td>
           </tr>
           
           <tr>
           <td><br></td>
           </tr>
           
           <tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.phoneNumber"></spring:message></span></td>
			<td><form:errors path="address.phone" /></td>
			<td><form:input path="address.phone" onkeypress="return isNumber(event)" id="mob1"/>
			<span id="pherror1" style="color: red; display: none;"><spring:message
									code="label.shippingAddr.mobileNumberErr"></spring:message></span></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>

			<tr>
			<td><span style="font-family: SapientSansMedium; font-size: 15px;"><spring:message
									code="label.shippingAddr.mobileNumber"></spring:message><span
						class="required">*</span></span></td>
			<td><form:errors path="address.mobileNumber" /></td>
			<td><form:input path="address.mobileNumber" onkeypress="return isNumber(event)" id="mob"/>
			<span id="pherror" style="color: red; display: none;"><spring:message
									code="label.shippingAddr.mobileNumberErr"></spring:message></span></td>
			</tr>
			
			<tr>
			<td><br></td>
			</tr>
			
			
			<form:errors path="address.addressId" />
			<form:input type="hidden" path="address.addressId" readonly="true" id="addrId"/>
		
			<form:errors path="address.userId" />
			<form:input type="hidden" path="address.userId" readonly="true" id="userId"/>
			
			
			<tr>
			<td><input type="button" value="<spring:message
									code="label.shippingAddr.button"></spring:message>" style="font-family: Sapient Centro Slab; font-size: 20px; color: #ffffff; background-color: #21addd" onclick="submitForm()"></td>
			</tr>
			
		</table>
		</form:form>

		<form action="getCitiesShippingAddress" id="getCitiesFormSA">
		
				<input type="hidden" name="statename" id="statevalue" value="">
				<input type="hidden" name="addrId" id="addrId2" value="" />
				<input type="hidden" name="userId" id="userId2" value="" />
				<input type="hidden" name="cusName" id="name" value="" />
				<input type="hidden" name="add1" id="add1" value="" /> 					
				<input type="hidden" name="add2" id="add2" value="" /> 
				<input type="hidden" name="postalcode" id="postalcode" value="" />
				<input type="hidden" name="mobile" id="mobile" value="" />
				<input type="hidden" name="phone" id="phone" value="" />

			</form>
		
			<form name="addtoshoppingcartForm" action="addToShoppingCart"
				method="GET">
				<ul>
					<c:forEach items="${bookList}" var="current">
						<li><a href="javacript:void(0)" title="${current.bookTitle}">
								<img src="${current.bookFullImage}" width="131" height="180"
								alt="${current.bookTitle}" /> <span>${current.bookTitle}</span>
								<p>${current.bookAuthor}</p>
						</a> <figure> <img src="img/ratings.jpg" width="98"
								height="14" alt="ratings" /></figure>
							<p class="price">$${current.bookPrice}</p> <c:choose>
								<c:when test="${not empty userId}">
									<a
										href="/SapeStore/addToShoppingCart?categoryId=${current.categoryId}&categoryName=${categoryName}&checkMe=${checkMe}&isbn=${current.isbn}"
										title="Add To Cart" class="addCart"> <img
										src="img/add_cart.jpg" width="15" height="13"
										alt="add to cart" />
									</a>
								</c:when>
								<c:otherwise>
									<script type="text/javascript">
		            	function alertIt()
		            	{
		            		alert("Please login to be able to use the cart.");
		            	}
		            </script>
									<a href="#login" title="Add To Cart" class="addCart inline"
										id="addToCart"><img src="img/add_cart.jpg" width="15"
										height="13" alt="add to cart" /></a>
								</c:otherwise>
							</c:choose></li>
					</c:forEach>
				</ul>
			</form>
		</div>
		</section>
		<div id="pageNavPosition1" align="center"></div>
		<div class="clearfix"></div>

		<footer style="background:#dfe5e6; width:1002px;margin:auto;">
                                         <div id="footer">
                           <div style="float: left; margin-left: 386px;">
                                  <a href="/SapeStore/contactUsCustomer" style="color: #21addd;"><spring:message code="label.faq.contact"></spring:message></a>
                           </div>
                           <div style="float: left; margin-left: 6px; color: #21addd">|</div>

                           <div style="float: left; margin-left: 7px;">
                                  <a href="/SapeStore/policyCustomer" style="color: #21addd;"><spring:message code="label.faq.privacypolicy"></spring:message></a>
                           </div>
                           <div>
                                  <spring:message code="label.signup.powered"/> <img src="/SapeStore/img/sapient_nitro.jpg" width="78"
                                         height="14" alt="sapient nitro">
                           </div>
                     </div>
              </footer>
	</div>

	<!-- This contains the hidden content for shopping cart popup -->

	<!-- This contains the hidden content for login popup -->
	<div style="display: none">
		<div id="login" class="popup">


			<%@include file="login.jsp"%>
		</div>
	</div>


	<!-- Forgot password-->
	<div style="display: none">
		<form method="post" action="" id="forgotPassword"
			onsubmit="return ValidateForm();">
			<fieldset>
				<label for="email">Enter your email id<span class="required">*</span></label>
				<input type="email" placeholder="Name" required="" name="name">
				<input type="submit" value="Submit" class="lightButton">
				<div id="someHiddenDiv" style="display: none">Your password
					has been sent to your registered mail.</div>
			</fieldset>
		</form>
	</div>
	<script type="text/javascript">
		var pager = new Pager('tablepaging', 10);
		pager.init();
		pager.showPageNav('pager', 'pageNavPosition1');
		pager.showPage(1);
	</script>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')</script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>
	<script>
	$(document).ready(function(){
		$(".inline").colorbox({inline:true, width:"auto", height:"auto"});
		$(".callbacks").colorbox({
			onOpen:function(){ alert('onOpen: colorbox is about to open'); },
			onLoad:function(){ alert('onLoad: colorbox has started to load the targeted content'); },
			onComplete:function(){ alert('onComplete: colorbox has displayed the loaded content'); },
			onCleanup:function(){ alert('onCleanup: colorbox has begun the close process'); },
			onClosed:function(){ alert('onClosed: colorbox has completely closed'); }
		});
	});
</script>

  <form action = "transactionHistory" id = "transactionForm"></form> 
        <form action = "getStatusPage" id = "orderStatusForm"></form> 
        <form action="editProfile" id="editProfileForm"></form>
	<form action="welcome" id="homePageForm"></form>
	
	<script>

      var placeSearch, autocomplete;
      var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
      };

      function initAutocomplete() {
        var options = {
        	    types: ['geocode'],  
        	    componentRestrictions: {country: "us"}
        	};
        var options2 = {
        	    types: ['geocode'],  
        	    componentRestrictions: {country: "in"}
        	};
        autocomplete = new google.maps.places.Autocomplete(
            (document.getElementById('autocomplete')),
            options);
        autocomplete2 = new google.maps.places.Autocomplete(
               (document.getElementById('autocomplete')),
                options2);

   
        autocomplete.addListener('place_changed', fillInAddress);
        autocomplete2.addListener('place_changed', fillInAddress2);
      }

      function fillInAddress() {
        var place = autocomplete.getPlace();

        for (var component in componentForm) {
          document.getElementById(component).value = '';
          document.getElementById(component).disabled = false;
        }

        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          if (componentForm[addressType]) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType).value = val;
          }
        }
      }

      function fillInAddress2() {
          var place = autocomplete2.getPlace();

          for (var component in componentForm) {
            document.getElementById(component).value = '';
            document.getElementById(component).disabled = false;
          }

          for (var i = 0; i < place.address_components.length; i++) {
            var addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
              var val = place.address_components[i][componentForm[addressType]];
              document.getElementById(addressType).value = val;
            }
          }
        }

      function geolocate() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
              center: geolocation,
              radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
            autocomplete2.setBounds(circle.getBounds());
          });
        }
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDKxzS2CR5U6qE3_ZvdDDs5A69zNsbI2b8&libraries=places&callback=initAutocomplete"
        async defer></script>
</body>
</html>