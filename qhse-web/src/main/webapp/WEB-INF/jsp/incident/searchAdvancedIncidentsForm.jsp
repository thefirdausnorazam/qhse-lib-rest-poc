<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
	<title></title>
  	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
    <c:set value="500" var="maxListSize"/>
<style type="text/css" media="all">
td.searchLabel {
	padding-right: 5% !important; width: 20%;
}
input{
  line-height: 26px;
    padding: 7px;
}
.cl-mcont .block {
	box-shadow: 0px 0px 0px rgba(0, 0, 0, 0) !important;
}
.row {
	margin-right: 0px;
 	margin-left: 0px;
}


</style>

	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />

<script type="text/javascript">
var createdUserId = '';
var createdUserName = '';
var assigneeId = '';
var assigneeName = '';
jQuery(document).ready(function() {
	$(jQuery('#loadSear')).unblock();	
	jQuery('select').not("createdbyuser").not("assignees").select2();
	
	jQuery('#bootSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
		  if(!state){
			  var bod = jQuery('#loadSear');	
			  $(bod).block({ 
			         message: '<span>Loading General Search...</span>', 
			         css: { top: '0px' } ,
			         css: { position: 'block' }
			     });
			  location.href='searchIncidentsForm.htm?hiddenToogleQuery=' + jQuery('#hiddenToogleQuery').val();
		  }
		});

	  hideSearchDivSelect2WhenScrolling();
	
	

  if(jQuery('#refreshCheck').val() == "no") {
    jQuery('#refreshCheck').val("yes");
  } else {
    jQuery('#refreshCheck').val("no");
    window.location.reload();
    return;
  }
  
	var incidentTypes = <json:object>
	  <c:forEach items="${types}" var="type">
		<json:array name="${type.id}" var="subType" items="${type.subTypes}">
		  <json:object> <json:property name="id" value="${subType.id}"/> <json:property name="active" value="${subType.active}"/> <json:property name="used" value="${subType.used}"/> <json:property name="name" value="${subType.name}"/> </json:object>
		</json:array>
  	  </c:forEach>
	</json:object>;
	
	jQuery('#typeId').change(function() {
		var target = jQuery("#subTypeId");
		var selected = jQuery(this).val();
		var subTypes = incidentTypes[selected];

		target.empty();
		target.prepend("<option value=''> Choose </option>").val('');
		target.select2('val', '');
		if(subTypes) {
			jQuery.each(subTypes, function(i, subType) {
				if(subType.active === true || subType.used === true) {
					target.append(jQuery('<option>').text(subType.name).val(subType.id));
				}
	        });
		}
	});
	
	jQuery('#openClosed').change(function() {
		var statusOpen = "";
		var statusClosed = "";
		var investigationOverdue = "";

		switch(jQuery(this).val()) {
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
	});
	restoreSearchCriteria('queryFormAdv');
	load();
	onLoadFunction('queryFormAdv');
  
  jQuery('#hiddenToogleQuery').val('${hiddenToogleQuery}');
  if('${hiddenToogleQuery}' == 'true'){
	  displayQueryDiv(true);
	  jQuery('#hiddenToogleQuery').val('true');
  } else {
	  displayQueryDiv(false);
	  jQuery('#hiddenToogleQuery').val('false');
  }
});


function setToogleQueryAdvancedSearch() {
	if(jQuery('#hiddenToogleQuery').val() == 'false'){
		jQuery('#hiddenToogleQuery').val('true');
	} else {
		jQuery('#hiddenToogleQuery').val('false');
	}
}

function reverse(s){
    return s.split("").reverse().join("");
}

function parseMonth(date) {
	date = date.replace("Jan",0);
	date = date.replace("Feb",1);
	date = date.replace("Mar",2);
	date = date.replace("Apr",3);
	date = date.replace("May",4);
	date = date.replace("Jun",5);
	date = date.replace("Jul",6);
	date = date.replace("Aug",7);
	date = date.replace("Sep",8);
	date = date.replace("Oct",9);
	date = date.replace("Nov",10);
	date = date.replace("Dec",11);
	return date;
}

function validateDates(from, to) {
	  var fromV = parseMonth(from.value);
	  var partsFrom = fromV.split('-');

	  var toV = parseMonth(to.value);
	  var partsTo = toV.split('-');
	  if(partsFrom != 'null' && partsTo != 'null')
	  {
		  var fromDate = new Date(partsFrom[2],partsFrom[1],partsFrom[0]);
		  var toDate =  new Date(partsTo[2],partsTo[1],partsTo[0]);
		  if(fromDate.getTime() > toDate.getTime())
		  {
			  alert("Date range is invalid: "+from.value+ " is after "+to.value);
			  return false;
		  }
	  }
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
				target.append(jQuery('<option>').text(subType.name).val(subType.id));
			}
      });
	}
}

