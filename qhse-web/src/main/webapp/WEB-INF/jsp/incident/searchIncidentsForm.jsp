<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->

<title></title>
	<script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
  	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
    <c:set value="500" var="maxListSize"/>
<style type="text/css" media="all">
td.searchLabel {
	padding-right: 5% !important; width: 20%;
}

.cl-mcont .block {
	box-shadow: 0px 0px 0px rgba(0, 0, 0, 0) !important;
}

.datetime .switch {
	display: table-cell;
}
</style>
<style type="text/css" media="print">

.page     {
	font-size: .9em; 
	zoom: 1;
	overflow:hidden !important;size: landscape;
     }
.nowrap{}
div { width: 100%;     border: 0;   overflow: hidden; size: auto;} 
.printFont{
	font-size:70%;
	/* width: 80% !important; */
}
.printImageSize {
	max-width: 550px; width:550px
}

body{width: 100%;font-size: 1em;}
</style>
<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>



<script type="text/javascript">
var assigneeId = '';
var assigneeName = '';
function checkQuickLink() {
	if('${quickLink}') {
		
		clearForm();
		var selectDepartment = '${selectedDepartment}';
		var selectType= '${selectedType}';
		var selectedOpenClosed= '${selectedOpenClosed}';

		if(selectDepartment) {
	  		jQuery("#departmentId").val(selectDepartment);
	  		jQuery("#departmentId").parent().find('span.select2-chosen').text(jQuery("#departmentId option[value='"+selectDepartment+"']").text());
			jQuery("#departmentId").val(selectDepartment).trigger('change');
		}
		if(selectType) {
			jQuery("#typeId").val(selectType).trigger('change');
	  		jQuery("#typeId").parent().find('span.select2-chosen').text(jQuery("#typeId option[value='"+selectType+"']").text());
			jQuery("#typeId").val(selectType).trigger('change');
		}
		if(selectedOpenClosed) {
			jQuery('#openClosed').val('${selectedOpenClosed}');
			jQuery('#openClosed option[value="${selectedOpenClosed}"]').change();
			changeStatus();
		}
		jQuery('#queryFormStd').submit();
	}
}

jQuery(document).ready(function() {
	var quickLink = '${quickLink}';jQuery("#pageSize").val(20);
	checkQuickLink();
	
  $(jQuery('#loadMask')).unblock(); 
  
   jQuery('select').select2();
 
  jQuery('#bootSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
	  if(state){
		  var bod = jQuery('#loadMask');	
		  $(bod).block({ 
		         message: '<span>Loading Advanced Search...</span>', 
		         css: { top: '0px' } ,
		         css: { position: 'block' }
		     });
		  location.href='searchAdvancedIncidentsForm.htm?hiddenToogleQuery=' + jQuery('#hiddenToogleQuery').val();
	  }
	});
 
  
   if(jQuery('#refreshCheck').val() == "no") {
	    jQuery('#refreshCheck').val("yes");
	  } else {
	    jQuery('#refreshCheck').val("no");
	    location.reload();
	    return;
	  }
  
	var incidentTypes = <json:object>
	  <c:forEach items="${types}" var="type">
		<json:array name="${type.id}" var="subType" items="${type.subTypes}">
		  <json:object> <json:property name="id" value="${subType.id}"/> <json:property name="active" value="${subType.active}"/> <json:property name="used" value="${subType.used}"/> <json:property name="name" value="${subType.name}"/> </json:object>
		</json:array>
  	  </c:forEach>
	</json:object>

	jQuery('#typeId').change(function() {
		var target = jQuery("#subTypeId");
		var selected = jQuery(this).val();
		var subTypes = incidentTypes[selected];
		target.empty();
		target.prepend("<option value=''> <fmt:message key='choose'/> </option>").val('');
		target.select2('val', '');
		if(subTypes) {
			jQuery.each(subTypes, function(i, subType) {
				if(subType.active === true || subType.used === true) {
					target.append(jQuery('<option>').text(jQuery("#"+subType.id).val()).val(subType.id));
				}
	        });
		}
	});
	
	jQuery('#openClosed').change(function() {
		changeStatus();
	});
	
	if(quickLink == "") {
		restoreSearchCriteria('queryFormStd')
		load();
		onLoadFunction('queryFormStd');
	}else{
		showUserList(${fn:length(users)}, "assignees", "100", "assigneeUserList.json", "", "");
	}
	
	displayQueryDiv(false);
	 jQuery('.datetime').datepicker({autoclose: true,clearBtn:true});
	 
	 jQuery('#hiddenToogleQuery').val('${hiddenToogleQuery}');
	  if('${hiddenToogleQuery}' == 'true'){
		  displayQueryDiv(true);
		  jQuery('#hiddenToogleQuery').val('true');
	  } else {
		  displayQueryDiv(false);
		  jQuery('#hiddenToogleQuery').val('false');
	  }
	  
});

