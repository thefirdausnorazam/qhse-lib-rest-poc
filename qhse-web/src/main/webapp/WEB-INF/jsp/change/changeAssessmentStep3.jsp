<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

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
	<li class="selected">Approval</li>    

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
    	<tr>
			<td><fmt:message key="changeAssessment.type" />:</td>			
			<td><select id="change.type" name="change.type" >
			<option value=""><fmt:message key="blankOption" /></option>		
				<c:forEach items="${types}" var="item">
					<option value="${item.name}">
						<c:if test="${item.name == status.value}">selected="selected"</c:if>
						<fmt:message key="changeAssessment${item}" />
					</option>
				</c:forEach>
			</select><span class="requiredHinted"> *</span>
			</td>			
		</tr>
		
    <tr>
		<td><fmt:message key="changeAssessment.postImplementationReview" /></td>
		<td><scannell:checkbox id="postImplementationReview" path="change.postImplementationReview" /></td>
	</tr>
	<tr>			
		<td><fmt:message key="changeAssessment.returnToOriginalStatus" /></td>
		<td><scannell:checkbox id="returnToOriginalStatus" path="change.returnToOriginalStatus" /></td>			
	</tr>
	<tr>	
		<td><fmt:message key="changeAssessment.approved" /></td>
		<td><scannell:checkbox id="approved" path="change.approved" onchange="onApproveChange(this)"/></td>			    	    	    	
	</tr>	
	
	<tr>
		<td><fmt:message key="changeAssessment.approvalComment" />:</td>
		<td><scannell:textarea path="change.approvalComment" cols="75" rows="3" /></td>
	</tr>
		
</tbody>
<tfoot>
	<tr>
		<td colspan="4" align="center">
			<c:choose>
				<c:when test="${managementProgramme.id gt 0}"><c:url var="cancelURL" value="/change/changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url></c:when>
				<c:otherwise><c:url var="cancelURL" value="/change/programmeView.htm"><c:param name="id" value="${command.change.programme.id}"/></c:url></c:otherwise>
			</c:choose>
				<input id="submitButton" type="submit" value="<fmt:message key="submit" />">			
				<input id="nextButton" style="display: none" type="submit" value="<fmt:message key="next" />">
			<input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">
		</td>
	</tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
