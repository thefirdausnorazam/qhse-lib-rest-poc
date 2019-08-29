<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script>
	<script type="text/javascript">
	<!--
	function init() {
	}

	function request()
	{
		document.forms[0].Review.value = "true";
	}
	function onAuditeeTypeChange() {
		if ($F('auditeeType') == 'u') {
			showBlock('userAuditeeForm');
			hideBlock("t_auditees");
		} else {
			hideBlock('userAuditeeForm');
			showBlock("t_auditees");
		}
		setNewAuditeeVisibility();
	}

	function setNewAuditeeVisibility() {
		if ($F('auditeeType') == 't' && $F('t_auditees') == '0') {
			Effect.Appear('newAuditeeForm');
		} else {
			Effect.Fade('newAuditeeForm');
		}
	}

	Event.observe(window, 'load', init, false);
	// -->
	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
		@import "<c:url value='/css/risk.css'/>";
		@import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
	</style>
</head>
<body>

<c:set var="audit" value="${command.exam.audit}" />


<scannell:form id="theForm">
<scannell:hidden path="exam.id" />
<scannell:hidden path="exam.version" />
<table class="viewForm" style="margin-top:0px;">
<thead>
	<tr>
		<td colspan="4"><fmt:message key="auditExpress.title" /></td>
	</tr>
</thead>

<tbody>
	<c:if test="${audit.id != null}">
	<tr>
		<td><fmt:message key="id" />:</td>
		<td id="auditId">
			<c:out value="${audit.id}"/>
		</td>

	</tr>
	</c:if>

	<tr>
		<td><fmt:message key="auditProgramme" />:</td>
		<td><c:out value="${command.exam.programme.description}" /></td>
	</tr>

	<tr>
		<th><fmt:message key="audit" /> <fmt:message key="name" />:</th>
		<td colspan="3" id="auditName"><scannell:textarea path="exam.name" cols="75" rows="3" /></td>
	</tr>

	<tr>
		<th><fmt:message key="leadAuditor" />:</th>
		<td colspan="3" id="leadAuditor"><select name="exam.leadAuditor" items="${auditors}" itemLabel="sortableName" itemValue="id" class="wide" /></td>
	</tr>

	<c:if test="${command.exam.programme.type.saveAndReview}">
	<tr>
		<th><fmt:message key="auditee" />:</th>
		<td>
			<table id="userAuditeeForm" <c:if test="${command.auditeeType != 'u'}"> style="display: none;"</c:if> >
			<tbody>
				<tr>
					<th><fmt:message key="employee" />:</th>
					<td><scannell:select id="u_auditees" path="auditeeUser" items="${userAuditees}" itemValue="id" itemLabel="sortableName" class="wide" /><scannell:errors path="userAuditee.user"/></td>
				</tr>
				<tr>
					<th><fmt:message key="department" />:</th>
					<td><select name="auditeeDepartment" items="${departments}" itemValue="id" itemLabel="name" class="wide" /><scannell:errors path="userAuditee.department" /></td>
				</tr>
			</tbody>
			</table>

			<c:if test="${command.canCreateThirdParty}">
				<c:set var="emptyOptionLabel" value="thirdPartyCreate" />
				<c:set var="onChangeAction" value="setNewAuditeeVisibility()" />
			</c:if>
			<scannell:select id="t_auditees" path="thirdPartyAuditee.id" items="${thirdPartyAuditees}" itemValue="id" itemLabel="description" visible="${command.auditeeType == 't'}" onchange="${onChangeAction}" emptyOptionValue="0" emptyOptionLabel="${emptyOptionLabel}" class="wide" />
			<scannell:errors path="thirdPartyAuditee" class="errorMessage" />
			<scannell:errors path="exam.auditee" class="errorMessage" writeRequiredHint="false" />
			<scannell:errors path="userAuditee" class="errorMessage" />

			<table id="newAuditeeForm" style="display: none;">
			<c:if test="${command.canCreateThirdParty}">
			<tbody>
				<tr>
					<th><fmt:message key="name" />:</th>
					<td><input name="thirdPartyAuditee.name" class="wide" /></td>
				</tr>
				<tr>
					<th><fmt:message key="company" />:</th>
					<td><input name="thirdPartyAuditee.company" class="wide" /></td>
				</tr>
				<tr>
					<th><fmt:message key="address" />:</th>
					<td><input name="thirdPartyAuditee.address" class="wide" /></td>
				</tr>
				<tr>
					<th><fmt:message key="phoneNumber" />:</th>
					<td><input name="thirdPartyAuditee.phoneNumber" /></td>
				</tr>
				<tr>
					<th><fmt:message key="emailAddress" />:</th>
					<td><input name="thirdPartyAuditee.emailAddress" /></td>
				</tr>
			</tbody>
			</c:if>
			</table>
		</td>
	</tr>
	</c:if>
	<fmt:message key="incident.enableAdditionalFields" var="enable" />
	<c:if test="${!enable}">
	<tr>
		<th><fmt:message key="department" />:</th>
		<td colspan="3"><select name="exam.department" items="${departments}" itemValue="id" itemLabel="name" class="wide" /></td>
	</tr>
	</c:if>
	
	<c:if test="${enable}">
	<tr>
		<th><fmt:message key="location" />:</th>
		<td colspan="3"><select name="exam.location" items="${locations}" itemValue="id" itemLabel="name" class="wide" /></td>
	</tr>
	</c:if>						
	
	<tr>
		<th><fmt:message key="otherParticipants" />:</th>
		<td colspan="3" id="otherParticipants"><input name="exam.otherParticipants" class="wide" /></td>
	</tr>

	<tr>
		<th><fmt:message key="startTime" />:</th>
		<td colspan="3">
			<scannell:input id="startDate" path="startDateTime.date" readonly="${true}" />
			<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'startDate', true);">
			<select name="startDateTime.hour" items="${hours}" class="narrow" numberFormat="00" />
			<select name="startDateTime.minute" items="${minutes}" class="narrow" numberFormat="00" />
			<scannell:errors path="exam.startTime" class="errorMessage" />
		</td>
	</tr>

	<tr>
		<th><fmt:message key="additionalInfo" />:</th>
		<td colspan="3" id="additionalInfo"><scannell:textarea path="exam.additionalInfo" cols="75" rows="3" /></td>
	</tr>

	<tr>
	<c:choose>
	<c:when test="${audit.createdByUser != null}">
		<th><fmt:message key="createdBy" />:</th>
		<td id="auditCreatedBy"><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</c:when>
	<c:otherwise>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</c:otherwise>
	</c:choose>

	<c:choose>
	<c:when test="${audit.lastUpdatedByUser != null}">
		<th><fmt:message key="lastUpdatedBy" />:</th>
		<td id="auditLastUpdatedBy"><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</c:when>
	<c:otherwise>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</c:otherwise>
	</c:choose>
	</tr>
