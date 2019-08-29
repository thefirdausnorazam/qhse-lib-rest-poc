function showHint() {
	jQuery('#assessmentNameText').attr("placeholder", riskTitle+" ("+jQuery('#assessmentNameText').attr("placeholder")+")");
}
		  
function getQuestionId( element ) {
	element = element.replace( "answers[", "" );
	element = element.replace( "]", "" );
	return element;
}	
var populateQuestionOptionsCount = 0;
var postPopulateQuestionOptionsCallbackHandler;

function populateQuestionOptions(id) {
	var el = document.getElementById(id);
	var questionId = el.getAttribute('questionid');
	var dependsOn = el.getAttribute('dependson');
	var dependsOnValue = (dependsOn) ? /*$F(dependsOn)*/ document.getElementById(dependsOn).value : -1;
	DWRUtil.removeAllOptions(id);

	// dependsOnValue is either '', '-1' or a number. If '', then no parent option is selected.
	if(dependsOnValue == '' || (dependsOnValue == -1 && $(dependsOn).value != ''))
	{
		//For this instance the parent has no values in its depends on list
		populateQuestionOptionsCount++;
		SystemDWRService.getQuestionOptionsDependingOn(questionId, 0, function(data) { populateQuestionOptionsCallback(id, data); });
	}
	else if (dependsOnValue != '') {
		DWRUtil.addOptions(id, {"-1":"Please Wait..."});
		populateQuestionOptionsCount++;
		SystemDWRService.getQuestionOptionsDependingOn(questionId, dependsOnValue, function(data) { populateQuestionOptionsCallback(id, data); });
	}

	// Fire the onchange event for dependent elements, if there are any.
	var dependsOnInput = jQuery('select[dependson*="'+getQuestionId(id)+'"]');
	if(dependsOnInput != null && dependsOnInput != 'undefined' && dependsOnInput.attr('id') != null)
	{
		populateQuestionOptions(dependsOnInput.attr('id'));
	}
}

function populateQuestionOptionsCallback(id, data) {
	DWRUtil.removeAllOptions(id);
	var el = document.getElementById(id);
	var emptyOptionValue = !el.getAttribute('emptyoptionvalue') ? "" : el.getAttribute('emptyoptionvalue');
	var emptyOptionLabel = !el.getAttribute('emptyoptionlabel') ? " " : el.getAttribute('emptyoptionlabel');
	DWRUtil.addOptions(id, (emptyOptionValue=="") ? {"":emptyOptionLabel} : {emptyOptionValue:emptyOptionLabel});
	DWRUtil.addOptions(id, data);

	populateQuestionOptionsCount--;
	if (postPopulateQuestionOptionsCallbackHandler != null) {
		postPopulateQuestionOptionsCallbackHandler();
	}
	var previousValue = jQuery('select[id*="'+getQuestionId(id)+'"]').val();
	var options = jQuery('select[id*="'+getQuestionId(id)+'"] option');                    // Collect options         
	options.detach().sort(function(a,b) {               // Detach from select, then Sort
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
	options.appendTo('select[id*="'+getQuestionId(id)+'"]'); 
	if(previousValue == ""){
		jQuery('select[id*="'+getQuestionId(id)+'"]').select2('val', '');
	}
}

function initDependsOn(formName)
{
	jQuery("#"+formName+" select").each(
	    function(index){  
	        var input = jQuery(this);
	        var dependson = input.attr('dependson');
	        if (dependson) {
	        	var dependsOnInput = jQuery('select[id*="'+getQuestionId(input.attr('dependson'))+'"]');
	        	if(dependsOnInput != null && dependsOnInput != 'undefined')
	        	{
	        		dependsOnInput.change(function() {
	        			populateQuestionOptions(input.attr('id'));
	    			});
	        	}
	        }
	    }
	);
}
