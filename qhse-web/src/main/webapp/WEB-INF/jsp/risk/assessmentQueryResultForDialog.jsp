<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="assessmentQueryResult.title" /></title>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>   
  <script type="text/javascript"> 
  jQuery(document).ready(function() {
  	jQuery('#queryForm').submit();
  	
  	jQuery('#pageNumber').val('');
  	jQuery('#pageSize').val('');
  });
  
 </script>
</head>
<body>
<scannell:form id="queryForm" action="/risk/assessmentQueryResult.htmf"
		onsubmit="return searchExcelCheck(this, 'resultsDiv');">
		<input type="hidden" name="calculateTotals" value="true"/>
		<input type="hidden" name="pageNumber" value="${pageNumber }"/>
		<input type="hidden" name="pageSize" value="${pageSize }"/>
		<input type="hidden" name="status" value="COMPLETE" />
		<input type="hidden" name="workspaceView" value="false" />
		<input type="hidden" name="hazardAnswers[21]" value="${answers21}" />
        <input type="hidden" name="hazardAnswers[46]" value="${answers46}" />
        <input type="hidden" name="hazardAnswers[39]" value="${answers39}" />
        <input type="hidden" name="jobHazardAnswers[300287]" value="${answers300287}" />
        <input type="hidden" name="jobHazardAnswers[300295]" value="${answers300295}" />
		<input type="hidden" name="answerUnion" value="true" />
		<input type="hidden" name="hazardQuery" value="true" />
		<input type="hidden" id="excel" name="excel" value="NO" />
<div id="searchCriteriaDiv"></div>
<div id="resultsDiv">		 
		
</div>
</scannell:form>
</body>
</html>
