function getQuestionId( element ) {
	element = element.replace( "answers[", "" );
	element = element.replace( "]", "" );
	return element;
}	
var populateQuestionOptionsCount = 0;
var postPopulateQuestionOptionsCallbackHandler;


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
	        			var value = input.attr('id');
	        			populateQuestionOptionsScoreBoard(value);
	    			});
	        	}
	        }
	    }
	);
}
function populateQuestionOptionsScoreBoard(value) {
	
	var el = document.getElementById(value);
	var questionId = el.getAttribute('questionid');
	var dependsOn = el.getAttribute('dependson');
	var dependsOnValue = (dependsOn) ? /*$F(dependsOn)*/ document.getElementById(dependsOn).value : -1;
	DWRUtil.removeAllOptions(value);
	
	// dependsOnValue is either '', '-1' or a number. If '', then no parent option is selected.
	if(dependsOnValue == '' || (dependsOnValue == -1 && $(dependsOn).value != ''))
	{
		//For this instance the parent has no values in its depends on list
		populateQuestionOptionsCount++;
		SystemDWRService.getQuestionOptionsDependingOn(questionId, 0, function(data) { populateQuestionOptionsCallbackScoreBoard(value, data); });
	}
	else if (dependsOnValue != '') {
		DWRUtil.addOptions(value, {"-1":"Please Wait..."});
		populateQuestionOptionsCount++;
		SystemDWRService.getQuestionOptionsDependingOn(questionId, dependsOnValue, function(data) { populateQuestionOptionsCallbackScoreBoard(value, data); });
	}
	
	// Fire the onchange event for dependent elements, if there are any.
	var dependsOnInput = jQuery('select[dependson*="'+getQuestionId(value)+'"]');
	if(dependsOnInput != null && dependsOnInput != 'undefined' && dependsOnInput.attr('id') != null)
	{
		populateQuestionOptionsScoreBoard(dependsOnInput.attr('id'));
	}
}
function populateQuestionOptionsCallbackScoreBoard(id, data) {
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
	jQuery('select[id*="'+getQuestionId(id)+'"]').select2('val', '');
	if(optionListUpdatable){
		selectChosenOption(getQuestionId(id));
	}
}
