<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Book Detail</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet"
       href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
       src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
       src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/SapeStore/css/normalize.css"
       type="text/css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/SapeStore/css/main.css" type="text/css">
<script src="/SapeStore/js/vendor/modernizr-2.6.2.min.js"></script>
<script type="text/javascript"
       src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // Check Radio-box
    $(".stars input:radio").attr("checked", false);

    $('.stars input').click(function() {
           $(".stars span").removeClass('checked');
           $(this).parent().addClass('checked');
    });

    $('input:radio').change(function() {
           userRating = this.value;
    
    })
$('#textArea').keyup(function () {
var left = 100 - $(this).val().length;
if (left < 0) {
left = 0;
}
$('#counter').text('Characters left: ' + left);
});
    $("#comment").click(function(){

           if($('input[name=stars]:checked').length <= 0 && $("#textArea").val().trim()=="")
                 {$("#ratevalid").text("<spring:message code="label.error.rating"/>");
                $("#comvalid").text("<spring:message code="label.error.comment"/>");
                 }
                 
           else if ($('input[name=stars]:checked').length <= 0) {
                 $("#comvalid").text("");
                  $("#ratevalid").text("<spring:message code="label.error.rating"/>");
           }
           else   if($("#textArea").val().trim()=="")
                 {
                 $("#ratevalid").text("");
                 $("#comvalid").text("<spring:message code="label.error.rating"/>");
                 }
           else 
                 $("#reviewForm").submit();
                 
    })
    $("#cancel").click(function(){
           $("#comvalid").text("");
           $("#ratevalid").text("");
           $(".stars input:radio").attr("checked", false);
           $(".stars input:radio").parent().removeClass('checked');
           $("#textArea").text("");
           })
});
</script>
<link rel="stylesheet"
       href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style type="text/css">
div.stars {
  width: 270px;
  height:38px;
  display: inline-block;
}

input.star { display: none; }

label.star {
  float: right;
  padding: 10px;
  font-size: 36px;
  color: #444;
  transition: all .2s;
}

input.star:checked ~ label.star:before {
  content: '\f005';
  color: #FD4;
  transition: all .25s;
}

input.star-5:checked ~ label.star:before {
  color: #FE7;
  text-shadow: 0 0 20px #952;
}

input.star-1:checked ~ label.star:before { color: #F62; }

label.star:hover { transform: rotate(-15deg) scale(1.3); }

label.star:before {
  content: '\f006';
  font-family: FontAwesome;
}
.rating {
         float: left;
       width: 190px;
       margin-left:22%;
}

.rating span {
       float: right;
       position: relative;
}

.rating span input {
       position: absolute;
       top: 0px;
       left: 0px;
       opacity: 0;
}

.rating span label {
       display: inline-block;
       width: 30px;
       height: 30px;
       text-align: center;
       color: #FFF;
       background: #ccc;
       font-size: 30px;
       margin-right: 2px;
       line-height: 30px;
       border-radius: 50%;
       -webkit-border-radius: 50%;
}

.rating span:hover ~ span label, .rating span:hover label, .rating span.checked label,
       .rating span.checked ~ span label {
       background: #F90;
       color: #FFF;
}
</style>
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

table.yuir {
       border-collapse: collapse;
       font-size: small;
       margin-left:50px;
}

table.yuir td {
       padding: 5px;
}

table.yuir .even {
       background-color: #EEE8AC;
}

table.yuir .odd {
       background-color: #F9FAD0;
}

table.yuir th {
       padding-top: 13px;
       height: auto;
}

table.yuir th a {
       text-decoration: none;
       text-align: center;
       padding-right: 20px;
       font-weight: bold;
       white-space: nowrap;
}

table.yuir tfoot td {
       background-color: #E1ECF9;
}

table.yuir thead td {
       vertical-align: middle;
       background-color: #E1ECF9;
       border: none;
}

table.yuir thead .tableHeader {
       font-size: larger;
       font-weight: bold;
}

table.yuir thead .filter {
       text-align: right;
}

table.yuir tfoot {
       background-color: #E1ECF9;
       text-align: center;
}

table.yuir .tablesorterPager {
       padding: 10px 0 10px 0;
}

table.yuir .tablesorterPager span {
       padding: 0 5px 0 5px;
}

table.yuir .tablesorterPager input.prev {
       width: auto;
       margin-right: 10px;
}

table.yuir .tablesorterPager input.next {
       width: auto;
       margin-left: 10px;
}

table.yuir .pagedisplay {
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

#pageNavPositionread {
       float: right;
       background: white;
      
    /*    padding-left: 774px;
       margin-right: 15px; */
    /*   padding-bottom: 0.5em;
       padding-top: 0.5em;
       padding-right: 2px;  */
height: auto;
width: auto;
     /*   width: 1000px; */
}


.rating-static {
       width: 60px;
       height: 16px;
       display: block;
       background: "/SapeStore/img/ratings.jpg";
}

.reviewtext {
       font-size: 12px;
       color: #1d1d1d;
}

#container {
  height: 222px;
  width: 160px;
  position: relative;
}
#image {
  position: absolute;
  left: 0;
  top: 0;
}
#text {
  z-index: 100;
  position: absolute;
  color: red;
  font-size: 24px;
  font-weight: bold;
  left: 0px;
  top: 50px;
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
</head>

