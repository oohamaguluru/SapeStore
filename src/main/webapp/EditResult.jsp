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
<style>
.highlight {
	background-color: yellow;
}

.lowlight {
	background-color: blue;
}
</style>
<script>
	$(document).ready(function() {
		$("#manageInv").css({
			position : 'relative',
			right : '30em',
			width : '8em',
			height : '30px',
			'background-color' : '#21addd',
			color : 'white',
		});
	
	$("#update").css({
		position: 'relative',
		width: '8em',
		height: '30px',
		top: '1px',
		'background-color' : '#21addd',
		color: 'white',
	});

	$("#fakeBrowse").css({
	    right: '25em',
    width: '8em',
    height: '30px',
    top: '1px',
    'background-color': 'rgb(33, 173, 221)',
    color: 'white',
	});

	$("#fakeBrowsefullImage").css({
	    right: '25em',
    width: '8em',
    height: '30px',
    top: '1px',
    'background-color': 'rgb(33, 173, 221)',
    color: 'white',
	});
	
});
function highlight(){
	$(document).ready(function(){
	      $("#quantity_id").change(function(){
	          $(".rowb").addClass($("#quantity_id").val() < 5?"highlight":"lowlight");
	      });
	 });
}
function submitForm() {
	$(document).ready(function(){
		
				
				var flag=true;
				$(".error").remove();
			    var characterReg = /^[1-9]*/;
			    var nameReg = /^[a-zA-Z0-9]{1,100}$/;
			    //var isbnNameReg = /^[0-9]{13,14}$/;
			    var alphaReg=/^[.a-zA-Z ]{1,100}$/;
			   //  var detailsReg=/^[-.,a-zA-Z0-9 ]{1,150}$/;
			    
			    var quantityVal= $("#quantity_id").val();
			    var quantityValT=quantityVal.trim();
			    if(quantityValT=="") {
			        $("#quantity_id").after('<span class="error"> 		<spring:message code="label.edit.BookQty"/></span>');
			        flag=false;
			    }
			    else if(quantityValT[0]=="-"){
			    	  $("#quantity_id").after('<span class="error"> 		<spring:message code="label.edit.BookQty2"/></span>');
				        flag=false;
				}
			    else if(!quantityValT.match(/^\d+$/)){
					 $("#quantity_id").after('<span class="error"> 		<spring:message code="label.edit.BookQty2"/></span>');
		       		flag=false;
				}
			    else
				    flag=true;
			    
				var flag2=true;
			    var bookPrice= $("#bookPrice_id").val();
			    var bookPriceT=bookPrice.trim();
			    if(bookPriceT=="") {
			        $("#bookPrice_id").after('<span class="error"> 		<spring:message code="label.edit.SP"/></span>');
			        flag2=false;
			    }
			    else if((bookPriceT[0]=="-")){
			    	  $("#bookPrice_id").after('<span class="error"> 		<spring:message code="label.edit.SP2"/></span>');
				        flag2=false;
				}
			    else if(!bookPriceT.match(/^(?!0*[.,]0*$|[.,]0*$|0*$)\d+[,.]?\d{1,3}$/)){			/* ----------/^(?!0*[.,]0*$|[.,]0*$|0*$)\d+[,.]?\d{1,3}$/ */
					 $("#bookPrice_id").after('<span class="error"> 		<spring:message code="label.edit.SP2"/></span>');
		       		flag2=false;
				} 
			    else
				    flag2=true;
			    
			    var rentPrice= $("#rentPrice_id").val();
			    var rentPriceT=rentPrice.trim();
			    var flag1=true
			    if(document.getElementById("rentPrice_id").disabled) {
			    	flag1=true;
			    }
			    else if(rentPriceT=="") {
			        $("#rentPrice_id").after('<span class="error"> 		<spring:message code="label.edit.RP"/></span>');
			        flag1=false;
			    }
			    else if((rentPriceT[0]=="-")){
			    	  $("#rentPrice_id").after('<span class="error"> 		<spring:message code="label.edit.RP2"/></span>');
				        flag1=false;
				}
			    else if((!rentPriceT.match(/^(?!0*[.,]0*$|[.,]0*$|0*$)\d+[,.]?\d{1,3}$/))){
					 $("#rentPrice_id").after('<span class="error"> 		<spring:message code="label.edit.RP2"/></span>');
		       		flag1=false;
				} 
			    else
				    flag1=true;
			   
 				var flag4=true;
			    var bookTitle= $("#bookTitle_id").val();
			    var bookTitleT=bookTitle.trim();
			    if(bookTitleT=="") {
			        $("#bookTitle_id").after('<span class="error"> 		<spring:message code="label.edit.BT"/></span>');
			        flag4=false;
			    }
			    else if(bookTitleT.match(/^.*[<>].*/g)){
			    	$("#bookTitle_id").after('<span class="error"> 		<spring:message code="label.edit.BT2"/></span>');
			    	flag4=false;
				}
			    else{
			    	flag4=true;
				}

			    var flag5=true;
			    var bookAuthor= $("#bookAuthor_id").val();
			    var bookAuthorT=bookAuthor.trim();
			    if(bookAuthorT=="") {
			        $("#bookAuthor_id").after('<span class="error"> 	<spring:message code="label.edit.BA"/></span>');
			        flag5=false;
			    }
			    else if(bookAuthorT.match(/^.*[<>].*/g)){
			    	$("#bookAuthor_id").after('<span class="error"> 		<spring:message code="label.edit.BA2"/></span>');
			    	flag5=false;
				}
			    else{
			    	flag5=true;
				}

			    var flag6=true;
			    var publisherName= $("#publisherName_id").val();
			    var publisherNameT=publisherName.trim();
			    if(publisherNameT=="") {
			        $("#publisherName_id").after('<span class="error"> 	<spring:message code="label.edit.PN"/></span>');
			        flag6=false;
			    }
			    else if(publisherNameT.match(/^.*[<>].*/g)){
			    	$("#publisherName_id").after('<span class="error"> 		<spring:message code="label.edit.PN2"/></span>');
			    	flag6=false;
				}
			    else{
			    	flag6=true;
				}
			    

			    var flag7=true;
			    var bookShortDesc= $("#bookShortDesc_id").val();
			    var bookShortDescT=bookShortDesc.trim();
			    if(bookShortDescT=="") {
			        $("#bookShortDesc_id").after('<span class="error"> 		<spring:message code="label.edit.DBlank"/></span>');
			        flag7=false;
			    }
			    else if(bookShortDescT.length>500) {
			        $("#bookShortDesc_id").after('<span class="error"> 		<spring:message code="label.edit.DMax"/></span>');
			        flag7=false;
			    }
			    else if(bookShortDescT.match(/^.*[<>].*/g)){
			    	$("#bookShortDesc_id").after('<span class="error"> 		<spring:message code="label.edit.DValid"/></span>');
			    	flag6=false;
				}			    
			    else
				    flag7=true;

			    var flag8=true;
			    var bookDetailDesc= $("#bookDetailDesc_id").val();
			    var bookDetailDescT=bookDetailDesc.trim();
			    if(bookDetailDescT=="") {
			        $("#bookDetailDesc_id").after('<span class="error"> 	<spring:message code="label.edit.DBlank"/></span>');
			        flag8=false;
			    }
			    else if(bookDetailDescT.length>1000) {
			        $("#bookDetailDesc_id").after('<span class="error"> 	<spring:message code="label.edit.DMax"/></span>');
			        flag8=false;
			    }
			    else if(bookDetailDescT.match(/^.*[<>].*/g)){
			    	$("#bookDetailDesc_id").after('<span class="error"> 		<spring:message code="label.edit.DValid"/></span>');
			    	flag6=false;
				}	
			    else
				    flag8=true;
			   
			    
			    if((flag==true)&&(flag2==true)&&(flag1==true)&&(flag4==true)&&(flag5==true)&&(flag6==true)&&(flag7==true)&&(flag8==true)){
					document.updateForm.submit();
			 		}
		});
}
</script>
<script type="text/javascript">

