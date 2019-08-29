<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="found" value="${false}" />

<c:if test="${!(empty surveyAlerts)}">
	<c:set var="found" value="${true}" />
	<!-- myLimitBreaches -->
	<tr>
		<th colspan="3" style="text-align: center"><fmt:message key="limits" /></th>
	</tr>
	<c:forEach items="${surveyAlerts}" var="limitPeriod" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/survey/limitPeriodView.htm"><c:param name="id" value="${limitPeriod.id}"/></c:url>">
		<c:out value="${limitPeriod.description}" /></a></td>
		<c:set var="color" value="orange" />
		<c:if test="${limitPeriod.complianceStatus.name == 'r'}" >
			<c:set var="color" value="#cc3333;" />
		</c:if>
		<td class="status" style="color: <c:out value="${color}" />;"	><fmt:message key="${limitPeriod.complianceStatus}" /></td>
		<c:set var="lpDate" value="${limitPeriod.lastUpdatedTs}" />
		<c:if test="${lpDate == null}" >
			<c:set var="lpDate" value="${limitPeriod.createdTs}" />
		</c:if>
		<td class="date"><fmt:formatDate value="${lpDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty measurementReadingAlerts)}">
	<c:set var="found" value="${true}" />
	<!-- myMeasurements -->
	<tr>
		<th colspan="3" style="text-align: center"><fmt:message key="readings" /></th>
	</tr>
	<c:forEach items="${measurementReadingAlerts}" var="reading" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/survey/readingView.htm"><c:param name="id" value="${reading.id}"/></c:url>">
		<c:out value="${reading.type.quantity.longName}" /></a></td>
		<td class="status">
			<c:if test="${reading.due}"><span style="color: orange"	>Due</span></c:if>
			<c:if test="${reading.overdue}"><span style="color: red" >Overdue</span></c:if>
		</td>
		<td class="date"><fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="dd-MMM-yyyy" /> - <c:out value="${reading.type.frequencyDisplay}" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty trainingRecords)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="3" style="text-align: center"><fmt:message key="trainingQueryForm" /></th>
	</tr>
	<c:forEach items="${trainingRecords}" var="record" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/maintenance/trainingRecordView.htm"><c:param name="id" value="${record.id}"/></c:url>">
		<c:out value="${record.longDescription}" /></a></td>
		<c:set var="color" value="orange" />
		<c:set var="status" value="Due" />
		<c:if test="${record.overdue}" >
			<c:set var="color" value="red" />
			<c:set var="status" value="Overdue" />
		</c:if>
		<td class="status" style="color: <c:out value="${color}" />;"	><c:out value="${status}" /></td>
		<td class="date"><fmt:formatDate value="${record.dueDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty ppeRecords)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="3" style="text-align: center"><fmt:message key="maintenance.ppeServiceAdd.title" /></th>
	</tr>
	<c:forEach items="${ppeRecords}" var="record" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/maintenance/ppeRecordView.htm"><c:param name="id" value="${record.id}"/></c:url>">
		<c:out value="${record.longDescription}" /></a></td>
		<c:set var="color" value="orange" />
		<c:set var="status" value="Due" />
		<c:if test="${record.overdue}" >
			<c:set var="color" value="red" />
			<c:set var="status" value="Overdue" />
		</c:if>
		<td class="status" style="color: <c:out value="${color}" />;"	><c:out value="${status}" /></td>
		<td class="data"><fmt:formatDate value="${record.dueDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>


<c:if test="${!(empty equipmentRecords)}">
	<c:set var="found" value="${true}" />
	<tr>
		<th colspan="3" style="text-align: center"><fmt:message key="equipmentQueryForm" /></th>
	</tr>
	<c:forEach items="${equipmentRecords}" var="record" varStatus="s">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td><a target="_top" href="<c:url value="/maintenance/equipmentRecordView.htm"><c:param name="id" value="${record.id}"/></c:url>"><c:out value="${record.longDescription}" /></a></td>
		<c:set var="color" value="orange" />
		<c:set var="status" value="Due" />
		<c:if test="${record.overdue}" >
			<c:set var="color" value="red" />
			<c:set var="status" value="Overdue" />
		</c:if>
		<td class="status" style="color: <c:out value="${color}" />;"	><c:out value="${status}" /></td>
		<td class="date"><fmt:formatDate value="${record.dueDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	</c:forEach>
</c:if>

<c:if test="${!(found)}">
	<tr>
		<%-- <td class="icon"><img src="<c:url value="/appstart/images/enviroMANAGER_Application_LAW_Icon.gif" />" width="16" height="17"></td> --%>
		<td colspan="2"><span class="txt">You have no new messages!</span></td>
		 <td></td>
	<tr>
</c:if>
