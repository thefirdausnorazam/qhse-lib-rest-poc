<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <!-- <meta name="printable" content="true"> -->
  <title></title>  
  <script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
 
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
<style type="text/css" media="all">
td.searchLabel {
padding-right: 5% !important;
width: 30%;
}
  </style> 
  <c:set value="500" var="maxListSize"/>
  <script type="text/javascript">
  
	jQuery(function(){
		
// 	      //Keep track of last scroll
 	      var lastScroll 	= 0;
 	      var count 		= 0;
 	     jQuery(window).scroll(function(event){
	          //Sets the current scroll position
	          var st = $(this).scrollTop();
	          //Determines up-or-down scrolling
	          //if (st > lastScroll && count != 0){
	        	  //jQuery('select.changeName').select2();
	        	  jQuery('.select2-no-results').each(function (index) {//select2-display-none select2-results select2-no-results
	        		  
	        		  jQuery(this).parent().parent().css("display","none");
	        		  //jQuery(this).remove();
	        	  });
	        	  jQuery('.select2-results').parent().css("display","none");
	        	  count = 0;
	          //}
	          //Updates scroll position
	          lastScroll = st;
	          count++;
 	      });
 	    });
  
  
  jQuery(document).ready(function() {
	  jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
	  jQuery('select').select2();
	  displayQueryDiv(false);	  
	  removeRejectStatus();
	  var responsibleUserText='';
		var responsibleUserId= '<c:out value="${command.responsibleUser.id}"/>';
		if(responsibleUserId != null){
			responsibleUserText= '<c:out value="${command.responsibleUser.sortableName}"/>';
			jQuery('#responsibleUser').val(responsibleUserId);
		}
		showResponsibleUserList(${fn:length(userList)}, "100", "taskUserList.json", responsibleUserId,responsibleUserText);
	  init();
  });
  function clearForm(){
	  jQuery("#type").select2().select2('val', jQuery('#type option:eq(0)').val());
	  jQuery('#responsibleUser').val('').change();
	  if(jQuery("#responsibleUser").is("input") == false){
	  		jQuery("#responsibleUser").select2().select2('val', jQuery('#responsibleUser option:eq(0)').val());
		}
	  jQuery("#departmentId").select2().select2('val', jQuery('#departmentId option:eq(0)').val());
	  jQuery("#workAreaId").select2().select2('val', jQuery('#workAreaId option:eq(0)').val());
	  jQuery("#locationId").select2().select2('val', jQuery('#locationId option:eq(0)').val());
	  jQuery("#status").select2().select2('val', jQuery('#status option:eq(0)').val());
	  jQuery("#priority").select2().select2('val', jQuery('#priority option:eq(0)').val());
	  jQuery("#createdByUser").select2().select2('val', jQuery('#createdByUser option:eq(0)').val());
	  jQuery("#businessAreaId").select2().select2('val', jQuery('#businessAreaId option:eq(0)').val());
	  jQuery("#sortName").select2().select2('val', jQuery('#sortName option:eq(0)').val());
	  var elem = document.getElementById('queryForm').elements;
	  for(var i = 0; i < elem.length; i++){
	  	  	var type = elem[i].type, tag = elem[i].tagName.toLowerCase();
			if (type == 'text' || tag == 'textarea'){
				elem[i].value = '';
			}
			else if (type == 'checkbox' || type == 'radio'){
				elem[i].checked = false;
			}
		}
	  jQuery("#objective").select2('val', jQuery('#objective option:eq(0)').val());
	  jQuery("#managementProgramme").select2('val', jQuery('#managementProgramme option:eq(0)').val());
	  updateMPList("");
  }
  function toggleQueryTable() {
	  displayQueryTable(jQuery('#queryTable').show());
    
  }
  function init() {	  
	  if('${quickLink}' != '') {
			clearForm();
			var selectedStatus = '${selectedStatus}';
			if(selectedStatus) {
				jQuery("#status").val(selectedStatus).trigger('change');
			}
			var selectDepartment = '${selectedDepartment}';
			if(selectDepartment) {
				jQuery("#departmentId").val(selectDepartment).trigger('change');
			}
			var selectType = '${selectedTaskType}';
			if(selectType) {
				jQuery("#type").val(selectType).trigger('change');
			}
		}
	  else {
	  	copyFormValuesIfPopup('queryForm');
	  }
	  jQuery('#queryForm').submit();
  }
  
  
  function removeRejectStatus() {
	  jQuery('#status').find('option').each(function () {
		  if(this.value == 'REJECTED'){
			  jQuery(this).remove();
		  }
	  });	  
  } 
  function updateMPList(value){
		var selectData, states;
		jQuery.getJSON("managementProgrammeListByObjective.json?objectiveId="+value, function (data) {
		    var state;
		    selectData = data;
		    jQuery("#managementProgramme").empty();
		    states = jQuery("#managementProgramme");
		    jQuery("<option value=\"\">Choose</option>").appendTo(states);
		    jQuery("#managementProgramme").select2('val', jQuery('#managementProgramme option:eq(0)').val());
		    for (i = 0; i < selectData.length; i++) {
		        jQuery("<option value=\""+selectData[i].id+"\">"+selectData[i].userName+"</option>").appendTo(states);
		    }
	 	});
  }
  function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/risk/legacyIdTask.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/taskQueryResult.ajax?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/taskQueryResult.ajax');
	}
  </script>
