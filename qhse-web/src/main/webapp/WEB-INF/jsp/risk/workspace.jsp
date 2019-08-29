<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <!-- <title></title> -->
  <style>
  	tfoot tr {
  		border: 1px solid #ddd  !important;
  	}
  </style>
    <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
  <script type="text/javascript">
  jQuery(document).ready(function(){
	  jQuery('#assessmentResultsDiv').html('');
	  jQuery('#targetResultsDiv').html('');
	  jQuery('#mpResultsDiv').html('');
	  jQuery('#taskResultsDiv').html('');
	  jQuery('#assessmentQueryForm').submit();
	  jQuery('#targetQueryForm').submit();
	  jQuery('#mpQueryForm').submit();
	  jQuery('#taskQueryForm').submit();	 
  });  
  function searchAsessment(form, targetElementId, scrollToResults) {	
		if (scrollToResults) {
			scrollToResultDiv = true;
		}		
		jQuery('#'+targetElementId).html('<table class="table table-bordered table-responsive"><thead><tr><th>Loading data...</th></tr></thead></table>');		
		jQuery.ajax({
			   url:  jQuery(form).attr('action'),
			   type: "post",
			   dataType: "html",
			   cache: false,
			   data:jQuery(form).serialize(form),
			   success: function(returnData){			  
				   jQuery('#'+targetElementId).html(returnData);
			   },			   
			   error: function(e){
			     alert('Error : '+e);
			   }
			});	
		scrollToResultDiv = true;
		return false;
	}
  </script>
</head>
<body >
    <common:moveSite recordType="assessment"/>

<form id="assessmentQueryForm" action="<c:url value="/risk/assessmentQueryResult.ajax" />" onSubmit="return searchAsessment(this, 'assessmentResultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="0" />
  <input type="hidden" name="pageSize" value="0" />
  <%-- <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /><c:out value="${businessArea.id}"/> --%>
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  <input type="hidden" name="approvalByUser" value="<c:out value="${currentUser.id}"/>" />
  <input type="hidden" name="workspaceView" value="true" />
  <input type="hidden" name="sortName" value="id" />
  <div id="assessmentResultsDiv"></div>
  
</form>

<form id="targetQueryForm" action="<c:url value="/risk/targetQueryResult.ajax" />" onSubmit="return search(this, 'targetResultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="0" />
  <input type="hidden" name="pageSize" value="0" />
<%--   <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /> --%>
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  <input type="hidden" name="responsibleUser" value="<c:out value="${currentUser.id}"/>" />
  <input type="hidden" name="workspaceView" value="true" />
 <!--  <input type="hidden" name="chronologicalOrder" value="true" /> -->
  <input type="hidden" name="sortName" value="id" />
  <div id="targetResultsDiv"></div>
</form>

<form id="mpQueryForm" action="<c:url value="/risk/managementProgrammeQueryResult.ajax" />" onSubmit="return search(this, 'mpResultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="0" />
  <input type="hidden" name="pageSize" value="0" />
<%--   <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /> --%>
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  <input type="hidden" name="responsibleUser" value="<c:out value="${currentUser.id}"/>" />
    <input type="hidden" name="workspaceView" value="true" />
    <!-- <input type="hidden" name="chronologicalOrder" value="true" /> -->
  <input type="hidden" name="sortName" value="id" />
  <div id="mpResultsDiv"></div>
</form>

<form id="taskQueryForm" action="<c:url value="/risk/taskQueryResult.ajax" />" onSubmit="return search(this, 'taskResultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="0" />
  <input type="hidden" name="pageSize" value="0" />
<%--   <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /> --%>
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  <input type="hidden" name="responsibleUser" value="<c:out value="${currentUser.id}"/>" />
  <input type="hidden" name="workspaceView" value="true" />
  <!-- <input type="hidden" name="chronologicalOrder" value="true" /> -->
   <input type="hidden" name="sortName" value="id" />
  <div id="taskResultsDiv"></div>
</form>

</body>
</html>
