<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="printable" content="true">
<title><fmt:message key="trainingView" /></title>
</head>
<body>

<table class="viewForm">
    <col class="label" />
<tbody>
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td><c:out value="${subject.id}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.category" />:</td>
    <td><c:out value="${subject.category.name}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.receiver" />:</td>
    <td><c:out value="${subject.receiver.displayName}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="description" />:</td>
    <td><scannell:text value="${subject.description}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.responsible" />:</td>
    <td><c:out value="${subject.responsible.displayName}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.receiversDepartment" />:</td>
    <td><c:out value="${subject.receiversDepartment.name}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.replacementFrequency" />:</td>
    <td><c:out value="${subject.intervalAmount}" /> <fmt:message key="${subject.intervalType}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.dueDate" />:</td>
    <td><fmt:formatDate value="${subject.dueDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.lastDate" />:</td>
    <td><fmt:formatDate value="${subject.lastDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="equipment.alertLeadDays" />:</td>
    <td><c:out value="${subject.alertLeadDays}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="active" />:</td>
    <td><fmt:message key="${subject.active}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${subject.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${subject.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <c:if test="${subject.lastUpdatedByUser != null}">
  <tr>
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td>
      <c:out value="${subject.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${subject.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
</tbody>
<tfoot>
  <tr>
    <td colspan="2">
      <c:if test="${subject.editable}" >
        <a href="<c:url value="trainingEdit.htm"><c:param name="showId" value="${subject.id}" /></c:url>">
          <fmt:message key="trainingEdit" /></a>&nbsp;
      </c:if>
    </td>
  </tr>
</tfoot>
</table>


<table class="viewForm bordered">
  <thead>
    <tr class="title">
      <th colspan="5"><fmt:message key="records" /></th>
    </tr>
    <tr>
      <th><fmt:message key="training.dueDate" /></th>
      <th><fmt:message key="training.actualDate" /></th>
      <th><fmt:message key="training.carriedOutBy" /></th>
      <th><fmt:message key="comment" /></th>
      <th><fmt:message key="createdBy" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${subject.history}" var="record" varStatus="s">
      <tr>
        <td><fmt:formatDate value="${record.dueDate}" pattern="dd-MMM-yyyy" /></td>
        <td><fmt:formatDate value="${record.actualDate}" pattern="dd-MMM-yyyy" /></td>
        <td><c:out value="${record.carriedOutBy}" /></td>
        <td><scannell:text value="${record.comment}" /></td>
        <td><c:out value="${record.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      </tr>
    </c:forEach>
  </tbody>
</table>

</body>
</html>
