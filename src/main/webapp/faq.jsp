<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
       href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
       src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
       src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Home</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css" type="text/css">
<link rel="stylesheet" href="css/main.css" type="text/css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script>
       $(document).ready(function() {
              $("#button2").click(function () {
                           $("#demo2").show();
                           $("#demo1").hide();
                           $("#demo3").hide();
                           $("#demo4").hide();
                           $("#demo5").hide();
                           $("#demo6").hide();
                           $("#demo7").hide();
                           $("#demo8").hide();
                           
                     });
              $("#button3").click(function () {
                     $("#demo3").show();
                     $("#demo1").hide();
                     $("#demo2").hide();
                     $("#demo4").hide();
                     $("#demo5").hide();
                     $("#demo6").hide();
                     $("#demo7").hide();
                     $("#demo8").hide();
                     
              });
              $("#button1").click(function () {
                     $("#demo1").show();
                     $("#demo2").hide();
                     $("#demo3").hide();
                     $("#demo4").hide();
                     $("#demo5").hide();
                     $("#demo6").hide();
                     $("#demo7").hide();
                     $("#demo8").hide();
                     
              });
              $("#button4").click(function () {
                     $("#demo4").show();
                     $("#demo1").hide();
                     $("#demo3").hide();
                     $("#demo2").hide();
                     $("#demo5").hide();
                     $("#demo6").hide();
                     $("#demo7").hide();
                     $("#demo8").hide();
                     
              });
              $("#button5").click(function () {
                     $("#demo5").show();
                     $("#demo1").hide();
                     $("#demo3").hide();
                     $("#demo4").hide();
                     $("#demo2").hide();
                     $("#demo6").hide();
                     $("#demo7").hide();
                     $("#demo8").hide();
                     
              });
              $("#button6").click(function () {
                     $("#demo6").show();
                     $("#demo1").hide();
                     $("#demo3").hide();
                     $("#demo4").hide();
                     $("#demo5").hide();
                     $("#demo2").hide();
                     $("#demo7").hide();
                     $("#demo8").hide();
                     
              });
              $("#button7").click(function () {
                     $("#demo7").show();
                     $("#demo1").hide();
                     $("#demo3").hide();
                     $("#demo4").hide();
                     $("#demo5").hide();
                     $("#demo2").hide();
                     $("#demo6").hide();
                     $("#demo8").hide();
                     
              });
              $("#button8").click(function () {
                     $("#demo8").show();
                     $("#demo1").hide();
                     $("#demo3").hide();
                     $("#demo4").hide();
                     $("#demo5").hide();
                     $("#demo2").hide();
                     $("#demo7").hide();
                     $("#demo6").hide();
                     
              });
              });
