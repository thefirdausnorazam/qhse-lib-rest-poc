<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html">
<html>
<head>
<title><spring:message text="${definition.name}" code="report.${definition.name}" /></title>
<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/interface/AuditDWRService.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/interface/RiskDWRService.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/interface/IncidentDWRService.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
<script language="javascript" type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#format").select2();
		loadSavedReportOptions();
		delayToAnableRunButton();
		
		if('${definition.name}' == 'incidentInvestigationReport'){
			if(jQuery("#completed_weeks") || jQuery("#action_count")){
				jQuery('#completed_weeks').bind('keyup paste', function(){
	                this.value = this.value.replace(/[^0-99]/g, '');
	            });
			}
			if(jQuery("#action_count")){
				jQuery('#action_count').bind('keyup paste', function(){
	                this.value = this.value.replace(/[^0-99]/g, '');
	            });
			}
		}
	});
var cleanCheckboxes = false;
var validAuditProgramme = '<fmt:message key="report.auditProgrammeMsg" />';
var invalidFeilds= '<fmt:message key="errors.global" />';
var required = '<fmt:message key="required.category" />';

function loadSavedReportOptions(){
	if(cleanCheckboxes == false){
		jQuery('input:checkbox').each( function () {
		       jQuery(this).attr('checked', false);
		});
	}
	cleanCheckboxes = true;
	<c:forEach items="${savedOptions}" var="item">
		if('${item.inputType}' == 'select') {
			jQuery('#${item.name}').select2().select2('val', jQuery('#${item.name}').val());
		} else if('${item.inputType}' == 'multiSelect') {
			jQuery('[name="${item.name}"]').each( function () {
					if(this.value == '${item.value}') {
			    	   this.checked = true;
			       }
			   });
		}else if('${item.inputType}' == 'checkbox') {
			jQuery('#${item.name}').attr('checked', true);
		} else {
			jQuery('#${item.name}').val('${item.value}');
		}		
	</c:forEach>
}
	var orginalAction = '<c:url value="reportRun."/>';

	function populateCallback(element, data, firstOption) {
		DWRUtil.removeAllOptions(element.id);
		if (firstOption) {
			DWRUtil.addOptions(element.id, firstOption);
		}
		DWRUtil.addOptions(element.id, data);
		loadSavedReportOptions();
	}

	function formSubmit() {
		if(checkAuditProgrammeId()) {
			if(('${definition.name}' == 'auditExpressByQuestion') || ('${definition.name}' == 'auditCountByDepartment')){
				jQuery('#departmentName').val(jQuery('#departmentId :selected').text());
				jQuery('#auditProgrammeName').val(jQuery('#auditProgrammeId :selected').text());
				jQuery('#questionName').val(jQuery('#questionId :selected').text());
			} else if('${definition.name}' == 'riskReductionCountByQuestion'){
				jQuery('#templateName').val(jQuery('#templateId :selected').text());
			}
			var form = document.getElementById('reportForm');
			form.setAttribute('action', orginalAction
					+ document.getElementById('format').value);
			form.setAttribute('method', 'GET');
			form.submit();
		}
	}

	function checkYear() {
		var noDateSelected = false;
		var elementId = '';
		jQuery('.calendarDate').each(function (){
			if(this.value == ''){
				noDateSelected = true;
				elementId = this.id;
			}
		});
		if(noDateSelected == false) {
			if (jQuery('#year').length) {
				var yea = document.getElementById('year').value;
				if (yea == null || yea == '' || yea == 'undefined') {
					document.getElementById("error").innerHTML = "* "+required;
					document.getElementById("error1").innerHTML = invalidFeilds;
				} else {
					formSubmit();
				}
			} else {
				formSubmit();
			}
		} else {
			jQuery('#'+elementId).css({"border-color": "red", "border-width":"1px", "border-style":"solid"});
		}
	}
	
	function checkAuditProgrammeId() {
		var elementId = '';
		if (jQuery('#auditProgrammeId').length) {
			var auditProgrammeId = document.getElementById('auditProgrammeId').value;
			if (auditProgrammeId == 0) {
				document.getElementById("error1").innerHTML = validAuditProgramme;
				return false;
			}
		}
		return true;
	}
	
	function delayToAnableRunButton() {
		if('riskByQuestion'=='${definition.viewName}' || '${definition.viewName}' == 'riskReductionCountByQuestion' || '${definition.viewName}' == 'riskReviewByQuestion'){
			if(jQuery('#templateId').val() == ''){
				setTimeout(delayToAnableRunButton, 1000);
			} else {
				if('riskByQuestion'=='${definition.viewName}'){
					if(jQuery('#questionId').val() == ''){
						setTimeout(delayToAnableRunButton, 1000);
					} else {
						jQuery('#runReportButton').prop( "disabled", false );
					}
				} else {
					jQuery('#runReportButton').prop( "disabled", false );
				}
			}
		} else {
			jQuery('#runReportButton').prop( "disabled", false );
		}
	}
