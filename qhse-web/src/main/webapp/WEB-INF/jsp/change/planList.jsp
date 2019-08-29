<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML>
<html>
<head>
	<title></title>
</head>
<body>
<script type="text/javascript">  
 jQuery('.recordsPerPage > select').select2();
 </script>
<c:set var="found" value="${!empty plans}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >3</c:when> 
	  <c:otherwise>2</c:otherwise> 
	</c:choose> 
</c:set>
<div class="col-md-12">
	
	<div id="block" class="">
		<div >
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
			    	<form action="<c:url value="/change/planView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
					    <fmt:message key="change.changePlanQueryForm.goTo" />
					    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
				    	<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='planEdit.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;<fmt:message key="changePlanNew" /></button>
						</c:if>
				  	</form>
		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>

<div class="header">
<h3><fmt:message key="changePlans" /></h3>
</div>

<div class="content">
<div class="table-responsive">
<div class="panel">
	<table class="table table-bordered table-responsive">
		<thead>
	
			
			<c:if test="${found}">
				<tr>
					<th><fmt:message key="auditPlan" /></th>
					<th><fmt:message key="percentCompleted" /></th>
			  		<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
				</tr>
			</c:if>
		</thead>
		<tbody>
			<tr>
				<td colspan="${colspan}">
					<c:if test="${!found}"><fmt:message key="search.empty" /></c:if>
				</td>
			</tr>
			<c:forEach items="${plans}" var="plan" varStatus="s">
				<c:choose>
					<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
					<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
				</c:choose>
				<tr class="<c:out value="${style}" />">
					<td><a href="<c:url value="planView.htm"><c:param name="id" value="${plan.id}"/></c:url>" ><c:out value="${plan.displayName}" /></a></td>
					<td><c:out value="${plan.percentCompleted}%" /></td>
					<c:if test="${showSiteColumn}"><td><c:out value="${plan.site}" /></td></c:if>
				</tr>
			</c:forEach>
			<c:if test="${found}">
				<tr>
					<td colspan="${colspan}"><scannell:paging result="${result}" /></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
</div>
</div>


</body>
</html>