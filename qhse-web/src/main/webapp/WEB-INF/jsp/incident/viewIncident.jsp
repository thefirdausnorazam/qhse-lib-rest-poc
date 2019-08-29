<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<c:set scope="request" var="incidentAvailableFieldsByName" value="${incident.availableFieldsByName}" /> <!-- copy to request scope for incident tag file -->
<c:set scope="request" var="incidentAvailableActiveFieldsByName" value="${incident.availableActiveFieldsByName}" /> <!-- copy to request scope for incident tag file -->

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
  <%-- <script type="text/javascript" src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script> --%>
  <style type="text/css">
  @media print {
  .tab-content > .tab-pane {display: block !important; opacity: 1 !important;}
 }
  </style>
    <style type="text/css" media="print">

.page     {
	font-size: .7em; 
	zoom: 1;
	overflow:hidden !important;size: landscape;
     }
.nowrap{}

div { width: 100%;     border: 0;   overflow: visible; size: auto;} 


body{width: 100%;}
</style>
   <script type="text/javascript">
   var tablesInitialised = false;
  jQuery(document).ready(function(){
	  jQuery('.hideDependantQuestion').closest("tr").hide();
    jQuery("#myTab li:eq(0) a").tab('show');
    
    jQuery('.nav-tabs > li ').hover( function(){
        if(jQuery(this).hasClass('hoverblock'))
            return;
        else
        	jQuery(this).find('a').tab('show');
   });


    jQuery('.nav-tabs > li').find('a').click( function(){
    	jQuery(this).parent()
        .siblings().addClass('hoverblock');
   });
    var url  = window.location.href;
    if(window.location.href.indexOf("#") >= 0){
    	var tab = url.split("#");
    	 $('a[href="#'+tab[1]+'"]').click();
    }
    jQuery('.nav-tabs > li').find('a#actions').hover( function(){
    	if(!tablesInitialised)
    	{
			tablesInitialised = true;
    		initSortTables();
    	}
   });
    jQuery('.keepSpaceFormatting').css({"white-space": "pre-line"})
});
  
  function openRiskWindow(url) {	    
	  jQuery("#dialogFrame").attr("src", url);
	  jQuery( "#dialogDiv" ).dialog();
      jQuery("#dialogDiv").dialog("open");
      jQuery("#dialogDiv").dialog('option', 'title', 'Upload Docs');
  }
  jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="800" height="550" marginWidth="0" close="yes" marginHeight="0" frameBorder="0" src="about:blank" />');
  
  function resizeWindowPopup(){
	  jQuery('#dialogFrameWindow').width('1600');
  }
</script>
</head>
<body><div class="page">
<div class="header">
<h2><fmt:message key="viewIncident" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<ul class="nav nav-tabs nav-justified " id="myTab" >
        <li><a data-toggle="tab" href="#sectionA"><span class="tabHead"><fmt:message key="incidentDetails" /></span></a></li>
        <li><a data-toggle="tab" href="#sectionB"><span class="tabHead"><fmt:message key="investigationDetails" /></span></a></li>
        <li><a id="actions" data-toggle="tab" href="#sectionC"><span class="tabHead"><fmt:message key="actionSummary" /></span></a></li>
        
    </ul>
    <div class="tab-content">
        <div id="sectionA" class="tab-pane fade in active">
        <div class="header">
        <h3><fmt:message key="incidentDetails" /></h3>
        </div>
        <div class="content"> 
        <div class="panel">

       
        
        <c:set var="updateIncidentAllowed" value="${incident.site.id == site.id}" />
<a name="incident"></a>

<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />

<tbody>
  <tr>
    <td ><fmt:message key="id" /></td>
    <td><c:out value="${incident.id}"/> <c:if test="${incident.confidential}"> <font color="red"><c:out value="CONFIDENTIAL"/></font></c:if></td>
  </tr>
  <c:if test="${showLegacyId}">
  <tr>
    <td >Legacy Id</td>
    <td colspan="3"><scannell:text value="${incident.legacyId}" /></td>
  </tr>
  </c:if>
  <c:set var="source" value="${incident.source}" />
  <c:if test="${source != null}">
  <tr>
    <td ><fmt:message key="source" /></td>
    <td><scannell:entityUrl entity="${source}" messageCodePrefix="auditResult."/></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="type" /></td>
    <td><fmt:message key="${incident.type.type.key}" />  <c:out value="${incident.type.name}" /></td>
  </tr>
  
  <tr> 
    <td ><fmt:message key="status" /></td>
    <td><fmt:message key="${incident.status.name}" />  <c:if test="${incident.incidentClosureDate != null}"><fmt:message key="at" /> <fmt:formatDate value="${incident.incidentClosureDate}" pattern="dd-MMM-yyyy HH:mm:ss" /></c:if></td>
    
  </tr>
  <c:if test="${incident.incidentClosureDate != null}">
	  <tr>
	    <td><fmt:message key="closingComment" /></td>
	    <td><c:out value="${incident.closingComment}" /></td>
	  </tr>
  </c:if>
	<incident:displayField name="description" when="${incident.sensitiveDescriptionDataViewable}" confidential="${true}">
    	<div class="bigtext keepSpaceFormatting" ><c:out value="${fieldValue}" /></div>
  	</incident:displayField>

  	<fmt:message key="incident.enableAdditionalFields" var="enable" />
  
  <incident:displayField name="occurredTime" >
    <fmt:formatDate value="${fieldValue}" pattern="dd-MMM-yyyy HH:mm:ss" />
  </incident:displayField>
  	
