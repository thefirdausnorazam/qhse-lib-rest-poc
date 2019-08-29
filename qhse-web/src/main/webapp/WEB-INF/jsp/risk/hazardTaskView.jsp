<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title>
 		
  </title>
</head>
<body>
<div class="header">
<h2><fmt:message key="taskView.title" /></h2>
</div>
<div class="content"> 
<a name="task"></a>
<div class="header">
<h3><fmt:message key="task" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <col  />
 
  <tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td><c:out value="${task.displayId}" /></td>

    <td ><fmt:message key="task.status" />:</td>
    <td><fmt:message key="task.${task.status}" /></td>
  </tr>
  <c:if test="${showLegacyId}">
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="legacyId" />:</td>
	    <td colspan="3"><scannell:text value="${task.legacyId}" /></td>
	  </tr>
  </c:if>
  <tr>
    <td><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
	 	<ul>
      		<c:forEach var="ba" items="${task.businessAreas}">
        		<li><c:out value="${ba.name}" /></li>
      		</c:forEach>
	    </ul>
	</td>
  </tr>
  <tr>
    <td ><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <c:if test="${task.priority != null}">      
  <tr>
    <td ><fmt:message key="priority" /></td>
    <td colspan="3"><fmt:message key="${task.priority}" /></td>
  </tr>  
  </c:if>

  <tr>
    <td ><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td ><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="task.responsibleDepartment" />:</td>
    <td colspan="3"><c:out value="${task.responsibleDepartment.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="task.managementProgramme" />:</td>
    <td colspan="3">
    <c:choose>
    <c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.HazardSubTask'}">
      <c:set var="managementProgramme" value="${task.parentTask.managementProgramme}" />
    </c:when>
    <c:otherwise>
      <c:set var="managementProgramme" value="${task.managementProgramme}" />
    </c:otherwise>
    </c:choose>
    <c:if test="${managementProgramme != null}">
      <c:url var="url" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}" /></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${managementProgramme.displayId}" /></a> -
      <c:out value="${managementProgramme.name}" />
    </c:if>
    </td>
  </tr>
   <tr>
   	<td ><fmt:message key="task.scoringQuestion" />:</td>
    <td colspan="3"><c:out value="${task.targetScore.question.name}" /></td>
  </tr>
  <tr>
   	<td ><fmt:message key="task.targetScore" />:</td>
    <td colspan="3"><c:out value="${task.targetScore}" /></td>
  </tr>
	  <c:if test="${task.completed}">
	   	<tr>
	    	<td ><fmt:message key="task.actualScore" />:</td>
	    	<td colspan="3"><c:out value="${task.actualScore}" /></td>
	   	</tr>
	  </c:if>
  <c:if test="${task.completed}">
  <tr>
    <td ><fmt:message key="task.achieved" />:</td>
    <td colspan="3"><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="task.completedBy" />:</td>
    <td colspan="3"><c:out value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3"><jsp:include page="../doclink/showLinkedDocs.jsp" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${task.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="task" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${task.site.name}" />
							 </fmt:message>
				</c:otherwise>
			</c:choose>
      </td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
<a name="assessments"></a>
<div class="header">
<h3><fmt:message key="task.associatedAssessment" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
 
  <tbody>
  <tr>
    <td ><fmt:message key="task.assessment" />:</td>
    <td ><fmt:message key="task.currentScore" />:</td>
    <td ><fmt:message key="score.justification" />:</td>
  </tr>
  <c:forEach var="hazard" items="${task.hazards}" varStatus="s">
	 	  <c:choose>
	      <c:when test="${s.index mod 2 == 0}">
	        <c:set var="style" value="even" />
	      </c:when>
	      <c:otherwise>
	        <c:set var="style" value="odd" />
	      </c:otherwise>
	   	  </c:choose>
		  <c:url var="url" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${hazard.job.assessment.id}"/></c:url>
		  <tr class="<c:out value="${style}" />">
		    <td>
			    <a href="<c:out value="${url}" />"><c:out value="${hazard.job.assessment.displayId}" /></a> -
			    <c:if test="${hazard.job.assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
		  		<c:if test="${hazard.job.assessment.sensitiveDataViewable}"><scannell:text value="${hazard.job.assessment.name}" /></c:if>
		    </td>
		    <td><c:out value="${task.originalScore}" /></td>
		     <c:if test="${hazard.answers[0].question.id eq 300293}">
		     <td><c:out value="${hazard.answers[0].value}" /></td> 
		     </c:if>
		  </tr>
  </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
