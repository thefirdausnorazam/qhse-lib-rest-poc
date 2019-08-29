<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<!DOCTYPE html>
<html>
<head>
<title>
</title> 
<style type="text/css">
.sp{
padding-left: 0px !important;
}
.cl-mcont .row {
margin-top: 0px !important;
}
.selectShowAll.select2-container .select2-results {max-height: 100%;}
.selectShowAll .select2-results {max-height: 100%;}
.selectShowAll .select2-choices {max-height: 100%; overflow-y: auto;}
	.links a {
		padding-left: 10px;
		margin-left: 10px;
		border-left: 1px solid #000;
		text-decoration: none;
		color: #999;
	}
	.links a:first-child {
		padding-left: 0;
		margin-left: 0;
		border-left: none;
	}
	.links a:hover {text-decoration: underline;}
	.column-left {
		display: inline; 
		float: left;
	}
	.column-right {
		display: inline; 
		float: right;
	}
	
	.small-body-image {
		width: 150px;
	}
	
	.select2-chosen{
	  word-wrap: break-word !important;
	  text-overflow: inherit !important;
	  white-space: normal !important;
	}
</style>

<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script src="<c:url value="/js/calendar.js" />"></script>
<script src="<c:url value="/js/selectBox.js" />"> </script>
<script src="<c:url value="/js/date.js" />"> </script>
<script src="<c:url value="/js/select2-3.2/maximize-select2-height.js" />"> </script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/clientQuestions.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/showHelp.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/editableTable.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/incidentEdit.js" />"></script>
<script src="https://www.google.com/recaptcha/api.js"></script>
<script type='text/javascript' src="<c:url value="/js/jsj/jqScribble/jquery.jqscribble.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/jsj/jqScribble/jqscribble.extrabrushes.js" />"></script>


<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery('#incidentForm').find('span').removeClass ( 'col-sm-10 sp' );
	jQuery("form").submit(function() {
		// submit more than once return false
		jQuery(this).submit(function() {
			return false;
		});
		// submit once return true
		return true;
	});
	initClientDependsOn();
	 jQuery(".checkClass").change(function(){ 
		 var classname = jQuery(this).attr("name");
		 classname = classname.replace("incidentAnswers[","");
		 classname = classname.replace("]","");
		 classname = "checkbox_"+classname;
	     if ( jQuery(this).is(":checked")) {
	    	 jQuery('.'+classname).parent("div").parent("div").show();
	     } else {
	    	 jQuery('.'+classname).parent("div").parent("div").hide();
	     }
	}).change();

	  jQuery('select').not('#communicatedTo').not('#activeUsers').not('#assignees').not('#unassigned').not('#siteLocation').select2({width: '95%'});
	  jQuery('.col-sm-10 select').select2({
          placeholder: "Choose",
          allowClear: false,
          width: '100%'});
	  jQuery('#occurredHour').select2({width: '80%'});
	  jQuery('#occurredMinute').select2({width: '80%'});

	  var subTypeSel = jQuery("#subTypeSel");
	  var options = jQuery("#subTypeSel option");
	  var daysToAdd = parseInt("<fmt:message key='incident.investigationDueForClosureDays'/>");
	  
	  if(options.size() == 2) {  // blank option + 1 real option
	    subTypeSel.val(options.get(1).value);
	  }
	  if(options.size() < 10) { 
		  jQuery("#subTypeSel").select2({width: '95%',containerCssClass: "selectShowAll",dropdownCssClass: "selectShowAll"});
	  }
	  else {
		  jQuery("#subTypeSel").select2({width: '95%'});		  
	  }
	  if(options.size() == 2) {  // blank option + 1 real option
		    subTypeSel.val(options.get(1).value);
	  }
	  jQuery( ".dateChange" ).change(function() {
		  var date = Date.parse(jQuery( this ).val());
	      if(date != null && !isNaN(date.getTime())){
		      date.setDate(date.getDate() + daysToAdd);
		      try{jQuery( ".dateToChange" ).val(jQuery.datepicker.formatDate('dd-MM-yy', date));}catch(e){}
	      } 
		  
		  //jQuery(".dateToChange").text("01-01-1999"); dd-MM-yyyy
		});

	  diableSubmitIfNoSubTypeSelected();
	  subTypeSel.change(diableSubmitIfNoSubTypeSelected);
	  onPageLoad();
	  init();
	  
	  jQuery('.col-sm-6').each(function () { 
		  if(jQuery(this).text() == 'Select where incident/accident occured') {
			  jQuery(this).css('width', '100%');
		  }
	  });
	  if("${command.incident.activeConfidentialVisible and command.incident.id>0}" == "true"){
	  jQuery('.activeHide').show();
	  }
	  
	  jQuery("select[name^='incident.participants']").each(function( index ) {
	  
		  jQuery(this).select2('destroy'); 
		  jQuery(this).css("width", "100%");
	  });
	  hideSearchDivSelect2WhenScrolling();
	  disableSubmitIfAssignedMandatory();
  
  
	  
/* 	  jQuery('#incidentForm').validate({
		  onkeyup: false,    
		  rules: {
		    },
		    showErrors: function(errorMap, errorList) {
		    	console.log(JSON.stringify(errorMap));
		    },
		    success: function() {
		    }
		}); */
	  
	  	if(jQuery("#div-site").length){
	  		jQuery( "#div-site" ).prependTo(jQuery(".departmentDiv").closest(".form-group").parent());
	  		jQuery("#userSelectedSite").prop('required',true);
	  	}
				
	//	jQuery('.canvasClass').click(function () {

			  //  return false;

	//	});
	  	 var multiselect = jQuery('select[multiple="multiple"].clientQuestion');
	    //multiselect.removeClass("scrollList");
	    multiselect.select2({
	      width:"95%",placeholder: "Choose"
	    }); 
	});

function showInActiveAlertMessage(){
	if(!jQuery('#activeCheckbox').is(":checked")){
		<fmt:message key="incidentInactive" var="warning"/>
			var text = "${warning}";
			var result = confirm(text);
			if (result == true) {
				jQuery('#activeCheckbox').prop('checked', false);
			}else{
				jQuery('#activeCheckbox').prop('checked', true);
			}
		
	}

}
	
	function changeMandatoryType(role, id) {
		if(role == 'Injured') {
			document.getElementById(id + "MandatorySpan").innerHTML = "*";
			document.getElementById(id + "MandatorySpan").className = "mandatory";
			//jQuery("#" + id + "MandatorySpan").val("*");
		} else {
			document.getElementById(id + "MandatorySpan").className = "" ;
			document.getElementById(id + "MandatorySpan").innerHTML="";
			
		}
	}
function diableSubmitIfNoSubTypeSelected() {
	  var subtypeId = parseInt(jQuery("#subTypeSel").val());
	  var subtypeSelected = !isNaN(subtypeId) && subtypeId > 0;
	  var submitButton = jQuery('[type="submit"]');
	  var subTypeError = document.getElementById("subTypeError");
	  var errtext = '';
	  if(subtypeSelected) {
	    submitButton.removeAttr("disabled");
	    var assignedMandatoryValue = '<c:out value="${command.incidentType.assignedMandatory}"/>';
		var assignees = document.getElementById("assignees");
		if(assignees) {
			if(assignedMandatoryValue == 'true' && assignees.length == 0)
			{
				//alert(assignedMandatory);
				disableSubmit();
			}
		}
	  } else {
	    submitButton.attr("disabled", "disabled");
	    errtext='<span class="errorMessage"><fmt:message key="required"/></span>';
	  }
	  if(subTypeError != null)
	  	subTypeError.innerHTML=errtext;
	}
