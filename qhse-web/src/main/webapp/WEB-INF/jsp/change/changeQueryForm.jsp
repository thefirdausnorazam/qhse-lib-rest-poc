<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<title><fmt:message key="changeAssessmentQueryForm" /></title>

	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		displayQueryDiv(false);
		if('${selectedStatus}' != '')
		{
			var status = '${selectedStatus}';
			if(status) {
				hardResetForm(document.getElementById('queryForm'));
				jQuery("#status").val(status).trigger('change');
			}
		}
		jQuery('#queryForm').submit();
		jQuery('#programmeId').select2({width:'100%'});
		jQuery('#businessAreaId').select2({width:'100%'});
		jQuery('#programmeTypeId').select2({width:'100%'});
		jQuery('#initiatorId').select2({width:'100%'});
		jQuery('#reviewerId').select2({width:'100%'});
		jQuery('#ownerId').select2({width:'100%'});
		jQuery('#technicalCloseout').select2({width:'50%'});
		jQuery('#status').select2({width:'50%'});
		jQuery('#reviewed').select2({width:'20%'});
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
		jQuery('#programmeId').select2('val', '');
		jQuery('#programmeTypeId').select2('val', '');
		jQuery('#initiatorId').select2('val', '');
		jQuery('#reviewerId').select2('val', '');
		jQuery('#ownerId').select2('val', '');
		jQuery('#technicalCloseout').select2('val', '');
		jQuery('#status').select2('val', '');
		jQuery('#reviewed').select2('val', '');
		jQuery('#businessAreaId').select2('val', '');
	}
		function trimDescription(){
			jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
	  	}

	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
</head>
<body >

<div class="col-md-12">
		<div id="block" class="">
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form action="<c:url value="/change/changeAssessmentView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
						Go to Change Assessment ID
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
									&nbsp;
									<fmt:message key="search.displaySearch" />
								</button>
						<c:forEach items="${urls }" var="url">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='${url.url}'">
								<i class="fa fa-edit" style="color: white"></i>&nbsp;${url.name }
							</button>
						</c:forEach>
						<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
					</div>
				</div>
		</div>
	</div>

<scannell:form id="queryForm" action="/change/changeQuery.htmf" onsubmit="return search(this, 'resultsDiv');">
	<input type="hidden" name="calculateTotals" id="calculateTotals" value="true"/>
	<scannell:hidden path="pageNumber" />
	<scannell:hidden path="pageSize" />
		<div class="content" id ="queryTable">
			<div class="header">
				<h3><fmt:message key="searchCriteria" /></h3>
			</div>

					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="changeName" />:</label>
						<div class="col-sm-6">
							 <input name="name" id="name" class="form-control" />
						</div>
					</div>	
	                <div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="businessArea" /></label>
						<div class="col-sm-6">
							 <select name="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id"  />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="changeProgramme" />:</label>
						<div class="col-sm-6">
							<scannell:select id="programmeId" path="programmeId" items="${programmeList}" itemValue="id" itemLabel="description" class="wide" />
						</div>
					</div>
				
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="programmeTypeIdLabel"><fmt:message key="changeProgrammeType" />:</label>
						<div class="col-sm-6">
							<scannell:select id="programmeTypeId" path="programmeTypeId" items="${programmeTypeList}" itemValue="id" itemLabel="name" class="wide" />
						</div>
					</div>
				
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="initiatorLabel"><fmt:message key="changeAssessment.initiator" />:</label>
						<div class="col-sm-6">
							<scannell:select id="initiatorId" path="initiatorId" items="${initiators}" itemValue="id" itemLabel="sortableName" class="wide" />
						</div>
					</div>
				
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="reviewerLabel"><fmt:message key="changeAssessment.reviewer" /> :</label>
						<div class="col-sm-6">
							<scannell:select id="reviewerId" path="reviewerId" items="${reviewers}" itemValue="id" itemLabel="sortableName" class="wide" />
						</div>
					</div>
				
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="ownerLabel"><fmt:message key="changeAssessment.owner" /> :</label>
						<div class="col-sm-6">
							<scannell:select id="ownerId" path="ownerId" items="${owners}" itemValue="id" itemLabel="sortableName" class="wide" />
						</div>
					</div>
				
					<div class="form-group">
						<%-- <label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="technicalCloseoutLabel"><fmt:message key="changeAssessment.technicalcloseout" />:</label>
						<div class="col-sm-6">
							<select name="technicalCloseout" id="technicalCloseout" class="narrow">
								<scannell:option value="true" labelkey="true" />
								<scannell:option value="false" labelkey="false" />
							</scannell:select>
						</div> --%>
						
				    	  <label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="statusLabel"><fmt:message key="assessment.status" />:</label>
				    	  <div class="col-sm-6">
				          <select name="changeStatus" id="status" renderEmptyOption="true" class="wide" >
				            <scannell:option value="IN_PROGR" labelkey="changeAssessmentChangeStatus[IN_PROGR]" />
				           <%--  <scannell:option value="COMPLETE" labelkey="changeAssessmentChangeStatus[COMPLETE]" /> --%>
				            <scannell:option value="TRASH"    labelkey="changeAssessmentChangeStatus[TRASH]" />
				            <scannell:option value="APPROVED"    labelkey="changeAssessmentChangeStatus[APPROVED]" />
				            <scannell:option value="DISAPPRO"    labelkey="changeAssessmentChangeStatus[DISAPPRO]" />
				          </scannell:select>
				    	 </div>
					</div>
					<div class="form-group">
							<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
							<div class="col-sm-6">
								<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                      <input class="form-control" size="16" id="createDateFrom" name="createDateFrom" type="text"  readonly>
                                      <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                      </div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
							<div class="col-sm-6">
								<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                      <input class="form-control" size="16" id="createDateTo" name="createDateTo" type="text"  readonly>
                                      <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                      </div>
							</div>
						</div>
					
				  	<div class="form-group">
					    <label class="col-sm-3 control-label scannellGeneralLabel nowrap"  id="reviewedLabel"><fmt:message key="reviewed" />:</label>
					    <div class="col-sm-6">
						      <select name="reviewed" id="reviewed" renderEmptyOption="true" class="narrow">
								<scannell:option value="true" labelkey="true" />
								<scannell:option value="false" labelkey="false" />
						      </scannell:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="assessment.reviewedFromStartDate" /></label>
						<div class="col-sm-6">
							<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                     <input class="form-control" size="16" id="reviewStartDateFrom" name="reviewStartDateFrom" type="text"  readonly>
                                     <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                     </div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>
						<div class="col-sm-6">
							<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                     <input class="form-control" size="16" id="reviewStartDateTo" name="reviewStartDateTo" type="text"  readonly>
                                     <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                     </div>
						</div>
					</div>
				      
				
					<div class="spacer2 text-center">
						<button type="submit" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();" class="g-btn g-btn--primary"><fmt:message key="search" /></button>
						<button type="reset" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);"><fmt:message key="reset" /></button>
					</div>
				</div>
		<div id="resultsDiv"></div>                  
</scannell:form>

<script type="text/javascript">
toggleQueryTable();
</script>
</body>
</html>
