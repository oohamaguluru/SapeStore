<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<style type="text/css">
table.yui {
       border-collapse: collapse;
       border-spacing: 0;
}

.wwFormTablewish {
       margin-left: -6px;
}

table.wwFormTablewish tr {
       margin: 0 0 10px 0;
}

hr{
    border-top: 1px dashed darkgrey;
    width:90%;
    margin-left:0;

}

</style>
</head>
<span id="perror" style="display: none"></span>
<script type="text/javascript">
       function validateLength1() {
              if (document.getElementById("login_userIdwish").value.length == 0
                           && document.getElementById("login_passwordwish").value.length == 0) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Please enter Username and password</span>";
              } else if (document.getElementById("login_passwordwish").value.length == 0) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Please enter password to proceed</span>";
              } else if (document.getElementById("login_userIdwish").value.length == 0) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Please enter Username to proceed</span>";
              }

              else if (document.getElementById("login_userIdwish").value.length <= 1
                           || document.getElementById("login_userIdwish").value.length >= 20) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Username should be more than 1 character</span>";
              }

              else if (document.getElementById("login_passwordwish").value.length < 6
                           || document.getElementById("login_passwordwish").value.length > 10) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Password should have 6 to 10 characters</span>";
              }

              else if (document.getElementById("login_passwordwish").value
                           .search("/[[A-Z]*[a-z]*[\d]+]/") == 0) {

                     document.getElementById("errorMessagewish").innerHTML = "<span class="+"'error'"+">Password should contain atleast one number</span>";
              }

              else {

                     document.loginformwish.submit();
              }
       }
</script>

<!-- <script>
window.onclick=LoginButtonClick;
function LoginButtonClick()
{
       
    document.getElementById("login_userId").value = "";
    document.getElementById("login_password").value = "";
}
</script> -->
<body onload="LoginButtonClick()">
<form:form id="login" name="loginformwish" action="/SapeStore/loginwish" method="POST" commandName="user">
       <table class="wwFormTablewish">
              <tr>
                           <td class="tdLabel"></td>
                           <td><label id="login_wish"
                                  style="font-size: 16px; font-weight: bold"><spring:message code="label.login.username"></spring:message><span
                                         class="required">*</span></label></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><input type="text" name="userId"  id="login_userIdwish"
                                  placeholder="User Name" required /></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><label id="login_wish"
                                  style="font-size: 16px; font-weight: bold"><spring:message code="label.login.password"/><span
                                         class="required">*</span></label> 
                           </td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><input type="password" name="password" id="login_passwordwish"
                                  placeholder="Password" required /></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td id="errorMessagewish"></td>
                     </tr>
                     
                     <tr>
                           <td colspan="2">
                           <div align="center" style="height:45px;">
                                         <input type="button" id="login_0wish" onclick="validateLength1()"
                                                value="<spring:message code="label.login.login"/>" class="lightButton" />
                                  </div>
                                  <a class="forgotPassword inline" style="float: right"
                                  title="Forgot Password" href="#forgotPassword1"><spring:message code="label.login.forgot"/></a>
                                  </td>
                     </tr>
       </table>
</form:form>

<form action="/SapeStore/signUp" method="post">
       <table class="wwFormTable">
              <fieldset>
                     <tr>
                           <hr>
       <td  style="padding-left: 10px;height:0px" class="tdLabel"></td>
                           <td><div align="center"><label id="login_wish"><spring:message code="label.login.noaccount"/></label></div></td>
                     </tr>
                     <tr>
                           <td style="padding-left: 26px;" colspan="2"><div align="center">
                                         <input type="submit" id="login_2wish" value="<spring:message code="label.login.register"/>"
                                                class="darkButton" />
                                  </div></td>
                     </tr>
              </fieldset>
       </table>
</form>

</body>
</html>