</head>
<body>

<div class="col-md-12">
	<div id="block" class="">
		<div>
		    <div class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		   <input type="text" id="refreshCheck" value="no" style="display: none;">
		    <form id="goToForm" action="<c:url value="/risk/taskView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
		    <input type="hidden" name="page" value="task"/>
		    <c:if test="${showLegacyId}">
		        <label>Legacy ID</label> 
		        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
		    </c:if>
			    Go to RAT/MPT
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Display Search</button>
			    <button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
				</div>
		 	</div>
		</div>
	</div>
</div>

<div class="content">
<scannell:form id="queryForm" action="/risk/taskQueryResult.ajax" onsubmit="updateSearchCriteriaSummary(); return searchExcelCheck(this, 'resultsDiv');">
<div id="queryDiv">
<div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
<scannell:hidden path="calculateTotals" />
<scannell:hidden path="pageNumber" />
<scannell:hidden path="pageSize" />


		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="businessAreas" />
			</label>
			<div class="col-sm-6">
				<select name="businessAreaId" id="businessArea" items="${businessAreaList}" itemLabel="name" cssStyle="width:100%" itemValue="id" renderEmptyOption="true"  />
			</div>
		</div>
                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="task.name" /></label>
									<div class="col-sm-6">
									<scannell:textarea path="name" id="name" class="form-control" cssStyle="width:100%" />
									</div>
								</div>
								<div style="clear: both;"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="task.type" /></label>
									<div class="col-sm-6">																			
										  <scannell:select id="type" path="type" cssStyle="width:100%">
                                          <scannell:option value="RA" label="Risk Assessment" />
                                          <scannell:option value="MP" label="Management Programme" />
                                          <scannell:option value="HT" label="Hazard/Aspect Task" />
                                          </scannell:select>
									</div>
								</div>								 
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="objective" /></label>
									<div class="col-sm-6">
									<select name="objectiveId" id="objective" items="${objectiveList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" onchange="updateMPList(this.value)" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="managementProgramme" /></label>
									<div class="col-sm-6">
										<select name="managementProgrammeId" id="managementProgramme" items="${managementProgrammeList}" itemLabel="name" itemValue="id" cssStyle="width:100%" /><br>
									</div>
								</div>
								<div class="form-group">
