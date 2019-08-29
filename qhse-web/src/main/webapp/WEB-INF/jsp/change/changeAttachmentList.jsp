<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="editAttachments" /></title>
</head>
<body>

<scannell:form enctype="multipart/form-data">
<input type="hidden" name="sourcePage" id="sourcePage">
<a name="attachments"></a>
<table class="viewForm bordered">
<thead>
	<tr><td colspan="5"><fmt:message key="attachments" /></td></tr>
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="addedBy" /></th>
		<th><fmt:message key="date" /></th>
		<th><fmt:message key="description" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>

<tbody>
<c:forEach items="${attachmentList}" var="item">
	<tr>
		<td><a href="<c:url value="changeAttachmentEdit.htm"><c:param name="itemId" value="${item.id}" /><c:param name="showId" value="${parentId}" /></c:url>"><c:out value="${item.name}" /></a><br /> </td>
		<td><c:out value="${item.createdByUser.displayName}" /><br /> </td>
		<td><fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" /> </td>
		<td><scannell:text value="${item.description}" /></td>
		<td><fmt:message key="${item.active}" /></td>
	</tr>
</c:forEach>
</tbody>

<tfoot>
	<tr>
		<td colspan="5">
			<c:if test="${isAttachmentAddable}">
			<a href="<c:url value="changeAttachmentEdit.htm"><c:param name="showId" value="${parentId}"/></c:url>"><fmt:message key="addAttachment" /></a>
			</c:if>
		</td>
	</tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
