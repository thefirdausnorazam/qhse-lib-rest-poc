<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta name="printable" content="true">
  <title><fmt:message key="recordView.title" /></title>
  <script type="">
</script>
</head>
<body>

<a name="record"></a>
<table class="viewForm">
  <tbody>
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td><c:out value="${record.id}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.person" />:</td>
    <td style="vertical-align: top;"><c:out value="${record.person.displayName}" /></td>

    <td class="label"><fmt:message key="healthRecord.address" />:</td>
    <td rowspan="2"><scannell:text value="${record.address}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.department" />:</td>
    <td colspan="2"><c:out value="${record.department.name}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.employeeNumber" />:</td>
    <td><c:out value="${record.employeeNumber}" /></td>

    <td class="label"><fmt:message key="healthRecord.seg" />:</td>
    <td><c:out value="${record.seg}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.title" />:</td>
    <td><c:out value="${record.title}" /></td>

    <td class="label"><fmt:message key="healthRecord.postcode" />:</td>
    <td><c:out value="${record.postcode}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.maritalStatus" />:</td>
    <td><c:out value="${record.maritalStatus}" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberHome" />:</td>
    <td><c:out value="${record.phoneNumberHome}" /></td>
  </tr>


  <tr>
    <td class="label"><fmt:message key="healthRecord.sex" />:</td>
    <td><c:out value="${record.sex}" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberWork" />:</td>
    <td><c:out value="${record.phoneNumberWork}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.birthdate" />:</td>
    <td><fmt:formatDate value="${record.birthdate}" pattern="dd-MMM-yyyy" /></td>

    <td class="label"><fmt:message key="healthRecord.emailAddress" />:</td>
    <td><c:out value="${record.emailAddress}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.location" />:</td>
    <td><c:out value="${record.location}" /></td>

    <td class="label"><fmt:message key="healthRecord.employmentStartDate" />:</td>
    <td><fmt:formatDate value="${record.employmentStartDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.locationSecondary" />:</td>
    <td><c:out value="${record.locationSecondary}" /></td>

    <td class="label"><fmt:message key="healthRecord.firstExaminedDate" />:</td>
    <td><fmt:formatDate value="${record.firstExaminedDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.manager" />:</td>
    <td><c:out value="${record.manager}" /></td>

    <td class="label"><fmt:message key="healthRecord.occupation" />:</td>
    <td><c:out value="${record.occupation}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.doctor" />:</td>
    <td><c:out value="${record.doctor}" /></td>

    <td class="label"><fmt:message key="healthRecord.occupationSecondary" />:</td>
    <td><c:out value="${record.occupationSecondary}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.healthCaution1" />:</td>
    <td><c:out value="${record.healthCaution1}" /></td>

    <td class="label"><fmt:message key="healthRecord.healthCaution2" />:</td>
    <td><c:out value="${record.healthCaution2}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.ethnicOrigin" />:</td>
    <td><c:out value="${record.ethnicOrigin}" /></td>

    <td class="label"><fmt:message key="healthRecord.bloodGroup" />:</td>
    <td><c:out value="${record.bloodGroup}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.nextOfKin" />:</td>
    <td><scannell:text value="${record.nextOfKin}" /></td>

    <td class="label"><fmt:message key="healthRecord.phoneNumberNextOfKin" />:</td>
    <td  style="vertical-align: top;"><c:out value="${record.phoneNumberNextOfKin}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.familyHistory" />:</td>
    <td colspan="3"><scannell:text value="${record.familyHistory}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthRecord.notes" />:</td>
    <td colspan="3"><scannell:text value="${record.notes}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${record.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${record.lastUpdatedByUser != null}">
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${record.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${record.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4"><scannell:url urls="${urls}" /></td>
    </tr>
  </tfoot>
</table>


<br />
<form id="queryForm" action="<c:url value="/health/testQueryResult.htmf" />" onsubmit="return search(this, 'resultsDiv', true);">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<input type="hidden" name="sortName" value="timePeriod" />
	<input type="hidden" name="recordId" value="<c:out value="${record.id}" />" />
	<button type="submit" id="healthTestQueryButton" style="display: none;"><fmt:message key="testView" /></button>

	<div id="resultsDiv"></div>
</form>

</body>
</html>
