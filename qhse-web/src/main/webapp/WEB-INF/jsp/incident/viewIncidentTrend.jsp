<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
  <title></title>
  
<script type="text/javascript">
function loadChart() {
  jQuery( "#trend-chartDiv" ).dialog();
  var chartImg = jQuery("#trend-chart");
  var w = chartImg.width();
  var h = Math.round(w * 0.6);
//   jQuery("#chartWidth").val(w); 
//   jQuery("#chartHeight").val(h); 
  chartImg.attr("src", contextPath + "/incident/summariseIncidents.jpeg?" + jQuery("#filterForm").serialize());
  chartImg.show();
}

jQuery(document).ready(function() {
	jQuery('select').select2();
	jQuery("#chartGroupBy").change(function() {
    loadChart();
    jQuery('.ui-dialog').css( "width", "500px" );
  });
  loadChart();
  jQuery('.ui-dialog').css( "width", "500px" );
});
</script>

</head>

<body>
<div class="header">
<h2><fmt:message key="viewIncidentTrend" /></h2>
</div>
<div class="panel">
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td><c:out value="${incidentTrend.id}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="description" />:</td>
    <td><div class="bigtext"><c:out value="${incidentTrend.description}" /></div></td>
  </tr>

  <tr>
    <td ><fmt:message key="fromDate" />:</td>
    <td><fmt:formatDate value="${incidentTrend.fromDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="toDate" />:</td>
    <td><fmt:formatDate value="${incidentTrend.toDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="incidentType" />:</td>
    <td>
      <c:if test="${incidentTrend.incidentType != null}" >
        <fmt:message key="${incidentTrend.incidentType.key}" />
      </c:if>
    </td>
  </tr>

  <tr>
    <td ><fmt:message key="rootCause" />:</td>
    <td>
      <div>
      	<c:out value="${incidentTrend.causeType.name}" />
        <%-- <c:forEach items="${investigation.causeTypes}" var="item" varStatus="s"><c:if test="${!s.first}">, </c:if><c:out value="${item.name}"/></c:forEach> --%>
      </div>
    </td>
  </tr>

  <tr>
    <td ><fmt:message key="department" />:</td>
    <td><c:out value="${incidentTrend.department.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${incidentTrend.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${incidentTrend.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${incidentTrend.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td>
      <c:out value="${incidentTrend.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${incidentTrend.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
</tbody>
<tfoot>
  <tr>
    <td colspan="2">
      <c:if test="${incidentTrend.editable}">
        <a href="<c:url value="editIncidentTrend.htm"><c:param name="showId" value="${incidentTrend.id}" /></c:url>"><fmt:message key="editIncidentTrend" /></a>
      </c:if>
      <c:if test="${incidentTrend.action != null}">
      	<c:if test="${incidentTrend.editable}">&nbsp;|&nbsp;</c:if>
        <a href="<c:url value="viewAction.htm"><c:param name="id" value="${incidentTrend.action.id}" /></c:url>"><fmt:message key="viewPreventativeAction" /></a>
      </c:if>
       <c:if test="${incidentTrend.lastUpdatedByUser != null}">
      	<c:if test="${incidentTrend.editable or incidentTrend.action != null}">&nbsp;|&nbsp;</c:if>
      <a href="javascript:openHistory(<c:out value="${incidentTrend.id},'${incidentTrend['class'].name}'" />)">
        <fmt:message key="viewHistory" /></a>
        </c:if>
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
<br />

<form id="filterForm" action="<c:url value="/incident/searchIncidents.htmf" />" onsubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" name="pageSize" value="10" />
  <input type="hidden" name="typeId" value="<c:out value="${incidentTrend.incidentType.id}" />" />
  <input type="hidden" name="subTypeId" value="<c:out value="${incidentTrend.incidentSubType.id}" />" />
  <input type="hidden" name="rootCauseId" value="<c:out value="${incidentTrend.causeType.id}" />" />
  <input type="hidden" name="fromOccurredDate" value="<fmt:formatDate value="${incidentTrend.fromDate}" pattern="dd-MMM-yyyy" />" />
  <input type="hidden" name="toOccurredDate" value="<fmt:formatDate value="${incidentTrend.toDate}" pattern="dd-MMM-yyyy" />" />
  <input type="hidden" name="departmentId" value="<c:out value="${incidentTrend.department.id}" />" />

  <input type="hidden" name="aggregateName" value="total" />
  <input type="hidden" name="secondaryGroupByName" value="date" />
  <input type="hidden" id="chartWidth" name="chartWidth" value="500" />
  <input type="hidden" id="chartHeight" name="chartHeight" value="400" />
  <fmt:message key="viewGraphBy" />:&nbsp;
  <select id="chartGroupBy" name="primaryGroupByName" style="width:300px;">
    <c:forEach items="${primaryGroupBys}" var="item">
      <option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
    </c:forEach>
  </select>
  <br />
  
  <div id="trend-chartDiv" title="Trend Chart" style="text-align: center;">
  <img id="trend-chart" style="display: none; width: 90%; " />
  </div>

  <br />
  <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;"><fmt:message key="viewIncidents" /></button>
  <div id="resultsDiv"></div>
</form>

</body>
</html>
