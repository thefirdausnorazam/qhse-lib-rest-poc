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
<h2><fmt:message key="quantityView" /></h2>
</div>
<div class="content"> 
<div class="header">
<h3><fmt:message key="quantity" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />

<tbody>
	<tr>
		<td ><fmt:message key="id" />:</td>
		<td><c:out value="${quantity.id}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="name" />:</td>
		<td><scannell:text value="${quantity.name}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="description" />:</td>
		<td><scannell:text value="${quantity.description}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="responsibleUser" />:</td>
		<td><c:out value="${quantity.responsibleUser.displayName}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="active" />:</td>
		<td><fmt:message key="${quantity.active}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="categoryName" />:</td>
		<td><c:out value="${quantity.category.name}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="categoryType" />:</td>
		<td><fmt:message key="${quantity.category.type}" /></td>
	</tr>
	<tr>
		<td ><fmt:message key="createdBy" />:</td>
		<td><c:out value="${quantity.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${quantity.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${quantity.lastUpdatedByUser != null}">
	<tr>
		<td ><fmt:message key="lastUpdatedBy" />:</td>
		<td>
			<c:out value="${quantity.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${quantity.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
		</td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<common:bindURL editable="${currentSiteRecord}" name="quantity" site="${quantity.site.name}">
				<c:if test="${quantity.editable}">
					<a href="<c:url value="quantityEdit.htm"><c:param name="showId" value="${quantity.id}" /></c:url>"><fmt:message key="quantityEdit" /></a> |
				</c:if>
				<a href="<c:url value="quantityCategoryView.htm"><c:param name="id" value="${quantity.category.id}"/></c:url>"><fmt:message key="quantityCategoryView" /></a> |
				<c:if test="${quantity.lastUpdatedByUser != null}">
					<a href="javascript:openHistory(<c:out value="${quantity.id},'${quantity['class'].name}'" />)"><fmt:message key="viewHistory" /></a> |
				</c:if>
				<a href="javascript:document.getElementById('queryButton').click();" ><fmt:message key="measurementView" /></a>
			</common:bindURL>	
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>

<br />
<form id="queryForm" action="<c:url value="/survey/measurementQuery.htmf" />" onsubmit="return search(this, 'resultsDiv', true);">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<input type="hidden" name="sortName" value="timePeriod" />
	<input type="hidden" name="quantityId" value="<c:out value="${quantity.id}" />" />
	<button type="submit" id="queryButton" style="display: none;"><fmt:message key="measurementView" /></button>

	<div id="resultsDiv"></div>
</form>

</body>
</html>
