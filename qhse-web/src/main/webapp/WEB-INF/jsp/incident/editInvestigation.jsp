<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="editInvestigation" />

<c:if test="${command.incident.investigation['new']}">
	<c:set var="title" value="createInvestigation" />
</c:if>
<title><fmt:message key="${title}" /></title>
<link rel="stylesheet" type="text/css"
	href="<scannell:resource value="/js/jsj/bootstrap-datetimepicker-master/build/css/bootstrap-datetimepicker.css" />">
<link rel="stylesheet" type="text/css" href="<scannell:resource value="/css/scannell-tooltip.css" />">
<style type="text/css">
	.scrollCause {
		max-height: 5; overflow-y: scroll;
	}
	input[type="checkbox"]:focus {
	    
	    border: 0 none;
	    outline: 0;
	} 
	.checkbox { border:0px !important; }
	.checkboxlabel {
		display: block !important; 
		text-align: left !important;
		font-weight:normal; 
		margin-bottom: 0px; 
		margin-top: -8px; 
		padding-left: 25px;
	}
	.checkboxBox {
		vertical-align: middle;
		position: relative;
	    bottom: 1px;
	    float: left;
	}
</style>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/moment-develop/moment.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/bootstrap-master/js/transition.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/bootstrap-master/js/collapse.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/clientQuestions.js" />"></script>
<%--  <script type="text/javascript" src="<scannell:resource value="/js/jsj/bootstrap-master/dist/js/bootstrap.js" />"></script> --%>
<script type="text/javascript"
	src="<scannell:resource value="/js/jsj/bootstrap-datetimepicker-master/build/js/bootstrap-datetimepicker.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/editInvestigation.js" />"></script>

<%-- <script src="<c:url value="/js/date.js" />"> </script> --%>
<script type="text/javascript">
//jQuery(document).off('.datepicker.data-api');
//jQuery(this).datepicker('setDate', new Date());
//jQuery('.datepicker').datepicker('update');
jQuery(document).ready(function() {	
 	jQuery( ".checkClass" ).addClass( "form-control checkbox icheck" );	
	 jQuery(".checkClass").change(function(){ 
		 var classname = jQuery(this).attr("name");
		 classname = classname.replace("investigationAnswers[","");
		 classname = classname.replace("]","");
		 classname = "checkbox_"+classname;
	     if ( jQuery(this).is(":checked")) {
	    	 jQuery('.'+classname).parent("div").parent("div").show();
	     } else {
	    	 jQuery('.'+classname).parent("div").parent("div").hide();
	     }
	}).change();
	initClientDependsOn();
	 jQuery('select.clientQuestion').select2({width: '100%'});
	//jQuery('.date').datetimepicker({showClose: true,clear:true,format:'DD-MMM-YYYY HH:mm'});
	
	//jQuery('.date').datetimepicker();
	
	var valuesArray = [] ;
	var index = 0;
	jQuery('div.dateDiv').each(function() {
		$( "div.dateDiv" ).addClass( "date" );
		$( "div.dateDiv" ).addClass( "datetime" );
		
		valuesArray.push(jQuery(this).children()[0].value);
		index = index + 1;
	});
	jQuery('.date').datetimepicker({showClose: true,clear:true,format:'DD-MMM-YYYY HH:mm'});
 	index = 0;
 	jQuery('div.dateDiv').each(function() {
 		jQuery(this).children()[0].value = valuesArray[index];
 		index = index + 1;
 	});
	
	if(document.getElementById('hidden${causeTypeCategories[0].name}')!=null && document.getElementById('hidden${causeTypeCategories[0].name}').value == 'true') {
		document.getElementById('${causeTypeCategories[0].name}').checked = true;
		toggleBlock(document.getElementById('${causeTypeCategories[0].name}').value+'CauseTypes');
	}
	if(document.getElementById('hidden${causeTypeCategories[1].name}')!=null && document.getElementById('hidden${causeTypeCategories[1].name}').value == 'true') {
		document.getElementById('${causeTypeCategories[1].name}').checked = true;
		toggleBlock(document.getElementById('${causeTypeCategories[1].name}').value+'CauseTypes');
	}
	if(document.getElementById('hidden${causeTypeCategories[2].name}')!=null && document.getElementById('hidden${causeTypeCategories[2].name}').value == 'true') {
		document.getElementById('${causeTypeCategories[2].name}').checked = true;
		toggleBlock(document.getElementById('${causeTypeCategories[2].name}').value+'CauseTypes');
	}
	if(document.getElementById('hidden${causeTypeCategories[3].name}')!=null && document.getElementById('hidden${causeTypeCategories[3].name}').value == 'true') {
		document.getElementById('${causeTypeCategories[3].name}').checked = true;
		toggleBlock(document.getElementById('${causeTypeCategories[3].name}').value+'CauseTypes');
	}
	if(document.getElementById('hidden${causeTypeCategories[4].name}') != null && document.getElementById('hidden${causeTypeCategories[4].name}').value == 'true') {
		document.getElementById('${causeTypeCategories[4].name}').checked = true;
		toggleBlock(document.getElementById('${causeTypeCategories[4].name}').value+'CauseTypes');
	}
	hideSearchDivSelect2WhenScrolling();
});

var envAspects = new Array ( new Array()
<c:forEach items="${environmentalAspects}" var="item"> ,new Array(
	<c:set var="displayComma" value="false" />
	<c:if test="${displayComma}">,</c:if>'<c:out value="${item.name}"/>','<c:out value="${item.id}" />'
	<c:set var="displayComma" value="true" />)
</c:forEach>);