<body>

  <div id="wrapper">
            
  
              <%-- <div id="writecommentcontainer" style="display: none">
                     <div id="writecomment1" class="popup">
                            <jsp:include page="Comment1.jsp" flush="true" /> 
                     </div>
              </div> --%>

              <form:form name="form"
                     action="/SapeStore/bookListByCat?categoryId=${categoryId}&categoryName=${categoryName}&checkMe = false"
                     method="GET" commandName="welcome">
                     <header>
                           <div id="header">
                                  <a href="/SapeStore/welcome?checkMe=${checkMe}" title="SapeStore"
                                         class="logo"><img src="/SapeStore/img/logo_option 01.png"
                                         width="231" height="109" alt="SapeStore"></a>

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
                                                </c:choose>
                                                  <label for="checkMe" style="font-size: 13px;"><spring:message code="label.header.partnerstore"/>|</label> <input type="hidden" name="categoryId"
                                         value="${categoryId}" /> <input type="hidden" name="categoryName"
                                         value="${categoryName}" />
                                         </li>
                                         <li><a class='inline' href="#shoppingCart"><img
                                                       src="/SapeStore/img/icon_cart.jpg" width="15" height="12"
                                                       alt="cart"></a></li>
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
                                                <li class="active"><a
                                                       href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.header.home"/></a></li>
                                                <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <li><a href="personalInformation"><spring:message code="label.header.account"/></a></li>
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
                                                                     id="addToCart"><spring:message code="label.header.wishlist"/></a></li>
                                                       </c:otherwise>
                                                </c:choose>
                                                <jsp:include page="Logout.jsp" flush="true" />
                                                <li><a href="/SapeStore/welcome?checkMe=${checkMe}"><img
                                                              alt="searchImage" src="/SapeStore/img/magnifier-icon.png" height="30"></a></li>

                                         </ul>
                                  </nav>
                           </div>
                     </header>

                     <!-- header ends -->
                     <section>
                                  <div class="leftCol">
                                  <h3 style="
    font-size: 14px;
    color: #1d1d1d;
    font-family: Georgia;
    font-weight: bold;
    "><spring:message code="label.signup.bookcat"></spring:message></h3>
                                  <nav>
                                         <!-- left navigation -->
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
                     </section>

              </form:form>
