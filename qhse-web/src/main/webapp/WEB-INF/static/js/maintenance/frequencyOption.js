
function userDefinedIntervalTypeAction(){
	if (jQuery('#userDefinedIntervalType').val() == 'a'  || jQuery('#userDefinedIntervalType').val() == 'c') {
		jQuery('#userDefinedIntervalAmount').val('0');
		jQuery('#alertLeadDays').val('0');		
		jQuery('#notificationRequested').prop('checked', false);
		jQuery('#notificationRequested').prop('disabled', true);
	}
}
function fractionIntervalTypeAction() {
	if (jQuery('#fractionIntervalType').val() == 'd') {
		jQuery('#fractionIntervalAmount').val('1');
		jQuery('#notificationRequested').prop('checked', false);	
		jQuery('#notificationRequested').prop('disabled', false);	
	} else if (jQuery('#fractionIntervalType').val() == 'h'
		|| jQuery('#fractionIntervalType').val() == 's') {
		jQuery('#notificationRequested').prop('checked', false);
		jQuery('#notificationRequested').prop('disabled', true);
	} else if (jQuery('#fractionIntervalType').val() == 'w') {
		jQuery('#notificationRequested').prop('checked', false);
		jQuery('#notificationRequested').prop('disabled', false);
	} else {
		jQuery('#notificationRequested').prop('checked', true);
		jQuery('#notificationRequested').prop('disabled', false);
	}
}

function multipleIntervalAmountAction() {
	if (parseInt($('#multipleIntervalAmount').val(), 10) > 1) {
		jQuery('#notificationRequested').prop('checked', false);
		jQuery('#notificationRequested').prop('disabled', true);		
	} else {
		jQuery('#notificationRequested').prop('checked', false);	
		jQuery('#notificationRequested').prop('disabled', false);
	}
}

function multipleIntervalTypeAction() {
	if (jQuery('#multipleIntervalType').val() == 'ds') {
		jQuery('#multipleIntervalAmount').val('1');
		jQuery('#notificationRequested').prop('checked', false);
		jQuery('#notificationRequested').prop('disabled', false);		
	} else if (jQuery('#multipleIntervalType').val() == 'hs'
		|| jQuery('#multipleIntervalType').val() == 's') {
		jQuery('#notificationRequested').prop('checked', false);	
		jQuery('#notificationRequested').prop('disabled', true);
	} else if (jQuery('#multipleIntervalType').val() == 'ws') {
		jQuery('#notificationRequested').prop('checked', false);	
		jQuery('#notificationRequested').prop('disabled', false);
	} else {
		jQuery('#notificationRequested').prop('checked', true);	
		jQuery('#notificationRequested').prop('disabled', false);
	}
}

function frequencyOptionAction(){
	if (jQuery('#frequencyOption').val() == 'm') {
		jQuery('#fraction').hide();
		jQuery('#userDefined').hide();
		jQuery('#multiple').show();
		jQuery('#notificationRequested').prop('disabled', false);
	} else if (jQuery('#frequencyOption').val() == 'f') {
		jQuery('#multiple').hide();
		jQuery('#userDefined').hide();
		jQuery('#fraction').show();	
		jQuery('#notificationRequested').prop('disabled', false);
	} else if (jQuery('#frequencyOption').val() == 'u') {
		jQuery('#multiple').hide();
		jQuery('#fraction').hide();
		jQuery('#userDefined').show();
		jQuery('#notificationRequested').prop('disabled', true);
	} else {
		jQuery('#multiple').hide();
		jQuery('#fraction').hide();
		jQuery('#userDefined').hide();		
	}
}