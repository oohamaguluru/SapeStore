<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="js/loginfix.js"></script>
<style type="/text/css">
table.yui {
       border-collapse: collapse;
       border-spacing: 0;
}

.wwFormTable {
       margin-left: -6px;
}

table.wwFormTable tr {
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

window.onload = function(){
    document.getElementById('login_userId').value="";
    document.getElementById('login_password').value="";
}
       function validateLength() {
              if (document.getElementById("login_userId").value.length == 0
                           && document.getElementById("login_password").value.length == 0) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="label.login.wronguserpass"/></span>";
              } else if (document.getElementById("login_password").value.length == 0) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="labe.login.enterpass"/></span>";
              } else if (document.getElementById("login_userId").value.length == 0) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="label.login.enteruser"/></span>";
              }

              else if (document.getElementById("login_userId").value.length <= 1
                           || document.getElementById("login_userId").value.length >= 20) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="labe.login.user1char"/></span>";
              }

              else if (document.getElementById("login_password").value.length < 6
                           || document.getElementById("login_password").value.length > 10) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="label.login.passlength"/></span>";
              }

              else if (document.getElementById("login_password").value
                           .search("/[[A-Z]*[a-z]*[\d]+]/") == 0) {

                     document.getElementById("errorMessage").innerHTML = "<span class="+"'error'"+"><spring:message code="label.login.passnumber"/></span>";
              }

              else {

                     document.loginform.submit();
              }
       }

       
</script>


<body>



<form:form id="login" name="loginform" action="/SapeStore/login" method="POST" commandName="user">
       <table class="wwFormTable">
                     <tr>
                           <td class="tdLabel"></td>
                           <td><label id="login_"
                                  style="font-size: 16px; font-weight: bold"><spring:message code="label.login.username"></spring:message><span
                                         class="required">*</span></label></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><input type="text" name="userId"  id="login_userId"
                                  placeholder="<spring:message code="label.login.username"/>" required /></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><label id="login_"
                                  style="font-size: 16px; font-weight: bold"><spring:message code="label.login.password"/><span
                                         class="required">*</span></label> 
                           </td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td><input type="password" name="password" id="login_password"
                                  placeholder="<spring:message code="label.login.password"/>" required /></td>
                     </tr>
                     <tr>
                           <td class="tdLabel"></td>
                           <td id="errorMessage"></td>
                     </tr>
                     
                     <tr>
                           <td colspan="2">
                           <div align="center" style="height:45px;">
                                         <input type="button" id="login_0" onclick="validateLength()"
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
                           <td><div align="center"><label id="login_"><spring:message code="label.login.noaccount"/></label></div></td>
                     </tr>
                     <tr>
                           <td style="align:center; padding-left:10px;" colspan="2"><div align="center">
                                         <input type="submit" id="login_2" value="<spring:message code="label.login.register"/>"
                                                class="darkButton" />
                                  </div></td>
                     </tr>
              </fieldset>
       </table>
</form>

</body>
</html>