<c:if test="${!empty incident.superType.incidentQuestionGroups}">
  	<c:forEach var="group" items="${incident.superType.incidentQuestionGroups}" varStatus="s">
		<c:set var="groupDiv" value="g${group.id}"/>
		<tr><td colspan="2">							
			<h2><c:out value="${group.name}"/></h2>
		</td></tr>
			<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
				<c:if test="${templateQuestion.active}">
				<c:choose>
					<c:when test="${templateQuestion.incidentField}">
						<c:choose>
							<c:when test="${templateQuestion.questionName == 'severity'}">
								  <incident:displayField name="severity" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'severityRisk'}">
								  <incident:displayField name="severityRisk" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'capaProject'}">
								  <incident:displayField name="capaProject" whenNotNull="true" >
								 	<fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'capaProjectAnswears'}">
								   <incident:displayField name="capaProjectAnswears" when="${!empty incident.capaProjectAnswears}">
								    <c:forEach items="${fieldValue}" var="item">
								     <c:out value="${item.name}" /><br />
								    </c:forEach>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'actualSeverity'}">
								  <incident:displayField name="actualSeverity" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'potentialSeverity'}">
								  <incident:displayField name="potentialSeverity" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'processSeverity'}">
								  <incident:displayField name="processSeverity" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'severityRanking'}">
								  <incident:displayField name="severityRanking" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'qualitySeverity'}">
								  <incident:displayField name="qualitySeverity" whenNotNull="true" >
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'severityRiskEvent'}">
								  <incident:displayField name="severityRiskEvent" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'programmeImpacts'}">
								   <incident:displayField name="programmeImpacts" when="${!empty incident.programmeImpacts}">
								    <c:forEach items="${fieldValue}" var="item">
								     <c:out value="${item.name}" /><br />
								    </c:forEach>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'businessAreas'}">
							  <tr>
							    <td ><fmt:message key="businessAreas" /></td>
							    <td>
							    	<ul>
							      		<c:forEach var="ba" items="${incident.businessAreas}">
							        		<li><c:out value="${ba.name}" /></li>
							      		</c:forEach>
								    </ul>
							    </td>
							  </tr>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'shift'}">
								  <incident:displayField name="shift" whenNotNull="true" >
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'location'}">
								  <incident:displayField name="location" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'department'}">
								  <incident:displayField name="department" >
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'workArea'}">
								  <incident:displayField name="workArea">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'location2'}">
								  <incident:displayField name="location2">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'incidentSource'}">
								  <incident:displayField name="incidentSource">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'incidentCategory'}">
								   <incident:displayField name="incidentCategory">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'equipmentLocation'}">
								  <incident:displayField name="equipmentLocation" when="${incident.equipmentLocation != null || incident.equipment != null || (incident.equipmentId != '' && incident.equipmentId != null)}" >
								    <c:if test="${incident.equipmentLocation != null}"><c:out value="${incident.equipmentLocation.name}" /></c:if>
								    <c:if test="${incident.equipmentLocation != null && incident.equipment != null}">, </c:if><c:if test="${incident.equipment != null}"> <c:out value="${incident.equipment.name}" /> </c:if>
								    <c:if test="${incident.equipmentId != '' && incident.equipmentLocation != null || incident.equipment != null }">, </c:if> <c:if test="${incident.equipmentId != ''}"><c:out value="${incident.equipmentId.name}" /></c:if>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'process'}">
								  <incident:displayField name="process" labelOverride="incidentProcess" when="${(incident.process != '' && incident.process != null) || (incident.batch != '' && incident.batch != null) }" >
								     <c:if test="${incident.process != null}"><c:out value="${incident.process.name}" /></c:if>
								     <c:if test="${incident.process != null && incident.batch != ''}"> & </c:if>
								     <c:if test="${incident.batch != ''}"><c:out value="${incident.batch}" /></c:if>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'supervisor'}">
								    <incident:displayField name="supervisor" when="${incident.supervisor != null }" >
								    <c:out value="${incident.supervisor.displayName}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'workGroup'}">
								  <incident:displayField name="workGroup" when="${incident.workGroup != null && incident.workGroup != ''}" >
								    <c:out value="${incident.workGroup}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'workOrderNumber'}">
								  <incident:displayField name="workOrderNumber" when="${incident.workOrderNumber != null && incident.workOrderNumber != ''}" >
								    <c:out value="${incident.workOrderNumber}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'bagNumber'}">
								  <incident:displayField name="bagNumber" when="${!empty incident.bagNumber}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'packType'}">
								  <incident:displayField name="packType" when="${!empty incident.packType}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'amountQuantity'}">
								  <incident:displayField name="amountQuantity" when="${!empty incident.amountQuantity}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'scope'}">
								  <incident:displayField name="scope" when="${!empty incident.scope}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'sample'}">
								  <incident:displayField name="sample">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'sampleDetails'}">
								  <incident:displayField name="sampleDetails" when="${!empty incident.sampleDetails}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'team'}">
								  <incident:displayField name="team" when="${incident.team != null && incident.team != 'None' && incident.team != '0'}" >
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'immediateAction'}">
								  <incident:displayField name="immediateAction" >
								    <div class="bigtext keepSpaceFormatting"><c:out value="${fieldValue}" /></div>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'customerAcknowledgement'}">
								  <incident:displayField name="customerAcknowledgement">
								    <c:out value="${fieldValue.name}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'acknowledgementDetails'}">
								  <incident:displayField name="acknowledgementDetails" when="${!empty incident.acknowledgementDetails}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'processSafety'}">
								  <incident:displayField name="processSafety" when="${!empty incident.processSafety}" >
								    <fmt:message key="${incident.processSafety}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'firstAidTreatment'}">
								  <incident:displayField name="firstAidTreatment" when="${!empty incident.firstAidTreatment}" >
								    <c:out value="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'firstAidOutcome'}">
								  <incident:displayField name="firstAidOutcome" when="${incident.firstAidOutcome != null && incident.firstAidOutcome != '0' && incident.firstAidOutcome != ''}" >
								    <fmt:message key="FirstAidOutcome[${fieldValue}]" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'ohnNotified'}">
								  <incident:displayField name="ohnNotified" whenNotNull="true" >
								    <fmt:message key="${fieldValue}" />
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'participants'}">
								  <incident:displayField name="participants" when="${incident.sensitiveParticipantsDataViewable}" confidential="${true}">
								    <display:table class="read" name="${fieldValue}" uid="datum" id="row">
								      <display:column titleKey="name" property="sensitiveName" />
								      <display:column titleKey="type" property="typeNameFromMessage" />
								      <display:column titleKey="bodyPart" property="bodyPartNameFromMessage"  />
								      <display:column titleKey="role" property="roleNameFromMessage" />
								      <display:column titleKey="department" property="department.name" />
								      <display:column titleKey="injuryType" property="injuryType.name" />
								      <display:column class="scrolllist keepSpaceFormatting" titleKey="injuryDesc"  property="injuryDescription" />
								      <display:column titleKey="bodyPartPic" >
								      	<c:if test="${not empty row.bodyPartPic}">
								      		<img src="${row.bodyPartPic}"/>
								      	</c:if>
								      </display:column>
								    </display:table>
					     		  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'assignees'}">
								  <incident:displayField name="assignees" >
								    <c:forEach items="${fieldValue}" var="item">
								      <c:out value="${item.displayName}" /><c:if test="${not item.active}"> (<fmt:message key="userInactive" />)</c:if><br />
								    </c:forEach>
								  </incident:displayField>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'communicatedTo'}">
								  <incident:displayField name="communicatedTo" labelOverride="incident.viewIncident.communicatedTo" >
								    <c:forEach items="${fieldValue}" var="item">
								      <c:out value="${item.displayName}" /><c:if test="${not item.active}"> (<fmt:message key="userInactive" />)</c:if><br />
								    </c:forEach>
								  </incident:displayField>
							</c:when>
						</c:choose>
					</c:when>
					<c:otherwise>	
						<tr <c:if test="${templateQuestion.question.answerType.name=='textarea'}"> class="keepSpaceFormatting" </c:if>>
						  	<td class=""><c:out value="${templateQuestion.question.name}" />
						  	</td>
						  	<td id="answers[<c:out value="${templateQuestion.question.id}"/>]" colspan="3"><c:choose><c:when test="${templateQuestion['class'].name == 'com.scannellsolutions.modules.client.domain.ClientTemplateQuestion'}"
						  	><c:out value="${enviromanager:getAnswerWithPreviousValues(templateQuestion.question,incident.answers)}"></c:out></c:when><c:otherwise></c:otherwise></c:choose></td>						  	
						</tr>
					</c:otherwise>
				</c:choose>
				</c:if>
		 	</c:forEach>
	</c:forEach>
