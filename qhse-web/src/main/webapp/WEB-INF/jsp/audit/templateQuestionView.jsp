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
<h2><fmt:message key="templateQuestionView" /></h2>
</div>
<div class="content">
<div class="header nowrap">
<h3><fmt:message key="templateQuestion.title" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">


<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="template" />:</td>
		<td><c:out value="${templateQuestion.template.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${templateQuestion.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="question" />:</td>
		<td><c:out value="${templateQuestion.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${templateQuestion.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="group" />:</td>
		<td><c:out value="${templateQuestion.group.name}" /></td>
	</tr>
	<c:if test="${templateQuestion.template.scorable}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="scoreMin" />:</td>
		<td><c:out value="${templateQuestion.scoreConfig.scoreMin}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="scoreMax" />:</td>
		<td><c:out value="${templateQuestion.scoreConfig.scoreMax}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="scoreIncrement" />:</td>
		<td><c:out value="${templateQuestion.scoreConfig.scoreIncrement}" /></td>
	</tr>
	</c:if>
	
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
		<td><fmt:message key="${templateQuestion.active}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${templateQuestion.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${templateQuestion.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${templateQuestion.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td>
			<c:out value="${templateQuestion.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${templateQuestion.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
		</td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="templateQuestion.title" /> <fmt:message key="notActiveSiteMsg" >
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
</div>
</body>
</html>
