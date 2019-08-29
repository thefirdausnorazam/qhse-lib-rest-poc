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
<div class="header">
<h2><fmt:message key="readingTrash" /></h2>
</div>
<div class="content"> 
<scannell:form>
<c:set var="reading" value="${command.entity}" />
<div class="header">
<h2><fmt:message key="reading" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">

<tbody>
  <tr>
    <td><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${reading.id}" />
    </td>

    <td><fmt:message key="status" />:</td>
    <td><fmt:message key="${reading.status}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="quantity" />:</td>
    <td colspan="3"><c:out value="${reading.type.quantity.longName}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="measure" />:</td>
    <td><c:out value="${reading.type.measure.measureName}" /></td>

    <td><fmt:message key="readingPoint" />:</td>
    <td><c:out value="${reading.type.readingPoint.name}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="measurement.frequency" />:</td>
    <td><c:out value="${reading.type.frequencyDisplay}" /></td>

    <td><fmt:message key="timePeriod.${reading.timePeriod.name}" />:</td>
    <td><fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="additionalInfo" />:</td>
    <td colspan="3"><scannell:text value="${reading.type.additionalInfo}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="readingTime" />:</td>
    <td><fmt:formatDate value="${reading.readingTime}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <td><fmt:message key="value" />:</td>
    <td><spring:message code="${reading.customUnitValueOfUnitSelected}" text="${reading.customUnitValueOfUnitSelected}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="comment" />:</td>
    <td colspan="3"><scannell:text value="${reading.notes}" /></td>
  </tr>

  <c:if test="${reading.updateComment != null}" >
  <tr>
    <td><fmt:message key="updateComment" />:</td>
    <td colspan="3"><scannell:text value="${reading.updateComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td><fmt:message key="createdBy" />:</td>
    <td colspan="3"><c:out value="${reading.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${reading.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${reading.lastUpdatedByUser != null}">
  <tr>
    <td><fmt:message key="lastUpdatedBy" />:</td>
    <td colspan="3"><c:out value="${reading.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${reading.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  </c:if>
</tbody>
<tfoot style="text-align: center;">
  <tr>
    <td colspan="4">
      <c:if test="${reading.editable}">
        <fmt:message var="submitButton" key="trash" />
        <input type="submit" class="g-btn g-btn--primary" value="<c:out value="${submitButton}" />">
      </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/survey/readingView.htm"><c:param name="id" value="${reading.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>
</div>
</body>
</html>
