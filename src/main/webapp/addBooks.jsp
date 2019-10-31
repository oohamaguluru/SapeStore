<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page
	import="java.util.*,java.io.*,com.sapestore.hibernate.entity.BookCategory,com.sapestore.controller.ProductController"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Home
</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/main.css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
</head>


<body onload="someFun()">
<script type="text/javascript">
function dis_able()
{	
	var r=$("#rentAvailable_id").val().trim();
	if(r=="N"){
		document.getElementById("rentPrice_id").value="";
		document.getElementById("rentPrice_id").disabled=true;
	}
	else{
		document.getElementById("rentPrice_id").disabled=false;
	}
} 
function HandleBrowseClick()
{
    var fileinput = document.getElementById("thumbImage");
    fileinput.click();
}
function Handlechange()
{
var fileinput = document.getElementById("thumbImage");
if (fileinput) {
	var startIndex = (fileinput.indexOf('\\') >= 0 ? fileinput.lastIndexOf('\\') : fileinput.lastIndexOf('/'));
	var filename = fileinput.substring(startIndex);
	if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
		filename = filename.substring(1);
	}
	var textinput = document.getElementById("filename");
	textinput.value = filename.value;
}

}
function HandleBrowseClickFullImage()
{
    var fileinput = document.getElementById("fullImage");
    fileinput.click();
}
function HandlechangeFullImage()
{
var fileinput = document.getElementById("fullImage");
if (fileinput) {
	var startIndex = (fileinput.indexOf('\\') >= 0 ? fileinput.lastIndexOf('\\') : fileinput.lastIndexOf('/'));
	var filename = fileinput.substring(startIndex);
	if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
		filename = filename.substring(1);
	}
	var textinput = document.getElementById("filenameFullImage");
	textinput.value = filename.value;
}

}

/* function validateInput()
{
	if(document.getElementById("addAddress_bookPrice").value==null)
		{
			document.getElementById("errorPrice").innerHTML = "Please provide book price.";
		}
	else if(document.getElementById("addAddress_bookPrice").value=="")
	{
		document.getElementById("errorPrice").innerHTML = "Please provide book price.";
	}
	else if(document.getElementById("addAddress_quantity").value=="")
	{
		document.getElementById("errorQuantity").innerHTML = "Please provide book quantity.";
	}
	else if(document.getElementById("addAddress_quantity").value=="")
	{
		document.getElementById("errorQuantity").innerHTML = "Please provide book quantity.";
	}
	else if(document.getElementById(""))
		{
			document.addBooksForm.submit();
		}
}
 */
function submitTheForm()
{
	document.addBooksForm.submit();
}
 function someFun(alertMessage){
		var r = $("#rentAvailable_id").val().trim();
		if(r=="N"||r=="No")
			document.getElementById("rentPrice_id").disabled = true;
	}
function goBack() {
    window.history.back();
}
/* jQuery(function ($) {
	$('.number').keypress(function(event) {
	            if ( event.which != 8 && (event.which < 48 || event.which > 57) && ($(this).val().indexOf('.') != -1) && ($(this).val().substring($(this).val().indexOf('.'), $(this).val().indexOf('.').length).length > 2)))
{
	            event.preventDefault();	
	   	         }
	    })
	    })  */  
	  
	     
</script>


