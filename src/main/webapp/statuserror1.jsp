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

.dash{
  border: 0 none;
  border-top: 2px dashed grey;
  background: none;
  height:0;
  margin-right: 30px;
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

var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> Â« Prev </span> ';

for (var page = 1; page <= this.pages; page++)

pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next Â»</span>';

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
       
       function allnumeric(inputtxt)  
       {  
          var numbers = /^[0-9]+$/;  
          if(inputtxt.value.match(numbers))  
          {  
        
          document.form1.text1.focus();  
          return true;  
          }  
          else  
          {  
          alert('Please input numeric characters only');  
          document.form1.text1.focus();  
          return false;  
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
<script>
	var reg= /^\d+$/; 
	function validate() {
			if($("#numberField").val()=="") {
				$("#nerrorDiv").show();
				$("#serrorDiv").hide();
				$("#showDetails").hide();
			}else if(!reg.test($("#numberField").val())) {
				
				$("#nerrorDiv").hide();
				$("#serrorDiv").show();
				$("#showDetails").hide();
	        }else {
				$("#submitForm").submit();
			}
		}
</script>
</head>

<body>

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
                                         </c:choose> <label for="checkMe" style="font-size: 13px;">Include
                                                books from Partner Store</label> <input type="hidden" name="categoryId"
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
								<option value="2" style="font-size: 10px;"><spring:message code="label.headerdropdown.orderstatus1"/></option>
								<option value="-1" style="font-size: 10px;"><spring:message code="label.headerdropdown.welcome"/>
                                                              ${username}</option>
								<option value="1" style="font-size: 10px;"><spring:message code="label.transactionhistory.header"/></option>

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
                                                <li  class="active"><a href="personalInformation"><spring:message code="label.header.account"/></a></li>
                                         </c:when>

                                  </c:choose>

                                      <c:choose>
								<c:when test="${not empty userId}">
									<li><a href="/SapeStore/wishlistcontroller" ><spring:message code="label.header.wishlist"/></a></li>
									
								</c:when>
								<c:otherwise>
									<script type="text/javascript">
										function alertIt() {
											alert("Please login to add to wishlist");
										}
									</script>
									<li class="active"><a href="#login" title="review" class="inline"
										id="addToCart">WISHLIST</a></li>
								</c:otherwise>
							</c:choose>
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
                           <h2><spring:message code="label.transactionhistory.header"/></h2>
                           <nav> <!-- left navigation -->
                           <ul>
                                  <li><a href="personalInformation"  style="font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.personalinfo"/></a></li>
                                  <li><a href="transactionHistory" style="font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.transactionHistory"/></a></li>
                                  <li><a href="orderstatus.jsp" style="color: #cacfd0; font-family : 'SapientSansMedium'"><spring:message code="label.headerdropdown.orderstatus"/></a></li>
                           </ul>
                           </nav>
                     </div>
              </form:form>

              <div id="mainContent">
                     <h2 style="font-family: SapientSansMedium; font-size: 22px;"><spring:message code="label.orderstatus.heading"/></h2>
                     <br><br>
                     <hr class="dash">
                     <div class="clearfix"></div>

                     <form action="/SapeStore/trackOrder" id="submitForm">
                     <p style="font-family: SapientSansMedium; font-size: 15px;"><spring:message code="label.orderstatus.heading1"/><span style="font-family: SapientSansMedium; font-size: 15px; color: #de2728; ">*</span></p> 
                     <input type="text"  id="numberField" name="orderId">&nbsp
                     <input type="button" onclick="validate()" value="<spring:message code="label.orderstatus.button1"/>" style="font-family: Sapient Centro Slab; font-size: 15px; color: #ffffff; background-color: #21addd">
                     </form>
                     <div id="nerrorDiv" style="color: red; display: none">
                     	Please enter a value
                     </div>
                     <div id="serrorDiv" style="color: red; display: none">
                     	Please enter an integer
                     </div>
                     
                     <form action="/SapeStore/trackOrderType">
                     <p style="font-family: SapientSansMedium; font-size: 15px;"><spring:message code="label.orderstatus.heading2"/><span style="font-family: SapientSansMedium; font-size: 15px; color: #de2728; ">*</span></p> 
                     <select name="orderType">
                     	  <option value="PURCHASED">Purchased</option>
						  <option value="RENTED" selected="selected">Rented</option>
                     </select>&nbsp
                     <input type="submit" value="<spring:message code="label.orderstatus.button2"/>" style="font-family: Sapient Centro Slab; font-size: 15px; color: #ffffff; background-color: #21addd">
                     </form>
                     
                     <div id="showDetails">
                     <p style="font-family: SapientSansRegular; font-size: 15px;"><spring:message code="label.orderstatus.error1"/><span style="font-family: SapientSansMedium; font-size: 15px; text-decoration: underline ;color: #de2728; ">${orderType}</span>.</p>
                     </div>
                     
                     
                     
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

              <footer>

              <div id="footer">
                     <div style="float: left; margin-left: 386px;">
                           <a href="/SapeStore/contactUsCustomer" style="color: #21addd;">Contact
                                  Us</a>
                     </div>
                     <div style="float: left; margin-left: 6px; color: #21addd">|</div>

                     <div style="float: left; margin-left: 7px;">
                           <a href="/SapeStore//policyCustomer" style="color: #21addd;">Privacy
                                  Policy</a>
                     </div>
                     <div>
                           Powered by <img src="img/sapient_nitro.jpg" width="78" height="14"
                                  alt="sapient nitro">
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
        <form action="personalInformation" id="editProfileForm"></form>
	<form action="welcome" id="homePageForm"></form>

</body>
</html>
