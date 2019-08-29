<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import = "com.scannellsolutions.users.User"
import = "com.scannellsolutions.modules.incident.domain.IncidentRoles"
import = "com.scannellsolutions.modules.action.domain.ActionRoles"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  
  <title><fmt:message key="userAccessCreateReport"/></title>
  <style>
.floating-box {
    display: inline-block;
    
    margin: 10px;  
}

.color-red {
    color: red; 
}
</style>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {
  
   jQuery('#generalQueryForm').submit();
    jQuery("select").select2();
    
    //displayQueryDiv(false);
  });
  function onPageLoad() {
	 
  }
  
  function updateCreatorResponsibleUser(obj) {
	  jQuery('#approvalByUser').val(obj.value);
	  jQuery('#assignees').val(obj.value);
	  
	  for(i = 1; i < 6; i++) {
		  jQuery('#responsibleUser' + i).val(obj.value);
	  }
  }
  function submitSave() {
	  jQuery("#submit-button").attr("disabled", "disabled");
	  if(jQuery('#delay').val().trim() == ""){
		  alert("Frequency is mandatory");
		  jQuery("#submit-button").prop( "disabled", false);
		 return false;
	  }
	  if(jQuery('#reportType').val().trim() == ""){
			 alert("Report Type is mandatory");
			 jQuery("#submit-button").prop( "disabled", false);
			 return false;
		  }
	  if(jQuery('#receiver2').val().trim() == ""  || validEmail(jQuery('#receiver2').val()) == false){
			 alert("Email is mandatory");
			 jQuery("#submit-button").prop( "disabled", false);
			 return false;
		  }
	  
	  jQuery('#createUserLoginAccessReport').val("save");
	  jQuery('#generalQueryForm').submit();
	  setTimeout(function (){clearFormFields();}, 1000);
	 
  }
  function clearFormFields() {
	  jQuery(".checkbox-module").each(function (){
		  jQuery(this).prop('checked', false);
	  });
	  jQuery('#delay').select2().select2('val',jQuery('#delay option:eq(0)').val());
	  jQuery('#reportType').select2().select2('val',jQuery('#reportType option:eq(0)').val());
	  //jQuery('#receiver1').val('');
	  jQuery("#receiver2").val('');
	  jQuery("#submit-button").prop( "disabled", false);
  }
  function deleteSearchCriteria(value) {
	  jQuery('#deleteId').val(value);
	  jQuery('#generalQueryForm').submit();
  }
  function validEmail(v) {
	    var r = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	    return (v.match(r) == null) ? false : true;
	}
  </script>
</head>
<body onload="onPageLoad();">
<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12" >
					
				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
	</div>
 <input type="hidden" id="formName" name="formName" value="all">
 <br>
<div class="noprint">
<font style="color: #666699"></font>
</div>
<scannell:form id="generalQueryForm" action="/enviro/userAccessCreateReportResult.ajax" onsubmit=" return search(this, 'resultsDiv');">
	
	<input type="hidden" name="pageNumber" id="pageNumber" value="1" />
		<scannell:hidden path="pageSize" />
		 <input type="hidden" name="deleteId" id="deleteId" value="" />
		 <input type="hidden" name="pageNumber2" id="pageNumber2" value="1" />
		 <input type="hidden" name="createUserLoginAccessReport" id="createUserLoginAccessReport" value="" />
 <div id="queryDiv">
 	<div class="header">
		<h3>
			
		</h3>
	</div>
 	<div class="content">
		<div class="table-responsive">
			<div class="panel hidden-print" id="queryTablePanel">
				<table id="queryTable" class="table table-bordered table-responsive">
				<tbody id="searchCriteria">
				  <tr class="form-group">
					<td  class="searchLabel">
				  			<fmt:message key="frequency" />:
				  	</td>
				  	<td class="search" colspan="3">
				    	<select name="delay" id="delay" class="wide" style="width: 300px"  >
				        	<option value="">Choose</option>
				        	<option value="monthly">Monthly</option>
				        	
				      	</select>
				      	<div class="floating-box"><font class="color-red">*</font></div>
				  	</td>
				 </tr>
				 <tr class="form-group">
					<td  class="searchLabel">
				  			<fmt:message key="reportType" />:
				  	</td>
				  	<td class="search" colspan="3">
				    	<select name="reportType" id="reportType" class="wide" style="width: 300px"  >
				        	<option value="">Choose</option>
				        	<option value="login">Login</option>
				      	</select>
				      	<div class="floating-box"><font class="color-red">*</font></div>
				  	</td>
				 </tr>
				 <tr class="form-group">
				    <td class="searchLabel"  style="width:20%"><fmt:message key="scannellRecipient" />:</td>
				    <td colspan="3" class="search">
				    	<input type="text" name="receiver1" id="receiver1" style="width:60%" value="${scannellRecipient }" readonly="readonly" class="form-control" maxlength="245">
				    </td>
				  </tr>
				  <tr class="form-group">
				    <td class="searchLabel"  style="width:20%"><fmt:message key="recipient2" />:</td>
				    <td colspan="3" class="search">
				    	<input type="text" name="receiver2" id="receiver2" style="width:60%" class="form-control" maxlength="245"><span class="floating-box"><font class="color-red">*</font></span>
				    	
				    </td>
				  </tr>
				
				  
				</tbody>
				<tfoot>
				  <tr>
				    <td colspan="4" style="text-align: center">
				    	<div class="spacer2 text-center">
					      <button type="button" id="submit-button" class="g-btn g-btn--primary" onClick="submitSave();" ><fmt:message key="save" /></button>
					      
					    </div>
				    </td>
				  </tr>
				</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
<div id="resultsDiv"></div>
</scannell:form> 

<form id="queryForm" action="<c:url value="/enviro/userAccessCreateReportResult.htmf" />" onSubmit="return search(this, 'userAccessCreateReportResultDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />
  <!-- <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /> -->
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  
  <input type="hidden" name="workspaceView" value="true" />
  <input type="hidden" name="deleteId" id="deleteId" value="" />
  <div id="userAccessCreateReportResultDiv"></div>
</form>


</body>
</html>
