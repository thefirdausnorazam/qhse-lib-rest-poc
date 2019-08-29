var lElement = 'location';
var wElement = 'workarea';
var dElement = 'department';
var uElement = 'user';
var userDefaultSite = "#userDefaultSite";

function handleSetDefaultSite(str) 
{
	$(userDefaultSite).val(str);
}

function updatePageOptions(usersToDepartment, usersToDepartmentName)
{
	var userSelect = jQuery('#'+uElement);
	var locationSelect = jQuery('#'+lElement);
	var workAreaSelect = jQuery('#'+wElement);
	var departmentSelect = jQuery('#'+dElement);
	var departmentOptions = departmentSelect.html();
	var userDefaultSiteId = 0;
	if(userSelect.val() != null && userSelect.val() != "")
	{
		SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
		userDefaultSiteId = jQuery(userDefaultSite).val();
		if(userDefaultSiteId == undefined)
			userDefaultSiteId = 0;
	}
	 //Set work area dropdown
	if(departmentSelect.val() != null && departmentSelect.val() != "" && workAreaSelect.val() == "")
	{
		prepare(wElement);
		SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 11001, departmentSelect.val(), function(data) { populateOptionCallback(wElement, data); });
	}
	//Set location dropdown
	if(workAreaSelect.val() != null && workAreaSelect.val() != "" && locationSelect.val() == "")
	{
		prepare(lElement);
		SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 64, workAreaSelect.val(), function(data) { populateOptionCallback(lElement, data); });
	}
	    	
	//updateUserOptions(usersToDepartment, usersToDepartmentName);
}
  
function populateOptionCallback(element, data) {
	reset(element);
	DWRUtil.addOptions(element, data);
	sortSelect(element);
}
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
	
}
function reset(element)
{
	DWRUtil.removeAllOptions(element);
    DWRUtil.addOptions(element, {"":"Choose"});
    jQuery('#'+element).select2('val', '');	
}

function prepare(element)
{
	DWRUtil.removeAllOptions(element);
	DWRUtil.addOptions(element, {"":"Please Wait..."});
}

function updateUserOptions(usersToDepartment, usersToDepartmentName) {
	var option = "";
	var userSelect = jQuery('#'+uElement);
	var locationSelect = jQuery('#'+lElement);
	var workAreaSelect = jQuery('#'+wElement);
	var departmentSelect = jQuery('#'+dElement);
	reset(dElement);
	
	if(userSelect != null && userSelect.val() != "")
	{
		var selectedUserId = userSelect.val();
		var matchingDeptId = usersToDepartment[selectedUserId];
		if(matchingDeptId) {
			SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
			userDefaultSiteId = jQuery(userDefaultSite).val();
			if(userDefaultSiteId == undefined)
				userDefaultSiteId = 0;
			option += "<option value='"+matchingDeptId+"'>"+usersToDepartmentName[selectedUserId]+"</option>";
		    departmentSelect.html(option);
	    	departmentSelect.select2('val', jQuery('#'+dElement+' option:eq(0)').val());
	    	//Set work area dropdown
			reset(wElement);
	    	prepare(wElement);
	    	SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 11001, matchingDeptId, function(data) { populateOptionCallback(wElement, data); });
		}
		else {
			prepare(dElement);
	    	SystemDWRService.getQuestionOptions(42, function(data) { populateOptionCallback(dElement, data); });
		}
	}
	else
	{
		reset(wElement);
	}
	reset(lElement);
}

function updateUserDepartmentOptions(usersToDepartment, usersToDepartmentName) {
	var option = "";
	var userSelect = jQuery('#'+uElement);
	var departmentSelect = jQuery('#'+dElement);
	reset(dElement);
    
	if(userSelect != null && userSelect.val() != "")
	{
		var selectedUserId = userSelect.val();
		var matchingDeptId = usersToDepartment[selectedUserId];
		if(matchingDeptId) {
			var userDefaultSiteId = SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
			userDefaultSiteId = jQuery(userDefaultSite).val();
			if(userDefaultSiteId == undefined)
				userDefaultSiteId = 0;
			option += "<option value='"+matchingDeptId+"'>"+usersToDepartmentName[selectedUserId]+"</option>";
		    departmentSelect.html(option);
	    	departmentSelect.select2('val', jQuery('#'+dElement+' option:eq(0)').val());
	    	sortSelect(dElement);
		}
		else {
			prepare(dElement);
	    	SystemDWRService.getQuestionOptions(42, function(data) { populateOptionCallback(dElement, data); });
		}
	}
}

