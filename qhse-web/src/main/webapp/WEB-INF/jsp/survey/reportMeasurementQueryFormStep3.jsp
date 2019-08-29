<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>
<style type="text/css">

.select2-search-choice-close {
        right: 30px !important;
}

.masterClass {
background-color: #D3D3D3 !important;
}

#validationErrors {
	text-align: center;
	padding: 10px;
}
</style>
<script type="text/javascript">

	var masterMeasurementNotSelectedError = '<fmt:message key="masterMeasurementNotSelectedError" />';
	var masterMeasurementParamNotSelectedError = '<fmt:message key="masterMeasurementParamNotSelectedError" />';
	var masterMeasurementOptionNotSelectedError = '<fmt:message key="masterMeasurementOptionNotSelectedError" />';
	var requiredError = '<fmt:message key="required"/>';

	jQuery(document).ready(function() {
		initSortTables();
		jQuery('select').not('#siteLocation').select2({width:'50%'});
		jQuery('#logic').select2({width:'30%'});
		
		jQuery('#masterMeasurement').select2({
			placeholder: "Select Measurement",
			allowClear: true,
			width:'30%'
			});
		jQuery('#masterLogic').select2({
			placeholder: "Select Sum/Avg/Ytd",
			allowClear: true,
			width:'15%'
		});
		jQuery('#masterCalculation').select2({
			placeholder: "Select Calculation",
			allowClear: true,
			width:'15%'
		});
		
	  	jQuery('#masterTable td:nth-child(1),th:nth-child(1)').hide();
    	jQuery('#masterTable td:nth-child(5),th:nth-child(5)').show();
    	jQuery('#masterTable td:nth-child(6),th:nth-child(6)').hide();
    	jQuery('#masterTable input[type="submit"]').prop('disabled', false);
    	jQuery('.checkbox').each(function(){this.checked = false;});
    	//for some strange reason this th was getting disappear, had to show them forcefuly
    	jQuery('#infoTable th').each(function () {
                    jQuery(this).show();
                });
    	
    	disableRowForNonAccumulativeRate();
    	
    	if(${fn:length(command.selectedMeasurementWithLogicalVariables)} == 1){
    		disableNextButton();
    	}
	});
	
	function disableNextButton(){
        jQuery('#nextButton').attr("disabled", true);
    }
		
	function showNextCalculation(){
    	jQuery('#masterTable td:nth-child(1),th:nth-child(1)').show();
    	jQuery('#masterTable td:nth-child(6),th:nth-child(6)').show();
    	jQuery('#masterTable td:nth-child(5),th:nth-child(5)').hide();
    //	jQuery('#masterTable td:nth-child(7),th:nth-child(7)').hide();
    	jQuery('#masterMeasurementDiv').show();
    	jQuery('#divCalulation').show();
    	jQuery('#backButton').show();
    	jQuery('#nextButton').hide();
    	
   		disableMasterRow();
	}
	function hideCalculation(){
	  	jQuery('#masterTable td:nth-child(1),th:nth-child(1)').hide();
    	jQuery('#masterTable td:nth-child(5),th:nth-child(5)').show();
    	jQuery('#masterTable td:nth-child(6),th:nth-child(6)').hide();
    //	jQuery('#masterTable td:nth-child(7),th:nth-child(7)').show();
    	jQuery('.checkbox').each(function(){this.checked = false;});
    	jQuery('#masterMeasurementDiv').hide();
    	jQuery('#divCalulation').hide();
    	jQuery('#backButton').hide();
    	jQuery('#nextButton').show();
    	//for some strange reason this th was getting disappear, had to show them forcefuly
    	jQuery('#infoTable th').each(function () {
                   jQuery(this).show();
                });

    	clearValidationErrors();
		enableAllAccumulativeRateRows();
	}

	function disableRowForNonAccumulativeRate(){
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="reportVariables">
		if(${!reportVariables.measurement.rate and !reportVariables.measurement.accumulation}){
			jQuery("#"+${reportVariables.id}).addClass( "masterClass" );
			jQuery("#logicalSum"+${reportVariables.id}).prop('disabled', true).select2();
			jQuery("#checkbox"+${reportVariables.id}).attr("disabled", true);
			jQuery("#emissionLimitValue"+${reportVariables.id}).attr("disabled", true);
			jQuery("#"+${reportVariables.id}).css('background-color', '#D3D3D3');
			jQuery("#option"+${reportVariables.id}).prop('disabled',true);
			jQuery("#customSymbol"+${reportVariables.id}).attr("disabled", true);
			jQuery("#customFraction"+${reportVariables.id}).attr("disabled", true);
		}
		</c:forEach>
	}
	
	function disableRow(rowId){
		var customSymbol = jQuery("#customSymbol"+rowId).val().trim();
		var customFraction = jQuery("#customFraction"+rowId).val().trim(); 
		var emissionLimit = jQuery("#emissionLimitValue"+rowId).val().trim();
		var allValue = customSymbol+customFraction+emissionLimit;
		if(allValue){
		jQuery("#logicalSum"+rowId).prop('disabled', true).select2();
		jQuery("#checkbox"+rowId).attr("disabled", true);
	//	jQuery("#emissionLimitValue"+rowId).attr("disabled", true);
		jQuery("#"+rowId).css('background-color', '#D3D3D3');
		jQuery("#option"+rowId).prop('disabled',true);
		jQuery("#testButton"+rowId).show();
		jQuery("#exampleButton"+rowId).show();
		}else{
			jQuery("#logicalSum"+rowId).prop('disabled', false).select2();
			jQuery("#checkbox"+rowId).attr("disabled", false);
		//	jQuery("#emissionLimitValue"+rowId).attr("disabled", false);
			jQuery("#"+rowId).css('background-color', '');
			jQuery("#option"+rowId).prop('disabled',false);
			jQuery("#testButton"+rowId).hide();
			jQuery("#exampleButton"+rowId).hide();
		}
	}
	
	function disableMasterRow() {
		enableAllAccumulativeRateRows();

    	var masterMeasurementSelected = jQuery("#masterMeasurement").length>0;
    	if(masterMeasurementSelected) {
    		var rowId = jQuery("#masterMeasurement")[0].value;
    		jQuery("#logicalSum"+rowId).prop("disabled", true).select2();
    		jQuery("#emissionLimitValue"+rowId).attr("disabled", true);
    		jQuery("#checkbox"+rowId).attr("disabled", true);
    		jQuery("#checkbox"+rowId).prop('checked', false);
    		jQuery("#"+rowId).addClass( "masterClass" );
    	}
	}

	
	function enableAllAccumulativeRateRows() {
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable">
		if(jQuery("#"+${variable.id}).hasClass( "masterClass" )){
			jQuery("#"+${variable.id}).removeClass( "masterClass" );
			jQuery("#logicalSum"+${variable.id}).prop('disabled', false).select2();
			jQuery("#emissionLimitValue"+${variable.id}).attr("disabled", false);
			jQuery("#checkbox"+${variable.id}).attr("disabled", false);
		}
		</c:forEach>
		disableRowForNonAccumulativeRate();		
	}
	
	function customUnitTest(id) {
		if(id){
		var expresion = jQuery('#customFraction'+id).val();
		openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=" + encodeURIComponent(expresion)+"&symbol="+encodeURIComponent(jQuery("#customSymbol"+id).val()), 500, 300, true, "Test", true);
		}else{
			var expresion = jQuery('#masterCustomExpression').val();
			openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=" + encodeURIComponent(expresion)+"&symbol="+encodeURIComponent(jQuery("#masterCustomSymbol").val()), 500, 300, true, "Test", true);
		}
	}

	function customUnitTestExample(id) {
		if(id){
		openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=x*8&sample=true"+"&symbol="+encodeURIComponent(document.getElementById("customSymbol"+id).value), 500, 300, true, "Sample", true);
		}else{
		openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=x*8&sample=true"+"&symbol="+encodeURIComponent(document.getElementById("masterCustomSymbol").value), 500, 300, true, "Sample", true);
		}
	}
	
	function validateForm() {
		var errors = [];
		var masterMeasurementShown = jQuery("#masterMeasurementDiv:visible").length==1;
		clearValidationErrors();
		
		if(masterMeasurementShown) {
			var $masterMeasurement = jQuery("#masterMeasurement")[0];
			var $masterLogic = jQuery("#masterLogic")[0];
			var $masterCalculation = jQuery("#masterCalculation")[0];

			if($masterMeasurement.value == "" || 
			   $masterLogic.value == "" ||
			   $masterCalculation.value == "") {
				
				errors.push(masterMeasurementNotSelectedError);
			}

			var tickedRows = getMasterMeasurementTickedRowIds();

			if (tickedRows.length==0) {
				errors.push(masterMeasurementParamNotSelectedError);
			}

			var parameterCalculationSelected=true;
			tickedRows.forEach(function(id) {
				var $logicalSumSelect = jQuery("#logicalSum"+id)[0];
				if($logicalSumSelect.value.toLowerCase() == "choose") {
					var $required = jQuery("<span>", {"class": "error"});
					$required.html("* " + requiredError);
					$required.appendTo($logicalSumSelect.parentNode);
					parameterCalculationSelected=false;
				}
			});
			
			if(!parameterCalculationSelected) {
				errors.push(masterMeasurementOptionNotSelectedError);
			}
		}
		
		if (errors.length > 0) {
			displayValidationErrors(errors);
		}
		
		
		return errors.length == 0;
	}
	
	function displayValidationErrors(errors) {
		var $validationErrorElement = jQuery("#validationErrors");
		
		errors.forEach(function(error) {
			var $newErrorElement = jQuery("<span>", {"class": "error"});
			$newErrorElement.html("* "+error);
			$newErrorElement.appendTo($validationErrorElement);
			jQuery("<br/>").appendTo($validationErrorElement);
		})
		
		$validationErrorElement.show();
	}
	
	function clearValidationErrors() {
		jQuery("#validationErrors").empty();
		jQuery(".error").remove();
	}
	
	function getMasterMeasurementTickedRowIds() {
		var tickedRows = [];
		
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable">
		var checkbox = jQuery("#checkbox"+${variable.id})[0];
		if(checkbox.checked) {
			tickedRows.push(${variable.id});
		}		
		</c:forEach>
		
		return tickedRows;
	}
