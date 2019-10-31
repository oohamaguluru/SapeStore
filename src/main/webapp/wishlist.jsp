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

.dotted {
  border:none;
  border-top:3px dotted;
  color:#d3d3d3;
  height:1px;
  width:95%;
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
	function start(flag) {
		checkLogin(flag); 
		search_view();
	
	
		}
       function search_view() {
              var parts = window.location.search.substr(1).split("&");
              var $_GET = {};
              for (var i = 0; i < parts.length; i++) {
                  var temp = parts[i].split("=");
                  $_GET[decodeURIComponent(temp[0])] = decodeURIComponent(temp[1]);
              }
              var search_click = $_GET.search;
              if(search_click == 'true')
              {
                     document.getElementById('search_parameters').style.display='block';
              }
       }
       function checkLogin(flag){
    		if(flag=="1")
    			alert("username or password is incorrect")
    	}

      	function outofstock(){

      		//document.getElementById("errorout").innerHTML=" Cannot add to cart !!! Book is out of Stock";
      		alert("Cannot add to cart !!! Book is out of Stock")
          	}
</script>
</head>

<body onload="start(${flag})">

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
       }
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
                                                       <input type="checkbox" name="checkMe" id="checkMe" disabled="disabled"
                                                              style="font-size: 13px;" onclick="form.submit();">
                                                </c:when>
                                                <c:otherwise>
                                                       <input type="checkbox" name="checkMe" id="checkMe" disabled="disabled"
                                                              style="font-size: 13px;" onclick="form.submit();"
                                                              checked="checked">
                                                </c:otherwise>
                                         </c:choose> <label for="checkMe" style="font-size: 13px;"><spring:message code="label.signup.includebooks"></spring:message></label> <input type="hidden" name="categoryId"
                                         value="${categoryId}" /> <input type="hidden" name="categoryName"
                                         value="${categoryName}" />
                                  </li>
                                  <li><a class='inline' href="#shoppingCart"><img
                                                src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a></li>
                                  <c:choose>
                                                <c:when test="${ShoppingCart.totalQuantity==0}">
                                                </c:when>
                                                <c:otherwise>
                                                 <li class="cartNum">${ShoppingCart.totalQuantity}</li>
                                                </c:otherwise>
                                                </c:choose>
                                  <c:choose>
                                         <c:when test="${not empty userId}">
                                               <select id="account" name="account" style="font-size: 12px;"
								onchange="changeVal()">
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
                                  <li><a
                                         href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.header.home"/></a></li>
                                   <c:choose>
                                          <c:when test="${not empty userId}">
                                  <li><a href="personalInformation"><spring:message code="label.header.account"/></a></li>
                                  </c:when>

                                  </c:choose>

                                 <%--  <li><a href="/SapeStore/welcome?checkMe=${checkMe}">Wishlist</a></li> --%>
                                <!--  <li><a href="/SapeStore/wishlistcontroller">Wishlist </a> </li> -->
                                 <c:choose>
								<c:when test="${not empty userId}">
									<li class="active"><a href="/SapeStore/wishlistcontroller" ><spring:message code="label.header.wishlist"/></a></li>
									
								</c:when>
								<c:otherwise>
									<script type="text/javascript">
										function alertIt() {
											alert("Please login to add to wishlist");
										}
									</script>
									<li class="active"><a href="#login" title="review" class="inline"
										id="addToCart"><spring:message code="label.header.wishlist"/></a></li>
								</c:otherwise>
							</c:choose>
                                 
                                 
                                  <jsp:include page="Logout.jsp" flush="true" />
                                  
                                         <li><a
                                                href="/SapeStore/Search?checkMe=${checkMe}&search=true"><img
                                                       alt="searchImage" src="img/magnifier-icon.png" height="30"></a></li>
                                
                           </ul>
                           </nav>
                     </div>
                     </header>
                     <!-- header ends -->
                     
                     <section>
                     <div class="leftCol">
                           <h2><spring:message code="label.signup.bookcat"></spring:message></h2>
                           <nav> <!-- left navigation -->
                           <ul>
                                  <c:forEach items="${catList}" var="current">
                                         <li
                                                <c:if test="${categoryName==current.categoryName}">
                     class="highlighted"
                     </c:if>>
                                                <a
                                                href="/SapeStore/bookListByCat?categoryId=${current.categoryId}&categoryName=${current.categoryName}&checkMe=${checkMe}"
                                                title="${current.categoryName}"> ${current.categoryName }</a>
                                         </li>
                                  </c:forEach>

                           </ul>
                           </nav>
                     </div>
              </form:form>

              <section> </section>
			
			
			
			
			
			
			
			

              <div id="mainContent">
              
                     
                     <h2>${categoryName}</h2>
                     <div class="clearfix"></div>

                     <div id="search_parameters" style="display: none">
                           <hr />
                           <label style="margin-left: 55px; font-size: 15px">Book Title</label>
                           <label style="margin-left: 245px; font-size: 15px">Book
                                  Author</label>
                           <div style="margin: 0 auto; width: 95%; text-align: center">
                                  <input type="text" style="width: 315px; height: 30px;"> <input
                                         type="text" style="width: 315px; height: 30px;">
                           </div>
                           <br /> <label style="margin-left: 66px">ISBN</label> <label
                                  style="margin-left: 165px">Book Category</label> <label
                                  style="margin-left: 80px">Publisher</label> <br />
                           <div style="margin: 0 auto; width: 95%; text-align: center">
                                  <input type="text" style="width: 200px; height: 30px"> <select
                                         style="width: 200px; height: 36px">
                                         <c:forEach items="${catList}" var="current">
                                                <option value="${current.categoryName}">${current.categoryName}</option>
                                         </c:forEach>
                                  </select> <input type="text" style="width: 200px; height: 30px">
                           </div>
                           <br />
                           <div style="margin: 0 auto; width: 95%; text-align: center">
                                  <input type="checkbox"> <label><a href="bookByMaxComments">Search by Max number of Comments</a></label> <input type="checkbox"> 
                                         <label>Search
                                         in Partner Store</label>
                           </div>
                           <br />
                           <div style="margin: 0 auto; width: 95%; text-align: center">
                                  <input type="button" value="Search"
                                         style="width: 200px; height: 40px; background-color: cyan; border: none;">
                           </div>
                     </div>
					
					
					<form name="addtoshoppingcartForm" action="addToShoppingCart"
                           method="GET">
                           <ul>
                                  <c:forEach items="${bookListByMaxComments}" var="current">
                                                <li><a href="viewBookDetails?isbn=${current.isbn}" title="${current.bookTitle}">     
                                                       <img src="<c:url value="/${current.bookThumbImage}" />" width="131" height="180"
								alt="${current.bookTitle}" />   <span>${current.bookTitle}</span>
                                                       <p>${current.bookAuthor}</p>
                                         </a> <figure>
                                                <img src="img/ratings.jpg" width="98" height="14" alt="ratings" /></figure>
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
			
					<div style="font-family: 'SapientCentroSlab-Medium'; font-size: 22px; color: #1d1d1d;" ><spring:message code="label.wishlist.yourcart"/></div>
					
					<table id="tablepaging" class="yui" cellspacing="30" cellpadding="10">
                                         <thead>
                                                <tr>
                                                     
                        
                                                       
                                                       <th style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: #1d1d1d;  " align="left"><spring:message code="label.wishlist.items"/></th>
                                                       <th style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: #1d1d1d; "><spring:message code="label.wishlist.qty"/></th>
                                                       <th style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: #1d1d1d; "><spring:message code="label.wishlist.available"/></th>
                                                       <th style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: #1d1d1d; "><spring:message code="label.wishlist.price"/></th>
                                                      
                                                       
                                                </tr>
                                         </thead>
                                         <hr class="dotted" />
                                         <tbody>
                                         <c:forEach items="${booklist}" var="book">
                                                <tr>
                                                       <td>
                                                              <img src="<c:url value="/${book.bookThumbImage}" />" width="80" height="110"
                                                       alt="Image" /> 
                                                       
                                                      <%--  <a href="viewBookDetails?isbn=${book.isbn}", target="_blank">${book.bookTitle} </a> --%>
                                                      <%--  <a href="viewBookDetails?isbn=${book.isbn}"  onclick="window.open('viewBookDetails?isbn=${book.isbn}', 'newwindow', 'width=1200, height=1000'); return false;"> ${book.bookTitle} </a>
                                                          --%>
                                                         <a href="viewBookDetails?isbn=${book.isbn}", target="_blank">${book.bookTitle} </a>
                                                         
                                                          
                                                          <br><div id="errorout"></div>
                                                                                                          
                                                       </td>
                                                      
                                                       
                                                       <td>${book.quantity}</td>
                                                       <td>
                                                       <c:if test="${book.rentAvailability =='Y'}" >
                                                  
                                                       <spring:message code="label.wishlist.yes"/>
                                                       </c:if>
                                                       <c:if test="${book.rentAvailability =='N'}" >
                                                       <spring:message code="label.wishlist.no"/>
                                                       </c:if>
                                                        </td>
                                                       <td>$ ${book.bookPrice}</td>
                                                       <td>
                                                       
                                                       <%-- <c:if test="${book.quantity > 0}">
                                                       <a href="/SapeStore/addToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=${checkMe}&isbn=${book.isbn}"
                                                                     title="Add To Cart" > 
                                                             <img src="/SapeStore/img/add_cart.jpg" width="20"
														height="20" alt="add to cart" style="color: gray;"  />
                                                              </a>
                                                       
                                                       </c:if> --%>
                                                       
                                                       <c:choose>
                                                       <c:when test="${book.quantity > 0}">
                                                        <a href="/SapeStore/addToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=${checkMe}&isbn=${book.isbn}"
                                                                     title="Add To Cart" > 
                                                             <img src="/SapeStore/img/add_cart.jpg" width="20"
														height="20" alt="add to cart" "  />
                                                              </a>
                                                       
                                                       </c:when>
                                                       <c:otherwise>
                                                       <a  href="" onclick="outofstock()">
                                                       <img src="/SapeStore/img/add_cart.jpg" width="20"
														height="20" alt="add to cart" "  />
                                                       </a>
                                                       
                                                       
                                                       
                                                       
                                                       </c:otherwise>
                                                       
                                                       </c:choose>
                                                      
                               
                                                       
                                                        
                                                           
                                                              </td>
                                                     <td><a href="/SapeStore/deletefromwishlist?isbn=${book.isbn}"><spring:message code="label.wishlist.deletebook"/></a></td> 
                                                     
                                                     <td><c:choose>
                                                     <c:when test="${book.quantity > 0 }">
                                                     <c:choose>
                                                     <c:when test="${book.rentAvailability =='Y'}">
                                                     <a href="/SapeStore/addToShoppingCartRent?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}" style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: red; "><spring:message code="label.wishlist.rent"/></a>
                                                     </c:when>
                                                     <c:otherwise>
                                                      <a href="" onclick="alert('Cannot Rent this book!!')" style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: red; "><spring:message code="label.wishlist.rent"/></a>
                                                    
                                                     </c:otherwise>
                                                     
                                                     </c:choose>
                                                     
                                                     
                                                     </c:when>
                                                     <c:otherwise>
                                                     
                                                     <a href="" onclick="alert('Book not available for Rent!!')" style="font-family: 'SapientCentroSlab-Medium'; font-size: 16px; color: red; "><spring:message code="label.wishlist.rent"/></a>
                                                     </c:otherwise>
                                                     
                                                     
                                                     
                                                     </c:choose></td>     
                                                       
                                                </tr>
                                                 
                                               
                                  </c:forEach>
                               <!--   
                                 <tr>
                                               
                                               <div id="errorout"></div></tr> -->
                                  
                                         </tbody>
                                          <div id="pageNavPosition1"  align="center"></div>
                                            
                                  </table>
                                  
                                 
								
					
					
					
                   

  <form action = "transactionHistory" id = "transactionForm"></form> 
        <form action = "getStatusPage" id = "orderStatusForm"></form> 
	  <form action="personalInformation" id="editProfileForm"></form>
	<form action="/" id="homePageForm"></form>

        
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

</body>
</html>