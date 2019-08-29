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
  <style type="text/css" media="all">    
    @import "<c:url value='/css/risk.css'/>";
  </style>
 <script type="text/javascript">
	 jQuery(document).ready(function(){
		 initSortTables();
	 })
 </script>
</head>
<body>
<div class="header">
<h2>
<c:choose>
      <c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
        <fmt:message key="subTaskView.title" />
      </c:when>
      <c:otherwise><fmt:message key="taskView.title" /></c:otherwise>
    </c:choose>
</h2>
</div>
<a name="task"></a>

<div class="content"> 
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="task" /></h3> --%>
<!-- </div> -->
<div class="content"> 
<div class="table-responsive">
<div class="panel">


<table class="table table-bordered table-responsive">
  <col/>  
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td><c:out value="${task.displayId}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="task.${task.status}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
	 	<ul>
      		<c:forEach var="ba" items="${task.businessAreas}">
        		<li><c:out value="${ba.name}" /></li>
      		</c:forEach>
	    </ul>
	</td>
  </tr>

  <c:if test="${showLegacyId}">
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="legacyId" />:</td>
	    <td colspan="3"><scannell:text value="${task.legacyId}" /></td>
	  </tr>
  </c:if>
  <c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.parentTask" />:</td>
    <td colspan="3">
      <c:if test="${task.parentTask != null}">
        <c:url var="url" value="/risk/taskView.htm"><c:param name="id" value="${task.parentTask.id}" /></c:url>
        <a href="<c:out value="${url}" />"><c:out value="${task.parentTask.displayId}" /></a> -
        <scannell:text value="${task.parentTask.name}" />
      </c:if>
    </td>
  </tr>
  </c:if>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <c:if test="${task.priority != null}">      
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="priority" /></td>
    <td colspan="3"><fmt:message key="${task.priority}" /></td>
  </tr>  
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleDepartment" />:</td>
    <td colspan="3"><c:out value="${task.responsibleDepartment.name}" /></td>
  </tr>

	<c:if test="${task.responsibleWorkArea != null}">
	  <tr>
	    <td class="scannellGeneralLabel nowrap"><fmt:message key="workArea" />:</td>
	    <td colspan="3"><c:out value="${task.responsibleWorkArea.name}" /></td>
	  </tr>
  </c:if>

  <c:if test="${task.responsibleLocation != null}">
	  <tr>
	    <td class="scannellGeneralLabel nowrap"><fmt:message key="deptLocation" />:</td>
	    <td colspan="3"><c:out value="${task.responsibleLocation.name}" /></td>
	  </tr>
  </c:if>
  
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.managementProgramme" />:</td>
    <td colspan="3">
    <c:choose>
    <c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
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

  <c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.RiskAssessmentTask'}">
  	<c:if test="${task.assessments[0].template.scorable}">
  		<tr>
    		<td class="scannellGeneralLabel"><fmt:message key="task.targetScore" />:</td>
    		<td colspan="3"><c:out value="${task.targetScore.score} - ${task.targetScore.name}" /></td>
  		</tr>
	    <c:if test="${task.completed}">
	    	<tr>
	    		<td class="scannellGeneralLabel"><fmt:message key="task.actualScore" />:</td>
	    		<td colspan="3"><c:out value="${task.actualScore.score} - ${task.actualScore.name}" /></td>
	    	</tr>
  		</c:if>
  	</c:if>
  </c:if>

  <c:if test="${task.completed}">
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.achieved" />:</td>
    <td colspan="3"><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.completedBy" />:</td>
    <td colspan="3"><c:out value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3">
		<c:set var="showLatest" value="${task.status.name != 'COMPLETE'}" scope="request"/>
		<jsp:include page="../doclink/showLinkedDocs.jsp" />
	</td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td ${task.lastUpdatedByUser != null ? "":"colspan='3'"}><c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><div id="urlLinks"><scannell:url urls="${urls}" /></div></c:when>
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
<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.RiskAssessmentTask'}">
<a name="assessments"></a>
<div class="header">
<h3><fmt:message key="task.associatedAssessment" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">

