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
</head>
<body>
	<div class="content">
		<div class="header">
			<h3>
				<fmt:message key="reading" />
			</h3>
		</div>
		<div class="table-responsive">
			<table class="table table-bordered table-responsive">

				<tbody>
					<tr>
						<td><fmt:message key="id" />:</td>
						<td><c:out value="${reading.id}" /></td>

						<td><fmt:message key="status" />:</td>
						<td><fmt:message key="${reading.status}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="quantity" />:</td>
						<td colspan="3"><c:out value="${reading.type.quantity.longName}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="measure" />:</td>
						<td><c:out value="${reading.type.measure.measureName}" /></td>

						<td><fmt:message key="readingPoint" />:</td>
						<td><c:out value="${reading.type.readingPoint.name}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="measurement.frequency" />:</td>
						<td><c:out value="${reading.readingMetaData == null ? reading.type.frequencyDisplay : reading.readingMetaData.frequencyDisplay}" /> </td>

						<td><fmt:message key="timePeriod.${reading.timePeriod.name}" />:</td>
						<td><fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="additionalInfo" />:</td>
						<td colspan="3"><scannell:text value="${reading.type.additionalInfo}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="readingTime" />:</td>
						<td><fmt:formatDate value="${reading.readingTime}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

						<td><fmt:message key="value" />:</td>
						<td><spring:message code="${reading.customUnitValueOfUnitSelected}" text="${reading.customUnitValueOfUnitSelected}" /></td>
					</tr>

					<tr>
						<td><fmt:message key="comment" />:</td>
						<td colspan="3"><scannell:text value="${reading.notes}" /></td>
					</tr>

					<c:if test="${reading.updateComment != null}">
						<tr>
							<td><fmt:message key="updateComment" />:</td>
							<td colspan="3"><scannell:text value="${reading.updateComment}" /></td>
						</tr>
					</c:if>
					<!--
  <tr>
    <th><fmt:message key="active" />:</th>
    <td><fmt:message key="${reading.active}" /></td>
  </tr>
  -->

					<tr>
						<td><fmt:message key="createdBy" />:</td>
						<td colspan="3"><c:out value="${reading.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${reading.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
					</tr>

					<c:if test="${reading.lastUpdatedByUser != null}">
						<tr>
							<td><fmt:message key="lastUpdatedBy" />:</td>
							<td colspan="3"><c:out value="${reading.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${reading.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4">
							<common:bindURL editable="${currentSiteRecord}" name="reading" site="${reading.site.name}">
								<c:if test="${reading.editable}">
									<c:url var="editURL" value="readingEdit.htm">
										<c:param name="showId" value="${reading.id}" />
									</c:url>
									<c:choose>
										<c:when test="${reading.due or reading.overdue}">
											<a href="<c:out value="${editURL}" />">
												<fmt:message key="readingEnterValue" />
											</a> | </c:when>
										<c:otherwise>
											<a href="<c:out value="${editURL}"/>">
												<fmt:message key="readingEdit" />
											</a> | </c:otherwise>
									</c:choose>
									<c:if test="${!reading.trashed}">
										<a href="<c:url value="readingTrash.htm"><c:param name="showId" value="${reading.id}"/></c:url>">
											<fmt:message key="readingTrash" />
										</a> | 
	        						</c:if>
								</c:if> 
								<a href="<c:url value="measurementView.htm"><c:param name="id" value="${reading.type.id}"/></c:url>">
									<fmt:message key="measurementView" />
								</a> 
								<c:if test="${reading.lastUpdatedByUser != null}">
	        						| <a href="javascript:openHistory(<c:out value="${reading.id},'${reading['class'].name}'" />)">
										<fmt:message key="viewHistory" />
									</a>
								</c:if>
							</common:bindURL>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>

	<c:if test="${!empty reading.limitPeriods}">
		<div class="header">
			<h3>
				<fmt:message key="limitPeriods" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">
					<thead>

						<tr>
							<th><fmt:message key="type" /></th>
							<th><fmt:message key="limit.frequency" /></th>
							<th><fmt:message key="lowerThreshold" /></th>
							<th><fmt:message key="upperThreshold" /></th>
							<th><fmt:message key="limitReadingValue" /></th>
							<th><fmt:message key="status" /></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reading.limitPeriodsSortedByStartTime}" var="limitPeriod">
							<tr>
								<td><a href="<c:url value="limitPeriodView.htm"><c:param name="id" value="${limitPeriod.id}"/></c:url>">
										<fmt:message key="${limitPeriod.limit.type}" />
									</a></td>
								<td><fmt:message key="${limitPeriod.limit.frequency}" /></td>
								<td><spring:message code="${limitPeriod.lowerThreshold}" text="${limitPeriod.lowerThresholdAsString}" /></td>
								<td><spring:message code="${limitPeriod.upperThreshold}" text="${limitPeriod.upperThresholdAsString}" /></td>
								<td><c:choose>
										<c:when test="${limitPeriod.limit.owner.rate}">
											<fmt:message key="max" />: <span style="white-space: nowrap;">
												<spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" />
											</span>
											<br>
											<fmt:message key="min" />: <span style="white-space: nowrap;">
												<spring:message code="${limitPeriod.lowerValue}" text="${limitPeriod.lowerValue}" />
											</span>
										</c:when>
										<c:otherwise>
											<spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:if test="${limitPeriod.complianceStatus != null}">
										<span class="<c:out value="${limitPeriod.complianceStatus.name}" />">
											<fmt:message key="${limitPeriod.complianceStatus}" />
										</span>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>

</body>
</html>
