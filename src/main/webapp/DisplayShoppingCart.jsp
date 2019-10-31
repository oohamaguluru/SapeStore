
<%-- DisplayShoppingCart.jsp  --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
       padding: 5px;
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

#emptyp {
       position: absolute;
       top: 55%;
       left: 60%;
       margin-top: -100px;
       margin-left: -200px;
       font-family: Centro Slab;
       font-size: larger;
}

.round {
       width: 30px;
       height: 30px;
       background-color: white;
       border-radius: 50%
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

.discount{
color: Orange;
font-family:fantasy;
font-style:sans-serif;
font-size: 20px;
font-stretch: wider;
}
#pageNavPosition {
       float: right;
       padding-left: 774px;
       padding-bottom: 2em;
       padding-top: 0.5em;
       padding-right: 2px;
       padding-left: 740px;
       margin-right: 7px;
}

hr {
       border-top-style: dashed;
       width: 95%;
       margin-left: 0;
       border-width: thin;
}

.scroller1{
	height: 250px;
		width: 826px; 
}

</style>





<script src="https://code.jquery.com/jquery-1.12.4.min.js"
       integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
       crossorigin="anonymous"></script>
<script>

window.onunload = refreshParent;
function refreshParent() {
    window.opener.location.reload();
}

$(document).ready(function(){
       $("button").click(function(){
              var bid=this.id;
       
              if(bid.substring(0,1)=='b')
                     {
                     var isbn= bid.substring(2);
                     var type = bid.substring(1,2);
              
              $.ajax({
                     url:"deleteFromShoppingCart",
                     data: ({"isbn" :  isbn, "purchaseType" : type}),
                     success: function(data){
                           $("#cartdiv").html(data);
                     }
              })
                     }
              else if(bid.substring(0,1)=='q')
                     {
                     var isbn= bid.substring(2);
                     var type = bid.substring(1,2);
                     
                     var cquantity=$('#'+isbn).val();
                     var dquantity=$('#u'+isbn).val();
                     var cartq=parseInt(cquantity)+1;
                     if(cartq>dquantity){
                           $("#maxq").text("Sorry! No more books available");
                     }
                     else{
              $.ajax({
                     url:"updateQuantity",
                     data: ({"isbn" :  isbn, "purchaseType" : type}),
                     success: function(data){
                           $("#cartdiv").html(data);
                     }
              })}
                     }
                           else if(bid.substring(0,1)=='m')
              {
                     var isbn= bid.substring(2);
                     var type = bid.substring(1,2);
       
       $.ajax({
              url:"reduceQuantity",
              data: ({"isbn" :  isbn, "purchaseType" : type}),
              success: function(data){
                     $("#cartdiv").html(data);
              }
       })
              }
       }),
       
$('.select').change( function() {

       var bid=this.id;
       
       if(bid.substring(0,1)=='u')
              {
              var isbn= bid.substring(2);
              var type = bid.substring(1,2);
              
    $.ajax({ 
       url:"updateType",
              data: ({"isbn" :  isbn, "purchaseType" : type}),
              success: function(data){
                     $("#cartdiv").html(data);
              }
    }); 
}
});
}
)

</script>

<html>

