<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthRecordForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
</head>
<body>

<scannell:form>
<table class="viewForm">
<tbody>
  <c:if test="${record.id != null}">
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${record.id}" />
    </td>

    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </c:if>

  <tr>
    <td class="label"><fmt:message key="healthRecord.person" />:</td>
    <td style="vertical-align: top;"><select name="person" items="${userList}" itemLabel="sortableName" itemValue="id" /></td>

    <td class="label"><fmt:message key="healthRecord.address" />:</td>
    <td rowspan="2"><scannell:textarea path="address" cols="35" rows="3" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.department" />:</td>
    <td colspan="2" style="vertical-align: top;"><select name="department" items="${departmentList}" itemLabel="name" itemValue="id" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.employeeNumber" />:</td>
    <td><input name="employeeNumber" /></td>

    <td class="label"><fmt:message key="healthRecord.seg" />:</td>
    <td>
      <scannell:select id="seg" path="seg" renderEmptyOption="true">
        <scannell:option value="SEG 01" label="SEG 01" />
        <scannell:option value="SEG 02" label="SEG 02" />
        <scannell:option value="SEG 03" label="SEG 03" />
        <scannell:option value="SEG 04" label="SEG 04" />
        <scannell:option value="SEG 05" label="SEG 05" />
        <scannell:option value="SEG 06" label="SEG 06" />
        <scannell:option value="SEG 07" label="SEG 07" />
        <scannell:option value="SEG 08" label="SEG 08" />
        <scannell:option value="SEG 09" label="SEG 09" />
        <scannell:option value="SEG 10" label="SEG 10" />
        <scannell:option value="SEG 11" label="SEG 11" />
        <scannell:option value="SEG 12" label="SEG 12" />
        <scannell:option value="SEG 13" label="SEG 13" />
        <scannell:option value="SEG 14" label="SEG 14" />
        <scannell:option value="SEG 15" label="SEG 15" />
        <scannell:option value="SEG 16" label="SEG 16" />
        <scannell:option value="SEG 17" label="SEG 17" />
        <scannell:option value="SEG 18" label="SEG 18" />
        <scannell:option value="SEG 19" label="SEG 19" />
        <scannell:option value="SEG 20" label="SEG 20" />
      </scannell:select>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.title" />:</td>
    <td><input name="title" /></td>

    <td class="label"><fmt:message key="healthRecord.postcode" />:</td>
    <td><input name="postcode" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.maritalStatus" />:</td>
    <td><input name="maritalStatus" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberHome" />:</td>
    <td><input name="phoneNumberHome" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.sex" />:</td>
    <td><input name="sex" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberWork" />:</td>
    <td><input name="phoneNumberWork" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.birthdate" />:</td>
    <td>
      <input name="birthdate" id="birthdate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'birthdate', true);">
    </td>

    <td class="label"><fmt:message key="healthRecord.emailAddress" />:</td>
    <td><input name="emailAddress" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.location" />:</td>
    <td><input name="location" /></td>

    <td class="label"><fmt:message key="healthRecord.employmentStartDate" />:</td>
    <td>
      <input name="employmentStartDate" id="employmentStartDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'employmentStartDate', true);">
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.locationSecondary" />:</td>
    <td><input name="locationSecondary" /></td>

    <td class="label"><fmt:message key="healthRecord.firstExaminedDate" />:</td>
    <td>
      <input name="firstExaminedDate" id="firstExaminedDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'firstExaminedDate', true);">
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.manager" />:</td>
    <td><input name="manager" /></td>

    <td class="label"><fmt:message key="healthRecord.occupation" />:</td>
    <td><input name="occupation" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.doctor" />:</td>
    <td><input name="doctor" /></td>

    <td class="label"><fmt:message key="healthRecord.occupationSecondary" />:</td>
    <td><input name="occupationSecondary" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.healthCaution1" />:</td>
    <td><input name="healthCaution1" /></td>

    <td class="label"><fmt:message key="healthRecord.healthCaution2" />:</td>
    <td><input name="healthCaution2" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.ethnicOrigin" />:</td>
    <td><input name="ethnicOrigin" /></td>

    <td class="label"><fmt:message key="healthRecord.bloodGroup" />:</td>
    <td><input name="bloodGroup" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.nextOfKin" />:</td>
    <td><scannell:textarea path="nextOfKin" cols="35" rows="3" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberNextOfKin" />:</td>
    <td style="vertical-align: top;"><input name="phoneNumberNextOfKin" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.familyHistory" />:</td>
    <td colspan="3"><scannell:textarea path="familyHistory" cols="75" rows="3" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.notes" />:</td>
    <td colspan="3"><scannell:textarea path="notes" cols="75" rows="3" /></td>
  </tr>


  <tr>
  <c:choose>
  <c:when test="${record.createdByUser != null}">
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${record.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${record.lastUpdatedByUser != null}">
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${record.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
      <c:choose>
        <c:when test="${record.id gt 0}">
        <input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/health/recordView.htm"><c:param name="id" value="${record.id}"/></c:url>'">
        </c:when>
        <c:otherwise>
        <input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/health/home.htm" />'">
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