</c:if>

<!-- START: Show Historic Data if Exists -->
  <incident:displayHistoricField name="severity" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="severityRisk" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="capaProject" whenNotNull="true" >
 	<fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
   <incident:displayHistoricField name="capaProjectAnswears" when="${!empty incident.capaProjectAnswears}">
    <c:forEach items="${fieldValue}" var="item">
     <c:out value="${item.name}" /><br />
    </c:forEach>
  </incident:displayHistoricField>
  <incident:displayHistoricField name="actualSeverity" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="potentialSeverity" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="processSeverity" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="severityRanking" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="qualitySeverity" whenNotNull="true" >
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="severityRiskEvent" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>					
<incident:displayHistoricField name="programmeImpacts" when="${!empty incident.programmeImpacts}">
    <c:forEach items="${fieldValue}" var="item">
     <c:out value="${item.name}" /><br />
    </c:forEach>
  </incident:displayHistoricField>

  <incident:displayHistoricField name="shift" whenNotNull="true" >
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>

  <incident:displayHistoricField name="location" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="workArea">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="location2">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="incidentSource">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  
   <incident:displayHistoricField name="incidentCategory">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  
  
  <incident:displayHistoricField name="equipment" when="${incident.equipmentLocation != null || incident.equipment != null || (incident.equipmentId != '' && incident.equipmentId != null)}" >
    <c:if test="${incident.equipmentLocation != null}"><c:out value="${incident.equipmentLocation.name}" /></c:if>
    <c:if test="${incident.equipmentLocation != null && incident.equipment != null}">, </c:if><c:if test="${incident.equipment != null}"> <c:out value="${incident.equipment.name}" /> </c:if>
    <c:if test="${incident.equipmentId != '' && incident.equipmentLocation != null || incident.equipment != null }">, </c:if> <c:if test="${incident.equipmentId != ''}"><c:out value="${incident.equipmentId.name}" /></c:if>
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="process" labelOverride="incidentProcess" when="${(incident.process != '' && incident.process != null) || (incident.batch != '' && incident.batch != null) }" >
     <c:if test="${incident.process != null}"><c:out value="${incident.process.name}" /></c:if>
     <c:if test="${incident.process != null && incident.batch != ''}"> & </c:if>
     <c:if test="${incident.batch != ''}"><c:out value="${incident.batch}" /></c:if>
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="bagNumber" when="${!empty incident.bagNumber}" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="scope" when="${!empty incident.scope}" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="sample">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="sampleDetails" when="${!empty incident.sampleDetails}" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="team" when="${incident.team != null && incident.team != 'None' && incident.team != '0'}" >
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>

  <incident:displayHistoricField name="immediateAction" >
    <div class="bigtext"><c:out value="${fieldValue}" /></div>
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="customerAcknowledgement">
    <c:out value="${fieldValue.name}" />
  </incident:displayHistoricField>
  
  <incident:displayHistoricField name="acknowledgementDetails" when="${!empty incident.acknowledgementDetails}" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="processSafety" when="${incident.processSafety}" >
    <fmt:message key="${incident.processSafety}" />
  </incident:displayHistoricField>
  <incident:displayHistoricField name="firstAidTreatment" when="${!empty incident.firstAidTreatment}" >
    <c:out value="${fieldValue}" />
  </incident:displayHistoricField>

  <incident:displayHistoricField name="firstAidOutcome" when="${incident.firstAidOutcome != null && incident.firstAidOutcome != '0' && incident.firstAidOutcome != ''}" >
    <fmt:message key="FirstAidOutcome[${fieldValue}]" />
  </incident:displayHistoricField>

  <incident:displayHistoricField name="ohnNotified" when="${incident.ohnNotified}" whenNotNull="true" >
    <fmt:message key="${fieldValue}" />
  </incident:displayHistoricField>

  <incident:displayHistoricField name="participants" when="${incident.sensitiveParticipantsDataViewable}" confidential="${true}">
    <display:table class="read" name="${fieldValue}" uid="datum" id="row">
      <display:column titleKey="name" property="sensitiveName" />
      <display:column titleKey="type" property="typeNameFromMessage" />
      <display:column titleKey="bodyPart" property="bodyPartNameFromMessage" />
      <display:column titleKey="role" property="roleNameFromMessage" />
      <display:column titleKey="department" property="department.name" />
      <display:column titleKey="injuryType" property="injuryType.name" />
      <display:column class="scrolllist keepSpaceFormatting" titleKey="injuryDesc"  property="injuryDescription" />
      
    </display:table>
  </incident:displayHistoricField>
