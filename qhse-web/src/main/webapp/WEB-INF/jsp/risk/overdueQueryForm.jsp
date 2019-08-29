<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html">
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
    <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery('#objectiveQueryForm').submit();
			jQuery('#targetQueryForm').submit();
			jQuery('#mpQueryForm').submit();
			jQuery('#taskQueryForm').submit();
		});
	</script>
</head>
<!-- <body onload="jQuery('objectiveQueryForm').submit();jQuery('#targetQueryForm').submit();jQuery('#mpQueryForm').submit();jQuery('#taskQueryForm').submit();"> -->
<body>
    <common:moveSite recordType="assessment"/>
	<form name="objectiveQueryForm" id="objectiveQueryForm" action="<c:url value="/risk/objectiveQueryResult.ajax" />" onSubmit="return search(this, 'objectiveResultsDiv');">
		<input type="hidden" name="calculateTotals" value="false" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" name="pageSize" value="0"/>
		<input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" />
		<input type="hidden" name="overdue" value="true" />
		<input type="hidden" name="overdueSearch" value="true" />
		<input type="hidden" name="workspaceView" value="true" />
		<div id="objectiveResultsDiv"></div>
	</form>


	<form id="targetQueryForm" action="<c:url value="/risk/targetQueryResult.ajax" />" onSubmit="return search(this, 'targetResultsDiv');">
		<input type="hidden" name="calculateTotals" value="false" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" name="pageSize" value="0"/>
		<input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" />
		<input type="hidden" name="overdue" value="true" />
		<input type="hidden" name="workspaceView" value="true" />
		<div id="targetResultsDiv"></div>
	</form>

	<form id="mpQueryForm" action="<c:url value="/risk/managementProgrammeQueryResult.ajax" />" onSubmit="return search(this, 'mpResultsDiv');">
		<input type="hidden" name="calculateTotals" value="false" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" name="pageSize" value="0"/>
		<input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" />
		<input type="hidden" name="overdue" value="true" />
		<input type="hidden" name="overdueSearch" value="true" />
		<input type="hidden" name="workspaceView" value="true" />
		<div id="mpResultsDiv"></div>
	</form>

	<form id="taskQueryForm" action="<c:url value="/risk/taskQueryResult.ajax" />" onSubmit="return search(this, 'taskResultsDiv');">
		<input type="hidden" name="calculateTotals" value="false" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" name="pageSize" value="0"/>
		<input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" />
		<input type="hidden" name="overdue" value="true" />
		<input type="hidden" name="overdueSearch" value="true" />
		<input type="hidden" name="workspaceView" value="true" />
		<input type="hidden" name="sortName" value="id" />
		<div id="taskResultsDiv"></div>
	</form>
</body>
</html>