function changeStatus() {
	var statusClosed = "";
	var statusOpen = "";
	var investigationOverdue = "";

	switch(jQuery('#openClosed').val()) {
		case "open":
			statusOpen = "true";
			break;
		case "overdue":
			statusOpen = "true";
			investigationOverdue = "true";
			break;
		case "closed":
			statusClosed = "true";
			break;
	}
	jQuery("#statusOpen").val(statusOpen);
	jQuery("#statusClosed").val(statusClosed);
	jQuery("#investigationOverdue").val(investigationOverdue);
}
function restoreSearchCriteria(formId){
  jQuery("#pageNumber").val(1);
 	var pageSize='<%=request.getSession().getAttribute("incidentSearch.pageSize")%>';
	if (pageSize != 'null')
		jQuery("#pageSize").val(pageSize);
    var typeId='<%=request.getSession().getAttribute("incidentSearch.typeId")%>';
   	if(typeId != 'null'){
   		jQuery("#typeId").val(typeId);
   		jQuery("#typeId").parent().find('span.select2-chosen').text(jQuery("#typeId option[value='"+typeId+"']").text());
   	}
   	
   	var subTypeId='<%=request.getSession().getAttribute("incidentSearch.subTypeId")%>';
   	onFocusIncident();
   	jQuery("#subTypeId").val('');
   	if(subTypeId != 'null' && subTypeId !=''){
		jQuery("#subTypeId").val(subTypeId);
		jQuery("#subTypeId").parent().find('span.select2-chosen').text(jQuery("#subTypeId option[value='"+subTypeId+"']").text());
   	}
	var fromOccurredDate='<%=request.getSession().getAttribute("incidentSearch.fromOccurredDate")%>';
  	if(fromOccurredDate != 'null')
  		jQuery("#fromOccurredDate").val(fromOccurredDate);

  	
  	var toOccurredDate='<%=request.getSession().getAttribute("incidentSearch.toOccurredDate")%>';
  	if(toOccurredDate != 'null')
  		jQuery("#toOccurredDate").val(toOccurredDate);
  	
  	var openClosed='<%=request.getSession().getAttribute("incidentSearch.openClosedFromCriteria")%>';
  	if(openClosed == 'null'){
  		openClosed='<%=request.getSession().getAttribute("incidentSearch.openClosed")%>';
  	}
  	if(openClosed != 'null')
		{
			jQuery("#openClosed").val(openClosed);
			jQuery("#openClosed").parent().find('span.select2-chosen').text(jQuery("#openClosed option[value='"+openClosed+"']").text());
	   	
			if(openClosed == 'open')
			{
				jQuery("#statusOpen").val("true");
				jQuery("#investigationOverdue").val("");
				jQuery("#statusClosed").val("");
			}
			else if(openClosed == 'overdue')
			{
				jQuery("#statusOpen").val("true");
				jQuery("#investigationOverdue").val("true");
				jQuery("#statusClosed").val("");
			}
			else if(openClosed == 'closed')
			{
				jQuery("#statusOpen").val("");
				jQuery("#investigationOverdue").val("");
				jQuery("#statusClosed").val("true");
			}
			else
			{
				jQuery("#statusOpen").val("");
				jQuery("#investigationOverdue").val("");
				jQuery("#statusClosed").val("");
			}
		}
  	  	 	  	  	
  	var primaryGroupByName='<%=request.getSession().getAttribute("incidentSearch.primaryGroupByName")%>';
  	if(primaryGroupByName != 'null'){
  		jQuery("#primaryGroupByName").val(primaryGroupByName);
  		jQuery("#primaryGroupByName").parent().find('span.select2-chosen').text(jQuery("#primaryGroupByName option[value='"+primaryGroupByName+"']").text());
  	}   	
  	
   	var status='<%=request.getSession().getAttribute("incidentSearch.status")%>';
  	if(status != 'null'){
  		jQuery("#status").val(status);
  		jQuery("#status").parent().find('span.select2-chosen').text(jQuery("#status option[value='"+status+"']").text());
  	}   
  	
  	var totalManDaysLost='<%=request.getSession().getAttribute("incidentSearch.totalManDaysLost")%>';
  	if(totalManDaysLost != 'null'){
  		jQuery("#totalManDaysLost").val(totalManDaysLost);
  	}   
  	
	var assignees='<%=request.getSession().getAttribute("incidentSearch.assignees")%>';
  	if(assignees != 'null'){
  		assigneeId = '<%=request.getSession().getAttribute("incidentSearch.assignees")%>';
  		assigneeName = '<%=request.getSession().getAttribute("incidentSearch.assigneesName")%>';
  		jQuery("#assignees").val(assignees);
  		jQuery("#assignees").parent().find('span.select2-chosen').text(jQuery("#assignees option[value='"+assignees+"']").text());
  	}   
  	
  	
	var departmentId='<%=request.getSession().getAttribute("incidentSearch.departmentId")%>';
  	if(departmentId != 'null'){
  		jQuery("#departmentId").val(departmentId);
  		jQuery("#departmentId").parent().find('span.select2-chosen').text(jQuery("#departmentId option[value='"+departmentId+"']").text());
	}   

	var businessAreaId='<%=request.getSession().getAttribute("incidentSearch.businessAreaId")%>';
  	if(businessAreaId != 'null'){
  		jQuery("#businessAreaId").val(businessAreaId);
  		jQuery("#businessAreaId").parent().find('span.select2-chosen').text(jQuery("#businessAreaId option[value='"+businessAreaId+"']").text());
	}
  	
  	var programmeImpact='<%=request.getSession().getAttribute("incidentSearch.programmeImpact")%>';
  	if(programmeImpact != 'null'){
  		jQuery("#programmeImpact").val(programmeImpact);
  		jQuery("#programmeImpact").parent().find('span.select2-chosen').text(jQuery("#programmeImpact option[value='"+programmeImpact+"']").text());
	}   
  	
  	var investigationImpactType='<%=request.getSession().getAttribute("incidentSearch.investigationImpactType")%>';
   	if(investigationImpactType == 'env'){	
  		jQuery('input:radio[name=investigationImpactType]')[1].checked = true;
   	}
  	else if(investigationImpactType == 'hs'){
  		jQuery('input:radio[name=investigationImpactType]')[2].checked = true;
   	}
  	else{
  		jQuery('input:radio[name=investigationImpactType]')[0].checked = true;
   	}
   	
   	var active = '<%=request.getSession().getAttribute("incidentSearch.active")%>';
   	jQuery("#active").val(active).change();
   	
}

