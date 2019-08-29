
function onPageLoad() {
	onHealthToggleChange();
	onEnvToggleChange();
	onReportableToggleChange();
	onQualityToggleChange();
	//onSelectCauseType();
	onAspectTypeChange();
	onValueChange();
}

function onEnvToggleChange() {
	if(document.getElementById("envToggle") != null) {
		var disabled = !document.getElementById("envToggle").checked;
		document.getElementById("environmentalAspect").disabled = disabled;
		document.getElementById("environmentalImpact").disabled = disabled;
		var environmentalImpactMandatory = document.getElementById("environmentalImpactMandatory");
		showHint();
		if(environmentalAspectMandatory!=null) {
			disabled==true ? environmentalAspectMandatory.style.display='none' : environmentalAspectMandatory.style.display='inline';
			disabled==true ? jQuery('#environmentalAspectDiv').hide() : jQuery('#environmentalAspectDiv').show();
		}
		if(environmentalImpactMandatory!=null) {
			disabled==true ? environmentalImpactMandatory.style.display='none' : environmentalImpactMandatory.style.display='inline';
			disabled==true ? jQuery('#environmentalImpactTypeDiv').hide() : jQuery('#environmentalImpactTypeDiv').show();
		}
		// document.getElementById("duration").disabled = disabled;
		if(document.getElementById("durationUnit")) 
			document.getElementById("durationUnit").disable = disabled;
		//document.getElementById("dtoRateEmission").disabled = disabled;
		//document.getElementById("dtoMassEmission").disabled = disabled;
		//document.getElementById("dtoType").disabled = disabled;
		//document.getElementById("dtoKeyword").disabled = disabled;
		onValueChange();
	}	
}

function showHint(){
	var environmentalOrHealthMandatory1 = document.getElementById("environmentalOrHealthMandatory1");
	var environmentalOrHealthMandatory2 = document.getElementById("environmentalOrHealthMandatory2");
	var environmentalOrHealthMandatory3 = document.getElementById("environmentalOrHealthMandatory3");
	var envToggle = document.getElementById("envToggle");
	var healthToggle = document.getElementById("healthToggle");
	var qualityToggle = document.getElementById("qualityToggle");
	var envNotChecked = false;
	var hsNotChecked = false;
	var qualityNotChecked = false;
	if(envToggle == null || (envToggle != undefined && !envToggle.checked)) {
		envNotChecked = true;
	}
	if(healthToggle == null || (healthToggle != undefined && !healthToggle.checked)) {
		hsNotChecked = true;
	}
	if(qualityToggle == null || (qualityToggle != undefined && !qualityToggle.checked)) {
		qualityNotChecked = true;
	}
	/*if(qualityNotChecked != undefined && !qualityNotChecked.checked) {
		qualityNotChecked = true;
	}*/
	var showHint = envNotChecked && hsNotChecked && qualityNotChecked;
	if(environmentalOrHealthMandatory1 != null) {
		showHint ? environmentalOrHealthMandatory1.style.display='inline' : environmentalOrHealthMandatory1.style.display='none';
	}
	if(environmentalOrHealthMandatory2 != null) {
		showHint ? environmentalOrHealthMandatory2.style.display='inline' : environmentalOrHealthMandatory2.style.display='none';
	}
	if(environmentalOrHealthMandatory3 != null) {
		showHint ? environmentalOrHealthMandatory3.style.display='inline' : environmentalOrHealthMandatory3.style.display='none';
	}
	
	/*showHint ? environmentalOrHealthMandatory2.style.display='inline' : environmentalOrHealthMandatory2.style.display='none';
	showHint ? environmentalOrHealthMandatory3.style.display='inline' : environmentalOrHealthMandatory3.style.display='none';*/
}

function onValueChange(){
	if(!jQuery("#duration").disabled){
		if(jQuery("#duration").val() == 0){
			jQuery("#duration").val('');
		}
	}
	
}