function dis_able() {
	var r = $("#rentAvailable_id").val().trim();
	var p = $("#bookPrice_id").val().trim();
	if (r == "No" || r=="N") {
		/* val=0.0
		document.getElementById("rentPrice_id").value = (val).toFixed(1); */
		document.getElementById("rentPrice_id").disabled = true;
	} else {
		document.getElementById("rentPrice_id").value = (p/10).toFixed(1);
		document.getElementById("rentPrice_id").disabled = false;
	}
}
function HandleBrowseClick()
{
    var fileinput = document.getElementById("thumbImage");
    fileinput.click();
}
function Handlechange()
{
var fileinput = document.getElementById("thumbImage");
if (fileinput) {
	var startIndex = (fileinput.indexOf('\\') >= 0 ? fileinput.lastIndexOf('\\') : fileinput.lastIndexOf('/'));
	var filename = fileinput.substring(startIndex);
	if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
		filename = filename.substring(1);
	}
	var textinput = document.getElementById("filename");
	textinput.value = filename.value;
}

}

function HandleBrowseClickFullImage()
{
    var fileinput = document.getElementById("fullImage");
    fileinput.click();
}
function HandlechangeFullImage()
{
var fileinput = document.getElementById("fullImage");
if (fileinput) {
	var startIndex = (fileinput.indexOf('\\') >= 0 ? fileinput.lastIndexOf('\\') : fileinput.lastIndexOf('/'));
	var filename = fileinput.substring(startIndex);
	if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
		filename = filename.substring(1);
	}
	var textinput = document.getElementById("filenameFullImage");
	textinput.value = filename.value;
}

}

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById('FullImg').src =  e.target.result;
        }

        reader.readAsDataURL(input.files[0]);
    }
}
function someFun(alertMessage){
	var r = $("#rentAvailable_id").val().trim();
	if(r=="N"||r=="No")
		document.getElementById("rentPrice_id").disabled = true;
}