<table class="table table-responsive table-bordered">  
  <tbody>
  <tr>
    <td ><fmt:message key="task.assessment" />:</td>
    <td ><fmt:message key="task.currentScore" />:</td>
    <td ><fmt:message key="score.justification" />:</td>
  </tr>

  <c:forEach var="score" items="${task.assessmentScores}" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
  <c:url var="url" value="/risk/assessmentView.htm"><c:param name="id" value="${score.assessment.id}"/></c:url>
  <tr class="<c:out value="${style}" />">
    <td>
      <a href="<c:out value="${url}" />"><c:out value="${score.assessment.displayId}" /></a> -
	  <c:if test="${score.assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  <c:if test="${score.assessment.sensitiveDataViewable}"><scannell:text value="${score.assessment.name}" /></c:if>
    </td>
    <td><c:out value="${score.selectedOption.score} - ${score.selectedOption.name}" /></td>
    <td><scannell:text value="${score.justification}" /></td>
  </tr>
  </c:forEach>

  <c:forEach var="assessment" items="${task.assessments}" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
  <c:url var="url" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
  <tr class="<c:out value="${style}" />">
    <td>
      <a href="<c:out value="${url}" />"><c:out value="${assessment.displayId}" /></a> -
      <c:choose>
        <c:when test="${assessment.confidential}"><fmt:message key="assessment.confidential" /></c:when>
        <c:otherwise><scannell:text value="${assessment.name}" /></c:otherwise>
      </c:choose>
    </td>
    <td></td>
    <td></td>
  </tr>
  </c:forEach>
  </tbody>
</table>
</div>
</div> 
</div>
</c:if>

<c:if test="${not (empty task.subTasks)}">
<a name="subTasks"></a>
<div class="header">
<h3> <fmt:message key="task.subTasks" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">


<table class="table table-bordered table-responsive dataTable">
  <thead>   
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="subTask.name" /></th>
      <th><fmt:message key="subTask.creationDate" /></th>
      <th><fmt:message key="subTask.targetCompletionDate" /></th>
      <th><fmt:message key="subTask.completionDate" /></th>
      <th><fmt:message key="subTask.status" /></th>
      <th><fmt:message key="createdBy" /></th>
      <th><fmt:message key="subTask.responsibleUser" /></th>
      <th><fmt:message key="subTask.completedBy" /></th>
      <th class="datatable-nosort">&nbsp;</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${task.subTasks}" var="subTask" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${subTask.id}" /></c:url>"><c:out value="${subTask.displayId}" /></a></td>
      <td><c:out value="${subTask.name}" /></td>
      <td><fmt:formatDate value="${subTask.creationDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:formatDate value="${subTask.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:formatDate value="${subTask.completionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="task.${subTask.status}" /></td>
      <td><c:out value="${subTask.createdByUser.displayName}" /></td>
      <td><c:out value="${subTask.responsibleUser.displayName}" /></td>
      <td><c:out value="${subTask.completedByUser.displayName}" /></td>
      <td>
      	<c:if test="${editSubTasks}">
	        <c:if test="${subTask.editable}">
	          <a href="<c:url value="/risk/taskEdit.htm"><c:param name="showId" value="${subTask.id}" /></c:url>">Edit</a>
	        </c:if>
	        <c:if test="${subTask.editable and subTask.completable}"> | </c:if>
	        <c:if test="${subTask.completable and subTask.status.name == 'IN_PROGR'}">
	          <a href="<c:url value="/risk/taskComplete.htm"><c:param name="showId" value="${subTask.id}" /></c:url>">Complete</a>
	        </c:if>
        </c:if>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
</c:if>
</div>
<script type="text/javascript">

$( "#urlLinks" ).children().each(function( index ) {
	  if($( this ).text().toLowerCase() == "complete" && ${task.completed}) {
		  $( this ).hide();
	  }
	});
</script>
</body>

</html>
