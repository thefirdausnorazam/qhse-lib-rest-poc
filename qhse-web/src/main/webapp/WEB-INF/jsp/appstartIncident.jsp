<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="found" value="${false}" />

<c:if test="${!(empty unassignedIncidents)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="openUnassignedIncidents" /></th>
	</tr>
	<c:forEach items="${unassignedIncidents}" var="incident" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/incident/viewIncident.htm"><c:param name="id" value="${incident.id}"/></c:url>"><c:out value="${incident.id}" /></a>
			<fmt:message key="${incident.type.type.key}" /> : <c:out value="${incident.type.name}" />
		</td>
		<td class="status" style="color: #cc3333;">Unassigned</td>
		<td class="date"><fmt:formatDate value="${incident.occurredTime}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty overdueIncompleteActions)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="overdueIncompleteActionsAssignedToMe" /></th>
	</tr>
	<c:forEach items="${overdueIncompleteActions}" var="action" varStatus="s">
	<tr>
	<%-- 	<td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>"><c:out value="${action.id}" /></a>
			<c:out value="${action.description}" /> (<fmt:message key="${action['class'].name}" />)
		</td>
		<td class="status" style="color: #cc3333;">Overdue</td>
		<td class="date"><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty overdueUnverifiedActions)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="overdueUnverifiedActionsAssignedToMe" /></th>
	</tr>
	<c:forEach items="${overdueUnverifiedActions}" var="action" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>"><c:out value="${action.id}" /></a>
			<c:out value="${action.description}" /> (<fmt:message key="${action['class'].name}" />)
		</td>
		<td class="status" style="color: #cc3333;">Overdue</td>
		<td class="date"><fmt:formatDate value="${action.verificationTargetDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty overdueTasks)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="overdueTasksAssignedToMe" /></th>
	</tr>
	<c:forEach items="${overdueTasks}" var="task" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td>
			<a target="_top" href="<c:url value="/incident/viewTask.htm"><c:param name="id" value="${task.id}"/></c:url>"><c:out value="${task.id}" /></a>
			(<c:out value="${task.description}" />)
		</td>
		<td class="status" style="color: #cc3333;">Overdue</td>
		<td class="date"><fmt:formatDate value="${task.targetDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(found)}">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td colspan="2" style="text-align: center"><span class="txt">You have no new messages!</span></td>
		 <td></td>
	<tr>
</c:if>
