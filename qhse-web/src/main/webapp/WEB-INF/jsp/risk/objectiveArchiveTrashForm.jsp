<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  
  <style type="text/css" media="all">   
    @import "<c:url value='/css/risk.css'/>";
  </style>
  
  <title>
  
  </title>
</head>
<body>
<div class="header nowrap">
<h2>
<c:choose>
    <c:when test="${archiveEntity}"><fmt:message key="objectiveArchiveForm.title" /></c:when>
    <c:otherwise><fmt:message key="objectiveTrashForm.title" /></c:otherwise>
  </c:choose>
  </h2>
</div>
<scannell:form>
<c:set var="objective" value="${command.entity}" />
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<%-- <col  /> --%>
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${objective.displayId}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="objective.status" />:</td>
    <td><fmt:message key="task.${objective.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="ba" items="${objective.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.name" />:</td>
    <td colspan="3"><scannell:text value="${objective.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.benefit" />:</td>
    <td colspan="3"><scannell:text value="${objective.benefit}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.creationDate" />:</td>
    <td><fmt:formatDate value="${objective.creationDate}" pattern="dd-MMM-yyyy"/></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="objective.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${objective.targetCompletionDate}" pattern="dd-MMM-yyyy"/></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.category" />:</td>
    <td colspan="3"><c:out value="${objective.category.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.externalObjective" />:</td>
    <td colspan="3"><c:out value="${objective.externalObjective}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.sponsor" />:</td>
    <td colspan="3"><c:out value="${objective.sponsor}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="objective.percentCompleted" />:</td>
    <td><c:out value="${objective.percentCompleted}" />%</td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.progressComment" />:</td>
    <td colspan="3"><scannell:text value="${objective.progressComment}" /></td>
  </tr>

  <c:if test="${objective.completed}">
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.completionDate" />:</td>
    <td><fmt:formatDate value="${objective.completionDate}" pattern="dd-MMM-yyyy"/></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${objective.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${objective.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${objective.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${objective.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <c:choose>
        <c:when test="${archiveEntity}"><fmt:message var="submitButton" key="archive" /></c:when>
        <c:when test="${objective.trashed}"><fmt:message var="submitButton" key="untrash" /></c:when>
        <c:otherwise><fmt:message var="submitButton" key="trash" /></c:otherwise>
      </c:choose>
      <input type="submit" class="button btn-primary" value="<c:out value="${submitButton}" />">
      <input type="button" class="button btn-primary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}"/></c:url>'">
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
