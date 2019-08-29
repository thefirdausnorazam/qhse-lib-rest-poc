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
  
  <title><fmt:message key="standardSearchCr" /></title>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {
  
    jQuery('#generalQueryForm').submit();
    jQuery("select").select2();
    
    displayQueryDiv(false);
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
  function submitSearch() {
	  
	  jQuery('#createdUserId').val(jQuery('#responsibleUserSelect').val());
	  jQuery('#name').val(jQuery('#name').val());
	  
	  
	  jQuery('#generalQueryForm').submit();
	 
  }
  function clearFormFields() {
	  jQuery('#nameCriteria').val('');
	  jQuery('#name').val('');
	  jQuery('#responsibleUserSelect').val('');
	  jQuery('#createdUserId').val('');
	  jQuery("#responsibleUserSelect").select2().select2('val',
				jQuery('#responsibleUserSelect option:eq(0)').val());
  }
  function deleteSearchCriteria(value) {
	  jQuery('#deleteId').val(value);
	  jQuery('#generalQueryForm').submit();
  }
  </script>
</head>
<body onload="onPageLoad();">
<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Display
							Search</button>
						<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					
					</div>
				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
	</div>
 <input type="hidden" id="formName" name="formName" value="all">
 <br>
<div class="noprint">
<font style="color: #666699"><fmt:message key="pleaseGoTo" /></font>
</div>
<scannell:form id="generalQueryForm" action="/enviro/savedSearchCriteriaResult.ajax" onsubmit=" return search(this, 'resultsDiv');">
	
	<input type="hidden" name="pageNumber" id="pageNumber" value="1" />
		<scannell:hidden path="pageSize" />
		 <input type="hidden" name="deleteId" id="deleteId" value="" />
		 <input type="hidden" name="pageNumber2" id="pageNumber2" value="1" />
 <div id="queryDiv">
 	<div class="header">
		<h3>
			<fmt:message key="searchCriteria" />
		</h3>
	</div>
 	<div class="content">
		<div class="table-responsive">
			<div class="panel hidden-print" id="queryTablePanel">
				<table id="queryTable" class="table table-bordered table-responsive">
				<tbody id="searchCriteria">
				  <tr class="form-group">
				    <td class="searchLabel" id="type" style="width:20%"><fmt:message key="name" />:</td>
				    <td colspan="3" class="search">
				    <input name="name" id="name" cssStyle="width:60%" class="form-control" maxlength="245" alt="env"/>
				    </td>
				  </tr>
				
				  <tr class="form-group">
					<td id="createdByUserLabel" class="searchLabel">
				  			<fmt:message key="createdBy" />:
				  	</td>
				  	<td class="search" colspan="3">
				    	<select name="createdUserId" class="wide" style="width: 300px" id="responsibleUserSelect" onchange="updateCreatorResponsibleUser(this)" >
				        	<option value="">Choose</option>
				        	<c:forEach items="${userList}" var="item">
				          		<option value="<c:out value="${item.id}" />" ${item.id == currentUser ? 'selected' : '' }><c:out value="${item.sortableName}" /></option>
				        	</c:forEach>
				      	</select>
				  	</td>
				 </tr>
				  
				</tbody>
				<tfoot>
				  <tr>
				    <td colspan="4" style="text-align: center">
				    	<div class="spacer2 text-center">
					      <button type="button" class="g-btn g-btn--primary" onClick="submitSearch();displayQueryDiv(false);" ><fmt:message key="search" /></button>
					      <button type="button" class="g-btn g-btn--secondary" onClick="clearFormFields();"><fmt:message key="reset" /></button>
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

<form id="queryForm" action="<c:url value="/enviro/savedSearchCriteriaResult.htmf" />" onSubmit="return search(this, 'savedSearchCriteriaResultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />
  <!-- <input type="hidden" name="businessAreaId" value="<c:out value="${businessArea.id}"/>" /> -->
  <input type="hidden" name="status" value="<%=com.scannellsolutions.modules.risk.domain.RiskStatus.IN_PROGRESS.getName()%>" />
  
  <input type="hidden" name="workspaceView" value="true" />
  <input type="hidden" name="deleteId" id="deleteId" value="" />
  <div id="savedSearchCriteriaResultsDiv"></div>
</form>


</body>
</html>