</script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/survey.css'/>";
</style>
</head>
<body>
	<div class="content">
<scannell:form id="form" onsubmit="return validateForm();">
<input type="hidden" id="selectedMeasurements" name="selectedMeasurements" value="">
<input type="hidden" id="mes" name="mes" value="">
<div class="table-responsive">
			<div id="queryTable">
					<div class="header">
						<h3>
							<fmt:message key="createReportStep3" />
						</h3>
					</div>

					<div class="table-responsive">
						<div class="panel">
				<table id="infoTable" class="table table-bordered table-responsive" style="width: 100%; border-top: 1px solid #DADADA;"> <tr>
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</th>
					    <td><c:out value="${command.id}" /></td>
					  </tr>
					    <tr>
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="title" />:</th>
					    <td><c:out value="${command.title}" /></td>
					  </tr>
					   <tr>
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="addLicenseReference"/>:</th>
					    <td>
					    	 <c:out value="${command.licenseReference}" />
					     </td>
					  </tr>
					   <tr>
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="readingPoint" />:</th>
					    <td>
					    	 <c:out value="${command.selectedMeasurementWithLogicalVariables[0].measurement.readingPoint.description}" />
					     </td>
					  </tr>
					     <tr >
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="reportingType" />:</th>
					    <td >
					 		<c:out value="${command.period}" />
					    </td>
					  </tr>
					     <tr>
					    <th class="scannellGeneralLabel nowrap "><fmt:message key="createdBy"/>:</th>
					    <td><c:out value="${command.createdByUser.displayName}" /></td>
					  </tr>
					       <tr>
					    <th class="scannellGeneralLabel nowrap"><fmt:message key="createdTs" /></th>
					    <td><c:out value="${command.createdTs}" /></td>
					  </tr>
					</table>
							</div>	
						<div class="form-group" id="masterMeasurementDiv" style="display: none;">
							<label
								class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="masterMeasurement" />
							</label>
							<div >
								<select id="masterMeasurement" name="masterMeasurement"	class="wide" onChange="disableMasterRow();">
								<option></option>
										<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variables">
											<option id="option${variables.id }" value="${variables.id }"><c:out value="${variables.measurement.id} : ${variables.measurement.quantity.longName}"></c:out></option>
										</c:forEach>
								</select>
								<select id="masterLogic" name="masterLogic">
									<option></option>
									<option value="SUM"><fmt:message	key="sum" /></option>
									<option value="AVG"><fmt:message	key="avg" /></option>
									<option value="YTD"><fmt:message	key="ytd" /></option>
								</select>
								<select id="masterCalculation"  name="masterCalculation">
									<option></option>
									<option value="ADD"><fmt:message	key="add+" /></option>
									<option value="MULTIPLY"><fmt:message	key="multiply" /></option>
									<option value="DIVIDE"><fmt:message	key="divide" /></option>
								</select>
								
							</div>
						</div>
						<div class="table-responsive">
							<div id="validationErrors"></div>
							<table class="table table-bordered table-responsive dataTable"style="width: 100%; border-top: 1px solid #DADADA;" id="masterTable">
								<thead>

									<tr>
										<th></th>
										<th><fmt:message key="id" /></th>
										<th><fmt:message key="quantity" /></th>
										<th><fmt:message key="currentUnit" /></th>
										<th><fmt:message key="applyCustomUnit" /></th>
										<th><fmt:message key="sumAvgYtd" /></th>
										<th><fmt:message key="emissionLimit" /></th>
									</tr>

								</thead>
								<tbody>
									<c:forEach
										items="${command.selectedMeasurementWithLogicalVariables}"	var="reportVariables" varStatus="s">
										<c:choose>
											<c:when test="${s.index mod 2 == 0}">
												<c:set var="style" value="even" />
											</c:when>
											<c:otherwise>
												<c:set var="style" value="odd" />
											</c:otherwise>
										</c:choose>
										<tr class="<c:out value="${style}" />" id="${reportVariables.id}">
											<td>
											<input type="checkbox" value="${reportVariables.id}" id="checkbox${reportVariables.id}" name="checkbox${reportVariables.id}" class="checkbox">
											<input type="hidden" id="hidden${reportVariables.id}" name="hidden${reportVariables.id}" value="${reportVariables.measurement.id}:${reportVariables.measurement.quantity.longName}">
											</td>
											<td><a
												href="<c:url value="measurementView.htm"><c:param name="id" value="${reportVariables.measurement.id}"/></c:url>"><c:out
														value="${reportVariables.measurement.id}" /></a></td>
											<td>
												<c:out	value="${reportVariables.measurement.quantity.longName}" />
											</td>
											<td>
											<c:out	value="${reportVariables.measurement.defaultUnit.symbol}" />
											</td>
											<td>
											<fmt:message key="customSymbol" />
											<input type="text" id="customSymbol${reportVariables.id}" name="customSymbol${reportVariables.id}" value=""  onChange="disableRow('${reportVariables.id}');">
											<fmt:message key="customExpression" />
											<input type="text" id="customFraction${reportVariables.id}" name="customFraction${reportVariables.id}" value=""  onChange="disableRow('${reportVariables.id}');">
											<button type="button" id="testButton${reportVariables.id}" onclick="customUnitTest(${reportVariables.id})" style="display:none">
												<fmt:message key="test" />
											</button>
											<button type="button" id="exampleButton${reportVariables.id}" onclick="customUnitTestExample('${reportVariables.id}')" style="display:none">
												<fmt:message key="waste.wasteTypeEdit.sample" />
											</button>
											</td>
											<td>
											<select id="logicalSum${reportVariables.id}" name="logicalSum${reportVariables.id}">
											<option value="CHOOSE"><fmt:message	key="choose" /></option>
											<option value="SUM"><fmt:message	key="sum" /></option>
											<option value="AVG"><fmt:message	key="avg" /></option>
											<option value="YTD"><fmt:message	key="ytd" /></option>
											</select>
											</td>
											<td>
											<input type="text" id="emissionLimitValue${reportVariables.id}" name="emissionLimitValue${reportVariables.id}" value="" size="5">
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="table-responsive" id="divCalulation" style="display: none;">

					
									<div class="form-group">
										<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
												<fmt:message key="customSymbol" />
											</label>
										<div class="col-sm-6">
											<input type="text" id="masterCustomSymbol" name="masterCustomSymbol" value=""  >
											<label class="control-label scannellGeneralLabel rightAlign">
											<fmt:message key="customExpression" />
											</label>
											<input type="text" id="masterCustomExpression" name="masterCustomExpression" value=""  >
											<button type="button" id="testButton${reportVariables.id}" onclick="customUnitTest()">
												<fmt:message key="test" />
											</button>
											<button type="button" id="exampleButton${reportVariables.id}" onclick="customUnitTestExample()">
												<fmt:message key="waste.wasteTypeEdit.sample" />
											</button>
										</div>
									</div>
						</div>
					</div>
				</div>

				<div style="clear: both;"></div>
				<div class="spacer2 text-center">
					<input type="button" id="nextButton" value="<fmt:message key="next" />" class="g-btn g-btn--primary" onclick="showNextCalculation();">
					<input type="button" id="backButton" value="<fmt:message key="back" />" class="g-btn g-btn--primary" onclick="hideCalculation();" style="display: none;">
					<input type="submit" value="<fmt:message key="reportDefinitions" />" class="g-btn g-btn--primary">
				</div></scannell:form>

	</div>
</body>
</html>
