/**
 * 
 */
var openProfileManager, selectProfile;
jQuery(document).ready(function() {
			
		selectProfile = function() {				 
		window.location = '<c:url value="/law/lawDashboard.htm"/>'+'?selectProfile='+ document.getElementById('profileSelect').value;
		};
				
		jQuery('#lawTabs').select2({
			width: '100%'
		});
		jQuery('#profileSelect').select2({
			width: '100%'
		});
		jQuery('#lawTabs').on('change', function() {
		 var lwval, url;
		 lwval = jQuery('#lawTabs').val();
		 $.cookie('lawTabs', lwval, {
		 expires: 7,
		 path: '/'
		});
		url = '<c:url value="/law/lawDashboard.htm"/>';
		window.location.href = url;
		});
				  
				 
			
});