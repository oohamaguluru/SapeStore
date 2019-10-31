<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<title>SapeStore-Home</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/main.css">

<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script src="js/vendor/jquery-1.9.1.min.js"></script>
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

border-collapse:collapse; 

font-size:small; 
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

padding: 5px; 
height: auto; 

}

table.yui th a { 
text-decoration: none; 
text-align: center; 
padding-right: 20px; 
font-weight:bold; 
white-space:nowrap; 
}

table.yui tfoot td { 
 
background-color:#E1ECF9; 
}

table.yui thead td { 
vertical-align:middle; 
background-color:#E1ECF9; 
border:none; 
}

table.yui thead .tableHeader { 
font-size:larger; 
font-weight:bold; 
}

table.yui thead .filter { 
text-align:right; 
}

table.yui tfoot { 
background-color:#E1ECF9; 
text-align:center; 
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
font-size:10pt; 
width: 30px; 
border: 0px; 
background-color: #E1ECF9; 
text-align:center; 
vertical-align:top; 
}
.homeAdmin #mainContent table{
 width: 99%;
 }
 #pageNavPosition{
	/* float: none;  */

	background: #dfe5e6;
/* 	padding-left: 774px;
	padding-bottom: 2em; */
	padding-top: 0.5em;
	margin-left:100px;
	/* padding-right: 2px;
	padding-left: 740px; */
  
	/* margin-right: 7px; */
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

var element = document.getElementById(positionId);

var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> « Prev </span> ';

for (var page = 1; page <= this.pages; page++)

pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next »</span>';

element.innerHTML = pagerHtml;

}

}

</script>

<script type="text/javascript">	
function submitForm(isbn) {
		
		
		
		var id = document.getElementById(isbn);

		var title = id.getElementsByClassName("bookTitle_td")[0].innerHTML;
		var author = id.getElementsByClassName("bookAuthor_td")[0].innerHTML;
		var publisher = id.getElementsByClassName("publisherName_td")[0].innerHTML;
		var rentAvailable = id.getElementsByClassName("rentAvailable_td")[0].innerHTML;
		var quantity = id.getElementsByClassName("quantity_td")[0].innerHTML;
		
		var bookPrice = id.getElementsByClassName("bookPrice_td")[0].innerHTML;
		var rentPrice = id.getElementsByClassName("rentPrice_td")[0].innerHTML;
		var isbn = id.getElementsByClassName("isbn_td")[0].innerHTML;
		var bookShortDesc = id.getElementsByClassName("bookShortDesc_td")[0].innerHTML;
		var bookDetailDesc = id
				.getElementsByClassName("bookDetailDesc_td")[0].innerHTML;
		var thumbPath = id
		.getElementsByClassName("thumbPath_td")[0].innerHTML;
		var categoryName = id.getElementsByClassName("categoryName_td")[0].innerHTML;
		var fullPath = id
		.getElementsByClassName("fullPath_td")[0].innerHTML;
		
		document.getElementById("name_to_submit").value = name;
		document.getElementById("title_to_submit").value = title;
		document.getElementById("author_to_submit").value = author;
		document.getElementById("publisher_to_submit").value = publisher;
		document.getElementById("rent_to_submit").value = rentAvailable;
		document.getElementById("quantity_to_submit").value = quantity;

		document.getElementById("bookPrice_to_submit").value = bookPrice;
		document.getElementById("rentPrice_to_submit").value = rentPrice;
		document.getElementById("isbn_to_submit").value = isbn;
		document.getElementById("bookShortDesc_to_submit").value = bookShortDesc;
		document.getElementById("bookDetailDesc_to_submit").value = bookDetailDesc;
		document.getElementById("thumbPath_to_submit").value = thumbPath;
		document.getElementById("fullPath_to_submit").value = fullPath;
		document.getElementById("categoryName_to_submit").value = categoryName;
		document.editForm.submit();
		
	}
	
