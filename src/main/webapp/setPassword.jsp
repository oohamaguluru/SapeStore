<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form id="setPass" name="newpassForm" action="setPass" method="POST">
Enter email id:
<input type="hidden" name="emailAddress" value="${emailId }" id="email_id" placeholder="Email ID" required/><br>
New Password
<input type="password" name="password" id="new_password" placeholder="New Password" required/><br>
Confirm Password
<input type="password" name="conf_password" id="conf_password" placeholder="Confirm Password" required/><br>
<input type="submit" id="login_2" value="Register" class="darkButton"/>

</form>
</body>
</html>