<div style="height:550px"> 
                    <table style="margin-left: 10px; margin-top: 10px;">
                           <tr>
                                  <td><input type="hidden" id="isbno" value="${book.isbn }"></td>
                                  <td><c:choose>
                                   <c:when test="${book.quantity <= 0}">
                                  <div id="container"><div id="imgdiv" style="height: 222px; width: 152px;">
                                                <img src="/SapeStore/${book.bookThumbImage}" width="152" height="222"
                                                       alt="${book.bookTitle}">
                                         </div>
                                         <p id="text">
                                                SOLD OUT!!
                                               </p>
                                         </div>
                                          
                                                                            </c:when>    
                                            <c:otherwise>
                                         
                                         <div id="imgdiv" style="height: 222px; width: 152px;">
                                                <img src="/SapeStore/${book.bookThumbImage}" width="152" height="222"
                                                       alt="${book.bookTitle}">
                                         </div>
                                         
                           </c:otherwise>
                                         </c:choose>
                                         </td>
                                  <td><div id="desc"
                                                style="height: 222px; width: 200px; margin-left: 10px;">
                                                <table>
                                                       <tr>
                                                              <td
                                                                     style="font-size: 28px; font-family: SapientCentroSl; color: #000000;">${book.bookTitle}</td>
                                                       </tr>
                                                       <tr>
                                                              <td
                                                                     style="font-size: 18px; color: #000000; font-family: SapientSansRegular;">${book.bookAuthor}</td>
                                                       </tr>
                                                       <tr>
                                                                     <td><c:choose>
                                                                           <c:when
                                                                                  test="${book.averageRating >= 0 && book.averageRating < 0.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-0.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${book.averageRating >= 0.5 && book.averageRating < 1.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-1.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${book.averageRating >= 1.5 && book.averageRating < 2.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-2.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${book.averageRating >= 2.5 && book.averageRating < 3.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-3.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${book.averageRating >= 3.5 && book.averageRating < 4.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-4.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when test="${book.averageRating >= 4.5}">
                                                                                  <figure> <img src="/SapeStore/img/ratings-5.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                                  <figure> <img src="/SapeStore/img/ratings-0.jpg"
                                                                                         width="70" height="14" style="float: left;" alt="ratings" />
                                                                                  </figure>
                                                                           </c:otherwise>
                                                                     </c:choose><%-- <h6>
                                                                     ${ratings}
                                                                           Ratings
                                                                           ${reviews}
                                                                                  Reviews
                                                                     </h6> --%>
                                                                     
                                                                     
                                                              <span
                                                                     style="font-size: 12px;display:inline; clear:none; font-family: SapientSansRegular;float:left";>${ratings}
                                                                           <spring:message code="label.bookdetails.rating"></spring:message> |&nbsp;</span>
                                                                           <u>
                                                                           <a href="/SapeStore/readAll?isbn=${book.isbn} "
                                                                           style="font-size: 12px; color: #ff0000; font-family: SapientSansRegular; display:inline;  float:left"; clear:none;>${reviews}
                                                                                  <spring:message code="label.bookdetails.reviews"></spring:message></a></u> 
                                                                                  
                                                              </td>
                                                       </tr>
                                                       <tr>
                                                              <td
                                                                     style="font-size: 14px; color: #000000; font-family: SapientSansRegular;"><spring:message code="label.bookdetails.publisher"></spring:message>:
                                                                     ${book.publisherName}</td>
                                                       </tr>
                                                       <tr>
                                                              <td>  <c:choose>
                                                                           <c:when test="${not empty userId}">
                                                              <a href="/SapeStore/addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=p"
                                                                     title="Add To Cart" ><input type="button" name="buy" onclick="addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=p"
                                                                     style="height: 25px; width: 125px; background-color: #21addd; font-family: SapientSansRegular; color: white"
                                                                     value="<spring:message code="label.bookdetails.buy"></spring:message> $ ${book.bookPrice}" class="addCart" /></a></c:when> 
                                                                     <c:otherwise>
                                                                                 <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                                                  <span><a href="#login" title="review"
                                                                                         class="inline"
                                                                                         id="addToCart"><input type="button" name="buy"
                                                                     style="height: 25px; width: 125px; background-color: #21addd; font-family: SapientSansRegular; color: white"
                                                                     value="<spring:message code="label.bookdetails.buy"></spring:message> $ ${book.bookPrice}" class="addCart" /></a>   </span>
                                                                           </c:otherwise>
                                                                     </c:choose>
                                                                     
                                                                     <c:choose>
                                                                           <c:when test="${not empty userId}">
                                                                                  <span><a
                                                                                         href="/SapeStore/addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=p">
                                                                                                <img src="/SapeStore/img/add_cart.jpg" width="20"
                                                                                                height="20" alt="add to cart" />
                                                                                  </a></span>
                                                                           </c:when>
                                                                          <c:otherwise>
                                                                                  <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                                                  <span> <a href="#login" title="review"
                                                                                         style="color: red; font-size: 10px" class="inline"
                                                                                         id="addToCart"><img src="/SapeStore/img/add_cart.jpg"
                                                                                                width="20" height="20" alt="add to cart" /></a></span>
                                                                           </c:otherwise>
                                                                     </c:choose></td>

                                                       </tr>
                                                       <tr>
                                                              <td>
                                                                 <c:choose>
                                                                           <c:when test="${not empty userId}">  <a href="/SapeStore/addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=r""
                                                                     title="Add To Cart" >
                                                                  
                                                              <input type="button" name="rent"
                                                              
                                                                     style="height: 25px; width: 125px; background-color: #21addd; font-family: SapientSansRegular; color: white"
                                                                     onclick="addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=r";
                                                                     value="<spring:message code="label.bookdetails.rent"></spring:message> $ ${book.rentPrice}"
                                                                     class="addCart" /></a>
                                                                       </c:when>
                                                                          <c:otherwise>
                                                                                  <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                                                  <span> <a href="#login" title="review"
                                                                                        class="inline"
                                                                                         id="addToCart">  <input type="button" name="rent"
                                                              
                                                                     style="height: 25px; width: 125px; background-color: #21addd; font-family: SapientSansRegular; color: white"
                                                               
                                                                     value="<spring:message code="label.bookdetails.rent"></spring:message> $ ${book.rentPrice}"
                                                                     class="addCart" /></a></span>
                                                                           </c:otherwise>
                                                                     </c:choose>
                                                              <c:choose>
                                                                           <c:when test="${not empty userId}">
                                                                                  <span><a
                                                                                         href="/SapeStore/addDetailsToShoppingCart?categoryId=${book.categoryId}&categoryName=${book.categoryName}&checkMe=false&isbn=${book.isbn}&purchaseType=r">
                                                                                                <img src="/SapeStore/img/add_cart.jpg" width="20"
                                                                                                height="20" alt="add to cart" />
                                                                                  </a></span>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                                  <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                                                  <span> <a href="#login" title="review"
                                                                                         style="color: red; font-size: 10px" class="inline"
                                                                                         id="addToCart"><img src="/SapeStore/img/add_cart.jpg"
                                                                                                width="20" height="20" alt="add to cart" /></a></span>
                                                                           </c:otherwise>
                                                                     </c:choose></td>
                                                       </tr>

                                                </table>
                                         </div></td>
                                  <td>
                                         <div id="buttons" style="height: 222px; width: 222px;">