function onPageLoad() {
	//alert('${command.incident.id}');
	var incidentHelp = "<fmt:message key='incident.help'/>";
	if(incidentHelp.substring(0,3) == '???' || incidentHelp == 'No'){
		var showIncidentSeverity = document.getElementById("showIncidentSeverity");
		if(showIncidentSeverity){
			showIncidentSeverity.style.display='none';	
		}
		var showIncidentAction = document.getElementById("showIncidentAction");
		if(showIncidentAction){
			showIncidentAction.style.display='none';	
		}
		var showIncidentScope = document.getElementById("showIncidentScope");
		if(showIncidentScope){
			showIncidentScope.style.display='none';
		}
		
	}
	var participantsHelp = "<fmt:message key='incident.participants.help'/>";
	if(participantsHelp == 'No' || participantsHelp.substring(0,3) == '???') {
		var showParticipantsHelp = document.getElementById("showParticipantsHelp");
		if(showParticipantsHelp){
			showParticipantsHelp.style.display='none';	
		}
	}	
	
	var option;
	var singleValue = '<c:out value="${command.incidentType.singleAssignable}"/>';
	
	var unassigned = document.getElementById("unassigned");
	var rightButton =  document.getElementById("rightButton");

	if(rightButton) {
		unassigned.multiple=true;
		<c:forEach items="${command.incident.assignees}" var="item">
		option = document.getElementById('<c:out value="assignee${item.id}" />');
		if (option) option.selected = true;
		</c:forEach>
		rightButton.onclick();
		jQuery("#assignees option").each(function()
				{
					this.selected = false;
				});
	}
	if(unassigned)
	{
		if(singleValue == '' || singleValue =='false')
		{
			unassigned.multiple=true;
		}
		else {
			unassigned.multiple=false;
		}
	}

	var communicatedToRightButton = document.getElementById("communicatedToRightButton");
	if(communicatedToRightButton) {
		<c:forEach items="${command.incident.communicatedTo}" var="item">
			option = document.getElementById('<c:out value="activeUser${item.id}" />');
			if (option)
				option.selected = true;
		</c:forEach>
		communicatedToRightButton.onclick();
		jQuery("#communicatedTo option").each(function()
		{
			this.selected = false;
		});
		<c:forEach items="${defaultCommunicatedToUsers}" var="item">
		option = document.getElementById('<c:out value="activeUser${item.id}" />');
		if (option)
			option.selected = true;
		</c:forEach>
		communicatedToRightButton.onclick();
		jQuery("#communicatedTo option").each(function()
		{
			this.selected = false;
		});
	}
	
	reorganizationPerson();
}

function selectItem(from,to) {

	var defaultUsers = new Array()
	
	if (<c:out value="${command.incident.notifyEditable}" /> == true) 
	{
	
	
		<c:forEach items="${defaultCommunicatedToUsers}" var="item">
			defaultUsers.push(<c:out value="${item.id}" />);
		</c:forEach>

		var optionValues=new Array();
		var opts = jQuery(from+' > option');
		for (var i=0; i<opts.length; i++) {
			var o = opts[i];
			if (o.selected) {
				optionValues.push(o.value);
			}
		}
		var canMove = true;
		for (var i=0; i<defaultUsers.length; i++) {
			for(var j=0; j<optionValues.length; j++){
				if (defaultUsers[i] == optionValues[j]) {
					canMove = false;
				}
			}
		}
		if (canMove) {
			move(from,to);
		} else {
			alert("User is on default Communicated to List");
		}
	}
}

