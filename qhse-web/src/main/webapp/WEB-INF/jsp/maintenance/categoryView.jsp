<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="maintenanceCategoryView.${category.type.name}" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col />
<tbody>
	<tr>
		<td ><fmt:message key="id" />:</td>
		<td><c:out value="${category.id}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="name" />:</td>
		<td><scannell:text value="${category.name}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="active" />:</td>
		<td><fmt:message key="${category.active}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="createdBy" />:</td>
		<td><c:out value="${category.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${category.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>

	<c:if test="${category.lastUpdatedByUser != null}">
	<tr>
		<td ><fmt:message key="lastUpdatedBy" />:</td>
		<td>
			<c:out value="${category.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${category.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
		</td>
	</tr>
	</c:if>
</tbody>

<tfoot>
	<tr>
		<td colspan="2">
			<c:if test="${canConfigure}">
			<button data-placement="top" data-toggle="tooltip" onclick="window.location.href='<c:url value="categoryEdit.htm"><c:param name="showId" value="${category.id}" /></c:url>';" data-original-title="<fmt:message key="maintenanceCategoryEdit" />" type="button" class="g-btn g-btn--primary">
			 <i class="fa fa-chevron-circle-up"></i> <fmt:message key="maintenanceCategoryEdit" /></button>				
			</c:if>
			<button data-placement="top" data-toggle="tooltip" onclick="window.location.href='<c:url value="/maintenance/categoryList.htm" ><c:param name="type" value="${category.type.name}" /></c:url>';" data-original-title="<fmt:message key="maintenanceCategoryList.${category.type.name}" />" type="button" class="g-btn g-btn--primary">
			 <i class="fa fa-chevron-circle-up"></i> <fmt:message key="maintenanceCategoryList.${category.type.name}" /></button>		
		
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