<br><br>

                                        <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <a href="#popUpWindow" data-toggle="modal"
                                                                     data-target="#popUpWindow"
                                                                     style="color: red; font-size: 10px; float:right;text-align: right;"><spring:message code="label.bookdetails.writereview"></spring:message></a>
                                                       </c:when>
                                                       <c:otherwise>
                                                              <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                              <a href="#login" title="review"
                                                                     style="color: red; font-size: 10px; float:right;text-align: right;" class="inline"
                                                                     id="addToCart"; text-align: right;><spring:message code="label.bookdetails.writereview"></spring:message>  </a>
                                                       </c:otherwise>
                                                </c:choose>
                                                
                                                
                                                <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <a href="/SapeStore/addToWishlist?isbnNumber=${book.isbn }"
                                                                     title="Add to wish list" style="color: red; font-size: 10px; float:right;";>+<spring:message code="label.bookdetails.addtowishlist"></spring:message> |</a>
                                                              
                                                       </c:when>
                                                       <c:otherwise>
                                                              <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to be able to post review.");
                                                                     }
                                                              </script>
                                                              <a href="#login" title="review"
                                                                     style="color: red; font-size: 10px; float:right;" class="inline"
                                                                     id="addToCart">+ <spring:message code="label.bookdetails.addtowishlist"></spring:message> |</a>
                                                       </c:otherwise>
                                                </c:choose>
                                                
                                                
                                                
                                                
                                         </div>
                                  </td>
                           </tr>
                     </table>
