<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <style type="text/css" media="all">   
    @import "<c:url value='/css/risk.css'/>";
  </style>
  <title></title>
  <script type="text/javascript">
    jQuery(document).ready(function() {
    	initSortTables();	
    	jQuery("#taskStatus").select2();
    });
  </script>
</head>
<body>
<div class="header">
<h2>
<fmt:message key="managementProgrammeView.title" />
</h2>
</div>
<div class="content"> 
<a name="managementProgramme"></a>
<!-- <div class="header nowrap"> -->
<!-- <h3> -->
<%--  <fmt:message key="managementProgramme" /> --%>
<!-- </h3> -->
<!-- </div> -->
<div class="content"> 
<div class="table-responsive">
<div class="panel">


<table class="table table-bordered table-responsive">
  <col  />  
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td><c:out value="${managementProgramme.displayId}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.status" />:</td>
    <td><fmt:message key="task.${managementProgramme.status}" /></td>
  </tr>
   <c:if test="${showLegacyId}">
  <tr>
    <td class="scannellGeneralLabel">Legacy Id:</td>
    <td><c:out value="${managementProgramme.legacyId}" /></td>
    <td></td><td></td>
   
  </tr>
   </c:if>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="ba" items="${managementProgramme.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.name" />:</td>
    <td colspan="3"><scannell:text value="${managementProgramme.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
    <td><fmt:formatDate value="${managementProgramme.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${managementProgramme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${managementProgramme.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="managementProgramme.department" />:</td>
    <td colspan="3"><c:out value="${managementProgramme.department.name}" /></td>
  </tr>

  <c:if test="${managementProgramme.workArea != null}">
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="workArea" />:</td>
	    <td colspan="3"><c:out value="${managementProgramme.workArea.name}" /></td>
	  </tr>
  </c:if>

  <c:if test="${managementProgramme.location != null}">
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="deptLocation" />:</td>
	    <td colspan="3"><c:out value="${managementProgramme.location.name}" /></td>
	  </tr>
  </c:if>
  
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.objective" />:</td>
    <td colspan="3">
      <c:if test="${managementProgramme.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${managementProgramme.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${managementProgramme.objective.displayId}" /></a> -
        <c:out value="${managementProgramme.objective.name}" />
      </c:if>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.percentCompleted" />:</td>
    <td colspan="3"><c:out value="${managementProgramme.percentCompleted}" />%</td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.progressComment" />:</td>
    <td colspan="3"><scannell:text value="${managementProgramme.progressComment}" /></td>
  </tr>

  <c:if test="${managementProgramme.completed}" >
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.completedBy" />:</td>
    <td colspan="3"><c:out value="${managementProgramme.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${managementProgramme.completionComment}" /></td>
  </tr>
  </c:if>
	<tr>
    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
    <td colspan="3">
		<c:set var="showLatest" value="${managementProgramme.status.name != 'COMPLETE'}" scope="request"/>
		<jsp:include page="../doclink/showLinkedDocs.jsp" />
	</td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${managementProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${managementProgramme.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${managementProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
    <c:if test="${managementProgramme.lastUpdatedByUser == null}">
     <td></td>
     <td></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="managementProgramme" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${managementProgramme.site.name}" />
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
<c:if test="${not (empty managementProgramme.tasks)  || not (empty managementProgramme.hazardTasks)}">
<a name="managementProgrammeTasks"></a>
<div class="header">
<h3>
 <fmt:message key="managementProgramme.tasks" />
</h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">

<table  class="table table-bordered table-responsive dataTable" >
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="task.name" /></th>
      <th><fmt:message key="task.targetCompletionDate" /></th>
      <th><fmt:message key="task.status" /></th>
      <th><fmt:message key="task.responsibleUser" /></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${managementProgramme.tasksHighestToLowest}" var="task" varStatus="s">  
  <c:if test="${param.showAllTasks || (param.showCompletedTasks && task.completed) || (!param.showCompletedTasks && task.inProgress)}">
    <tr>
      <td><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}" /></c:url>"><c:out value="${task.displayId}" /></a></td>
      <td><c:out value="${task.name}" /></td>
      <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="task.${task.status}" /></td>
      <td><c:out value="${task.responsibleUser.displayName}" /></td>
    </tr>
  </c:if>
  <%--<c:forEach items="${task.subTasks}" var="subTask" varStatus="s">  
  <c:if test="${param.showAllTasks || (param.showCompletedTasks && subTask.completed) || (!param.showCompletedTasks && subTask.inProgress)}">
    <tr>
      <td><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${subTask.id}" /></c:url>"><c:out value="${subTask.displayId}" /></a></td>
      <td><c:out value="${subTask.name}" /></td>
      <td><fmt:formatDate value="${subTask.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="${subTask.status}" /></td>
      <td><c:out value="${subTask.responsibleUser.displayName}" /></td>
    </tr>
  </c:if>
  </c:forEach> --%>
  </c:forEach>
  <c:forEach items="${managementProgramme.hazardTasks}" var="task" varStatus="s">  
  <c:if test="${param.showAllTasks || (param.showCompletedTasks && task.completed) || (!param.showCompletedTasks && task.inProgress)}">
    <tr>
      <td><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}" /></c:url>"><c:out value="${task.displayId}" /></a></td>
      <td><c:out value="${task.name}" /></td>
      <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="task.${task.status}" /></td>
      <td><c:out value="${task.responsibleUser.displayName}" /></td>
    </tr>
  </c:if>
  </c:forEach>
</tbody>
<tfoot>
  <tr>
    <td colspan="5" style="text-align:center;">
        <c:url var="url" value="/risk/managementProgrammeView.htm">
          <c:param name="id" value="${managementProgramme.id}"/>
        </c:url>
        <span>Show: </span>
         <select id="taskStatus" name="targetStatus" onchange="location = '${url}' + '&' + this.options[this.selectedIndex].value + '=true#objectiveTargets';">
        		
                 <option value="inProgressTasks">In Progress</option>
                 <option value="showCompletedTasks" <c:if test="${param.showCompletedTasks}">selected="selected"</c:if>>Complete</option>
                 <option value="showAllTasks" <c:if test="${param.showAllTasks}">selected="selected"</c:if>>All</option>
        </select>
    </td>
  </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</c:if>
</div>
</body>
</html>
