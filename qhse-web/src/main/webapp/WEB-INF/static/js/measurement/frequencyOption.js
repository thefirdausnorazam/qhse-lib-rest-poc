
function userDefinedIntervalTypeAction(){

 if (jQuery('#userDefinedIntervalType').val() == 'a'  || jQuery('#userDefinedIntervalType').val() == 'c')
 {
     var userDefinedIntervalAmount = document.getElementById('userDefinedIntervalAmount');
 	 userDefinedIntervalAmount.value = '0';
 	
 	 var alertLeadDays = document.getElementById('alertLeadDays');
 	 alertLeadDays.value='0';
 	 var notificationRequested = document.getElementById('notificationRequested');
	 notificationRequested.checked = false; 	
 }

}
function fractionIntervalTypeAction()
{
 	if (jQuery('#fractionIntervalType').val() == 'd')
 	{
	 	var fractionIntervalAmount = document.getElementById('fractionIntervalAmount');
 		//fractionIntervalAmount.value = 1;
 		
	 	var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = false; 		
 	}
 	else if (jQuery('#fractionIntervalType').val() == 'w' || jQuery('#fractionIntervalType').val() == 'h')
 	{
 		var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = false; 		
 	}
 	else
 	{
 		var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = true;
 	}
}

function multipleIntervalTypeAction()
{
 	if (jQuery('#multipleIntervalType').val() == 'ds')
 	{
	 	var multipleIntervalAmount = document.getElementById('multipleIntervalAmount');
 		//multipleIntervalAmount.value = 1;
 		
		var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = false;
 	}
 	else if (jQuery('#multipleIntervalType').val() == 'ws' || jQuery('#multipleIntervalType').val() == 'hs')
 	{
    	var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = false;
 	}
 	else
 	{
 		var notificationRequested = document.getElementById('notificationRequested');
	 	notificationRequested.checked = true;
 	}
}



function frequencyOptionAction(){
 if (jQuery('#frequencyOption').val() == 'm')
 {
	 jQuery('#fraction').hide();
	 jQuery('#userDefined').hide();
	 jQuery('#multiple').show(); 	 
 }
 else if (jQuery('#frequencyOption').val() == 'f')
 {
	 jQuery('#multiple').hide();
	 jQuery('#userDefined').hide();
	 jQuery('#fraction').show();	
 }
 else if (jQuery('#frequencyOption').val() == 'u')
 {
	 jQuery('#multiple').hide();
	 jQuery('#fraction').hide();
	 jQuery('#userDefined').show();	 
 }  	
 else
 {
	 jQuery('#multiple').hide();
	 jQuery('#fraction').hide();
	 jQuery('#userDefined').hide();  	 
 }
}

function multipleIntervalTypeAction(){
	 if (jQuery('#multipleIntervalType').val() == 's')
	 {
		 jQuery('#shiftMessage').show(); 	 
	 }
	 else
	 {
		 jQuery('#shiftMessage').hide();	
	 }
}

function frequencyChanged() {
	var newFreqOpt = 'FrequencyOption['+jQuery('#frequencyOption').val()+']';
	var previousFreqOpt = jQuery('#previousFreqOpt').val();
	var displayWarning = false;
	if(jQuery('#frequencyOption').val() == '' || previousFreqOpt == '' || previousFreqOpt == 'FrequencyOption[u]' || newFreqOpt == 'FrequencyOption[u]') {
		return false;
	}
	if(newFreqOpt != previousFreqOpt) {
		displayWarning = true;
	}
	else if (previousFreqOpt == 'FrequencyOption[m]') {
		if(jQuery('#previousMultipleIntervalType').val() !='Frequency['+ jQuery('#multipleIntervalType').val() +']'
				|| jQuery('#previousMultipleIntervalAmount').val() != jQuery('#multipleIntervalAmount').val()) {
			displayWarning = true;
		}
    } else if (previousFreqOpt == 'FrequencyOption[f]') {
    	if(jQuery('#previousFractionIntervalType').val() != 'Frequency['+jQuery('#fractionIntervalType').val() +']'
				|| jQuery('#previousFractionIntervalAmount').val() != jQuery('#fractionIntervalAmount').val()) {
    		displayWarning = true;
		}
    }
	return displayWarning;
}

function trashReadingsList() {
	if(frequencyChanged()) {
		if(document.getElementById('queryButton') != null) {
			document.getElementById('queryButton').click();
		}
		//Wait for readings to return
		setTimeout(function() {
			jQuery('#dueOverdueReadings').dialog({
			      modal: true, title: 'Trash Readings', autoOpen: true,
			      width: 'auto', resizable: false, height: 'auto',
			      buttons: {
			          "Ok": function () {
			        	  	jQuery( this ).dialog( "close" );
			        	  	url = contextPath + '/survey/trashInvalidReadings.json?id='+jQuery('#mid').val();
			        	    jQuery.getJSON(url, function(json) {
			  	            	
			        	    });
			        	    jQuery("#updateMeasurement").submit();
		  	                return true;
			          },
			          Cancel: function () {
			        	  	jQuery( this ).dialog( "close" );
			        	  	return false;
			          }
			      },
			      close: function (event, ui) {
			      }
			});
		}, 500);
		return false;
	}
	return true;
}

