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
<title>SapeStore-Home</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/main.css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script
       src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
</script>
<script>


$(document).ready(function(){
       $("#manageInv").css({
              position: 'relative',
              right: '24em',
              width: '8em',
              height: '30px',
              'background-color': '#21addd',
              color: 'white',
       });
       
       $("#update").css({
              position: 'relative',
              width: '8em',
              height: '30px',
              top: '1px',
              'background-color' : '#21addd',
              color: 'white',
       });
});



</script>
<script>
function isValidEmail(emailAddress) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
};
function submitForm() {
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
              var flag = 0;
              
              if(usern.length==0) {
            	  $("#userNerror").text("<spring:message code="label.signup.provfull"></spring:message>");
                     $("#userNerror").show();
                     flag=1;
              } else if(usern.length>20){
            	  $("#userNerror").show();
                  flag=1;
              } else {
				  $("#userNerror").hide();
                  }
              if(useri.length==0) {
                     $("#userIerror").text("<spring:message code="label.signup.provfull"></spring:message>");
                     $("#userIerror").show();
                     flag=1;
              } else if(useri.length<3) {
                     $("#userIerror").text("Please Enter More Than 2 Characters!");
                     $("#userIerror").show();
                     flag=1;
              } 
              else if(useri.length>20) {
                  $("#userIerror").text("Please Enter less Than 20 Characters!");
                  $("#userIerror").show();
                  flag=1;
           } else {
				$("#userIerror").hide();
               } 
             
              
              if(em.length==0) {
                     $("#emerror").text("<spring:message code="label.signup.validemail"></spring:message>");
                     $("#emerror").show();
                     flag=1;
              } else if (!(isValidEmail(em))) {
                     $("#emerror").text("<spring:message code="label.signup.validemail"></spring:message>");
                     $("#emerror").show();
                     flag=1;
              } else {
                  $("#emerror").hide
                  }
              if(al1.length==0) {
            	  $("#al1error").text("<spring:message code="label.signup.provadd"></spring:message>");
                     $("#al1error").show();
                     flag=1;
              } else if (al1.length>40){
            	  $("#al1error").show();
            	  flag=1;
              } else
                  {
					$("#al1error").hide();
                  }
              
              var reg= /^\d+$/;
              
              if(zc.length!=5 & zc.length!=6) {
            	  $("#zcerror").text("<spring:message code="label.signup.incorrectFormat"></spring:message>");
                     $("#zcerror").show();
                     flag=1;
              } else if(!reg.test(zc)) {
            	  $("#zcerror").text("<spring:message code="label.signup.incorrectFormat"></spring:message>");
					$("#zcerror").show();
					flag=1;
	           } else {
            	  $("#zcerror").hide();
              }
              if(pass!=confpass) {
            	  $("#confpasserror").text("<spring:message code="label.signup.retypepass"></spring:message>");
                     $("#confpasserror").show();
                     flag=1;
              }
              else
            	  {
            	  $("#confpasserror").hide();
            	  }
              if(ph.length!=0)
            	  {
              if((ph.length>10 |ph.length <10) ) { 
                  $("#pherror").show();
                   flag=1;
           } else  if(!reg.test(ph)) {
        	   $("#pherror").text("<spring:message code="label.signup.incorrectFormat"></spring:message>");
				$("#pherror").show();
				flag=1;
				
           } else {
			$("#pherror").hide();
	           }
            	  }
              else
            	  {
            	  $("#pherror").hide();
            	  }
             
        	   if(mob.length!=10) {
        		   if(mob.length==0)
             	  {
             	  $("#moberror").text("<spring:message code="label.signup.mobnum"></spring:message>");
             	  $("#moberror").show();
                   flag=1;
             	  }
                   $("#moberror").show();
                   flag=1;
            } else if(!reg.test(mob)) {
            	 $("#moberror").text("<spring:message code="label.signup.incorrectFormat"></spring:message>");
 				$("#moberror").show();
 				flag=1;
            } else {
             	  $("#moberror").hide();
               }
             
              if(pass.length==0) {
                  $("#passerror").text("<spring:message code="label.signup.provpass"></spring:message>")
                  $("#passerror").show();
                  flag=1;
           } else if (pass.length < 8) {
                  $("#passerror").text("<spring:message code="label.signup.passlength"></spring:message>");
                  $("#passerror").show();
                  flag=1;
           } else if (pass.length > 15) {
         		 $("#passerror").text("<spring:message code="label.signup.passlength"></spring:message>");
              	 $("#passerror").show();
              	 flag=1;
           }else if(CheckPasswordStrength(pass)<=1)
     	  {
         	  $("#passerror").text("<spring:message code="label.signup.incorrectMsg"></spring:message>");
               $("#passerror").show();
               flag=1;
         	  } 
           else {
					$("#passerror").hide();
               }
              if(flag==0) {
                     $("#mainform").submit();
              }
              
              
             
              
}
</script>

