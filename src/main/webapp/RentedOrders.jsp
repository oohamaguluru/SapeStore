
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<script src="js/vendor/jquery-1.9.1.min.js"></script>
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
#pageNavPositions {
	float: right;
	margin-right: 15px;
	

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

</script>
<script>

$(document).ready(function(){
	$("#dispatcha").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	$("#return").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	 n= $('.holidaya:checked').size(); 
	
	 r= $('.rentedsa:checked').size(); 
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

    function valReturn(event)
    {
       var checkboxs=document.getElementsByName("rented");
        var checkboxs1=document.getElementsByName("dispatch1");
		
        var flag=0;
        for(var i=0,l=checkboxs.length;i<l;i++)
        {
             if(checkboxs[i].checked==true && checkboxs1[i].checked==false){
                flag=1;
                break;
             }
             
             else if(checkboxs[i].checked==true && checkboxs1[i].disabled==false && checkboxs1[i].checked==true ){
             	flag=1;
             	break;
             }
             else if(checkboxs[i].checked==true && checkboxs1[i].disabled==true){
             	if(flag==0)
             		flag=2;
             }
             
           
    }
        if(flag==2||flag==0)
     	   return true;
        else 
     	   return false;
    }
    
    function valDispatch1(){
 	   var flag=0;
 	   var checkboxs=document.getElementsByName("rented");
        var checkboxs1=document.getElementsByName("dispatch1");
        for(var i=0,l=checkboxs.length;i<l;i++)
        {
     	   if(checkboxs1[i].checked==true && checkboxs[i].checked==false && checkboxs1[i].disabled==false){
     		   flag=1;
     		   break;
     	   }
     	  
        }
        if(flag==0)
     	   return true;
        else
     	   return false;
           
 	   
    }
      
	 jQuery(function ($) {
	   	    //form submit handler
	   	    $('#dispatcha').on("click",function (e) {
	   	        //check atleat 1 checkbox is checked
	   	        if (!$('.holidaya').is(':checked')&&(!$('.rentedsa').is(':checked'))) {
	   	            //prevent the default form submit if it is not checked
	   	            e.preventDefault();
	   	               $("#error2").text("Please select at least one order.");

	   	        }

	   	     else  if(($('.rentedsa').is(':checked'))&&(!$('.holidaya').is(':checked'))){
	   	        	e.preventDefault();
	   	               $("#error2").text("Please correct your selection.");
	   	               
		   	        }
	   	    else if($('.holidaya').is(':checked')&&($('.rentedsa').is(':checked'))){
                  e.preventDefault();
  	               $("#error2").text("Please correct your selection.");
                   
		   	     }
		   	        
	   	    })
	   	}) 
	   	
	   	jQuery(function ($) {
	   	    //form submit handler
	   	    $('#return').on("click",function (e) {

	   	     if (!$('.holidaya').is(':checked')&&(!$('.rentedsa').is(':checked'))) {
	   	            //prevent the default form submit if it is not checked
	   	            e.preventDefault();
	   	               $("#error3").text("Please select at least one order.");

	   	        }
	   	    	var res2=valReturn();
	   	    	if(res2==false){
	   	    		e.preventDefault();
	   	    	 $("#error3").text("Please dispatch the order and collect the payment on delivery.");
	   	    	}
	   	    	
	   	    	var res3=valDispatch1();
	   	    	//res2=true;
	   	    	if(res3==false){
	   	    		e.preventDefault();
	   	    		$("#error3").text("Please correct your selection.");
	   	    	}
	   	        //check atleat 1 checkbox is checked
	   	 
/* 					
	   	        else if( $('rentedsa').is(':checked') &&  !$('.holidaya').is(':disabled')){
				
	   	         e.preventDefault();
	   	      $("#error3").text("");
 	               $("#error4").text("Please dispatch the order and collect payment on delivery");

		   	        
		   	        }
	   	         */
		   	        
	   	    })
	   	}) 
 
</script>

</head>

<body>
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

				<form:form method="POST"  action="/SapeStore/updateRent" onsubmit="return Validate();"  name="updateForm" style="height: 25px; font-size: initial; width: 1000px" commandName="rentedUpdateForm" id="ordera">
					<table id="tablepagings" class="yui" style="width: 950px; height: 91px; border-bottom-width: 0px;text-align: center;">
						<thead>
							<tr>
								<th>ORDER ID</th>
                                   <th>ORDER ITEM ID</th>
								<th>ITEMS</th>
								<th>RENT AMOUNT</th>
								<th>RETURN DATE</th>
								<th>DISPATCH ORDER(S)</th>
								<th>RETURN RECEIVED</th>
							</tr>
						</thead>
						<c:forEach items="${rentedOrdersList}" var="current" varStatus="loop">						
						<tbody>
							     <tr
                                                       id="index${current.orderItemId}">
                                                       <td align="center">${current.orderId}
                                                       </td>
                                                        <td align="center">${current.orderItemId}
                                                       </td>
								<td>${current.bookTitle}
								</td>
								<td>$${current.rentPrice}
								</td>
								<td>--/--/--</td>
								<%-- <c:choose>
									<c:when test="${empty current.actualReturnDate}">
										<td>--/--/--</td>
									</c:when>
									<c:otherwise>
										<td>${current.actualReturnDate}</td>
									</c:otherwise>
								</c:choose> --%>
								<c:set var="orderStatusVar" value="${current.orderStatus}"/>
								<%
									Boolean orderStatusVar = (Boolean) request
													.getAttribute("orderStatusVar");
								%>
								<td>
								<c:choose>
								<c:when test="${current.orderStatus==true}">
								<input type="checkbox"
									id="dispatchCheckIndex${current.orderItemId}"
									checked disabled name="dispatch1"
									onclick="dispatchClick(this)"/>
								</c:when>
								<c:otherwise>
									<input type="checkbox"
									id="dispatchCheckIndex${current.orderItemId}"
									name="dispatch1"
									onclick="dispatchClick(this)" class="holidaya" />
						
								</c:otherwise>
								</c:choose>
								</td>

								<c:set var="returnReceivedVar"
									value="${current.returnStatus}"/>
								<%
									Boolean returnReceivedVar = (Boolean) request
													.getAttribute("returnReceivedVar");
								%>
								<td>
								<c:choose>
								<c:when test="${current.returnStatus==true}">
								<input type="checkbox"
								id="returnCheckIndex${current.orderItemId}" name="rented"
									checked disabled
									onclick="returnClick(this)" />
								</c:when>
								<c:otherwise>
								<input type="checkbox"
								id="returnCheckIndex${current.orderItemId}" 
									onclick="returnClick(this)" class="rentedsa" name="rented"/>
								</c:otherwise>
								</c:choose>
								</td>

								<td id="dispatchTextIndex${current.orderItemId}">
								<input type="text" style="display: none;" value="${current.orderStatus}" name="rentedUpdateList[${loop.index}].dispatchStatus" >
								</td>
								
								<td id="returnTextIndex${current.orderItemId}">
								<input type="text" style="display: none;" value="${current.returnStatus}" name="rentedUpdateList[${loop.index}].returnStatus">
								</td>
							</tr>
							</tbody>
						</c:forEach>
					</table>
					
					<div id="pageNavPositions"  align="center"></div>
					<div style="margin-left: 0em;float: left; margin-bottom: 1em; margin-top: 1em;height: 30px;">
						<input type="submit" name="dispatch" style="font-family: Georgia;" id="dispatcha" value="<spring:message code="label.rentedorder.dispatchbutton"/>" />
						 <div id="error2" class="error" ></div>
					</div>
					<div style="float: left; margin-bottom: 1em; margin-top: 1em; margin-left: 1em;height: 30px;">
						<input type="submit" name="return" style="font-family: Georgia;" id="return" name="method:returnOrder" value="<spring:message code="label.rentedorder.returnbutton"/>" />
						 <div id="error3" class="error" ></div>
					 </div>
					
				</form:form>
<script type="text/javascript">
		var pager = new Pager('tablepagings', 10);
		pager.init();
		pager.showPageNav('pager', 'pageNavPositions');
		pager.showPage(1);
	</script>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')
	</script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>
</body>
</html>