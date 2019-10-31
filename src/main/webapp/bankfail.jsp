<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style type="text/css">
button {
   
    background-color: #4CAF50;
    color: white;
    padding: 20px 20px ;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    height:10px;
    width:200px;
    text-align: center;
    padding-top: 10px;
}

button:hover{
    background-color: #45a049;
    height:10px;
    width:%;
    text-align: center;
     padding: 20px 20px ;
     padding-top: 10px;
}

</style>
<body>
<br>
    <c:if test="${status==0}">
        <p style="color: red;">not enough balance in card</p>
</c:if>
<c:if test="${status==-1}">
<p style="color: red;">cannot find card</p>
</c:if>
<c:if test="${status==-2}">
<p style="color: red;">Error in card details</p>
</c:if>
<a href="payProfile"><button type="button">Back to profile</button></a>
</body>
</html>