</tbody>
</table>


<table class="viewForm">
<col class="label" />
<thead>
	<tr>
		<td colspan="4"><fmt:message key="questions.title" /></td>
	</tr>
</thead>

<tbody>
	<c:set var="group" value="${command.exam.programme.type.expressQuestionGroup}" />
	<c:if test="${group.active}">
		<c:if test="${group.name != null && group.name!= ''}">
		<tr><td colspan="2" class="scoringCategoryTitle"><c:out value="${group.name}"/></td></tr>
		</c:if>
		<c:forEach items="${group.questions}" var="q" varStatus="s">
			<c:if test="${s.first || (s.index mod 2 == 0)}"><tr></c:if>
			<c:if test="${q.active and q.visible}">
				<td style="vertical-align: top;">
					<div class="label"><b><c:out value="${q.name}" />:</b></div>
					<enviromanager:question path="exam.answers" question="${q}" emptyOptionLabel="Choose"/>
				</td>
			</c:if>
			<c:if test="${s.last || (s.index mod 2 == 1)}"></tr></c:if>
		</c:forEach>
	</c:if>
</tbody>

<tbody>
	<c:if test="${command.exam.programme.type.saveAndReview}">
		<tr>
		<tr>
			<td colspan="2" align="center" class="longLabel"><fmt:message key="reviewMessage" /></td>
		</tr>
		</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<c:choose>
				<c:when test="${managementProgramme.id gt 0}"><c:url var="cancelURL" value="/audit/expressView.htm"><c:param name="id" value="${audit.id}"/></c:url></c:when>
				<c:otherwise><c:url var="cancelURL" value="/audit/programmeView.htm"><c:param name="id" value="${command.exam.programme.id}"/></c:url></c:otherwise>
			</c:choose>
			<input type="submit" value="<fmt:message key="submit" />">
			<input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">

			<INPUT TYPE="HIDDEN" NAME="Review" VALUE="false">

			<c:if test="${command.exam.programme.type.saveAndReview}">
				<input type="submit" onclick="request();" value="<fmt:message key="savereview" />">
			</c:if>
		</td>
	</tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
