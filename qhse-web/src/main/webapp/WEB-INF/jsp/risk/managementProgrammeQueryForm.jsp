<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<!--   <meta name="printable" content="true"> -->
  <title></title>  
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
  <link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
  <c:set value="500" var="maxListSize"/>
  <style type="text/css" media="all">
 td.searchLabel {
padding-right: 5% !important;
width: 30%;
}

.ui-widget-header .ui-dialog-titlebar .ui-widget-header .ui-corner-all .ui-helper-clearfix {
    background: #b0de78;
    border: 0;
    color: #fff;
    font-weight: normal;
}
  </style> 
  <script type="text/javascript">
  jQuery(document).ready(function() {
	  jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
	  jQuery("#businessAreaId").select2({width:'100%'});	 
	  jQuery("#departmentId").select2({width:'100%'});	 
	  jQuery("#status").select2({width:'100%'});	  	 
	  jQuery("#createdByUser").select2({width:'100%'});	  
	  jQuery("#sortName").select2({width:'100%'});
	  jQuery("#workAreaId").select2({width:'100%'});
	  jQuery("#locationId").select2({width:'100%'});
	  jQuery(".commonSearchAtributes").select2({width:'100%'});		
	  var responsibleUserText='';
	  var responsibleUserId= '<c:out value="${command.responsibleUser.id}"/>';
	  if(responsibleUserId != null){
		 responsibleUserText= '<c:out value="${command.responsibleUser.sortableName}"/>';
		 jQuery('#responsibleUser').val(responsibleUserId);
		 if(jQuery("#responsibleUser").is("input") == false){ // only does this if it is not an INPUT html
		 	jQuery('#responsibleUser').select2('val', responsibleUserId);
		 }
	  }
	  showResponsibleUserList(${fn:length(userList)}, "100", "mPUserList.json", responsibleUserId,responsibleUserText);

	  displayQueryDiv(false);
	  });
  
  
jQuery(window).bind('load', formOnLoad);
  
  function formOnLoad(){	  
	  copyFormValuesIfPopup('queryForm');	
	  if('${criteriaId}' == '')  {
	  	jQuery("#status").select2("val", "IN_PROGR");
	  } 
	  
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
		}
	  else {
		  var currentUsr = document.getElementById('currentUser').value;
		  jQuery("#responsibleUser option").each(function() 
			{
		
			    if (jQuery(this).text() == currentUsr) {	
			    	if('${responsibleUserFromSavedCriteria}' != 'true') {
			    		jQuery("#responsibleUser").select2("val", jQuery(this).val());	
			    	}
			    }

			});
	  }
	  
	  jQuery('#queryForm').submit();
	  updateSearchCriteriaSummary();
  }
  function clearForm(){
	  jQuery('select').not('#siteLocation').not('#lawTabs').not('#profileSelect').not('.recordsPerPage > select').select2().select2('val', '');
	  jQuery('#queryForm')[0].reset();
	  jQuery('#status').val('');
	  jQuery('#responsibleUser').val('').change();
	  if(jQuery("#responsibleUser").is("input") == false){ // only does this if it is not an INPUT html
	  	jQuery("#responsibleUser").select2().select2('val', jQuery('#responsibleUser option:eq(0)').val());
	  }
	  jQuery('#departmentId').val('');
	  jQuery('#workAreaId').val('');
	  jQuery('#locationId').val('');
	  jQuery('#sortName').val('');
	  
  }
<!--
  function toggleQueryTable() {
	displayQueryTable(jQuery('#queryTable').show());
  }
// -->

function getMP(){

var legId1 = jQuery('#gotoLegacyId').val();
/* jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "managementProgrammeFromAllSite.json",
		  data: 'legId='+ legId1,
		  success: function(data){
			  for(var i =0; i < data.length; i++){
				  jQuery('#mpTable').append('<tr><td><a href="managementProgrammeView.htm?id='+data[i].id+'"><font color="#CF3030">'+data[i].id +'</font> </a></td><td>'+data[i].site+'</td></tr>');
				  jQuery('#mpTable2').append('<tr><td><a href="managementProgrammeView.htm?id='+data[i].id+'"><font color="#CF3030">'+data[i].id +'</font> </a></td><td>'+data[i].site+'</td></tr>');
				//jQuery('#mpTable').append('<tr><td><a href="managementProgrammeView.htm?id='+data[i].id+'"><font color="#CF3030">'+data[i].id +'</font> </a></td><td>'+data[i].name+'</td><td>'+data[i].status+'</td><td>'+data[i].site+'</td></tr>');
			  }
			  jQuery("#dialogTable").dialog({
				  modal:true
				  }).dialog('open');
			  jQuery('#dialogTable2').show();
			  jQuery('#dialogTableHeader').show();
			  
	            
		  }
		}); 
		
		jQuery('#dialogTable').on('dialogclose', function(event) {
			jQuery('#mpTable').find("tr:gt(0)").remove();
		}); */
		
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/risk/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/managementProgrammeQueryResult.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/managementProgrammeQueryResult.htmf');
	}
	
  function trimDescription(){
	jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  }
  </script>
