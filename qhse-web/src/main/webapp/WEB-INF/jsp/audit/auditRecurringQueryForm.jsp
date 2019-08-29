<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
	<script type="text/javascript">	
	jQuery(document).ready(function() {
		jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({width:'100%'});
	});
		
	function hardResetForm(form) {
		    var inputs = form.getElementsByTagName('input');
		    for (var i = 0; i<inputs.length; i++) {
		        switch (inputs[i].type) {
		          case 'text':
		                inputs[i].value = '';
		                break;
		        }
		    }
		jQuery('#planId').select2('val', '');
		jQuery('#programmeId').select2('val', '');
		jQuery('#programmeTypeId').select2('val', '');
		jQuery('#auditorId').select2('val', '');
		jQuery('#userAuditeeId').select2('val', '');
		jQuery('#thirdPartyAuditeeId').select2('val', '');
		jQuery('#departmentId').select2('val', '');
		jQuery('#completed').select2('val', '');
		jQuery('#sortName').select2('val', '');
		jQuery('#workAreaId').select2('val', '');
		jQuery('#locationId').select2('val', '');
		jQuery('#observerId').select2('val', '');
		jQuery('#businessAreaId').select2('val', '');
	}
	
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/audit/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/auditRecurringQuery.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/auditRecurringQuery.htmf');
	}
	
	function trimDescription(){
		jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  	}
	
	</script>
	
</head>
<body>

	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
						<input type="text" id="refreshCheck" value="no"
							style="display: none;">
						<form id="goToForm" action="<c:url value="/audit/recurringAuditView.htm" />" method="get"	onSubmit="if(!jQuery('#gotoId')) return false;">
						 <input type="hidden" name="page" value="recurringAudit"/>
		        			<c:if test="${showLegacyId}">
		        			<label>Legacy ID</label> 
		        			<input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
							</c:if>
							<fmt:message key="audit.auditRecurringQueryForm.goTo" />
							<input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Hide Search</button>
							<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print printcolor" style="color:white"></i><span class="printcolor"></span></button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<scannell:form id="queryForm" action="/audit/auditRecurringQuery.htmf" onsubmit="return searchExcelCheck(this, 'resultsDiv');">
	<input type="hidden" id="calculateTotals" name="calculateTotals" value="true">
	<scannell:hidden path="pageNumber" />
	<scannell:hidden path="pageSize" />	
		<div class="content" id ="queryTable">
			<div class="header">
				<h3><fmt:message key="searchCriteria" /></h3>
			</div>
			                <div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="businessArea" /></label>
								<div class="col-sm-6">
									 <select name="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id"  />
								</div>
							</div>
	                         <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditPlan" /></label>
									<div class="col-sm-6">
										<select name="planId" id="planId" items="${planList}" itemValue="id" itemLabel="displayName" class="wide" />
									</div>
								</div>
	                         <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditProgramme" /></label>
									<div class="col-sm-6">
										<select name="programmeId" id="programmeId" items="${programmeList}" itemValue="id" itemLabel="description" class="wide" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="programmeType" /></label>
									<div class="col-sm-6">
										<select name="programmeTypeId" id="programmeTypeId" items="${programmeTypeList}" itemValue="id" itemLabel="name" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="auditor" /></label>
									<div class="col-sm-6">
										<select name="auditorId" id="auditorId" items="${auditors}" itemValue="id" itemLabel="sortableName" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee" /> (<fmt:message key="auditeeType[u]" />)</label>
									<div class="col-sm-6">
										<select name="userAuditeeId" id="userAuditeeId" items="${userAuditees}" itemValue="id" itemLabel="sortableName" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee" /> (<fmt:message key="auditeeType[t]" />):</label>
									<div class="col-sm-6">
										<select name="thirdPartyAuditeeId" id="thirdPartyAuditeeId" items="${thirdPartyAuditees}" itemValue="id" itemLabel="name" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee.department" /></label>
									<div class="col-sm-6">
										<select name="departmentId" id="departmentId" items="${departments}" itemValue="id" itemLabel="name" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="fromDate" name="startDateFrom" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="toDate" name="startDateTo" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="name" /></label>
									<div class="col-sm-6">
										<scannell:input id="name" path="name" class="form-control" cssStyle="width:100%"/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">
										 <scannell:select id="sortName" path="sortName" items="${sortList}" lookupItemLabel="true" renderEmptyOption="true" class="wide" />
									</div>
								</div>
								
								<div class="spacer2 text-center">
			                     	<button type="submit" class="g-btn g-btn--primary" onClick="resetExcelRequest();this.form.pageNumber.value = 1;displayQueryTable(false);trimDescription();" ><fmt:message key="search" /></button>
			                     	<button id="resetAll" class="g-btn g-btn--secondary" onclick="resetExcelRequest();hardResetForm(this.form);"><fmt:message key="reset" /></button>
			                     	<c:if test="${createExcel == true}">
      									<button type="submit" class="g-btn g-btn--primary" onClick="excelRequest();this.form.pageNumber.value = 1;displayQueryTable(false)"><fmt:message key="exportToExcel" /></button>
      								</c:if>
      								<input type="hidden" id="excel" name="excel" value="NO" />
			                  </div>
			                  
			                  
			                  
		</div>	
		<div id="resultsDiv"></div>                  
</scannell:form>

<script type="text/javascript">
toggleQueryTable();
</script>
</body>
</html>
