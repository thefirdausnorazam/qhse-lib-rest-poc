<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:set var="found" value="${false}" />

<c:if test="${!(empty riskAssessments)}">
<c:set var="found" value="${true}" />
	<!-- Assessments Awaiting Approval -->
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="assessment" /></th>
	</tr>
	<c:forEach items="${riskAssessments}" var="assessment" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_RISK_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>"><c:out value="${assessment.displayId}" /></a>
			<scannell:text value="${assessment.name}" />
		</td>
		<td class="status" style="color: #cc3333;">Awaiting Approval</td>
		<td class="date"><fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty riskManagementProgrammes)}">
	<c:set var="found" value="${true}" />
	<!-- Overdue Management Programme -->
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="managementProgramme" /></th>
	</tr>
	<c:forEach items="${riskManagementProgrammes}" var="programme" varStatus="s">
	<tr>
	<%-- 	<td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_RISK_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/risk/managementProgrammeView.htm"><c:param name="id" value="${programme.id}"/></c:url>"><c:out value="${programme.displayId}" /></a>
			<scannell:text value="${programme.name}" />
		</td>
		<td class="status" style="color: #cc3333;">Overdue</td>
		<td class="date"><fmt:formatDate value="${programme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty riskTasks)}">
	<c:set var="found" value="${true}" />
	<!-- Overdue Tasks -->
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="task" /></th>
	</tr>
	<c:forEach items="${riskTasks}" var="task" varStatus="s">
	<tr>
	<%-- 	<td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_RISK_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>"><c:out value="${task.displayId}" /></a>
			<scannell:text value="${task.name}" />
		</td>
		<td class="status" style="color: #cc3333;">Overdue</td>
		<td class="date"><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(found)}">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_RISK_Icon.gif" />" width="16" height="17"></td> --%>
		<td colspan="2" style="text-align: center"><span class="txt">You have no new messages!</span></td>
		<td></td>
	<tr>
</c:if>

