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

#btn {
	background-color: #008CBA;
	color: white;
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

table.wwFormTable tr {
	margin: 0 0 10px 0;
}
</style>
<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
       
       function isValidEmail(emailAddress) {
           var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
           return pattern.test(emailAddress);
       };
       function isValidPassword(pass){
          var pattern = "(?=^[!@#$%\^&*()_-+=[{]};:<>|./?a-zA-Z\d]{8,}$)(?=([!@#$%\^&*()_-+=[{]};:<>|./?a-zA-Z\d]\W+){1,})(?=[^0-9][0-9])[!@#$%\^&*()_-+=[{]};:<>|./?a-zA-Z\d]*$";
                 return pattern.test(pass); 
       }
       function isValidateFullName(usern){
          var pattern = RegExp("^([a-zA-Z0-9]{0,})$");
          return pattern.test(usern);
       }
       function isValidateLoginId(useri){
          var pattern = RegExp("^([a-zA-Z0-9._]{0,})$");
          return pattern.test(useri);
       }
       function submitForm() {
           var state = $("#stateid").val();
                     document.getElementById("statevalue").value = state;
                     var usern = $("#userN").val().trim();
                     var useri = $("#userI").val().trim();
                     var pass = $("#pass").val().trim();
                     var confpass = $("#confpass").val().trim();
                     var em = $("#em").val().trim();
                     var al1 = $("#al1").val().trim();
                     var al2 = $("#al2").val().trim();
                     var zc = $("#zc").val().trim();
                     var ph = $("#ph").val().trim();
                     var mob = $("#mob").val().trim();
                    
                     var flag = 0;
                     
                     if(usern.length==0) {
                            $("#userNerror").show();
                            flag=1;
                     }else if(usern.length>50){
                          $("#userNerror").text("<spring:message code="label.signup.userNameMax"/>");
                          $("#userNerror").show();
                          flag=1;
                     }else if(!usern.match(/^[a-zA-Z ]+$/)){
                          $("#userNerror").text("<spring:message code="label.signup.userNameSpl"/>");
                          $("#userNerror").show();
                          flag=1
                     }else {
                          $("#userNerror").hide();
                     }
                     
                     if(useri.length==0) {
                            $("#userIerror").text("<spring:message code="label.signup.userIdBlank"/>");
                            $("#userIerror").show();
                            flag=1;
                     }else if(useri.length>20){
                          $("#userIerror").text("<spring:message code="label.signup.userIdMax"/>");
                               $("#userIerror").show();
                               flag=1;
                         }else if(!useri.match(/^(?=.*?[A-Z])([a-zA-Z0-9._]{6,})$/)){
                             $("#userIerror").text("<spring:message code="label.signup.userIdMatch"/>");
                             $("#userIerror").show();
                             flag=1;
                         }else{
                          $("#userIerror").hide();
                     }
                     
                     if(pass.length==0) {
                            $("#passerror").text("<spring:message code="label.signup.passwordBlank"/>")
                            $("#passerror").show();
                            flag=1;
                     }else if(pass.length>16){
                             $("#passerror").text("<spring:message code="label.signup.passwordMax"/>")
                              $("#passerror").show()
                              flag=1
                         }else if(!pass.match(/^(?=.*?[0-9]).{8,}$/)){
                          $("#passerror").text("<spring:message code="label.signup.passwordMatch"/>")
                          $("#passerror").show()
                          flag=1;
                     }else{ 
                          $("#passerror").hide();
                     }
                     
                     if(em.length==0) {
                            $("#emerror").text("<spring:message code="label.signup.emailBlank"/>");
                            $("#emerror").show();
                            flag=1;
                     }else if(em.length>50){
                             $("#emerror").text("<spring:message code="label.signup.emailMax"/>");
                                $("#emerror").show();
                                flag=1;
                         }else if (!(isValidEmail(em))) {
                            $("#emerror").text("<spring:message code="label.signup.emailValid"/>");
                            $("#emerror").show();
                            flag=1;
                     }else {
                          $("#emerror").hide();
                     }
                     
                     if(al1.length==0) {
                            $("#al1error").show();
                            flag=1;
                     }else if(al1.length>25){
                          $("#al1error").text("<spring:message code="label.signup.address1Max"/>");
                          $("#al1error").show();
                               flag=1;
                     }else{
                          $("#al1error").hide();
                     } 
                     
                     if(al2.length>25){
                             $("#al2error").text("<spring:message code="label.signup.address1Max"/>");
                             $("#al2error").show();
                                flag=1;
                        }
                      
                     var reg= /^\d+$/;
                     if(zc.length==0) {
                            $("#zcerror").show();
                            flag=1;
                     }else if(zc.length>6){
                          $("#zcerror").text("<spring:message code="label.signup.incorrectMsg"/>")
                          $("#zcerror").show();
                          flag=1
                     }else if(!reg.test(zc)) {
                                                $("#zcerror").show();
                                                flag=1;
                        }else {
                          $("#zcerror").hide();
                     }
                     
                     if(confpass.length==0){
                          $("#confpasserror").text("<spring:message code="label.signup.passBlank"/>");
                          $("#confpasserror").show();
                               flag=1;
                     }else if(confpass.length>16){
                             $("#confpasserror").text("<spring:message code="label.signup.passwordMax"/>");
                                $("#confpasserror").show();
                                flag=1;
                         }else if(pass!=confpass) {
                            $("#confpasserror").show();
                            flag=1;
                     }else if(pass==confpass) {
                          $("#confpasserror").hide();
                     }
                     
                     if(mob.length==0) {
	                      $("#moberror").text("<spring:message code="label.signup.mobileBlank"/>")
                         $("#moberror").show();
                         flag=1;
                     }else if(mob.length>10){
                         $("#moberror").text("<spring:message code="label.signup.incorrectMsg"/>");
                         $("#moberror").show();
                         flag=1;
                     }else if((mob.length<10 && mob.length>0)||!reg.test(mob)) {
                         $("#moberror").text("<spring:message code="label.signup.incorrectMsg"/>")
                         $("#moberror").show();
                         flag=1;
                         }else{
                         $("#moberror").hide();
                         } 

                     
                     if(ph.length==0) {
                                              $("#pherror").hide();
                        }else if(ph.length>10){
                             $("#pherror").text("<spring:message code="label.signup.incorrectMsg"/>");
                                $("#pherror").show();
                                flag=1;
                         }else if(!reg.test(ph)) {
                                                $("#pherror").show();
                                                flag=1;
                    }else {
                                             $("#pherror").hide();
                        }
                     
                     /*if(CheckPasswordStrength(pass)<=1)
                       {
                       $("#passerror").text("Please Enter a Proper password!");
                     $("#passerror").show();
                     flag=1;
                       }*/
                         
                     if(flag==0) {
                            $("#mainform").submit();
                     }
                     
       }
