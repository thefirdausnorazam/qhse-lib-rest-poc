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
		<h2>
			<fmt:message key="auditQuestionView" />
		</h2>
	</div>
	<div class="content">
<!-- 		<div class="header nowrap"> -->
<!-- 			<h3> -->
<%-- 				<fmt:message key="auditQuestion.title" /> --%>
<!-- 			</h3> -->
<!-- 		</div> -->
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col class="label" />

						<tbody>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
								<td><c:out value="${question.id}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="question" />:</td>
								<td><c:out value="${question.name}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="audit" />:</td>
								<td><c:out value="${question.audit.name}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditProgramme" />:</td>
								<td><c:out value="${question.audit.programme.description}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
								<td><scannell:text value="${question.additionalInfo}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="group" />:</td>
								<td><c:out value="${question.group.name}" /></td>
							</tr>

							<c:if test="${question.scorable}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="scoreMin" />:</td>
									<td><c:out value="${question.scoreConfig.scoreMin}" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="scoreMax" />:</td>
									<td><c:out value="${question.scoreConfig.scoreMax}" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="scoreIncrement" />:</td>
									<td><c:out value="${question.scoreConfig.scoreIncrement}" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="score" />:</td>
									<td><c:if test="${question.score ne null}">
											<c:out value="${question.score}/${question.scoreConfig.scoreMax}" />
										</c:if></td>
								</tr>
							</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
								<td><fmt:message key="${question.active}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="findingType" />:</td>
								<td><c:if test="${question.findingType != null}">
										<fmt:message key="${question.findingType}" />
									</c:if></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="findingComment" />:</td>
								<td><scannell:text value="${question.findingComment}" /></td>
							</tr>

							<c:if test="${question.completed}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="completedBy" />:</td>
									<td><c:out value="${question.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${question.completedTime}" pattern="dd-MMM-yyyy" /></td>
								</tr>
								<c:set var="result" value="${question.result}" />
								<c:if test="${result != null}">
									<tr>
										<td class="scannellGeneralLabel"><fmt:message key="result" />:</td>
										<td><scannell:entityUrl entity="${result}" messageCodePrefix="auditResult." /> (<fmt:message
												key="status" />: <fmt:message key="${result.statusCode}" />)</td>
									</tr>
								</c:if>
							</c:if>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
								<td><c:out value="${question.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${question.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
							<c:if test="${question.lastUpdatedByUser != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
									<td><c:out value="${question.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${question.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:if>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2"><c:choose>
										<c:when test="${urls != null}">
											<scannell:url urls="${urls}" />
										</c:when>
										<c:otherwise>
											<fmt:message key="auditQuestion.title" />
											<fmt:message key="notCurrentSelectedSiteMsg">
												<fmt:param value="${question.site.name}" />
											</fmt:message>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
