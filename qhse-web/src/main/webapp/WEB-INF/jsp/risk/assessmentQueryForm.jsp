<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/riskScoreBoard.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
  <c:set value="500" var="maxListSize"/>

<style type="text/css" media="all">
.searchQueryFormSegment {
	background-color: white !important; border-width: 0px !important; padding-top: 20px !important;
}

td.searchLabel {
	padding-right: 5% !important;
}
 
table td {
	border-left: 0px !important; border-bottom: 0px !important;
}

.table>tfoot>tr>td {
	border-top: 0px !important;
}

table td:last-child {
	border-right: 0px !important;
}
.select2Util{
	
}
</style>

<c:set var="attachmentDrivenTemId" value="${attachmentDrivenTemplateId}" />
<script type="text/javascript">
// contextPath is throwing exception in printable page when this page open from quickLink button because contextPath does not exist because the printable page does not import frameDecorator
//and this variable is created in frameDecorato.jsp
var contextPath = '<%=request.getContextPath()%>';

function backChangeSelectNames() {

// 	jQuery('select.select2Util').each(function() {
// 		// $(this) now refers to one specific <select> element
// 		newId = this.id.replace("[", "_");
// 		newId = newId.replace("]", "_");

// 		this.id = newId;

// 	});
}
	function changeSelectNames() {
		
// 		jQuery('select.select2Util').each(function() {
// 			// $(this) now refers to one specific <select> element
// 			newId = this.id.replace("_", "[");
// 			newId = newId.replace("_", "]");

// 			this.id = newId;

// 		});
		
	}

	jQuery(document).ready(function() {
		
		jQuery("#templateId").select2();

		jQuery("#sortName").select2();
		jQuery("#sortName").select2().select2('val',
				jQuery('#sortName option:eq(0)').val());

		jQuery("#createdByUser").select2();

		jQuery("#status").select2();

		var responsibleUserText='';
		var responsibleUserId= '<c:out value="${command.responsibleUser.id}"/>';
		if(responsibleUserId != null){
			responsibleUserText= '<c:out value="${command.responsibleUser.sortableName}"/>';
			jQuery('#responsibleUser').val(responsibleUserId);
			jQuery('#responsibleUser').select2('val', responsibleUserId);
		}
		showUserList(${fn:length(userList)}, "responsibleUser", "40", "raUserList.json", responsibleUserId,responsibleUserText);
		
		jQuery("#approvedByUser").select2();
		jQuery("#reviewed").select2();
		jQuery("#onlyForAttachmentDriven").hide();
		
		displayQueryDiv(false);
		
		// #AddedByFernando, i took the example from method init2
		// this is necessary as the submit is being performed periodically before the form is being populated. Delaying it by 2 seconds.
		setTimeout(function() {
			jQuery( "select" ).each(function( index ) {
				jQuery(this).select2().select2('val',jQuery(this).val());
			});
			//if exists
 			if(jQuery(document.getElementById('answers[11001]')).length) { jQuery(document.getElementById('answers[11001]')).change();}
 			//else if(jQuery(document.getElementById('answers_11001_')).length) { jQuery(document.getElementById('answers_11001_')).change();}
		}, 2000);
		
		disableKeyIssues();
		if('${command.scoreType}' != 'null' && '${command.scoreType}' != ''){
			jQuery('#scoreTypeUtil').val('${command.scoreType}');
		}
	});