var subTypeOptArr = new Array ( new Array()
<c:forEach items="${types}" var="type">, new Array(
	<c:set var="displayComma" value="false" />
	<c:forEach items="${type.subTypes}" var="subType" varStatus="subTypeStatus">
		<c:if test="${subType.active}">
			<c:if test="${displayComma}">,</c:if>new Option('<c:out value="${subType.name}"/>','<c:out value="${subType.id}" />', false, false)
			<c:set var="displayComma" value="true" />
		</c:if>
	</c:forEach>)
</c:forEach>);


function toggleCauseTypesBlock(BasicCauseTypeId, causeType){
	var causeTypeName = causeType.value;
	var isCauseTypeSelected = document.getElementById(causeTypeName).checked;
	var causeTypes = document.getElementsByName("causeTypes");
	
	var equipSetOnce		= false;
	var materialsSetOnce	= false;
	var methodsSetOnce		= false;
	var peopleSetOnce		= false;
	var workplaceSetOnce	= false;
	
	for (var i=0 ; i<causeTypes.length ; i++) {

		if (causeTypes[i].checked && causeTypes[i].id == "equipmentCheckboxList") {
			equipSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "materialsCheckboxList") {
			materialsSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "methodsCheckboxList") {
			methodsSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "peopleCheckboxList") {
			peopleSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "workplaceCheckboxList") {
			workplaceSetOnce = true;
			continue;
		}
	}
	
	
	if(!isCauseTypeSelected){
		document.getElementById(causeTypeName).checked = true;
		if(causeTypeName == 'Equipment'){
			var newCauseType='';
			if(${userInRole}){
			newCauseType =document.getElementsByName("newEquipmentCauseType")[0].value;
			}
			if(equipSetOnce || newCauseType.length >=1){
				document.getElementById(causeTypeName).checked = true;
				showAlert();
					
			}else{
				toggleBlock(BasicCauseTypeId);
				document.getElementById(causeTypeName).checked = false;
				equipSetOnce = false;
			}
		}
		if(causeTypeName == 'Materials'){
			var newCauseType='';
			if(${userInRole}){
			document.getElementsByName("newMaterialsCauseType")[0].value;
			}
			if(materialsSetOnce || newCauseType.length >=1){
				document.getElementById(causeTypeName).checked = true;
				showAlert();
				}else{
				toggleBlock(BasicCauseTypeId);
				document.getElementById(causeTypeName).checked = false;
				materialsSetOnce = false;
			}
		}
		if(causeTypeName == 'Methods'){
			var newCauseType='';
			if(${userInRole}){
			document.getElementsByName("newMethodsCauseType")[0].value;
			}
			if(methodsSetOnce || newCauseType.length >=1){
				document.getElementById(causeTypeName).checked = true;
				showAlert();
			}else{
				toggleBlock(BasicCauseTypeId);
				document.getElementById(causeTypeName).checked = false;
				methodsSetOnce = false;
			}
		}
		if(causeTypeName == 'People'){
			var newCauseType='';
			if(${userInRole}){
			newCauseType =document.getElementsByName("newPeopleCauseType")[0].value;
			}
			if(peopleSetOnce || newCauseType.length >=1){
				document.getElementById(causeTypeName).checked = true;
				showAlert();
			}else{
				toggleBlock(BasicCauseTypeId);
				document.getElementById(causeTypeName).checked = false;
				peopleSetOnce = false;
			}
		}
		if(causeTypeName == 'Workplace'){
			var newCauseType='';
			if(${userInRole}){
			newCauseType =document.getElementsByName("newWorkplaceCauseType")[0].value;
			}
			if(workplaceSetOnce || newCauseType.length >=1){
				document.getElementById(causeTypeName).checked = true;
				showAlert();
			}else{
				toggleBlock(BasicCauseTypeId);
				document.getElementById(causeTypeName).checked = false;
				workplaceSetOnce = false;
			}
		}
	}else{
		toggleBlock(BasicCauseTypeId);
	}
}

jQuery(window).bind('load', onPageLoad);
</script>
<style type="text/css" media="all">
.form-control.checkbox {
	width: 20px; margin-top: -15px;
}


_:-ms-fullscreen, :root .ieHack { position:relative; top:-8px; left:10px; }

_:-ms-lang(x), .ieHack { position:relative\9; bottom:-11px\9; left:10px\9; }

@media screen and (-webkit-min-device-pixel-ratio:0) { 
/* Safari and Chrome */
	.ieHack { position:relative; top:-8px; left:10px; }


#reporteeRow table td {
	border: 0px; display: inline-flex;
}

