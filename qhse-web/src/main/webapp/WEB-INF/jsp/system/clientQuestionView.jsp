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
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<div class="header">
<h2><fmt:message key="questionView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>

	<tbody>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="id" />:</td>
			<td><c:out value="${question.id}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="codeName" />:</td>
			<td><c:out value="${question.codeName}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="name" />:</td>
			<td><c:out value="${question.name}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="clientQuestionMandatory" />:</td>
			<td><fmt:message key="${question.required}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="active" />:</td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="questionAnswerType" />:</td>
			<td><fmt:message key="${question.answerType}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="dependsOnQuestions" />:</td>
			<td><c:out value="${question.dependsOnQuestion.name}" /></td>
		</tr>
<%-- 		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="parentTable" />:</td>
			<td><c:out value="${question.parent.name}" /></td>
		</tr> --%>
		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="modules" />:</td>
			<td>
				<c:forEach items="${question.modules}" var="module">
			 		<fmt:message key="${module.name}" />&nbsp;
			 	</c:forEach>
			</td>
		</tr>
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
			<td colspan="2">
				<scannell:url urls="${urls}" />
			</td>
		</tr>
	</tfoot>
</table>
</div>
</div>
</div>
<c:if test="${optionsAllowed}">
	<div class="header">
	<h2><fmt:message key="options" /></h2>
	</div>
	<div class="content">
	<div class="table-responsive">
	<div class="panel">
	<table class='table table-responsive table-bordered dataTable'>
		<thead>		
			<tr>
				<th><fmt:message key="id" /></th>
				<th><fmt:message key="name" /></th>
				<th><fmt:message key="active" /></th>
				<th><fmt:message key="InActiveInSite" /></th>
				<c:if test="${question.dependsOnQuestion != null && question.dependsOnQuestion.answerType != 'QuestionAnswerType[checkbox]'}">
					<th><fmt:message key="dependsOnOptions" /></th>
				</c:if>
			</tr>
		</thead>
		<tbody>
	  <c:set var="options" value="${question.options}" />
	
		<c:forEach items="${options}" var="option" varStatus="s">
			<c:choose>
				<c:when test="${s.index mod 2 == 0}">
					<c:set var="style" value="even" />
				</c:when>
				<c:otherwise>
					<c:set var="style" value="odd" />
				</c:otherwise>
			</c:choose>
			<tr class="<c:out value="${style}" />">
				<td><c:out value="${option.id}" /></td>
				<td><a href="<c:url value="clientQuestionOptionView.htm"><c:param name="id" value="${option.id}" />
										</c:url>"><c:out value="${option.name}" /></a></td>
				<td><fmt:message key="${option.activeIgnoreSite}" /></td>
				<td>
					<c:forEach items="${option.inactiveInSites}" var="site" varStatus="s">
						<c:out value="${site}" /><c:if test="${!s.last}"><br/></c:if>
					</c:forEach>
				</td>
				<c:if test="${question.dependsOnQuestion != null && question.dependsOnQuestion.answerType != 'QuestionAnswerType[checkbox]'}">
					<td>
							<c:forEach items="${option.dependsOnOptions}" var="dependsOnOption" varStatus="s">
								<c:out value="${dependsOnOption.dependsOnOption.name}" />
								<c:if test="${!s.last}"><br/></c:if>
							</c:forEach>
					</td>
				</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	</div>
</c:if>
</body>
</html>
