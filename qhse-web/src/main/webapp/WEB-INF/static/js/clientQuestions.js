
function populateClientDependsOnOptions(qid, listOid)
{
	//Check is noting is selected
	if(listOid == "") {
		jQuery('select.clientQuestion').each(function() {
			var clientDependson = jQuery(this).attr("clientDependson");
			if(clientDependson == "answers["+qid+"]") {
				//Deselect
				jQuery(this).find("option:selected").prop("selected", false);
				jQuery(this).find("option:selected").each(function(){
					  jQuery(this).removeAttr("selected");
					  jQuery(this).attr("selected", false);
					});
				jQuery(this).empty();
				jQuery(this).select2({               
	                placeholder: "Choose",
	                allowClear: true,
	            	width: '100%'});
			}
		});   
	}
	else {
		var url=contextPath + '/client/listDependentOptions.json?dependsOnIds='+listOid;
		jQuery.getJSON(url, function(d) {
			jQuery('select.clientQuestion').each(function() {
				var clientDependson = jQuery(this).attr("clientDependson");
				if(clientDependson == "answers["+qid+"]") {
					var questionId = jQuery(this).attr("questionid");
					var id = jQuery(this).attr("id");
	   	 			var selectedOptions = jQuery(this).find("option:selected").map(function(){ return this.value }).get().join(", ");
	   	 			var el = jQuery(this);
					jQuery(this).select2().select2('val', '');
					jQuery(this).empty();
					el.append("<option></option>");
			   	 	for (i = 0; i < d.length; i++) {
			   	 		if(questionId == d[i].questionId) {
		   	 				var selected = "";
				   	 		var strArr = selectedOptions.split(',');
				   	 		for(j=0; j < strArr.length; j++) {
				   	 		   if(d[i].id == strArr[j]) {
			   	 					selected = "selected";
			   	 				}
		   	 				}
		   	 				el.append("<option id='"+d[i].id+"' value='"+d[i].id+"' "+selected+">"+d[i].name+"</option>");
			   	 		}
			   	 	}
				}
				jQuery(this).select2({               
	                placeholder: "Choose",
	                allowClear: true,
	            	width: '100%'});
			});
		});
	}
}

function initClientDependsOn()
{
	jQuery('select.clientQuestion').change(function() {
		populateClientDependsOnOptions(jQuery(this).attr('questionId'), jQuery(this).find("option:selected").map(function(){ return this.value }).get().join(", ")); //May be multi select
	}).change();
}

