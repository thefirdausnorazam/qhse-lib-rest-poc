<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="editIncidentTrend" />
<c:if test="${command['new']}"><c:set var="title" value="createIncidentTrend" /></c:if>
<title><fmt:message key="${title}" /></title>
<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
}
</style>
<script language="javascript" src="<c:url value="/js/utils.js" />"> </script>
<script language="javascript" src="<c:url value="/js/incident.js" />"> </script>
<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript" >
jQuery(document).ready(function() {	
	jQuery('select').select2();
});

function previewIncidents(form) {
  updateForm(form);
  return search(form, 'resultsDiv');
}

function previewGraph(form) {
  updateForm(form);  
  return summariseChart(form, '/incident/summariseIncidents.jpeg', '1000','800');
}

function updateForm(form) {
  document.filterForm.typeId.value = document.trendForm.incidentType.value
  document.filterForm.subTypeId.value = document.trendForm.incidentSubType.value  
  document.filterForm.rootCauseId.value = document.trendForm.causeType.value 
  document.filterForm.departmentId.value = document.trendForm.department.value
  document.filterForm.fromOccurredDate.value = document.trendForm.fromDate.value
  document.filterForm.toOccurredDate.value = document.trendForm.toDate.value
  document.filterForm.primaryGroupByName.value = document.trendForm.primaryGroupByName.value
}

</script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<spring:hasBindErrors name="command">
  <div class="errorMessage"><fmt:message key="errors.global" /></div>
  <br />
  <spring:bind path="command">
    <div class="errorMessage"><c:out value="${status.errorMessage}" /></div>
    <br />
  </spring:bind>
</spring:hasBindErrors>


<form name="trendForm" method="post" >

<spring:nestedPath path="command">
<spring:bind path="id">
  <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
  <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>
<spring:bind path="version">
  <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
  <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="description" /></td>
    <td class="search"><spring:bind path="description">
      <textarea name="<c:out value="${status.expression}"/>" style="width:300px;"><c:out
        value="${status.value}" /></textarea>
        <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="incidentType" /></td>
    <td class="search">
      <spring:bind path="incidentType">
        <select name="<c:out value="${status.expression}"/>" style="width:300px;">
          <option value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${incidentTypes}" var="type">
            <option value="<c:out value="${type.id}" />" <c:if test="${type.id == status.value}">selected="selected"</c:if>>
              <fmt:message key="${type.key}" /></option>
            </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="incidentSubType" /></td>
    <td class="search">
      <spring:bind path="incidentSubType">
        <select name="<c:out value="${status.expression}"/>" style="width:300px;">
          <option value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${incidentTypes}" var="type">
            <c:forEach items="${type.subTypes}" var="subType">
              <c:if test="${subType.active}">
                <option value="<c:out value="${subType.id}" />" <c:if test="${subType.id == status.value}">selected="selected"</c:if>>
                  <fmt:message key="${type.key}" /> : <c:out value="${subType.name}" /></option>
              </c:if>
              </c:forEach>
            </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="rootCause" /></td>
    <td class="search">
      <spring:bind path="causeType">
        <select name="<c:out value="${status.expression}"/>" style="width:300px;">
          <option value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${causeTypes}" var="type">
            <option value="<c:out value="${type.id}" />" <c:if test="${type.id == status.value}">selected="selected"</c:if>>
              <c:out value="${type.name}" /></option>
            </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="fromDate" /></td>
    <td class="search">
      <spring:bind path="fromDate">
        <%-- <input id="fromDate" type="text" name="<c:out value="${status.expression}"/>"
          value="<c:out value="${status.value}"/>" size="35" readonly="readonly">
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
          onclick="return showCalendar(event, 'fromDate', true);"> --%>
          <div id="cal" style="float:left;width:205px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                <input id="fromDate" class="form-control" value="<c:out value="${status.value}"/>" type="text" name="<c:out value="${status.expression}"/>"	readonly="readonly">              
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
        <span class="requiredHinted">*</span>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="toDate" /></td>
    <td class="search" >
      <spring:bind path="toDate">
       <%--  <input id="toDate" type="text" name="<c:out value="${status.expression}"/>"
          value="<c:out value="${status.value}"/>" size="35" readonly="readonly">
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
          onclick="return showCalendar(event, 'toDate', true);"> --%>
          <div id="cal" style="float:left;width:205px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                <input id="completionTargetDateTo" class="form-control" value="<c:out value="${status.value}"/>" type="text" name="<c:out value="${status.expression}"/>"	readonly="readonly">              
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>		
                </div>
        <span class="requiredHinted">*</span>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="department" /></td>
    <td class="search">
      <spring:bind path="department">
        <select name="<c:out value="${status.expression}"/>" style="width:300px;">
          <option value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${departments}" var="item">
              <c:if test="${item.active || item.id == status.value}">
              <option value="<c:out value="${item.id}" />"
                <c:if test="${item.id == status.value}">selected="selected"</c:if>>
                <c:out value="${item.name}" />
              </option>
              </c:if>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center">
      <button type="button" class="g-btn g-btn--primary" onClick="document.filterForm.pageNumber.value = 1; document.filterForm.onsubmit();" style="width: 200px;"><fmt:message key="previewIncidents" /></button>
      &nbsp;&nbsp;&nbsp;<fmt:message key="viewGraphBy" />:&nbsp;
      <select name="primaryGroupByName" style="width:13%">
        <c:forEach items="${primaryGroupBys}" var="item">
          <option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
        </c:forEach>
      </select>
      <button type="button" class="g-btn g-btn--primary" onClick="return previewGraph(document.filterForm)"><fmt:message key="go" /></button>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
    
    <c:set var="btnKey" value="submit" />
    <c:if test="${command.action == null}">
      <c:set var="btnKey" value="next" />
    </c:if>
    <button type="submit" class="g-btn g-btn--primary" ><fmt:message key="${btnKey}" /></button>
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</spring:nestedPath>
</form>

<form name="filterForm" action="<c:url value="/incident/searchIncidents.htmf" />" onsubmit="return previewIncidents(this);">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />
  <input type="hidden" name="typeId" />
  <input type="hidden" name="subTypeId" />
  <input type="hidden" name="rootCauseId" />
  <input type="hidden" name="fromOccurredDate" />
  <input type="hidden" name="toOccurredDate" />
  <input type="hidden" name="departmentId" />
  <input type="hidden" name=aggregateName value="total" />
  <input type="hidden" name="primaryGroupByName" />
  <input type="hidden" name=secondaryGroupByName value="date" />
  <input type="hidden" name="chartWidth" value="500" />
  <input type="hidden" name="chartHeight" value="400" />

  <div id="resultsDiv"></div>
</form>

</body>
</html>