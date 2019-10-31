<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>SapeStore-Error Occurred</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

<link rel="stylesheet" href="css/normalize.css" type="text/css">
<link rel="stylesheet" href="css/main.css" type="text/css">
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
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
#xyz {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
    height:200px;
    width:300px;
    margin-left:80px;
    margin-top: 90px;
}
input[type=button] {
   
    background-color: #4CAF50;
    color: white;
    padding: 20px 20px ;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    height:10px;
    width:100%;
    text-align: center;
    padding-top: 10px;
}

input[type=button]:hover {
    background-color: #45a049;
    height:10px;
    width:100%;
    text-align: center;
     padding: 20px 20px ;
     padding-top: 10px;
}
input[type=text], select {
  
    padding: 4px 15px;
    margin: 4px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
input[type=password], select {
  
    padding: 4px 15px;
    margin: 4px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
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
#pageNavPositionpay {
       float: right;

	border-right: 1px solid #AAAAAA;
/* border-left: 1px solid #AAAAAA;
	border-bottom: 1px solid #AAAAAA;  */
	/* padding-left: 774px; */
	 padding-bottom: 0.5em;
	 padding-top: 0.5em; 
 padding-right: 2px;
	width: 1000px;
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

<body>
<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]--> 

        

<b>Received Transaction history</b> 
<c:choose>
<c:when test="${empty reclist}">
<br><br>Sorry received history is empty
</c:when>
<c:otherwise>

<table id="tablepagingpay" class="yui" cellspacing="30" cellpadding="10">
   <tr>
  <th>transaction ID</th>
    <th>received from</th>
    <th>amount</th>
    <th>Date</th>
  </tr>
  
 <c:forEach var="t" items="${reclist}" >
  <tr>
    <td>${t.transId }</td>
    <td>${t.sender }</td>
    <td align="center">${t.amount }</td>
    <td>${t.localDate }</td>
  </tr>
  
  </c:forEach>
</table>
</c:otherwise>
</c:choose>
       <div id="pageNavPositionpay"  align="center"></div>
</body>
<script type="text/javascript">
              var pager = new Pager('tablepagingpay', 3);
              pager.init();
              pager.showPageNav('pager', 'pageNavPositionpay');
              pager.showPage(1);
       </script>
       	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="/SapeStore/js/vendor/jquery-1.9.1.min.js"><\/script>')
	</script>
	<script src="/SapeStore/js/plugins.js"></script>
	<script src="/SapeStore/js/main.js"></script>
</html>