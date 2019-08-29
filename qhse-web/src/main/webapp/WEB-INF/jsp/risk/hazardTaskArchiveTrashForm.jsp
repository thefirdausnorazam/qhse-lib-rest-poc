<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<c:set var="task" value="${command.entity}" />
<html>
<head>
  <title>
  
  </title>
</head>
<body>
<div class="header">
<h2>
<c:choose>
     <c:when test="${archiveEntity}"><fmt:message key="taskArchiveForm.title" /></c:when>
     <c:otherwise><fmt:message key="taskTrashForm.title" /></c:otherwise>
  </c:choose>
</h2>
</div>
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${task.displayId}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="task.${task.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>
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

  <!-- <tr>
    <td class="label"><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="link" items="${docLinkHolder.links}">
        <li><a href="<c:out value="${link.url}" />" target="linkedDoc"><c:out value="${link.name}" /></a> - <c:out value="${link.description}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  -->
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td ${task.lastUpdatedByUser != null ? "":"colspan='3'"}>
    	<c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>

    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="4" align="center">
      <c:choose>
        <c:when test="${task.trashed}"><fmt:message var="submitButton" key="untrash" /></c:when>
        <c:otherwise><fmt:message var="submitButton" key="trash" /></c:otherwise>
      </c:choose>
      <input type="submit" class="button btn-primary" value="<c:out value="${submitButton}" />">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
