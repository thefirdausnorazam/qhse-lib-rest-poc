<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:url var="url" value="/doclink/linkView.htm"><c:param name="name" value="ChangeProgramme[${change.programme.id}]" /></c:url>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<c:set var="title" value="changeAssessment.edit" />
	<c:if test="${command.change.change == null}">
		<c:set var="title" value="changeAssessment.create" />
	</c:if>
	<title><fmt:message key="${title}" /></title>

	<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script>
	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

	<script type="text/javascript">
	function onApproveChange() {
		var approvalComment = document.getElementsByName("approvalComment");		
		approvalComment = !$("approved").checked;		
	}
	
	</script>

	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
    	@import "<c:url value='/css/change.css'/>";		
	</style>
</head>
<body>
<scannell:form id="theForm" onsubmit="onFormSubmit()">
<ul class="caMenu">

  	<li>Change Assessment</li>        
	<li>Checklist</li>  
	<li class="selected">Technical Closeout</li>    

</ul>

<table class="viewForm" style="margin-top:0px;">
<col class="label" />
<tbody>
	<tr>
		<td><fmt:message key="changeProgramme" />:</td>
		<td><c:out value="${command.change.programme.description}" /></td>
		<c:if test="${command.change.change != null}">
    		<td><fmt:message key="changeAssessment.status" />:</td>
    		<td id="changeAssessmentStatus"><fmt:message key="changeAssessment${command.change.status}" /></td>
    	</c:if>
    	
    	
		<c:forEach items="${command.change.programme.type.questionGroups}" var="group" varStatus="h">
		<c:if test="${!empty group.questions}">
			<c:if test="${group.codeName == 'change.programeeTypeQuestionGroup.technical' }">
		
			<table class="viewForm">
			<col class="label" />
			<thead>
				<tr>
					<td colspan="4"><c:out value="${group.name}"/></td>
				</tr>
			</thead>
			<tbody>			
			<c:forEach items="${group.questions}" var="q" varStatus="s">		
				<c:if test="${s.first}"><tr></c:if>
				<c:if test="${q.active and q.visible}">
					<c:choose>
						<c:when test="${q.answerType.name == 'label'}">
							<td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
						</c:when>
						<c:otherwise>	
							<td><b><c:out value="${q.name}" />:</td>
							<td> <enviromanager:question path="change.answers" question="${q}" emptyOptionLabel="Choose" /></td>
						</c:otherwise>
					</c:choose>		
				</c:if>
				<tr/>
				<c:if test="${s.last}"></tr></c:if>
			</c:forEach> 
			
			<tr>
				<td><fmt:message key="changeAssessment.technicalCloseoutComment" />:</td>
				<td><scannell:textarea path="change.technicalCloseoutComment" cols="75" rows="3" /></td>
			</tr>   	
				
			</tbody>
			<tfoot>
			<tr>
				<td colspan="4" align="center">
					<c:url var="cancelURL" value="/change/changeAssessmentView.htm"><c:param name="id" value="${command.change.id}"/></c:url>						
					<input id="submitButton" type="submit" value="<fmt:message key="submit" />">			
					<input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">
				</td>
			</tr>
			</tfoot>
		</table>
		</c:if>
	</c:if>
	</c:forEach>
</tr>
</tbody>
</table>
</scannell:form>

</body>
</html>
