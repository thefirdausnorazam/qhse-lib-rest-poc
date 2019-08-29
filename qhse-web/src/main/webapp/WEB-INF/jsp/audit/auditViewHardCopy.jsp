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
	<div class="header nowrap">
		<h2>
			<fmt:message key="audit.title" />
		</h2>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">


					<tbody>
						<tr>
							<th><fmt:message key="programme" /> <fmt:message key="name" />:</th>
							<td><c:out value="${audit.programme.description}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="audit" /> <fmt:message key="name" />:</th>
							<td><c:out value="${audit.name}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="leadAuditor" />:</th>
							<td><c:out value="${audit.leadAuditor.displayName}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="auditee" />:</th>
							<td><c:out value="${audit.auditee.name}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="secondaryAuditors" />:</th>
							<td><c:forEach items="${audit.secondaryAuditors}" var="auditor" varStatus="loopStatus">
									<c:if test="${!loopStatus.first}">, </c:if>
									<c:out value="${auditor.displayName}" />
								</c:forEach></td>
						</tr>
						<tr>
							<th><fmt:message key="otherParticipants" />:</th>
							<td><scannell:text value="${audit.otherParticipants}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="additionalInfo" />:</th>
							<td><scannell:text value="${audit.additionalInfo}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="template" />:</th>
							<td><c:out value="${audit.template.name}" /></td>
						</tr>
						<tr>
							<th><fmt:message key="location" />:</th>
							<c:if test="${audit.deptLocation != null}">
								<td><c:out value="${audit.deptLocation}" /></td>
							</c:if>
						</tr>
						<tr>
							<th><fmt:message key="startTime" />:</th>
							<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
						</tr>
						<tr>
							<th><fmt:message key="duration" />:</th>
							<td><c:out value="${audit.duration.description}" /></td>
						</tr>
						<c:if test="${audit.completed}">
							<tr>
								<th><fmt:message key="completedBy" />:</th>
								<td><c:out value="${audit.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${audit.completionTime}" pattern="dd-MMM-yyyy" /></td>
							</tr>
							<tr>
								<th><fmt:message key="completionComment" />:</th>
								<td><scannell:text value="${audit.completionComment}" /></td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<div class="header">
		<h3>
			<fmt:message key="notes" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<th><fmt:message key="title" /></th>
							<th><fmt:message key="text" /></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${audit.notes}" var="note" varStatus="s">
							<c:choose>
								<c:when test="${s.index mod 2 == 0}">
									<c:set var="style" value="even" />
								</c:when>
								<c:otherwise>
									<c:set var="style" value="odd" />
								</c:otherwise>
							</c:choose>
							<tr class="<c:out value="${style}" />">
								<td><c:out value="${note.name}" /></td>
								<td><scannell:text value="${note.text}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="header">
		<h2>
			<c:choose>
				<c:when test="${group ne null}">
					<c:out value="${group.name}" />
				</c:when>
				<c:otherwise>
					<fmt:message key="questions.title" />
				</c:otherwise>
			</c:choose>
		</h2>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">

					<c:forEach items="${groups}" var="groupQuestionEntry">
						<c:set var="group" value="${groupQuestionEntry.key}" />
						<c:set var="questions" value="${groupQuestionEntry.value}" />


						<tbody>
							<c:forEach items="${questions}" var="question" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td style="border-top: thin black solid;">
									<div><c:out value="${question.name}" /></div>
									<c:out value="${question.additionalInfo}" />
										<div style="height: 200px; width: 100%; background-color: white;"></div>
										<div style="padding-top: 5px; padding-bottom: 20px;">
											<c:if test="${audit.template.scorable}">
												<fmt:message key="score" />:
													<c:forEach var="score" items="${question.scoreConfig.permittedScores}">
														&nbsp;&nbsp;&nbsp;&nbsp;${score}
													</c:forEach>
											</c:if>
										</div></td>
								</tr>
							</c:forEach>
						</tbody>

					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