<table style="margin-left: 50px;" id="tablepagingread" class="yuir" >
                           <tr>
                                  <td style="font-size: 22px; color: #000000; font-family: SapientCentroSl;"><spring:message code="label.bookdetails.customerreviews"></spring:message></td>
                                  <td><a href="/SapeStore/viewBookDetails?isbn=${setIsbn}"
                                         style="color: red; font-size: 12px;"><spring:message code="label.read.less"></spring:message></a></td>
                           </tr>
                           
                           <c:forEach items="${reviewList}" var="current">
                                  <tr>
                                         <td style="font-size: 14px;font-weight:bolder; color: #000000; float: left;font-family:SapientSansRegular;">${current.userId}</td>
                                                <td>
                                                <c:choose>
                          <c:when test="${current.bookRating >= 0 && current.bookRating < 0.5}">
                          <figure><img src="/SapeStore/img/ratings-0.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:when test="${current.bookRating >= 0.5 && current.bookRating < 1.5}">
                          <figure><img src="/SapeStore/img/ratings-1.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:when test="${current.bookRating >= 1.5 && current.bookRating < 2.5}">
                          <figure><img src="/SapeStore/img/ratings-2.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:when test="${current.bookRating >= 2.5 && current.bookRating < 3.5}">
                          <figure><img src="/SapeStore/img/ratings-3.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:when test="${current.bookRating >= 3.5 && current.bookRating < 4.5}">
                          <figure><img src="/SapeStore/img/ratings-4.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:when test="${current.bookRating >= 4.5}">
                          <figure><img src="/SapeStore/img/ratings-5.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:when>
                          <c:otherwise>
                          <figure><img src="/SapeStore/img/ratings-0.jpg" width="98" height="14" style="float:left;" alt="ratings" /></figure>
                          </c:otherwise>
                  </c:choose> 
                                         </td>
                                         <td> &nbsp &nbsp &nbsp</td>
                                         <td style="float: left; font-size:14px;font-family:SapientSansRegular; color:#000000;"><fmt:formatDate value="${current.bookCommentDate}" pattern="dd MMM yyyy"/></td>
                                  </tr>
                                  <tr>
                                         <td>
                                                <p style="width:500px ;height:25px;">${current.bookComments}</p>
                                         </td>
                                  </tr>
                           </c:forEach>
                     </table>
                      <div id="pageNavPositionread">  <!-- align="center" --></div>
