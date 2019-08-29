<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="measurementQueryResult" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTablesForClass('dataTableLimitPeriod');
		} );
	</script>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >11</c:when> 
	  <c:otherwise>10</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3><fmt:message key="searchResults" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
<c:set var="found" value="${!empty result.results}" />
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-bordered table-responsive dataTableLimitPeriod">
<thead>
	
	<tr>
		<th><fmt:message key="id" /></th>
		<th><fmt:message key="measurement" /></th>
		<th><fmt:message key="limitType" /></th>
		<th><fmt:message key="limit.frequency" /></th>
		<th><fmt:message key="timePeriod" /></th>
		<th><fmt:message key="lowerThreshold" /></th>
		<th><fmt:message key="upperThreshold" /></th>
		<th><fmt:message key="limitReadingValue" /></th>
		<th><fmt:message key="complianceStatus" /></th>
		<th><fmt:message key="reviewed" /></th>
		<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
	</tr>
</thead>

<tbody>

	<c:forEach items="${result.results}" var="limitPeriod" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}">
				<c:set var="style" value="even" />
			</c:when>
			<c:otherwise>
				<c:set var="style" value="odd" />
			</c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><a href="<c:url value="limitPeriodView.htm"><c:param name="id" value="${limitPeriod.id}"/></c:url>" ><c:out value="${limitPeriod.id}" /></a></td>
			<td><c:out value="${limitPeriod.limit.owner.description}" /></td>
			<td><fmt:message key="${limitPeriod.limit.type}" /></td>
			<td><fmt:message key="${limitPeriod.limit.frequency}" /></td>
			<td><c:out value="${limitPeriod.timePeriod}" /></td>
			<td><c:out value="${limitPeriod.lowerThresholdAsString}" /></td>
			<td><spring:message code="${limitPeriod.upperThreshold}" text="${limitPeriod.upperThresholdAsString}" /></td>
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
			<td>
			<c:if test="${limitPeriod.complianceStatus != null}">
				<span class="<c:out value="${limitPeriod.complianceStatus.name}" />"><fmt:message key="${limitPeriod.complianceStatus}" /></span>
			</c:if>
			</td>
			<td><fmt:message key="${limitPeriod.reviewed}" /></td>
        	<c:if test="${showSiteColumn}"><td><c:out value="${limitPeriod.site}" /></td></c:if>
		</tr>
	</c:forEach>
	<tfoot>
		<c:if test="${found}">
			<tr>
				<td colspan="${colspan}"> <scannell:paging result="${result}" /></td>
			</tr>
		</c:if>
	</tfoot>
</tbody>

</table>
</div>
</div>
</div>
</body>
</html>