<%--       <c:if test="${!incident.sensitiveDataViewable}"> <c:out value="Confidential"/></c:if> --%>

  <incident:displayHistoricField name="assignees"  when="${!empty incident.assignees}" >
    <c:forEach items="${fieldValue}" var="item">
      <c:out value="${item.displayName}" /><c:if test="${not item.active}"> (<fmt:message key="userInactive" />)</c:if><br />
    </c:forEach>
  </incident:displayHistoricField>

  <incident:displayHistoricField name="communicatedTo"  when="${!empty incident.communicatedTo}" labelOverride="incident.viewIncident.communicatedTo" >
    <c:forEach items="${fieldValue}" var="item">
      <c:out value="${item.displayName}" /><c:if test="${not item.active}"> (<fmt:message key="userInactive" />)</c:if><br />
    </c:forEach>
  </incident:displayHistoricField>
  
  
  <if test="${! empty historicIncidentAnswers}">
	  <c:forEach var="historicAnswer" items="${historicIncidentAnswers}" varStatus="loop">
			<tr>
			  	<td class=""><c:out value="${historicAnswer.question.name}" /></td>
			  	<td id="answers[<c:out value="${historicAnswer.question.id}"/>]" colspan="3"><enviromanager:answer question="${historicAnswer.question}" answers="${historicIncidentAnswers}" /></td>
			</tr>
	  </c:forEach>
  </if>
<!-- END: Show Historic Data if Exists -->

  <tr>
    <td ><fmt:message key="active" /></td>
    <td><fmt:message key="${incident.active}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${incident.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${incident.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${incident.lastUpdated != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" /></td>
    <td>
      <c:out value="${incident.lastUpdated.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${incident.lastUpdated.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>

  <incident:displayField name="investigationClosureDate" whenNotNull="true">
    <fmt:formatDate value="${fieldValue}" pattern="dd-MMM-yyyy" />
  </incident:displayField>
  
  <c:if test="${incident.sensitiveDataViewable}">
    <incident:displayField name="attachments" confidential="${true}">
		<incident:attachments urlPrefix="viewIncidentAttachment" attachments="${incident.attachments}" />
    </incident:displayField>
  </c:if>

</tbody>
<tfoot>
  <tr>
    <td colspan="3">
    <div>
    	<c:choose>
    		<c:when test="${updateIncidentAllowed}">
		      <c:if test="${incident.editable && isPermitedToAttach}">
			        <a href="<c:url value="editIncident.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="editIncident" /></a> |
				      <c:if test="${incident.closableState and incident.canCreateInvestigation}">
				        <a href="<c:url value="closeIncident.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="closeIncident" /></a> |
				      </c:if>  
			        <c:if test="${incident.displayConfidential}">
			          <c:choose>
			          <c:when test="${incident.confidential}">
			            <a href="<c:url value="toggleConfidential.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="incident.undoConfidential" /></a> |
			          </c:when>
			          <c:otherwise>
			            <a href="<c:url value="toggleConfidential.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="incident.makeConfidential" /></a> |
			          </c:otherwise>
			          </c:choose>
			        </c:if>
			        <c:if test="${incident.displayAccessLevel}">
			             <a href="<c:url value="incidentAccessLevel.htm"><c:param name="ownerId" value="${incident.id}" /><c:param name="showId" value="${incident.accessLevel.id}" /></c:url>"><fmt:message key="accessLevel" /></a> |  
			        </c:if>
			       <incident:displayField name="attachments" noHtml="true">
			        	<a href="<c:url value="addIncidentAttachment.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="addAttachment" /></a> |
				    	<c:if test="${!empty incident.attachments}">
				    	<c:if test="${incident.sensitiveDataViewable}">
				      		<a href="<c:url value="editIncidentAttachments.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="editAttachments" /></a> |
				    	</c:if>
				    	</c:if>
				    </incident:displayField>
			      </c:if>
			      <c:if test="${incident.lastUpdatedByUser != null || incident.answersUpdated}">
			        <a href="javascript:openParentChildHistory(<c:out value="${incident.id},'${incident['class'].name}','${incident.answerIdsCSV}','incidentAnswer'" />)"><fmt:message key="viewHistory" /></a> 
		      </c:if>
			</c:when>
			<c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${incident.site.name}" /></fmt:message></c:otherwise> 
      </c:choose>
      </div>
    </td>
  </tr>
</tfoot>
</table>
</div>
     
</div> 
</div>          
</div>

<div id="sectionB" class="tab-pane fade">
   
   <c:if test="${incident.investigation ne null or (incidentAvailableFieldsByName['investigation'] ne null and !incident.closed)}">