function restoreSearchCriteria(formId){
  	jQuery("#pageNumber").val(1);
  	var pageSize='<%=request.getSession().getAttribute("incidentSearch.pageSize")%>';
 	if(pageSize != 'null'){
 		  jQuery("#pageSize").val(pageSize);
 	}
  	jQuery("#incidentSource").val('${sessionScope["incidentSearch.incidentSource"]}');
  	jQuery("#incidentCategory").val('${sessionScope["incidentSearch.incidentCategory"]}');
  
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
  	
	var fromCreatedDate='<%=request.getSession().getAttribute("incidentSearch.fromCreatedDate")%>';
  	if(fromCreatedDate != 'null')
  		jQuery("#fromCreatedDate").val(fromCreatedDate);
  	var toCreatedDate='<%=request.getSession().getAttribute("incidentSearch.toCreatedDate")%>';
  	if(toCreatedDate != 'null')
  		jQuery("#toCreatedDate").val(toCreatedDate);
  	
	var fromUpdatedDate='<%=request.getSession().getAttribute("incidentSearch.fromUpdatedDate")%>';
  	if(fromUpdatedDate != 'null')
  		jQuery("#fromUpdatedDate").val(fromUpdatedDate); 	
  	var toUpdatedDate='<%=request.getSession().getAttribute("incidentSearch.toUpdatedDate")%>';
  	if(toUpdatedDate != 'null')
  		jQuery("#toUpdatedDate").val(toUpdatedDate);
  	
	var fromInvestCreatedDate='<%=request.getSession().getAttribute("incidentSearch.fromInvestCreatedDate")%>';
  	if(fromInvestCreatedDate != 'null')
  		jQuery("#fromInvestCreatedDate").val(fromInvestCreatedDate);	
  	var toInvestCreatedDate='<%=request.getSession().getAttribute("incidentSearch.toInvestCreatedDate")%>';
  	if(toInvestCreatedDate != 'null')
  		jQuery("#toInvestCreatedDate").val(toInvestCreatedDate);
  	
	var fromInvestUpdatedDate='<%=request.getSession().getAttribute("incidentSearch.fromInvestUpdatedDate")%>';
  	if(fromInvestUpdatedDate != 'null')
  		jQuery("#fromInvestUpdatedDate").val(fromInvestUpdatedDate);
  	var toInvestUpdatedDate='<%=request.getSession().getAttribute("incidentSearch.toInvestUpdatedDate")%>';
  	if(toInvestUpdatedDate != 'null')
  		jQuery("#toInvestUpdatedDate").val(toInvestUpdatedDate);
  	
	var fromInvestStartDate='<%=request.getSession().getAttribute("incidentSearch.fromInvestStartDate")%>';
  	if(fromInvestStartDate != 'null')
  		jQuery("#fromInvestStartDate").val(fromInvestStartDate);
  	var toInvestStartDate='<%=request.getSession().getAttribute("incidentSearch.toInvestStartDate")%>';
  	if(toInvestStartDate != 'null')
  		jQuery("#toInvestStartDate").val(toInvestStartDate);
  	
	var fromInvestTargetCloseDate='<%=request.getSession().getAttribute("incidentSearch.fromInvestTargetCloseDate")%>';
  	if(fromInvestTargetCloseDate != 'null')
  		jQuery("#fromInvestTargetCloseDate").val(fromInvestTargetCloseDate);
  	var toInvestTargetCloseDate='<%=request.getSession().getAttribute("incidentSearch.toInvestTargetCloseDate")%>';
  	if(toInvestTargetCloseDate != 'null')
  		jQuery("#toInvestTargetCloseDate").val(toInvestTargetCloseDate);
  	
  	var fromCloseDate='<%=request.getSession().getAttribute("incidentSearch.fromCloseDate")%>';
  	if(fromCloseDate != 'null')
  		jQuery("#fromCloseDate").val(fromCloseDate);
  	
  	var toCloseDate='<%=request.getSession().getAttribute("incidentSearch.toCloseDate")%>';
  	if(toCloseDate != 'null')
  		jQuery("#toCloseDate").val(toCloseDate);

  	var severity='<%=request.getSession().getAttribute("incidentSearch.severity")%>';
  	if(severity != 'null'){
  		jQuery("#severity").val(severity);
  		jQuery("#severity").parent().find('span.select2-chosen').text(jQuery("#severity option[value='"+severity+"']").text());
  	}
  	var severityRanking='<%=request.getSession().getAttribute("incidentSearch.severityRanking")%>';
  	if(severityRanking != 'null'){
  		jQuery("#severityRanking").val(severityRanking);
  		jQuery("#severityRanking").parent().find('span.select2-chosen').text(jQuery("#severityRanking option[value='"+severityRanking+"']").text());
  	}
  	var actualSeverity='<%=request.getSession().getAttribute("incidentSearch.actualSeverity")%>';
  	if(actualSeverity != 'null'){
  		jQuery("#actualSeverity").val(actualSeverity);
  		jQuery("#actualSeverity").parent().find('span.select2-chosen').text(jQuery("#actualSeverity option[value='"+actualSeverity+"']").text());
  	}
  	var potentialSeverity='<%=request.getSession().getAttribute("incidentSearch.potentialSeverity")%>';
  	if(potentialSeverity != 'null'){
  		jQuery("#potentialSeverity").val(potentialSeverity);
  		jQuery("#potentialSeverity").parent().find('span.select2-chosen').text(jQuery("#potentialSeverity option[value='"+potentialSeverity+"']").text());
  	}
  	var processSeverity='<%=request.getSession().getAttribute("incidentSearch.processSeverity")%>';
  	if(processSeverity != 'null'){
  		jQuery("#processSeverity").val(processSeverity);
  		jQuery("#processSeverity").parent().find('span.select2-chosen').text(jQuery("#processSeverity option[value='"+processSeverity+"']").text());
  	}

  	var severityRiskEvent='<%=request.getSession().getAttribute("incidentSearch.severityRiskEvent")%>';
  	if(severityRiskEvent != 'null'){
  		jQuery("#severityRiskEvent").val(severityRiskEvent);
  		jQuery("#severityRiskEvent").parent().find('span.select2-chosen').text(jQuery("#severityRiskEvent option[value='"+severityRiskEvent+"']").text());
  	}
  	var severityRisk='<%=request.getSession().getAttribute("incidentSearch.severityRisk")%>';
  	if(severityRisk != 'null'){
  		jQuery("#severityRisk").val(severityRisk);
	  	jQuery("#severityRisk").parent().find('span.select2-chosen').text(jQuery("#severityRisk option[value='"+severityRisk+"']").text());
	}
  	var capaProject='<%=request.getSession().getAttribute("incidentSearch.capaProject")%>';
  	if(capaProject != 'null'){
  		jQuery("#capaProject").val(capaProject);
	  	jQuery("#capaProject").parent().find('span.select2-chosen').text(jQuery("#capaProject option[value='"+capaProject+"']").text());
	}
  	var capaProjectAnswears='<%=request.getSession().getAttribute("incidentSearch.capaProjectAnswears")%>';
  	if(capaProjectAnswears != 'null'){
  		jQuery("#capaProjectAnswears").val(capaProjectAnswears);
  		jQuery("#capaProjectAnswears").parent().find('span.select2-chosen').text(jQuery("#capaProjectAnswears option[value='"+capaProjectAnswears+"']").text());
	}
  	var reporteeId='<%=request.getSession().getAttribute("incidentSearch.reporteeId")%>';
  	if(reporteeId != 'null'){
  		jQuery("#reporteeId").val(reporteeId);
  		jQuery("#reporteeId").parent().find('span.select2-chosen').text(jQuery("#reporteeId option[value='"+reporteeId+"']").text());
	}
   	
  	var reportedExternally='<%=request.getSession().getAttribute("incidentSearch.reportedExternally")%>';
  	if(reportedExternally != 'null'){
  		jQuery("#reportedExternally").val(reportedExternally);
  		jQuery("#reportedExternally").parent().find('span.select2-chosen').text(jQuery("#reportedExternally option[value='"+reportedExternally+"']").text());
	}
   	
  	var participantType='<%=request.getSession().getAttribute("incidentSearch.participantType")%>';
  	if(participantType != 'null'){
  		jQuery("#participantType").val(participantType);
  		jQuery("#participantType").parent().find('span.select2-chosen').text(jQuery("#participantType option[value='"+participantType+"']").text());
  	}
  	
  	var communicatedTo='<%=request.getSession().getAttribute("incidentSearch.communicatedTo")%>';
  	if(communicatedTo != 'null'){
  		jQuery("#communicatedTo").val(communicatedTo);
  		jQuery("#communicatedTo").parent().find('span.select2-chosen').text(jQuery("#communicatedTo option[value='"+communicatedTo+"']").text());
  	}
  	
  	var participantBodyPart='<%=request.getSession().getAttribute("incidentSearch.participantBodyPart")%>';
  	if(participantBodyPart != 'null'){
  		jQuery("#participantBodyPart").val(participantBodyPart);   	
  		jQuery("#participantBodyPart").parent().find('span.select2-chosen').text(jQuery("#participantBodyPart option[value='"+participantBodyPart+"']").text());
  	}
  	
	var participantName='<%=request.getSession().getAttribute("incidentSearch.participantName")%>';
  	if(participantName != 'null')
  		jQuery("#participantName").val(participantName);
  	
  	var role='<%=request.getSession().getAttribute("incidentSearch.role")%>';
  	if(role != 'null'){
  		jQuery("#role").val(role);
  		jQuery("#role").parent().find('span.select2-chosen').text(jQuery("#role option[value='"+role+"']").text());
	}
  	
  	var shift='<%=request.getSession().getAttribute("incidentSearch.shift")%>';
  	if(shift != 'null'){
  		jQuery("#shift").val(shift);
  		jQuery("#shift").parent().find('span.select2-chosen').text(jQuery("#shift option[value='"+shift+"']").text());
	}
  	
  	var qualitySeverityId='<%=request.getSession().getAttribute("incidentSearch.qualitySeverity")%>';
  	if(qualitySeverityId != 'null'){
  		jQuery("#qualitySeverity").val(qualitySeverityId);
  		jQuery("#qualitySeverity").parent().find('span.select2-chosen').text(jQuery("#qualitySeverity option[value='"+qualitySeverityId+"']").text());
	}
  	
  	var teamId='<%=request.getSession().getAttribute("incidentSearch.team")%>';
  	if(teamId != 'null'){
  		jQuery("#team").val(teamId);
  		jQuery("#team").parent().find('span.select2-chosen').text(jQuery("#team option[value='"+teamId+"']").text());
	}
  	 	
  	var equipmentLocationId='<%=request.getSession().getAttribute("incidentSearch.equipmentLocation")%>';
  	if(equipmentLocationId != 'null')
  		jQuery("#equipmentLocation").val(equipmentLocationId);
  	
  	var processId='<%=request.getSession().getAttribute("incidentSearch.process")%>';
  	if(processId != 'null'){
  		jQuery("#process").val(processId);
	  	jQuery("#process").parent().find('span.select2-chosen').text(jQuery("#process option[value='"+processId+"']").text());
	}
  	var causeType='<%=request.getSession().getAttribute("incidentSearch.causeType")%>';
  	if(causeType != 'null'){
  		jQuery("#causeType").val(causeType);
	  	jQuery("#causeType").parent().find('span.select2-chosen').text(jQuery("#causeType option[value='"+causeType+"']").text());
	}
  	
  	var equipmentId='<%=request.getSession().getAttribute("incidentSearch.equipmentId")%>';
  	if(equipmentId != 'null')
  		jQuery("#equipmentId").val(equipmentId);
  	
  	var processSafety='<%=request.getSession().getAttribute("incidentSearch.processSafety")%>';
  	if(processSafety != 'null')
  		jQuery('#processSafety').prop('checked', true);
  	
  	var rootCauseId='<%=request.getSession().getAttribute("incidentSearch.rootCauseId")%>';
  	if(rootCauseId != 'null'){
  		jQuery("#rootCauseId").val();
	  	jQuery("#rootCauseId").parent().find('span.select2-chosen').text(jQuery("#rootCauseId option[value='"+rootCauseId+"']").text());
	}
  	
  	var environmentalAspectTypeId='<%=request.getSession().getAttribute("incidentSearch.environmentalAspectTypeId")%>';
  	if(environmentalAspectTypeId != 'null'){
  		jQuery("#environmentalAspectTypeId").val(environmentalAspectTypeId);
	  	jQuery("#environmentalAspectTypeId").parent().find('span.select2-chosen').text(jQuery("#environmentalAspectTypeId option[value='"+environmentalAspectTypeId+"']").text());
	}
  	
  	var environmentalImpactTypeId='<%=request.getSession().getAttribute("incidentSearch.environmentalImpactTypeId")%>';
  	if(environmentalImpactTypeId != 'null'){
  		jQuery("#environmentalImpactTypeId").val(environmentalImpactTypeId);
  		jQuery("#environmentalImpactTypeId").parent().find('span.select2-chosen').text(jQuery("#environmentalImpactTypeId option[value='"+environmentalImpactTypeId+"']").text());
	}
  	
  	var qualityImpactTypeId='<%=request.getSession().getAttribute("incidentSearch.qualityImpactTypeId")%>';
  	if(qualityImpactTypeId != 'null'){
  		jQuery("#qualityImpactTypeId").val(qualityImpactTypeId);
  		jQuery("#qualityImpactTypeId").parent().find('span.select2-chosen').text(jQuery("#qualityImpactTypeId option[value='"+qualityImpactTypeId+"']").text());
	}
  	
  	var location2='<%=request.getSession().getAttribute("incidentSearch.location2")%>';
  	if(location2 != 'null'){
  		jQuery("#location2").val(location2);
  		jQuery("#location2").parent().find('span.select2-chosen').text(jQuery("#location2 option[value='"+location2+"']").text());
	}
  	
  	var healthHazardTypeId='<%=request.getSession().getAttribute("incidentSearch.healthHazardTypeId")%>';
  	if(healthHazardTypeId != 'null'){
  		jQuery("#healthHazardTypeId").val(healthHazardTypeId);
	  	jQuery("#healthHazardTypeId").parent().find('span.select2-chosen').text(jQuery("#healthHazardTypeId option[value='"+healthHazardTypeId+"']").text());
	}
  	
  	var injuryTypeId='<%=request.getSession().getAttribute("incidentSearch.injuryTypeId")%>';
  	if(injuryTypeId != 'null'){
  		jQuery("#injuryTypeId").val(injuryTypeId);
	  	jQuery("#injuryTypeId").parent().find('span.select2-chosen').text(jQuery("#injuryTypeId option[value='"+injuryTypeId+"']").text());
	}
  	
  	var secondaryGroupByName='<%=request.getSession().getAttribute("incidentSearch.secondaryGroupByName")%>';
  	if(secondaryGroupByName != 'null'){
  		jQuery("#secondaryGroupByName").val(secondaryGroupByName);
  		jQuery("#secondaryGroupByName").parent().find('span.select2-chosen').text(jQuery("#secondaryGroupByName option[value='"+secondaryGroupByName+"']").text());
	}
  	
  	var areaOwner='<%=request.getSession().getAttribute("incidentSearch.areaOwner")%>';
  	if(areaOwner != 'null'){
  		jQuery("#areaOwner").val(areaOwner);
	  	jQuery("#areaOwner").parent().find('span.select2-chosen').text(jQuery("#areaOwner option[value='"+areaOwner+"']").text());
	}
  	
  	var InvestigationAppByAreaOwner='<%=request.getSession().getAttribute("incidentSearch.InvestigationAppByAreaOwner")%>';
  	if(InvestigationAppByAreaOwner != 'null')
  		jQuery("#InvestigationAppByAreaOwner").val(InvestigationAppByAreaOwner);
  	
   	var openClosed='<%=request.getSession().getAttribute("incidentSearch.openClosed")%>';
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
  	
   	var confidential='<%=request.getSession().getAttribute("incidentSearch.confidential")%>';
  	if(confidential != 'null'){
  		jQuery("#confidential").val(confidential);
	  	jQuery("#confidential").parent().find('span.select2-chosen').text(jQuery("#confidential option[value='"+confidential+"']").text());
	}
  	
  	var totalManDaysLost='<%=request.getSession().getAttribute("incidentSearch.totalManDaysLost")%>';
  	if(totalManDaysLost != 'null')
  		jQuery("#totalManDaysLost").val(totalManDaysLost);
  	
	var assignedToUser='<%=request.getSession().getAttribute("incidentSearch.assignees")%>';
  	if(assignedToUser != 'null'){
  		assigneeId = '<%=request.getSession().getAttribute("incidentSearch.assignees")%>';
		assigneeName = '<%=request.getSession().getAttribute("incidentSearch.assigneesName")%>';
  		jQuery("#assignees").val(assignedToUser);
  		jQuery("#assignees").parent().find('span.select2-chosen').text(jQuery("#assignees option[value='"+assignedToUser+"']").text());
	}
  	
	var departmentId='<%=request.getSession().getAttribute("incidentSearch.departmentId")%>';
  	if(departmentId != 'null'){
  		jQuery("#departmentId").val(departmentId);
	  	jQuery("#departmentId").parent().find('span.select2-chosen').text(jQuery("#departmentId option[value='"+departmentId+"']").text());
	}
  	
  	var investigationImpactType='<%=request.getSession().getAttribute("incidentSearch.investigationImpactType")%>';
  	if(investigationImpactType != 'null'){  		
	  	if(investigationImpactType == 'env'){	
	  		if((jQuery('input:radio[name=investigationImpactType]')[1] != null)) {
	  			jQuery('input:radio[name=investigationImpactType]')[1].checked = true;
	  		}
	   	}
	  	else if(investigationImpactType == 'hs'){
	  		if((jQuery('input:radio[name=investigationImpactType]')[2] != null)) {
	  			jQuery('input:radio[name=investigationImpactType]')[2].checked = true;
	  		}
	   	}
	  	else{
	  		if((jQuery('input:radio[name=investigationImpactType]')[0] != null)) {
	  			jQuery('input:radio[name=investigationImpactType]')[0].checked = true;
	  		}
	   	}
  	}
  	
  	var description='<%=request.getSession().getAttribute("incidentSearch.description")%>';
  	if(description != 'null')
  		jQuery("#description").val(description);
  	var programmeImpacts='<%=request.getSession().getAttribute("incidentSearch.programmeImpacts")%>';
  	if(programmeImpacts != 'null'){
  		jQuery("#programmeImpacts").val(programmeImpacts);
	  	jQuery("#programmeImpacts").parent().find('span.select2-chosen').text(jQuery("#programmeImpacts option[value='"+programmeImpacts+"']").text());
	}

  	var immediateAction='<%=request.getSession().getAttribute("incidentSearch.immediateAction")%>';
  	if(immediateAction != 'null')
  		jQuery("#immediateAction").val(immediateAction);
  		
  	var workAreaId='<%=request.getSession().getAttribute("incidentSearch.workArea")%>';
    if(workAreaId != 'null'){
      jQuery("#workArea").val(workAreaId);
      jQuery("#workArea").parent().find('span.select2-chosen').text(jQuery("#workArea option[value='"+workAreaId+"']").text());
	}
    
    var firstAidOutcome='<%=request.getSession().getAttribute("incidentSearch.firstAidOutcome")%>';
    if(firstAidOutcome != 'null'){
      jQuery("#firstAidOutcome").val(firstAidOutcome);
	  jQuery("#firstAidOutcome").parent().find('span.select2-chosen').text(jQuery("#firstAidOutcome option[value='"+firstAidOutcome+"']").text());
	}
    
	var createdByUser='<%=request.getSession().getAttribute("incidentSearch.createdByUser")%>';
  	if(createdByUser != 'null'){
  		createdUserId = '<%=request.getSession().getAttribute("incidentSearch.createdByUser")%>';
  		createdUserName = '<%=request.getSession().getAttribute("incidentSearch.createdByUserName")%>';	
  		jQuery("#createdByUser").val(createdByUser);
	  	jQuery("#createdByUser").parent().find('span.select2-chosen').text(jQuery("#createdByUser option[value='"+createdByUser+"']").text());
	}
	var createdByUserDepartmentId='<%=request.getSession().getAttribute("incidentSearch.createdByUserDepartmentId")%>';
  	if(createdByUserDepartmentId != 'null'){
  		jQuery("#createdByUserDepartmentId").val(createdByUserDepartmentId);
	  	jQuery("#createdByUserDepartmentId").parent().find('span.select2-chosen').text(jQuery("#createdByUserDepartmentId option[value='"+createdByUserDepartmentId+"']").text());
	}
  	var mobileAppSource='<%=request.getSession().getAttribute("incidentSearch.mobileAppSource")%>';
  	if(mobileAppSource != 'null'){
  		jQuery("#mobileAppSource").val(mobileAppSource);
  		jQuery("#mobileAppSource").parent().find('span.select2-chosen').text(jQuery("#mobileAppSource option[value='"+mobileAppSource+"']").text());
  	}
}
function is_numeric(str){
	if(!(/^\d+$/.test(str)))
		{
		alert("Please specify a specify day count");
		}
    return /^\d+$/.test(str);
}
 /*  function toggleSearch() {
    if($('searchToggleLink').innerHTML == "Hide Search Criteria") {
      Effect.Fade('advancedSearchCriteriaTable');
      $('searchToggleLink').innerHTML = "Display Search Criteria";
    }
    else{
      Effect.Appear('advancedSearchCriteriaTable');
      $('searchToggleLink').innerHTML = "Hide Search Criteria";
    }
  } */
  function onLoadFunction(formId) {	 
    copyFormValuesIfPopup(formId);
    var queryString = window.top.location.href.substring();
    restoreSearchCriteria(formId);
    showUserList(${fn:length(allUsers)}, "createdByUser", "100", "assigneeUserList.json", createdUserId, createdUserName);
	showUserList(${fn:length(allUsers)}, "assignees", "100", "assigneeUserList.json", assigneeId, assigneeName);
    jQuery('#'+formId).submit();
  }
  function onLoadFunction2(formId) {	 
	    copyFormValuesIfPopup(formId);
	    var queryString = window.top.location.href.substring();
	    //restoreSearchCriteria(formId);
	    jQuery('#'+formId).submit();
	  }
  jQuery(function(){ 
		jQuery('#totalManDaysLost').keyup(function() {
			
		  	var totalManDaysLost=jQuery("#totalManDaysLost")[0].value;
		  	if(totalManDaysLost == '')
		  	{
		  		return true;	
		  	}
		  	 
			if(isNaN(totalManDaysLost) || totalManDaysLost !== String(Math.round(Number(totalManDaysLost))))
			{
				<fmt:message key="incident.searchTasksForm.manDayLostAlertMsg.notInteger" var="dayLost"/>
				var dayLost="${dayLost}"
				alert(dayLost);
				jQuery("#totalManDaysLost").val('');
				return false;
			} else if(totalManDaysLost.length >= 10) {
				<fmt:message key="incident.searchTasksForm.manDayLostAlertMsg.maxExceeded" var="dayLost"/>
				var dayLost="${dayLost}"
				alert(dayLost);
				jQuery("#totalManDaysLost").val('');
				return false;
			}
			
			return true;
		    
		  });
		});
  
  function clearForm(){
	  
	  jQuery('.clientQuestionSelect').each(
			    function() {
			     	jQuery(this).val("").trigger( "change" ); 
			    }
			);
	  jQuery("#answerOptionIds").val("");
	  jQuery("#answerCheckBoxes").val("");
	  jQuery("#answerText").val("");
	  jQuery("#createdByUser").val("");
	  
	  document.getElementById('queryFormAdv').reset();
	  jQuery("#subTypeId").empty();
	  

	  jQuery("#subTypeId").prepend("<option value=''> Choose </option>").val('');
	  jQuery("form#queryFormAdv select").each(function(){
		  jQuery("#"+$(this).attr('id')).select2().select2('val', jQuery('#'+$(this).attr('id')+' option:eq(0)').val());
		});
		
	  jQuery("#confidential").select2().select2('val', '');
	  
	  jQuery("#pageSize").select2().select2('val', jQuery('#pageSize option:eq(1)').val());
	  
		jQuery("#statusOpen").val("");
		jQuery("#statusClosed").val("");
		jQuery("#investigationOverdue").val("");
  
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
  // created by Manjush on 16/June/2014
  function getCookie(name) {
	    var dc = document.cookie;
	    var prefix = name + "=";
	    var begin = dc.indexOf("; " + prefix);
	    if (begin == -1) {
	        begin = dc.indexOf(prefix);
	        if (begin != 0) return null;
	    }
	    else
	    {
	        begin += 2;
	        var end = document.cookie.indexOf(";", begin);
	        if (end == -1) {
	        end = dc.length;
	        }
	    }
	    return unescape(dc.substring(begin + prefix.length, end));
	} 
//created by Manjush on 16/June/2014
  function deleteCookie(c_name) {
	    document.cookie = encodeURIComponent(c_name) + "=deleted; expires=" + new Date(0).toUTCString();
	}
//created by Manjush on 16/June/2014 
  function myTimer() {
	  var myCookie = getCookie("test");
	  if(myCookie != null){
		  deleteCookie("test");
		  window.location.reload(true);
		 
	  }
	}

  function searchExcelCheck(form, targetElementId, scrollToResults) {	
	  validateDates(document.getElementById("fromOccurredDate"), document.getElementById("toOccurredDate"));
	  validateDates(document.getElementById("fromCreatedDate"), document.getElementById("toCreatedDate"));
	  validateDates(document.getElementById("fromUpdatedDate"), document.getElementById("toUpdatedDate"));
	  validateDates(document.getElementById("fromCloseDate"), document.getElementById("toCloseDate"));
	  validateDates(document.getElementById("fromInvestStartDate"), document.getElementById("toInvestStartDate"));
	  validateDates(document.getElementById("fromInvestUpdatedDate"), document.getElementById("toInvestUpdatedDate"));
	  validateDates(document.getElementById("fromInvestTargetCloseDate"), document.getElementById("toInvestTargetCloseDate"));
	
		var exc=jQuery("#excel").val();
		 if(exc == 'YES'){
			var stDate=jQuery('#fromOccurredDate').val();	
			if(!stDate){							
				var r=confirm("You have not selected a date range for the export."+
						"Please select a date in the Occurred Date From and To fields."+
						"If you do not select any dates the default range will be used."+
						"This is Year to Date (i.e. 1 January to today).");
				if(r==false){					
					return false;
				}
				
			}			
			targetElementId=null;
			// created by Manjush on 16/June/2014 to reload the page and download excel
			var myVar = setInterval(function(){myTimer()}, 100);	
			
		} 
		if (scrollToResults) {
			scrollToResultDiv = true;
		}	
		
		//created by Manjush on 16/June/2014 	
		jQuery('#'+targetElementId).html('<table class="table table-bordered table-responsive"><thead><tr><th>Loading data...</th></tr></thead></table>');	
		if(exc == 'NO'){
		jQuery.ajax({
			   url:  jQuery(form).attr('action'),
			   type: "post",
			   dataType: "html",
			   data:jQuery(form).serialize(form),
			   success: function(returnData){			 
			   jQuery('#'+targetElementId).html(returnData);				   
			   },
			   error: function(e){
			     alert('Error : '+e);
			   }
			});	
		}else{	 
			jQuery('body').append('<div id="preparing-file-modal" title="Preparing report..." style="display: none;"> We are preparing your excel report, please wait... <img src="../images/loading.gif" /> </div>');
			jQuery('body').append('<div id="error-modal" title="Error" style="display: none;">There was a problem generating your report, please try again.</div>');
			var preparingFileModal = jQuery("#preparing-file-modal");
			preparingFileModal.dialog({ modal: true });
			jQuery.fileDownload(jQuery(form).attr('action'), {	        	 
	            httpMethod: "POST",
	            successCallback: function (url) {
	                preparingFileModal.dialog('close');
	            },
	            failCallback: function (responseHtml, url) {
	            	preparingFileModal.dialog('close');
	            	jQuery("#error-modal").dialog({ modal: true });
	            },
	            data: jQuery(form).serialize(form)
	        });
 //	        e.preventDefault();//this is critical to stop the click event which will trigger a normal file download!
	    
	   
			
			
		}
		 scrollToResultDiv = true;		 
		return false; 
	}
  
  function setExcelNo(){
	  setTimeout(function() { resetExcelRequest(); }, 2000);
  }
  
  function populateClientQuestionAnswerIds(id){
	  var arr = jQuery('.clientQuestionSelect').map(function(){
          return this.value
      }).get();
	//  jQuery('#answerOptionIds').val(arr);
  }
  
  function populateClientQuestions(){
	  var checkBoxId = "";
	  jQuery('.clientQuestionCheckBox').each(function () {
	       var checkBoxValue = (this.checked ? this.checked : ""); 
	        if(checkBoxValue){
	        	if(checkBoxId){
	        		checkBoxId=checkBoxId+","+jQuery(this).attr("id");
	        	}else{
	        		checkBoxId=jQuery(this).attr("id");
	        	}
	        	
	        }
		  });
		  jQuery('#answerCheckBoxes').val(checkBoxId);
		  
		  var answerOption = "";
		  jQuery('.clientQuestionSelect  option:selected').each(function() {
			  var select = jQuery(this);
			    var id = select.attr('id');
			    if(jQuery(this).val()){
			    	if(answerOption){
			    		answerOption = answerOption+","+jQuery(this).parent().attr("id")+":"+jQuery(this).val();
			    	}else{
			    		 answerOption = jQuery(this).parent().attr("id")+":"+jQuery(this).val();
			    	}
			   
			    }
		    });
		  jQuery('#answerOptionIds').val(answerOption);
		  
		  var textIdAndValue = "";
		  jQuery(".clientQuestionText").each(function() {
			  if(jQuery(this).val()){
				  textIdAndValue=textIdAndValue+jQuery(this).attr("id")+":"+jQuery(this).val()+","; 
			  }});
			  jQuery('#answerText').val(textIdAndValue);
		  
     }
  function populateClientQuestionText(){
	  var textIdAndValue = "";
	  jQuery(".clientQuestionText").each(function() {
		  if(jQuery(this).val()){
			  textIdAndValue=textIdAndValue+jQuery(this).attr("id")+":"+jQuery(this).val()+","; 
		  }});
		  jQuery('#answerText').val(textIdAndValue);
     }
	function getObjects(){
		jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/incident/legacyId.htm').submit();
	}
</script>


</head>
<body>
<input type="hidden" id = "hiddenToogleQuery" value="false">
	<div id="loadSear">
		<div class="col-md-12">
			<div id="block" class="">
				<div>
					<div style="padding-left: 0px;" class="col-md-6"></div>
					<div class="col-md-12 col-sm-12 pull-right">

						<div align="right">
							<form id="goToForm" action="<c:url value="/incident/viewIncident.htm" />" method="get"
								onSubmit="if(!jQuery('#gotoId')) return false;">
								<label style="padding: 1px;">
									<fmt:message key="advancedSearch" />
								</label>
								<input id="bootSwitch" class="switch" data-size="small" type="checkbox" checked>
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
									<fmt:message key="newIncident" />
									<fmt:message key="search.displaySearch" />
								</button>
								<!-- <button type="button" class="g-btn g-btn--primary" id="loadMask" ><i class="fa fa-search-plus" style="color:white">Standard Search</i></button> -->
								<c:if test="${addButtonEnabled == true }">
									<button type="button" class="g-btn g-btn--primary"
										onclick="location.href='editIncident.htm'">
										<i class="fa fa-edit" style="color: white"></i>
										<fmt:message key="newIncident" />
									</button>
								</c:if>
								<button type="button"
									onclick="window.open(jQuery('#printParam').val(), '_blank')"
									class="g-btn g-btn--primary">
									<i class="fa fa-print" style="color: white"></i> <span></span>
								</button>
							</form>
						</div>
					</div>
				</div>

				<input type="hidden" id="refreshCheck" value="no">
				<%-- 		<div class="row col-sm-4 pull-right">
		<div class="hidden-print col-sm-2 " style="padding-right:0px;padding-left:0px;">
		  
			    <label> <fmt:message key="incident.searchIncidentsForm.goTo"/></label>
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			 
		</div>
		<div class="hidden-print col-sm-2 pull-right" style="padding-right:0px;padding-left:0px;">
		
			     <label>Advanced Search</label>	
			     <input id="bootSwitch" class="switch" data-size="small"  type="checkbox" >
			 
		</div>
		
		</div> --%>



			</div>
		</div>

		<form id="queryFormAdv" method="post"
			action="<c:url value="/incident/searchIncidents.htmf" />"
			onsubmit="populateClientQuestions();return searchExcelCheck(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" value="true"/> 
			<input type="hidden" id="pageNumber" name="pageNumber" value="1"/> 
			<input type="hidden" id="pageSize" name="pageSize" />
			<fmt:message key="incident.enableAdditionalFields" var="enable" />
			<div id="queryDiv">
				<div class="header">
					<h3>
						<fmt:message key="advancedSearchCriteria" />
					</h3>
				</div>
					<div class="spacer2 text-center" >
		<button type="submit" class="g-btn g-btn--primary"
			onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);resetExcelRequest();setToogleQueryAdvancedSearch();">
			<fmt:message key="search" />
		</button>
		<button type="button" class="g-btn g-btn--primary"
			onClick="resetExcelRequest();return summarise(this.form, '/incident/summariseIncidents.jpeg')">
			<fmt:message key="viewSummaryChart" />
		</button>
		<c:if test="${createExcel == true}">
			<button type="submit" class="g-btn g-btn--primary"
				onClick="excelRequest();this.form.pageNumber.value = 1;setExcelNo();">
				<fmt:message key="exportToExcel" />
			</button>
		</c:if>
		<button type="button" class="g-btn g-btn--secondary" onClick="resetExcelRequest();clearForm()">
			<fmt:message key="reset" />
		</button>
	</div>
	
					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="type" />
								</label> <select id="typeId" name="typeId" style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<c:forEach items="${types}" var="type">
										<option value="<c:out value="${type.id}" />"><fmt:message
												key="${type.key}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="subType" />
								</label> <select id="subTypeId" name="subTypeId" style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
								</select>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="fromOccurredDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromOccurredDate"
										name="fromOccurredDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toOccurredDate"
										name="toOccurredDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="incidentFromCreatedDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromCreatedDate"
										name="fromCreatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toCreatedDate"
										name="toCreatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="incidentFromUpdatedDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromUpdatedDate"
										name="fromUpdatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toUpdatedDate"
										name="toUpdatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="fromCloseDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromCloseDate"
										name="fromCloseDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toCloseDate" name="toCloseDate"
										type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="fromInvestStartDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromInvestStartDate"
										name="fromInvestStartDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toInvestStartDate"
										name="toInvestStartDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="fromInvestUpdatedDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromInvestUpdatedDate"
										name="fromInvestUpdatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toInvestUpdatedDate"
										name="toInvestUpdatedDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="fromInvestTargetCloseDate" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="fromInvestTargetCloseDate"
										name="fromInvestTargetCloseDate" type="text" readonly>
									<span class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="to" />
								</label>
								<div class="input-group date datetime col-md-5 col-xs-7"
									class="input-group date datetime " data-min-view="2"
									data-date-format="dd-MM-yyyy">
									<input class="form-control" id="toInvestTargetCloseDate"
										name="toInvestTargetCloseDate" type="text" readonly> <span
										class="input-group-addon btn btn-primary"> <span
										class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="status" />
								</label> <select id="status" name="status" style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<c:forEach items="${incidentStatuses}" var="item">
										<option value="<c:out value="${item.name}" />"><fmt:message
												key="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="departmentChoose" />
								</label> <select id="departmentId" name="departmentId"
									style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<c:forEach items="${departments}" var="item">
										<option value="<c:out value="${item.id}" />"
											title="<c:out value="${item.name}" />"
											<c:if test="${item.id == status.value}">selected="selected"</c:if>>
											<c:out value="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="confidential" />
								</label> <select id="confidential" name="confidential"
									style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<option value="true"><fmt:message key="true" /></option>
									<option value="false"><fmt:message key="false" /></option>
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="control-label scannellGeneralLabel nowrap">
									<fmt:message key="description" />
								</label>
								<textarea id="description" name="description"
									style="width: 100%;"></textarea>
							</div>
						</div>
					</div>


					<div class="row">

						<div class="col-sm-6 col-md-6">
							<c:if test="${!empty incidentSources}">
								<div class="form-group">
									<label class="scannellGeneralLabel "> <fmt:message
											key="incidentSource" />
									</label> <select id="incidentSource" name="incidentSource2"
										style="width: 100%;">
										<option value=""><fmt:message key="choose" /></option>
										<c:forEach items="${incidentSources}" var="item">
											<c:if test="${item.active}">
												<option value="<c:out value="${item.id}" />"><c:out
														value="${item.name}" /></option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</c:if>
						</div>
					</div>
					<div class="row">
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
						<div class="col-sm-6 col-md-6">
							<div class="form-group" style="border-bottom: 0px">
								<label class="control-label scannellGeneralLabel nowrap"
									style="width: 100%; text-align: left;"> <fmt:message
										key="unassigned" />
								</label> 
								<input type="checkbox" id="assigned" name="assigned" value="false" />
							</div>
						</div>
					</div>
					
					<div class="row">

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel "> <fmt:message
										key="mobileAppSource" />
								</label> <select id="mobileAppSource" name="mobileAppSource" style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<option value="true"><fmt:message
											key="true" /></option>
									<option value="false"><fmt:message key="false" /></option>
								</select>
							</div>

						</div>

						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="scannellGeneralLabel ">
									<fmt:message key="task.openClosed" />
								</label>
								<select id="openClosed" name="openClosed" style="width: 100%;">
									<option value=""><fmt:message key="choose" /></option>
									<option value="open"><fmt:message key="task.openClosed.open" /></option>
									<option value="overdue"><fmt:message key="task.openClosed.overdue" /></option>
									<option value="closed"><fmt:message key="task.openClosed.closed" /></option>
								</select>
								<input type="hidden" id="statusOpen" name="statusOpen" />
								<input type="hidden" id="statusClosed" name="statusClosed" />
								<input type="hidden" id="investigationOverdue" name="investigationOverdue" />
							</div>
				
						</div>
					</div>

					<c:forEach var="templateQuestion"
						items="${incidentAvailableFieldsByName}" varStatus="loop">
						<c:choose>
							<c:when test="${templateQuestion.incidentField}">
								<c:set var="g" value="${templateQuestion}" />
								<c:if test="${g.fieldOptionType != 'NONE'}">

									<c:set var="label" value="${g.questionName}" />

									<c:if test="${g.questionName == 'participants'}">

										<div class="row">

											<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label class="scannellGeneralLabel "> <fmt:message
															key="participantType" />
													</label> <select id="participantType" style="width: 100%;"
														name="participantType">
														<option value=""><fmt:message key="choose" /></option>
														<c:forEach items="${participantTypes}" var="item">
															<option value="<c:out value="${item.name}" />"><fmt:message
																	key="${item}" /></option>
														</c:forEach>
													</select>
												</div>

											</div>
											<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label class="control-label scannellGeneralLabel nowrap">
														<fmt:message key="participantName" />
													</label> <input type="text" style="width: 100%;"
														id="participantName" name="participantName" />
												</div>
											</div>
										</div>


										<div class="row">

											<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label class="scannellGeneralLabel "> <fmt:message
															key="participantBodyPart" />
													</label> <select id="participantBodyPart"
														name="participantBodyPart" style="width: 100%;">
														<option value=""><fmt:message key="choose" /></option>
														<c:forEach items="${participantBodyParts}" var="item">
															<option value="<c:out value="${item.name}" />"><fmt:message
																	key="${item}" /></option>
														</c:forEach>
													</select>
												</div>

											</div>
											<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label class="control-label scannellGeneralLabel nowrap">
														<fmt:message key="participant.role" />
													</label> <select id="role" name="role" style="width: 100%;">
														<option value=""><fmt:message key="choose" /></option>
														<c:forEach items="${participantRoles}" var="item">
															<option value="<c:out value="${item.name}" />"><fmt:message
																	key="${item}" /></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label class="control-label scannellGeneralLabel nowrap">
														<fmt:message key="injuryType" />
													</label>
													<select id="injuryTypeId" name="injuryTypeId" style="width: 100%;">
														<option value=""><fmt:message key="choose" /></option>
														<c:forEach items="${injuries}" var="item">
															<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>


									</c:if>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
	
	<c:set var="lineCount" value="0"></c:set>
					<c:forEach var="templateQuestion"
						items="${incidentAvailableFieldsByName}" varStatus="s">
						<c:choose>
							<c:when test="${! templateQuestion.incidentField}">
								<c:set var="g" value="${templateQuestion.question}" />
								<c:if test="${g.answerType != QuestionAnswerType[NONE]}">

									<c:set var="label" value="${g.name}" />

									<c:if test="${g.name != 'participants' and g.active}">
									<div class="col-sm-6 col-md-6">
										<div class="form-group">
											<label class="scannellGeneralLabel "> ${label}
											</label>
										<c:choose>
											<c:when test="${g.answerType == 'QuestionAnswerType[checkbox]'}">
												<input type="checkbox" id="${g.id}" name="${label}"
													style="width: 100%;" class="clientQuestionCheckBox"/>
											</c:when>
											<c:when test="${g.answerType == 'QuestionAnswerType[text]'}">
												<input type="text" id="${g.id}" name="${label}"
													style="width: 100%;" class="clientQuestionText" />
											</c:when>
											<c:when test="${g.answerType == 'QuestionAnswerType[textarea]'}">
												<input type="text" id="${g.id}" name="${label}"
													style="width: 100%;" class="clientQuestionText" />
											</c:when>
										<c:when test="${g.answerType == 'QuestionAnswerType[option]'}">
											  <select id="${g.id}" style="width: 100%;" name="${label}" onchange="populateClientQuestionAnswerIds(this.value)" class="clientQuestionSelect">
											  		<option value=""><fmt:message key="choose" /></option>
													<c:forEach items="${clientQuestionOptions[g.id]}" var="item">
															<option value="<c:out value="${item.id}" />">${item.name}</option>
													</c:forEach>
												</select>
											</c:when>
										<c:when test="${g.answerType == 'QuestionAnswerType[option-multi-choice]'}">
												<select id="${g.id}" style="width: 100%;" name="${label}" onchange="populateClientQuestionAnswerIds(this.value)" class="clientQuestionSelect">
											  		<option value=""><fmt:message key="choose" /></option>
													<c:forEach items="${clientQuestionOptions[g.id]}" var="item2">
															<option value="<c:out value="${item2.id}" />">${item2.name}</option>
													</c:forEach>
												</select>
											</c:when>
											<c:when test="${g.answerType == QuestionAnswerType[DATE]}">
												<div class="input-group date datetime col-md-5 col-xs-7"
													class="input-group date datetime " data-min-view="2"
													data-date-format="dd-MM-yyyy">
													<input class="form-control" style="width: 100%;"
														id="${g.name}" name="${g.name}"
														type="text" readonly> <span
														class="input-group-addon btn btn-primary"> <span
														class="glyphicon glyphicon-th"></span>
													</span>
												</div>

											</c:when>
										</c:choose>
	<c:set var="lineCount" value="${lineCount + 1 }"></c:set>
	</div>
	</div>
	</c:if>
	
	</c:if>
	</c:when>
	</c:choose>
	</c:forEach>  	
	<c:set var="lineCount" value="0"></c:set>
	<c:forEach var="templateQuestion" items="${incidentAvailableFieldsByName}" varStatus="s">
		<c:choose>
			<c:when test="${templateQuestion.incidentField}">
				<c:set var="g" value="${templateQuestion}" />
				<c:choose>
					<c:when test="${g.fieldOptionType != 'NONE'}">
						<c:set var="label" value="${g.questionName}" />
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<c:if test="${g.questionName != 'participants' && g.questionName != 'department'}">
									<label class="scannellGeneralLabel "> <fmt:message
												key="${label}" />
										</label>

										<c:choose>
											<c:when test="${g.questionName == 'assignees'}">
												<c:choose>
													<c:when test="${fn:length(allUsers)  lt maxListSize && fn:length(allUsers) > 0}">
														<select name="assignees" id="assignees" style="width:100%;">
											              	<option value=""><fmt:message key="choose" /></option>
										              		<c:forEach items="${allUsers}" var="item">
										              			<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
										              		</c:forEach>
											           </select>
													</c:when>
													<c:otherwise>
														<input type="hidden" id="assignees" name="assignees" />
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${g.fieldOptionType == 'TEXT'}">
												<input type="text" id="${label}" name="${label}"
													style="width: 100%;" />
											</c:when>
											<c:when test="${g.fieldOptionType == 'TEXTAREA'}">
												<input type="text" id="${label}" name="${label}"
													style="width: 100%;" />
											</c:when>
											<c:when test="${g.fieldOptionType == 'LIST'}">
												<select id="${label}" name="${label}" style="width: 100%;">
													<option value=""><fmt:message key="choose" /></option>
													<c:if
														test="${availableFieldsByName[g.questionName] != null}">
														<c:forEach
															items="${availableFieldsByName[g.questionName]}"
															var="item">
															<c:choose>
																<c:when
																	test="${item['class'].simpleName == 'QuestionOption'}">
																	<c:if test="${item.active || item.obsolete}">
																		<option value="<c:out value="${item.id}" />"
																			title="<c:out value="${item.name}" />"><c:out
																				value="${item.name}" /></option>
																	</c:if>
																</c:when>
																<c:when
																	test="${item['class'].simpleName == 'RiskBusinessArea'}">
																	<c:if test="${item.active || item.obsolete}">
																		<option value="<c:out value="${item.id}" />"
																			title="<c:out value="${item.name}" />"><c:out
																				value="${item.name}" /></option>
																	</c:if>
																</c:when>
																<c:when
																	test="${item['class'].superclass.simpleName == 'Option'}">
																	<c:if test="${item.active || item.obsolete}">
																		<option value="<c:out value="${item.id}" />"
																			title="<c:out value="${item.name}" />"><c:out
																				value="${item.name}" /></option>
																	</c:if>
																</c:when>
																<c:otherwise>
																	<option value="<c:out value="${item.name}" />"
																		title="<fmt:message key="${item}" />"><fmt:message
																			key="${item}" /></option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:if>
												</select>
											</c:when>
											<c:when test="${g.fieldOptionType == 'USERLIST'}">
												<select id="${label}" name="${label}" style="width: 100%;">
													<option value=""><fmt:message key="choose" /></option>
													<c:if
														test="${availableFieldsByName[g.questionName] != null}">
														<c:forEach
															items="${availableFieldsByName[g.questionName]}"
															var="item">
															<option value="<c:out value="${item.id}" />"><c:out
																	value="${item.sortableName}" /></option>
														</c:forEach>
													</c:if>
												</select>
											</c:when>
											<c:when test="${g.fieldOptionType == 'DATE'}">
												<div class="input-group date datetime col-md-5 col-xs-7"
													class="input-group date datetime " data-min-view="2"
													data-date-format="dd-MM-yyyy">
													<input class="form-control" style="width: 100%;"
														id="${g.questionName}" name="${g.questionName}"
														type="text" readonly> <span
														class="input-group-addon btn btn-primary"> <span
														class="glyphicon glyphicon-th"></span>
													</span>
												</div>

											</c:when>
										</c:choose>
								<c:set var="lineCount" value="${lineCount + 1 }"></c:set>
							</c:if>
						</div>
					</div>
					</c:when>
					<c:when test="${g.questionName == 'processSafety' }">
						<div class="col-sm-6 col-md-6">
							<div class="form-group"  style="border-bottom: 0px">
								<label class="control-label scannellGeneralLabel nowrap" style="width: 100%; text-align: left;">
									<fmt:message key="processSafety" />
								</label>
								<input type="checkbox" id="processSafety" name="processSafety" value="true" />
							</div>
						</div>
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
	</c:forEach> 