function testFunction(isbn)
{
	var id = document.getElementById(isbn);
	var rentAvailable = id.getElementsByClassName("rentAvailable_td")[0].innerHTML;
	var quantity = id.getElementsByClassName("quantity_td")[0].innerHTML;
	var author = id.getElementsByClassName("bookAuthor_td")[0].innerHTML;
	var x=rentAvailable;
	var del;
	if(x.trim()=="Y")
	{
		if(quantity>1)
			{
			var result = confirm("More than 1 book is available in the inventory. Click Yes, if you want to delete all records.");
			if (result==true) {
			del="yes";    
			}
			}
		else
			{
			var result = confirm("Only  1 book is available in the inventory. Click Yes, if you want to delete the records.");
			if (result==true) {
				del="yes"; 
			}
			}
// here
		if(del=="yes"){
			var isbn = id.getElementsByClassName("isbn_td")[0].innerHTML;
			document.getElementById("isbn_to_submit").value = isbn;
			document.editForm.submit();
		}
	}
	else
		{
		alert("This book is rented by a customer and cannot be deleted from records");
		}
	
}

function handleSubmit(isbn)
{
    var delSubmit = document.getElementById("delSubmit");
    
	var id = document.getElementById(isbn);
	
	var rentAvailable = id.getElementsByClassName("rentAvailable_td")[0].innerHTML;
	var quantity = id.getElementsByClassName("quantity_td")[0].innerHTML;
	var author = id.getElementsByClassName("bookAuthor_td")[0].innerHTML;
	var x=rentAvailable;
	var del;
	
	
		if(quantity>1)
			{
			
			var result = confirm("More than 1 book is available in the inventory. Click Yes, if you want to delete all records.");
			if (result==true) {
			del="yes";    
			}
			}
		else
			{
			
			var result = confirm("Only  1 book is available in the inventory. Click Yes, if you want to delete the records.");
			if (result==true) {
				del="yes"; 
			}
			}
// here
		if(del=="yes"){
			var isbn = id.getElementsByClassName("isbn_td")[0].innerHTML;
			document.getElementById("isbn_to_submit").value = isbn;
			delSubmit.click();
		}
	
	
	
    
}
function myFunction() {
    document.getElementById("myForm").action = "/SapeStore/deleteBook";
    document.getElementById("myForm").method= "GET";
    document.getElementById("demo").innerHTML = "The value of the action attribute was changed to /action_page.php.";
}

function checkthis(testcase) {
	if(testcase==1) {
		alert("Cannot be Deleted since Order_Type=Rented !");
		}
	if(testcase==0) {
		alert("Successfully Deleted!");
		} 
}
</script>
</head>