<a name="investigation"></a>
<c:set var="investigation" value="${incident.investigation}" />

<div class="header">
        <h3><fmt:message key="investigationDetails" /></h3>
</div>
<div class="content"> 
<div class="panel" >
 
<div class="table-responsive">

<table class="table table-responsive table-bordered">
<col/>


<c:choose>
  <c:when test="${investigation == null}">
  <div class="panel-heading" style="text-align: center;" >
  Investigation Not Started
  </div>  
  </c:when>
  <c:otherwise>
  <thead>
  <tr>
    <td colspan="6" >
      
      <c:forEach items="${licences}" var="item">
        <c:choose>
          <c:when test="${item=='law'}">
            <c:url value="/legal/front/checklists/IncidentRelatedChecklists.jsp" var="url">
              <c:param name="aspectId" value="${investigation.environmentalAspectType.masterId}" />
              <c:param name="hazardId" value="${investigation.healthHazardType.masterId}" />
            </c:url>
            <a alt="<fmt:message key="elaw.giff.alt" />" onclick="openWindow('<c:out value="${url}" />', 640, 480, false, 'law', true);"><span class="badge badge-primary"><fmt:message key="law.badge.alt" /></span></a>
          </c:when>
          <c:when test="${item=='risk' && investigation.qualityOnly}">
          	<c:url value="/risk/assessmentQueryResultForDialog.htm" var="url">
              <c:param name="popup"           value="true" />
              <c:param name="calculateTotals" value="true" />
              <c:param name="pageNumber"      value="1" />
              <c:param name="pageSize"        value="10" />
              <c:param name="status"          value="COMPLETE" />
              <c:param name="answers[21]" value="0" />
              <c:param name="answers[46]" value="0" />
              <c:param name="answers[39]" value="0" />
              <c:param name="answers[300295]" value="0" />
              <c:param name="answers[300287]" value="0" />
            </c:url>
           	<a alt="<fmt:message key="erisk.giff.alt" />" onclick="openWindow('<c:out value="${url}" />', 640, 480, false, 'risk', false);resizeWindowPopup()"><span class="badge badge-danger"><fmt:message key="risk.badge.alt" /></span></a>
          </c:when>
          <c:when test="${item=='risk'}">
          	<c:url value="/risk/assessmentQueryResultForDialog.htm" var="url">
              <c:param name="popup"           value="true" />
              <c:param name="calculateTotals" value="true" />
              <c:param name="pageNumber"      value="1" />
              <c:param name="pageSize"        value="10" />
              <c:param name="status"          value="COMPLETE" />
              <c:param name="answers[21]" value="${investigation.environmentalAspectType.id}" />
              <c:param name="answers[46]" value="${investigation.environmentalImpactType.id}" />
              <c:param name="answers[39]" value="${investigation.healthHazardType.id}" />
              <c:param name="answers[300295]" value="${investigation.environmentalAspectType.id}" />
              <c:param name="answers[300287]" value="${investigation.healthHazardType.id}" />
            </c:url>
           	<a alt="<fmt:message key="erisk.giff.alt" />" onclick="openWindow('<c:out value="${url}" />', 640, 480, false, 'risk', false);resizeWindowPopup()"><span class="badge badge-danger"><fmt:message key="risk.badge.alt" /></span></a>
          </c:when>
        </c:choose>
      </c:forEach>
    </td>
  </tr>
  </thead>
  	<tbody>
 	 	<c:forEach var="ba" items="${businessAreaList}">
			<c:choose>
				<c:when test="${ba.name == 'Health & Safety'}">
					  <tr>
					    <td ><fmt:message key="healthHazardType" /></td>
					    <td><c:out value="${investigation.healthHazardType.name}" /></td>
					  </tr>
				</c:when>
				<c:when test="${ba.name == 'Environmental'}">
					  <tr>
					    <td ><fmt:message key="environmentalAspectType" /></td>
					    <td><c:out value="${investigation.environmentalAspectType.name}" /></td>
					  </tr>
				  		<tr>
                          	<td ><fmt:message key="environmentalImpactType" /></td>
   							<td><c:out value="${investigation.environmentalImpactType.name}" /></td>
 						</tr>
				</c:when>
				<c:when test="${ba.name == 'Quality'}">
				  	<tr>
                     	<td ><fmt:message key="qualityImpactType" /></td>
   						<td><c:out value="${investigation.qualityImpactType.name}" /></td>
 					</tr>
 				</c:when>
 			</c:choose>
 		</c:forEach>
	  							<c:if test="${enable}">
	  								<c:if test="${investigation.dtoBypass != null}">
	  									<tr>
	    									<td ><fmt:message key="incident.editInvestigation.dtoTable.dtoBypass" /></td>
	    									<td>
	      										<c:if test="${investigation.dtoBypass.rateEmission != null}">
	        										<fmt:message key="incident.editInvestigation.dtoTable.rateEmission" />: <c:out value="${investigation.dtoBypass.rateEmission}"/>,
	      										</c:if>
	      										<c:if test="${investigation.dtoBypass.massEmission != null}">
		       	 									<fmt:message key="incident.editInvestigation.dtoTable.massEmission" />: <c:out value="${investigation.dtoBypass.massEmission}"/>,
		      									</c:if>
	      										<c:if test="${investigation.dtoBypass.type != null}">
	        										<fmt:message key="incident.editInvestigation.dtoTable.type" />: <c:out value="${investigation.dtoBypass.type}"/>,
	      										</c:if>
	      										<c:if test="${investigation.dtoBypass.keyword != null}">
	        										<fmt:message key="incident.editInvestigation.dtoTable.keyword" />: <c:out value="${investigation.dtoBypass.keyword.name}"/>,
	      										</c:if>
	    									</td>
	  									</tr>
	 						 		</c:if>
	  							</c:if>
  <c:if test="${!empty incident.superType.investigationQuestionGroups}">
  	<c:forEach var="group" items="${incident.superType.investigationQuestionGroups}" varStatus="s">
		<c:set var="groupDiv" value="g${group.id}"/>
		<tr><td colspan="2">							
			<h2><c:out value="${group.name}"/></h2>
		</td></tr>
			<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
				<c:if test="${templateQuestion.active}">
				<c:choose>
					<c:when test="${templateQuestion.investigationField}">
						<c:choose>
							<c:when test="${templateQuestion.questionName == 'durationForm'}">
								<c:if test="${investigation.duration != null}" >
  									<tr>
    									<td ><fmt:message key="duration" /></td>
    									<td><c:out value="${investigation.duration.amount}" /> <fmt:message key="${investigation.duration.unit}" /></td>
  									</tr>
  								</c:if>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'numberManDaysLost'}">
  								<tr>
    								<td ><fmt:message key="manDaysLost" /></td>
    								<td><c:out value="${investigation.manDaysLost}" /></td>
  								</tr>

  								<c:if test="${!empty investigation.manDaysLostRecouperationPeriods}">
  									<tr>
    									<td></td>
    									<td>
      										<display:table class="read" name="${investigation.manDaysLostRecouperationPeriods}" uid="datum" id="row">
        										<display:column group="1" titleKey="startDate" >
          											<fmt:formatDate value="${row.periodStartDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
        										</display:column>
        										<display:column titleKey="endDate" >
          											<fmt:formatDate value="${row.periodEndDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
        										</display:column>
      										</display:table>
    									</td>
  									</tr>
  								</c:if>

  								<tr>
    								<td ><fmt:message key="incident.viewIncident.restrictedDays" /></td>
    								<td><c:out value="${investigation.manDaysRestricted}" /></td>
  								</tr>

  								<c:if test="${!empty investigation.restrictedRecouperationPeriods}">
  									<tr>
    									<td></td>
    									<td>
      										<display:table class="read" name="${investigation.restrictedRecouperationPeriods}" uid="datum" id="row">
        										<display:column group="1" titleKey="startDate" >
          											<fmt:formatDate value="${row.periodStartDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
        										</display:column>
        										<display:column titleKey="endDate" >
          											<fmt:formatDate value="${row.periodEndDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
        										</display:column>
      										</display:table>
    									</td>
  									</tr>
  								</c:if>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'operatingHoursLost'}">
								  <tr>
								    <td ><fmt:message key="operatingHoursLost" /></td>
								    <td><c:out value="${investigation.operatingHoursLost}" /></td>
								  </tr>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'causeCategory'}">
								
								  <tr>
								    <td ><fmt:message key="causeType" /></td>
								    <td>
								      <display:table class="read" name="${investigation.causeTypes}" uid="datum" id="row">
								        <display:column group="1" titleKey="causeCategory" property="category" />
								        <display:column titleKey="causeType" property="description" class="keepSpaceFormatting"/>
								      </display:table>
								    </td>
								  </tr>
								
								  <tr>
								    <td ><fmt:message key="causeDescription" /></td>
								    <td class = "keepSpaceFormatting"><scannell:text value="${investigation.causeDescription}" /></td>
								  </tr>
															</c:when>
															<c:when test="${templateQuestion.questionName == 'reportable'}">
								  <tr>
								    <td ><fmt:message key="reportable" /></td>
								    <td ><fmt:message key="${investigation.reportable}" /></td>
								  </tr>
								
								  <c:if test="${investigation.reportable}">
								  <tr>
								    <td ><fmt:message key="reportees" /></td>
								    <td>
								    <div>
								      <c:forEach items="${investigation.reportees}" var="item" varStatus="s">
								        <c:if test="${!s.first}">, </c:if><c:out value="${item.name}"/>
								      </c:forEach>
								    </div>
								    </td>
								  </tr>
								  </c:if>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'investigationAppByAreaOwner'}">
								  <tr>
									<td ><fmt:message key="InvestigationAppByAreaOwner" /> </td>	
									<td><fmt:message key="${investigation.investigationAppByAreaOwner}" /></td>
								  </tr>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'areaOwnerComments'}">
								  <tr>
									<td ><fmt:message key="AreaOwnerComments" /> </td>
									<td class = "keepSpaceFormatting"><c:out value="${investigation.areaOwnerComments}" /> </td>
								  </tr>
							</c:when>
							<c:when test="${templateQuestion.questionName == 'areaOwner'}">
								  <tr>
									<td ><fmt:message key="AreaOwner" /> </td>
									<td class = "keepSpaceFormatting"><c:out value="${investigation.areaOwner.displayName}" /> </td>
								  </tr>
							</c:when>
						</c:choose>
					</c:when>
				<c:otherwise>	
					<tr>
						<td class=""><c:out value="${templateQuestion.question.name}" /></td>
						<td id="investigationAnswers[<c:out value="${templateQuestion.question.id}"/>]" colspan="3" <c:if test="${templateQuestion.question.answerType.name=='textarea'}"> class="keepSpaceFormatting" </c:if>><enviromanager:answer question="${templateQuestion.question}" answers="${investigation.investigationAnswers}" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
			</c:if>
		</c:forEach>
	</c:forEach>
