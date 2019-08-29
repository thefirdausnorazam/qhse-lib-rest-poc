<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<%@page import="com.scannellsolutions.modules.audit.domain.AuditQuestion"%>
<%@page import="com.scannellsolutions.entity.AbstractEntity"%>
<%@page import="com.scannellsolutions.modules.action.domain.Action"%>
<%@page import="com.scannellsolutions.modules.incident.domain.Incident"%>
<html>
<head>
<title></title>

</head>
<body>

	<div class="header nowrap">
		<h2>
			<fmt:message key="auditReport" />
		</h2>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">


					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="type" />:</td>
							<td><c:out value="${audit.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
							<td><c:out value="${audit.leadAuditor.displayName}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="auditee" />:</td>
							<td><c:out value="${audit.auditee.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="template" />:</td>
							<td><c:out value="${audit.template.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="startDate" />:</td>
							<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="location" />:</td>
							<td><c:out value="${audit.deptLocation}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" />:</td>
							<td><scannell:text value="${audit.additionalInfo}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="resultSummary" />:</td>
							<td><c:out value="${audit.resultSummary}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel nowrap"><fmt:message key="completionComment" />:</td>
							<td><scannell:text value="${audit.completionComment}" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<h3 style="text-align: center;">Full Audit Report details available in enviroAUDIT</h3>


	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<th><fmt:message key="question" /></th>
							<th><fmt:message key="findingComment" /></th>
							<th><fmt:message key="findingType.short" /></th>
							<th><fmt:message key="action" /></th>
							<th><fmt:message key="responsibleUser" /></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${audit.actionableQuestionsBySeverity}" var="question" varStatus="s">
							<c:choose>
								<c:when test="${s.index mod 2 == 0}">
									<c:set var="style" value="even" />
								</c:when>
								<c:otherwise>
									<c:set var="style" value="odd" />
								</c:otherwise>
							</c:choose>
							<tr class="<c:out value="${style}" />" style="vertical-align: top;">
								<td><c:out value="${question.name}" /><br />
								<br />
								<scannell:text value="${question.additionalInfo}" /></td>
								<td><scannell:text value="${question.findingComment}" /></td>
								<td><fmt:message key="${question.findingType}.short" /></td>
								<td>
									<%
										pageContext.removeAttribute("action");
											AbstractEntity result = ((AuditQuestion) pageContext.getAttribute("question")).getResult();
											Action action = null;
											if (result instanceof Action) {
												action = ((Action) result);
											} else if (result instanceof Incident) {
												action = (Action) ((Incident) result).getCurrentActions().get(0);
											}
											if (action != null) {
												pageContext.setAttribute("action", action);
											}
									%> <scannell:text value="${action.description}" />
								</td>
								<td><c:out value="${action.responsibleUser.displayName}" /> <br />
								<br /> <c:if test="${action.completionTargetDate != null}">
										<fmt:message key="due" />
										<br />
										<fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" />
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