</script>
</head>
<body>
       <div id="wrapper">
              <div style="display: none">
                     <div id="shoppingCart" class="popup">
                           <jsp:include page="DisplayShoppingCart.jsp" flush="true" />
                     </div>
              </div>
              <form:form name="form" action="bookListByCat" method="post">
                     <!-- header starts-->
                     <header>
                     <div id="header">
                           <a href="/SapeStore/welcome?checkMe=${checkMe}" title="SapeStore"
                                  class="logo"><img src="img/logo_option 01.png" width="231"
                                  height="109" alt="SapeStore"></a>
                           <ul class="topLinks">
                                  <li>
                                         <!--form:checkbox id="checkMe" path="checkMe" value="Include books from Partner Store" onchange="form.submit();"/-->
                                         <input type="checkbox" name="checkMe" id="checkMe"
                                         style="font-size: 13px;" value="Include books from Partner Store"
                                         disabled="disabled" onclick="form.submit();"> <label
                                         for="checkMe" style="font-size: 13px;"><spring:message code="label.header.partnerstore"></spring:message></label> <input type="hidden" name="categoryId"
                                         value="%{categoryId}" /> <input type="hidden" name="categoryName"
                                         value="%{categoryName}" />
                                  </li>
                                  <li><a class='inline' href="#shoppingCart"><img
                                                src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a></li>
                                  <li><c:choose>
                                                <c:when test="${ShoppingCart.totalQuantity==0}">
                                                </c:when>
                                                <c:otherwise>
                                                       <li class="cartNum">${ShoppingCart.totalQuantity}</li>
                                                </c:otherwise>
                                         </c:choose></li>
                           </ul>
                           <nav>
                           <ul class="nav">
                                  <li class="active"><a
                                         href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.header.home"></spring:message></a></li>
                                  <li><a href="personalInformation"><spring:message code="label.header.account"></spring:message></a></li>
                                  <li><c:choose>
                                                <c:when test="${not empty userId}">
                                                       <li><a href="/SapeStore/wishlistcontroller"><spring:message code="label.header.wishlist"></spring:message></a></li>

                                                </c:when>
                                                <c:otherwise>
                                                       <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to add to wishlist");
                                                                     }
                                                              </script>
                                                       <li class="active"><a href="#login" title="review"
                                                              class="inline" id="addToCart"><spring:message code="label.header.wishlist"></spring:message></a></li>
                                                </c:otherwise>
                                         </c:choose></li>
                                  <c:choose>
                                         <c:when test="${empty userId}">
                                                <li><a href="#login" class='inline' title="Login"
                                                       id="loginPop"><spring:message code="label.login.login"></spring:message></a></li>

                                         </c:when>
                                         <c:otherwise>
                                                <li><a href="/SapeStore/logout"><spring:message code="label.header.logout"></spring:message></a></li>
                                         </c:otherwise>
                                  </c:choose>
                                  <li><a href="/SapeStore/Search"><img alt="searchImage" src="img/magnifier-icon.png" height="30"></a></li>
                           </ul>
                           </nav>
                     </div>
                     </header>
                     <!-- header ends -->
                     <section>
                     <div class="leftCol" style="height: 1000px">
                           <h2><spring:message code="label.signup.bookcat"></spring:message></h2>
                           <nav> <!-- left navigation -->

                           <ul>
                                  <c:forEach items="${catList}" var="current">
                                         <li
                                                <c:if test="%{#globalCategoryName==categoryName}">
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
                     </section>
              </form:form>
                     
              <div class="container">
                     <div style="width: 85%; text-align: center">
                           <h2 style="font-size: 20px; margin-top: 40px; margin-bottom: 20px">
                                  <u>FAQ's</u>
                           </h2>
                     </div>
                     <button type="button" id="button1" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo1">
                           <b><spring:message code="label.faq.question1"></spring:message></b>
                     </button>
                     <div id="demo1" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer1"></spring:message>
                     </div>
                     </br> </br>
                     <button type="button" id="button2" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo2">
                           <b><spring:message code="label.faq.question2"></spring:message></b>
                     </button>
                     <div id="demo2" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px;width:85%"><spring:message code="label.faq.answer2"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button3" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo3">
                           <b><spring:message code="label.faq.question3"></spring:message></b>
                     </button>
                     <div id="demo3" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer3"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button4" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo4">
                           <b><spring:message code="label.faq.question4"></spring:message></b>
                     </button>
                     <div id="demo4" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer4"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button5" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo5">
                           <b><spring:message code="label.faq.question5"></spring:message></b>
                     </button>
                     <div id="demo5" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer5"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button6" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo6">
                           <b><spring:message code="label.faq.question6"></spring:message></b>
                     </button>
                     <div id="demo6" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer6"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button7" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo7">
                           <b><spring:message code="label.faq.question7"></spring:message></b>
                     </button>
                     <div id="demo7" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer7"></spring:message></textfield>
                     </div>
                     </br> </br>
                     <button type="button" id="button8" class="btn btn-info"
                           style="width: 770px; margin-left: 10px"
                           data-target="#demo8">
                           <b><spring:message code="label.faq.question8"></spring:message></b>
                     </button>
                     <div id="demo8" class="collapse" style="width: 85%">
                           <textfield style="font-size:15px;margin-left:10px"><spring:message code="label.faq.answer8"></spring:message></textfield>
                     </div>
                     </br> </br>
                     </div>
                           
              <div class="clearfix"></div> 
                <footer>
              <div id="footer" style="width:1003px;">
                     <div style="float: left; margin-left: 386px;">
                           <a href="/SapeStore/contactUsCustomer" style="color: #21addd;"><spring:message code="label.faq.contact"></spring:message></a>
                     </div>
                     <div style="float: left; margin-left: 6px; color: #21addd">|</div>

                     <div style="float: left; margin-left: 7px;">
                           <a href="/SapeStore//policyCustomer" style="color: #21addd;"><spring:message code="label.faq.privacypolicy"></spring:message></a>
                     </div>
                     <div>
                           <spring:message code="label.signup.powered"></spring:message> <img src="img/sapient_nitro.jpg" width="78" height="14"
                                  alt="sapient nitro">
                     </div>
              </div>
              </footer>
              </div>
              <!-- This contains the hidden content for login popup -->
              <div style="display: none">
                     <div id="login" class="popup">
                           <jsp:include page="login.jsp" flush="true" />
                     </div>
              </div>

              <!-- Forgot password-->
              <div style="display: none">
                     <form method="post" action="" id="forgotPassword"
                           onsubmit="return ValidateForm();">
                           <fieldset>
                                  <label for="email"><spring:message code="label.faq.email"></spring:message><span
                                         class="required">*</span></label> <input type="email" placeholder="Name"
                                         required="" name="name"> <input type="submit"
                                         value="Submit" class="lightButton">
                                  <div id="someHiddenDiv" style="display: none"><spring:message code="label.faq.passmsg"></spring:message></div>
                           </fieldset>
                     </form>
              </div>
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



