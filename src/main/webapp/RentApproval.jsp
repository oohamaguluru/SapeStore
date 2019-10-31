
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
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
#pageNavPositionv {
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
	$("#accept").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	$("#reject").css({
		'background-color' : '#21addd',
		color: 'white',
	});
	
});
</script>

<script>
		$(document).ready(function(){
		var stringa='';
		var stringr='';
		$('input:radio').click(function(){
		var id=this.value;

		if(id.substring(0,1)=='a')
			{
			stringa=stringa+id.substring(1)+" ";
	
			}
		else if(id.substring(0,1)=='r')
		{
		stringr=stringr+id.substring(1)+" ";
	
		}
		
	})
		$("#butt").click(function(){
			
		
		$("#acceptList").val(stringa);	
		$("#rejectList").val(stringr);
			$("#rentForm").submit();
			
			})
		})
</script>

</head>

<body>
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

				<form:form method="POST" action="/SapeStore/approveRent" id="rentForm"   name="updateForm" style="height: 25px; font-size: initial; width: 1000px" commandName="rentedUpdateForm1">
					<table id="tablepagingv" class="yui" style="width: 950px; height: 91px; border-bottom-width: 0px; text-align: center;">
						<thead>
							<tr>
								  <th>ORDER ID</th>
                                   <th>ORDER ITEM ID</th>
								<th>ITEMS</th>
								<th>RENT AMOUNT</th>
								<th>LATE FEE</th>
								<!-- <th>RETURN DATE</th> -->
								<th>ACCEPT</th>
								<th>REJECT</th>
							</tr>
						</thead>
						
						<c:forEach items="${rentedOrdersList1}" var="current" varStatus="loop">						
						<tbody>
							  <tr id="index${current.orderItemId}">
                                                       <td align="center">${current.orderId}
                                                       </td>
                                                        <td align="center">${current.orderItemId}
                                                       </td>
								<td>${current.bookTitle}
								</td>
								<td>$${current.rentPrice}
								</td>
								<td>$${current.lateFee}
								</td>
								<%-- <c:choose>
									<c:when test="${empty current.actualReturnDate}">
										<td>--/--/--</td>
									</c:when>
									<c:otherwise>
										<td>${current.actualReturnDate}</td>
									</c:otherwise>
								</c:choose> --%>
								<td>
									<input type="radio" id="a${current.orderItemId }" value="a${current.orderItemId }" name="${current.orderItemId }">
								</td>
								<td>
									<input type="radio" id="r${current.orderItemId  }" value="r${current.orderItemId  }" name="${current.orderItemId  }">
								</td>
									
								
							</tr>
							</tbody>
						</c:forEach>
					</table>
					
					<input type="hidden" value="" name="acceptList" id="acceptList">
					<input type="hidden" value="" name="rejectList" id="rejectList">
					<div style="margin-left: 0em;float: left; margin-bottom: 1em; margin-top: 1em;height: 30px;">
						<input type="button" style="font-family: Georgia;" id="butt" value="Submit" />
					</div>
					
					<div id="pageNavPositionv"  align="center"></div>
				</form:form>
<script type="text/javascript">
		var pager = new Pager('tablepagingv', 10);
		pager.init();
		pager.showPageNav('pager', 'pageNavPositionv');
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