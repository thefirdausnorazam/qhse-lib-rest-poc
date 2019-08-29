<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
</head>
<body>
<div class="header">
<h2><fmt:message key="maintenance.trainingView.title" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />
<thead>
	<tr>
		<td colspan="4"></td>
	</tr>
</thead>
<tbody>
	<tr>
		<td ><fmt:message key="id" />:</td>
		<td><c:out value="${subject.id}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.category" />:</td>
		<td><c:out value="${subject.category.name}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.receiver" />:</td>
		<td><c:out value="${subject.trainee.description}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="description" />:</td>
		<td><scannell:text value="${subject.description}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.responsible" />:</td>
		<td><c:out value="${subject.responsible.displayName}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.location" />:</td>
		<td><c:out value="${subject.trainee.location}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.replacementFrequency" />:</td>
		<td><c:out value="${subject.intervalTypeDisplay}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="maintenance.trainingView.initialMaintenanceDate" />:</td>
		<td><fmt:formatDate value="${subject.initialMaintenanceDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="maintenance.trainingView.dueDate" />:</td>
		<td><fmt:formatDate value="${subject.dueDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="training.lastDate" />:</td>
		<td><fmt:formatDate value="${subject.lastDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="maintenance.trainingView.notificationRequested" />:</td>
		<td><fmt:message key="${subject.notificationRequested}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="equipment.alertLeadDays" />:</td>
		<td><c:out value="${subject.alertLeadDays}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="active" />:</td>
		<td><fmt:message key="${subject.active}" /></td>
	</tr>

	<tr>
		<td ><fmt:message key="maintenance.trainingView.documents" />:</td>
		<td colspan="3"><jsp:include page="../doclink/showLinkedDocs.jsp" /></td>
	</tr>
	<tr>
		    <td ><fmt:message key="uploadedDocuments" />:</td>
		    <td colspan="3">
		     <ul>
		      <c:forEach items="${subject.attachments}" var="item">
			  <c:if test="${item.active}">
			  <c:choose>
				<c:when test="${item.type.name == 'attach'}">
				  <li><a target="attachment" href="<c:url value="viewTrainingAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
					<c:out value="${item.name}" /></a><c:if test="${not empty item.description}"> - </c:if><c:out value="${item.description}" /> (<c:out value="${item.createdByUser.sortableName}" />) </li>
			    </c:when>
				<c:otherwise>
					<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
						<c:out value="${item.name}" /></a><c:if test="${not empty item.description}"> - </c:if><c:out value="${item.description}" /></li>
				</c:otherwise>
			  </c:choose> 
			  </c:if>
			  </c:forEach>
			  </ul>
		    </td>
		  </tr>

	<tr>
		<td ><fmt:message key="createdBy" />:</td>
		<td><c:out value="${subject.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${subject.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>

	<c:if test="${subject.lastUpdatedByUser != null}">
	<tr>
		<td ><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${subject.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${subject.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<common:bindURL editable="${urls !=  null}" name="maintenance.trainingHistoryAdd.title" site="${subject.site.name}">
				<scannell:url urls="${urls}" />
			</common:bindURL>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>

<div class="header">
<h2><fmt:message key="maintenance.trainingView.history" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<thead>
	
	<tr>
		<th><fmt:message key="training.dueDate" /></th>
		<th><fmt:message key="training.actualDate" /></th>
		<th><fmt:message key="training.carriedOutBy" /></th>
		<th><fmt:message key="comment" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${subject.history}" var="record" varStatus="s">
	<tr>
		<td><fmt:formatDate value="${record.dueDate}" pattern="dd-MMM-yyyy" /></td>
		<td><fmt:formatDate value="${record.actualDate}" pattern="dd-MMM-yyyy" /></td>
		<td><c:out value="${record.carriedOutBy}" /></td>
		<td><scannell:text value="${record.comment}" /></td>
		<td><c:out value="${record.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</body>
</html>
