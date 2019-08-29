<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="changeTemplateView" /></h2>
</div>
<div class="content">
<div class="header nowrap">
<h3><fmt:message key="changeTemplateTitle" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${template.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><c:out value="${template.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${template.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
		<td><fmt:message key="${template.activeTemplate}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${template.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${template.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${template.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="template.title" /> <fmt:message key="notActiveSiteMsg" >
									<fmt:param value="${currentSite.name}" />
								 </fmt:message>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>

<div class="header">
<h3><fmt:message key="changeTemplateStep1" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>	
	<tr>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>
<tbody>

<c:forEach items="${detailsGroup}" var="groupQuestionEntry">
	<c:set var="group" value="${groupQuestionEntry}" />
	<c:set var="questions" value="${groupQuestionEntry.questions}" />
	
	<tr>
		<td colspan="3" class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;">
			<c:if test="${group eq null}"><fmt:message key="auditTemplate.nullGroup" /></c:if><c:out value="${group.name}" />
		</td>
	</tr>
	
	<c:forEach items="${questions}" var="question" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${question.displayName}" /></td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
	</c:forEach>
</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</div>

<div class="header">
<h3><fmt:message key="changeTemplateStep2" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>	
	<tr>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>
<tbody>

<c:forEach items="${checklistGroup}" var="groupQuestionEntry">
	<c:set var="group" value="${groupQuestionEntry}" />
	<c:set var="questions" value="${groupQuestionEntry.questions}" />
	
	<tr>
		<td colspan="3" class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;">
			<c:if test="${group eq null}"><fmt:message key="auditTemplate.nullGroup" /></c:if><c:out value="${group.name}" />
		</td>
	</tr>
	
	<c:forEach items="${questions}" var="question" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${question.displayName}" /></td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
	</c:forEach>
</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
