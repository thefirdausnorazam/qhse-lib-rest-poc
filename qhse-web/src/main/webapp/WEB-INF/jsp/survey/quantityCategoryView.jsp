<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="quantityCategoryView" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<thead>
	<tr>
		<td colspan="2"><fmt:message key="quantityCategory" /></td>
	</tr>
</thead>

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
		<td ><fmt:message key="type" />:</td>
		<td><fmt:message key="${category.type}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="description" />:</td>
		<td><scannell:text value="${category.description}" /></td>
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
			<common:bindURL editable="${currentSiteRecord}" name="category" site="${category.site.name}">
				<c:if test="${category.editable}">
					<a href="<c:url value="quantityCategoryEdit.htm"><c:param name="showId" value="${category.id}" /></c:url>"><fmt:message key="quantityCategoryEdit" /></a> |
					<a href="<c:url value="quantityEdit.htm" ><c:param name="categoryId" value="${category.id}" /></c:url>"><fmt:message key="quantityCreate" /></a> 
				</c:if>
				<c:if test="${category.lastUpdatedByUser != null}">
					 | <a href="javascript:openHistory(<c:out value="${category.id},'${category['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
				</c:if>
			</common:bindURL>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>

<c:if test="${!empty category.quantities}">
<div class="header">
<h2><fmt:message key="quantities" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>
	
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="responsibleUser" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${category.quantities}" var="quantity">
	<tr>
		<td><a href="<c:url value="quantityView.htm"><c:param name="id" value="${quantity.id}" /></c:url>"><c:out value="${quantity.name}" /></a></td>
		<td><c:out value="${quantity.responsibleUser.displayName}" /></td>
		<td><fmt:message key="${quantity.active}" /></td>
	</tr>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>

</body>
</html>
