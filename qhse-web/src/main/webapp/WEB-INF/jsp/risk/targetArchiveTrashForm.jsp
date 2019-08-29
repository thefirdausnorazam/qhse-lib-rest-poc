<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  
  <style type="text/css" media="all">		
		@import "<c:url value='/css/risk.css' />";
	</style>
	<title></title>
</head>
<body>
<div class="header nowrap">
<h2>
<c:choose>
    <c:when test="${archiveEntity}"><fmt:message key="targetArchiveForm.title" /></c:when>
    <c:otherwise><fmt:message key="targetTrashForm.title" /></c:otherwise>
  </c:choose>
</h2>
</div>
<scannell:form>
<c:set var="target" value="${command.entity}" />
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive">
<col class="label" />
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${target.displayId}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="target.status" />:</td>
    <td><fmt:message key="task.${target.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.name" />:</td>
    <td colspan="3"><scannell:text value="${target.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="target.creationDate" />:</td>
    <td><fmt:formatDate value="${target.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="target.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${target.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.objective" />:</td>
    <td colspan="3">
      <c:if test="${target.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${target.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${target.objective.displayId}" /></a> -
        <c:out value="${target.objective.name}" />
      </c:if>
    </td>
  </tr>

  <c:if test="${target.completed}" >
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.completedBy" />:</td>
    <td><c:out value="${target.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.completionDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="target.achieved" />:</td>
    <td><fmt:message key="boolean.${target.achieved}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="target.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${target.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${target.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${target.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${target.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <c:choose>
        <c:when test="${archiveEntity}"><fmt:message var="submitButton" key="archive" /></c:when>
        <c:when test="${target.trashed}"><fmt:message var="submitButton" key="untrash" /></c:when>
        <c:otherwise><fmt:message var="submitButton" key="trash" /></c:otherwise>
      </c:choose>
      <input type="submit" class="g-btn g-btn--primary" value="<c:out value="${submitButton}" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/targetView.htm"><c:param name="id" value="${target.id}"/></c:url>'">
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