<style>
.error {
    color: #ff0000;
}
</style>
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

	<!-- Add your site or application content here -->
	<div id="wrapper" class="homeAdmin">
		<!-- header starts-->
		<header>
			<div id="header">
				<a href="#" title="SapeStore" class="logo"><img src="img/logo.jpg" width="231" height="109" alt="SapeStore"></a>
				<ul class="topLinks hide">
					<li><input name="include_books" type="checkbox"
						value="include_books" checked> <a
						title="Add books from Partner Store" href="#"><spring:message
								code="label.signup.partnerStore" /></a>
					</li>
					<li><a class='inline' href="#shoppingCart"><img
							src="img/icon_cart.jpg" width="15" height="12" alt="cart">
					</a>
					</li>
					<li class="cartNum">0</li>
				</ul>
				<!-- in case of admin hide this and display another one -->
				<nav>
					<ul class="nav">
					<li class="active"><a href="/SapeStore/manageInventory"><spring:message
									code="label.manageorders.manageinventory"/></a></li> 

					<li><a href="/SapeStore/manageOrders" ><spring:message
									code="label.manageorders.manageorder" /></a></li> 

					<li><a href="/SapeStore/adminReport"><spring:message
									code="label.manageorders.adminreport" /></a></li> 

					<li><a href="/SapeStore/managePages" ><spring:message
									code="label.manageorders.managepages" /></a></li> 

					<li><a href="/SapeStore/logout"><spring:message
									code="label.manageorders.logout" /></a></li>
					</ul>
				</nav>
			</div>
		</header>
		<!-- header ends -->
		<section>
			<div id="mainContent" class="addAddress">
				<h2 style="font:Sapient Centro Slab;"><spring:message code="label.addbooks.addbookstore" /></h2>
				<div class="clearfix"></div>
				<form:form method="POST" name="addBooksForm" action="/SapeStore/addBooks" id="addAddress" enctype="multipart/form-data" commandName="addBooks">
				<table class="wwFormTable">
					
						<div><tr>
						<td class="tdLabel"><label for="thumbImage" class="label"><spring:message
											code="label.edit.thumbnail" /><span class="required">*</span></label></td>
						<td>
							<input type="button"  class="lightButton addtoStore" value="<spring:message
											code="label.addBooks.BrowseImage" />" id="fakeBrowse" name="fakeBrowse" onclick="HandleBrowseClick();"/>
							<form:errors path="thumbImage" cssClass="error"/>
							<label id="filename" style="font-size: 13px;"></label>
							<input type="file" id="thumbImage" name="thumbImage" accept="image/gif, image/jpeg, image/jpg, image/png, image/bmp" id="thumbImage" placeholder="Book Thumbnail Image" required="required" style="opacity: 0" onChange="Handlechange();" value="${addBooks.thumbImage}"/>
							<input type="hidden" id="thumbPath" name="thumbPath" value="${addBooks.thumbPath}"/>
							
						</td>
						</tr>
						</div>
						<div><tr>
						<td class="tdLabel"><label for="fullImage" class="label"><spring:message
											code="label.edit.Detail" /><span class="required">*</span></label></td>
						<td>
							<input type="button" class="lightButton addtoStore" value="<spring:message
											code="label.addBooks.BrowseImage" />" id="fakeBrowsefullImage" name="fakeBrowsefullImage" onclick="HandleBrowseClickFullImage();"/>
							<form:errors path="fullImage" cssClass="error"/>
							<label id="filenameFullImage" style="font-size: 13px;"></label>
							<input type="file" id="fullImage" name="fullImage" value="" accept="image/gif, image/jpeg, image/jpg, image/png, image/bmp" id="fullImage" placeholder="Book Detail Image" required="required" style="opacity: 0" onChange="HandlechangeFullImage();" value="${addBooks.fullImage}"/>
						    <input type="hidden" id="fullPath" name="fullPath" value="${addBooks.fullPath}"/> 
						</td>
						</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="addAddress_bookTitle" class="label"><spring:message
											code="label.edit.Title" /><span class="required">*</span></label></td>
    						<td><input type="text" name="bookTitle" value="${addBooks.bookTitle.trim()}" id="addAddress_bookTitle" placeholder="Book Title"/>
    							<form:errors path="bookTitle" cssClass="error"/></td>
							</tr>
						</div>
						<div>
								<tr>
    							<td class="tdLabel"><label for="addAddress_bookAuthor" class="label"><spring:message
											code="label.edit.Author" /><span class="required">*</span></label></td>
    							<td><input type="text" name="bookAuthor" value="${addBooks.bookAuthor}" id="addAddress_bookAuthor" placeholder="Book Author"/>
    								<form:errors path="bookAuthor" cssClass="error"/>
    							</td>
								</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="addAddress_isbn" class="label"><spring:message
											code="label.edit.ISBN" /><span class="required">*</span></label></td>
    						<td><input type="text" name="isbn" value="${addBooks.isbn}" id="addAddress_isbn" placeholder="ISBN"/>
    							<form:errors path="isbn" cssClass="error"/> <div style="color:red; font-size:11.5px; top:800px;">${errorsa}</div></td>
    						
							</tr>
						</div>
						<div>
						<tr>
    					<td class="tdLabel"><label for="addAddress_publisherName" class="label"><spring:message
											code="label.edit.Publisher" /><span class="required">*</span></label></td>
    					<td><input type="text" name="publisherName" value="${addBooks.publisherName}" id="addAddress_publisherName" placeholder="Publisher Name"/>
    						<form:errors path="publisherName" cssClass="error"/>
    					</td>
						</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="addAddress_categoryName" class="label"><spring:message
											code="label.edit.Category" /><span class="required">*</span></label></td>
    						<td>	    							 						
    							<form:select path="categoryId">
    							<form:option value="" label="Select a category"/>
    							<c:forEach items="${categoryList}" var="current">
    								<c:choose>
    									<c:when test="${current.categoryName==addBooks.categoryName}">
    										<form:option value="${current.categoryId}" label="${current.categoryName}" selected="selected"/>
    									</c:when>
    									<c:otherwise>
    										<form:option value="${current.categoryId}" label="${current.categoryName}"/>
    									</c:otherwise>
    								</c:choose>
    							</c:forEach>
    							</form:select>
    							<form:errors path="categoryId" cssClass="error" />
									</td>
    						</tr>
						</div>
						<div>
								<tr>
    							<td class="tdLabel"><label for="addAddress_bookPrice" class="label"><spring:message
											code="label.edit.SellingPrice" /><span class="required">*</span></label></td>
    							<td><input type="text" name="bookPrice" id="addAddress_bookPrice" onkeypress="isNumberKey(this)" value="${addBooks.bookPrice}" placeholder="Book Price (In $)"/>
    								<form:errors path="bookPrice" cssClass="error"/><div id="error"></div>
								</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="rentPrice_id" class="label"><spring:message
											code="label.edit.RentPrice" /><span class="required">*</span></label></td>
   							<td><input type="text" name="rentPrice" value="${addBooks.rentPrice}" id="rentPrice_id" placeholder="Rent Price"/>
   								<form:errors path="rentPrice" cssClass="error"/>
   							</td>
							</tr>
						</div>
						<div>
								<tr>
    							<td class="tdLabel"><label for="addAddress_quantity" class="label"><spring:message
											code="label.edit.Quantity" /><span class="required">*</span></label></td>
    							<td><input type="text" name="quantity" id="addAddress_quantity" value="${addBooks.quantity}" placeholder="Quantity"/>
    								<form:errors path="quantity" cssClass="error"/>
    							</td>
								</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="rentAvailable_id" class="label"><spring:message
											code="label.edit.Availability" /><span class="required">*</span></label></td>
    						<td><select name="rentAvailable" id="rentAvailable_id" onchange="dis_able()" >
    							<option value="Y"><spring:message code="label.addbooks.yes" /></option>
    						<c:choose>
    							<c:when test="${addBooks.rentAvailable=='N'}">
    								<option value="N" selected="selected"><spring:message code="label.addbooks.no" /></option>
    							</c:when>
    							<c:otherwise>
    								<option value="N"><spring:message code="label.addbooks.no" /></option>
    							</c:otherwise>
    						</c:choose>
    							
								</select>
								<form:errors path="rentAvailable" cssClass="error"/>
							</td>
							</tr>
						</div>

						<div>
								<tr>
    							<td class="tdLabel"><label for="addAddress_bookShortDesc" class="label"><spring:message
											code="label.edit.ShortDes" /><span class="required">*</span></label></td>
    							<td><textarea name="bookShortDesc" cols="25" rows="3" id="addAddress_bookShortDesc" placeholder="Short Description">${addBooks.bookShortDesc}</textarea>
    								<form:errors path="bookShortDesc" cssClass="error"/>
    							</td>
								</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="addAddress_bookDetailDesc" class="label"><spring:message code="label.edit.DetailDes" /><span class="required">*</span></label></td>
    						<td><textarea name="bookDetailDesc" cols="25" rows="6" id="addAddress_bookDetailDesc" placeholder="Detail Description">${addBooks.bookDetailDesc}</textarea>
							<form:errors path="bookDetailDesc" cssClass="error"/></td>
							</tr>
						</div>
							  <tr>
    						  <td colspan="2"><div align="center">
									<input style="position: absolute; left: 37.5%;" type="button"
										id="addAddress__addBooks" name="method:addBooks"
										value="<spring:message code="label.addbooks.addstore" />" onclick="submitTheForm()"
										class="lightButton addtoStore" />
									<button type="button" id=addAddress__cancel name="cancel"
										value="Submit" onclick="goBack()"
										class="lightButton addtoStore"><spring:message code="label.edit.cancel" /></button>
								</div></td>
								</tr>
					
					</table>
				</form:form>
				
</form>
			</div>
		</section>  
		
		<div class="clearfix"></div>
		<footer>
			<div id="footer">
		  		<div><spring:message code="label.signup.powered" /><img src="img/sapient_nitro.jpg" width="78" height="14" alt="sapient nitro"></div>
		  	</div>
		</footer>
	</div>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')
	</script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>
</body>
</html>