<!-- START: Investigation Fields -->
	<div class="row">
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
				<label class="scannellGeneralLabel ">
					<fmt:message key="environmentalAspectType" />
				</label>
				<select id="environmentalAspectTypeId" name="environmentalAspectTypeId" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${environmentalAspects}" var="item">
						<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
					</c:forEach>
				</select>
			</div>

		</div>
		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="control-label scannellGeneralLabel nowrap">
					<fmt:message key="environmentalImpactType" />
				</label>
				<select id="environmentalImpactTypeId" name="environmentalImpactTypeId" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${environmentalImpacts}" var="item">
						<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="scannellGeneralLabel ">
					<fmt:message key="healthHazardType" />
				</label>
				<select id="healthHazardTypeId" name="healthHazardTypeId" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${healthHazards}" var="item">
						<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
					</c:forEach>
				</select>
			</div>

		</div>

		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="scannellGeneralLabel ">
					<fmt:message key="qualityImpactType" />
				</label>
				<select id="qualityImpactTypeId" name="qualityImpactTypeId" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${qualityImpacts}" var="item">
						<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
					</c:forEach>
				</select>
			</div>

		</div>

	</div>

	<c:forEach var="templateQuestion" items="${incidentAvailableFieldsByName}" varStatus="s">
		<c:if test="${templateQuestion.investigationField}">
			<c:set var="g" value="${templateQuestion}" />
				<c:if test="${g.questionName != 'durationForm' && g.questionName != 'operatingHoursLost' && g.questionName != 'investigationAppByAreaOwner' && g.questionName != 'areaOwnerComments'}">
					<c:choose>
						<c:when test="${g.questionName == 'numberManDaysLost'}">					
								<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label class="scannellGeneralLabel ">
											<fmt:message key="minTotalManDaysLost" />
										</label>
										<input type="text" name="totalManDaysLost" id="totalManDaysLost" style="width: 100%;" />
										<c:out value="*When using date fields Incident must have occurred between the dates"></c:out>
									</div>
						
								</div>
						</c:when>
						<c:when test="${g.questionName == 'areaOwner'}">
								<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label class="control-label scannellGeneralLabel nowrap">
											<fmt:message key="AreaOwner" />
										</label>
										<select id="areaOwner" name="areaOwner" style="width: 100%;">
											<option value=""><fmt:message key="choose" /></option>
											<c:forEach items="${approvalUserList}" var="item">
												<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
													<c:out value="${item.sortableName}" />
												</option>
											</c:forEach>
										</select>
									</div>
								</div>
						</c:when>
						<c:when test="${g.questionName == 'reportable'}">
							<div class="row">
								<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label class="scannellGeneralLabel ">
											<fmt:message key="reportee" />
										</label>
										<select id="reporteeId" name="reporteeId" style="width: 100%;">
											<option value=""><fmt:message key="choose" /></option>
											<c:forEach items="${reportees}" var="item">
												<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
											</c:forEach>
										</select>
									</div>
		
								</div>
								<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label class="control-label scannellGeneralLabel nowrap">
											<fmt:message key="reportedExternally" />
										</label>
										<select id="reportedExternally" name="reportedExternally" style="width: 100%;">
											<option value=""><fmt:message key="choose" /></option>
											<option value="true"><fmt:message key="true" /></option>
											<option value="false"><fmt:message key="false" /></option>
										</select>
									</div>
								</div>
							</div>
						</c:when>
						<c:when test="${g.questionName == 'causeCategory'}">
							<div class="row">
									<div class="col-sm-6 col-md-6">
										<div class="form-group">
											<label class="scannellGeneralLabel ">
												<fmt:message key="causeCategory" />
											</label>
											<select id="causeType" name="causeType" style="width: 100%;">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${causeTypeCategories}" var="item">
													<option value="<c:out value="${item.name}" />"><c:out value="${item.name}" /></option>
												</c:forEach>
											</select>
										</div>
							
									</div>
									<div class="col-sm-6 col-md-6">
										<div class="form-group">
											<label class="control-label scannellGeneralLabel nowrap">
												<fmt:message key="rootCause" />
											</label>
											<select id="rootCauseId" name="rootCauseId" style="width: 100%;">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${causeTypes}" var="item">
													<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
												</c:forEach>
											</select>
										</div>
									</div>
							</div>
						</c:when>
					</c:choose>
				</c:if>
			</c:if>
	</c:forEach>