function goBack() {
    window.history.back();
}
</script>
</head>
<body onload="someFun()">
	<!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

	<!-- Add your site or application content here -->
	<div id="wrapper" class="homeAdmin">
		<!-- header starts-->
		<header>
			<div id="header">
				<a href="/SapeStore/manageInventory" title="SapeStore" class="logo"><img
					src="img/logo.jpg" width="231" height="109" alt="SapeStore">
				</a>
				<ul class="topLinks">
					
					
				</ul>
				<ul>
				<c:choose>
                                         <c:when test="${not empty userId}">
                                                <select id="account" name="account" style="font-size: 12px;"
                                                       onchange="changeVal()">
                                                       <option value="-1" style="font-size: 10px;">Welcome ${username}</option>
                                                       
                                                </select>
                                         </c:when>
                                  </c:choose>
				</ul>
				<!-- in case of admin hide this and display another one -->
				<nav>
					<ul class="nav">
					<li class="active"><a href="/SapeStore/manageInventory" ><spring:message code="label.edit.ManageInventory"/></a></li> 

					<li><a href="/SapeStore/manageOrders" ><spring:message code="label.edit.ManageOrders"/></a></li> 

					<li><a href="/SapeStore/adminReport"><spring:message code="label.edit.ManageReports"/></a></li> 

					<li><a href="/SapeStore/managePages" ><spring:message code="label.edit.ManagePages"/></a></li> 

					<li><a href="/SapeStore/logout" ><spring:message code="label.edit.Logout"/></a></li>
					</ul>
				</nav>
			</div>
		</header>
		<!-- header ends -->
		<section>
			<div id="mainContent" class="addAddress">
				<h2><spring:message code="label.edit.header"/></h2>
				<div class="clearfix"></div>
				<form:form id="fid" name="updateForm" action="/SapeStore/updateInventory" enctype="multipart/form-data" method="post" commandName="updateInv">
				<table>
					<fieldset>
					
					<div>
						<tr>
    					<td class="tdLabel"><label for="thumbImage_id" class="label"><spring:message code="label.edit.thumbnail"/><span class="required">*</span></label></td>
    					<td>
    						<img alt="Book Thumbnail" width="81" height="112" src="${updateBooks.thumbPath}">
    						<input type="button" value="<spring:message code="label.edit.BrowseImageButton"/>" id="fakeBrowse" name="fakeBrowse" onclick="HandleBrowseClick();"/>
							<label id="filename" style="font-size: 13px;"></label>
    						<input type="file" id="thumbImage" name="thumbImage" value="${updateBooks.thumbPath}" accept="image/gif, image/jpeg, image/jpg, image/png, image/bmp" id="thumbImage_id" placeholder="Book Thumbnail Image" style="opacity: 0" onChange="Handlechange();"/>
    					</td>
						</tr>
						</div>
						<td class="tdLabel"><label for="fullImage" class="label"><spring:message code="label.edit.Detail"/><span class="required">*</span></label></td>
						<td>
							<img id="FullImg" alt="Book Detail Image" width="81" height="112" src="${updateBooks.fullPath}">
							<input type="button" value="<spring:message code="label.edit.BrowseImageButton"/>" id="fakeBrowsefullImage" name="fakeBrowsefullImage" onclick="HandleBrowseClickFullImage();"/>
							<label id="filenameFullImage" style="font-size: 13px;"></label>
							<input type="file" id="fullImage" name="fullImage" value="${updateBooks.fullPath}" accept="image/gif, image/jpeg, image/jpg, image/png, image/bmp" id="fullImage" placeholder="${updateBooks.fullPath}" required="required" style="opacity: 0" onChange="HandlechangeFullImage();"/>
						</td>
						</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="bookTitle_id" class="label"><spring:message code="label.edit.Title"/><span class="required">*</span></label></td>
    						<td><input type="text" name="bookTitle" value="${updateBooks.bookTitle.trim()}" id="bookTitle_id" placeholder="Book Title"/></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="bookAuthor_id" class="label"><spring:message code="label.edit.Author"/><span class="required">*</span></label></td>
   							<td><input type="text" name="bookAuthor" value="${updateBooks.bookAuthor.trim()}" id="bookAuthor_id" placeholder="Book Author"/></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="isbn_id" class="label"><spring:message code="label.edit.ISBN"/><span class="required">*</span></label></td>
   							<td><input type="text" name="isbn" value="${updateBooks.isbn.trim()}" id="isbn_id" placeholder="ISBN" readonly="readonly" style="background-color:grey";/>
   								<input type="hidden" id="oldIsbn" name="oldIsbn" value="${updateBooks.isbn.trim()}"/>
   							</td>
							</tr>
						</div>
						<div>
							<tr>
    						<td><label><spring:message code="label.edit.Category"/></label><label style="color:red;">*</label></td>
										<td><form:select path="categoryId">
												<form:option value="${updateBooks.categoryId}"
													label="${updateBooks.categoryName}" /> 
												<form:options items="${categoryList}" itemValue="categoryId"
													itemLabel="categoryName" />
											</form:select></td>
										<td class="tdLabel"></td>
										<td class="errMsg" id="categoryErrorMessage"></td>
    						<!-- <td class="tdLabel"><label for="rentAvailable_id" class="label">Available for Rent</label></td>
    						<td><select name="rentAvailable" id="rentAvailable_id" onchange="dis_able()">
    							<option value="Y">Yes</option>
    							<option value="N">No</option>
								</select>
							</td> -->
    						</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="bookPrice_id" class="label"><spring:message code="label.edit.SellingPrice"/><span class="required">*</span></label></td>
    						<td><input type="text" name="bookPrice" value="${updateBooks.bookPrice}" id="bookPrice_id" placeholder="Book Price (In $)" maxlength="8"/></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="rentPrice_id" class="label"><spring:message code="label.edit.RentPrice"/><span class="required">*</span></label></td>
   							<td><input type="text" name="rentPrice" value="${updateBooks.rentPrice}" id="rentPrice_id" placeholder="Rent Price (In $)" maxlength="8"/></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="quantity_id" class="label"><spring:message code="label.edit.Quantity"/><span class="required">*</span></label></td>
    						<td><input type="text" name="quantity" value="${updateBooks.quantity}" id="quantity_id" placeholder="Quantity" maxlength="8" onchange="highlight()"/></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="publisherName_id" class="label"><spring:message code="label.edit.Publisher"/><span class="required">*</span></label></td>
    						<td><input type="text" name="publisherName" value="${updateBooks.publisherName.trim()}" id="publisherName_id" placeholder="Publisher Name"/></td>
							</tr>
						</div>

						<div>
							<tr>
							<td><label><spring:message code="label.edit.Availability"/></label><label style="color:red;">*</label></td>
										<td><form:select id="rentAvailable_id" path="rentAvailable" onchange="dis_able()">
												<form:options items="${YesNo}" />
										</form:select></td>
    						
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="bookShortDesc_id" class="label"><spring:message code="label.edit.ShortDes"/><span class="required">*</span></label></td>
    						<td><textarea name="bookShortDesc" cols="40" rows="5" id="bookShortDesc_id" placeholder="Short Description">${updateBooks.bookShortDesc.trim()}
								</textarea></td>
							</tr>
						</div>
						<div>
							<tr>
    						<td class="tdLabel"><label for="bookDetailDesc_id" class="label"><spring:message code="label.edit.DetailDes"/></label></td>
    						<td><textarea name="bookDetailDesc" cols="40" rows="10" id="bookDetailDesc_id" placeholder="Detail Description ">${updateBooks.bookDetailDesc.trim()}
								</textarea></td>
							</tr>
						</div>
					</fieldset>
					<br>

					<div id="cancel" style="width: 42em;">	
					<tr>
    				<td colspan="3">
    				<div align="right">
    					<input id="update" name="update" type="button" style="right: 30em;" value="<spring:message code="label.edit.UpdateButton"/>" onclick="submitForm()"/>
    					<button type="button" id="manageInv" name="manageInv" value="Submit" onclick="goBack()"><spring:message code="label.edit.CancelButton"/></button>
					</div></td>
					</tr>
					</div>
					</table>
				</form:form>
			</div>
		</section>

		<div class="clearfix"></div>
		<footer>
			<div id="footer">
				
		  		<div>Powered by <img src="img/sapient_nitro.jpg" width="78" height="14" alt="sapient nitro"/></div>
		  	</div>
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
</body>
</html>