<script>
    function getcities() {
              var state = $("#stateid").val();
              document.getElementById("statevalue").value = state;
              var pass = $("#pass").val();
              var confpass = $("#confpass").val(); 
              document.getElementById("password").value = pass;
              document.getElementById("confpassword").value = confpass; 
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
       function iszipcode(zc) {
    	    
    	    for (var i = 0; i < zc.length; i++) {
    	    	 if(isNaN(zc[i]))
    	    		 {
    	    		 alert("must input numbers");
    	    		 return true;
    	    		 }
    	    	 
            }
    	   
    	    return false;
    	} 
</script>


<script type="text/javascript">
   function  CheckPasswordStrength(password) {
        var password_strength = document.getElementById("pass");
 
        //TextBox left blank.
        
 
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




</head>
<style>
body {
       font-family: 'SapientSansMedium';
}
</style>
<body>
       <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->


       <div id="wrapper">
              <div id="shoppingCartContainer" style="display: none">
                     <div id="shoppingCart" class="popup">
                           <jsp:include page="DisplayShoppingCart.jsp" flush="true" />
                     </div>
              </div>
              <form:form name="form" action="/SapeStore/bookListByCat?categoryId=${categoryId}&categoryName=${categoryName}&checkMe=false" method="GET" commandName="welcome">
                     <header>
                     <div id="header">
                           <a href="/SapeStore/welcome?checkMe=${checkMe}" title="SapeStore" class="logo"><img
                                  src="img/logo_option 01.png" width="231" height="109"
                                  alt="SapeStore"></a>

                           <ul class="topLinks">
                                  <li>
                                         <!--form:checkbox id="checkMe" path="checkMe" value="Include books from Partner Store" onchange="form.submit();"/-->
                                         <c:choose>
                                                <c:when test="${welcome.checkMe==false}">
                                                       <input type="checkbox" name="checkMe" id="checkMe" disabled="disabled" style="font-size: 13px;"
                                                              onclick="form.submit();">
                                                </c:when>
                                                <c:otherwise>
                                                       <input type="checkbox" name="checkMe" id="checkMe" disabled="disabled" style="font-size: 13px;"
                                                              onclick="form.submit();" checked="checked">
                                                </c:otherwise>
                                         </c:choose>
                                         <label for="checkMe" style="font-size: 13px;"><spring:message code="label.signup.includebooks"></spring:message>
                                               </label> 
                                                <input type="hidden" name="categoryId" value="${categoryId}" /> 
                                                <input type="hidden" name="categoryName" value="${categoryName}" />
                                  </li>
                                  <li><a class='inline' href="#shoppingCart"><img
                                                src="img/icon_cart.jpg" width="15" height="12" alt="cart"></a></li>
                             <li>   <c:choose>
                                                <c:when test="${ShoppingCart.totalQuantity==0}">
                                                </c:when>
                                                  <c:otherwise>
                                                    <li class="cartNum">${ShoppingCart.totalQuantity}</li>
                                                  </c:otherwise>
                                                </c:choose>
                                                </li>
                                  
                                  <c:choose>
                                  <c:when test="${ not empty userId}">
                                                <select id="account" name="account" style="font-size: 12px;" onchange="changeVal()">
                                                <option value="1" style="font-size: 10px;"><spring:message code="label.signup.acc"></spring:message></option>
                                                <option value="-1" style="font-size: 10px;"><spring:message code="label.signup.welcome"></spring:message> ${username}</option>
                                                <option value="2" style="font-size: 10px;"><spring:message code="label.signup.orderstatus"></spring:message></option>
                                                <option value="3" style="font-size: 10px;"><spring:message code="label.signup.transac"></spring:message></option>
                                                </select>
                                  </c:when>
                                  </c:choose>
                                  
                           </ul>
                           <nav>
                           <ul class="nav">
                                  <li class="active"><a href="/SapeStore/welcome?checkMe=${checkMe}">HOME</a></li>
                                                                     <c:choose>
                                  <c:when test="${not empty userId}">
                                  <li><a href="personalInformation"><spring:message code="label.signup.acc"></spring:message></a></li>
                                  </c:when>

                                  </c:choose>
                                  
                                      <c:choose>
								<c:when test="${not empty userId}">
									<li><a href="/SapeStore/wishlistcontroller" ><spring:message code="label.signup.wishlist"></spring:message></a></li>
									
								</c:when>
								<c:otherwise>
									<script type="text/javascript">
										function alertIt() {
											alert("Please login to add to wishlist");
										}
									</script>
									<li class="active"><a href="#login" title="review" class="inline"
										id="addToCart"><spring:message code="label.signup.wish"></spring:message></a></li>
								</c:otherwise>
							</c:choose>
                                  <jsp:include page="Logout.jsp" flush="true" />
                                  <li><a href="/SapeStore/welcome?checkMe=${checkMe}"><img alt="searchImage" src="img/magnifier-icon.png" height="30"></a></li>
                                  
                           </ul>
                           </nav>
                     </div>
                     </header>
                     <!-- header ends -->
                     <section>
                     <div class="leftCol">
                           <h2><spring:message code="label.signup.acc"></spring:message></h2>
                           <nav> <!-- left navigation -->
                           <ul>
                                  <li><a href=""  style="color: #cacfd0; font-family : 'SapientSansMedium'"><spring:message code="label.signup.personalinformation"></spring:message></a></li>
                                  <li><a href="transactionHistory" style="font-family : 'SapientSansMedium'"><spring:message code="label.signup.transac"></spring:message></a></li>
                                  <li><a href="orderstatus.jsp" style="font-family : 'SapientSansMedium'"><spring:message code="label.signup.orderstatus"></spring:message></a></li>
                           </ul>
                           </nav>
                     </div>
              </form:form>
              
              
              <section>
                     <div id="mainContent" class="addAddress">
                           <h2><spring:message code="label.signup.editprofile"></spring:message></h2>
                           <div class="clearfix"></div>
                           <form:form method="post" id="mainform" action="editProfileSubmit" commandName="editUserVO">

       <table class="wwFormTable">

                                  <tr>
                                  <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.fullname"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:input path="user.name" id="userN" /></td>
                                         <td><form:errors path="user.name"/><span id="userNerror" style="color: red; display: none;"></span> </td>
                                  </tr>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
 
                                  <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.preflogin"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:input path="user.userId" id="userI"  readonly="true"/></td>
                                         <td><form:errors path="user.userId"/><span id="userIerror" style="color: red; display: none;">Please Enter User ID</span> </td>
                                  </tr>
                                   <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.loginpass"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:password path="user.password" id="pass" onkeypress="CheckPasswordStrength(this.value)" value="${pass}" /></td>
                                         <td><form:errors path="user.password"/><span id="passerror" style="color: red; display: none;"><spring:message code="label.signup.incorrectMsg"></spring:message></span></td>
                                  </tr>
                                   <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.repass"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><input type="password" id="confpass" value="${cpass}"></td><td><span id="confpasserror" style="color: red; display: none;"></span></td>
                                  </tr>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.emailadd"></spring:message> <span
                                         class="required">*</span></label></td>
                                         <td><form:input path="user.emailAddress" id="em" readonly="true" /></td>
                                         <td><form:errors path="user.emailAddress"/><span id="emerror" style="color: red; display: none;">Please Enter Email</span> </td>
                                  </tr>
                                   <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.add"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:input path="address.addressLine1" id="al1" /></td>
                                         <td><form:errors path="address.addressLine1" /><span
                                                id="al1error" style="color: red; display: none;">Please
                                                       Enter  Proper Address</span></td>
                                  </tr>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                  <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.add2"></spring:message><span
                                         ></span></label></td>
                                         <td><form:input path="address.addressLine2" id="al2" /></td>
                                         <td><form:errors path="address.addressLine2" /></td>
                                  </tr>
<tr> <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                  <tr>
                                          <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.city"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><select name="cityNames" id="cityid">
                                                       <c:forEach items="${editUserVO.cityNames }" var="cityName">
                                                              <option value="${cityName }" label="${cityName }" />
                                                       </c:forEach>

                                         </select></td>
                                <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>

                                  <tr>
                                 <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.state"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><select name="stateNames" id="stateid" 
                                                onchange="getcities()">
                                                       <c:forEach items="${editUserVO.stateNames }" var="stateName">
                                                              <option id="stateoption" value="${stateName }"
                                                                     label="${stateName }" />
                                                       </c:forEach>

                                         </select></td>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                     <tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.zip"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:input path="address.postalCode" id="zc" 
                                         onkeypress="return isNumber(event)"/></td>
                                         <td><form:errors path="address.postalCode"/><span id="zcerror" style="color: red; display: none;"><spring:message code="label.signup.incorrectMsg"></spring:message></span></td>
                                  </tr>
                                     
                                      <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                         <td><spring:message code="label.signup.num"></spring:message></td>
                                         <td><form:input path="user.phone" id="ph"
                                                       onkeypress="return isNumber(event)" /></td>
                                         <td><form:errors path="user.phone" /><span id="pherror" style="color: red; display: none;"><spring:message code="label.signup.incorrectMsg"></spring:message></span></td>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                                         <td><label id="edit_"
                                  style="font-size: 16px"><spring:message code="label.signup.mnum"></spring:message><span
                                         class="required">*</span></label></td>
                                         <td><form:input path="user.mobileNumber" id="mob"
                                                       onkeypress="return isNumber(event)" /></td>
                                         <td><form:errors path="user.mobileNumber" /><span id="moberror" style="color: red; display: none;"><spring:message code="label.signup.incorrectMsg"></spring:message></span></td>
                                  </tr>
                                  <tr> <td></td></tr><tr><td></td></tr><tr><td></td> </tr><tr><td></td></tr><td></td>
                                  </tr>
<tr>
                           <td style="padding-left: 26px;" colspan="2">
                                         <input type="button" style="font-family: SapientSansMedium" id="update" value=<spring:message code="label.signup.updateprofile"></spring:message>
                                                style="color:Blue" onclick="submitForm()" />
                                  </div></td>
                                  <form:form action="/SapeStore/" method="post"> 
					
					</form:form>
					    <form:form action="personalInformation" method="post"> 
					<td style="padding-left: 200px;" colspan="4">
						<input type="submit" id="manageInv" value=<spring:message code="label.edit.cancel"></spring:message>
							style="color:Blue"  />
					</td>
					</form:form>
                     </tr>
                                  
                           </table>
</form:form>

<form action="getCities" id="getCitiesForm">
       <input type="hidden" name="statename" id="statevalue" value="">
              <input type="hidden" name="password" id="password" value="">
                     <input type="hidden" name="confpassword" id="confpassword" value="">
</form>
                     </div>
                   
              </section>

             <div   class="clearfix"></div> 
        
 <footer>
  
     <div id="footer">
       <div style=" float: left; margin-left: 386px;">
              <a href="/SapeStore/contactUsCustomer" style="color: #21addd;"><spring:message code="label.signup.contactus"></spring:message></a>
              </div>
              <div style="float: left;margin-left: 6px; color: #21addd"></div>
              
              <div style="float: left;margin-left: 7px;">
                    <a href="/SapeStore//policyCustomer" style="color: #21addd;"><spring:message code="label.signup.privacypolicy"></spring:message></a>
              </div>
              <div>Powered by <img src="img/sapient_nitro.jpg" width="78" height="14" alt="sapient nitro"></div>
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
        <form action = "transactionHistory" id = "transactionForm"></form> 
        <form action = "getStatusPage" id = "orderStatusForm"></form> 
          <form action="personalInformation" id="editProfileForm"></form>
       <form action="welcome" id="homePageForm"></form>

</body>
</html>







