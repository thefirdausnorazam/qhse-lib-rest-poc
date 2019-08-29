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
<h2><fmt:message key="programme.title" /></h2>
</div>
<scannell:form>
<scannell:hidden path="id" />
<scannell:hidden path="version" />
<c:set var="programme" value="${command.programme}" />
<c:set var="auditors" value="${command.auditors}" />
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="id" />:</td>
		<td class="search"><c:out value="${programme.id}" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="auditPlan" />:</td>
		<td class="search"><c:out value="${programme.plan.displayName}" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="type" />:</td>
		<td class="search"><c:out value="${programme.type.name}" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="owner" />:</td>
		<td class="search"><c:out value="${programme.owner.displayName}" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="percentCompleted" />:</td>
		<td class="search"><c:out value="${programme.percentCompleted}%" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel "><fmt:message key="status" />:</td>
		<td class="search">
		<c:if test="${programme.completed}">
			<fmt:message key="audit.status.completed" />
		</c:if>
		<c:if test="${!programme.completed}">
			<fmt:message key="audit.status.inProgress" />
		</c:if>
		</td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:text value="${programme.additionalInfo}" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="reviewDate" />:</td>
		<td class="search"><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="auditors" />:</td>
		<td class="search">
		<c:forEach items="${auditors}" var="auditor" varStatus="s">
			<c:out value="${auditor.displayName}" /><c:if test="${!s.last}">, </c:if>
		</c:forEach>
		</td>
	</tr>
	  <tr class="form-group">
	    <td class="searchLabel"><fmt:message key="programme.comment" />:</td>
	    <td class="search" colspan="3" id="assessmentApprovalComment"><scannell:textarea path="comment" cols="75" rows="3" /></td>
	  </tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="createdBy" />:</td>
		<td class="search"><c:out value="${programme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${programme.lastUpdatedByUser != null}">
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td class="search"><c:out value="${programme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>'">
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
