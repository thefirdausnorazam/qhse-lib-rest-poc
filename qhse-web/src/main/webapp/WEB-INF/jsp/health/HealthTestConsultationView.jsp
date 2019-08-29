<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title><fmt:message key="healthTestConsultationView.title" /></title>
</head>
<body>

<a name="record"></a>
<table class="viewForm">
<tbody>
	<tr>
		<td class="label"><fmt:message key="id" />:</td>
		<td><c:out value="${test.id}" /></td>
	</tr>

	<c:url var="recordViewURL" value="/health/recordView.htm">
		<c:param name="id" value="${test.record.id}" />
	</c:url>
	<tr>
		<td class="label"><fmt:message key="healthRecord.person" />:</td>
		<td><a href="<c:out value="${recordViewURL}"/>"><c:out value="${test.record.person.displayName}" /></a></td>

		<td class="label"><fmt:message key="healthRecord.department" />:</td>
		<td><c:out value="${test.record.department.name}" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.testDate" />:</td>
		<td colspan="3"><fmt:formatDate value="${test.testDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.testReason" />:</td>
		<td colspan="3"><scannell:text value="${test.testReason}" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.notes" />:</td>
		<td colspan="3"><scannell:text value="${test.notes}" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.retestDate" />:</td>
		<td colspan="3"> <fmt:formatDate value="${test.retestDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${test.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${test.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

		<c:if test="${test.lastUpdatedByUser != null}">
		<td class="label"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${test.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${test.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</c:if>
	</tr>
</tbody>

<tfoot>
	<tr><td colspan="4"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>

<%@include file="testAttachmentList.jsp" %>

</body>
</html>