<%-- Disable and enabling of select2 has some problem with IE10 and older version. To workaround this situation we are now hidding/showing multiselect instead of disabling --%>
	function disableHazard() {
		//Column from Result page was also getting disappeared so making this change
		//jQuery("[id*='300287']").parent().hide();
		//jQuery("[id*='300295']").parent().hide();
		
		jQuery("select[name='answers[300287]']").parent().parent().hide();
		jQuery("select[name='answers[300295]']").parent().parent().hide();
	}

	function enableHazard() {
		//Column from Result page was also getting disappeared so making this change
		//jQuery("[id*='300287']").parent().show();
		//jQuery("[id*='300295']").parent().show();
		
		jQuery("select[name='answers[300287]']").parent().parent().show();
		jQuery("select[name='answers[300295]']").parent().parent().show();
	}

	function toggleKeyIssues(){
		    var ischecked= jQuery("#keyIssuesCheckBox").is(':checked');
		    if(ischecked){
		    	enableKeyIssues();
		    }else{
		    	disableKeyIssues();
		    }

	}
	function disableKeyIssues(){
		jQuery("[id*='310287']").val("").trigger('change');
		jQuery("[id*='350287']").val("").trigger('change');
		jQuery("[id*='410002']").val("").trigger('change');
		
		jQuery("select[name='answers[310287]']").parent().parent().hide();
		jQuery("select[name='answers[350287]']").parent().parent().hide();
		jQuery("select[name='answers[410002]']").parent().parent().hide();
		
		
	}
 	function enableKeyIssues(){
		jQuery("select[name='answers[310287]']").parent().parent().show();
		jQuery("select[name='answers[350287]']").parent().parent().show();
		jQuery("select[name='answers[410002]']").parent().parent().show();
		jQuery('#scoreTypeUtil').val('');
 	}
	var postPopulateQuestionOptionsCallbackHandler = null;
	var populateQuestionOptionsCount = 0;
	var q11001 = '';
	var q64 = '';
	function populateQuestionOptions(element, value) {
		var questionId = document.getElementById(element.id).getAttribute(
				'questionid');		
		//SystemDWRService.getQuestionName(questionId, function(data) { $('answers['+questionId+'].name').innerHTML = data; });
		DWRUtil.removeAllOptions(element.id);
		if (questionId != '') {
			DWRUtil.addOptions(element.id, {
				"" : "Choose"
			});
			populateQuestionOptionsCount++;
			if(questionId == 42){				
			SystemDWRService.getQuestionOptionsObsoleteArray(questionId,
						function(data) {
							populateQuestionOptionsCallback(element, data, value);
						});	
			}else{
			SystemDWRService.getQuestionOptionsArray(questionId,
					function(data) {
						populateQuestionOptionsCallback(element, data, value);
						savedSearchCriteraHazardAspect();  //This method is called many times overwiting my changes so calling savedSearchCriteraHazardAspect from this method.
					});
			}
		}

		jQuery("select").each(function() {
			if (jQuery(this).hasClass("boot")) {
				jQuery(this).select2();
				disableHazard();

			}
		});
		
		var callInitDependsOn = false;
		if(jQuery(document.getElementById("answers[11001]")).length) {
			jQuery(document.getElementById("answers[11001]")).attr("dependson", "answers[42]");
			jQuery(document.getElementById("answers[11001]")).attr("emptyoptionlabel", "Choose");
			callInitDependsOn = true;
		} else if(jQuery(document.getElementById("answers_11001_")).length) {
			jQuery(document.getElementById("answers_11001_")).attr("dependson", "answers_42_");
			jQuery(document.getElementById("answers_11001_")).attr("emptyoptionlabel", "Choose");
			callInitDependsOn = true;
		}
		if(jQuery(document.getElementById("answers[64]")).length) {
			jQuery(document.getElementById("answers[64]")).attr("dependson", "answers[11001]");
			jQuery(document.getElementById("answers[64]")).attr("emptyoptionlabel", "Choose");
			callInitDependsOn = true;
		} else if(jQuery(document.getElementById("answers_64_")).length) {
			jQuery(document.getElementById("answers_64_")).attr("dependson", "answers_11001_");
			jQuery(document.getElementById("answers_64_")).attr("emptyoptionlabel", "Choose");
			callInitDependsOn = true;
		}
		
		if(callInitDependsOn) {
			initDependsOn("queryForm");
		}
	}
