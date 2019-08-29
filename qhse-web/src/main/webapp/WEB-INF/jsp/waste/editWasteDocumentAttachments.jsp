<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<script type="text/javascript">
	jQuery(document).ready(function() {	  
		onPageLoad();
		});
	</script>
</head>

<body>
<div class="header">
<h2><fmt:message key="editWasteAttachments" /></h2>
</div>
<scannell:form enctype="multipart/form-data">
<input type="hidden" name="sourcePage" id="sourcePage">
<a name="attachments"></a>
<div class="content">
<div class="header">
<h3><fmt:message key="attachments" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<thead>
	
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="addedBy" /></th>
		<th><fmt:message key="date" /></th>
		<th><fmt:message key="description" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${command.wasteDocument.attachments}" var="item">
	<tr>
		<td><a href="<c:url value="wasteDocumentAttachmentCreate.htm"><c:param name="itemId" value="${item.id}" /><c:param name="showId" value="${command.wasteDocument.id}" /></c:url>"><c:out value="${item.name}" /></a><br /> </td>
		<td><c:out value="${item.createdByUser.displayName}" /><br /> </td>
		<td><fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		<td><scannell:text value="${item.description}" /></td>
		<td><fmt:message key="${item.active}" /></td>
	</tr>
	</c:forEach>
</tbody>

<tfoot>
	<tr>
		<td colspan="5">
			<c:if test="${command.wasteDocument != null}">
			<a href="<c:url value="wasteDocumentAttachmentCreate.htm"><c:param name="showId" value="${command.wasteDocument.id}"/></c:url>"><fmt:message key="addAttachment" /></a>
			</c:if>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
