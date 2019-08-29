<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
 
</head>
<body>
<scannell:form action="/incident/taskTrashUnTrash.htm?id=${object.id}" >
<div class="header">
<h2>

    <c:choose>
 	   <c:when test="${object.trash}"><fmt:message key="unTrashTask" /></c:when>
   	   <c:otherwise> <fmt:message key="trashTask" /></c:otherwise>
    </c:choose>

</h2>
</div>
<c:set var="updateIncidentAllowed" value="${actionSite.id == site.id}" />
<div class="content">
<div class="table-responsive">
<div class="content">
<div class="panel">

<table class="table table-bordered table-responsive">
<tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td><c:out value="${object.id}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="description" />:</td>
    <td><div><c:out value="${object.description}" /></div></td>
  </tr>

  <tr>
    <td ><fmt:message key="targetDate" />:</td>
    <td><fmt:formatDate value="${object.targetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="responsibleUser" />:</td>
    <td><c:out value="${object.responsibleUser.displayName}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="responsibleDepartment" /></td>
    <td><c:out value="${object.responsibleDepartment.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="status" />:</td>
    <td>
    <c:choose>
 	   <c:when test="${object.trash}"><fmt:message key="trash" /></c:when>
   	   <c:otherwise> <fmt:message key="closed.${object.completed}" /></c:otherwise>
    </c:choose>
   </td> 
  </tr>
  <c:if test="${object.priority != null}">
  <tr>
    <td ><fmt:message key="priority" /></td>
    <td><fmt:message key="${object.priority}" /></td>
  </tr>
  </c:if>
    

  <c:if test="${object.completed}">
  <tr>
    <td ><fmt:message key="completedBy" />:</td>
    <td><c:out value="${object.completedBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.completedTime}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="completedComment" />:</td>
    <td><div><c:out value="${object.completedComment}" /></div></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${object.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${object.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${object.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  </c:if>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
    <c:if test="${object.trash == false}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
    </c:if>
   <c:if test="${object.trash == true}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />">
    </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/incident/viewTask.htm"><c:param name="id" value="${object.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
