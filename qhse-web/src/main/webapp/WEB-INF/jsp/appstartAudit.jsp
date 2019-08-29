<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="found" value="${false}" />

<c:if test="${!(empty auditProgrammeAlerts)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="programmes" /></th>
	</tr>
	<c:forEach items="${auditProgrammeAlerts}" var="programme" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/audit/programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>">
			<c:out value="${programme.plan.displayName} - ${programme.type.name}" /></a></td>
		<td class="status" style="color: #cc3333;"	/>Overdue</td>
		<td class="date"><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty auditAlerts)}">
<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="audits" /></th>
	</tr>
	<c:forEach items="${auditAlerts}" var="audit" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/audit/auditView.htm"><c:param name="id" value="${audit.id}"/></c:url>">
			<c:out value="${audit.name}" /></a></td>
		<td class="status" style="color: #cc3333;">Due / Overdue</td>
		<td class="date"><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(found)}">
	<tr>
	<%-- 	<td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td colspan="2"><span class="txt">You have no new messages!</span></td>
		 <td></td>
	</tr>
</c:if>