function onHealthToggleChange() {
	if(document.getElementById("healthToggle") != null) {
		document.getElementById("healthHazard").disabled = !document.getElementById("healthToggle").checked;
		showHint();
		var healthHazardMandatory = document.getElementById("healthHazardMandatory");
		if(healthHazardMandatory != null) {
			document.getElementById("healthHazard").disabled ? healthHazardMandatory.style.display='none' : healthHazardMandatory.style.display='inline';
			document.getElementById("healthHazard").disabled ? jQuery('#healthHazardDiv').hide() : jQuery('#healthHazardDiv').show();
		}
	}	
}

function onQualityToggleChange() {
	if(document.getElementById("qualityImpact") != null) {
		document.getElementById("qualityImpact").disabled = !document.getElementById("qualityToggle").checked;
		showHint();
		var qualityMandatory = document.getElementById("qualityMandatory");
		if(qualityMandatory != null) {
			document.getElementById("qualityImpact").disabled ? qualityMandatory.style.display='none' : qualityMandatory.style.display='inline';
			document.getElementById("qualityImpact").disabled ?  jQuery('#qualityImpactDiv').hide() : jQuery('#qualityImpactDiv').show();
		}
	}	
}


function onReportableToggleChange() {
	var reportees = document.getElementsByName("reporteeId");
	
	for (var i=0 ; i<reportees.length ; i++) {
		
		reportees[i].disabled = !document.getElementById("reportableToggle").checked;
	}
	if(document.getElementById("reportableToggle").checked){
		jQuery( "#reporteeTable").after('<span id="reporteeTableSpan" class="requiredHinted" style="width:10%">*</span>' );
	}else{
		jQuery( "#reporteeTableSpan").remove();
	}
}

function onEhsFieldsToggleChange() {
	var disabled = !document.getElementById("ehsFieldsToggle").checked;
	document.getElementById("operatingHoursLost").disabled	= disabled;
	document.getElementById("workRelatedTable").disabled = disabled;
	document.getElementById("reportableToggle").disabled = disabled;
	document.getElementById("addButton").disabled = disabled;
	var reportees = document.getElementsByName("reporteeId");
	for (var i=0 ; i<reportees.length ; i++) {
		reportees[i].disabled = !ehsFieldsToggle.checked;
	}
}


function showAlert(){
	alert("You must deselect the associated Causes below before you can deselect this Cause Type");
}
function selectEnable(){
	 jQuery("#pt").select2({width:'100%'})
	 jQuery('textarea').autosize(); 
}

/*function clickDatePicker(tag){
	var off = jQuery(tag).offset();
	jQuery(tag).offset({ top: off.top, left: off.left });
	   
	//jQuery('span.input-group-addon.btn.btn-primary').offset({ top: off.top, left: off.left });
}
*/
function addRowRow(tableId, rowTemplateId) {	
	var table = document.getElementById(tableId);
	var row = table.tBodies[0].insertRow(-1);
	var rowTemplate = document.getElementById(rowTemplateId);	 
	for(var i = 0; i < rowTemplate.cells.length; i++) {
		var cell = row.insertCell(i);
		var innerStr = rowTemplate.cells[i].innerHTML;
		//jQuery('.datetime').datepicker({showTodayButton:true,autoclose: true,clear:true});  
		var newString = innerStr.replace(/idPlaceHolderStartDate/,"idPlaceHolderStartDate"+table.rows.length).replace(/idFuncPlaceHolderStartDate/,"idPlaceHolderStartDate"+table.rows.length);
		var newStringAgain = newString.replace(/idPlaceHolderEndDate/,"idPlaceHolderEndDate"+table.rows.length).replace(/idFuncPlaceHolderEndDate/,"idPlaceHolderEndDate"+table.rows.length);
		
		cell.innerHTML = newStringAgain;
	}
}



