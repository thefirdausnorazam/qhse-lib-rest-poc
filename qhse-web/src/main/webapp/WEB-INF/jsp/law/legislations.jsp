<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="confidential" content="false">
  <meta name="printCopyright" content="true">
<style type="text/css">
.gre {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: #13ab94;
}
.re {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: red;
}
.bl {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: #4D90FD;
}
.blu {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: white;
	background-color: #4D90FD;
}
.accordion.accordion-semi .panel-head a {
background-color: #FFF !important;
color: #00b1ac!important;
transition: background-color 200ms ease-in-out !important;
border-bottom: 0px solid #FFF !important;
}
</style>

<%@ include file="headInclude.jsp" %>
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jquery.blockUI.js" />"></script>

<title></title>


</head>
<body> 
<script type="text/javascript">
jQuery(document).ready(function() {
	  jQuery('.cat').on('click', function() {
	    var url;
	    url = '<law:url value="/law/legislationsView.htm?legRegister=" />' + jQuery('#lawTabs').val() + '&catId=' + jQuery(this).attr('cat-id');
	    location.href = url;
	  });
	  jQuery('.withoutCat').on('click', function() {
	    var urlCat;
	    urlCat = '<law:url value="/law/legislationsView.htm?legRegister=" />' + jQuery('#lawTabs').val();
	    location.href = urlCat;
	  });	  
	});
 </script>  
	<!-- <div class="row">			
		<div class="content"> -->
						<!--For Loop First -->

		 <div class="list-group tickets">
		 <c:set var="total" value="0"/>
		 <li href="#" class="list-group-item withoutCat"><a href="#">All</a> <span class="badge badge-warning" >${legTotal} </span></li>		         
		 <c:forEach items="${categoryCountDetails}" var="categoryEntry">		  
	       <li href="#" class="list-group-item cat" cat-id="${categoryEntry.key.id}">	       
	       <a href="#" >${categoryEntry.key.name}</a> <span class="badge badge-primary">${categoryEntry.value}</span></li>		   
		 </c:forEach>
		 </div>

		<!-- </div>
	</div>  -->
</body>
</html>
