<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:url var="url" value="/doclink/linkView.htm"><c:param name="name" value="ChangeProgramme[${change.programme.id}]" /></c:url>
<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="changeAssessment.edit" />
	<c:if test="${command.change.change == null}">
		<c:set var="title" value="changeAssessment.create" />
	</c:if>
	<title></title>

	<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script>
	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

	<script type="text/javascript">
	jQuery(document).ready(function() {
		onFormSubmit();
	});
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
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form id="theForm" >
<ul class="caMenu">

  	<li>Change Assessment</li>        
    <li>Checklist</li>
	<li class="selected">Approval</li>    

</ul>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive" style="margin-top:0px;">

<col  />
<tbody>
	<tr class="form-group">
		<td class="searchLabel" ><fmt:message key="changeProgramme" />:</td>
		<td class="search"><c:out value="${command.change.programme.description}" /></td>
		<c:if test="${command.change.change != null}">
    		<td class="searchLabel"><fmt:message key="changeAssessment.status" />:</td>
    		<td class="search" id="changeAssessmentStatus"><fmt:message key="changeAssessment${command.change.status}" /></td>
    	</c:if>
    	<tr class="form-group">
			<td class="searchLabel"><fmt:message key="changeAssessment.type" />:</td>			
			<td class="search"><select id="change.type" name="change.type" >
			<option value=""><fmt:message key="blankOption" /></option>		
				<c:forEach items="${types}" var="item">
					<option value="${item.name}">
						<c:if test="${item.name == status.value}">selected="selected"</c:if>
						<fmt:message key="changeAssessment${item}" />
					</option>
				</c:forEach>
			</select>
			</td>			
		</tr>
		
    <tr class="form-group">
		<td class="searchLabel"><fmt:message key="changeAssessment.postImplementationReview" /></td>
		<td class="search"><scannell:checkbox id="postImplementationReview" path="change.postImplementationReview" /></td>
	</tr>
	<tr class="form-group">			
		<td class="searchLabel"><fmt:message key="changeAssessment.returnToOriginalStatus" /></td>
		<td class="search"><scannell:checkbox id="returnToOriginalStatus" path="change.returnToOriginalStatus" /></td>			
	</tr>
	<tr class="form-group">	
		<td class="searchLabel"><fmt:message key="changeAssessment.approved" /></td>
		<td class="search"><scannell:checkbox id="approved" path="change.approved" onchange="onApproveChange(this)"/></td>			    	    	    	
	</tr>	
	
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="changeAssessment.approvalComment" />:</td>
		<td class="search"><scannell:textarea path="change.approvalComment" cols="75" rows="3" /></td>
	</tr>
		
</tbody>
<tfoot>
	<tr>
		<td colspan="4" align="center">
			<c:choose>
				<c:when test="${managementProgramme.id gt 0}"><c:url var="cancelURL" value="/change/changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url></c:when>
				<c:otherwise><c:url var="cancelURL" value="/change/programmeView.htm"><c:param name="id" value="${command.change.programme.id}"/></c:url></c:otherwise>
			</c:choose>
				<input id="submitButton" class="g-btn g-btn--primary" type="submit" value="<fmt:message key="submit" />">			
				<input id="nextButton" class="g-btn g-btn--primary" style="display: none" type="submit" value="<fmt:message key="next" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
