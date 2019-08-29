<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css" media="all">
@import "<c:url value='/css/risk.css'/>";
</style>
<style type="text/css">
/* Style the Image Used to Trigger the Modal */
body {
	background-color: white;
}
</style>
<title><fmt:message key="assessmentQueryResult.title" /></title>
</head>
<body bgcolor="#E6E6F;">
	<script type="text/javascript">
		jQuery(document).ready(
				function() {
					setFooterColSpan();
					jQuery(".popup-content+button").hide();
					initSortTablesForClassCallBack('dataTableRA');
					jQuery('table.templateTable').each(function(e) {
						setFooterColSpanById(jQuery(this).attr('id'))
						initSortTablesForIdCallBack(jQuery(this).attr('id'));
					});
					jQuery('select').select2();
					jQuery(".deleteRow").show();
					jQuery( ".deleteRow" ).removeClass( "odd" );
					jQuery( ".deleteRow" ).removeClass( "even" );


				});
		if (typeof backChangeSelectNames !== 'undefined'
				&& $.isFunction(backChangeSelectNames)) {
			backChangeSelectNames();
		}

		if ('${searchByLegacyId}' == 'true') {
			if ('${fn:length(result.results)}' == '1') {
				location.href = '${pageContext.request.contextPath}'
						+ '/risk/assessmentView.htm?id=${result.results[0].id}';
			}
		}
	</script>
	<c:set var="found" value="${!empty result.results}" />
	<jsp:include page="showCurrentThreshold.jsp" />
	<div class="header">
		<h3>
			<fmt:message key="assessmentQueryResult.searchResults" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">


			<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
			<c:forEach items="${templateResults}" var="result"
				varStatus="templateStatus">
				<c:set var="found" value="${!empty result.results}" />
				<c:choose>
					<c:when test="${found}">
						<c:set var="recordsExists" value="true" />
						<c:set var="templateIdPram" value="${assessment.template.id}" />
						<c:set var="changeRow" value="false" />
						<c:forEach items="${result.results}" var="assessment"
							varStatus="s">
							<c:if test="${changeRow}">
							<c:set var="changeRow" value="false" />
							</c:if>
							<c:if test="${assessment.template.id  != templateIdPram}">
							<c:set var="templateIdPram" value="${assessment.template.id}" />
							<c:set var="changeRow" value="true" />
							</c:if>
							<c:if test="${s.index == 0}">
								<div class="panel">
									<div class="div-for-pagination">
										<scannell:paging result="${result}" />
									</div>
									<table id="RA"
										class="table table-responsive table-bordered templateTable">
										<thead>
											<tr>
												<th><fmt:message key="id" />/<fmt:message key="assessment.name" /></th>
												<th><fmt:message key="assessment.template" /></th>
												<th><fmt:message key="assessment.status" /></th>
												<th><fmt:message key="assessment.approvalByUser" /></th>
												<th><fmt:message key="assessment.responsibleUser" /></th>
												<th><fmt:message key="assessment.score" /></th>

												<c:if test="${showSiteColumn and not groupSite}">
													<th><fmt:message key="site" /></th>
												</c:if>
												<c:if test="${showLegacyId}">
													<th><fmt:message key="legacyId" /></th>
												</c:if>
												<th class="printColumn">Print</th>
											</tr>
										</thead>
										<tbody>

											</c:if>

												<c:if test="${changeRow}">
													<tr class="deleteRow" style="background-color:#DCDCDC; font-weight:bold">
														<td><scannell:text value="${assessment.template.name}" /></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
											</c:if>
											<%-- <risk:assessment2 assessment="${assessment}" style="${style}" showSiteColumn="${showSiteColumn}" riskType="${riskType}" template="${assessment.template}" showLegacyIds="${showLegacyId}" showAllRA="${showAllRA}"/> --%>
											<c:set var="threshold" value="${assessment.threshold}" />
											<tr class="<c:out value="${style}" />">
												<td><c:choose>
														<c:when test="${assessment.type eq riskType}">
															<c:url var="assessmentURL"
																value="/risk/expressAssessmentView.htm">
																<c:param name="showId" value="${assessment.id}" />
															</c:url>
														</c:when>
														<c:otherwise>
															<c:url var="assessmentURL"
																value="/risk/assessmentView.htm">
																<c:param name="id" value="${assessment.id}" />
															</c:url>
														</c:otherwise>
													</c:choose> <a href="<c:out value="${assessmentURL}"/>"><c:out
															value="${assessment.displayId}" /></a> <br> <c:if
														test="${assessment.confidential}">
														<fmt:message key="assessment.confidential" />
													</c:if> <c:if test="${assessment.sensitiveDataViewable}">
														<scannell:text value="${assessment.name}" />
													</c:if></td>
												<td><scannell:text value="${assessment.template.name}" />
												</td>
												<td><fmt:message key="assessment${assessment.status}" /></td>
												<td><c:out
														value="${assessment.approvalByUser.displayName}" /></td>
												<td><c:out
														value="${assessment.responsibleUser.displayName}" /></td>
												<td><c:if test="${assessment.template.prefix != 'SA' and assessment.template.scorable}">
														<c:set var="threshold" value="${assessment.threshold}" />
														<c:choose>
															<c:when
																test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
																<img
																	src="<c:url value="/images/risk/score_redlight.giff" />" />
															</c:when>
															<c:when
																test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
																<img
																	src="<c:url value="/images/risk/score_amberlight.giff" />" />
															</c:when>
															<c:when
																test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
																<img
																	src="<c:url value="/images/risk/score_redlight.giff" />" />
															</c:when>
															<c:when
																test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
																<img
																	src="<c:url value="/images/risk/score_yellowlight.giff" />" />
															</c:when>
															<c:when
																test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
																<img
																	src="<c:url value="/images/risk/score_amberlight.giff" />" />
															</c:when>
															<c:otherwise>
																<img
																	src="<c:url value="/images/risk/score_greenlight.giff" />" />
															</c:otherwise>
														</c:choose>
														<c:out value="${assessment.score}" />
													</c:if></td>
												<c:if test="${showSiteColumn}">
													<td><c:out value="${assessment.site.name}" /></td>
												</c:if>
												<c:if test="${showLegacyId}">
													<td> <c:out value="${assessment.legacyId}" /> </td>
												</c:if>
												<td><a
													href="<c:out value="${assessmentURL}" />&printable=true"
													target="printWindow"><img alt="Print"
														src="<c:url value="/images/print.gif" />"></a> <br>
												</td>
											</tr>
											
											<c:if test="${s.last}">
												<tfoot>
													<tr>
														<td><scannell:paging result="${result}" /></td>
													</tr>
												</tfoot>
										</tbody>
									</table>
								</div>
							</c:if>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</body>
</html>