jQuery(function(){ 
	jQuery('#totalManDaysLost').keyup(function() {
		
	  	var totalManDaysLost=jQuery("#totalManDaysLost")[0].value;
	  	if(totalManDaysLost == '')
	  	{
	  		return true;	
	  	}
		if(isNaN(totalManDaysLost))
		{
			<fmt:message key="incident.searchTasksForm.manDayLostAlertMsg" var="dayLost"/>
			var dayLost="${dayLost}"
			alert(dayLost);
			jQuery("#totalManDaysLost").val('');
			return false;
		}
		return true;
	    
	  });
	});
  
  function onLoadFunction(formId){	 
  	copyFormValuesIfPopup(formId); 
  	var queryString = window.top.location.href.substring();

  	restoreSearchCriteria(formId);
	showUserList(${fn:length(users)}, "assignees", "100", "assigneeUserList.json", assigneeId, assigneeName);
 		jQuery('#'+formId).submit();
 		
//   	if(queryString.indexOf("printable=true") > 0 ){
//   	}
  } 
  function onLoadFunction2(formId){	 
	  	copyFormValuesIfPopup(formId); 
	  	var queryString = window.top.location.href.substring();
	  	
	  	//restoreSearchCriteria(formId);
	 		jQuery('#'+formId).submit();
	 		
//	   	if(queryString.indexOf("printable=true") > 0 ){
//	   	}
	  } 
  
  function onFocusIncident(){
	  var incidentTypes = <json:object>
	  <c:forEach items="${types}" var="type">
		<json:array name="${type.id}" var="subType" items="${type.subTypes}">
		  <json:object> <json:property name="id" value="${subType.id}"/> <json:property name="active" value="${subType.active}"/> <json:property name="used" value="${subType.used}"/> <json:property name="name" value="${subType.name}"/> </json:object>
		</json:array>
  	  </c:forEach>
	</json:object>;
	var target = jQuery("#subTypeId");
	var selected = jQuery('#typeId').val();
	var subTypes = incidentTypes[selected];
	target.empty();
	target.append(jQuery('<option>'));
	if(subTypes) {
		jQuery.each(subTypes, function(i, subType) {
			if(subType.active === true || subType.used === true) {
				target.append(jQuery('<option>').text(jQuery("#"+subType.id).val()).val(subType.id));
			}
        });
	}
  }
  function clearForm(){
	  document.getElementById('queryFormStd').reset();
	  jQuery("#subTypeId").empty();
	  
	  jQuery("#typeId").select2().select2('val', jQuery('#typeId option:eq(0)').val());
	  jQuery("#subTypeId").prepend("<option value=''> <fmt:message key='choose'/> </option>").val('');
	  jQuery("#subTypeId").select2().select2('val', jQuery('#subTypeId option:eq(0)').val());
	  
	  jQuery("#primaryGroupByName").select2().select2('val', jQuery('#primaryGroupByName option:eq(0)').val());
	  jQuery("#status").select2().select2('val', jQuery('#status option:eq(0)').val());
	  jQuery("#openClosed").select2().select2('val', jQuery('#openClosed option:eq(0)').val());

	  jQuery("#assignees").val('');
	  if(jQuery("#assignees").is("input") == false){ // only does this if it is not an INPUT html
		  	jQuery("#assignees").select2().select2('val', jQuery('#assignees option:eq(0)').val());
		  }
	  jQuery("#departmentId").select2().select2('val', jQuery('#departmentId option:eq(0)').val());
	  jQuery("#programmeImpact").select2().select2('val', jQuery('#programmeImpact option:eq(0)').val());
	  
	    
	  jQuery('#statusOpen').val('');
	   jQuery('#statusClosed').val('');
	   jQuery('#investigationOverdue').val('');
	   jQuery("#active").select2().select2('val', jQuery('#active option:eq(0)').val());
  }
  
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/incident/legacyId.htm').submit();
		jQuery('#queryFormStd').attr('action', '${pageContext.request.contextPath}' +'/incident/searchIncidents.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryFormStd').attr('action', '${pageContext.request.contextPath}' +'/incident/searchIncidents.htmf');
	}
	function load(){
		var fdat=jQuery("#fromOccurredDate").val();
		if(!fdat){	
			  var today = new Date();	
			  var toFinaDate;
			  var ddd = today.getDate();
			  var yyyy = today.getFullYear();
			  var month = new Array();
			  month[0] = "Jan";
			  month[1] = "Feb";
			  month[2] = "Mar";
			  month[3] = "Apr";
			  month[4] = "May";
			  month[5] = "Jun";
			  month[6] = "Jul";
			  month[7] = "Aug";
			  month[8] = "Sep";
			  month[9] = "Oct";
			  month[10] = "Nov";
			  month[11] = "Dec";	 
			  var fromFinaDate= '01'+'-'+month[0]+'-'+yyyy;	
			  if(ddd == 0){			  
				  var lastDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 0);
				  var editDate = lastDayOfMonth.getDate();			  
				  toFinaDate= editDate+'-'+month[lastDayOfMonth.getMonth()]+'-'+lastDayOfMonth.getFullYear();
				  
			  }else{
			  toFinaDate= ddd+'-'+month[today.getMonth()]+'-'+yyyy;
		       }
			  jQuery("#fromOccurredDate").val(fromFinaDate);
			  jQuery("#toOccurredDate").val(toFinaDate);
			}
	  }
	
	function setToogleQueryAdvancedSearch() {
		if(jQuery('#hiddenToogleQuery').val() == 'false'){
			jQuery('#hiddenToogleQuery').val('true');
		} else {
			jQuery('#hiddenToogleQuery').val('false');
		}
	}
	