<body onload="refreshParent()">
       <div id="cartdiv">
              <c:choose>
                     <c:when test="${empty ShoppingCart.booksInCart}">
                           <div>

                                  <div class='inline'>
                                         <h2>
                                                <img src="img/ShoppingCarticon.png" width="20" height="17"
                                                       alt="cart">&nbsp <spring:message code="label.cart.yourcart"/>
                                         </h2>
                                  </div>
                                  <br> <br>
                                 
                                  <hr>
                                  <div class="scroller">
                                         <table id="emptytable" class="yui1">
                                                <thead>
                                                       <p id="emptyp">
                                                       
                                                              <span><spring:message code="label.cart.emptycart"/></span>
                                                       </p>
                                                </thead>
                                         </table>
                                  </div>
                           </div>
                           <hr>
                           
                     </c:when>
                     <c:otherwise>
                           <form:form name="cart" action="shippingAddressForm" method="GET">
                                    <div class='inline'><h2><img src="img/ShoppingCarticon.png" width="17" height="17" alt="cart">&nbsp<spring:message code="label.cart.yourcart"/></h2></div>
                                  <div class="scroller">
                                         <table id="tablepaging" class="yui" cellspacing="10px" cellpadding="5px">
                                                <%-- Display the heading of the shoppingCart --%>
                                                <thead>
                                                       <tr>
                                                              <th><spring:message code="label.cart.item"/></th>
                                                              <th width="100px"></th>
                                                              <th></th>
                                                              <th><spring:message code="label.cart.qty"/></th>
                                                              <th></th>
                                                              <th><spring:message code="label.cart.trans"/></th>
                                                              <th><spring:message code="label.cart.price"/></th>
                                                              <th><spring:message code="label.cart.subtotal"/></th>
                                                              <th></th>
                                                       </tr>
                                                </thead>

                     
                                                <c:forEach items="${ShoppingCart.booksInCart}" var="current">
                                                       <tbody>
                                                       
                                                              <tr id="row">

                                                                     <td style="width: 60px"><img src="${current.thumbPath}"
                                                                           width="81" height="112" alt="product name"></td>
                                                                     <c:choose>
                                                                           <c:when test="${current.purchaseType  == 'p'}">
                                                                                  <td align="left">${current.bookTitle}</td>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                                  <td align="left">${current.bookTitle}<br> Book return Date:
                                                                                  <div style="color: red"><fmt:formatDate
                                                       value="${current.returnDate}" pattern="dd MMM yyyy" />     </div>

                                                                                  </td>
                                                                           </c:otherwise>

                                                                     </c:choose>
																	 <td><button class="round" type="button"
                                                                                  id="q${current.purchaseType}${current.isbn}">
                                                                                  <img src="img/plus.png" width="15" height="12" alt="cart">
                                                                           </button></td>
                                                                     <td>${current.cartQuantity}</td>
                                                                    
                                                                     <td><button type="button" class="round"
                                                                                  id="m${current.purchaseType}${current.isbn}">
                                                                                  <img src="img/minus.png" width="15" height="12" alt="cart">
                                                                           </button></td>


                                                                     	<c:choose>
												<c:when test="${current.purchaseType  == 'p' && current.cartQuantity>= 5}" >
												<td><select class="select"
													id="u${current.purchaseType}${current.isbn}">
														<option value="p" selected="selected">Purchase</option>
														<option value="r">Rent</option>
												</select></td>
										  			<td>$${current.bookPrice }</td>
											 <fmt:parseNumber var="subTotal" integerOnly="true" pattern="0.0" value="${current.cartQuantity * current.bookPrice* 0.9 }" />
											 	  <td> <c:out value="$${subTotal}"  /></td>
											<!--  <td>$${current.cartQuantity * current.bookPrice* 0.9 }</td>-->
												</c:when>
												<c:when test="${current.purchaseType  == 'p' && current.cartQuantity< 5}" >
												<td><select class="select"
													id="u${current.purchaseType}${current.isbn}">
														<option value="p" selected="selected">Purchase</option>
														<option value="r">Rent</option>
												</select></td>
												<!--<fmt:parseNumber var="bookPrice" integerOnly="true" pattern="0" value="${current.bookPrice }" /> -->
										  			<td>$${current.bookPrice }</td>
											 <fmt:parseNumber var="subTotal" integerOnly="true" pattern="0.0" value="${current.cartQuantity * current.bookPrice}" />
											 	  <td> <c:out value="$${subTotal}"  /></td>
							
												</c:when>
									
											<c:otherwise>
												<td><select class="select"
													id="u${current.purchaseType}${current.isbn}">
														<option value="p">Purchase</option>
														<option value="r" selected="selected">Rent</option>
												</select></td>
												<td>$${current.rentPrice}</td>
												<td>$${current.cartQuantity * current.rentPrice}</td>
											</c:otherwise>

										</c:choose>
                                                                     
                                                                     <td><input type="hidden" name="isbn"
                                                                           value="${current.isbn}" />

                                                                           <button type="button"
                                                                                  id="b${current.purchaseType}${current.isbn}"
                                                                                  class="round"><img src="img/remove1.png" width="15" height="15" alt="cart"></button> <input type="hidden"
                                                                           name="cquantity" value="${current.cartQuantity}"
                                                                           id="${current.isbn}" /> <input type="hidden" name="dquantity"
                                                                           value="${current.quantity}" id="u${current.isbn}" /> </td>
                                                                           
                                                              </tr>                  
                                                       </tbody>
                                                       
                                                </c:forEach>
                                                
                                         </table>
                                  </div>
                                  <hr>
                                  <div style="color: red; height:30px; font-family: SapientSansRegular;" id="maxq"></div>
                         
                                  <div align="left" class="discount"> <spring:message code="label.cart.discount"/></div><div align="right">
                                     <spring:message code="label.cart.total"/> : $${ShoppingCart.totalPrice}</div>
                                         
                           
                                  
                                  
                                
                                  <hr>
                                  <div>
                                         <input type="submit" value="<spring:message code="label.cart.checkout"/>" class="lightButton checkout">
                                  </div>
                           </form:form>
                     </c:otherwise>
              </c:choose>


              <div>
                     <br>

                     <form action="/SapeStore/">
                           <input style="width: 300px" type="submit" value="<spring:message code="label.cart.continue"/>"
                                  class="lightButton">
                     </form>

              </div>


       
       </div>
</html>