#reporteeRow table input {
	margin-top: -5px; margin-right: 10px;
}
</style>
</head>
<body onload="onPageLoad();">
<!-- 	<div class="header"> -->
<!-- 		<h2> -->
<%-- 			<fmt:message key="${title}" /> --%>
<!-- 		</h2> -->
<!-- 	</div> -->
	<spring:hasBindErrors name="command">
		<spring:bind path="command">
			<%-- <div class="errorMessage">
				<c:out value="${status.errorMessage}" />
			</div>
			<br /> --%>
		</spring:bind>
	</spring:hasBindErrors>

	<div class="content">
		<scannell:form onsubmit="onPageSubmit(this);">
			<input type="hidden" id="recouperationSize" name="recouperationSize" value="" />
			<input type="hidden" id="enable" name="enable" value="<fmt:message key="incident.enableAdditionalFields" />" />
			<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel ">
						<fmt:message key="incident" /> <fmt:message key="description" />
					</label>
					<div class="col-sm-6">
						<c:out value="${command.incident.description}" />
					</div>
				</div>
				<div style="clear:both"></div>
				<spring:nestedPath path="command.incident.investigation">
					<c:forEach var="ba" items="${businessAreaList}">
						<c:choose>
							<c:when test="${ba.name == 'Health & Safety'}">
								<div class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel ">
											<fmt:message key="hasHealthAndSafetyImpact" />
										</label>
										<div class="col-sm-6">
											<spring:bind path="hasHealthAndSafetyImpact">
												<input type="hidden" name="<c:out value="_${status.expression}"/>" class="form-control" />
												<label style=" padding-top: 1%;display: block;white-space: nowrap;" >
													<input class="form-control checkbox icheck " style="border: 0px;" id="healthToggle" onclick="onHealthToggleChange()" type="checkbox"
														name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
					<span class="scannell-tooltip" ><img id="showIncidentSeverity" style="margin-top:-50px" src="<c:url value="/images/help_small.gif"/>" ><span style="margin-top:-25px;white-space:normal;" class="tooltiptext"><fmt:message key="investigationHealthSaftyImpactTooltip" /></span></span>
												</label>
												<span id="environmentalOrHealthMandatory1" class="requiredHinted" style="display: none">
													 * <fmt:message key="incident.environmentalOrHealthMandatory" /></span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</div>
									</div>
									<div id="healthHazardDiv" class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel ">
											<fmt:message key="healthHazardType" />
										</label>
										<div class="col-sm-6">
											<spring:bind path="healthHazardType">
												<select id="healthHazard" name="<c:out value="${status.expression}"/>" class="form-control" style="float:left;width:80%">
													<option value="0"><fmt:message key="blankOption" /></option>
													<c:forEach items="${healthHazards}" var="item">
														<c:if test="${item.active || item.id == status.value}">
															<option value="<c:out value="${item.id}" />"
																<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																<c:out value="${item.name}" />
															</option>
														</c:if>
													</c:forEach>
												</select>
												<span id="healthHazardMandatory" class="requiredHinted" style="display: none">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</div>
										<span class="scannell-tooltip" ><img id="showhealthHazardTypeTooltip"  src="<c:url value="/images/help_small.gif"/>" ><span style="margin-top:-25px;white-space:normal;" class="tooltiptext"><fmt:message key="investigationhealthHazardTypeTooltip" /></span></span>
									</div>
									<div style="clear: both;"></div>
								</c:when>
								<c:when test="${ba.name == 'Environmental'}">
									<div class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel">
											<fmt:message key="hasEnvironmentalImpact" />
										</label>
										<div class="col-sm-6">
											<spring:bind path="hasEnvironmentalImpact">
												<input type="hidden" name="<c:out value="_${status.expression}"/>" class="form-control" />
												<label style=" padding-top: 1%">
													<input type="checkbox" class="form-control checkbox icheck" style="border: 0px" id="envToggle" onclick="onEnvToggleChange()"
														name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
												</label>
												<span id="environmentalOrHealthMandatory2" class="requiredHinted" style="display: none">
													 * <fmt:message key="incident.environmentalOrHealthMandatory" /></span>
					
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</div>
									</div>
					
									<div id="environmentalAspectDiv" class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
											<fmt:message key="environmentalAspectType" />
										</label>
										<div class="col-sm-6">
											<spring:bind path="environmentalAspectType">
												<select id="environmentalAspect" name="<c:out value="${status.expression}"/>" class="form-control" style="float:left;width:80%"
													onchange="onAspectTypeChange();">
													<option value="0"><fmt:message key="blankOption" /></option>
													<c:forEach items="${environmentalAspects}" var="item">
														<c:if test="${item.active || item.id == status.value}">
															<option value="<c:out value="${item.id}" />" selectedValue="<c:out value="${item.name}" />"
																<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																<c:out value="${item.name}" />
															</option>
														</c:if>
													</c:forEach>
												</select>
												<span id="environmentalAspectMandatory" class="requiredHinted" style="display: none">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</div>
									</div>
					
									<div id="environmentalImpactTypeDiv" class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
											<fmt:message key="environmentalImpactType" />
										</label>
										<div class="col-sm-6">
											<spring:bind path="environmentalImpactType">
												<select id="environmentalImpact" name="<c:out value="${status.expression}"/>" class="form-control" style="float:left;width:80%">
													<option value="0"><fmt:message key="blankOption" /></option>
													<c:forEach items="${environmentalImpacts}" var="item">
														<c:if test="${item.active || item.id == status.value}">
															<option value="<c:out value="${item.id}" />"
																<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																<c:out value="${item.name}" />
															</option>
														</c:if>
													</c:forEach>
												</select>
												<span id="environmentalImpactMandatory" class="requiredHinted" style="display: none">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</div>
									</div>
									<div style="clear: both;"></div>
								</c:when>
								<c:when test="${ba.name == 'Quality'}">
									<!-- START: Has Business Impart -->
									<div class="form-group">
											<label class="col-sm-3 control-label scannellGeneralLabel ">
												<fmt:message key="hasQualityImpact" />
											</label>
											<div class="col-sm-6">
												<spring:bind path="hasQualityImpact">
													<input type="hidden" name="<c:out value="_${status.expression}"/>" class="form-control" />
													<label style=" padding-top: 1%">
														<input class="form-control checkbox icheck " style="border: 0px;" id="qualityToggle" onclick="onQualityToggleChange()" type="checkbox"
															name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
						
													</label>
													<span id="environmentalOrHealthMandatory3" class="requiredHinted" style="display: none">
														 * <fmt:message key="incident.environmentalOrHealthMandatory" /></span>
													<span class="errorMessage">
														<c:out value="${status.errorMessage}" />
													</span>
												</spring:bind>
											</div>
										</div>
										<div id="qualityImpactDiv" class="form-group">
											<label class="col-sm-3 control-label scannellGeneralLabel ">
												<fmt:message key="qualityImpactType" />
											</label>
											<div class="col-sm-6">
												<spring:bind path="qualityImpactType">
													<select id="qualityImpact" name="<c:out value="${status.expression}"/>" class="form-control" style="float:left;width:80%">
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${qualityImpacts}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />"
																	<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" />
																</option>
															</c:if>
														</c:forEach>
													</select>
													<span id="qualityMandatory" class="requiredHinted" style="display: none">*</span>
													<span class="errorMessage">
														<c:out value="${status.errorMessage}" />
													</span>
												</spring:bind>
											</div>
										</div>
										<div style="clear: both;"></div>
										<!-- END: Has Business Impart -->
								</c:when>
							</c:choose>
						</c:forEach>
						
				<c:if test="${!empty command.incident.superType.investigationQuestionGroups}">
	      			<c:forEach var="group" items="${command.incident.superType.investigationQuestionGroups}" varStatus="s">
						<c:set var="groupDiv" value="g${group.id}"/>
						<div id="${groupDiv}" class="questionGroupEdit">							
							<h2><c:out value="${group.name}"/></h2>
							<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
								<c:if test="${templateQuestion.active}">
								<div style="clear: both;"></div>
								<c:choose>
									<c:when test="${templateQuestion.investigationField}">
										<c:choose>
											<c:when test="${templateQuestion.questionName == 'durationForm'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="durationForm" />
													</label>
													<div class="col-sm-6 nowrap" style="display: flex;">
														<div style="width: 100%">
														<spring:bind path="command.durationAmount" ignoreNestedPath="true">
															<input id="duration" type="number" name="<c:out value="${status.expression}"/>" onkeyup="onValueChange()"
																style="min-width: 60px; width: 10%; display: inline;float: left" value="<c:out value="${status.value}"/>"
																class="form-control" />
														</spring:bind>
														<spring:bind path="command.durationUnit" ignoreNestedPath="true">
															<select id="durationUnit" name="<c:out value="${status.expression}"/>" style="width: 40%; margin-left: 10px;float: left;"
																class="form-control">
																<c:forEach items="${durationUnits}" var="item">
																	<option value="<c:out value="${item.name}" />"
																		<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																	<c:set var="selectedUtil" value="${true}" />
								
																</c:forEach>
															</select>
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
														</spring:bind>
														<spring:bind path="command.durationAmount" ignoreNestedPath="true">
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
														</div>
													</div>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'causeCategory'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="causeTypes" />
													</label>
													<div class="col-sm-6">
														<c:forEach items="${causeTypeCategories}" var="category">
															<div style="float: left; margin-left: 10px;">
															<div style="font-size: 16px">
																<input type="checkbox"  class="checkClass" id="<c:out value="${category.name}"/>" 
																	name="<c:out value="${category.name}"/>" value="<c:out value="${category.name}"/>"
																	onclick="toggleCauseTypesBlock(value+'CauseTypes', ${category.name});" /><c:out value="${category.name}" />
															</div>
															
								
															<%-- <div class="checkbox-inline">
																<input type="checkbox" class="form-control checkbox" style="margin-top: -8px; margin-right: 5px;"
																	id="<c:out value="${category.name}"/>" name="<c:out value="${category.name}"/>"
																	value="<c:out value="${category.name}"/>"
																	onclick="toggleCauseTypesBlock(value+'CauseTypes', ${category.name});" />
																<c:out value="${category.name}" />
															</div> --%>
															</div>
														</c:forEach>
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
															<spring:bind path="command.causeTypes" ignoreNestedPath="true">
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind>
													</div>
												</div>
								
												<div class="form-group higher">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="causeType" />
													</label>
													<div class="col-sm-6">
														<div class="block">
															<table id="generalCauseTypesTable" class="table table-bordered table-responsive" style="overflow: auto;">
																<tr id="EquipmentCauseTypes" style="visibility: hidden; display: none; overflow: auto; ">
																	<td class="col-md-2 col-sm-1" ><fmt:message key="CauseTypeCategory[Equipment]" /></td>
																	<td class="col-md-6 col-sm-6" style="padding-left: 5%">
																		<div>
																			<c:set var="selectedUtil" value="${false}" />
																			<c:forEach items="${equipmentCauseTypes}" var="anyCauseType">
																				<c:set var="selected" value="${false}" />
																				<c:forEach items="${command.incident.investigation.causeTypes}" var="selectedCauseType">
																					<c:if test="${anyCauseType.id == selectedCauseType.id}">
																						<c:set var="selected" value="${true}" />
																						<c:set var="selectedUtil" value="${true}" />
																					</c:if>
								
																				</c:forEach>
																				<div class="checkbox">
																					<input id="equipmentCheckboxList" type="checkbox"  class="checkClass" name="causeTypes"
																						value="<c:out value="${anyCauseType.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
																					<span class="ieHack">
																						<c:out value="${anyCauseType.description}" />
																					</span>
																				</div>
																				<div style="clear: both;"></div>
																			</c:forEach>
																			<c:if test="${selectedUtil == true }">
																				<input type="hidden" value="${selectedUtil}" id="hidden${causeTypeCategories[0].name}" />
								
																			</c:if>
																		</div>
																	</td>
																	<c:if test="${userInRole}">
																		<td class="col-md-1 col-sm-1"><fmt:message key="newCauseType" /><br> <spring:bind
																				path="command.newEquipmentCauseType" ignoreNestedPath="true">
																				<input id="selectedEquipmentCauseTypes" type="text" name="<c:out value="${status.expression}"/>"
																					value="<c:out value="${status.value}"/>" />
																					<span class="errorMessage">
																						<c:out value="${status.errorMessage}" />
																					</span>
																			</spring:bind></td>
																	</c:if>
																</tr>
								
																<tr id="MaterialsCauseTypes" style="visibility: hidden; display: none; overflow: auto; "
																	class="scrolllist">
																	<td class="col-md-2 col-sm-1"><fmt:message key="CauseTypeCategory[Materials]" />:</td>
																	<td class="col-md-6 col-sm-6" style="padding-left: 5%">
																		<div>
																			<c:set var="selectedUtil" value="${false}" />
																			<c:forEach items="${materialsCauseTypes}" var="anyCauseType">
																				<c:set var="selected" value="${false}" />
																				<c:forEach items="${command.incident.investigation.causeTypes}" var="selectedCauseType">
																					<c:if test="${anyCauseType.id == selectedCauseType.id}">
																						<c:set var="selected" value="${true}" />
																						<c:set var="selectedUtil" value="${true}" />
																					</c:if>
																				</c:forEach>
																				<div class="checkbox">
																					<input id="materialsCheckboxList" type="checkbox"  class="checkClass" name="causeTypes"
																						value="<c:out value="${anyCauseType.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
																					<span class="ieHack">
																						<c:out value="${anyCauseType.description}" />
																					</span>
																				</div>
																				<div style="clear: both;"></div>
																			</c:forEach>
																			<c:if test="${selectedUtil == true }">
																				<input type="hidden" value="${selectedUtil}" id="hidden${causeTypeCategories[1].name}" />
																			</c:if>
																		</div>
																	</td>
																	<c:if test="${userInRole}">
																		<td class="col-md-1 col-sm-1"><fmt:message key="newCauseType" /><br /> <spring:bind
																				path="command.newMaterialsCauseType" ignoreNestedPath="true">
																				<input type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
																				<span class="errorMessage">
																					<c:out value="${status.errorMessage}" />
																				</span>
																			</spring:bind></td>
																	</c:if>
																</tr>
								
								
																<tr id="MethodsCauseTypes" style="visibility: hidden; display: none; overflow: auto; "
																	class="scrolllist">
																	<td class="col-md-2 col-sm-1"><fmt:message key="CauseTypeCategory[Methods]" />:</td>
																	<td class="col-md-6 col-sm-6" style="padding-left: 5%">
																		<div>
																			<c:set var="selectedUtil" value="${false}" />
																			<c:forEach items="${methodsCauseTypes}" var="anyCauseType">
																				<c:set var="selected" value="${false}" />
																				<c:forEach items="${command.incident.investigation.causeTypes}" var="selectedCauseType">
																					<c:if test="${anyCauseType.id == selectedCauseType.id}">
																						<c:set var="selected" value="${true}" />
																						<c:set var="selectedUtil" value="${true}" />
																					</c:if>
																				</c:forEach>
																				<div class="checkbox">
																					<input id="methodsCheckboxList" type="checkbox" name="causeTypes"  class="checkClass"
																						value="<c:out value="${anyCauseType.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
																					<span class="ieHack">
																						<c:out value="${anyCauseType.description}" />
																					</span>
																				</div>
																				<div style="clear: both;"></div>
																			</c:forEach>
																			<c:if test="${selectedUtil == true }">
																				<input type="hidden" value="${selectedUtil}" id="hidden${causeTypeCategories[2].name}" />
																			</c:if>
																		</div>
																	</td>
																	<c:if test="${userInRole}">
																		<td class="col-md-1 col-sm-1"><fmt:message key="newCauseType" />:<br /> <spring:bind
																				path="command.newMethodsCauseType" ignoreNestedPath="true">
																				<input type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
																				<span class="errorMessage">
																					<c:out value="${status.errorMessage}" />
																				</span>
																			</spring:bind></td>
																	</c:if>
																</tr>
								
																<tr id="PeopleCauseTypes" style="visibility: hidden; display: none; overflow: auto; "
																	class="scrolllist">
																	<td class="col-md-2 col-sm-1"><fmt:message key="CauseTypeCategory[People]" />:</td>
																	<td class="col-md-6 col-sm-6" style="padding-left: 5%">
																		<div>
																			<c:set var="selectedUtil" value="${false}" />
																			<c:forEach items="${peopleCauseTypes}" var="anyCauseType">
																				<c:set var="selected" value="${false}" />
																				<c:forEach items="${command.incident.investigation.causeTypes}" var="selectedCauseType">
																					<c:if test="${anyCauseType.id == selectedCauseType.id}">
																						<c:set var="selected" value="${true}" />
																						<c:set var="selectedUtil" value="${true}" />
																					</c:if>
																				</c:forEach>
																				<div class="checkbox">
																					<input id="peopleCheckboxList" type="checkbox" name="causeTypes"  class="checkClass"
																						value="<c:out value="${anyCauseType.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
																					<span class="ieHack">
																						<c:out value="${anyCauseType.description}" />
																					</span>
																				</div>
																				<div style="clear: both;"></div>
																			</c:forEach>
																			<c:if test="${selectedUtil == true }">
																				<input type="hidden" value="${selectedUtil}" id="hidden${causeTypeCategories[3].name}" />
																			</c:if>
																		</div>
																	</td>
																	<c:if test="${userInRole}">
																		<td class="col-md-1 col-sm-1"><fmt:message key="newCauseType" />:<br /> <spring:bind
																				path="command.newPeopleCauseType" ignoreNestedPath="true">
																				<input type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
																				<span class="errorMessage">
																					<c:out value="${status.errorMessage}" />
																				</span>
																			</spring:bind></td>
																	</c:if>
																</tr>
								
																<tr id="WorkplaceCauseTypes" style="visibility: hidden; display: none; overflow: auto; "
																	class="scrolllist">
																	<td class="col-md-2 col-sm-1"><fmt:message key="CauseTypeCategory[Workplace]" />:</td>
																	<td class="col-md-6 col-sm-6" style="padding-left: 5%">
																		<div class="checkbox">
																			<c:set var="selectedUtil" value="${false}" />
																			<c:forEach items="${workplaceCauseTypes}" var="anyCauseType">
																				<c:set var="selected" value="${false}" />
																				<c:forEach items="${command.incident.investigation.causeTypes}" var="selectedCauseType">
																					<c:if test="${anyCauseType.id == selectedCauseType.id}">
																						<c:set var="selected" value="${true}" />
																						<c:set var="selectedUtil" value="${true}" />
																					</c:if>
																				</c:forEach>
																				<div class="checkbox">
																					<input id="workplaceCheckboxList" type="checkbox" name="causeTypes" class="checkClass"
																						value="<c:out value="${anyCauseType.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
								
																					<span class="ieHack">
																						<c:out value="${anyCauseType.description}" />
																					</span>
																				</div>
																				<div style="clear: both;"></div>
																			</c:forEach>
																			<c:if test="${selectedUtil == true }">
																				<input type="hidden" value="${selectedUtil}" id="hidden${causeTypeCategories[4].name}" />
																			</c:if>
																		</div>
																	</td>
																	<c:if test="${userInRole}">
																		<td class="col-md-1 col-sm-1"><fmt:message key="newCauseType" />:<br /> <spring:bind
																				path="command.newWorkplaceCauseType" ignoreNestedPath="true">
																				<input type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
																				<span class="errorMessage">
																					<c:out value="${status.errorMessage}" />
																				</span>
																			</spring:bind></td>
																	</c:if>
																</tr>
															</table>
															<spring:bind path="causeTypes">
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind>
														</div>
													</div>
												</div>
												<div style="clear: both;"></div>
												<div class="form-group higher">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="causeDescription" />
													</label>
													<div class="col-sm-6">
														<spring:bind path="causeDescription">
															<textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3" class="form-control"><c:out
																	value="${status.value}" /></textarea>
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
													</div>
													<span class="scannell-tooltip" ><img id="showCauseDescriptionTooltip"  src="<c:url value="/images/help_small.gif"/>" ><span style="margin-top:-25px;white-space:normal;" class="tooltiptext"><fmt:message key="causeDescriptionTooltip" /></span></span>
													
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'reportable'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="reportable" />
													</label>
													<div class="col-sm-6">
														<spring:bind path="reportable">
															<input type="hidden" name="<c:out value="_${status.expression}"/>" class="form-control" />
															<label  style=" padding-top: 1%">
																<input class="form-control checkbox" style="border: 0px"  id="reportableToggle" type="checkbox" onclick="onReportableToggleChange()"
																	name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
								
															</label>
															<br />
														</spring:bind>
														<spring:bind path="reportable">
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted" style="width:10%">*</span></c:if>
														</spring:bind>	
														<spring:bind path="reportable">
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
													</div>
												</div>
								
												<div class="form-group" id="reporteeRow" style="height: 250px;">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="reportees" />
													</label>
													<div class="col-sm-8">
														<table class="table" style="border: 0px;width:95%;" id="reporteeTable">
															<c:forEach items="${reportees}" var="reportee" varStatus="s">
																<c:if test="${s.index mod 3 == 0}">
																	<tr>
																</c:if>
																<c:set var="selected" value="false" />
																<c:forEach items="${command.incident.investigation.reportees}" var="selectedReportee">
																	<c:if test="${selectedReportee.id == reportee.id}">
																		<c:set var="selected" value="true" />
																	</c:if>
																</c:forEach>
																<td style="width: 30%; border: 0px">
																	<input type="checkbox" class="form-control checkbox checkboxBox" name="reporteeId"
																		id="r${reportee.id}" value="<c:out value="${reportee.id}"/>" <c:if test="${selected}">checked="checked"</c:if> style="border:0px;background-color: white;"/>
																	<label class="checkboxlabel" for="r${reportee.id}"><c:out value="${reportee.name}" /></label>
																</td>
																<c:if test="${s.index mod 3 == 2}">
																	</tr>
																</c:if>
															</c:forEach>
								
														</table>
														<spring:bind path="reportees">
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
													</div>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'numberManDaysLost'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="incident.editInvestigation.manDaysLost" />
													</label>
													<div class="col-sm-9">
														<div id="table" class="content" style="display: inline;">
															<table id="workRelatedTable" class="table table-bordered  table-responsive">
																<thead>
																	<tr>
																		<th style="width: 20%"><fmt:message key="incident.editInvestigation.workRelatedTable.startDate" /></th>
																		<th style="width: 20%"><fmt:message key="incident.editInvestigation.workRelatedTable.endDate" /></th>
																		<th style="width: 20%"><fmt:message key="incident.editInvestigation.workRelatedTable.workPractice" /></th>
																		<th style="width: 30%"><fmt:message key="incident.editInvestigation.workRelatedTable.description" /></th>
																		<th style="width: 10%"><fmt:message key="incident.editInvestigation.workRelatedTable.action" /></th>
																	</tr>
																</thead>
																<tbody>
								
																	<c:forEach items="${command.incident.investigation.recouperationPeriods}" var="recouperationPeriod"
																		varStatus="s">
																		<spring:nestedPath path="recouperationPeriods[${s.index}]">
																			<tr>
																				<td><spring:bind path="periodStartDate">
																						<%-- 														<input type="text" size="16" readonly="readonly" id="<c:out value="${status.expression}"/>" name="incident.investigation.recouperationPeriods.periodStartDate" value="<c:out value="${status.value}"/>" />
																						<img id="serviceDateCalendar"
																							src="<c:url value="/images/calendar.gif"/>"
																							alt="show-calendar"
																							onclick="return showTimeCalendar(event, '<c:out value="${status.expression}"/>', true);">--%>
																						
																						<div style="width: 100% !important;">
																							<div class="input-group dateDiv" data-min-view="2" data-date-format="dd-MM-yyyy"
																								style="width: 100% !important;min-width: 210px">
																								<!--  <input type="text" class="form-control" id="reviewStartDateFrom" name="reviewStartDateFrom" size="13" readonly="readonly"> -->
																								<input type="text" id="<c:out value="${status.expression}"/>" class="form-control"
																									name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
								
																								<span class="input-group-addon btn btn-primary">
																									<span class="glyphicon glyphicon-th"></span>
																								</span>
																							</div>
																							<div class="errorMessage">
																								<c:out value="${status.errorMessage}" />
																							</div>
																						</div>
																						
																					</spring:bind></td>
								
																				<td ><spring:bind path="periodEndDate">
								
																						<%-- 														<input type="text" size="16" readonly="readonly" id="<c:out value="${status.expression}"/>" name="incident.investigation.recouperationPeriods.periodEndDate" value="<c:out value="${status.value}"/>" />
																						<img id="serviceDateCalendar"
																							src="<c:url value="/images/calendar.gif"/>"
																							alt="show-calendar"
																							onclick="return showTimeCalendar(event, '<c:out value="${status.expression}"/>', true);"> --%>
																						<div class="errorMessage">
																							<c:out value="${status.errorMessage}" />
																						</div>
								
																						<div style="width: 100% !important;">
																							<div class="input-group dateDiv" data-min-view="2" data-date-format="dd-MM-yyyy"
																								style="width: 100% !important;min-width: 210px">
																								<!--  <input type="text" class="form-control" id="reviewStartDateFrom" name="reviewStartDateFrom" size="13" readonly="readonly"> -->
																								<input type="text" id="<c:out value="${status.expression}"/>" class="form-control"
																									name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" size="16">
																								<span class="input-group-addon btn btn-primary">
																									<span class="glyphicon glyphicon-th"></span>
																								</span>
																							</div>
																						</div>
								
								
																					</spring:bind></td>
								
																				<td><spring:bind path="periodType">
																						<select id="<c:out value="${status.expression}"/>"
																							name="incident.investigation.recouperationPeriods.periodType">
																							<option value=""><fmt:message key="blankOption" /></option>
																							<c:forEach items="${workTypes}" var="item">
																								<option value="<c:out value="${item.name}" />"
																									<c:if test="${item.name == status.value}">selected="selected"</c:if>>
																									<fmt:message key="${item}" />
																								</option>
								
																							</c:forEach>
								
																						</select>
																						<div class="errorMessage">
																							<c:out value="${status.errorMessage}" />
																						</div>
																					</spring:bind></td>
								
																				<td><spring:bind path="description">
																						<textarea id="<c:out value="${status.expression}"/>"
																							name="incident.investigation.recouperationPeriods.description" cols="25" rows="2" style="min-height: 38px;width: 100%"><c:out
																								value="${status.value}" /></textarea>
																						<div class="errorMessage">
																							<c:out value="${status.errorMessage}" />
																						</div>
																					</spring:bind></td>
								
																				<td onclick="deleteRow(this.row)">
																					<button type="button" class="g-btn g-btn--primary"
																						onclick="deleteRow(getParent('tr',this));">
																						<fmt:message key="deleteShort" />
																					</button>
																				</td>
																			</tr>
																		</spring:nestedPath>
																	</c:forEach>
								
																</tbody>
								
																<tfoot>
																	<tr>
																		<td colspan="4"><button id="addButton" type="button" class="g-btn g-btn--primary"
																				onclick="addRow('workRelatedTable', 'workRelatedTableRow')">
																				<fmt:message key="incident.editInvestigation.workRelatedTable.addPeriod" />
																			</button>
																		<td>
																	</tr>
																</tfoot>
															</table>
															<spring:bind path="recouperationPeriods">
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind>
								
														</div>
													</div>
													<spring:bind path="recouperationPeriods">
													</spring:bind>
								
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'operatingHoursLost'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="operatingHoursLost" />
														:
													</label>
													<div class="col-sm-6">
														<spring:bind path="operatingHoursLost">
															<input id="operatingHoursLost" type="text" class="form-control" style="width: 40%;display: inline;"
																name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
													</div>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'areaOwner'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="AreaOwner" />
														:
													</label>
													<div class="col-sm-6">
														<spring:bind path="areaOwner">
															<select name="<c:out value="${status.expression}"/>" id="areaOwner" style="width: 40%;display: inline;" class="form-control">
																<option value="">Choose</option>
																<c:forEach items="${approvalUserList}" var="item">
																	<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																		<c:out value="${item.sortableName}" />
																	</option>
																</c:forEach>
															</select>
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
													</div>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'investigationAppByAreaOwner'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel ">
														<fmt:message key="InvestigationAppByAreaOwner" />
														:
													</label>
													<div class="col-sm-6">
														<spring:bind path="investigationAppByAreaOwner">
															<input type="hidden" name="<c:out value="_${status.expression}"/>" class="form-control" />
															<label  style=" padding-top: 1%">
															<input type="checkbox" class="form-control checkbox" id="investigationToggle" style="border:0px"
																name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
																</label>
														</spring:bind>
													</div>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'areaOwnerComments'}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="AreaOwnerComments" />
														:
													</label>
													<div class="col-sm-6 nowrap">
														<spring:bind path="areaOwnerComments">
															<textarea id="AreaOwnerComments" name="<c:out value="${status.expression}"/>" class="form-control"
																style="width: 40%;display: inline;"><c:out value="${status.value}" /></textarea>
															<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
														</spring:bind>
								
													</div>
												</div>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:if test="${templateQuestion.question.active}">
											<div class="form-group">
												<label class="col-sm-3 control-label scannellGeneralLabel"><c:out value="${templateQuestion.question.name}" /></label>
											    <div class="col-sm-6">
										        	<enviromanager:question path="investigationAnswers" question="${templateQuestion.question}" emptyOptionLabel="Choose"
																multiselectCheckboxes="false" required="${templateQuestion.mandatory}" overrideRequired="true"/>
										        	<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
											     </div>
											     <c:if test="${templateQuestion.question.tooltip != null }">
								<div class="scannell-tooltip"><img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>" ><span class="tooltiptext"><c:out value="${templateQuestion.question.tooltip}" /></span></div>
							</c:if>
										  	</div>
										  </c:if>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
				</c:if>
			</spring:nestedPath>
			<div style="clear: both;"></div>
			<div class="spacer2 text-center">
				<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
				<button type="button" class="g-btn g-btn--primary" onclick="window.history.go(-1)">
					<fmt:message key="cancel" />
				</button>
			</div>


		</scannell:form>
	</div>
	<table style="display: none;" class="table table-bordered table-responsive">
		<tr id="workRelatedTableRow">
			<td>
				<div style="width: 100%;">
					<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
						style="width: 100% !important;min-width: 210px">
						<!--  <input type="text" class="form-control" id="reviewStartDateFrom" name="reviewStartDateFrom" size="13" readonly="readonly"> -->
						<input type="text" id="idPlaceHolderStartDate" class="form-control"
							name="incident.investigation.recouperationPeriods.periodStartDate" size="16">
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				</div> <%-- <input type="text" id="idPlaceHolderStartDate"
				name="incident.investigation.recouperationPeriods.periodStartDate"
				size="16" readonly="readonly"> <img
				src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
				onclick="return showTimeCalendar(event,'idFuncPlaceHolderStartDate', true);"> --%>
			</td>
			<td>
				<div style="width: 100%;">
					<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
						style="width: 100% !important; min-width: 210px">
						<!--  <input type="text" class="form-control" id="reviewStartDateFrom" name="reviewStartDateFrom" size="13" readonly="readonly"> -->
						<input type="text" id="idPlaceHolderEndDate" class="form-control"
							name="incident.investigation.recouperationPeriods.periodEndDate" size="16">
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				</div> <%-- <input type="text" id="idPlaceHolderEndDate"
				name="incident.investigation.recouperationPeriods.periodEndDate"
				size="16" readonly="readonly"> <img
				src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
				onclick="return showTimeCalendar(event, 'idFuncPlaceHolderEndDate', true);">
			</td> --%>
			<td><select name="incident.investigation.recouperationPeriods.periodType">
					<option value=""><fmt:message key="blankOption" /></option>
					<c:forEach items="${workTypes}" var="item">
						<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
					</c:forEach>
				</select></td>

			<td><textarea name="incident.investigation.recouperationPeriods.description" cols="25" rows="2" style="min-height: 28px; width: 100%; overflow: hidden; overflow-wrap: break-word; resize: horizontal; "></textarea></td>
			<td onclick="deleteRow(this.row)"><button type="button" class="g-btn g-btn--primary"
					onclick="deleteRow(getParent('tr',this));">
					<fmt:message key="deleteShort" />
				</button></td>
		</tr>
	</table>


</body>
</html>
