<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(document).on("click", "a", function () 
		{ 
			document.getElementById("login_userId").value="";
			document.getElementById("login_password").value="";
			
		});
</script>
					<c:choose>
					
					<c:when test="${empty userId}">
					<li><a href="#login" class='inline' title="Login"
							id="loginPop"><spring:message code="label.login.login"/></a></li>
						
					</c:when>
					<c:otherwise>
						<li><a href="/SapeStore/logout"><spring:message code="label.header.logout"/></a></li>
					</c:otherwise>
					</c:choose>