</script>


</head>
<body>
<input type="hidden" id="hiddenToogleQuery" value="false">
	<div id="loadMask">
		<div class="col-md-12">
			<div id="block" class="">
				<div>
					<div style="padding-left: 0px;" class="col-md-6"></div>
					<div class="col-md-12 col-sm-12">
						<div align="right">
							<form id="goToForm" action="<c:url value="/incident/viewIncident.htm" />" method="get"
								onSubmit="if(!jQuery('#gotoId')) return false;">
								<label style="padding: 1px;">Advanced Search</label>
								<input id="bootSwitch" class="switch" data-size="small" type="checkbox">
								<input type="hidden" name="page" value="Incident"/>
								<c:if test="${showLegacyId}">
								 <label>Legacy ID</label> 
		                        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
								</c:if>
								<label style="padding-left: 0%">
									<fmt:message key="incident.searchIncidentsForm.goTo" />
								</label>
								<input type="text" id="gotoId" name="id" size="3">
								<input type="submit" class="g-btn g-btn--primary" value="Go">
								<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();setToogleQueryAdvancedSearch();">
									&nbsp;
									<fmt:message key="search.displaySearch" />
								</button>
								<!-- <button type="button" class="g-btn g-btn--primary" id="loadAdv"><i class="fa fa-search-plus" style="color:white">Advanced Search</i></button> -->
								<c:if test="${addButtonEnabled == true }">
									<button type="button" class="g-btn g-btn--primary" onclick="location.href='editIncident.htm'">
										<i class="fa fa-edit" style="color: white"></i>
										<fmt:message key="newIncident" />
									</button>
								</c:if>
								<button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary">
									<i class="fa fa-print" style="color: white"></i>
									<span></span>
								</button>
							</form>
						</div>
					</div>
				</div>
				<input type="text" id="refreshCheck" value="no" style="display: none;">
				<%-- <div class="hidden-print col-sm-3 pull-right" style="padding-right:0px;">
		  <div style="text-align:right;padding-top:3%;">
			  <form action="<c:url value="/incident/viewIncident.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
			    <fmt:message key="incident.searchIncidentsForm.goTo"/>
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			  </form>
		  </div>
		</div> --%>
			</div>
		</div>

		<input type="hidden" id="queryTableToggleLink" value="Hide Search" />

		<form id="queryFormStd" action="<c:url value="/incident/searchIncidents.htmf" />"
			onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" id="pageNumber" name="pageNumber" value="1" />
			<input type="hidden" id="pageSize" name="pageSize" />			
			<div id="queryDiv">
				<div class="header">
					<h3>
						<fmt:message key="standardSearchCriteria" />
					</h3>
				</div>

				<div class="col-sm-12 col-md-12" id="standardSearchCriteriaTable">
					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="type" />
								</label>
								<select id="typeId" name="typeId" style="width: 100%;">
									<option value=""><fmt:message key="choose"/></option>
									<c:forEach items="${types}" var="type">
										<option value="<c:out value="${type.id}" />"><fmt:message key="${type.key}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="subType" />
								</label>
								<select id="subTypeId" name="subTypeId" style="width: 100%;">
									<option value=""><fmt:message key="choose"/></option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="fromOccurredDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromOccurredDate" name="fromOccurredDate" type="text" readonly>
									<span class="input-group-addon btn btn-primary">
										<span class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toOccurredDate" name="toOccurredDate" type="text" readonly>
									<span class="input-group-addon btn btn-primary">
										<span class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="primaryGroupByName" />
								</label>
								<input type="hidden" name=aggregateName value="total" />
								<select id="primaryGroupByName" name="primaryGroupByName" style="width: 100%;">
									<c:forEach items="${primaryGroupBys}" var="item">
										<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="status" />
								</label>
								<select id="status" name="status" style="width: 100%;">
									<option value=""><fmt:message key="choose"/></option>
									<c:forEach items="${incidentStatuses}" var="item">
										<option value="<c:out value="${item.name}" />"><fmt:message key="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>



					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="task.openClosed" />
								</label>
								<select id="openClosed" name="openClosed" style="width: 100%;">
									<option value=""><fmt:message key="choose"/></option>
									<option value="open"><fmt:message key="task.openClosed.open" /></option>
									<option value="overdue"><fmt:message key="task.openClosed.overdue" /></option>
									<option value="closed"><fmt:message key="task.openClosed.closed" /></option>
								</select>
								<input type="hidden" id="statusOpen" name="statusOpen" />
								<input type="hidden" id="statusClosed" name="statusClosed" />
								<input type="hidden" id="investigationOverdue" name="investigationOverdue" />
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="minTotalManDaysLost" />
								</label>
								<input class="form-control" type="text" name="totalManDaysLost" id="totalManDaysLost" style="width: 100%;" />
								<c:out value="*When using date fields Incident must have occurred between the dates"></c:out>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="assignedTo" />
								</label>
								<%-- <select id="assignees" name="assignees" style="width: 100%;">
									<option value=""><fmt:message key="choose"/></option>
									<c:forEach items="${users}" var="item">
										<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
									</c:forEach>
								</select> --%>
								<c:choose>
									<c:when test="${fn:length(users)  lt maxListSize && fn:length(users) > 0}">
										<select name="assignees" id="assignees" style="width:100%;">
							              	<option value=""><fmt:message key="choose" /></option>
							              		<c:forEach items="${users}" var="item">
							              			<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
							              		</c:forEach>
							           </select>
									</c:when>
									<c:otherwise>
										<input type="hidden" id="assignees" name="assignees" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="department" />
								</label>
								<select id="departmentId" name="departmentId" style="width: 100%;">
									<option value="">Choose</option>
									<c:forEach items="${departments}" var="item">
										<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

					<%-- <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="assignedTo" /></label>                      
              <select id="assignees" name="assignees" style="width:100%;">
             <option value=""><fmt:message key="choose"/></option>
             <c:forEach items="${users}" var="item">
             <option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
             </c:forEach>
             </select>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="department" /></label>                         
             <select id="departmentId" name="departmentId" style="width:100%;">
             <option value=""><fmt:message key="choose"/></option>
            <c:forEach items="${departments}" var="item">
            <c:if test="${item.active}">
            <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
            </c:if>
           </c:forEach>
           </select>
             </div>
      </div>
 </div> --%>



					<div class="row">
						<div class="col-sm-6 col-md-6">
							<c:if test="${!empty programmeImpact}">
								<div class="form-group">
									<label class="scannellGeneralLabel ">
										<fmt:message key="programmeImpact" />
									</label>
									<select id=programmeImpact name="programmeImpact" style="width: 100%;">
										<option value="">Choose</option>
										<c:forEach items="${programmeImpact}" var="item">
											<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
										</c:forEach>
									</select>
								</div>
							</c:if>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-6 control-label scannellGeneralLabel nowrap" style="width: 100%; text-align: left;">
									<fmt:message key="investigationImpactType" />
								</label>
								<div class="radio-inline">
									<input type="radio" name="investigationImpactType" id="investigationImpactType" value="">
									&nbsp;
									<fmt:message key="all" />
									&nbsp;
								</div>
								<c:forEach items="${investigationImpactTypes}" var="item" varStatus="s">
									<div class="radio-inline">
										<input type="radio" name="investigationImpactType" id="investigationImpactType<c:out value="${s.index}" />"
											value="<c:out value="${item.name}" />" alt="<fmt:message key="${item}" />">
										&nbsp;
										<fmt:message key="${item}" />
										&nbsp;
									</div>
									<label style="display: none;" for="investigationImpactType<c:out value="${s.index}" />">
										&nbsp;
										<fmt:message key="investigationImpactType" />
									</label>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-6 control-label scannellGeneralLabel nowrap" style="width: 100%; text-align: left;">
									<fmt:message key="saveCriteria" />
								</label>
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
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
							<label class="scannellGeneralLabel "> <fmt:message
										key="active" />
								</label> <select id="active" name="active" style="width: 100%;">
									<option value="true" selected="selected"><fmt:message
											key="true" /></option>
									<option value="false"><fmt:message key="false" /></option>
								</select>
							</div>
						</div>
					</div>


					<div class="spacer2 text-center">
						<button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;checkForEmptySavedCriteria();setToogleQueryAdvancedSearch();">
							<fmt:message key="search" />
						</button>
						<button type="button" class="g-btn g-btn--primary"
							onClick="return summarise(this.form, '/incident/summariseIncidents.jpeg')">
							<fmt:message key="viewSummaryChart" />
						</button>
						<button type="button" class="g-btn g-btn--secondary" onClick="clearForm()">
							<fmt:message key="reset" />
						</button>
						<input type="hidden" class="g-btn g-btn--primary" id="searchCheck" name="searchCheck" value="searchCheck" />
					</div>

					<input type="hidden" name="chartWidth" value="600" />
		<input type="hidden" name="chartHeight" value="400" />
				</div>
			</div>
			<div id="searchCriteria.summary"></div>
			<div id="resultsDiv"></div>
		</form>
	</div>
	
	<c:forEach items="${types}" var="type">
		<c:forEach var="subType" items="${type.subTypes}">
			<input type="hidden" value="<c:out value="${subType.name}"/>" id="${subType.id}">
		</c:forEach>
  	  </c:forEach>
	
	
	
</body>
</html>