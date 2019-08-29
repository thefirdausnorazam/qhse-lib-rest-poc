<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<c:set var="task" value="${command.entity}" />
<html>
<head>
  <title>
  <c:choose>
     <c:when test="${archiveEntity}"><fmt:message key="taskArchiveForm.title" /></c:when>
     <c:otherwise><fmt:message key="taskTrashForm.title" /></c:otherwise>
  </c:choose>
  </title>
</head>
<body>

<scannell:form>

<table class="table table-bordered table-responsive" style="width:100%;border-top:1px solid #DADADA;">
<tbody>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${task.displayId}" />
    </td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="${task.status}" /></td>
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
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>
  <c:if test="${task.completed}">
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.achieved" />:</td>
    <td colspan="3"><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completedBy" />:</td>
    <td colspan="3"><c:out value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3"><jsp:include page="../doclink/showLinkedDocs.jsp" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    <c:if test="${task.lastUpdatedByUser == null}">
    <td></td>
    <td></td>
    </c:if>
    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="4" align="center">
      <c:choose>
        <c:when test="${archiveEntity}"><fmt:message var="submitButton" key="archive" /></c:when>
        <c:when test="${task.trashed}"><fmt:message var="submitButton" key="untrash" /></c:when>
        <c:otherwise><fmt:message var="submitButton" key="trash" /></c:otherwise>
      </c:choose>
      <input type="submit" value="<c:out value="${submitButton}" />" class="g-btn g-btn--primary"> 
    </td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
