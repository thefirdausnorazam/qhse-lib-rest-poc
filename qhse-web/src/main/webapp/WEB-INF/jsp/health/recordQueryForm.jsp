<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta name="printable" content="true">
  <title><fmt:message key="healthRecordQueryForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
  <script type="text/javascript">
<!--
  function toggleQueryTable() {
    $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
    $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
  }
// -->
  </script>
</head>
<body onload="copyFormValuesIfPopup('queryForm'); $('queryForm').onsubmit();">

<div style="text-align:right;">
<form action="<c:url value="/health/recordView.htm" />" method="get" onsubmit="if(!$F('gotoId')) return false;">
  Go to ID: <input type="text" id="gotoId" name="id" size="3"><input type="submit" value="Go">
</form>
</div>

<a href="#" id="queryTableToggleLink" onclick="toggleQueryTable();">Display Search Criteria</a> | <scannell:url urls="${urls}" />

<scannell:form id="queryForm" action="/health/recordQueryResult.htmf" onsubmit="updateSearchCriteriaSummary(); displayQueryTable(false); return search(this, 'resultsDiv');">
  <scannell:hidden path="calculateTotals" />
  <scannell:hidden path="pageNumber" />
  <scannell:hidden path="pageSize" />

<table id="queryTable" class="viewForm" style="display: none;">
<thead>
  <tr><td colspan="4"><fmt:message key="searchCriteria" /></td></tr>
</thead>
<tbody id="searchCriteria">
  <tr>
    <th id="personLabel"><fmt:message key="healthRecord.person" />:</th>
    <td colspan="3">
      <scannell:select id="person" path="person" items="${userList}" itemLabel="sortableName" itemValue="id" class="wide" emptyOptionLabel="${emptyObjectiveLabel}" />
      (Blank = All)
    </td>
  </tr>

  <tr>
    <th id="departmentIdLabel"><fmt:message key="healthRecord.department" />:</th>
    <td colspan="3">
      <scannell:select id="departmentId" path="departmentId" items="${departmentList}" itemLabel="name" itemValue="id" class="wide" emptyOptionLabel="${emptyObjectiveLabel}" />
    </td>
  </tr>

  <tr>
    <th id="segLabel"><fmt:message key="healthRecord.seg" />:</th>
    <td colspan="3">
      <scannell:select id="seg" path="seg" renderEmptyOption="true" class="wide">
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
    <th id="employmentStartDateFromLabel"><fmt:message key="healthRecord.employmentStartDate" /> <fmt:message key="from" />:</th>
    <td>
      <input name="employmentStartDateFrom" id="employmentStartDateFrom" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'employmentStartDateFrom', true);">
    </td>

    <th id="employmentStartDateToLabel"><fmt:message key="to" />:</th>
    <td>
      <input name="employmentStartDateTo" id="employmentStartDateTo" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'employmentStartDateTo', true);">
    </td>
  </tr>

  <tr>
    <th id="createdByUserLabel"><fmt:message key="createdBy" />:</th>
    <td colspan="3">
      <scannell:select id="createdByUser" path="createdByUser" items="${userList}" itemLabel="sortableName" itemValue="id" class="wide" emptyOptionLabel="${emptyObjectiveLabel}" />
    </td>
  </tr>

  <tr>
    <th id="sortNameLabel"><fmt:message key="sortName" />:</th>
    <td colspan="3">
      <scannell:select id="sortName" path="sortName" items="${sortList}" lookupItemLabel="true" renderEmptyOption="true" class="wide" />
    </td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="4">
      <button type="submit" onClick="this.form.pageNumber.value = 1;"><fmt:message key="search" /></button>
      <button type="reset"><fmt:message key="reset" /></button>
    </td>
  </tr>
</tfoot>
</table>

<div id="searchCriteria.summary"></div>
<div id="resultsDiv"></div>

</scannell:form>
</body>
</html>
