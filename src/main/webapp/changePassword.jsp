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

<link rel="stylesheet" href="../css/normalize.css" type="text/css">
<link rel="stylesheet" href="../css/main.css" type="text/css">
<script src="../js/vendor/modernizr-2.6.2.min.js"></script>
<script src="..///ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<link rel="stylesheet"
       href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
       text-align:left;
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

hr{
    border-top: 2px dashed darkgrey;
    width:80%;
    margin-left:0;

}
/* #subButton{
position:relative;
right: 24em;
width: 8em;
height: 30px;
background-color: #21addd;
color: white;
} */
</style>
</head>

<body>
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
                                  class="logo"><img src="../img/logo_option 01.png" width="231"
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
                                                src="../img/icon_cart.jpg" width="15" height="12" alt="cart"></a></li>
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
                                                       <option value="-1" style="font-size: 10px;">Welcome
                                                              ${username}</option>
                                                       <option value="1" style="font-size: 10px;">Account</option>
                                                       <option value="2" style="font-size: 10px;">Order Status
                                                              Tracking</option>
                                                       <option value="3" style="font-size: 10px;">Transaction
                                                              History</option>
                                                </select>
                                         </c:when>
                                  </c:choose>
                           </ul>
                           <nav>
                           <ul class="nav">
                                  <li class="active"><a
                                         href="/SapeStore/welcome?checkMe=${checkMe}">HOME</a></li>
                                  <c:choose>
                                         <c:when test="${not empty userId}">
                                                <li><a href="personalInformation">Account</a></li>
                                         </c:when>

                                  </c:choose>

                                   <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <li><a href="/SapeStore/wishlistcontroller" >Wishlist</a></li>
                                                              
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
                                         <li><a href="/SapeStore/Search"><img alt="searchImage" src="../img/magnifier-icon.png" height="30"></a></li>
                           </ul>
                           </nav>
                     </div>
                     </header>
                     <!-- header ends -->
                     <section>
                    
              </form:form>
<div id="mainContent">

              
              <form action="../changePasswordSubmit" id="form" method="post">
                     <input type="hidden" name="email" value="${emailid }">
                     
                     <h1>Reset Password</h1>
                     <hr>
                     <label id="password" style="font-size: 16px">New Password<span class="required">*</span></label> 
                     <br>
                     
                     <input type="password" name="password" id="passwordfield" style="width:200px;"/>
                     <br/>
                     <label id="password" style="font-size: 16px">Confirm Password<span class="required">*</span>
                                         </label><br>
                                         
                     <input type="password" id="newPassword" style="width:200px;"/> <br><br>
                                  
                                  
                                  <div id="wrongDiv" style="display: none;color:red;">Incorrect Password</div>
                           <div id="wrongDivLength" style="display: none;color:red;">Please enter characters above 6 digits</div>
                     
                     
                     <button type="button" id="subButton" class="btn btn-primary" style="width:200px;">Reset Password</button>
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
                           Powered by <img src="../img/sapient_nitro.jpg" width="78" height="14"
                                  alt="sapient nitro">
                     </div>
              </div>
              </footer>
       </div>

<script>
       $(document).ready(function () {
              $("#subButton").click(function() {
                     var first = $("#passwordfield").val();
                     var second = $("#newPassword").val();
                     if(first != second) {
                           $("#wrongDiv").show();
                     }
                     else if(first.length <6 ) {
                           $("#wrongDivLength").show();
                     } else {
                           $("#form").submit();
                           alert("PASSWORD RESET!!");
                     }
              });
       });
</script>
<!-- <script>
$(document).ready(function(){
       $("#subButton").css({
              position: 'relative',
              right: '24em',
              width: '8em',
              height: '30px',
              'background-color': '#21addd',
              color: 'white',
       });
});
</script> -->
      
</body>
</html>



