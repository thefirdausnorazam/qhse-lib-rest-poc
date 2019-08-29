<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="trainingQueryForm" /></title>

<script type="text/javascript" src="<c:url value="/js/survey.js" />" ></script>
<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body onload="$('queryForm').onsubmit();">

<c:if test="${canConfigure}">
  <a href="<c:url value="trainingEdit.htm"/>"><fmt:message key="trainingCreate" /></a>&nbsp;
</c:if>

<form id="queryForm" action="<c:url value="/training/trainingQuery.htmf" />" onsubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />

<table class="viewForm">
    <col class="label" />
<thead>
  <tr>
    <td colspan="4">
      <fmt:message key="searchCriteria" />
    </td>
  </tr>
</thead>
<tbody>
  <tr>
    <td><label for="categoryId"><fmt:message key="training.category" /></label>:</td>
    <td colspan="3"><select id="categoryId" name="categoryId" class="wide">
      <option></option>
      <c:forEach items="${categories}" var="category">
        <option value="<c:out value="${category.id}" />">
          <c:out value="${category.name}" />
        </option>
      </c:forEach>
    </select>
    </td>
  </tr>

  <tr>
    <td><label for="active"><fmt:message key="active" /></label>:</td>
    <td colspan="3"><select id="active" name="active" class="narrow">
      <option value="true"><fmt:message key="true" /></option>
      <option value="false"><fmt:message key="false" /></option>
      <option value=""></option>
    </select>
    </td>
  </tr>

  <tr>
    <td><label for="dueDateFrom"><fmt:message key="training.dueDate" /> <fmt:message key="from" /></label>:</td>
    <td>
        <input type="text" id="dueDateFrom" name="dueDateFrom" size="15" readonly="readonly" />
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'dueDateFrom', true);">
    </td>
    <td>
        <label for="dueDateTo"><fmt:message key="to" /></label>
    </td>
    <td>
        <input type="text" id="dueDateTo" name="dueDateTo" size="15" readonly="readonly" />
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'dueDateTo', true);">
    </td>
  </tr>

  <tr>
    <td><label for="lastDateFrom"><fmt:message key="training.lastDate" /> <fmt:message key="from" /></label>:</td>
    <td>
        <input type="text" id="lastDateFrom" name="lastDateFrom" size="15" readonly="readonly" />
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'lastDateFrom', true);">
    </td>
    <td>
        <label for="lastDateTo"><fmt:message key="to" /></label>
    </td>
    <td>
        <input type="text" id="lastDateTo" name="lastDateTo" size="15" readonly="readonly" />
        <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'lastDateTo', true);">
    </td>
  </tr>

  <tr>
    <td><label for="receiverId"><fmt:message key="training.receiver" /></label>:</td>
    <td colspan="3"><select id="receiverId" name="receiverId" class="wide">
      <option></option>
      <c:forEach items="${users}" var="user">
        <option value="<c:out value="${user.id}" />">
          <c:out value="${user.sortableName}" />
        </option>
      </c:forEach>
    </select>
    </td>
  </tr>
  
    <tr>
    <td><label for="responsibleId"><fmt:message key="training.responsible" /></label>:</td>
    <td colspan="3"><select id="responsibleId" name="responsibleId" class="wide">
      <option></option>
      <c:forEach items="${users}" var="user">
        <option value="<c:out value="${user.id}" />">
          <c:out value="${user.sortableName}" />
        </option>
      </c:forEach>
    </select>
    </td>
  </tr>
 
  <tr>
    <td><label for="departmentId"><fmt:message key="training.department" /></label>:</td>
    <td colspan="3"><select id="departmentId" name="departmentId" class="wide">
      <option></option>
      <c:forEach items="${departments}" var="department">
        <option value="<c:out value="${department.id}" />">
          <c:out value="${department.name}" />
        </option>
      </c:forEach>
    </select>
    </td>
  </tr>

  <tr>
    <td><label for="carriedOutBy"><fmt:message key="training.carriedOutBy" /></label>:</td>
    <td colspan="3"><input type="text" id="carriedOutBy" name="carriedOutBy" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="sortName" />:</td>
    <td colspan="3">
      <select name="sortName" class="wide">
        <c:forEach items="${sorts}" var="item">
            <option value="<c:out value="${item}" />">
              <fmt:message key="${item}" />
            </option>
        </c:forEach>
      </select>
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

<div id="resultsDiv"></div>

</form>
</body>
</html>