<%-- 									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="responsibleUser" /></label>
									<div class="col-sm-6">
									<select name="responsibleUser" id="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id" renderEmptyOption="true" cssStyle="width:100%"  />
									</div> --%>
									
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="responsibleUser" />
									</label>
								    	<c:choose>
											<c:when test="${fn:length(userList) lt maxListSize && fn:length(userList) > 0}">
												<div class="col-sm-6"><select name="responsibleUser" id="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id"
													cssStyle="width:100%" renderEmptyOption="true" /></div>
											</c:when>
											<c:otherwise>
												    <div class="col-sm-6"><input type="hidden" id="responsibleUser" style="width:100% !important;"  name="responsibleUser" /></div>
											</c:otherwise>
										</c:choose>
										
										
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="managementProgramme.department" /></label>
									<div class="col-sm-6">
										<select name="departmentId" id="departmentId" items="${departmentList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="workArea" /></label>
									<div class="col-sm-6">
										<select name="workAreaId" id="workAreaId" items="${workareaList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" />
									</div>
								</div>								
								
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="deptLocation" /></label>
									<div class="col-sm-6">
										<select name="locationId" id="locationId" items="${locationList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%"  />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="task.status" /></label>
									<div class="col-sm-6">
										 <select name="status" id="status" renderEmptyOption="true" cssStyle="width:100%">
											<c:forEach items="${statusList}" var="status">
												<scannell:option value="${status.name}" labelkey="${status.name}" />
											</c:forEach>
										</scannell:select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="priority" /></label>
									<div class="col-sm-6">
										<select name="priority" id="priority" items="${prioritiesList}" itemValue="name" lookupItemLabel="true" renderEmptyOption="true" cssStyle="width:100%"/>
									</div>
								</div>
								
<%-- 							<jsp:include page="../SearchAttributes.jsp">
			        			<jsp:param name="structureFormat" value="divFormat"/>
			    			</jsp:include> --%>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="targetCompletionDateFrom" /> </label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="targetCompletionDateFrom" id="targetCompletionDateFrom" readonly="true" cssStyle="size:16;" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="targetCompletionDateTo" /> </label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="targetCompletionDateTo" cssStyle="size:16;" id="targetCompletionDateTo" readonly="true" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>	
								
							 <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="completionDateFrom" id="completionDateFrom" readonly="true" cssStyle="size:16;" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="completionDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="completionDateTo" cssStyle="size:16;" id="completionDateTo" readonly="true" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="overdue" /></label>
									<div class="col-sm-6">
										 <scannell:checkbox  path="overdue" id="overdue" value="true" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">									
										<select name="sortName" id="sortName" items="${sortList}" lookupItemLabel="true" renderEmptyOption="true" cssStyle="width:100%" />
									</div>
								</div>
								<div class="form-group">
									<label id="sortNameLabel" class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="saveCriteria" /></label>
									
									<div>
										<div>
											<input type="checkbox" style="float:left;" onclick="showCriteriaSaveForm(this)" name="saveCriteriaChk" id="saveCriteriaChk"> 
											<div id="saveCriteriaDiv" style="float:left;margin-left:7px;display:none">
												<fmt:message key="searchCriteriaPrivate" />: <input type="radio" checked="checked" name="saveCriteria" id="saveCriteria" value="personal">
				      							<fmt:message key="searchCriteriaGlobal" />: <input type="radio" name="saveCriteria" id="saveCriteria" value="global"> 
				      							<input id="criteriaName" name="criteriaName" onkeyup="verifySaveCriteriaName(this)" size="40" maxlength="40" value="" placeholder="<fmt:message key="searchCriteriaDefaultMessage" />">
				                            	<div>
				                            		&nbsp;<label style="display:none;" id="saveCriteriaError"><span class="errorMessage"><fmt:message key="searchCriteriaError"/></span></label>
												</div>
				                            </div>
										</div>
		                            </div>
								</div>

     
                              <div class="spacer2 text-center">
			                     <button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="resetExcelRequest();this.form.pageNumber.value = 1;displayQueryDiv(false);"><fmt:message key="search" /></button>
                                 <button type="button" class="g-btn g-btn--secondary" onclick="resetExcelRequest();clearForm();"><fmt:message key="reset" /></button>
								<c:if test="${createExcel == true}">
									<button type="button" class="g-btn g-btn--primary"
										onClick="excelRequest();this.form.pageNumber.value = 1;displayQueryDiv(false);init();">
										<fmt:message key="exportToExcel" />
									</button>
								</c:if>
								<input type="hidden" id="excel" name="excel" value="NO" />
			                  </div>
     


</div>

<div id="resultsDiv"></div>

</scannell:form>
</div>



</body>
</html>