<!-- END: Investigation Fields -->

	<div class="row">
		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="control-label scannellGeneralLabel nowrap">
					<fmt:message key="primaryGroupByName" />
				</label>
				<input type="hidden" name=aggregateName value="total" />
				<select id="primaryGroupByName" name="primaryGroupByName" style="width: 100%;">
					<option value="type"><fmt:message key="choose" /></option>
					<c:forEach items="${primaryGroupBys}" var="item">
						<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
					</c:forEach>
				</select>
			</div>
		</div>


		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="scannellGeneralLabel ">
					<fmt:message key="secondaryGroupByName" />
				</label>
				<select id="secondaryGroupByName" name="secondaryGroupByName" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${secondaryGroupBys}" var="item">
						<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
					</c:forEach>
				</select>
			</div>

		</div>

	</div>
	
<div class="row">

		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="scannellGeneralLabel ">
					<fmt:message key="createdBy" />
				</label>
				<c:choose>
					<c:when test="${fn:length(allUsers)  lt maxListSize && fn:length(allUsers) > 0}">
						<select name="createdByUser" id="createdByUser" style="width:100%;">
			              	<option value=""><fmt:message key="choose" /></option>
			              		<c:forEach items="${allUsers}" var="item">
			              			<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
			              		</c:forEach>
			           </select>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="createdByUser" name="createdByUser" />
					</c:otherwise>
				</c:choose>
				<%-- <select id="createdByUser" name="createdByUser" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${allUsers}" var="item">
						<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
							<c:out value="${item.sortableName}" />
						</option>
					</c:forEach>
				</select> --%>
			</div>

		</div>
		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="scannellGeneralLabel ">
					<fmt:message key="createdByDepartment" />
				</label>
				<select id="createdByUserDepartmentId" name="createdByUserDepartmentId" style="width: 100%;">
					<option value=""><fmt:message key="choose" /></option>
					<c:forEach items="${departments}" var="item">
						<option value="<c:out value="${item.id}" />"
							title="<c:out value="${item.name}" />"
							<c:if test="${item.id == status.value}">selected="selected"</c:if>>
							<c:out value="${item.name}" /></option>
					</c:forEach>
				</select>
			</div>

		</div>

	</div>

	<div class="row">
		<div class="col-sm-6 col-md-6">
			<div class="form-group">
				<label class="control-label scannellGeneralLabel nowrap">
					<fmt:message key="sortName" />
				</label>
				<select id="sortName" name="sortName" style="width: 100%;">
					<c:forEach items="${sorts}" var="item">
						<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
					</c:forEach>
				</select>
			</div>
		</div>


		

	</div>



	<div class="spacer2 text-center" >
		<button type="submit" class="g-btn g-btn--primary"
			onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);resetExcelRequest();setToogleQueryAdvancedSearch();">
			<fmt:message key="search" />
		</button>
		<button type="button" class="g-btn g-btn--primary"
			onClick="resetExcelRequest();return summarise(this.form, '/incident/summariseIncidents.jpeg')">
			<fmt:message key="viewSummaryChart" />
		</button>
		<c:if test="${createExcel == true}">
			<button type="submit" class="g-btn g-btn--primary"
				onClick="excelRequest();this.form.pageNumber.value = 1;setExcelNo();">
				<fmt:message key="exportToExcel" />
			</button>
		</c:if>
		<button type="button" class="g-btn g-btn--secondary" onClick="resetExcelRequest();clearForm()">
			<fmt:message key="reset" />
		</button>
		<input type="hidden" name="chartWidth" value="600" />
		<input type="hidden" name="chartHeight" value="400" />
		<input type="hidden" id="excel" name="excel" value="NO" />
		<input type="hidden" id="answerOptionIds" name="answerOptionIds" value="" />
		<input type="hidden" id="answerCheckBoxes" name="answerCheckBoxes" value="" />
		<input type="hidden" id="answerText" name="answerText" value="" />
	</div>
	</div>
	<div id="searchCriteria.summary"></div>
	<div id="resultsDiv"></div>

	</form>

</body>
</html>