<body onload="checkthis(${testcase})">
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

	<!-- Add your site or application content here -->
	<div id="wrapper" class="homeAdmin">
		<!-- header starts-->
		<header>
			<div id="header">
				<a href="/SapeStore/manageInventory" title="SapeStore" class="logo"><img
					src="img/logo.jpg" width="231" height="109" alt="SapeStore">
				</a>
				<ul class="topLinks">
					
				<c:choose>
                                         <c:when test="${not empty userId}">
                                                <select id="account" name="account" style="font-size: 12px;"
                                                       onchange="changeVal()">
                                                       <option value="-1" style="font-size: 10px;">Welcome ${username}</option>
                                                       
                                                </select>
                                         </c:when>
                                  </c:choose>
				
				</ul>
				<!-- in case of admin hide this and display another one -->
				<nav>
					<ul class="nav">
					<li class="active"><a href="/SapeStore/manageInventory" ><spring:message code="label.edit.ManageOrders"/></a></li> 

					<li><a href="/SapeStore/manageOrders"><spring:message code="label.edit.ManageOrders"/></a></li> 

					<li><a href="/SapeStore/adminReport"><spring:message code="label.edit.ManageReports"/></a></li> 

					<li><a href="/SapeStore/managePages"><spring:message code="label.edit.ManagePages"/></a></li> 

					<li><a href="/SapeStore/logout"><spring:message code="label.edit.Logout"/></a></li>
					</ul>
				</nav>
			</div>
		</header>
		<!-- header ends -->
		<section>

			<div id="mainContent" style="padding-right: 20px;width: 950px;">
				<h2><spring:message code="label.edit.InventorySummary"/></h2>
				
				<form:form name="addBooks" action="/SapeStore/addBooksAdmin" method="POST">
					<input type="submit" value="Add a book" style="height: 25px; margin-left:733px; font-weight:bold; font-size: initial; width: 106px; background-color: #21addd; color: white; height: 30px">
				</form:form>
				
				<form:form  id = "myForm"  action="/SapeStore/editBooks"  method="POST" name="editForm" commandName="updateBooks">
						<input type="hidden" name="name" id="name_to_submit"/>
						<input type="hidden" name="bookTitle" id="title_to_submit"/>
						<input type="hidden" name="bookAuthor" id="author_to_submit"/>
						<input type="hidden" name="publisherName" id="publisher_to_submit"/>
						<input type="hidden" name="rentAvailable" id="rent_to_submit"/>
						<input type="hidden" name="quantity" id="quantity_to_submit"/>
						<input type="hidden" name="bookPrice" id="bookPrice_to_submit"/>
						<input type="hidden" name="rentPrice" id="rentPrice_to_submit"/>
						<input type="hidden" name="isbn" id="isbn_to_submit"/>
						<input type="hidden" name="bookShortDesc" id="bookShortDesc_to_submit"/>
						<input type="hidden" name="bookDetailDesc" id="bookDetailDesc_to_submit"/>
						<input type="hidden" name="thumbPath" id="thumbPath_to_submit"/>
						<input type="hidden" name="categoryName" id="categoryName_to_submit"/>
						<input type="hidden" name="fullPath" id="fullPath_to_submit"/>
					<table id="tablepaging" class="yui">
					
						<thead>
							<tr style="border-bottom: dashed 1px #b7bcbd">
								<th><spring:message code="label.add.Category"/></th>
								<th><spring:message code="label.add.BookName"/></th>
								<th><spring:message code="label.add.Author"/></th>
								<th><spring:message code="label.add.Publisher"/></th>
								<th style="text-align: center"><spring:message code="label.add.ForRent"/></th>
								<th><spring:message code="label.add.Quantity"/></th>
								<th colspan="2" style="text-align: center;"><spring:message code="label.add.Action"/></th>
							</tr>
						</thead>
						
						
						<c:forEach items="${adminInventoryList}" var="current">
							
							<tr id="${current.isbn}" style="height: 60px">
							<c:choose>
                                   <c:when test="${current.quantity<5}">
								<td class="categoryName_td" style="width: 120px;word-break: break-word;color:red">${current.categoryName}
								</td>
								     </c:when>    
                            <c:otherwise>
                            <td class="categoryName_td" style="width: 120px;word-break: break-word">${current.categoryName}
								</td>
								</c:otherwise>
								</c:choose>
								
								<c:choose>
                                   <c:when test="${current.quantity<5}">
								<td class="bookTitle_td" style="width: 110px;word-break: break-word;color:red">${current.bookTitle}
								</td>
								</c:when>    
                            <c:otherwise>
                            <td class="bookTitle_td" style="width: 110px;word-break: break-word">${current.bookTitle}
								</td>
								</c:otherwise>
								</c:choose>
								
								
								
								<c:choose>
                                   <c:when test="${current.quantity<5}">
								<td class="bookAuthor_td" style="width: 110px;word-break: break-word;color:red">${current.bookAuthor}
								</td>
								</c:when>  
								<c:otherwise>
								<td class="bookAuthor_td" style="width: 110px;word-break: break-word">${current.bookAuthor}
								</td>
								</c:otherwise>
								</c:choose>
								
								
								<c:choose>
                                   <c:when test="${current.quantity<5}">
								<td class="publisherName_td" style="width: 110px;word-break: break-word;color:red">${current.publisherName}
								</td>
								</c:when>  
								<c:otherwise>
								<td class="publisherName_td" style="width: 110px;word-break: break-word">${current.publisherName}
								</td>
								</c:otherwise>
								</c:choose>
								
								
								<c:choose>
                                   <c:when test="${current.quantity<5}">
								<td class="rentAvailable_td" style="text-align: center; width: 190px;color:red">${current.rentAvailability}
								</td>
								</c:when>  
								<c:otherwise>
								<td class="rentAvailable_td" style="text-align: center; width: 190px">${current.rentAvailability}
								</td>
								</c:otherwise>
								</c:choose>
								
								
								
								
								<c:choose>
                                   <c:when test="${current.quantity<5}">
                           <td class="quantity_td" style="text-align: center; width: 95px;word-break: break-word;color:red">${current.quantity}
                                </td>
                                  </c:when>    
                            <c:otherwise>
                           <td class="quantity_td" style="text-align: center; width: 95px;word-break: break-word">${current.quantity}
                            </td>  
                              </c:otherwise>
                             </c:choose>

								
								<td style="display:none" class="bookPrice_td">${current.bookPrice}</td>
								
								<td style="display:none" class="rentPrice_td">${current.rentPrice}
															</td>
								<td style="display:none" class="isbn_td">${current.isbn}
								</td>
								<td style="display:none" class="bookShortDesc_td">${current.bookShortDescription}
								</td>
								<td style="display:none" class="bookDetailDesc_td">${current.bookDetailDescription}
								</td>
								<td style="display:none" class="thumbPath_td">${current.bookThumbImage}
								</td>
								<td style="display:none" class="fullPath_td">${current.bookFullImage}
								</td>
								
								
								<%-- <button type="submit" name="editBook" title="Edit" onclick="submitForm('${current.isbn}')"><img src="img/edit11.png" width="15" height="13"></button> --%>
								
								 
								<td style="float: inherit;">
								<button type="submit" name="editBook" title="Edit" onclick="submitForm('${current.isbn}')"><img src="img/edit11.png" width="15" height="13" align="right"></button>
								
								
								</td>	
								
								</td>	
								<td style="float: inherit;"><button type="button" formmethod="GET" formaction="/SapeStore/deleteBook" name="deleteBook" title="Delete" onclick="handleSubmit('${current.isbn}');"><img src="img/delete.png" width="15" height="13"></button>
									
								</td>
								<!-- <td><input type="submit" name="delSubmit" id="delSubmit" style="opacity: 0"></td> -->
								<td><input type="submit" name="deleteBook" id="delSubmit" style="opacity: 0.0" onclick="myFunction()"></td>
								<td style="float: inherit; margin-right:100px; ">			
							</tr>
							
						</c:forEach>
					</table>
					
				
				</form:form>
				<%-- <td><input type="submit" name="deleteBook" id="delSubmit" style="opacity: 0.0" onclick="myFunction()"></td> 
								<td style="float: inherit;">
								<button type="submit" name="editBook" title="Edit" onclick="submitForm('${current.isbn}')"><img src="img/edit11.png" width="15" height="13" align="right"></button>
								
								
								</td>	
							<!-- button -->	<td style="float: inherit;"><button type="button" formmethod="GET" formaction="/SapeStore/deleteBook" name="deleteBook" title="Delete" onclick="handleSubmit('${current.isbn}');"><img src="img/delete.png" width="15" height="13" align="right"></button>
									
								</td>
												
							</tr>
							
						</c:forEach>
					</table>
					
					<div id="pageNavPosition"></div>
				</form:form> --%>
					<div id="pageNavPosition"></div>
			</div>
		</section>
		<div class="clearfix"></div>
		<footer>
			<div id="footer">
	     	
	  		<div>Powered by <img src="img/sapient_nitro.jpg" width="78" height="14" alt="sapient nitro"></div>
	  		</div>
		</footer>
	</div>
	<script type="text/javascript">
		var pager = new Pager('tablepaging', 10);
		pager.init();
		pager.showPageNav('pager', 'pageNavPosition');
		pager.showPage(1);
	</script>


</body>
</html>