function updateWorkAreaOptions() {
	var option = "";
	var userSelect = jQuery('#'+uElement);
	var workAreaSelect = jQuery('#'+wElement);
	var departmentSelect = jQuery('#'+dElement);
	var departmentOptions = departmentSelect.html();
	workAreaSelect.select2('val', '');	
	var userDefaultSiteId = 0;
	if(userSelect.val() != null && userSelect.val() != "")
	{
		userDefaultSiteId = SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
		userDefaultSiteId = jQuery(userDefaultSite).val();
		if(userDefaultSiteId == undefined)
			userDefaultSiteId = 0;
	}
	if(departmentSelect.val() != null && departmentSelect.val() != "")
	{
		prepare(wElement);
		SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 11001, departmentSelect.val(), function(data) { populateOptionCallback(wElement, data); });
	}
}

function updateWorkAreaOptions2(usersToDepartment) {
	var option = "";
	var userSelect = jQuery('#'+uElement);
	var workAreaSelect = jQuery('#'+wElement);
	var departmentSelect = jQuery('#'+dElement);
	var departmentOptions = departmentSelect.html();
	workAreaSelect.select2('val', '');	
	var userDefaultSiteId = 0;
	if(userSelect.val() != null && userSelect.val() != "")
	{
		userDefaultSiteId = SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
		userDefaultSiteId = jQuery(userDefaultSite).val();
		if(userDefaultSiteId == undefined)
			userDefaultSiteId = 0;
	}
	if(departmentSelect.val() != null && departmentSelect.val() != "")
	{
		prepare(wElement);
		SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 11001, departmentSelect.val(), function(data) { populateOptionCallback(wElement, data); });
	} else if (departmentSelect.val() == null) {
		var selectedUserId = userSelect.val();
		var matchingDeptId = usersToDepartment[selectedUserId];
		if(matchingDeptId) {
			prepare(wElement);
			SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 11001, matchingDeptId, function(data) { populateOptionCallback(wElement, data); });
		}
	}
}

function updateLocationOptions() {
	var option = "";
	var userSelect = jQuery('#'+uElement);
	var locationSelect = jQuery('#'+lElement);
	var workAreaSelect = jQuery('#'+wElement);
	locationSelect.select2('val', '');	
	var matchingWAId = workAreaSelect.val();
	if(matchingWAId) {
		var userDefaultSiteId = 0;
		if(userSelect.val() != null && userSelect.val() != "")
		{
			userDefaultSiteId = SystemDWRService.getDefaultSite(userSelect.val(), handleSetDefaultSite);
			userDefaultSiteId = jQuery(userDefaultSite).val();
			if(userDefaultSiteId == undefined)
				userDefaultSiteId = 0;
		}
	    //Set location dropdown
		prepare(lElement);
    	SystemDWRService.getQuestionOptionsDependingOnIgnoreCurrentSite(userDefaultSiteId, 64, matchingWAId, function(data) { populateOptionCallback(lElement, data); });
	}
}

function setDepartmentforUser(userSelectedDetails){
/*	var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';*/
	if(userSelectedDetails.userId != null){
		reset('workarea');
		reset('location');
		jQuery('#user').val(userSelectedDetails.userId);
		jQuery('#user').trigger('change');
		
		if(userSelectedDetails.newDepartment){
			setTimeout( function(){
			jQuery('#department').val(userSelectedDetails.newDepartment);
			jQuery('#department').trigger('change');
			}, 500 );
		}else{
		setTimeout( function(){
			jQuery('#department').val(userSelectedDetails.department);
			jQuery('#department').trigger('change');
		}, 500 );
		}
		setTimeout( function(){
			jQuery('#workarea').val(userSelectedDetails.workArea); 
			jQuery('#workarea').trigger('change');
		}, 1500 );
		setTimeout( function(){
			jQuery('#location').val(userSelectedDetails.location); 
			jQuery('#location').trigger('change');
		}, 3000 );
	}
}