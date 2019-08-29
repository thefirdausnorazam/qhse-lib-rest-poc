<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
    <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="limitPeriodView" /></h2>
</div>
<div class="content">


<div class="header">
<h3><fmt:message key="limitPeriod" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />

<tbody>
	<tr>
		<td ><fmt:message key="id" />:</td>
		<td><c:out value="${limitPeriod.id}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="limitType" />:</td>
		<td><fmt:message key="${limitPeriod.limit.type}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="limit.frequency" />:</td>
		<td><fmt:message key="${limitPeriod.limit.frequency}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="timePeriod.${limitPeriod.timePeriod.name}" />:</td>
		<td><c:out value="${limitPeriod.timePeriod}" /></td>
	</tr>

	<c:if test="${limitPeriod.limit.owner.rate}">
	<tr>
		<td ><fmt:message key="lowerThreshold" />:</td>
		<td><c:out value="${limitPeriod.lowerThresholdAsString}" /></td>
	</tr>
	</c:if>

	<tr>
		<td ><fmt:message key="upperThreshold" />:</td>
		<td><spring:message code="${limitPeriod.upperThreshold}" text="${limitPeriod.upperThresholdAsString}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="limitReadingValue" />:</td>
		<td>
			<c:choose>
				<c:when test="${limitPeriod.limit.owner.rate}" >
					<fmt:message key="max" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" /></span><br>
					<fmt:message key="min" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.lowerValue}" text="${limitPeriod.lowerValue}" /></span>
				</c:when>
				<c:otherwise>
					<spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" />
				</c:otherwise>
			</c:choose>
		</td>
	</tr>

	<tr>
		<td ><fmt:message key="complianceStatus" />:</td>
		<td>
			<c:if test="${limitPeriod.complianceStatus != null}">
			<span class="<c:out value="${limitPeriod.complianceStatus.name}" />"><fmt:message key="${limitPeriod.complianceStatus}" /></span>
			</c:if>
		</td>
	</tr>

	<tr>
		<td ><fmt:message key="overrideQuestion" />:</td>
		<td><scannell:text value="${limitPeriod.limit.overrideQuestion}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="breached" />:</td>
		<td><fmt:message key="${limitPeriod.breached}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${limitPeriod.limit.additionalInfo}" /></td>
	</tr>

	<c:if test="${limitPeriod.reviewed}">
	<c:if test="${limitPeriod.overrideEnabled}">
	<tr>
		<td ><fmt:message key="overridden" />:</td>
		<td><fmt:message key="${limitPeriod.overridden}" /></td>
	</tr>
	</c:if>

	<tr>
		<td ><fmt:message key="reviewedBy" />:</td>
		<td><c:out value="${limitPeriod.reviewedBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${limitPeriod.reviewedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="reviewComment" />:</td>
		<td><scannell:text value="${limitPeriod.reviewComment}" /></td>
	</tr>
	</c:if>

	<c:set var="incident" value="${limitPeriod.incident}"></c:set>
	<c:if test="${incident != null}">
	<tr>
		<td ><fmt:message key="incidentStatus" />:</td>
		<td><fmt:message key="${incident.status.name}" /></td>
	</tr>
	</c:if>
</tbody>

<tfoot>
	<tr>
		<td colspan="2">
			<common:bindURL editable="${currentSiteRecord}" name="limitPeriod" site="${limitPeriod.site.name}">					
				<c:if test="${limitPeriod.reviewable}">
					<a href="<c:url value="limitPeriodBreachReview.htm"><c:param name="showId" value="${limitPeriod.id}" /></c:url>">
						<fmt:message key="limitPeriodBreachReview" /></a>&nbsp; |
				</c:if>
				<a href="<c:url value="limitView.htm"><c:param name="id" value="${limitPeriod.limit.id}"/></c:url>" ><fmt:message key="limitView" /></a> |
				<a href="<c:url value="measurementView.htm"><c:param name="id" value="${limitPeriod.limit.owner.id}"/></c:url>" ><fmt:message key="measurementView" /></a> |
				<a href="javascript:document.getElementById('queryButton').click();" ><fmt:message key="limitPeriodsViewRelated" /></a>
				<c:if test="${incident != null}">
					 | <a href="<c:url value="/incident/viewIncident.htm"><c:param name="id" value="${incident.id}"></c:param></c:url>" >
						<fmt:message key="incidentView" /></a>
				</c:if>	
			</common:bindURL>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>

<c:if test="${!empty limitPeriod.readings}">

<div class="header">
<h3><fmt:message key="readings" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive dataTable">
<thead>
	
	<tr>
		<th><fmt:message key="id" /></th>
		<th><fmt:message key="readingTime" /></th>
		<th><fmt:message key="value" /></th>
		<th><fmt:message key="quantity" /></th>
		<th><fmt:message key="measure" /></th>
		<th><fmt:message key="readingPoint" /></th>
		<th><fmt:message key="measurement.frequency" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${limitPeriod.readings}" var="reading" varStatus="s">
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="readingView.htm"><c:param name="id" value="${reading.id}"/></c:url>" ><c:out value="${reading.id}" /></a></td>
		<td><fmt:formatDate value="${reading.readingTime}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		<td><spring:message code="${reading.value}" text="${reading.value}" /></td>
		<td><c:out value="${reading.type.quantity.longName}" /></td>
		<td><c:out value="${reading.type.measure.measureName}" /></td>
		<td><c:out value="${reading.type.readingPoint.name}" /></td>
		<td><fmt:message key="${reading.type.frequency}" /></td>
	</tr>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>

<form id="queryForm" action="<c:url value="/survey/limitPeriodQuery.htmf" />" onsubmit="return search(this, 'resultsDiv', true);">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<input type="hidden" name="sortName" value="timePeriod" />
	<input type="hidden" name="limitId" value="<c:out value="${limitPeriod.limit.id}" />" />
	<button type="submit" id="queryButton" style="display: none;"><fmt:message key="readingsView" /></button>
	<div id="resultsDiv"></div>
</form>


</div>
</body>
</html>