function addChoose(){}
function populateQuestionOptionsCallback(element, data, value) {
	DWRUtil.removeAllOptions(element.id);
	var questionId = document.getElementById(element.id).getAttribute(
			'questionid');
	if(!document.getElementById(element.id).multiple){
		DWRUtil.addOptions(element.id, {
			"" : "Choose"
		});
	}
	
	DWRUtil.addOptions(element.id, data);
	populateQuestionOptionsCount--;
	if (postPopulateQuestionOptionsCallbackHandler) {
		postPopulateQuestionOptionsCallbackHandler();
	}
	sortSelect(element.id);
	if (value) {
		
		var options = document.getElementById(element.id).options;
		for (var i = 0, l = options.length; i < l; i++) {
			if (options[i].value == value) {
				options[i].selected = true;
				jQuery('#'+element.id+' option[value="'+options[i].value+'"]').prop('selected', 'selected').change();
				optionListUpdatable.push({questionId: element.id, optionId: options[i].value});
			}
		}
	}
	
}
function selectChosenOption(questId){
	for(var c = 0; c < optionListUpdatable.length; c++){
		if(questId == optionListUpdatable[c].questionId){
			jQuery('#'+questId+' option[value="'+optionListUpdatable[c].optionId+'"]').prop('selected', 'selected').change();
		}
	}
}
var optionListUpdatable = new Array();	
	function sortSelect(selectId){
		var options = jQuery('#'+selectId+' option');                    // Collect options         
		options.detach().sort(function(a,b) { // Detach from select, then Sort
			if(jQuery(a).text() == "Choose"){
				jQuery(a).text(" Choose") ;
			}
			if(jQuery(b).text() == "Choose"){
				jQuery(b).text(" Choose") ;
			}
		    var at = jQuery(a).text();
		    var bt = jQuery(b).text();         
		    return (at > bt)?1:((at < bt)?-1:0);            // Tell the sort function how to order
		});
		options.appendTo('#'+selectId);
		jQuery('#'+selectId).val('')
	}