function addRow(tableId, rowTemplateId) {
	var table = document.getElementById(tableId);
	var row = table.tBodies[0].insertRow(-1);
	var rowTemplate = document.getElementById(rowTemplateId);
	for(var i = 0; i < rowTemplate.cells.length; i++) {
		var cell = row.insertCell(i);
		var innerStr = rowTemplate.cells[i].innerHTML;
		// jQuery('.datetime').datepicker('remove');  
		jQuery('.date').datetimepicker({showClose: true,clear:true,format:'DD-MMM-YYYY HH:mm'});		
		var newString = innerStr.replace(/idPlaceHolderStartDate/,"idPlaceHolderStartDate"+table.rows.length).replace(/idFuncPlaceHolderStartDate/,"idPlaceHolderStartDate"+table.rows.length);
		//jQuery('.datetime').datepicker('remove'); 
		jQuery('.date').datetimepicker({showClose: true,clear:true,format:'DD-MMM-YYYY HH:mm'});
		var newStringAgain = newString.replace(/idPlaceHolderEndDate/,"idPlaceHolderEndDate"+table.rows.length).replace(/idFuncPlaceHolderEndDate/,"idPlaceHolderEndDate"+table.rows.length);
		var fragmentObj = document.createRange().createContextualFragment(newStringAgain);
		if(fragmentObj){
			var htmlObj = fragmentObj.querySelector('textarea');
			if(htmlObj){
				htmlObj.value= "";
			}
			cell.appendChild(fragmentObj);
		} else {
			cell.innerHTML = newStringAgain;
		}
	}
}
/*function addRow(tableId, rowTemplateId) {
	var count = jQuery('table#workRelatedTable tr#periodRow').length;
	var clone = jQuery('table#workRelatedTable tr#periodRow').clone(true);
	
	clone.find('#dateCheck').each(function() {		
		jQuery(this).addClass('datetime');
		jQuery(this).datepicker({autoclose: true,clearBtn:true});
     });
	clone.attr('id','periodRow');
	clone.attr('style','');
	
	if(jQuery('table#workRelatedTable tr#periodRow:last').length==0){
		jQuery('table#workRelatedTable tr#workRelatedTableRow').after(clone);
	}else{
		jQuery('table#workRelatedTable tr#periodRow:last').after(clone);
	}

	
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodStartDate').attr('name','incident.investigation.recouperationPeriods['+ count +'].periodStartDate');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodStartDate').attr('id','incident.investigation.recouperationPeriods['+ count +'].periodStartDate');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodEndDate').attr('name','incident.investigation.recouperationPeriods['+ count +'].periodEndDate');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodEndDate').attr('id','incident.investigation.recouperationPeriods['+ count +'].periodEndDate');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodType').attr('name','incident.investigation.recouperationPeriods['+ count +'].periodType');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.periodType').attr('id','incident.investigation.recouperationPeriods['+ count +'].periodType');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.description').attr('name','incident.investigation.recouperationPeriods['+ count +'].description');
	jQuery('table#workRelatedTable tr#periodRow:last incident\\.investigation\\.recouperationPeriods\\['+ (count-1) +'\\]\\.description').attr('id','incident.investigation.recouperationPeriods['+ count +'].description');	

	reorganizationPeriod();
	}*/

function reorganizationPeriod(){
	var array = jQuery('table#workRelatedTable tr');
	var count=0;
	for(var i=0;i<array.length;i++){
		
		if(jQuery(array[i]).find('input').val()){
		
			jQuery(array[i]).find('input[id*="StartDate"]').attr('name','incident.investigation.recouperationPeriods['+count+'].periodStartDate');
			jQuery(array[i]).find('input[id*="StartDate"]').attr('id','incident.investigation.recouperationPeriods['+count+'].periodStartDate');
			
			jQuery(array[i]).find('input[id*="EndDate"]').attr('name','incident.investigation.recouperationPeriods['+count+'].periodEndDate');
			jQuery(array[i]).find('input[id*="EndDate"]').attr('id','incident.investigation.recouperationPeriods['+count+'periodEndDate');
			
			jQuery(array[i]).find('select').attr('id','incident.investigation.recouperationPeriods['+count+'].periodType');
			jQuery(array[i]).find('select').attr('name','incident.investigation.recouperationPeriods['+count+'].periodType');

			jQuery(array[i]).find('textarea').attr('id','incident.investigation.recouperationPeriods['+count+'].description');
			jQuery(array[i]).find('textarea').attr('name','incident.investigation.recouperationPeriods['+count+'].description');
			
			count=count+1;
			
		}


	}
}

