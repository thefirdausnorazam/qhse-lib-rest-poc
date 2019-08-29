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
<h2><fmt:message key="group.GroupView" /></h2>
</div>
<div class="content">
<div class="header nowrap">
<h3><fmt:message key="group.title" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${group.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><c:out value="${group.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
		<td><fmt:message key="${group.active}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${group.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${group.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${group.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
<h3><fmt:message key="questions.title" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>	
	<tr>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="additionalInfo" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
		<c:forEach items="${questions}" var="question" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><a href="<c:url value="templateQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><c:out value="${question.name}" /></a></td>
			<td><c:out value="${question.additionalInfo}" /></td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
	</c:forEach>
</thead>
<tbody>
</tbody>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
