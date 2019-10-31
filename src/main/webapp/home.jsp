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
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script
       src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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

#containerhome {
  height: 180px;
  width: 131px;
  position: relative;
}
#imagehome {
  position: absolute;
  left: 0;
  top: 0;
  height: 180px;
  width: 131px;
}
#texthome {
  z-index: 100;
  position: absolute;
  color: red;
  font-size: 200px;
  font-weight: bold;
  left: 0px;
  top: 50px;
  width: 131px;
}
#containerlink{
height:38 px ;
width: 130px ;
position: relative;




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
       $("#butt").click(function(){
          var pattern = RegExp("^([a-zA-Z0-9 &*':.,_-]{0,})$");

          $("#valid").text("");
          var flag = 1;
                 if($("#isbno").val().trim().length>13)
                        { flag = 0;   
                        $("#valid").text("<spring:message code="label.search.maxcharacters"></spring:message>");}
                 if(!pattern.test($("#isbno").val().trim()))
                        {flag = 0;
                                   $("#valid").text("<spring:message code="label.search.validisbn"></spring:message>");}
                       if(!pattern.test($("#booktitle").val().trim()))
                       {flag = 0;
                     $("#valid").text("<spring:message code="label.search.validbooktitile"></spring:message>");}
                       if(!pattern.test($("#bookauthor").val().trim()))
                       {flag = 0;
                     $("#valid").text("<spring:message code="label.search.validbookauthor"></spring:message>");}
                       if(!pattern.test($("#publisher").val().trim()))
                       {flag = 0;
                     $("#valid").text("<spring:message code="label.search.validpublisher"></spring:message>");}
                       $("#abc").is(':checked') ? ($("#desc").val("true")) : ($("#desc").val("false"));
                     $("#partner").is(':checked') ? ($("#store").val("true")) : ($("#store").val("false"));
                    if (flag == 1)
                           {
                             $("#search").submit();
                                  
                           }
           });
});


$("#divdeps").dialog({
    autoOpen: false,
    show: 'slide',
    resizable: false,
    position: 'center',
    stack: true,
    height: 'auto',
    width: 'auto',
    modal: true
});
</script>
<!--  
<script>

$(document).ready(function(){

         if ($('#abc').is(':checked')) {

       $('#abc').attr('checked','checked');

         }
       
});

</script>


-->


<!-- <script>

   jQuery(function ($) {
                  //form submit handler
                         var flag=0;                     
                      if ($('#abc').is(':checked')) {
                          
                    $('#butt').click(function () {
                    flag=1;
                  });        
                }
                       if(flag==1)
                              { $('#abc').attr('checked','checked');}                        
              }); 
</script> -->



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
                     if($("#what").val()=="true")
                           {
                           $("#desc").val("true");
                           $('#abc').prop('checked', true);
                           }
                     else $('#abc').prop('checked', false);
                     if($("#store").val()=="true"){
                           $("#part").val("true");
                           $('#partner').prop('checked', true);
                           }
                     else{
                           $('#partner').prop('checked', false);
                     }
              checkLogin(flag);
              }
       function checkLogin(flag){
         
                if(flag=="1")
                              jQuery(function(){
                                                  jQuery('#loginPop').click();
                                   document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+">Username or password is incorrect</span>";
                                                              });
                  
              if(flag=="4")
                alert("Successfully registered. Please log in!")
                
                if(flag=="7") 
                       alert("This email ID does not exist in our records!")
       }
</script>
</head>

<body onload="start(${flag})">






