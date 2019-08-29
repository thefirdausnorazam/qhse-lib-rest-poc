

function showCriteriaSaveForm(obj) {
	  if(jQuery(obj).is(':checked')) {
		  jQuery('#saveCriteriaDiv').show();
	  } else {
		  jQuery('#submitButton').removeAttr("disabled");
		  hideSaveCriteria();
	  }
	  verifySaveCriteriaName(document.getElementById('criteriaName'));
  }
  
  function verifySaveCriteriaName(obj) {
	  if(jQuery('#saveCriteriaChk').is(':checked')) {
		  var criName = jQuery.trim(obj.value);
		  if(criName == "") {
			  jQuery('#saveCriteriaError').show();
			  jQuery('#submitButton').attr('disabled', 'disabled');
			  jQuery('#criteriaName').focus();
			  displayQueryDiv(true);
		  } else {
			  jQuery('#saveCriteriaError').hide();
			  jQuery('#submitButton').removeAttr("disabled");
			  displayQueryDiv(true);
		  }
	  } else {
		  jQuery('#saveCriteriaError').hide();
		  jQuery('#submitButton').removeAttr("disabled");
		  displayQueryDiv(true);
	  }
  }
  
  function clearNameSearchCriteria() {
	  jQuery('#criteriaName').val('');
  }
  
  function hideSaveCriteria()  {
	  jQuery('#saveCriteriaDiv').hide();
	  jQuery('#saveCriteriaError').hide();
  }
  function verifyToSaveCriteria(){
	  if (jQuery('#criteriaName').val() == '' || jQuery('#criteriaName').val() == 'Please add Save Criteria Name'){
		  jQuery('#saveCriteriaChk').prop('checked', false);
		  showCriteriaSaveForm(document.getElementById("criteriaName"));
	  }
  }
  
  function checkForEmptySavedCriteria(){
		var errtext = '';
		var blankSaveCriteriaError = document.getElementById("saveCriteriaError");
		if(jQuery("#saveCriteriaChk").is(':checked') && (jQuery('#criteriaName').val() == ''  || jQuery('#criteriaName').val() == 'Please add Save Criteria Name')){
			errtext='<span class="errorMessage">Please specify Criteria Name in order to save Criteria</span>';
			blankSaveCriteriaError.innerHTML=errtext;
			jQuery('#saveCriteriaError').show();
			jQuery('#criteriaName').focus();
			displayQueryDiv(true);
		 }else{
			 jQuery('#saveCriteriaError').val('');
			 displayQueryDiv(false);
		 }
	}