<c:set var="singlequote" value="'"/>
var departments = new Array ( new Array()
<c:forEach items="${participantDepartments}" var="item"> ,new Array(
  <c:set var="displayComma" value="false" />
     <c:if test="${displayComma}">,</c:if>'<c:out value="${fn:replace(item.name, singlequote, '`')}" escapeXml="false"/>','<c:out value="${item.id}" />'
     <c:set var="displayComma" value="true" />  )
</c:forEach>);
var injuries = new Array ( new Array()
<c:forEach items="${injuries}" var="item"> ,new Array(
  <c:set var="displayComma" value="false" />
     <c:if test="${displayComma}">,</c:if>'<c:out value="${item.name}" escapeXml="false" />','<c:out value="${item.id}" />'
     <c:set var="displayComma" value="true" />  )
</c:forEach>);

var subTypeOptArr = new Array ( new Array()
<c:forEach items="${types}" var="type">, new Array(
  <c:set var="displayComma" value="false" />
  <c:forEach items="${type.subTypes}" var="subType"  varStatus="subTypeStatus">
    <c:if test="${subType.active}">
      <c:if test="${displayComma}">,</c:if>new Option('<c:out value="${subType.name}"/>','<c:out value="${subType.id}" />', false, false)
      <c:set var="displayComma" value="true" />
    </c:if>
  </c:forEach>)
</c:forEach>);
</script>

  <script type="text/javascript" >
	var isNew = null;
		var singleAssignable = "<fmt:message key="incident.singleAssignable"/>";
		var maxListSize = 500;
	
		var assignedMandatory = "<fmt:message key="incident.assignedMandatory"/>";
		
		function onChangeRole() {
			var injuryM = document.getElementById("mandatoryInjuryType");
			var select = document.getElementById("addPerson").getElementsByTagName("select");
			
	        for(var i=0;i<select.length;i++)
	        {
	          if(select[i].id=="incident.participants.role")
	          {
	        	  if(select[i].value == "Injured")
	        	  {
	        		  injuryM.style.display='inline';		
	        	  }
	        	  else {
	        		  injuryM.style.display='none';
	        	  }
	          }
	       }
		}
		
		function disableSubmitIfAssignedMandatory(){
			var assignedMandatoryValue = '<c:out value="${command.incidentType.assignedMandatory}"/>';
			var size=jQuery('#assignees option').length;
			
			if(assignedMandatoryValue == "true" && size ==0)
			{
				 var submitButton = jQuery('[type="submit"]');
				 submitButton.attr("disabled", "disabled");
			}
		}
		
		function checkAssigned(single, from, to) {
			var size=jQuery(to+' > option').length;
			if(single && size >= 1)
			{
		      alert(singleAssignable);
			  return false;
			}
			move(from,to);
			var assignedMandatoryValue = '<c:out value="${command.incidentType.assignedMandatory}"/>';
			if(assignedMandatoryValue == "true" && size ==0)
			{
				 var submitButton = jQuery('[type="submit"]');
				 submitButton.removeAttr("disabled");
			}
			return true;
		}
		
		function checkMandatory(from, to) {
			var size=jQuery(from+' > option').length;
			var assignedMandatoryValue = '<c:out value="${command.incidentType.assignedMandatory}"/>';
			var assignees = document.getElementById("assignees");
			if(assignedMandatoryValue=='true' && assignees.length == 1 && size == 1)
			{
				 disableSubmit();
			}
			move(from,to);
			return true;
		}
		
		function move(from, to) {
			var ret = jQuery(from).find(':selected').appendTo(to);
			sort(to);
			sort(from);
			return ret;
		}
		
		function sort(select) {
			var len = jQuery(select+' > option').length;
			var size2=jQuery(select+' option').size();
			//alert("len="+len+" and size="+size2);
			if(len < maxListSize)
			{  
				jQuery(select).append(jQuery(select+" option").remove().sort(function(x, y) {
				    var xt = jQuery(x).text().toLowerCase(), yt = jQuery(y).text().toLowerCase();
				    return (xt > yt)?1:((xt < yt)?-1:0);
			   }))
			}
		}
		jQuery.postJSON = function(url, data, callback) {  
			return jQuery.ajax({
		       url: url,
		       type: "POST",
		       data: data,
		       processData: false,
		       contentType: false,
		       success: callback
		    });
		};
		function filterDepartment(selectObj){
			var jsonData = new FormData();
			jsonData.append("siteId", selectObj.value);
			
			jQuery.postJSON("filterDepartmentBySite.htm", jsonData, function(responseFromController){
				
				jQuery('[questionId="42"]').find("option").remove();
				jQuery("<option>", { value: "", text: "Choose"}).appendTo(jQuery('[questionId="42"]'));
				
				jQuery(responseFromController.departmentList).each(function (){
					jQuery("<option>", { value: this.id, text: this.name}).appendTo(jQuery('[questionId="42"]'));
				});
				jQuery('[questionId="42"]').val('');
				jQuery('[questionId="42"]').trigger("change");
			}).error(function(jqXHR, error, errorThrown) {
				if (jqXHR.status && jqXHR.status == 404) {
					alert('<fmt:message key="couldNotSearchForDepartments" />')
				} else if (jqXHR.status && jqXHR.status == 500) {
					alert('<fmt:message key="couldNotSearchForDepartments" />')
				} else {
					alert('<fmt:message key="noImageFound" />')
				}
			});
		}
		
	</script>
	
<style type="text/css" media="all">
@import "<c:url value='/css/scannell-tooltip.css'/>";
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/incident.css'/>";

@import "<c:url value='/css/editableTable.css'/>";
</style>

</head>
<body onload="onPageLoad();onChangeRole();">
 	<system:gdprBanner/>
	<scannell:form id="incidentForm" onsubmit="selectAllCommunicatedTo();onPageSubmit(this);">
		<input type="hidden" id="incidentType" name="incidentType" value="" />
		<input type="hidden" id="participantsSize" name="participantsSize" value="" />
		<input type="hidden" id="incidentTypeChange" name="incidentTypeChange" value="" />

		<spring:nestedPath path="command.incident">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="type" />
				</label>
				<div class="col-sm-6">
					<spring:bind path="type">
						<c:set var="selectedTypeId" value="${command.incidentType.id}" />
						<c:forEach items="${types}" var="type">
							<c:forEach items="${type.subTypes}" var="subType">
								<c:if test="${subType.id == status.value}">
									<c:set var="selectedTypeId" value="${type.id}" />
								</c:if>
							</c:forEach>
						</c:forEach>
						<c:choose>
							<c:when test="${command.locked}">
								<select id="superType" name="superType" disabled="disabled" onchange="onTypeChange(this);" style="float:left;width:80%">
							</c:when>
							<c:otherwise>
								<select id="superType" name="superType" onchange="onTypeChange(this);" data-toggle="tooltip" title="Test tooltip" style="float:left;width:80%">
							</c:otherwise>
						</c:choose>
						<c:if test="${selectedTypeId eq null}">
							<option value="0"><fmt:message key="blankOption" /></option>
						</c:if>
						<c:forEach items="${types}" var="type">
							<c:if test="${type.active or type.id == selectedTypeId}">
								<option value="<c:out value="${type.id}" />"
									<c:if test="${type.id == selectedTypeId}">selected="selected"</c:if>>
									<fmt:message key="${type.key}" /></option>
							</c:if>
						</c:forEach>
						</select><span class="requiredHinted">*</span>
						<div class="scannell-tooltip"><img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>" ><span class="tooltiptext"><fmt:message key="incidentTypeTooltip" /></span></div>
					</spring:bind>
					<spring:bind path="id">
						<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
							class="form-control" />
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
					</spring:bind>
					<spring:bind path="version">
						<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
							class="form-control" />
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
					</spring:bind>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="subtype" />
				</label>
				<div class="col-sm-6">
					<spring:bind path="type">
						<select id="subTypeSel" name="<c:out value="${status.expression}"/>">
							<option id="blankOption" value="0"><fmt:message key="blankOption" /></option>
							<c:forEach items="${types}" var="type">
								<c:if test="${type.id == selectedTypeId}">
									<c:forEach items="${type.subTypes}" var="subType">
										<c:if test="${subType.active || subType.id == status.value}">
											<option value="<c:out value="${subType.id}" />"
												<c:if test="${subType.id == status.value}">selected="selected"</c:if>>
												<c:out value="${subType.name}" /></option>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						</select>
						<span class="requiredHinted">*</span>
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
						<c:if test="${command.incident.id>0}">
							<div id="subTypeError" ></div>
						</c:if>
					</spring:bind>
				</div>
			</div>
			
			<c:choose>
				<c:when test="${command.incident.sensitiveDescriptionDataViewable}">
					<incident:bindField name="description" style="min-height:130px;"  required="true">
						<textarea name="<c:out value="${status.expression}" />" cols="75" rows="3" style="max-height: 100%;float:left;width:95%" class="form-control"><c:out
								value="${status.value}" /></textarea>
					</incident:bindField>
				</c:when>
				<c:otherwise>
					<incident:bindField name="description"  required="false">
						<input type=hidden name="<c:out value="${status.expression}" />" value="${status.value}"><font color="red"><c:out value="CONFIDENTIAL"/></font>
					</incident:bindField>
				</c:otherwise>
			</c:choose>

			<incident:bindField name="occurredTime" style="min-height:130px;" required="false">

				<c:set var="onCalendarSelectHandler" value="dateChanged()" />
				<spring:bind ignoreNestedPath="true" path="command.occurredDate">
					<div id="cal" style="width: 250px;">
						<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
							<input type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
								class="form-control dateChange" readonly="readonly" id="<c:out value="${status.expression}"/>">
							<span class="input-group-addon btn btn-primary">
								<span class="glyphicon glyphicon-th"></span>
							</span>
						</div>

					</div>
				</spring:bind>
				<div><fmt:message key="24HourClock" /></div>
					<div class="col-sm-2" style="min-height: 70px; font-size: 14px; padding: 0px;">
						<scannell:select id="occurredHour" path="occurredHour" items="${hours}" cssStyle="width:100px" numberFormat="00"
							emptyOptionLabel="00" emptyOptionValue="00" />
					</div>
					<div class="col-sm-2" style="min-height: 70px; font-size: 14px; padding: 0px;">
						<scannell:select id="occurredMinute" path="occurredMinute" items="${minutes}" cssStyle="width:100px" numberFormat="00"
							emptyOptionLabel="00" emptyOptionValue="00" />
					</div>
					<spring:bind ignoreNestedPath="true" path="command.occurredDate">
						<span class="requiredHinted">*</span>
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
					</spring:bind>
			</incident:bindField>
			
			<c:if test="${!empty command.incidentType.incidentQuestionGroups}">
      			<c:forEach var="group" items="${command.incidentType.incidentQuestionGroups}" varStatus="s">
					<c:set var="groupDiv" value="g${group.id}"/>
					<div id="${groupDiv}" class="questionGroupEdit">						
						<h2><c:out value="${group.name}"/></h2>
						<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
							<c:if test="${templateQuestion.active}">
							<div style="clear: both;"></div>
								<c:choose>
									<c:when test="${templateQuestion.incidentField}">
										<c:choose>
											<c:when test="${templateQuestion.questionName == 'severity'}">
												<incident:bindField name="severity" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${severities}" var="item">
															<fmt:message key="${item}" var="str" />
															<option value="<c:out value="${item.name}" />" title="<c:out value="${str}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
													<img style="display:none" id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>"
														data-toggle="tooltip" data-original-title='<c:choose><c:when test="${incidentSeverityHelp != null}"><c:out value="${incidentSeverityHelp}"/></c:when><c:otherwise><fmt:message key="incident.severity.help"/></c:otherwise></c:choose>' />
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'qualitySeverity'}">								
												<incident:bindField name="qualitySeverity" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${qualitySeverity}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" /></option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'severityRisk'}">		
	
												<incident:bindField name="severityRisk" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${severityRisks}" var="item">
															<option value="<c:out value="${item.name}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'severityRiskEvent'}">		
	
												<incident:bindField name="severityRiskEvent" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${severityRiskEvents}" var="item">
															<fmt:message key="${item}" var="actual" />
															<option value="<c:out value="${item.name}" />" title="<c:out value="${actual}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'capaProject'}">	
												<incident:bindField name="capaProject" required="${templateQuestion.mandatory}">
									
													<select id="capaProjectSelect" name="<c:out value="${status.expression}"/>"
														onchange="toggleCapaAnswears(this);">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${capaProjectOptions}" var="item">
															<option value="<c:out value="${item.name}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
												<c:choose>
													<c:when test="${command.incident.capaProject.name=='yes'}">
														<c:set var="capaAnswearsDisplay" value="display:block;height:150px;" />
													</c:when>
													<c:otherwise>
														<c:set var="capaAnswearsDisplay" value="display:none" />
													</c:otherwise>
												</c:choose>
												<c:set var="selected" value="${false}" />
									
												<div id="capaProjectAnswearsDiv"  style="${capaAnswearsDisplay}">
												<incident:bindField name="capaProjectAnswears"  required="${templateQuestion.mandatory}">
													<c:forEach items="${capaProjectAnswearOptions}" var="pi">
														<c:set var="selected" value="${false}" />
														<c:forEach items="${status.value}" var="selectedPi">
															<c:if test="${pi.id == selectedPi.id}">
																<c:set var="selected" value="${true}" />
															</c:if>
														</c:forEach>
														<input type="hidden" name="<c:out value="_${status.expression}"/>" />
														<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${pi.id}" />"
															<c:if test="${selected}">checked="checked"</c:if> />
														<span>
															<c:out value="${pi.name}" />
														</span>
														<br />
													</c:forEach>
												</incident:bindField>
												</div>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'actualSeverity'}">	
												<incident:bindField name="actualSeverity" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${actualSeverities}" var="item">
															<fmt:message key="${item}" var="actual" />
															<option value="<c:out value="${item.name}" />" title="<c:out value="${actual}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'potentialSeverity'}">	
												<incident:bindField name="potentialSeverity" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${potentialSeverities}" var="item">
															<fmt:message key="${item}" var="potential" />
															<option value="<c:out value="${item.name}" />" title="<c:out value="${potential}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'processSeverity'}">
												<incident:bindField name="processSeverity" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${processSeverities}" var="item">
															<fmt:message key="${item}" var="processS" />
															<option value="<c:out value="${item.name}" />" title="<c:out value="${processS}" />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'severityRanking'}">
												<incident:bindField name="severityRanking" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value=""><fmt:message key="blankOption" /></option>
														<c:forEach items="${severitiesRanking}" var="item">
															<option value="<c:out value="${item.name}" />" title="<fmt:message key='${item.name}'  />"
																<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'department'}">
												<incident:bindQuestionField name="department" question="${departmentQuestion}" required="false">
													<enviromanager:question path="answers" question="${departmentQuestion}" emptyOptionLabel="Choose" class="departmentDiv"
														multiselectCheckboxes="false" required="${templateQuestion.mandatory}"/>
													    <span class="col-sm-6"><fmt:message key="selectincident" /></span>
												</incident:bindQuestionField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'workArea'}">
												<incident:bindQuestionField name="workArea" question="${workAreaQuestion}"  required="false">
													<enviromanager:question path="answers" question="${workAreaQuestion}" emptyOptionLabel="Choose" required="${templateQuestion.mandatory}"
														multiselectCheckboxes="false"/>
												</incident:bindQuestionField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'location2'}">
												<incident:bindQuestionField name="location2" question="${locationQuestion}" required="false">
													<enviromanager:question path="answers" question="${locationQuestion}" emptyOptionLabel="Choose"
														multiselectCheckboxes="false" required="${templateQuestion.mandatory}"/>
												</incident:bindQuestionField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'incidentSource'}">
												<incident:bindField name="incidentSource" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>" >
														<option value="0"><fmt:message key="blankChoose" /></option>
														<c:forEach items="${incidentSources}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" />
																</option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'incidentCategory'}">
												<incident:bindField name="incidentCategory" required="${templateQuestion.mandatory}">
													<span class="col-sm-10 sp"><select name="<c:out value="${status.expression}"/>" >
														<option value="0"><fmt:message key="blankChoose" /></option>
														<c:forEach items="${incidentCategories}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" />
																</option>
															</c:if>
														</c:forEach>
													</select></span>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'equipmentLocation'}">
												<c:if test="${incidentAvailableFieldsByName['equipmentLocation'] != null}">
													<div class="form-group">
														<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="equipmentLocation" /></label>
															<incident:bindQuestionFieldOnly name="equipmentLocation" question="${equipmentLocationQuestion}">
																<enviromanager:question path="answers" question="${equipmentLocationQuestion}" emptyOptionLabel="Choose"
																	multiselectCheckboxes="false" cssStyle="float:left;width:20%"/>
															</incident:bindQuestionFieldOnly> 
															<incident:bindQuestionFieldOnly name="equipment" question="${equipmentQuestion}">
																<enviromanager:question path="answers" question="${equipmentQuestion}" emptyOptionLabel="Choose"
																	multiselectCheckboxes="false" cssStyle="float:left;width:20%"/>
															</incident:bindQuestionFieldOnly> <!-- The following is a very special case!!! Not normal flow --> 
															<c:choose>
																<c:when test="${equipmentIdQuestion != null}">
																	<incident:bindQuestionFieldOnly name="equipmentLocation" question="${equipmentIdQuestion}">
																		<enviromanager:question path="answers" question="${equipmentIdQuestion}" emptyOptionLabel="Choose"
																			multiselectCheckboxes="false" cssStyle="float:left;width:20%"/>
																	</incident:bindQuestionFieldOnly>
																</c:when>
																<c:otherwise>
																	<incident:bindField name="equipmentIdFreeText" required="false">
																		<input id="<c:out value="${status.expression}"/>" type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
																		<div class="errorMessage">
																			<c:out value="${status.errorMessage}" />
																		</div>
																	</incident:bindField>
																</c:otherwise>
															</c:choose>
															<div class="col-sm-3">
																<c:if test="${templateQuestion.mandatory}"><span class="requiredHinted">*</span></c:if>
																<spring:bind path="equipmentLocation">
																	<span class="errorMessage">
																		<c:out value="${status.errorMessage}" />
																	</span>
																</spring:bind>
															</div>
													</div>
												</c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'process'}">
												<c:if test="${incidentAvailableFieldsByName['process'] != null or command.incident.process != null}">
															<incident:bindField name="process" required="${templateQuestion.mandatory}">
																<select id="process" name="<c:out value="${status.expression}"/>">
																	<option value=""><fmt:message key="blankOption" /></option>
																	<c:forEach items="${process}" var="item">
																		<c:if test="${item.active || item.id == status.value}">
																			<option value="<c:out value="${item.id}" />"
																				<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																				<c:out value="${item.name}" />
																			</option>
																		</c:if>
																	</c:forEach>
																</select>
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</incident:bindField> 
															<incident:bindField name="batch" required="${templateQuestion.mandatory}">
																<input id="<c:out value="${status.expression}"/>" type="text" name="<c:out value="${status.expression}"/>"  value="<c:out value="${status.value}"/>" class="form-control"  style="float:left;width:95%"/>
																<div class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</div>
															</incident:bindField>
														</c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'bagNumber'}">
												<incident:bindField name="bagNumber" required="${templateQuestion.mandatory}">
													<input id="bagNumber" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" size="75" class="form-control"  style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'packType'}">
												<incident:bindField name="packType" required="${templateQuestion.mandatory}">
													<input id="packType" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" size="75" class="form-control"  style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'amountQuantity'}">
												<incident:bindField name="amountQuantity" required="${templateQuestion.mandatory}">
													<input id="amountQuantity" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" size="75" class="form-control"  style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'scope'}">
												<incident:bindField name="scope" required="${templateQuestion.mandatory}">
													<input id="scope" type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
														size="75" class="form-control"  style="float:left;width:95%"/>
													<img id="showIncidentScope" src="<c:url value="/images/help_small.gif"/>"
														data-toggle="tooltip" data-original-title="<c:choose><c:when test="${incidentScopeHelp != null}"><c:out value="${incidentScopeHelp}"/></c:when><c:otherwise><fmt:message key="incident.scope.help"/></c:otherwise></c:choose>" />
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'sample'}">
												<incident:bindField name="sample" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${samples}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" /></option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'sampleDetails'}">
												<incident:bindField name="sampleDetails" required="${templateQuestion.mandatory}">
													<input id="sampleDetails" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" size="75" class="form-control"  style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'programmeImpacts'}">
												<incident:bindField name="programmeImpacts" style="min-height:130px;" required="${templateQuestion.mandatory}">
									
													<c:forEach items="${programmeImpactValues}" var="pi">
														<c:set var="selected" value="${false}" />
														<c:forEach items="${status.value}" var="selectedPi">
															<c:if test="${pi.id == selectedPi.id}">
																<c:set var="selected" value="${true}" />
															</c:if>
														</c:forEach>
														<input type="hidden" name="<c:out value="_${status.expression}"/>" />
														<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${pi.id}" />"
															<c:if test="${selected}">checked="checked"</c:if> />
														<span>
															<c:out value="${pi.name}" />
														</span>
														<br />
													</c:forEach>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'businessAreas'}">
												<c:if test="${incidentAvailableFieldsByName['businessAreas'] != null}" >
													<incident:bindField name="businessAreas" required="${templateQuestion.mandatory}" style="min-height:100px;">
														<spring:bind path="businessAreas">
										          			<c:forEach var="ba" items="${businessAreaList}">
											            		<c:set var="selected" value="${false}" />
											            		<c:forEach items="${businessAreas}" var="selectedBA">
											              			<c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
											            		</c:forEach>
											            		<input type="checkbox" id="businessAreas"
											                		name="<c:out value="${status.expression}"/>"
											                		value="<c:out value="${ba.id}" />" <c:if test="${selected}">checked="checked"</c:if> /><c:out value="${ba.name}" /><br>
											            		<c:remove var="selected" />
										          			</c:forEach>
										          			<span class="requiredHinted">*</span>
															
														</spring:bind>
											      </incident:bindField>
											    </c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'shift'}">
												<incident:bindField name="shift" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>">
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${shifts}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" /></option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'team'}">
												<incident:bindField name="team" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>" class="wide">
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${teams}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" /></option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'location'}">
												<incident:bindField name="location" labelOverride="locationOfIncident" required="${templateQuestion.mandatory}">
													<input id="location" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" size="75" class="form-control"  style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'immediateAction'}">
												<incident:bindField name="immediateAction" style="min-height:130px;"  required="${templateQuestion.mandatory}">
													<textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3"  class="form-control"  style="float:left;width:95%;max-height: 100%"><c:out
															value="${status.value}" /></textarea>
													
													<img id="showIncidentAction" style="margin-left: -20px; vertical-align: top;display:none"
														src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="<c:choose><c:when test="${incidentActionHelp != null}"><c:out value="${incidentActionHelp}"/></c:when><c:otherwise><fmt:message key="incident.action.help"/></c:otherwise></c:choose>" />
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'customerAcknowledgement'}">
												<incident:bindField name="customerAcknowledgement" required="${templateQuestion.mandatory}">
													<select name="<c:out value="${status.expression}"/>" >
														<option value="0"><fmt:message key="blankOption" /></option>
														<c:forEach items="${customerAcknowledgements}" var="item">
															<c:if test="${item.active || item.id == status.value}">
																<option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.name}" /></option>
															</c:if>
														</c:forEach>
													</select>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'acknowledgementDetails'}">
												<incident:bindField name="acknowledgementDetails" required="${templateQuestion.mandatory}">
													<input id="acknowledgementDetails" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" class="form-control" size="75" style="float:left;width:95%"/>
													<span class="requiredHinted">*</span>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'firstAidTreatment'}">
												<incident:bindField name="firstAidTreatment" required="${templateQuestion.mandatory}">
													<input id="firstAidTreatment" type="text" name="<c:out value="${status.expression}"/>"
														value="<c:out value="${status.value}"/>" class="form-control" size="75" style="float:left;width:95%"/>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'firstAidOutcome'}">
												<c:if test="${incidentAvailableFieldsByName['firstAidOutcome'] != null or command.incident.firstAidOutcome != null}">
														<spring:bind path="firstAidOutcome">
													<div class="form-group" style="${style}">
															<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
																<fmt:message key="firstAidOutcome" />
															</label>
															<div class="col-sm-6">
																<select id="firstAidOutcome" name="<c:out value="${status.expression}"/>">
																	<option value="0"><fmt:message key="blankOption" /></option>
																	<c:forEach items="${firstAidOutcomes}" var="item">
																		<option value="<c:out value="${item.name}" />"
																			<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																	</c:forEach>
																</select>
																<c:if test="${templateQuestion.mandatory}">
																	<span class="requiredHinted">*</span>
																</c:if>
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</div></div>
														</spring:bind>
														<spring:bind path="ohnNotified">
														<div class="form-group" style="${style}">
															<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
																<fmt:message key="ohnNotified" />
															</label>
															<div class="col-sm-6">
																<input type="hidden" name="<c:out value="_${status.expression}"/>" />
																<input type="checkbox" id="ohnNotified" name="<c:out value="${status.expression}"/>"
																	<c:if test="${status.value}">checked="checked"</c:if> />
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</div>
														</div>
													</spring:bind>
												</c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'supervisor'}">
												<c:if test="${incidentAvailableFieldsByName['supervisor'] != null }" >
													<incident:bindField name="supervisor" required="${templateQuestion.mandatory}">
																	<select id="supervisor" name="supervisor" >
																		<option value="0"><fmt:message key="blankOption" /></option>
																		<c:forEach items="${allUsersForSupervisor}" var="user">
																			<option value="<c:out value="${user.id}" />" <c:if test="${user.id == status.value}">selected="selected"</c:if>> 
																				<c:out value="${user.displayName}" />
																			</option>
																		</c:forEach>
																	</select>
											      </incident:bindField>
											    </c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'workGroup'}">
											    <c:if test="${incidentAvailableFieldsByName['workGroup'] != null}" >
													<incident:bindField name="workGroup" required="${templateQuestion.mandatory}">
																	<select name="workGroup" id="workGroup"  >
																		<option value=""><fmt:message key="blankOption" /></option>
																		<c:forEach items="${workGroupList}" var="wgValue">
																			<option value="<c:out value="${wgValue}" />" <c:if test="${wgValue == status.value}">selected="selected"</c:if>> 
																				<c:out value="${wgValue}" />
																			</option>
																		</c:forEach>
																	</select>
											      </incident:bindField>
											    </c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'workOrderNumber'}">
											    <c:if test="${incidentAvailableFieldsByName['workOrderNumber'] != null }" >
													<incident:bindField name="workOrderNumber" required="${templateQuestion.mandatory}">
														<spring:bind path="workOrderNumber">
															<input id="workOrderNumber" type="text" name="workOrderNumber" 
																cols="30" value="<c:out value="${status.value}"/>" class="form-control"  style="float:left;width:95%"/>
																
														</spring:bind>
											      </incident:bindField>
											    </c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'processSafety'}">
												<c:if test="${incidentAvailableFieldsByName['processSafety'] != null}" >
													<incident:bindField name="processSafety" required="${templateQuestion.mandatory}">
														<spring:bind path="processSafety">
															<input id="processSafety" type="checkbox" name="processSafety" 
																 value="<c:out value="true"/>" ${status.value == true ? "checked":"" } />
														</spring:bind>
											      </incident:bindField>
											    </c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'participants'}">
												<c:if test="${incidentAvailableFieldsByName['participants'] != null or not empty command.incident.participants}">
												<div class="form-group">
													<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
														<fmt:message key="participants" />
														<span class="scannell-tooltip"><img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>" ><span class="tooltiptext" style="white-space:normal;"><fmt:message key="peopleInvolvedTooltip" /></span></span>
													</label>
													
												<c:choose>
													<c:when test="${command.incident.sensitiveParticipantsDataViewable}">
													<div class="col-sm-6"></div>
												</div>
														<div class="participants">
															<div id="table" class="table-editable">
																<table class="table" id="participants">
																	<tr>
																		<td><fmt:message key="name" /></td>
																		<td><fmt:message key="type" /></td>
																		<td><fmt:message key="bodyPart" /></td>
																		<td><fmt:message key="role" /></td>
																		<td><fmt:message key="department" /></td>
																		<td><fmt:message key="injuryType" /></td>
																		<td style="width: 15%;"><fmt:message key="injuryDesc" /></td>
																		<td>
																			<button class="table-add g-btn g-btn--primary" onclick="return addPerson()"><fmt:message key="addPerson" /></button>
																		</td>
																	</tr>
																	
																	<c:forEach items="${command.incident.participants}" var="item" varStatus="s">
																	<c:set var="participant" value="${command.incident.participants[s.index]}" />
																	<spring:nestedPath path="participants[${s.index}]">
																		<tr id="participantRow">
																			<td ><spring:bind path="name"><input type="text" class="form-control"
																					id="incident.participants[${s.index}].name" name="incident.participants[${s.index}].name" value="${participant.name}" />
																					<span class="requiredHinted" >*</span>
																					<span class="errorMessage"><c:out value="${status.errorMessage}" /></span></spring:bind>
																			</td>
																			<td ><spring:bind path="type"><select id="incident.participants[${s.index}].type"
																					name="incident.participants[${s.index}].type" >
																					<option value=""><fmt:message key="blankOption" /></option>
																					<c:forEach items="${participantTypes}" var="item">
																						<option value="<c:out value="${item.name}" />"
																							<c:if test="${item.name == participant.type.name}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																					</c:forEach>
																				</select>
																				<span class="requiredHinted">*</span>
																				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span></spring:bind>
																			</td>
																			<td ><spring:bind path="bodyPart">
																				<select id="incident.participants[${s.index}].bodyPart"
																						name="incident.participants[${s.index}].bodyPart" value="${command.incident.participants[s.index].bodyPart}">
																					<option value=""><fmt:message key="blankOption" /></option>
																					<c:forEach items="${participantBodyParts}" var="item">
																					<option value="<c:out value="${item.name}" />"
																							<c:if test="${item.name == participant.bodyPart.name}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																					</c:forEach>
																				</select>
																				</spring:bind>

																				<c:choose>
																				    <c:when test="${empty command.incident.participants[s.index].bodyPartPic}">
																				        <c:set var="initialParticipantBodyImageSrc" value="../images/body.JPG"/>
																				        <c:set var="existingParticipantBodyImageSrc" value=""/>
																				        <c:set var="bodyImageStyle" value="style=display:none"/>
																				    </c:when>
																				    <c:otherwise>
																				        <c:set var="initialParticipantBodyImageSrc" value="${command.incident.participants[s.index].bodyPartPic}"/>
																				        <c:set var="existingParticipantBodyImageSrc" value="${command.incident.participants[s.index].bodyPartPic}"/>
																				        <c:set var="bodyImageStyle" value=""/>
																				    </c:otherwise>
																				</c:choose>

																				<img id="incident.participants[0].bodyPartPicture" class="small-body-image" <c:out value="${bodyImageStyle}"/> src="<c:url value="${initialParticipantBodyImageSrc}"/>" />
																				<canvas class="canvasClass" style="border: 1px solid red; display: none;" id="incident.participants[0].bodyPartCanvas" name="incident.participants[0].bodyPartCanvas"></canvas>	
																				<div class="links" style="margin-top: 5px;">
																					<a href="#/" name="incident.participants[0].open" id="incident.participants[0].open" onclick='openBodyPartImage(this.id);'><hidden >Open</a>
																					<a href="#/" name="incident.participants[0].clear" style="display:none" id="incident.participants[0].clear" onclick='clearCanvas(this.id);'>Clear</a>
																					<a href="#/" name="incident.participants[0].save" style="display:none" id="incident.participants[0].save" onclick='saveBodyPartImage(this.id);'>Save</a>
																				</div>
																				<input type="hidden" name="incident.participants[0].bodyPartPic" id="incident.participants[0].bodyPartPic" value="<c:url value="${existingParticipantBodyImageSrc}"/>"/>
																			</td>
																			<td ><spring:bind path="role">
																				<c:set var="role" value="${status.value}" />
																				<select id="incident.participants[${s.index}].role"
																					name="incident.participants[${s.index}].role" onchange="changeMandatoryType(this.value, this.id)">
																					<option value=""><fmt:message key="blankOption" /></option>
																					<c:forEach items="${participantRoles}" var="item">
																						<option value="<c:out value="${item.name}" />"
																							<c:if test="${item.name == participant.role.name}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																					</c:forEach>
																				</select>
																				<span class="requiredHinted">*</span>
																				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
																				</spring:bind>
																			</td>
																			<td ><select id="incident.participants[${s.index}].department"
																					name="incident.participants[${s.index}].department" >
																					<option value=""><fmt:message key="blankOption" /></option>
																					<c:forEach items="${participantDepartments}" var="item">
																						<c:if test="${item.active || item.id == status.value}">
																							<option value="<c:out value="${item.id}" />" title="<c:out value="${item.name}" />"	<c:if test="${item.name == participant.department.name}">selected="selected"</c:if>>
																								<c:out value="${item.name}" />
																							</option>
																						</c:if>
																					</c:forEach>
																				<span class="requiredHinted">*</span>
																				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
																				</select></td>
																			<td ><spring:bind path="injuryType">
																			<select id="incident.participants[${s.index}].injuryType"
																					name="incident.participants[${s.index}].injuryType" >
																					<option value=""><fmt:message key="blankOption" /></option>
																					<c:forEach items="${injuries}" var="item">
																						<c:if test="${item.active}">
																						 <option value="<c:out value="${item.id}" />" <c:if test="${item.id == participant.injuryType.id}">selected="selected"</c:if>>
																							<c:out value="${item.name}" /></option>
																						</c:if>
																					</c:forEach>
																				</select>
																				
																					<span ${role == 'Injured' ? "class='mandatory'" : ""}  id="incident.participants[${s.index}].roleMandatorySpan">${role == 'Injured' ? "*" : ""}</span>
																				<c:if test="${role == 'Injured'}">
																					<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
																				</c:if>
																				</spring:bind>
																			</td>
																			<td ><textarea id="incident.participants[${s.index}].injuryDescription"
																					name="incident.participants[${s.index}].injuryDescription" class="form-control" rows="3" cols="20" style="height:auto !important"><c:out value="${fn:trim(participant.injuryDescription)}" /></textarea>
																			</td>
																			<td><button id="delete-${s.index}" class="g-btn g-btn--primary" onclick="return deleteRow(this)">Delete</button></td>
									
																		</tr>
																		</spring:nestedPath>
																	</c:forEach>
														<c:if test="${incidentAvailableFieldsByName['participants'] == null or empty command.incident.participants}">			
																	<tr id="participantRow">
																		<td ><input type="text" class="form-control" id="incident.participants[0].name"
																				name="incident.participants[0].name" /><span class="requiredHinted" >*</span></td>
																				
																		<td >
																		<select id="incident.participants[0].type" name="incident.participants[0].type"
																				>
																				<option value=""><fmt:message key="blankOption" /></option>
																				<c:forEach items="${participantTypes}" var="item">
																					<option value="<c:out value="${item.name}" />"
																						<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																				</c:forEach>
																			</select><span class="requiredHinted" >*</span></td>
																		<td >
																		<select id="incident.participants[0].bodyPart"
																				name="incident.participants[0].bodyPart" onselect="showBodyImageDive(this.id)">
																				<option value=""><fmt:message key="blankOption" /></option>
																				<c:forEach items="${participantBodyParts}" var="item">
																					<option value="<c:out value="${item.name}" />"
																						<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																				</c:forEach>
																			</select>
																		<img id="incident.participants[0].bodyPartPicture" class="small-body-image" style="display: none;" src="<c:url value="../images/body.JPG"/>" />
																		<canvas class="canvasClass" style="border: 1px solid red;display:none"  id="incident.participants[0].bodyPartCanvas" name="incident.participants[0].bodyPartCanvas"></canvas>	
																				<div class="links" style="margin-top: 5px;">
																					<a href="#/" name="incident.participants[0].open" id="incident.participants[0].open" onclick='openBodyPartImage(this.id);'><hidden >Open</a>
																					<a href="#/" name="incident.participants[0].clear" style="display:none" id="incident.participants[0].clear" onclick='clearCanvas(this.id);'>Clear</a>
																					<a href="#/" name="incident.participants[0].save" style="display:none" id="incident.participants[0].save" onclick='saveBodyPartImage(this.id);'>Save</a>
																				</div>
																				<input type="hidden" name="incident.participants[0].bodyPartPic" id="incident.participants[0].bodyPartPic" />
																		</td>
																		<td ><select id="incident.participants[0].role" name="incident.participants[0].role"
																				onchange="changeMandatoryType(this.value, this.id)">
																				<option value=""><fmt:message key="blankOption" /></option>
																				<c:forEach items="${participantRoles}" var="item">
																					<option value="<c:out value="${item.name}" />"
																						<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
																				</c:forEach>
																			</select><span class="requiredHinted" >*</span></td>
																		<td ><select id="incident.participants[0].department"
																				name="incident.participants[0].department" >
																				<option value=""><fmt:message key="blankOption" /></option>
																				<c:forEach items="${participantDepartments}" var="item">
																					<c:if test="${item.active || item.id == status.value}">
																						<option value="<c:out value="${item.id}" />" title="<c:out value="${item.name}" />"
																							<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																							<c:out value="${item.name}" /></option>
																					</c:if>
																				</c:forEach>
																			</select></td>
																		<td ><select id="incident.participants[0].injuryType"
																				name="incident.participants[0].injuryType" >
																				<option value=""><fmt:message key="blankOption" /></option>
																				<c:forEach items="${injuries}" var="item">
																					<c:if test="${item.active}">
																						<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
																					</c:if>
																				</c:forEach>
																			</select><span id="incident.participants[0].roleMandatorySpan"></span></td>
																		<td ><textarea id="incident.participants[0].injuryDescription" 
																				name="incident.participants[0].injuryDescription" class="form-control" rows="3" cols="20" style="height:auto !important" ></textarea></td>
																		<td><button class="g-btn g-btn--primary" onclick="return deleteRow(this)">Delete</button></td>
																	</tr>
																</c:if>	
																</table>
															</div>
															<span class="errorMessage">
																<c:out value="${status.errorMessage}" />
															</span>
															</div>
														</c:when>
														<c:otherwise>
															<div class="col-sm-6"><font color="red"><c:out value="CONFIDENTIAL"/></font></div></div>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'assignees'}">									
												<!-- ENV-8328: Can be rolled out to all later  -->
												<incident:bindField name="assignees" style="min-height:250px" required="${false}">
													<c:if test="${templateQuestion.helpText != null && templateQuestion.helpText != ''}">
														<img src="<c:url value="/images/help_small.gif"/>"
															data-toggle="tooltip" data-html="true" data-original-title='${templateQuestion.helpText}' />
													</c:if>
													<c:set var="single" value="${command.incidentType.singleAssignable}" />
													<table class="table table-responsive">
														<thead>
															<tr>
																<th><fmt:message key="incident.editIncident.activeUsers" /></th>
																<th></th>
																<th><fmt:message key="incident.editIncident.assignToUsers" /></th>
																<th>&nbsp;</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td align="center"><select id="unassigned" name="unassigned" class="box" multiple="multiple" size="8"
																		style="width: 300px;" onDblClick="checkAssigned(${single}, '#unassigned','#assignees');"
																		<c:choose>
																			<c:when test="${single}">
																			</c:when>
																			<c:otherwise>multiple="multiple"</c:otherwise>
																		</c:choose>>
																		<c:forEach items="${users}" var="item">
																			<option id="<c:out value="assignee${item.id}" />" value="<c:out value="${item.id}" />"><c:out
																					value="${item.sortableName}" /></option>
																		</c:forEach>
																	</select></td>
									
																<td align="center"><input id="rightButton" class="g-btn g-btn--primary" style="margin-bottom: 5px" type="button" name="right"
																		value="&gt;&gt;" onclick="checkAssigned(${single}, '#unassigned','#assignees')" /><br>
									
																	<input type="button" class="g-btn g-btn--primary" name="left" value="&lt;&lt;"
																		onclick="checkMandatory('#assignees','#unassigned')" /><br></td>
									
																<td align="center"><select id="assignees" name="assignees" class="box" multiple="multiple" size="8"
																		style="width: 300px;" ondblclick="checkMandatory('#assignees','#unassigned')"><!-- for some rason it  was using the method MOVE here, but it needs some validation, so changing again to checkManadatory method -->
																	</select></td>
									
																<td><c:forEach items="${command.incident.assignees}" var="item" varStatus="s">
																		<spring:bind path="assignees[${s.index}]">
																			<div class="errorMessage">
																				<c:out value="${status.errorMessage}" />
																			</div>
																		</spring:bind>
																	</c:forEach><c:if test="${templateQuestion.mandatory or command.incidentType.assignedMandatory}">
																		<span class="requiredHinted">*</span></c:if>
																</td>
															</tr>
														</tbody>
													</table>
												</incident:bindField>
											</c:when>
											<c:when test="${templateQuestion.questionName == 'communicatedTo'}">
												  <c:if test="${incidentAvailableFieldsByName['communicatedTo'] != null || incidentType == null}"> 					
												<!-- ENV-8385: Can be rolled out to all later  -->
												<incident:bindField name="communicatedTo" labelOverride="incident.editIncident.communicatedTo" required="false"
													style="min-height:250px">
													<c:if test="${templateQuestion.helpText != null && templateQuestion.helpText != ''}">
														<img src="<c:url value="/images/help_small.gif"/>"
															data-toggle="tooltip" data-html="true" data-original-title='${templateQuestion.helpText}' />
													</c:if>
													<table class="table table-responsive">
														<thead>
															<tr>
																<th><fmt:message key="incident.editIncident.notifyToUsers" /> ${hideCommunicatedTo}</th>
																<th></th>
																<th><fmt:message key="incident.editIncident.communicatedToUsers" /></th>
																<th>&nbsp;</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td align="center"><select id="activeUsers" name="activeUsers" class="box" multiple="multiple" size="8"
																		onDblClick="move('#activeUsers','#communicatedTo')" style="width: 300px;">
									
																		<c:forEach items="${allUsers}" var="item">
																			<option id="<c:out value="activeUser${item.id}" />" value="<c:out value="${item.id}" />">
																				<c:out value="${item.sortableName}" /></option>
																		</c:forEach>
																	</select></td>
									
									
																<td align="center"><input id="communicatedToRightButton" class="g-btn g-btn--primary" style="margin-bottom: 5px" type="button" name="right"
																		value="&gt;&gt;" onclick="move('#activeUsers','#communicatedTo')" /><br>
																	<input type="button" class="g-btn g-btn--primary" name="left" value="&lt;&lt;"
																		onclick="selectItem('#communicatedTo','#activeUsers')" /><br></td>
									
																<td style="text-align:center;"><select id="communicatedTo" name="communicatedTo" class="box"
																		multiple="multiple" size="8" onDblClick="selectItem('#communicatedTo','#activeUsers')"
																		style="width: 300px;">
																	</select></td>
																<td><c:forEach items="${command.incident.communicatedTo}" var="item" varStatus="s">
																		<spring:bind path="communicatedTo[${s.index}]">
																			<div class="errorMessage">
																				<c:out value="${status.errorMessage}" />
																			</div>
																		</spring:bind>
																	</c:forEach><c:if test="${templateQuestion.mandatory}">
																		<span class="requiredHinted">*</span></c:if></td>
															</tr>
														</tbody>
													</table>
												</incident:bindField>
												</c:if>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:if test="${templateQuestion.question.active}">
											<div class="form-group">
												<label class="col-sm-3 control-label scannellGeneralLabel"><c:out value="${templateQuestion.question.name}" /></label>
											    <div class="col-sm-6">
										        	<enviromanager:question path="incidentAnswers" question="${templateQuestion.question}" emptyOptionLabel="Choose"
																multiselectCheckboxes="false" required="${templateQuestion.mandatory}" overrideRequired="true" />
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

			<div style="clear: both"></div>
						
			<c:if test="${command.incidentType.investigationConfigured}">
				<incident:bindField name="investigationClosureDate" required="${false}">
					<c:choose>
						<c:when test="${command.incident.notifyEditable}">
						<div class="col-sm-6">
							<div class="input-group date datetime" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
	                        <input id="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"  class="form-control dateToChange" size="16" id="fromDate" name="<c:out value="${status.expression}"/>" type="text"  readonly>
	                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
	                        </div>
						</div>
						</c:when>
						<c:otherwise>
						<div class="col-sm-6">
							<div class="input-group date datetime " class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
	                        <input style="width:100%" id="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" readonly="readonly"  class="form-control dateToChange"  id="fromDate" name="<c:out value="${status.expression}"/>" type="text"  readonly>
	                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
	                        </div>
						</div>				
							
						</c:otherwise>
					</c:choose>
				</incident:bindField>
			</c:if>
			
			<div style="clear: both"></div>
											
			<%-- <c:if test="${command.incident.activeConfidentialVisible and command.incident.id>0}"> --%>
			<div class="form-group activeHide" style="display:none">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="active" />
				</label>
				<div class="col-sm-6">
					<spring:bind path="active">
						<input type="hidden" name="<c:out value="_${status.expression}"/>" />
						<input type="checkbox" id="activeCheckbox" name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if>  onclick="showInActiveAlertMessage();"/>
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
					</spring:bind>
				</div>
			</div>
			<div class="form-group activeHide" style="display:none">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="incident.confidential" />
				</label>
				<div class="col-sm-6">
					<spring:bind path="confidential">
						<input type="hidden" name="<c:out value="_${status.expression}"/>" />
						<c:choose>
							<c:when test="${!command.incident.sensitiveDataViewable}">
								<input type="hidden" name="<c:out value="${status.expression}"/>" value="${status.value}" />
								<input type="checkbox" name="x" <c:if test="${status.value}">checked="checked"</c:if> disabled
									/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="<c:out value="${status.expression}"/>"
									<c:if test="${status.value}">checked="checked"</c:if> />
							</c:otherwise>
						</c:choose>
						<span class="errorMessage">
							<c:out value="${status.errorMessage}" />
						</span>
					</spring:bind>
				</div>
			</div>
	<%-- 	</c:if> --%>
		</spring:nestedPath>

		<div class="help" id="help" style="display: none; position: absolute;"></div>
		<c:if test="${allowUserToSelectSite != null}">
		<div class="form-group" id="div-site">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="site" />
				</label>
				<div class="col-sm-6">
				
						<scannell:select id="userSelectedSite" path="userSelectedSite" items="${allowUserToSelectSite}" cssStyle="width:20%" itemValue="id" itemLabel="name"
							 emptyOptionLabel="Choose" onchange="filterDepartment(this)" />
						
					<span class="requiredHinted">*</span>
				</div>
			</div>
		
	<div style="clear: both"></div>
		<c:if test="${showCaptcha eq 'true'}">
			<div align="center">
					<div class="g-recaptcha" data-sitekey="<fmt:message key="google.recaptcha.v2.data.sitekey"/>"></div>
			</div>
		</c:if>
		</c:if>	
			
	<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>

	</scannell:form>

</body>
</html>