</c:if>

<!-- START: Show Historic Data if Exists -->
<c:set var="activeInvestigationFields" value="${incident.superType.activeInvestigationFields}" />
<c:set var="configuredAvailableInvestigationFields" value="${incident.superType.configuredAvailableInvestigationFields}" />

<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'durationForm') || !enviromanager:contains(activeInvestigationFields, 'durationForm')) && investigation.duration != null && investigation.duration != ''}" >
  <tr>
    <td ><fmt:message key="duration" /></td>
    <td><c:out value="${investigation.duration.amount}" /> <fmt:message key="${investigation.duration.unit}" /></td>
  </tr>
</c:if>

<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'numberManDaysLost') || !enviromanager:contains(activeInvestigationFields, 'numberManDaysLost')) && investigation.manDaysLost != null && investigation.manDaysLost != ''}" >
  <tr>
    <td><fmt:message key="manDaysLost" /></td>
    <td><c:out value="${investigation.manDaysLost}" /></td>
  </tr>

	<c:if test="${!empty investigation.manDaysLostRecouperationPeriods}" >
	  <tr>
	    <td></td>
	    <td>
	      <display:table class="read" name="${investigation.manDaysLostRecouperationPeriods}" uid="datum" id="row">
	        <display:column group="1" titleKey="startDate" >
	          <fmt:formatDate value="${row.periodStartDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
	        </display:column>
	        <display:column titleKey="endDate" >
	          <fmt:formatDate value="${row.periodEndDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
	        </display:column>
	      </display:table>
	    </td>
	  </tr>
	  </c:if>
	  <tr>
	    <td ><fmt:message key="incident.viewIncident.restrictedDays" /></td>
	    <td><c:out value="${investigation.manDaysRestricted}" /></td>
	  </tr>

	  <c:if test="${!empty investigation.restrictedRecouperationPeriods}">
		  <tr>
		    <td></td>
		    <td>
		      <display:table class="read" name="${investigation.restrictedRecouperationPeriods}" uid="datum" id="row">
		        <display:column group="1" titleKey="startDate" >
		          <fmt:formatDate value="${row.periodStartDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
		        </display:column>
		        <display:column titleKey="endDate" >
		          <fmt:formatDate value="${row.periodEndDateAsDate}" pattern="dd-MMM-yyyy HH:mm"/>
		        </display:column>
		      </display:table>
		    </td>
		  </tr>
	  </c:if>
