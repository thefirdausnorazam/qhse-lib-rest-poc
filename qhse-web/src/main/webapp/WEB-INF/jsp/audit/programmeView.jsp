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
<h2><span class="nowrap"><fmt:message key="programme.title" /><!--<fmt:message key="programmeView" />--></span></h2>
</div>
<div class="content">
<c:set var="foundRecurringAudits" value="${!empty activeRecurringAudits}" />
<c:set var="foundAuditTrail" value="${!empty insufficientFindings}" />
<c:set var="foundActions" value="${!empty programmeResults}" />
<c:set var="foundNotes" value="${!empty programme.notes}" />

<c:set var="showAuditee" value="${programme.type.auditeeRequired}" />

<a name="programme"></a>
<!-- <div class="header"> -->
<%-- <h3><span class="nowrap"><fmt:message key="programme.title" /></span></h3> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<col class="label" />
<%-- <thead>
	<tr>
		<td colspan="2">
			<div class="navLinks"><a href="#audits">
				<fmt:message key="audits.title" /></a>
				<c:if test="${foundRecurringAudits}">| <a href="#recurringAudits"><fmt:message key="recurringAudits" /></a></c:if>
				<c:if test="${foundAuditTrail}">| <a href="#auditTrail"><fmt:message key="auditTrail" /></a></c:if>
				<c:if test="${foundActions}">| <a href="#actions"><fmt:message key="actions" /></a></c:if>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			
		</td>
	</tr>
