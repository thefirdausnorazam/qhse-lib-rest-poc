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

	<div class="header ">
<h2><fmt:message key="changeProgramme.complete" /></h2>
</div>
<scannell:form>
<scannell:hidden path="id" />
<scannell:hidden path="version" />
<c:set var="programme" value="${command.programme}" />
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${programme.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="auditPlan" />:</td>
		<td><c:out value="${programme.plan.year}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="type" />:</td>
		<td><c:out value="${programme.type.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="owner" />:</td>
		<td><c:out value="${programme.owner.displayName}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="percentCompleted" />:</td>
		<td><c:out value="${programme.percentCompleted}%" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="changeAssessment.initiator" />:</td>
		<td><c:forEach items="${initiators}" var="initiator" varStatus="s">
			<c:out value="${initiator.displayName}" /><c:if test="${!s.last}">, </c:if>
		</c:forEach></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${programme.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="reviewDate" />:</td>
		<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${programme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${programme.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${programme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/change/programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>'">
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