</c:if>
<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'operatingHoursLost') || !enviromanager:contains(activeInvestigationFields, 'operatingHoursLost')) && investigation.operatingHoursLost != null && investigation.operatingHoursLost != ''}" >
  <tr>
    <td ><fmt:message key="operatingHoursLost" /></td>
    <td><c:out value="${investigation.operatingHoursLost}" /></td>
  </tr>
</c:if>

<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'reportable') || !enviromanager:contains(activeInvestigationFields, 'reportable')) && investigation.reportable}">
  <tr>
    <td ><fmt:message key="reportable" /></td>
    <td><fmt:message key="${investigation.reportable}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="reportees" /></td>
    <td>
    <div>
      <c:forEach items="${investigation.reportees}" var="item" varStatus="s">
        <c:if test="${!s.first}">, </c:if><c:out value="${item.name}"/>
      </c:forEach>
    </div>
    </td>
  </tr>
  </c:if>
<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'investigationAppByAreaOwner') || !enviromanager:contains(activeInvestigationFields, 'investigationAppByAreaOwner')) && investigation.investigationAppByAreaOwner != null && investigation.investigationAppByAreaOwner != ''}" >  
	  <tr>
		<td ><fmt:message key="InvestigationAppByAreaOwner" /> </td>	
		<td><fmt:message key="${investigation.investigationAppByAreaOwner}" /></td>
	  </tr>
  </c:if>

  <c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'areaOwnerComments') || !enviromanager:contains(activeInvestigationFields, 'areaOwnerComments')) && investigation.areaOwnerComments != null && investigation.areaOwnerComments != ''}" >  
	<tr>
	<td ><fmt:message key="AreaOwnerComments" /> </td>
	<td><c:out value="${investigation.areaOwnerComments}" /> </td>
  </tr>
  </c:if>
<c:if test="${(!enviromanager:contains(configuredAvailableInvestigationFields, 'areaOwner') || !enviromanager:contains(activeInvestigationFields, 'areaOwner')) && investigation.areaOwner != null && investigation.areaOwner != ''}" >  
  <tr>
	<td ><fmt:message key="AreaOwner" /> </td>
	<td><c:out value="${investigation.areaOwner.displayName}" /> </td>
  </tr>
  </c:if>
    <c:if test="${! empty historicInvestigationAnswers}">
	  <c:forEach var="historicAnswer" items="${historicInvestigationAnswers}" varStatus="loop">
			<tr>
			  	<td class=""><c:out value="${historicAnswer.question.name}" /></td>
			  	<td id="answers[<c:out value="${historicAnswer.question.id}"/>]" colspan="3"><enviromanager:answer question="${historicAnswer.question}" answers="${historicInvestigationAnswers}" /></td>
			</tr>
	  </c:forEach>
  </c:if>
