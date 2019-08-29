<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
<script type="text/javascript">
	function scroll(object) {
		$('html, body').animate({
	        scrollTop: $("#"+object).offset().top
	    }, 2000);
	}
</script>

<style>
@import "<c:url value='/css/survey.css'/>";
</style>

</head>
<body>
	
	<div class="content">


		<div class="header">
			<h3>
				<fmt:message key="measurement" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">
					<col />


					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" /></td>
							<td><c:out value="${measurement.id}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="quantity" /></td>
							<td><c:out value="${measurement.quantity.longName}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementView.parameterOwner" /></td>
							<td><c:out value="${measurement.quantity.responsibleUser.displayName}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="measure" /></td>
							<td><c:out value="${measurement.measure.measureName}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="readingPoint" /></td>
							<td><c:out value="${measurement.readingPoint.description}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementView.frequency" /></td>
							<td><c:out value="${measurement.frequencyDisplay}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementView.initialMeasurmentDate" /></td>
							<td><fmt:formatDate value="${measurement.initialMeasurmentDate}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementView.notificationRequested" /></td>
							<td><fmt:message key="${measurement.notificationRequested}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementView.alertLeadDays" /></td>
							<td><c:out value="${measurement.alertLeadDays}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="defaultUnit" /></td>
							<td><c:out value="${measurement.defaultUnit.name}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="survey.measurementEdit.customUnit" /></td>
							<td><c:if test="${measurement.customUnit != null}">
									<c:out value="${measurement.customUnit.symbol} (${measurement.customUnit.convertFromBaseFunction.expression})" />
								</c:if></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="authorisedUsers" /></td>
							<td><c:forEach items="${measurement.authorisedUsers}" var="user" varStatus="status">
									<c:out value="${user.displayName}" />
									<c:if test="${!status.last}">, </c:if>
								</c:forEach></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="active" /></td>
							<td><fmt:message key="${measurement.active}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" /></td>
							<td><scannell:text value="${measurement.additionalInfo}" /></td>
						</tr>

						<c:choose>
							<c:when test="${measurement.lastUpdatedByUser != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" /></td>
									<td><c:out value="${measurement.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${measurement.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="createdBy" /></td>
									<td><c:out value="${measurement.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${measurement.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>

					<tfoot>
						<tr>
							<td colspan="2">
								<c:choose>
									<c:when test="${currentSiteRecord}">
										<c:if test="${measurement.editable}">
											<a href="<c:url value="measurementEdit.htm"><c:param name="showId" value="${measurement.id}" /></c:url>">
												<fmt:message key="measurementEdit" />
											</a> |
											<a href="<c:url value="limitEdit.htm"><c:param name="measurementId" value="${measurement.id}" /></c:url>">
																	<fmt:message key="limitCreate" />
																</a> |
											<a href="<c:url value="editMeasurementAttachment.htm"><c:param name="showId" value="${measurement.id}" /></c:url>">
																	<fmt:message key="addAttachment" />
																</a> |
										</c:if> 
										<c:if test="${measurement.readingEnterable}">
											<a href="<c:url value="readingEdit.htm"><c:param name="measurementId" value="${measurement.id}" /></c:url>">
												<fmt:message key="readingCreate" />
											</a> |
										</c:if> 
										<c:if test="${measurement.lastUpdatedByUser != null}">
											<a href="javascript:openHistory(<c:out value="${measurement.id},'${measurement['class'].name}'" />)">
												<fmt:message key="viewHistory" />
											</a> |
										</c:if> 
										<a href="javascript:document.getElementById('queryButton').click();scroll('readings');">
											<fmt:message key="readingsView" />
										</a>
									</c:when>
									<c:otherwise>
										<fmt:message key="measurement" />
										<fmt:message key="notCurrentSelectedSiteMsg">
											<fmt:param value="${measurement.site.name}" />
										</fmt:message>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>


		<c:if test="${!empty measurement.limits}">
			<div class="header">
				<h3>
					<fmt:message key="limits" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<table class="table table-responsive table-bordered">
						<thead>

							<tr>
								<th><fmt:message key="type" /></th>
								<th><fmt:message key="lowerThreshold" /></th>
								<th><fmt:message key="upperThreshold" /></th>
								<th><fmt:message key="limit.frequency" /></th>
								<th><fmt:message key="active" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${measurement.limits}" var="limit">
								<tr>
									<td><a href="<c:url value="limitView.htm"><c:param name="id" value="${limit.id}" /></c:url>">
											<fmt:message key="${limit.type}" />
										</a></td>
									<td><spring:message code="${limit.lowerThreshold}" text="${limit.lowerThresholdAsString}" /></td>
									<td><spring:message code="${limit.upperThreshold}" text="${limit.upperThresholdAsString}" /></td>
									<td><fmt:message key="${limit.frequency}" /></td>
									<td><fmt:message key="${limit.active}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>

		<c:if test="${!empty measurement.attachments}">
			<a name="attachments"></a>
			<div class="header">
				<h3>
					<fmt:message key="attachments" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<table class="table table-bordered table-responsive">


						<tbody>
							<c:forEach items="${measurement.attachments}" var="item">
								<c:if test="${item.active}">
									<tr>
										<td><c:choose>
												<c:when test="${item.type.name == 'attach'}">
													<a target="attachment"
														href="<c:url value="viewMeasurementAttachment.htm"><c:param name="id" value="${item.id}" /></c:url>">
														<c:out value="${item.name}" />
													</a>
												</c:when>
												<c:otherwise>
													<a target="attachment" href="<c:out value="${item.externalUrl}" />">
														<c:out value="${item.name}" />
													</a>
												</c:otherwise>
											</c:choose> <br /> <c:out value="${item.createdByUser.displayName}" /><br /> <fmt:formatDate
												value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
										<td><scannell:text value="${item.description}"/></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2">
									<common:bindURL editable="${currentSiteRecord}" name="measurement" site="${measurement.site.name}">
										<c:if test="${measurement.editable}">
											<a
												href="<c:url value="editMeasurementAttachment.htm"><c:param name="showId" value="${measurement.id}" /></c:url>">
												<fmt:message key="addAttachment" />
											</a> | 
										</c:if> 
										<c:if test="${measurement != null && measurement.attachmentsEditable && !empty measurement.attachments}">
											<a
												href="<c:url value="editMeasurementAttachments.htm"><c:param name="showId" value="${measurement.id}" /></c:url>">
												<fmt:message key="editMeasurementAttachments" />
											</a>
										</c:if>
									</common:bindURL>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</c:if>

		<div id="readings">
			<form id="queryForm" action="<c:url value="/survey/readingQuery.htmf" />"
				onsubmit="return search(this, 'resultsDiv', true);">
				<input type="hidden" name="calculateTotals" value="true" />
				<input type="hidden" name="pageNumber" value="1" />
				<input type="hidden" id="pageSize" name="pageSize" />
				<input type="hidden" name="sortName" value="timePeriod" />
				<input type="hidden" name="typeId" value="<c:out value="${measurement.id}" />" />
				<button type="submit" id="queryButton" style="display: none;">
					<fmt:message key="readingsView" />
				</button>
		<input type="hidden" name="sortByTimePeriod" value="true">
				<div id="resultsDiv"></div>
			</form>
		</div>
	</div>
</body>
</html>