</thead> --%>
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${programme.id}" /></td>
	</tr>
   <c:if test="${showLegacyId}">
	<tr>
		<td class="scannellGeneralLabel">Legacy <fmt:message key="id" />:</td>
		<td><c:out value="${programme.legacyId}" /></td>
	</tr>
	</c:if>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
		<td colspan="3">
	      <ul>
		      <c:forEach var="ba" items="${programme.businessAreas}">
		        	<li><c:out value="${ba.name}" /></li>
		      </c:forEach>
	      </ul>
		</td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="auditPlan" />:</td>
		<td><c:out value="${programme.plan.displayName}" /></td>
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
		<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
		<td><c:out value="${programme.percentCompleted}%" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
		<td>
			<fmt:message key="${programme.programmeStatus}" />
		</td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="programme.comment" />:</td>
		<td>
			<c:out value="${programme.comment}" />
		</td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${programme.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="reviewDate" />:</td>
		<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="auditors" />:</td>
		<td><c:forEach items="${auditors}" var="auditor" varStatus="s">
			<c:out value="${auditor.displayName}" /><c:if test="${!s.last}">, </c:if>
		</c:forEach></td>
	</tr>
	<tr>
		    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
		    <td >
		    	<c:set var="showLatest" value="${programme.programmeStatus != 'COMPLETE'}" scope="request"/>
		    	<jsp:include page="../doclink/showLinkedDocs.jsp" />
		    </td>
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
		<td colspan="3">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="programmeView" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${programme.site.name}" />
							 </fmt:message>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>

<div class="header">
<h3><span class="nowrap"><fmt:message key="auditSchedule" /></span></h3>
</div>
<a name="audits"></a>
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<%-- <tr>
		<td colspan="6">
			<div class="navLinks">
				<a href="#programme"><fmt:message key="programme" /></a>
				<c:if test="${foundRecurringAudits}">| <a href="#recurringAudits"><fmt:message key="recurringAudits" /></a></c:if>
				<c:if test="${foundAuditTrail}">| <a href="#auditTrail"><fmt:message key="auditTrail" /></a></c:if>
				<c:if test="${foundActions}">| <a href="#actions"><fmt:message key="actions" /></a></c:if>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			
		</td>
	</tr> --%>
	<tr>
		<th><fmt:message key="startDate" /></th>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="department" /></th>
		<th><fmt:message key="leadAuditor" /></th>
		<c:if test="${showAuditee}"><th><fmt:message key="auditee" /></th></c:if>
		<th><fmt:message key="percentCompleted" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${audits}" var="audit" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
	<c:choose>
		<c:when test="${audit != null && audit.status != 'TRASH'}">
				<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy" /></td>
				<td><a href="<c:url value="auditView.htm"><c:param name="id" value="${audit.id}" /></c:url>"><c:out value="${audit.name}" /></a></td>
				<td><c:out value="${audit.locationOrDepartmentName}" /></td>
				<td><c:out value="${audit.leadAuditor.displayName}" /></td>
				<c:if test="${showAuditee}"><td><c:out value="${audit.auditee.name}" /></td></c:if>
				<td><c:out value="${audit.percentCompleted}%" /></td>
		 </c:when>
	</c:choose>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
<c:if test="${foundRecurringAudits}">

<div class="header">
<h3><span class="nowrap"><fmt:message key="recurringAudits" /></span></h3>
</div>

<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<%-- <tr>
		<td colspan="6">
			<div class="navLinks">
				<a href="#programme"><fmt:message key="programme" /></a>
				| <a href="#audits"><fmt:message key="audits.title" /></a>
				<c:if test="${foundAuditTrail}">| <a href="#auditTrail"><fmt:message key="auditTrail" /></a></c:if>
				<c:if test="${foundActions}">| <a href="#actions"><fmt:message key="actions" /></a></c:if>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			
		</td>
	</tr> --%>
	<tr>
		<th><fmt:message key="startDate" /></th>
		<th><fmt:message key="frequency" /></th>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="department" /></th>
		<th><fmt:message key="leadAuditor" /></th>
		<c:if test="${showAuditee}"><th><fmt:message key="auditee" /></th></c:if>
	</tr>
</thead>
<tbody>
<c:forEach items="${activeRecurringAudits}" var="recurringAudit" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><fmt:formatDate value="${recurringAudit.startTimestamp}" pattern="dd-MMM-yyyy" /></td>
	    <td><fmt:message key="RecurringAuditFrequency.${recurringAudit.frequency}" /></td>
	    <td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${recurringAudit.id}" /></c:url>"><c:out value="${recurringAudit.name}" /></a></td>
		<td><c:out value="${recurringAudit.locationOrDepartmentName}" /></td>
	    <td><c:out value="${recurringAudit.leadAuditor.displayName}" /></td>
		<td><c:if test="${showAuditee}"><c:out value="${recurringAudit.auditee.name}" /></td></c:if>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</c:if>


<c:if test="${foundAuditTrail}">
<div class="header">
<h3><span class="nowrap"><fmt:message key="auditTrail" /></span></h3>
</div>

<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<%-- <tr>
		<td colspan="3">
			<div class="navLinks">
				<a href="#programme"><fmt:message key="programme" /></a>
				| <a href="#audits"><fmt:message key="audits.title" /></a>
				<c:if test="${foundRecurringAudits}">| <a href="#recurringAudits"><fmt:message key="recurringAudits" /></a></c:if>
				<c:if test="${foundActions}">| <a href="#actions"><fmt:message key="actions" /></a></c:if>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			
		</td>
	</tr> --%>
	<tr>
		<th><fmt:message key="audit" /></th>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="findingComment" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${insufficientFindings}" var="question" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="auditView.htm"><c:param name="id" value="${question.audit.id}" /></c:url>"><scannell:text value="${question.audit.name}" maxChars="50" /></a></td>
		<td><a href="<c:url value="auditQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><scannell:text value="${question.name}" maxChars="50" /></a></td>
		<td><scannell:text value="${question.findingComment}" maxChars="100" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>

</c:if>

<c:if test="${foundActions}">
<div class="header">
<h3><span class="nowrap"><fmt:message key="actions" /> / <fmt:message key="incidents" /></span></h3>
</div>

<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<%-- <tr>
		<td colspan="4">
			<div class="navLinks"><a href="#programme">
				<fmt:message key="programme" /></a>
				| <a href="#audits"><fmt:message key="audits.title" /></a>
				<c:if test="${foundRecurringAudits}">| <a href="#recurringAudits"><fmt:message key="recurringAudits" /></a></c:if>
				<c:if test="${foundAuditTrail}">| <a href="#auditTrail"><fmt:message key="auditTrail" /></a></c:if>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			
		</td>
	</tr> --%>
	<tr>
		<th><fmt:message key="audit" /></th>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="result" /></th>
		<th>&nbsp;</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${programmeResults}" var="question" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}">
			<c:set var="style" value="even" />
		</c:when>
		<c:otherwise>
			<c:set var="style" value="odd" />
		</c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="auditView.htm"><c:param name="id" value="${question.audit.id}" /></c:url>"><scannell:text value="${question.audit.name}" maxChars="50" /></a></td>
		<td><a href="<c:url value="auditQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><scannell:text value="${question.name}" maxChars="50" /></a></td>
		<td><scannell:text value="${question.findingComment}" maxChars="100" /></td>
		<td><scannell:entityUrl entity="${question.result}" messageCodePrefix="auditResult." /> <fmt:message key="status" />: <fmt:message key="${question.result.statusCode}" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</c:if>

<c:if test="${foundNotes}">

<div class="header">
<h3><fmt:message key="notes" /></h3>
</div>

<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<%-- <tr>
		<td colspan="3">
			<div class="navLinks">
				<a href="#programme"><fmt:message key="programme" /></a>
				| <a href="#audits"><fmt:message key="audits.title" /></a>
				<c:if test="${foundRecurringAudits}">| <a href="#recurringAudits"><fmt:message key="recurringAudits" /></a></c:if>
				<c:if test="${foundAuditTrail}">| <a href="#auditTrail"><fmt:message key="auditTrail" /></a></c:if>
				<c:if test="${foundActions}">| <a href="#actions"><fmt:message key="actions" /></a></c:if>
			</div>
			
		</td>
	</tr> --%>
	<tr>
		<th><fmt:message key="title" /></th>
		<th><fmt:message key="text" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${programme.notes}" var="note" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><c:out value="${note.name}" /></td>
		<td><scannell:text value="${note.text}" /></td>
		<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</c:if>

</div>
</body>
</html>