var clearButtonPressed = 'NO';

	function onTemplateChange() {
		var templateId = jQuery("#templateId").val();
		var criteriaId = jQuery("#searhCriteriaId").val();

		var contains=false;
		<c:forEach var="item" items="${attachmentDrivenTemplateId}">
		if("${item}"==templateId){
			contains=true;
		}

		</c:forEach>
		
		if(contains){
			jQuery("#onlyForAttachmentDriven").show();
			jQuery('#nrag').select2({width:'10%'});
		}else{
			jQuery("#onlyForAttachmentDriven").hide();
		}
		var date = new Date();
		var time = date.getTime();
		
		var url = contextPath + '/risk/assessmentQueryFormSegment.ajax?id='
				+ templateId + '&date=' + time+'&clearButton='+clearButtonPressed;
		if(jQuery("#searhCriteriaId").val() && jQuery("#searhCriteriaId").val() > 0)
		{
			url = url + '&searchCriteriaId=${criteriaId}';
		}
		var curl = '<c:url value="'+url+'" />';
		clearButtonPressed = 'NO';

		jQuery.ajax({
			url : curl,
			success : function(transport) {
				var response = transport.responseText || "";
				try {
					eval(response);
					var noQuestions = loadTemplateQuestions();
					if (postPopulateQuestionOptionsCallbackHandler) {
						postPopulateQuestionOptionsCallbackHandler();
					}
				} catch (err) {
					//alert("error Ajax:" + err.message);
				}

			},
			onFailure : function() {
				alert('Something went wrong...')
			}
		});
		
		if(templateId != null && templateId != '' && templateId == '${multiApprovalTemplateId}'){
			jQuery("#ramsStatusRow").show(); 
			jQuery("#overdueRow").show();
			jQuery("#onlyForAttachmentDriven").hide();
		}else{
			jQuery("#ramsStatusRow").hide(); 
			jQuery("#overdueRow").hide();
		}
		
	}

	function savedSearchCriteraHazardAspect(){
		var hazardAspectOption = '${hazardAspectOptions}';
		if(hazardAspectOption){
			jQuery('#scoreType1').attr('checked', false);
			jQuery('#scoreType2').attr('checked', true);
			enableHazard();
			var selectedValues = hazardAspectOption.split(',');
		    jQuery("[id*='300295']").select2('val',selectedValues);
		    jQuery("[id*='300287']").select2('val',selectedValues);

		}else{
			jQuery('#scoreType1').attr('checked', true);
			jQuery('#scoreType2').attr('checked', false);
			disableHazard();
		}
	}

	function init() {
		// Set the default value of the status to 'apporved'
		//  $('status').selectedIndex = 2;

		// We need to load both before and after the template change. The first load is required
		// to set the tempalte correctly, while the second load is to set the additional questions.
		
		copyFormValuesIfPopup('queryForm');
		if('${quickLink}' != '') {
			displayQueryDiv(false);
		 	clearForm();
			templateRow.Visible = false;
			jQuery("templateId").select2().select2('val',
					jQuery('#templateId option:eq(0)').val());
			var selectedStatus = '${selectedStatus}';
			if(selectedStatus) {
				jQuery("#status").val(selectedStatus).trigger('change');
			}
			var selectDepartment = '${selectedDepartment}';
			if(selectDepartment) {
				jQuery("#answers_42_").val(selectDepartment).trigger('change');
			}
		}
		
		
		postPopulateQuestionOptionsCallbackHandler = init2();
		onTemplateChange();
		ajaxPrint = true;
	}
	function getUrlParameter(sParam)
	{
	    var sPageURL = window.location.search.substring(1);
	    var sURLVariables = sPageURL.split('&');
	    for (var i = 0; i < sURLVariables.length; i++) 
	    {
	        var sParameterName = sURLVariables[i].split('=');
	        if (sParameterName[0] == sParam) 
	        {
	            return sParameterName[1];
	        }
	    }
	}
	function init2() {
		if (populateQuestionOptionsCount == 0) {
			postPopulateQuestionOptionsCallbackHandler = null;
			copyFormValuesIfPopup('queryForm');
			// this is necessary as the submit is being performed periodically before the form is being populated. Delaying it by 2 seconds.   	  
		//	setTimeout(function() {
				jQuery('#queryForm').submit();
				updateSearchCriteriaSummary();
		//	}, 2000);
			displayQueryDiv(false);
			jQuery('#queryTableToggleLink')
					.html(
							'<i class="fa fa-compress" style="color:white"> </i>&nbsp;Display Search');
		}
	}
	/* Event.observe(window, 'load', init, false); */
	jQuery(window).bind('load', init);

	function clearForm() {
		jQuery("#searhCriteriaId").val('0');
		jQuery("#templateId").select2().select2('val',
				jQuery('#templateId option:eq(0)').val());
		jQuery("#sortName").select2().select2('val',
				jQuery('#sortName option:eq(0)').val());
		jQuery("#createdByUser").select2().select2('val',
				jQuery('#createdByUser option:eq(0)').val());
		jQuery("#status").select2().select2('val',
				jQuery('#status option:eq(0)').val());
		jQuery('#responsibleUser').val('').change();
		jQuery("#responsibleUser").select2('val',
				jQuery('#responsibleUser option:eq(0)').val());
		jQuery("#approvedByUser").select2().select2('val',
				jQuery('#approvedByUser option:eq(0)').val());
		jQuery("#reviewed").select2().select2('val',
				jQuery('#reviewed option:eq(0)').val());
		var elem = document.getElementById('queryForm').elements;
		for (var i = 0; i < elem.length; i++) {
			var type = elem[i].type, tag = elem[i].tagName.toLowerCase();
			if (type == 'text' || tag == 'textarea') {
				elem[i].value = '';
			}
		}
		clearButtonPressed = 'YES';
		onTemplateChange();
		// Add by Fernando, i took the example from method init2
		// this is necessary as the submit is being performed periodically before the form is being populated. Delaying it by 2 seconds.
		if('${quickLink}' == '') {
			setTimeout(function() {
				jQuery('select').not('#siteLocation').val('');
				jQuery("#templateId").select2().select2('val', jQuery('#templateId option:eq(0)').val());
				updateSearchCriteriaSummary();
				jQuery(document.getElementById('answers[42]')).val('');
			}, 2000);
		}
		//init();
		//init2();
		jQuery("#answers_42_").val('').trigger('change');
	}
	
	function changeStatus(obj){
		if(obj.value == 'red') {
			jQuery("#status").select2().select2('val', 'REJECTED');
		} else if(obj.value == 'amber') {
			jQuery("#status").select2().select2('val', 'IN_PROGR');
		} else {
			jQuery("#status").select2().select2('val', 'COMPLETE');
		}
	}
	function changeStatusColour(obj) {
		if(obj.value == 'IN_PROGR') {
			jQuery('input:radio[name=scoreColour]').filter('[value=amber]').prop('checked', true);
		} else if(obj.value == 'REJECTED') {
			jQuery('input:radio[name=scoreColour]').filter('[value=red]').prop('checked', true);
		} else if(obj.value == 'COMPLETE') {
			jQuery('input:radio[name=scoreColour]').filter('[value=green]').prop('checked', true);
		} else {
			jQuery('input:radio[name=scoreColour]').filter('[value=amber]').prop('checked', false);
			jQuery('input:radio[name=scoreColour]').filter('[value=red]').prop('checked', false);
			jQuery('input:radio[name=scoreColour]').filter('[value=green]').prop('checked', false);
		}
	}
	function setOverdueApproval(obj){
		if(obj.checked == true) {
			jQuery('#overdueApproval').val(true);
		} else {
			jQuery('#overdueApproval').val(false);
		}
		obj.value = false;
		
	}
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/risk/legacyIdAssessment.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/assessmentQueryResult.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/assessmentQueryResult.htmf');
	}
	function trimDescription(){
		jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  	}
