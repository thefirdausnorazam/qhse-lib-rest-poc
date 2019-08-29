<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="questionOptionQueryForm" /></title>

<script type="text/javascript" src="<c:url value="/js/prototype.js" />" ></script>
<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script>

</head>
<body onload="$('queryForm').onsubmit();">

<scannell:url urls="${urls}" />

<form id="queryForm" action="<c:url value="/system/questionOptionQueryResult.htmf" />" onSubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />

<table class="viewForm" >
<thead>
  <tr>
    <td colspan="4">
      <fmt:message key="searchCriteria" />
    </td>
  </tr>
</thead>
<tbody id="searchCriteria">
  <tr>
    <td><label for="name"><fmt:message key="name" /></label>:</td>
    <td colspan="3"><input type="text" id="name" name="name" class="wide"/>
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

<div id="resultsDiv"></div>

</form>
</body>
</html>