</script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>
</head>
<body>
<!-- 	<div class="header nowrap"> -->
<!-- 		<h2> -->
<%-- 			<fmt:message key="reportDefinitions" /> --%>
<!-- 		</h2> -->
<!-- 	</div> -->
	<div class="content">

<!-- 		<div class="header nowrap"> -->
<!-- 			<h3> -->
<%-- 				<spring:message text="${definition.name}" code="report.${definition.name}" /> --%>
<!-- 			</h3> -->
<!-- 		</div> -->
		<form id="reportForm">
			<input type="hidden" name="name" value="<c:out value="${definition.name}"/>" />
			<input type="hidden" name="moduleName" value="<c:out value="${moduleName}"/>" />
			<span style="color: red; font-weight: bold;" id="error1"> </span>

			<div class="content">
				<div class="table-responsive">
					<div class="panel">
						<table class="table table-bordered table-responsive">

							
							<tbody>							
								<c:forEach items="${definition.parameters}" var="item">
									<c:if test="${item.display}">
										<tr>
											<td class="searchLabel nowrap"><spring:message code="${item.displayName}" text="${item.displayName}" />:</td>
											<td class="search"><c:choose>

													<c:when test="${item.inputType == 'select'}">
														 <select id="<c:out value="${item.name}" />" name="<c:out value="${item.name}" />" class="extraWide" style="min-width: 20%;width:50%" placeholder="None">
															<c:forEach items="${item.selectList}" var="selectListItem">
																<option value="<c:out value="${selectListItem.name}" />"><fmt:message key="${selectListItem}" /></option>
															</c:forEach>
														</select>
													</c:when>


													<c:when test="${item.inputType == 'multiSelect'}">
														<div id="${item.name}" class="scrolllist" style="width: 480px; height: 70px;">
															<c:forEach items="${item.selectList}" var="selectListItem">
																<input <c:if test="${selectListItem.name == 'REJECTED'}">style='display:none'</c:if> type="checkbox" name="<c:out value="${item.name}" />"
																	value="<c:out value="${selectListItem.name}" />"
																	<c:if test="${selectListItem == item.value}">checked="true"</c:if> />
																<c:if test="${selectListItem.name != 'REJECTED'}"><c:out value="${selectListItem.description}" /></c:if>
																<br />
															</c:forEach>
														</div>
													</c:when>


													<c:when test="${item.inputType == 'checkbox'}">
														<input type="checkbox" id="<c:out value="${item.name}" />" name="<c:out value="${item.name}" />"
															value="true" />
													</c:when>

													<c:when test="${item.inputType == 'calendar'}">
													
														<div style="width: 250px;">
															<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
																style="width: 200px;">
																<input class="form-control calendarDate" id="${item.name}" name="${item.name}" size="6" type="text"
																	value="<fmt:parseDate value="${item.value}" var="date" pattern="yyyy-MM-dd"/><fmt:formatDate value="${date}" pattern="dd-MMMM-yyyy" />" readonly>
																<span class="input-group-addon btn btn-primary">
																	<span class="glyphicon glyphicon-th"></span>
																</span>
															</div>
														</div>
													</c:when>
													<c:otherwise>
														<input type="text" id="<c:out value="${item.name}" />" name="<c:out value="${item.name}" />"
															value="<c:out value="${item.value}" />" <c:if test="${item.readOnly}">readonly="readonly"</c:if> />
														<span style="color: red; font-weight: bold;" id="error"> </span>
														<c:if test="${item.inputType == 'calendar'}">
															<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
																onclick="return showCalendarWithFormat(event, '<c:out value="${item.name}" />','%Y-%m-%d', true);">
														</c:if>
													</c:otherwise>

												</c:choose></td>
										</tr>
									</c:if>
									<c:if test="${item.hidden}">
										<input type="hidden" id="<c:out value="${item.name}" />" name="<c:out value="${item.name}" />"
											value="<c:out value="${item.value}" />" />
									</c:if>
									<script language="javascript" type="text/javascript"><c:out value="${item.javascript}" escapeXml="false" /></script>
								</c:forEach>

								<tr>
									<td class="searchLabel"><fmt:message key="format" />:</td>
									<td class="search"><select id="format" name="format" style="width:200px;">
											<c:forEach items="${definition.formats}" var="item">
												<option value="<c:out value="${item}" />"><spring:message code="reportFormat.${item}"
														text="${item}" /></option>
											</c:forEach>
										</select></td>
								</tr>
								
							</tbody>

							<tfoot>
								<tr>
									<td colspan="2" align="center"><input type="button" id="runReportButton" class="g-btn g-btn--primary"
											value="<fmt:message key="runReport" />" onclick='checkYear();' disabled="disabled"/></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		${definition.clientScript}
	</script>

</body>
</html>