</script>
</head>
<body>

	<div class="col-md-12">
		<div id="block" class="">
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form id="goToForm" action="<c:url value="/risk/assessmentView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
					
					<input type="hidden" name="page" value="assessment"/>
					<c:if test="${showLegacyId}">
						<label>Legacy ID</label> 
		                <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
		            </c:if>
						Go to RA ID
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Display Search</button>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='assessmentTemplateList.htm'">
								<i class="fa fa-edit" style="color: white"></i>&nbsp;New RA
							</button>
						</c:if>
						<button  type="button" onclick="window.open(jQuery('#printParam').val().replace('quickLinkId','noQuickLinkId'), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
					</div>
				</div>
		</div>
	</div>

	<scannell:form id="queryForm" action="/risk/assessmentQueryResult.htmf"
		onsubmit="return searchExcelCheck(this, 'resultsDiv');updateSearchCriteriaSummary();">
		<scannell:hidden path="calculateTotals" />
		<scannell:hidden path="pageNumber" />
		<scannell:hidden path="pageSize" />
		<input type="hidden" value="" id="scoreTypeUtil" name="scoreTypeUtil">
		<input type="hidden" name="answerUnion" value="true" />
		<input type="hidden" id="searhCriteriaId" name="searhCriteriaId" value="${criteriaId}" />
		<input type="hidden" name="currentUser" id="currentUser" value="${currentUser}" />
		<div id="queryDiv">
			<div class="header" style="margin-top: 10px">
				<h3>
					<fmt:message key="searchCriteria" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">

					<div class="table-responsive hidden-print">
						<table id="queryTable" class="table table-responsive">
							<fmt:message var="blankChoose" key="blankChoose" />
							<tbody id="searchCriteria">
								<tr id="templateRow" class="form-group">
									<td class="searchLabel" id="templateIdLabel"><fmt:message key="assessment.template" />:</td>
									<td colspan="3" class="search"><select name="templateId" id="templateId" items="${templateList}"
											itemLabel="name" itemValue="id" cssStyle="width:40%" renderEmptyOption="true" onchange="resetSearchRequest();onTemplateChange();" />
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel" id="nameLabel"><fmt:message key="assessment.name" />:</td>
									<td colspan="3" class="search"><scannell:textarea path="name" id="name" cssStyle="width:40%" class="form-control"/></td>
								</tr>

								<tr class="form-group">
									<td id="responsibleUserLabel" class="searchLabel"><fmt:message key="assessment.responsibleUser" />:</td>
									<td colspan="3" class="search">
										<c:choose>
											<c:when test="${fn:length(userList)  lt maxListSize && fn:length(userList) > 0}">
												<scannell:select id="responsibleUser" path="responsibleUser" items="${userList}" itemValue="id" itemLabel="sortableName" cssStyle="width:40%" emptyOptionLabel="${blankChoose}" renderEmptyOption="true"/>
											</c:when>
											<c:otherwise>
												<input type="hidden" id="responsibleUser" name="responsibleUser" />
											</c:otherwise>
										</c:choose>(Choose = All)
									</td>
								</tr>
								<tr class="form-group">
									<td id="approvedByUserLabel" class="searchLabel"><fmt:message key="assessment.approvedBy" />:</td>
									<td colspan="3" class="search"><select name="approvedByUser" id="approvedByUser"
											renderEmptyOption="true" items="${userList}" itemLabel="sortableName" itemValue="id" cssStyle="width:40%"
											emptyOptionLabel="${blankChoose}" /> (Choose = All)</td>
								</tr>

								<tr class="form-group">
									<td id="statusLabel" class="searchLabel"><fmt:message key="assessment.status" />:</td>
									<td colspan="3" class="search"><c:set var="emptyOption" value="${fn:length(statusList) gt 1}" /> <scannell:select
											path="status" id="status" renderEmptyOption="false" class="wide" cssStyle="width:40%" onchange="changeStatusColour(this)">
											<c:if test="${emptyOption == 'true'}">
												<option value=""><fmt:message key="choose" /></option>
											</c:if>
											<c:forEach items="${statusList}" var="status">
												<c:choose>
													<c:when test="${status.name == 'REJECTED' && multiApprovalTemplateId == null}"></c:when>
													<c:otherwise>
														<scannell:option value="${status.name}" labelkey="assessmentRiskStatus[${status.name}]" />
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</scannell:select></td>
								</tr>
								<tr class="form-group" id="onlyForAttachmentDriven" >
									<td id="statusLabel" class="searchLabel"><fmt:message key="assessment.PtWStatus" />:</td>
									<td colspan="3" class="search"> 
									<select id="nrag" name="nrag"  class="wide">
									<option value=""><fmt:message key="assessment.PtWStatus.choose" /></option>
									<c:forEach items="${nragList}" var = "nrag">
											<option value="${nrag}"><fmt:message key="assessment.PtWStatus.${nrag}" /></option>
									</c:forEach>	
									</select>
									</td>
								</tr>
								<tr class="form-group">
									<td id="reviewedLabel" class="searchLabel"><fmt:message key="reviewed" />:</td>
									<td colspan="3" class="search"><select name="reviewed" id="reviewed" renderEmptyOption="true"
											cssStyle="width:40%" emptyOptionLabel="${blankChoose}">
											<scannell:option value="true" labelkey="true" />
											<scannell:option value="false" labelkey="false" />
										</scannell:select></td>
								</tr>


								<tr class="form-group">
									<td class="searchLabel" id="reviewStartDateFromLabel"><label for="reviewStartDateFrom">
											<fmt:message key="assessment.reviewedFromStartDate" />
											:
										</label></td>
									<td class="search" style="width: 10% !important;">
										<div style="width: 70% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<!--  <input type="text" class="form-control" id="reviewStartDateFrom" name="reviewStartDateFrom" size="13" readonly="readonly"> -->
												<scannell:input class="form-control" id="reviewStartDateFrom" cssStyle="width:100%;"
													path="reviewStartDateFrom" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>


									</td>
									<td class="searchLabel2" id="reviewStartDateToLabel" style="width: 5% !important;"><label
											for="reviewStartDateTo">
											<fmt:message key="to" />
											:
										</label></td>
									<td class="search" style="width: 40% !important;">
										<div style="width: 30% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<!--  <input type="text" class="form-control" id="reviewStartDateTo" name="reviewStartDateTo" size="13" readonly="readonly">                  -->
												<scannell:input class="form-control" id="reviewStartDateTo" cssStyle="width:100%;"
													path="reviewStartDateTo" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>

								</tr>



								<tr class="form-group">
									<td id="createdByUserLabel" class="searchLabel"><fmt:message key="createdBy" />:</td>
									<td colspan="3" class="search"><select name="createdByUser" id="createdByUser"
											renderEmptyOption="true" items="${userList}" itemLabel="sortableName" itemValue="id" cssStyle="width:40%"
											emptyOptionLabel="${blankChoose}" /> (Choose = All)</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel" id="createStartDateFromLabel"><label for="fromDate">
											<fmt:message key="readingDate" />
											<fmt:message key="from" />
											:
										</label></td>
									<td class="search" style="width: 20% !important;">
										<div style="width: 70% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<scannell:input class="form-control" id="createStartDateFrom" cssStyle="width:100%;"
													path="createStartDateFrom" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>


									</td>
									<td class="searchLabel2" id="createStartDateToLabel" style="width: 5% !important;"><label for="fromDate">
											<fmt:message key="to" />
											:
										</label></td>
									<td class="search" style="width: 10% !important;">
										<div style="width: 30% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<scannell:input class="form-control" id="createStartDateTo" cssStyle="width:100%;"
													path="createStartDateTo" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>
								</tr>
								<tr class="form-group">
									<td class="searchLabel nowrap" id="targetReviewDateFromLabel"><fmt:message key="reviewTargetDate" />:</td>
									<td class="search" style="width: 20% !important;">

										<div style="width: 70% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<scannell:input class="form-control" id="targetReviewDateFrom" cssStyle="width:100%;"
													path="targetReviewDateFrom" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>
									<td class="searchLabel2" id="targetReviewDateToLabel" style="width: 5% !important;"><label for="fromDate">
											<fmt:message key="to" />
											:
										</label></td>
									<td class="search" style="width: 10% !important;">

										<div style="width: 30% !important;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
												style="width: 100% !important;">
												<scannell:input class="form-control" id="targetReviewDateTo" cssStyle="width:100%;"
													path="targetReviewDateTo" readonly="true" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>

								</tr>
							<%-- <jsp:include page="../SearchAttributes.jsp">
        							<jsp:param name="structureFormat" value="table"/>
    						</jsp:include>
								<jsp:include page="../SearchAttributes.jsp" /> --%>
								<tr class="form-group">
									<td id="sortNameLabel" class="searchLabel"><fmt:message key="sortName" />:</td>
									<td colspan="3" class="search"><scannell:select id="sortName" path="sortName" items="${sortList}"
											lookupItemLabel="true" renderEmptyOption="true" cssStyle="width:40%" emptyOptionLabel="${blankChoose}" /></td>
								</tr>
								<tr class="form-group">
									<td id="sortNameLabel" class="searchLabel"><fmt:message key="responsibleDepartment" />:</td>
									<td colspan="3" class="search">
									<select id="answers_42_" name="answers[42]" style="width: 450px">
									  <option value=""><fmt:message key="choose" /></option>
	    								<c:forEach items="${departments}" var="item">
	          								<option value="<c:out value="${item.id}" />" <c:if test="${departmentAnswer == item.id}">selected</c:if>><c:out value="${item.name}" /></option>
	        							</c:forEach>
									 </select>
											
									</td>
								</tr>
								<tr class="form-group" id="ramsStatusRow">
									<td id="scoreLabel" class="searchLabel"><fmt:message key="statusColour" />:</td>
									<td colspan="3" class="search">
									<input type="radio" name="scoreColour" value="red" onclick="changeStatus(this)"><img src="<c:url value="/images/risk/score_redlight.giff" />" />
									<input style="margin-left:15px" type="radio" name="scoreColour" value="amber" onclick="changeStatus(this)" ><img src="<c:url value="/images/risk/score_amberlight.giff" />" />
									<input style="margin-left:15px" type="radio" name="scoreColour" value="green" onclick="changeStatus(this)"><img src="<c:url value="/images/risk/score_greenlight.giff" />" />
									
									</td>
								</tr>
								<tr class="form-group" id="overdueRow">
									<td id="scoreLabel" class="searchLabel"><fmt:message key="overdue" />:</td>
									<td colspan="3" class="search">
										<scannell:checkbox path="overdue" id="overdue" value="true" onclick="setOverdueApproval(this)"/>
										<scannell:hidden path="overdueApproval" id="overdueApproval" />
									</td>
								</tr>
								<tr class="form-group">
								    <td id="sortNameLabel" class="searchLabel">Save Criteria:</td>
									<td colspan="3" class="search">
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
								    </td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center">
										<div class="spacer2 text-center">
											<button id="submitButton" type="submit" class="g-btn g-btn--primary"
												onClick="resetExcelRequest();this.form.pageNumber.value = 1;checkForEmptySavedCriteria();changeSelectNames();updateSearchCriteriaSummary();trimDescription();">
												<fmt:message key="search" />
											</button>
											<button type="button" class="g-btn g-btn--secondary" onClick="clearForm()">
												<fmt:message key="reset" />
											</button>
											<c:if test="${createExcel == true}">
												<button type="submit" class="g-btn g-btn--primary"
													onClick="excelRequest();this.form.pageNumber.value = 1;displayQueryDiv(false);">
													<fmt:message key="exportToExcel" />
												</button>
											</c:if>
											<input type="hidden" id="excel" name="excel" value="NO" />
										</div>

									</td>
								</tr>
							</tfoot>
						</table>
					</div>

				</div>
			</div>
		</div>
		<div id="searchCriteriaDiv"></div>
		<div id="resultsDiv"></div>

	</scannell:form>


</body>
</html>

