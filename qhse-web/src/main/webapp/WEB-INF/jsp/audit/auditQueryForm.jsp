<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
  	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
    <c:set value="500" var="maxListSize"/>
	<script type="text/javascript">	
	jQuery(document).ready(function() {
		jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		if('${quickLink}' != '') {
			hardResetForm(document.getElementById('queryForm'));
			var selectedStatus = '${selectedStatus}';
			if(selectedStatus) {
				jQuery("#status").val(selectedStatus).trigger('change');
			}
			var selectDepartment = '${selectedDepartment}';
			if(selectDepartment) {
				jQuery("#departmentId").val(selectDepartment).trigger('change');
			}
		}
		//createdById
		var createdByName='<c:out value="${command.createdByName}"/>';
		var createdById= '<c:out value="${command.createdById}"/>';
		if(createdById != null && createdByName != ""){
			jQuery('#createdById').val(createdById);
		}
		showUserList(${fn:length(auditors)}, "createdById", "100", "auditorList.json", createdById, createdByName);
		//auditorId
		var auditorName='<c:out value="${command.auditorName}"/>';
		var auditorId= '<c:out value="${command.auditorId}"/>';
		if(auditorId != null && auditorName != ""){
			jQuery('#auditorId').val(auditorId);
		}
		showUserList(${fn:length(auditors)}, "auditorId", "100", "auditorList.json", auditorId, auditorName);
		
		//userAuditeeId
		var userAuditeeName='<c:out value="${command.userAuditeeName}"/>';
		var userAuditeeId= '<c:out value="${command.userAuditeeId}"/>';
		if(userAuditeeId != null && userAuditeeName != ""){
			jQuery('#userAuditeeId').val(userAuditeeId);
		}
		showUserList(${fn:length(userAuditees)}, "userAuditeeId", "100", "auditeeList.json", userAuditeeId, userAuditeeName);
		
		//observerId
		var observerName='<c:out value="${command.observerName}"/>';
		var observerId= '<c:out value="${command.observerId}"/>';
		if(observerId != null && observerName != ""){
			jQuery('#observerId').val(observerId);
		}
		showUserList(${fn:length(allUsers)}, "observerId", "100", "allUserList.json", observerId, observerName);

		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').not('#observerId').not('#userAuditeeId').not('#auditorId').not('#createdById').select2({width:'100%'});
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
		jQuery('#status').select2('val', '');
    	jQuery('#status option[value=""]').attr('selected','selected');
		jQuery('#overdue').attr('checked', false);
		jQuery('#createdById').val('');
		jQuery('#createdById').select2('val', '');
    	jQuery('#createdById option[value=""]').attr('selected','selected');
		jQuery('#planId').select2('val', '');
    	jQuery('#planId option[value=""]').attr('selected','selected');
		jQuery('#programmeId').select2('val', '');
    	jQuery('#programmeId option[value=""]').attr('selected','selected');
		jQuery('#programmeTypeId').select2('val', '');
    	jQuery('#programmeTypeId option[value=""]').attr('selected','selected');
		jQuery('#auditorId').val('');
		jQuery('#auditorId').select2('val', '');
    	jQuery('#auditorId option[value=""]').attr('selected','selected');
		jQuery('#userAuditeeId').val('');
		jQuery('#userAuditeeId').select2('val', '');
    	jQuery('#userAuditeeId option[value=""]').attr('selected','selected');
		jQuery('#thirdPartyAuditeeId').select2('val', '');
    	jQuery('#thirdPartyAuditeeId option[value=""]').attr('selected','selected');
		jQuery('#departmentId').select2('val', '');
    	jQuery('#departmentId option[value=""]').attr('selected','selected');
		jQuery('#completed').select2('val', '');
    	jQuery('#completed option[value=""]').attr('selected','selected');
		jQuery('#sortName').select2('val', '');
    	jQuery('#sortName option[value=""]').attr('selected','selected');
		jQuery('#workAreaId').select2('val', '');
    	jQuery('#workAreaId option[value=""]').attr('selected','selected');
		jQuery('#locationId').select2('val', '');
    	jQuery('#locationId option[value=""]').attr('selected','selected');
		jQuery('#observerId').val('');
		jQuery('#observerId').select2('val', '');
    	jQuery('#observerId option[value=""]').attr('selected','selected');
		jQuery('#businessAreaId').select2('val', '');
    	jQuery('#businessAreaId option[value=""]').attr('selected','selected');
	}
	
	function setSearchNames() {
		//createdById
		if(jQuery('#createdById').val() != "")
			jQuery("#createdByName").val(jQuery('#createdById').select2("data").text);
		//auditorId
		if(jQuery('#auditorId').val() != "")
			jQuery("#auditorName").val(jQuery('#auditorId').select2("data").text);
		//userAuditeeId
		if(jQuery('#userAuditeeId').val() != "")
			jQuery("#userAuditeeName").val(jQuery('#userAuditeeId').select2("data").text);
		//observerId
		if(jQuery('#observerId').val() != "")
			jQuery("#observerName").val(jQuery('#observerId').select2("data").text);
	}
	
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/audit/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/auditQuery.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/auditQuery.htmf');
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
						<form id="goToForm" action="<c:url value="/audit/auditView.htm" />" method="get"	onSubmit="if(!jQuery('#gotoId')) return false;">
							<input type="hidden" name="page" value="audit"/>
						    <c:if test="${showLegacyId}">
						    <label>Legacy ID</label> 
                            <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
							</c:if>
							<fmt:message key="audit.auditQueryForm.goTo" />
							<input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Hide Search</button>
							<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print printcolor" style="color:white"></i><span class="printcolor"></span></button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<scannell:form id="queryForm" action="/audit/auditQuery.htmf" onsubmit="return searchExcelCheck(this, 'resultsDiv');">
	<scannell:hidden path="calculateTotals" />
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
										<input type="hidden" id="auditorName" name="auditorName" />
										<%-- <select name="auditorId" id="auditorId" items="${auditors}" itemValue="id" itemLabel="sortableName" class="wide" /> --%>
										<c:choose>
											<c:when test="${fn:length(auditors)  lt maxListSize && fn:length(auditors) > 0}">
												<select name="auditorId" id="auditorId" style="width:100%;">
									               <option value=""><fmt:message key="choose" /></option>
									              	<c:forEach items="${auditors}" var="item">
									              		<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
									              	</c:forEach>
										      </select>
											</c:when>
											<c:otherwise>
												<input type="hidden" id="auditorId" name="auditorId" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee" /> (<fmt:message key="auditeeType[u]" />)</label>
									<div class="col-sm-6">
										<%-- <select name="userAuditeeId" id="userAuditeeId" items="${userAuditees}" itemValue="id" itemLabel="sortableName" class="wide" /> --%>
										<c:choose>
											<c:when test="${fn:length(userAuditees)  lt maxListSize && fn:length(userAuditees) > 0}">
												<select name="userAuditeeId" id="userAuditeeId" style="width:100%;">
									               <option value=""><fmt:message key="choose" /></option>
									              	<c:forEach items="${userAuditees}" var="item">
									              		<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
									              	</c:forEach>
										      </select>
											</c:when>
											<c:otherwise>
												<input type="hidden" id="userAuditeeId" name="userAuditeeId" />
											</c:otherwise>
										</c:choose>
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
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee.workArea" /></label>
									<div class="col-sm-6">
										<scannell:select id="workAreaId" path="workAreaId" items="${workareas}" itemValue="id" itemLabel="name" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee.location" /></label>
									<div class="col-sm-6">
										<scannell:select id="locationId" path="locationId" items="${locations}" itemValue="id" itemLabel="name" class="wide" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="audit.personObserved"/></label>
									<div class="col-sm-6">
										<input type="hidden" id="observerName" name="observerName" />
										<%-- <scannell:select id="observerId" path="observerId" items="${allUsers}" itemValue="id" itemLabel="sortableName" class="wide" /> --%>
										<c:choose>
											<c:when test="${fn:length(allUsers)  lt maxListSize && fn:length(allUsers) > 0}">
												<select name="observerId" id="observerId" style="width:100%;">
									               <option value=""><fmt:message key="choose" /></option>
									              	<c:forEach items="${allUsers}" var="item">
									              		<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
									              	</c:forEach>
										      </select>
											</c:when>
											<c:otherwise>
												<input type="hidden" id="observerId" name="observerId" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="audit.createdBy"/></label>
									<div class="col-sm-6">
										<input type="hidden" id="createdByName" name="createdByName" />
										<%-- <scannell:select id="createdById" path="createdById" items="${auditors}" itemValue="id" itemLabel="sortableName" class="wide" /> --%>
										<c:choose>
											<c:when test="${fn:length(auditors)  lt maxListSize && fn:length(auditors) > 0}">
												<select name="createdById" id="createdById" style="width:100%;">
									               <option value=""><fmt:message key="choose" /></option>
									              	<c:forEach items="${auditors}" var="item">
									              		<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
									              	</c:forEach>
										      </select>
											</c:when>
											<c:otherwise>
												<input type="hidden" id="createdById" name="createdById" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="completed" /></label>
									<div class="col-sm-6">
										<select name="completed" id="completed" class="wide" >
				                        <scannell:option value="true" labelkey="true" />
				                        <scannell:option value="false" labelkey="false" />
			                            </scannell:select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="status" /></label>
									<div class="col-sm-6">
										<select name="status" id="status" class="wide" >
				                        <scannell:option value="IN_PROGR" labelkey="IN_PROGR" />
				                        <scannell:option value="COMPLETE" labelkey="COMPLETE" />
				                        <scannell:option value="TRASH" labelkey="TRASH" />
			                            </scannell:select>
								</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="overdue" /></label>
									<div class="col-sm-6">
										 <scannell:checkbox  path="overdue" id="overdue" value="true" />
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
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionTargetDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="targetCompletionDateFrom" name="targetCompletionDateFrom" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionTargetDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="targetCompletionDateTo" name="targetCompletionDateTo" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
							<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="completionDateFrom" name="completionDateFrom" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="completionDateTo" name="completionDateTo" type="text"  readonly>
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
			                     	<button type="submit" class="g-btn g-btn--primary" onClick="resetExcelRequest();this.form.pageNumber.value = 1;displayQueryTable(false);setSearchNames();" ><fmt:message key="search" /></button>
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