</script>
<script>
       function getcities() {
              var state = $("#stateid").val();
              document.getElementById("statevalue").value = state;
              var usern = $("#userN").val();
              var useri = $("#userI").val();
              var pass = $("#pass").val();
              var confpass = $("#confpass").val();
              var em = $("#em").val();
              var al1 = $("#al1").val();
              var al2 = $("#al2").val();
              var zc = $("#zc").val();
              var ph = $("#ph").val();
              var mob = $("#mob").val();
              
              
              document.getElementById("name").value = usern;
              document.getElementById("userId").value = useri;
              document.getElementById("password").value = pass;
              document.getElementById("confpassword").value = confpass;
              document.getElementById("email").value = em;
              document.getElementById("add1").value = al1;
              document.getElementById("add2").value = al2;
              document.getElementById("postalcode").value = zc;
              document.getElementById("phone").value = ph;
              document.getElementById("mobile").value = mob;

              $("#getCitiesForm").submit();
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
<script type="text/javascript">
function CheckUserName(){
       var checkUname=document.getElementbyId("userN");
       if(/^[a-zA-Z ]*$/.exec(checkUname)){
              return 1;
       }else{
              return 2;
              }
} 
</script>
<script type="text/javascript">
   function CheckPasswordStrength(password) {
        var password_strength = document.getElementById("pass");

        //TextBox left blank.
        if (password.length == 0) {
            password_strength.innerHTML = "";
            return 0;
        }

        //Regular Expressions.
        var regex = new Array();
        regex.push("[A-Z]"); //Uppercase Alphabet.
        regex.push("[a-z]"); //Lowercase Alphabet.
        regex.push("[0-9]"); //Digit.
       //Special Character.

        var passed = 0;

        //Validate for each Regular Expression.
        for (var i = 0; i < regex.length; i++) {
            if (new RegExp(regex[i]).test(password)) {
                passed++;
            }
        }
        
        var regex = new Array();
        regex.push("[$@$!%*#?&]");
        for (var i = 0; i < regex.length; i++) {
            if (new RegExp(regex[i]).test(password)) {
                passed=0;
            }
        }

        //Validate for length of Password.
       
 
        //Display status.
        var color = "";
        var strength = "";
        switch (passed) {
            case 0:
            case 1:
                strength = "Weak";
                color = "black";  
                break;
            case 2:
                strength = "Good";
                color = "black";
                break;
            case 3:
            case 4:
                strength = "Strong";
                color = "black";
                break;
            case 5:
                strength = "Very Strong";
                color = "black";
                break;
        }
        password_strength.innerHTML = strength;
        password_strength.style.color = color;
        
      
       return passed;
        
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
<script>

          function start(flag) {
                 check(flag);
                 if(flag!=2) {
                 loadOpts();
                 }
          }
       function check(flag) {
              if(flag==1) setTimeout(function() {alert("<spring:message code="label.signup.alert"/>");}, 1);
       }
       function loadOpts() {
          getcities();
       }
</script>

</head>
<style>
body {
	font-family: 'SapientSansRegular'
}
</style>
<body onload="start(${flag})">

	<script type="text/javascript">
$(document).ready(function(){
       $("#loginPop").click();
});


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
									disabled="disabled" style="font-size: 13px;"
									onclick="form.submit();">
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="checkMe" id="checkMe"
									disabled="disabled" style="font-size: 13px;"
									onclick="form.submit();" checked="checked">
							</c:otherwise>
						</c:choose> <label for="checkMe" style="font-size: 13px;"><spring:message
								code="label.signup.partnerStore" /></label> <input type="hidden"
						name="categoryId" value="${categoryId}" /> <input type="hidden"
						name="categoryName" value="${categoryName}" />
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
								<option value="-1" style="font-size: 10px;"><spring:message
										code="label.signup.welcome" /> ${username}
								</option>
								<option value="1" style="font-size: 10px;"><spring:message
										code="label.signup.editprofile" /></option>
								<option value="2" style="font-size: 10px;"><spring:message
										code="label.signup.orderstatus" /></option>
								<option value="3" style="font-size: 10px;"><spring:message
										code="label.signup.transac" /></option>
							</select>
						</c:when>
					</c:choose>
				</ul>
				<nav>
				<ul class="nav">
					<li class="active"><a
						href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message
								code="label.signup.home" /></a></li>
					<c:choose>
						<c:when test="${not empty userId}">
							<li><a href="/SapeStore/welcome?checkMe=${checkMe}"><spring:message
										code="label.signup.account" /></a></li>
						</c:when>

					</c:choose>

					<%-- <li><a href="/SapeStore/welcome?checkMe=${checkMe}">Wishlist</a></li> --%>
					<c:choose>
						<c:when test="${not empty userId}">
							<li class="active"><a href="/SapeStore/wishlistcontroller"><spring:message
										code="label.signup.wish" /></a></li>

						</c:when>
						<c:otherwise>
							<script type="text/javascript">
                                                                     function alertIt() {
                                                                           alert("Please login to add to wishlist");
                                                                     }
                                                              </script>
							<li class="active"><a href="#login" title="review"
								class="inline" id="addToCart"><spring:message
										code="label.signup.wishlist" /></a></li>
						</c:otherwise>
					</c:choose>



					<jsp:include page="Logout.jsp" flush="true" />
					<li><a href="/SapeStore/Search"><img alt="searchImage"
							src="img/magnifier-icon.png" height="30"></a></li>
				</ul>
				</nav>
			</div>
			</header>
			<!-- header ends -->
			<section>
			<div class="leftCol">
				<h2>
					<spring:message code="label.signup.bookcat" />
				</h2>
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
			</section>

		</form:form>



		<div id="mainContent">
			<h2>
				<spring:message code="label.signup.signup" />
			</h2>
			<div class="clearfix"></div>
			<form:form method="post" action="signUpSubmit" id="mainform"
				commandName="editUserVO">


				<table class="wwFormTable">
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.fullname" /><span class="required">*</span>
						</label></td>
						<td><form:input path="user.name" id="userN"
								onfocus="CheckUserName(this.value)" /></td>
						<td><form:errors path="user.name" /><span id="userNerror"
							style="color: red; display: none;"><spring:message
									code="label.signup.provfull" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.preflogin" /><span class="required">*</span>
						</label></td>
						<td><form:input path="user.userId" id="userI" /></td>
						<td><form:errors path="user.userId" /><span id="userIerror"
							style="color: red; display: none;"><spring:message
									code="label.signup.userIdBlank" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.loginpass" /><span class="required">*</span>
						</label></td>
						<td><form:password path="user.password" id="pass"
								value="${pass }" /></td>
						<td><form:errors path="user.password" /><span id="passerror"
							style="color: red; display: none;"><spring:message
									code="label.signup.passwordBlank" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.repass" /><span class="required">*</span> </label></td>
						<td><input type="password" id="confpass" value="${cpass }"></td>
						<td><span id="confpasserror"
							style="color: red; display: none;"><spring:message
									code="label.signup.passBlank" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.emailadd" /><span class="required">*</span>
						</label></td>
						<td><form:input path="user.emailAddress" id="em" /></td>
						<td><form:errors path="user.emailAddress" /><span
							id="emerror" style="color: red; display: none;"><spring:message
									code="label.signup.emailValid" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.add" /><span class="required">*</span> </label></td>
						<td><form:input path="address.addressLine1" id="al1" /></td>
						<td><form:errors path="address.addressLine1" /><span
							id="al1error" style="color: red; display: none;"><spring:message
									code="label.signup.provadd" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><spring:message code="label.signup.add2" /></td>
						<td><form:input path="address.addressLine2" id="al2" /></td>
						<td><form:errors path="address.addressLine2" /><span
							id="al2error" style="color: red; display: none;"><spring:message
									code="label.signup.provadd" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>






					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.city" /><span class="required">*</span></label></td>
						<td><select name="cityNames" id="cityid">
								<c:forEach items="${editUserVO.cityNames }" var="cityName">
									<option value="${cityName }" label="${cityName }" />
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.state" /><span class="required">*</span></label></td>
						<td><select name="stateNames" id="stateid"
							onchange="getcities()">
								<c:forEach items="${editUserVO.stateNames }" var="stateName">
									<option id="stateoption" value="${stateName }"
										label="${stateName }" />
								</c:forEach>

						</select></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.zip" /><span class="required">*</span></label></td>
						<td><form:input path="address.postalCode" id="zc"
								onkeypress="return isNumber(event)" /></td>
						<td><form:errors path="address.postalCode" /><span
							id="zcerror" style="color: red; display: none;"><spring:message
									code="label.signup.zipcode" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><spring:message code="label.signup.num" /></td>
						<td><form:input path="user.phone" id="ph"
								onkeypress="return isNumber(event)" /></td>
						<td><form:errors path="user.phone" /><span id="pherror"
							style="color: red; display: none;"><spring:message
									code="label.signup.phnnum" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><label id="login_" style="font-size: 16px"><spring:message
									code="label.signup.mnum" /><span class="required">*</span> </label></td>
						<td><form:input path="user.mobileNumber" id="mob"
								onkeypress="return isNumber(event)" /></td>
						<td><form:errors path="user.mobileNumber" /><span
							id="moberror" style="color: red; display: none;"><spring:message
									code="label.signup.mobileBlank" /></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>

					<tr>
						<td>
						<td style="padding-left: 0px;" colspan="2"><input
							type="button" id="btn" style="font-family: SapientSansMedium"
							value="<spring:message code="label.signup.createProfile"/>"
							onclick="submitForm()"></td>
					</tr>

				</table>
			</form:form>
			<form action="getCitiesSignUp" id="getCitiesForm">
				<input type="hidden" name="statename" id="statevalue" value="">
				<input type="hidden" name="name" id="name" value="" /> <input
					type="hidden" name="userId" id="userId" value="" /> <input
					type="hidden" name="password" id="password" value="" /><input
					type="hidden" name="confpassword" id="confpassword" value="" /> <input
					type="hidden" name="email" id="email" value="" /> <input
					type="hidden" name="add1" id="add1" value="" /> <input
					type="hidden" name="add2" id="add2" value="" /> <input
					type="hidden" name="postalcode" id="postalcode" value="" /> <input
					type="hidden" name="phone" id="phone" value="" /> <input
					type="hidden" name="mobile" id="mobile" value="" />

			</form>
			<input type="hidden" id="flaginput" value="${flag }">
		</div>
		<div id="pageNavPosition1" align="center"></div>
		<div class="clearfix"></div>

		<footer>

		<div id="footer">
			<div style="float: left; margin-left: 386px;">
				<a href="/SapeStore/contactUsCustomer" style="color: #21addd;"><spring:message
						code="label.signup.contact" /></a>
			</div>
			<div style="float: left; margin-left: 6px; color: #21addd">|</div>

			<div style="float: left; margin-left: 7px;">
				<a href="/SapeStore//policyCustomer" style="color: #21addd;"><spring:message
						code="label.signup.privacy" /></a>
			</div>
			<div>
				<spring:message code="label.signup.powered" />
				<img src="img/sapient_nitro.jpg" width="78" height="14"
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




