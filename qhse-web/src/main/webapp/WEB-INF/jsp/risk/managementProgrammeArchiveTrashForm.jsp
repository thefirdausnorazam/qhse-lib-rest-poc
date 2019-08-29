<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <style type="text/css">
  td.search {
padding-left: 5%!important;
}
  </style>
  <title>
  	
  </title>
  <script type="text/javascript">
jQuery(document).ready(function() {
	var objs = jQuery(".showSubTask");
	if(objs.length < 1) {
		jQuery("#showSubTask").hide();
	}
});
</script>
</head>
<body>
<div class="header nowrap">
<h2>
 <c:choose>
    <c:when test="${archiveEntity}"><fmt:message key="managementProgrammeArchiveForm.title" /></c:when>
    <c:otherwise><fmt:message key="managementProgrammeTrashForm.title" /></c:otherwise>
  </c:choose>
</h2>
</div>
<scannell:form>
<c:set var="managementProgramme" value="${command.entity}" />
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<tbody>
  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td >
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${managementProgramme.displayId}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.status" />:</td>
    <td ><fmt:message key="task.${managementProgramme.status}" /></td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td  colspan="3">
      <ul>
      <c:forEach var="ba" items="${managementProgramme.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.name" />:</td>
    <td  colspan="3"><scannell:text value="${managementProgramme.name}" /></td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
    <td ><fmt:formatDate value="${managementProgramme.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
    <td ><fmt:formatDate value="${managementProgramme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.responsibleUser" />:</td>
    <td colspan="3" ><c:out value="${managementProgramme.responsibleUser.displayName}" /></td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.objective" />:</td>
    <td colspan="3" >
      <c:if test="${managementProgramme.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${managementProgramme.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${managementProgramme.objective.displayId}" /></a> -
        <c:out value="${managementProgramme.objective.name}" />
      </c:if>
    </td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel nowrap"><fmt:message key="managementProgramme.percentCompleted" />:</td>
    <td colspan="3"><c:out value="${managementProgramme.percentCompleted}" />%</td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel" ><fmt:message key="managementProgramme.progressComment" />:</td>
    <td  colspan="3"><scannell:text value="${managementProgramme.progressComment}" /></td>
  </tr>

  <c:if test="${managementProgramme.completed}">
  <tr >
    <td class="scannellGeneralLabel" colspan="3"><fmt:message key="managementProgramme.completionDate" />:</td>
    <td ><fmt:formatDate value="${managementProgramme.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="managementProgramme.completionComment" />:</td>
    <td  colspan="3"><scannell:text value="${managementProgramme.completionComment}" /></td>
  </tr>
  </c:if>

  <tr >
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td ><c:out value="${managementProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${managementProgramme.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td ><c:out value="${managementProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
    <c:if test="${managementProgramme.lastUpdatedByUser == null}">
    <td class="scannellGeneralLabel"></td>
    <td ></td>
    </c:if>
  </tr>

  <tr id="showSubTask">
    <td class="scannellGeneralLabel"></td>
    <td  colspan="3">
      <c:set var="displayedWarningMessage" value="false" />
      <ul>
      <c:forEach var="task" items="${managementProgramme.tasks}">
        <c:if test="${not (task.archived or task.completed or task.trashed)}">
          <c:if test="${not displayedWarningMessage}">
            <c:set var="displayedWarningMessage" value="true" />
            <fmt:message key="assessmentTrashForm.openTasks" />
          </c:if>
          <li class="showSubTask"><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="${task.displayId}" /></a></li>
        </c:if>
      </c:forEach>
      </ul>
    </td>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <c:choose>
        <c:when test="${archiveEntity}"><fmt:message var="submitButton" key="archive" /></c:when>
        <c:otherwise>
        	<c:if test="${managementProgramme.trashed }"><fmt:message var="submitButton" key="untrash" /></c:if>
        	<c:if test="${managementProgramme.trashed == false}"><fmt:message var="submitButton" key="trash" /></c:if>
        </c:otherwise>
      </c:choose>
      <input type="submit" class="g-btn g-btn--primary" value="<c:out value="${submitButton}" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}"/></c:url>'">
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