function deleteRow(targetRow) {
	if (targetRow != null) {
		var table = getParent("table", targetRow);
		table.deleteRow(targetRow.rowIndex);
	}
	reorganizationPeriod();
}

function onPageSubmit(aForm) {
	reorganizationPeriod();
	if(jQuery("#duration").val() == ''){
		jQuery("#duration").val('0');
	}
	var count = jQuery('table#workRelatedTable tr').length;
	jQuery('#recouperationSize').val(count-2);
		//addIndicesToCollectionElements(aForm, "incident.investigation.recouperationPeriods", "recouperationSize");
	
}

function addIndicesToCollectionElements(aForm, prefix, sizeElementId) {
	var first = null;
	var index = -1;
	var sizeElement = document.getElementById(sizeElementId);
    alert(sizeElement);
	for (var i = 0; i < aForm.elements.length; i++) {
		var el = aForm.elements[i];
		
		if (el.name.indexOf(prefix) == 0 && el.name != sizeElement.name) {
			if (first == null) {
				first = el.name;
				index++;
			} else if (first == el.name) {
				index++;
			}
			el.name = prefix + "[" + index + "]" + el.name.substr(prefix.length);
			alert('el: '+el.name );
			alert('el va: '+el.value );
		}
	}
	if (sizeElement == null) {
		return false;
	}
	sizeElement.value = index + 1;
}

function onSelectCauseType() {
	var causeTypes = document.getElementsByName("causeTypes");
	var equipSetOnce			= false;
	var materialsSetOnce	= false;
	var methodsSetOnce		= false;
	var peopleSetOnce			= false;
	var workplaceSetOnce	= false;

	for (var i=0 ; i<causeTypes.length ; i++) {
		if (causeTypes[i].checked && causeTypes[i].id == "equipmentCheckboxList" && !equipSetOnce) {
			$("Equipment").checked = true;
			toggleBlock("EquipmentCauseTypes");
			equipSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "materialsCheckboxList" && !materialsSetOnce) {
			$("Materials").checked = true;
			toggleBlock("MaterialsCauseTypes");
			materialsSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "methodsCheckboxList" && !methodsSetOnce) {
			$("Methods").checked = true;
			toggleBlock("MethodsCauseTypes");
			methodsSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "peopleCheckboxList" && !peopleSetOnce) {
			$("People").checked = true;
			toggleBlock("PeopleCauseTypes");
			peopleSetOnce = true;
			continue;
		}
		if (causeTypes[i].checked && causeTypes[i].id == "workplaceCheckboxList" && !workplaceSetOnce) {
			$("Workplace").checked = true;
			toggleBlock("WorkplaceCauseTypes");
			workplaceSetOnce = true;
			continue;
		}
	}
}

function onAspectTypeChange() {
	/*var aspectType = document.getElementById("environmentalAspect");
	for (var i = 0; i < envAspects.length; i++) {
		var name = envAspects[i][0];
		var id = envAspects[i][1];
		if (name == "LVI Trip") {
			break;
		}
	}

	if ($("enable").value == "true") {
		if(aspectType.value == id) {
			showBlock("dtoLableRow");
			showBlock("dtoRow");
			showBlock("dtoTitleRow");
		} else {
			hideBlock("dtoLableRow");
			hideBlock("dtoRow");
			hideBlock("dtoTitleRow");
		}
	}*/
}