</div>        

                    
       </div> 
                   
               
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


       <!-- This contains the hidden content for shopping cart popup -->

       <!-- This contains the hidden content for login popup -->
       <div style="display: none">
              <div id="login" class="popup">


                     <%@include file="login.jsp"%>
              </div>
       </div>
        <div style="display: none">
                     <div id="shoppingCart" class="popup">
                    <jsp:include page="DisplayShoppingCart.jsp"></jsp:include>
                     </div>
              </div> 
             

                     <div class="modal fade" id="popUpWindow" style="display: none;">

                           <div class="modal-dialog">
                                  <div class="modal-content" style="padding: 5px 6px">
                                         <form id="reviewForm" action="addReview">
                                                <!-- Header -->
                                                <button type="submit" class="close" data-dismiss="modal">&times;</button>
                                                       <span> <div class="bg-danger" id="comvalid"></div>
                                                       <div class="bg-warning" id="ratevalid"></div>
                                                       <p style="font-size: 22px; font-family: SapientCentroSlab;"><spring:message code="label.write.review"></spring:message></p></span>
                                                       <span style="font-family:SapientSansMedium;  margin-left:26%;"><spring:message code="label.your.comment"></spring:message></span>
                                                <input type="hidden" name="isbn" value="${book.isbn }">
                                                <table>
                                                       <tr>
                                                              <td><img src="<c:url value="/${book.bookThumbImage}"/>"
                                                                     width="150px" height="234px"></td>
                                                              <td><textarea maxlength="100" id="textArea" name="comment"
                                                                           style="font-family: SapientSansRegular; margin-left: 5px; font-size: 14px;"
                                                                           placeholder="<spring:message code="label.your.comment"></spring:message>" rows="12" cols="64"></textarea></td>

                                                       </tr>
                                                       <tr><td style="font-family: SapientSansMedium;">${book.bookTitle}</td> <td style="float:right;"><p style="font-family: SapientSansMedium" id="counter"></p></td></tr>
                                                       <tr><td style="font-family: SapientSansRegular;">${book.bookAuthor}</td>
                                                </table>
                                                <!-- button -->
                                                <div class="modal-footer" style="display: none;"></div>
                                                <div class="stars">
                                                       <input class="star star-5" value="5" name="stars" id="star-5" type="radio" name="star"/>
    <label  class="star star-5" for="star-5"></label>
    <input name="stars" value="4" class="star star-4" id="star-4" type="radio" name="star"/>
    <label class="star star-4" for="star-4"></label>
    <input name="stars" value="3" class="star star-3" id="star-3" type="radio" name="star"/>
    <label class="star star-3" for="star-3"></label>
    <input name="stars" value="2" class="star star-2" id="star-2" type="radio" name="star"/>
    <label class="star star-2" for="star-2"></label>
    <input name="stars"class="star star-1" value="1" id="star-1" type="radio" name="star"/>
    <label class="star star-1" for="star-1"></label>
                                                </div>
                                         <span>
                                                <button type="button" style="width: 25%; right:10%;"
                                                       class="btn btn-primary" id="comment"><spring:message code="label.post.comment"></spring:message></button> </span>
                                                       <span> 
                                                <a href="" data-dismiss="modal"
                                           style="width: 10%; left: 85%; top: 87%; color:red;"
                                           id="cancel"><u><spring:message code="label.cancel.post"></spring:message></u></a>
                                                       </span>
                                                       <p style="font-family: SapientSansMedium" id="counter"></p>
                                         </form>
                                  </div>
                           </div>
                     </div>
                    
       <%-- <div id="bookDisplay" style="float: left">
              <img style="float:left;" height="222" width="152" src="${book.book_thumb_image}"/>
       </div>
       <div id=bookDisplay" style="float: left">
              
       </div>
       --%>
       <script type="text/javascript">
              var pager = new Pager('tablepagingread', 6);
              pager.init();
              pager.showPageNav('pager', 'pageNavPositionread');
              pager.showPage(1);
       </script>
       <script
              src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
       <script>
              window.jQuery
                           || document
                                         .write('<script src="/SapeStore/js/vendor/jquery-1.9.1.min.js"><\/script>')
       </script>
       <script src="/SapeStore/js/plugins.js"></script>
       <script src="/SapeStore/js/main.js"></script>
       <script>
              $(document)
                           .ready(
                                         function() {
                                                $(".inline").colorbox({
                                                       inline : true,
                                                       width : "auto",
                                                       height : "auto"
                                                });
                                                $(".callbacks")
                                                              .colorbox(
                                                                           {
                                                                                  onOpen : function() {
                                                                                         alert('onOpen: colorbox is about to open');
                                                                                  },
                                                                                  onLoad : function() {
                                                                                         alert('onLoad: colorbox has started to load the targeted content');
                                                                                  },
                                                                                  onComplete : function() {
                                                                                         alert('onComplete: colorbox has displayed the loaded content');
                                                                                  },
                                                                                  onCleanup : function() {
                                                                                         alert('onCleanup: colorbox has begun the close process');
                                                                                  },
                                                                                  onClosed : function() {
                                                                                         alert('onClosed: colorbox has completely closed');
                                                                                  }
                                                                           });

                                         });
              
       </script>
        <form action = "transactionHistory" id = "transactionForm"></form> 
        <form action = "getStatusPage" id = "orderStatusForm"></form> 
          <form action="personalInformation" id="editProfileForm"></form>
       <form action="welcome" id="homePageForm"></form>
       
</body>

</html>


