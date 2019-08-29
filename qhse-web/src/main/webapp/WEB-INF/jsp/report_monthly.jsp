<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<style type="text/css" media="all">
    @import "<c:url value='/stylesheets/report.css'/>";
</style>

<title><c:out value="${report.name}" /></title>
</head>

<body>

<h1><c:out value="${report.name}" /></h1>

<table class="report">
  <colgroup>
    <col style="title" />
    <col style="value" span="12" />
    <col style="total" />
  </colgroup>
  <thead>
    <tr>
      <th>Detail</th>
      <th>Jan</th>
      <th>Feb</th>
      <th>Mar</th>
      <th>Apr</th>
      <th>May</th>
      <th>Jun</th>
      <th>Jul</th>
      <th>Aug</th>
      <th>Sep</th>
      <th>Oct</th>
      <th>Nov</th>
      <th>Dec</th>
      <th>Total</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${report.headerLines}" var="hdr">
      <tr class="headerLine">
        <td colspan="14"><c:out value="${hdr.name}" /></td>
      </tr>
      <c:forEach items="${hdr.details}" var="dtl">
        <tr class="detailLine">
          <td><c:out value="${dtl.name}" /></td>
          <c:forEach items="${dtl.monthlyValues}" var="val">
            <td><c:out value="${val}" /></td>
          </c:forEach>
          <td><c:out value="${dtl.yearlyValue}" /></td>
        </tr>
        <tr class="headerLine">
          <td colspan="14"></td>
        </tr>
      </c:forEach>

    </c:forEach>
  </tbody>
</table>
<br />
<form name="actionForm"><input type="hidden" name="template" value="<c:out value="${template.name}" />" />
<table>
  <thead>
    <tr>
      <td colspan="2">Change Report Parameters</td>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${template.parameterNames}" var="name" varStatus="status">
      <tr>
        <td><c:out value="${name}" /><input type="hidden" name="parameterName"
          value="<c:out value="${name}"/>" /></td>
        <td><input type="text" name="parameterValue"
          value="<c:out value="${report.parameterValues[status.index]}"/>" /></td>
      </tr>
    </c:forEach>
    <tr>
      <td colspan="2">
      <button type="submit">Submit</button>
      </td>
    </tr>
    <tr>
      <td colspan="2"><input type="hidden" name="format" />
      <button type="submit" onclick="this.form.format.value='csv'; this.form.action='<c:url value="viewReport.csv"/>'">Export to CSV</button>
      </td>
    </tr>
  </tbody>

</table>
</form>
</body>
</html>