<script type="text/javascript">
       $(document).ready(function(){
       $("#loginPop").click();
      ("#loginPopwish").click();
       $(this).find('input[type=text], select').each(function(){
        if($(this).val() == "") {
            $('#message').val="Please enter values in atleast one filter";
            console.log("Hello");
        }
       }); 
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
                                                       <input type="checkbox" name="checkMe" id="checkMe"
                                                              style="font-size: 13px;" onclick="form.submit();">
                                                </c:when>
                                                <c:otherwise>
                                                       <input type="checkbox" name="checkMe" id="checkMe"
                                                              style="font-size: 13px;" onclick="form.submit();"
                                                              checked="checked">
                                                </c:otherwise>
                                         </c:choose>
                                          <label for="checkMe" style="font-size: 13px;"><spring:message code="label.signup.includebooks"></spring:message></label> <input type="hidden" name="categoryId"
                                         value="${categoryId}" /> <input type="hidden" name="categoryName"
                                         value="${categoryName}" />
                              
                                  </li>
                                  <li><c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <a class='inline' href="#shoppingCart"><img
                                                src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a>
                                                       </c:when>
                                                       <c:otherwise>
                                                             <a class='inline' href="#shoppingCart"><img
                                                src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a>
                                                       </c:otherwise>
                                                </c:choose>
                                  </li>
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
                                         href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message code="label.homepage.home"></spring:message></a></li>
                                  

                                   <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <li><a href="/SapeStore/wishlistcontroller" ><spring:message code="label.homepage2"></spring:message></a></li>
                                                              
                                                       </c:when>
                                                       <c:otherwise>
                                                              <script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to add to wishlist");
                                                                     }
                                                              </script>
                                                              <li ><a href="#loginwish" title="review" class="inline"
                                                                     id="addToCart"><spring:message code="label.homepage4"></spring:message></a></li>
                                                       </c:otherwise>
                                                </c:choose>
                                  <jsp:include page="Logout.jsp" flush="true" />
                                  <li><a href="/SapeStore/faqs?checkMe=${checkMe}">FAQs</a></li>
                                  <li><a href="/SapeStore/chat"><spring:message code="label.homepage3"></spring:message></a></li>
                                         <li><a href="/SapeStore/Search"><img alt="searchImage" src="img/magnifier-icon.png" height="30"></a></li>
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

        <div id="mainContent">
        
         

<br>
        <c:choose>
                               <c:when test="${categoryName =='Top Rated'}">
                                 <h2><spring:message code="label.home.toprated"></spring:message></h2>
                                                </c:when>
                                                </c:choose>
                          
                     <div class="clearfix"></div>
                     <c:choose>
                     <c:when test="${search == 'true'}">
                     <div id="search_parameters">
                           <h2><spring:message code="label.search.searchbook"></spring:message></h2>
                           <hr style="border-top:1px dashed; width:97%"/>
                           <form id ="search" action="/SapeStore/Search" method="post">

                                  <label style="margin-left: 55px; font-size: 15px"><spring:message code="label.search.booktitle"></spring:message></label> 
                                  <label style="margin-left: 245px; font-size: 15px"><spring:message code="label.search.bookauthor"></spring:message></label>
                                  <div style="margin: 0 auto; width: 95%; text-align: center">
                                  <input type="text" id="booktitle" name="bookTitle" style="width: 315px; height: 30px;" placeholder="<spring:message code="label.search.booktitle"></spring:message>" value="${bookTitle}"> 
                               <input type="text" id="bookauthor" name="bookAuthor" style="width: 315px; height: 30px;" placeholder="<spring:message code="label.search.bookauthor"></spring:message>" value="${bookAuthor}">
                                  </div>
                                  <br /> <label style="margin-left: 66px"><spring:message code="label.search.isbn"></spring:message></label> <label
                                         style="margin-left: 165px"><spring:message code="label.search.bookcat"></spring:message></label> <label
                                         style="margin-left: 80px"><spring:message code="label.search.publisher"></spring:message></label> <br />
                                  <div style="margin: 0 auto; width: 95%; text-align: center">
                                         <input type="text" id="isbno" name="isbn" style="width: 200px; height: 30px" placeholder="<spring:message code="label.search.isbn"></spring:message>" value="${isbn}">
                                         <select name="categoryId" style="width: 200px; height: 36px">
                                                <option selected="selected" value="-1"><spring:message code="label.search.selectcategorybook"></spring:message></option>
                                                <c:forEach items="${selectList}" var="current">
                                                <c:choose>
                                                <c:when test="${current.categoryId == categoryId}">
                                                       <option value="${current.categoryId}" selected="selected">${current.categoryName}</option>
                                                </c:when>
                                                <c:otherwise>
                                                       <option value="${current.categoryId}">${current.categoryName}</option>
                                                </c:otherwise>
                                                </c:choose>
                                                </c:forEach>
                                         </select> 
                                         <input type="text" id="publisher"  name="publisherName" style="width: 200px; height: 30px" placeholder="<spring:message code="label.search.publisher"></spring:message>" value="${publisherName}">
                                  </div>
                                  <span><p style="color: red;margin-left:100px; " id="valid"></p></span>
                                  <br />
                                  <div style="margin: 0 auto; width: 95%; text-align: center">
                                                <input type="checkbox" id="abc" class="pinToggles">  <label><spring:message code="label.search.searchbycomments"></spring:message></label> <input type="checkbox" id="partner"> <label><spring:message code="label.search.searchinpartnerstore"></spring:message></label>
                                  </div>
                                  <br />
                                  <div style="margin: 0 auto; width: 95%; text-align: center">
                                         <input type="button" value="<spring:message code="label.search.searchbutton"></spring:message>" id="butt"
                                                style="width: 200px; height: 40px; background-color: #299bd8; color: #FFFFFF;border: none;font-size:20px">
                                    <input type="hidden" name="desc" id="desc" value="">     
                                    <input type="hidden" name="what" id="what" value="${desc}">
                                    <input
                                                              type="hidden" name="part" id="part" value=""> <input
                                                              type="hidden" name="store" id="store" value="${part}">
                                  </div> 
                                                 
                           </form>
                     </div>
                     </c:when>
                     </c:choose>
                    <c:choose>
                     <c:when test="${message == 'No result found.'}">
                           <p style="color: red; text-align: center"> <spring:message code="label.search.noresult"></spring:message> </p>
                     </c:when>
                     <c:when test="${message == 'Please provide at least one of the search filter value.'}">
                     <p style="color: red; text-align: center"> <spring:message code="label.search.atleastenterafield"></spring:message>
                     </p></c:when>
                     </c:choose>
                                                       
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
                     
                                  
                                  
                                  
                                  
                                  
                     <form name="addtoshoppingcartForm" action="addToShoppingCart"
                           method="GET">
                           <ul>
                                  <c:forEach items="${bookList}" var="current">
                     
                                         <c:choose>
                                         <c:when test="${current.quantity <=0 }">
                                         
                                         
                                                                    <li> <div id="containerhome"><a href="viewBookDetails?isbn=${current.isbn}">     
                                                       <img src="<c:url value="/${current.bookThumbImage}" />" id="imagehome"
                                                       alt="${current.bookTitle}" />
                                                       <p id="texthome" style="color: red; background-color:white; width: 131px; ">
                                                       SOLD OUT!!
                                                       </p>
                                                       </a>
                                                       
                                                       </div>
                                                       <div id="containerlink">
                                                       <a href="viewBookDetails?isbn=${current.isbn}" title="{current.title}" >
                                                          <span>${current.bookTitle}</span>
                                                       <p>${current.bookAuthor}</p>
                                                       </a>
                                                       </div>
                                          
                                         
                                         
                                         
                                         <c:choose>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 0 && current.averageRating < 0.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-0.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 0.5 && current.averageRating < 1.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-1.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 1.5 && current.averageRating < 2.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-2.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 2.5 && current.averageRating < 3.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-3.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 3.5 && current.averageRating < 4.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-4.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when test="${current.averageRating >= 4.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-5.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-0.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:otherwise>
                                                                     </c:choose>
                                                <p class="price">$${current.bookPrice}</p> <c:choose>
                                                       <c:when test="${not empty userId}">
                                                              <a
                                                                     href=""
                                                                     title="Add To Cart" class="addCart" onclick=""> <img
                                                                     src="img/add_cart.jpg" width="15" height="13"
                                                                     alt="add to cart" />
                                                              </a>
                                                              
                                                              <div id="divdeps" style="display:none" title="">Sold Out!!!</div>
                                                                
                                                                                                                                                                        </c:when>
                                                       <c:otherwise>
                                                              <script type="text/javascript">
                            function alertIt()
                            {
                                   alert("Please login to be able to use the cart.");
                            }
                          </script><!-- 
                                                              <a href="#login" title="Add To Cart" class="addCart inline"
                                                                     id="addToCart"><img src="img/add_cart.jpg" width="15"
                                                                     height="13" alt="add to cart" /></a> -->
                                                                      <a
                                                                     href="#soldout"
                                                                     title="Add To Cart" class="addCart" onclick=""> <img
                                                                     src="img/add_cart.jpg" width="15" height="13"
                                                                     alt="add to cart" />
                                                              </a>
                                                              <div id="divdeps" style="display:none" title="">Sold Out!!!</div>
                                                       </c:otherwise>
                                                </c:choose></li>
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         </c:when>
                                         
                                         <c:otherwise>
                                                                    <li><a href="viewBookDetails?isbn=${current.isbn}" title="${current.bookTitle}">     
                                                       <img src="<c:url value="/${current.bookThumbImage}" />" width="131" height="180"
                                                       alt="${current.bookTitle}" />   <span>${current.bookTitle}</span>
                                                       <p>${current.bookAuthor}</p>
                                         </a>  <c:choose>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 0 && current.averageRating < 0.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-0.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 0.5 && current.averageRating < 1.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-1.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                   test="${current.averageRating >= 1.5 && current.averageRating < 2.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-2.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 2.5 && current.averageRating < 3.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-3.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when
                                                                                  test="${current.averageRating >= 3.5 && current.averageRating < 4.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-4.jpg" width="98"
                                                                                                height="14"  alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:when test="${current.averageRating >= 4.5}">
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-5.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                                  <figure>
                                                                                         <img src="/SapeStore/img/ratings-0.jpg" width="98"
                                                                                                height="14" alt="ratings" />
                                                                                  </figure>
                                                                           </c:otherwise>
                                                                     </c:choose>
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
                                                               <a
                                                                     href="/SapeStore/addToShoppingCart?categoryId=${current.categoryId}&categoryName=${categoryName}&checkMe=${checkMe}&isbn=${current.isbn}"
                                                                     title="Add To Cart" class="addCart"> <img
                                                                     src="img/add_cart.jpg" width="15" height="13"
                                                                     alt="add to cart" />
                                                              </a>
                                                       </c:otherwise>
                                                </c:choose></li>
                                         
                                         </c:otherwise>
                                         
                                         
                                         </c:choose>
                              
                                  </c:forEach>
                           </ul>
                     </form>

              <form action = "transactionHistory" id = "transactionForm"></form> 
        <form action = "getStatusPage" id = "orderStatusForm"></form> 
         <form action="personalInformation" id="editProfileForm"></form>
              <form action="/" id="homePageForm"></form> 

        </form> 
              </div>
              </section>
              <div id="pageNavPosition1" align="center"></div>
              <div class="clearfix"></div>

                                        <footer style="background:#dfe5e6; width:1002px;margin:auto;">
                                         <div id="footer">
                                                                    <div style="float: left;">
                                                                    <a style="color: #21addd;" href="/SapeStore/welcome?language=en">English</a> |
                                                                    <a style="color: #21addd;" href="/SapeStore/welcome?language=nl">French</a>
                           </div>
                           <div style="float: left; margin-left: 305px;">
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
              
                <div id="loginwish" class="popup">


                    <%@include file="loginwish.jsp"%> 
              </div>
       </div>

       <!-- Forgot password-->
       <div style="display: none">
              <form method="get" action="forgot" id="forgotPassword1"
                     onsubmit="return ValidateForm();">
                     <fieldset>
                           <label for="email">Enter your email id<span class="required">*</span></label>
                           <input type="email" placeholder="Name" required="" name="email">
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


