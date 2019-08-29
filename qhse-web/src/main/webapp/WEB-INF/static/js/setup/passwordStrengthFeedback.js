jQuery(document).ready(function() {
	jQuery('#password').bind('input', refreshPasswordComplexityIcons);
});

function refreshPasswordComplexityIcons() {
	var password = $('#password').val();
	
	if (password.length == 0) {
		setComplexityToIcon('complexity-character-count', 'info');
		setComplexityToIcon('enforce-password-complexity-alphanumeric', 'info');
		setComplexityToIcon('enforce-password-complexity-special', 'info');
	} else {
		setComplexityToIcon('complexity-character-count', checkPasswordLength(password));
		setComplexityToIcon('enforce-password-complexity-alphanumeric', checkPasswordAlphaNumComplexity(password));
		setComplexityToIcon('enforce-password-complexity-special', checkPasswordSpecialChars(password));
	}
	
	if (checkPasswordLength(password) == 'requirement-met') {
		jQuery.ajax({
			type: "POST",
			url: getContextUrl() + 'setup/checkCommonPassword.html',
			data: {'password': password},
			success: onCheckCommonPasswordResult
		});

		jQuery.ajax({
			type: "POST",
			url: getContextUrl() + 'setup/checkIfPasswordReused.html',
			data: {'password': password},
			success: onCheckPasswordReused
		});
	} else {
		setComplexityToIcon('complexity-avoid-common-passwords', 'info');
		setComplexityToIcon('enforce-password-history', 'info');
	}
}

function onCheckCommonPasswordResult(result) {
	var result = JSON.parse(result);
	
	setComplexityToIcon('complexity-avoid-common-passwords', 
						result.passwordContainsUsername || result.passwordIsCommon ? 'requirement-not-met' : 'requirement-met');

}

function onCheckPasswordReused(result) {
	var result = JSON.parse(result);
	
	setComplexityToIcon('enforce-password-history', result.isPasswordReused ? 'requirement-not-met' : 'requirement-met');
}

function setComplexityToIcon(elementId, icon) {
	var iconBackgroundElement = jQuery('#' + elementId);
	var iconElement = jQuery('#' + elementId + ' i');
	
	iconBackgroundElement.removeClass('alert-info');
	iconBackgroundElement.removeClass('alert-success');
	iconBackgroundElement.removeClass('alert-danger');
	iconElement.removeClass('fa-info-circle');
	iconElement.removeClass('fa-check');
	iconElement.removeClass('fa-times-circle');
	
	switch(icon) {
		case 'info': 
			iconBackgroundElement.addClass('alert-info');
			iconElement.addClass('fa-info-circle');
			break;				
		
		case 'requirement-met': 
			iconBackgroundElement.addClass('alert-success');
			iconElement.addClass('fa-check');
			break;
			
		case 'requirement-not-met': 
			iconBackgroundElement.addClass('alert-danger');
			iconElement.addClass('fa-times-circle');
			break;
	}
}

// Password Complexity Checks
function checkPasswordLength(password) {
	if (password.length >= 8 && password.length <= 100) { 
		return 'requirement-met';
	}
	
	return 'requirement-not-met';
}

function checkPasswordAlphaNumComplexity(password) {
	var lowerCase = RegExp('[a-z]');
	var upperCase = RegExp('[A-Z]');
	var numeric = RegExp('[0-9]');
	
	if (!lowerCase.test(password)) {
		return 'requirement-not-met';
	}
	
	if (!upperCase.test(password)) {
		return 'requirement-not-met';
	}
	
	if (!numeric.test(password)) {
		return 'requirement-not-met';
	}
	
	return 'requirement-met';
}

function checkPasswordSpecialChars(password) {
	var specialChars = RegExp('[!"#$%&\'()*+,-./:;<=>?@[\\\]^_`{|}~ ]');

	if (!specialChars.test(password)) {
		return 'requirement-not-met';
	}
	
	return 'requirement-met';
}