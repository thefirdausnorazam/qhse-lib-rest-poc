<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthTestConsultationForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
</head>
<body>

<scannell:form>
<table class="viewForm">
<tbody>
  <c:if test="${test.id != null}">
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${test.id}" />
    </td>

    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </c:if>

  <tr>
    <td class="label"><fmt:message key="healthRecord.person" />:</td>
    <td><c:out value="${command.record.person.displayName}" /></td>

    <td class="label"><fmt:message key="healthRecord.department" />:</td>
    <td><c:out value="${command.record.department.name}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.testDate" />:</td>
    <td colspan="3">
      <input name="testDate" id="testDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'testDate', true);">
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.testReason" />:</td>
    <td colspan="3"><scannell:textarea path="testReason" cols="75" rows="3" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.notes" />:</td>
    <td colspan="3"><scannell:textarea path="notes" cols="75" rows="3" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.retestDate" />:</td>
    <td colspan="3">
      <input name="retestDate" id="retestDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'retestDate', true);">
    </td>
  </tr>


  <tr>
  <c:choose>
  <c:when test="${command.createdByUser != null}">
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${command.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${command.lastUpdatedByUser != null}">
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${command.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" value="<fmt:message key="submit" />">
      <input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/health/recordView.htm"><c:param name="id" value="${command.record.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
