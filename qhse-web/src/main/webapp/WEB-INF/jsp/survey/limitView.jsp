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
<h2><fmt:message key="limitView" /></h2>
</div>
<div class="content"> 
<div class="header">
<h3><fmt:message key="survey.limitView.title" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />


<tbody>
	<tr>
		<td ><fmt:message key="id" />:</td>
		<td><c:out value="${limit.id}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="quantity" />:</td>
		<td><c:out value="${limit.owner.quantity.longName}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="measure" />:</td>
		<td><c:out value="${limit.owner.measure.measureName}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="measurement.frequency" />:</td>
		<td><fmt:message key="${limit.owner.frequency}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="readingPoint" />:</td>
		<td><c:out value="${limit.owner.readingPoint.name}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="type" />:</td>
		<td><fmt:message key="${limit.type}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="limit.frequency" />:</td>
		<td><fmt:message key="${limit.frequency}" /></td>
	</tr>

	<c:if test="${limit.owner.rate}" >
	<tr>
		<td ><fmt:message key="lowerThreshold" />:</td>
		<td><c:out value="${limit.lowerThresholdAsString}" /></td>
	</tr>
	</c:if>

	<c:if test="${limit.owner.numeric}" >
	<tr>
		<td ><fmt:message key="upperThreshold" />:</td>
		<td><c:out value="${limit.upperThresholdAsString}" /></td>
	</tr>
	</c:if>

	<tr>
		<td ><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${limit.additionalInfo}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="overrideEnabled" />:</td>
		<td><fmt:message key="${limit.overrideEnabled}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="overrideQuestion" />:</td>
		<td><scannell:text value="${limit.overrideQuestion}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="active" />:</td>
		<td><fmt:message key="${limit.active}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="createdBy" />:</td>
		<td><c:out value="${limit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${limit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>

	<c:if test="${limit.lastUpdatedByUser != null}">
	<tr>
		<td ><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${limit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${limit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>

<tfoot>
	<tr>
		<td colspan="2">
			<common:bindURL editable="${currentSiteRecord}" name="limit" site="${limit.site.name}">					
				<c:if test="${limit.owner.editable}">
					<a href="<c:url value="limitEdit.htm"><c:param name="showId" value="${limit.id}" /></c:url>"><fmt:message key="limitEdit" /></a>&nbsp;|
				</c:if>
					<a href="<c:url value="measurementView.htm"><c:param name="id" value="${limit.owner.id}"/></c:url>" ><fmt:message key="measurementView" /></a> |
					<a href="javascript:document.getElementById('queryButton').click();" ><fmt:message key="survey.limitView.viewLimitPeriods" /></a> |
				<c:if test="${limit.lastUpdatedByUser != null}">
					<a href="javascript:openHistory(<c:out value="${limit.id},'${limit['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
				</c:if>
			</common:bindURL>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
<form id="queryForm" action="<c:url value="/survey/limitPeriodQuery.htmf" />" onsubmit="return search(this, 'resultsDiv', true);">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<input type="hidden" name="sortName" value="timePeriod" />
	<input type="hidden" name="limitId" value="<c:out value="${limit.id}" />" />
	<button type="submit" id="queryButton" style="display: none;"><fmt:message key="readingsView" /></button>
	<div id="resultsDiv"></div>
</form>

</body>
</html>