</head>
<body>
<div class="col-md-12">
	<div id="block" class="">
		<!-- <div>	 -->	  
			<div class="col-lg-12 col-md-12 col-sm-12 pull-right">
		    	<div align="right" class="row">		    
		       <input type="text" id="refreshCheck" value="no" style="display: none;">
		       <form id="goToForm"  class="col-lg-12 col-md-12 col-sm-12 pull-right" action="<c:url value="/risk/managementProgrammeView.htm" />" method="get" onSubmit="if(!(jQuery('#gotoId') || jQuery('#gotoLegacyId') )) return false;">
		       <input type="hidden" name="page" value="managementProgramme"/>
		       <c:if test="${showLegacyId}">
		       <label>Legacy ID</label> 
		        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getMP();">
			   </c:if>
			    Go to MP			    
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			   <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Display Search</button>
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='managementProgrammeAdd.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;New MP</button>
					</c:if>
				<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
				<%-- <form style="padding-right:0px" class="col-lg-2 col-md-2 col-sm-2 pull-right" action="<c:url value="/risk/managementProgrammeView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
		        <label>Legacy ID</label> 
		        <input type="text" id="gotoId" name="id" size="12"><input type="submit" class="g-btn g-btn--primary" value="Go">
		        </form> --%>
		  		</div>
		 	</div>
		<!-- </div> -->
	</div>
</div>


<div class="content">
 <scannell:form id="queryForm" action="/risk/managementProgrammeQueryResult.htmf" onsubmit=" return search(this, 'resultsDiv');updateSearchCriteriaSummary();">
<div id="queryDiv">
<div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
<scannell:hidden path="calculateTotals" />
<scannell:hidden path="pageNumber" />
 <scannell:hidden path="pageSize" />
 <input type="hidden" name="currentUser" id="currentUser" value="${currentUser}"/>


                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="businessArea" /></label>
									<div class="col-sm-6">
									<select name="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" onchange="onChangeBusinessArea()" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="managementProgramme.name" /></label>
									<div class="col-sm-6">																			
										 <scannell:textarea path="name" class="form-control" id="name" cssStyle="width:100%"  />
									</div>
								</div>								 
								<div style="clear: both;"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="responsibleUser" /></label>
									<div class="col-sm-6">
										<c:choose>
											<c:when test="${fn:length(userList)  lt maxListSize && fn:length(userList) > 0}">
										 <select name="responsibleUser" id="responsibleUser" items="${userList}" itemLabel="sortableName" cssStyle="width:100%" itemValue="id" renderEmptyOption="true"  />
											</c:when>
											<c:otherwise>
												<input type="hidden" id="responsibleUser" name="responsibleUser" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="managementProgramme.department" /></label>
									<div class="col-sm-6">
										 <select name="departmentId" id="departmentId" items="${departmentList}" itemLabel="name" cssStyle="width:100%" itemValue="id" renderEmptyOption="true"  />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="workArea" /></label>
									<div class="col-sm-6">
										 <select name="workAreaId" id="workAreaId" items="${workareaList}" itemLabel="name" cssStyle="width:100%" itemValue="id" renderEmptyOption="true"  />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="deptLocation" /></label>
									<div class="col-sm-6">
										 <select name="locationId" id="locationId" items="${locationList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="managementProgramme.status" /></label>
									<div class="col-sm-6">
										<select name="status" id="status" renderEmptyOption="true" cssStyle="width:100%">
											<c:forEach items="${statusList}" var="status">
												<scannell:option value="${status.name}" labelkey="${status.name}" />
											</c:forEach>
										</scannell:select>
									</div>
								</div>
								
																
<%-- 							<jsp:include page="../SearchAttributes.jsp">
			        			<jsp:param name="structureFormat" value="divFormat"/>
			    			</jsp:include> --%>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										<scannell:input class="form-control" id="startDateFrom"  cssStyle="size:16;" path="startDateFrom"  readonly="true"/>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                         <scannell:input class="form-control" id="startDateTo"  cssStyle="size:16;" path="startDateTo"  readonly="true"/>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="targetCompletionDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="targetCompletionDateFrom" id="targetCompletionDateFrom" readonly="true" cssStyle="size:16;" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="targetCompletionDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										 <scannell:input class="form-control" path="targetCompletionDateTo" cssStyle="size:16;" id="targetCompletionDateTo" readonly="true" />
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
			                     <button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);updateSearchCriteriaSummary();trimDescription();"><fmt:message key="search" /></button>
                                 <button type="button" class="g-btn g-btn--secondary" onClick="clearForm()"><fmt:message key="reset" /></button>
			                  </div>
     


</div>
<div id="searchCriteriaDiv"></div>
<div id="resultsDiv"></div>

</scannell:form>
</div>

</body>
</html>