<!-- END: Show Historic Data if Exists -->

  <tr>
    <td ><fmt:message key="status" /></td>
    <td><fmt:message key="${investigation.statusCode}" /></td>
  </tr>

  <c:if test="${investigation.completed}">
  <tr>
    <td ><fmt:message key="completedBy" /></td>
    <td><c:out value="${investigation.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${investigation.completionTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="findings" /></td>
    <td><scannell:text value="${investigation.findings}" /></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${investigation.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${investigation.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${investigation.lastUpdated != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" /></td>
    <td><c:out value="${investigation.lastUpdated.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${investigation.lastUpdated.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  </c:if>

  <c:if test="${incident.sensitiveDataViewable}">
  <tr>
    <td ><fmt:message key="attachments" /></td>
    <td>
    	  <c:if test="${empty investigation.attachments}"><fmt:message key="none" /></c:if>
	      <c:forEach items="${investigation.attachments}" var="item" varStatus="stat">
			  <c:if test="${item.active}">
			      <c:choose>
			        <c:when test="${item.type.name == 'attach'}">
			          <a target="attachment" href="<c:url value="viewInvestigationAttachment.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a>
			        </c:when>
			        <c:otherwise>
			          <a target="attachment" href="<c:out value="${item.externalUrl}" />"><c:out value="${item.name}" /></a>
			        </c:otherwise>
			      </c:choose>
			      <br />
			      <c:out value="${item.createdByUser.displayName}" /><br />
			      <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />

			    <scannell:text value="${item.description}"/>
				<c:if test="${!stat.last}"><hr/></c:if>
			  </c:if>
		  </c:forEach>
    </td>
  <tr>
  </c:if>
</tbody>
   </c:otherwise>
  </c:choose>

  <tfoot>
  <tr>
    <td colspan="2">
    	<c:choose>
    		<c:when test="${updateIncidentAllowed}">
			      <c:if test="${investigation == null && incident.canCreateInvestigation}">
			      <a href="<c:url value="editInvestigation.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="createInvestigation" /></a> |
				      <c:if test="${incident.closableState and incidentAvailableFieldsByName['investigationOptional'] ne null}">
				      <a href="<c:url value="closeIncident.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="closeIncidentWithoutInvestigation" /></a> |
				      </c:if>
			      </c:if>
			      <c:if test="${investigation != null && investigation.editable}">
			      <a href="<c:url value="editInvestigation.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="editInvestigation" /></a> |
			      </c:if>
			      <c:if test="${investigation != null && investigation.completable}">
			        <a href="<c:url value="completeInvestigation.htm"><c:param name="showId" value="${incident.id}" /></c:url>"><fmt:message key="completeInvestigation" /></a> |
			      </c:if>
			      <c:if test="${investigation != null && investigation.reopenable}">
			        <a href="<c:url value="reopenInvestigation.htm"><c:param name="id" value="${incident.id}" /></c:url>"><fmt:message key="reopenInvestigation" /></a> |
			      </c:if>
			      <c:if test="${investigation != null && investigation.editable}">
			        <a href="<c:url value="addInvestigationAttachment.htm"><c:param name="showId" value="${investigation.id}" /></c:url>"><fmt:message key="addAttachment" /></a> |
			      </c:if>
			      <c:if test="${investigation != null && investigation.editable && !empty investigation.attachments}">
			        <a href="<c:url value="editInvestigationAttachments.htm"><c:param name="showId" value="${investigation.id}" /></c:url>"><fmt:message key="editAttachments" /></a> |
			      </c:if>
			      <c:if test="${investigation.lastUpdatedByUser != null || investigation.answersUpdated}">
			        <a href="javascript:openParentChildHistory(<c:out value="${incident.id},'${investigation['class'].name}','${investigation.answerIdsCSV}','investigationAnswer'" />)"><fmt:message key="viewHistory" /></a> 
			      </c:if>
			</c:when>
			<c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${incident.site.name}" /></fmt:message></c:otherwise>
		</c:choose>
     </td>
  </tr>
</tfoot>
</table>
</div>

</div>
</div>
</c:if>         

            
            
</div>



<div id="sectionC" class="tab-pane fade">
            <a name="action"></a>
 
 <div class="header">
        <h3> <fmt:message key="actionSummary" /></h3>
</div>           
<div class="content"> 
<div class="panel" >

<div class="table-responsive">
<table id="actionTable" class="table table-responsive table-bordered"> 
<c:choose>
<c:when test="${!incident.hasCurrentActions}">
          <tr><td colspan="7">No Action Associated with this Incident</td></tr>
    </c:when>
    <c:otherwise>     <script>jQuery('#actionTable').addClass('dataTable');</script>      
		      <thead>
		      <tr>
		        <th><fmt:message key="id"/></th>
		        <th><fmt:message key="type" /></th>
		        <th><fmt:message key="description" /></th>
		        <th><fmt:message key="completionTargetDate" /></th>
		        <th><fmt:message key="responsibleUser" /></th>
		        <th><fmt:message key="status" /></th>
		        <th></th>
		      </tr>
		      </thead>
	
		      <c:forEach items="${actionList}" var="item"><!-- before was incident.currentActions but I could to use actionList as I could not to sort incident.currentActions in the controller-->
			      <c:choose>
				      <c:when test="${item != null}">
					      <tr class="<c:out value="${style}" />">
					        <td><a href="<c:url value="viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>" ><c:out value="${item.id}" /></a></td>
					        <td><fmt:message key="ActionType[${item.type}]" /></td>
					        <td><div class="keepSpaceFormatting"><c:out value="${item.description}" /></div></td>
					        <td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
					        <td><c:out value="${item.responsibleUser.displayName}" /></td>
						    <td><fmt:message key="${item.statusCode}" /></td>
					        <td><a href="<c:url value="viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>" ><fmt:message key="view" /></a></td>
					      </tr>
				      </c:when>
			      </c:choose>
		      </c:forEach>
			
	</c:otherwise>
  </c:choose>
  <tfoot>
			  <tr>
			    <td colspan="7">

			    	<c:choose>
			    		<c:when test="${updateIncidentAllowed}">
						    <c:if test="${incident.canAssociateWithAction}">
						      <a href="<c:url value="editAction.htm"><c:param name="incidentId" value="${incident.id}" /><c:param name="type" value="prevent" /></c:url>"><fmt:message key="createPreventativeAction" /></a> |
						      <a href="<c:url value="editAction.htm"><c:param name="incidentId" value="${incident.id}" /><c:param name="type" value="correct" /></c:url>"><fmt:message key="createCorrectiveAction" /></a>  |
						      <a href="<c:url value="selectActions.htm"><c:param name="id" value="${incident.id}" /></c:url>"><fmt:message key="selectAction" /></a>
						    </c:if>
						    <c:if test="${incident.hasPreviousActions}" >
						      | <a href="<c:url value="viewPreviousActions.htm"><c:param name="id" value="${incident.id}" /></c:url>"><fmt:message key="viewPreviousActions" /></a>
						    </c:if>
						</c:when>
						<c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${incident.site.name}" /></fmt:message></c:otherwise>
					</c:choose>
			    </td>
			  </tr>
			</tfoot>
		</table>
</div>

        </div>
        </div>
    </div>
</div>
</div>
</div>
</body>
</html>
