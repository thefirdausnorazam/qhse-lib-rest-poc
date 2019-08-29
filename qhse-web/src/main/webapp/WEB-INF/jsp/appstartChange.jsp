<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="found" value="${false}" />

<c:if test="${!(empty changeProgrammeAlerts)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="changeProgrammes" /></th>
	</tr>
	<c:forEach items="${changeProgrammeAlerts}" var="programme" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/change/programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>">
			<c:out value="${programme.plan.year} - ${programme.type.name}" /></a></td>
		<td class="status" style="color: #cc3333;"	/>Overdue</td>
		<td class="date"><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty changeAssessmentAlerts)}">
<c:set var="found" value="${true}" />
	<tr>
		<th colspan="4" style="text-align: center"><fmt:message key="changeAssessments" /></th>
	</tr>
	<c:forEach items="${changeAssessmentAlerts}" var="change" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/change/changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url>">
			<c:out value="${change.name}" /></a></td>
		<td class="status" style="color: #cc3333;">Due / Overdue</td>
		<td class="date"><fmt:formatDate value="${change.targetTechnicalCloseoutDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(found)}">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td colspan="2"><span class="txt">You have no new messages!</span></td>
		 <td></td>
	</tr>
</c:if>
