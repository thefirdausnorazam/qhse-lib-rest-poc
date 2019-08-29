<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>enviroHEALTH</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <style type="text/css">
  .enviro {
    color: #999999;
    font-size: 2em;
    font-weight: bold;
  }
  .module {
    color: #13AB94;
    font-size: 2em;
    font-weight: bold;
  }
  </style>
  <script type="text/javascript">
  <!--
  function onPageLoad() {
    $('healthTestQueryForm').onsubmit();
    changeTitle();
  }
  function changeTitle() {
    if ($('healthTestQueryResult.title')) {
      $('healthTestQueryResult.title').innerHTML = '<fmt:message key="healthTestQueryResult.dueSearchResults" />';
    } else {
      setTimeout("changeTitle();", 400);
    }
  }
  // -->
  </script>

</head>

<body onload="onPageLoad();">

<br />
<form id="healthTestQueryForm" action="<c:url value="/health/testQueryResult.htmf" />" onsubmit="return search(this, 'resultsDiv', true);">
	<input type="hidden" name="calculateTotals" value="false" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize"/>
	<input type="hidden" name="sortName" value="timePeriod" />
	<input type="hidden" name="retestDateFrom" value="<fmt:formatDate value="${retestDateFrom}" pattern="dd-MMM-yyyy" />" />
	<input type="hidden" name="retestDateTo" value="<fmt:formatDate value="${retestDateTo}" pattern="dd-MMM-yyyy" />" />

	<div id="resultsDiv"></div>
</form>

</body>
</html>
