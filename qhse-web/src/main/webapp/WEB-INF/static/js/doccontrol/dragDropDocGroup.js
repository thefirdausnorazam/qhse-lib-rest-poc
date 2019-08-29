var showShutUp = true;
var yes = SCANNELL_TRANSLATIONS.yes;
var no = SCANNELL_TRANSLATIONS.no;

//Allow Drop Document
function allowDrop(ev) {
    ev.preventDefault();
}

//Drag for Doc Group and Document
function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

//Drop Document
function drop(ev) {
    ev.preventDefault();
    //Check you only allow Documents drop here
    var data = ev.dataTransfer.getData("text");
    if(document.getElementById(data) != null && document.getElementById(data).className == "note") {
        var dataObject = document.getElementById(data);
    	var dest = jQuery(ev.target).closest('.treeNode').find('.docHolder').attr('id');
    	var source = jQuery("#"+data).closest('.treeNode').find('.docHolder').attr('id');
    	//Check they are not dropping on itself
    	if(dest != source) {
			fnOpenNormalDialog(ev, data);
    	}
	}
}

//Allow Drop Doc Group
function allowDropDocGroup(ev) {
    ev.preventDefault();
}

//Drop Doc Group
function dropDocGroup(event) {
	event.preventDefault();
    var data = event.dataTransfer.getData("text");
    //Check you only allow Doc Groups drop here
    if(document.getElementById(data) != null && document.getElementById(data).className == "treeNode") {
    	var source;
    	var dest;
    	//Check if source has any children, if it doesn't do not try to get an id
    	if(jQuery("#"+data).closest('.docGroup').find('.docGroupList') != null) {
    		source = jQuery("#"+data).closest('.docGroup').find('.docGroupList').attr('id');
    	}
    	//Check if dest has any children, if it doesn't do not try to get an id.  Will need to create the children list later
    	if(jQuery(event.target).closest('.docGroup').find('.docGroupList') != null) {
    		dest = jQuery(event.target).closest('.docGroup').find('.docGroupList').attr('id');
    	}
    	//Check they are not dropping on itself
    	if(dest != source) {
    		fnOpenNormalDocGroupDialog(event, data, source, dest);
    	}
	}
}

function isChild(source, dest) {
    var parents = jQuery("#" + dest).parents(".docGroupList");
    var selector = "";
    for (var i = parents.length-1; i >= 0; i--) {
    	if(parents[i].id == source) {
        	return true;
    	}
    }
    return false;
}

//Show the Modal for the Document Move confirmation dialog
function fnOpenNormalDialog(ev, data) {
    // Define the Dialog and its properties.
	if(showShutUp) {
	    jQuery("#dialog-confirm").dialog({
	        resizable: false,
	        modal: true,
	        title: SCANNELL_TRANSLATIONS.moveDocument,
	        height: 250,
	        width: 400,
	        create: function (e, ui) {
	            var pane = jQuery(this).dialog("widget").find(".ui-dialog-buttonpane")
	            jQuery("<label class='shut-up' ><input  type='checkbox'/>"+SCANNELL_TRANSLATIONS.doNotShowAgain+"</label>").prependTo(pane)
	        },
	        buttons: {
	        	yes: function () {
	            	jQuery(this).dialog('close');
	                callback(true, ev, data);
	            },
	            no: function () {
	                	jQuery(this).dialog('close');
	                callback(false, ev, data);
	            }
	        }
	    });
	}
	else {
		callback(true, ev, data);
	}
}

//Show the Modal for the Doc Group Move confirmation dialog
function fnOpenNormalDocGroupDialog(ev, data, source, dest) {
    // Define the Dialog and its properties.
	if(showShutUp) {
	    jQuery("#dialog-confirm-docGroup").dialog({
	        resizable: false,
	        modal: true,
	        title: SCANNELL_TRANSLATIONS.moveDocgroup,
	        height: 250,
	        width: 400,
	        create: function (e, ui) {
	            var pane = jQuery(this).dialog("widget").find(".ui-dialog-buttonpane")
	            jQuery("<label class='shut-up' ><input  type='checkbox'/>"+SCANNELL_TRANSLATIONS.doNotShowAgain+"</label>").prependTo(pane)
	        },
	        buttons: {
	        	yes: function () {
	            	jQuery(this).dialog('close');
	                callbackDocGroup(true, ev, data, source, dest);
	            },
	            no: function () {
	                	jQuery(this).dialog('close');
	                	callbackDocGroup(false, ev, data, source, dest);
	            }
	        }
	    });
	}
	else {
		callbackDocGroup(true, ev, data, source, dest);
	}
}

//Set the showShutUp to false if user checks it, then start 5  minute timer
jQuery('#btnOpenDialog').click(fnOpenNormalDialog);
jQuery(document).on("change", ".shut-up input", function () {
	showShutUp =  !this.checked;
	if(!showShutUp) {
		loading();
	}
})

//This is to wait 5 minutes and reset the showShutUp check box back to true, only started after user sets to false
function loading(){
    setTimeout(function(){ 
    	showShutUp = true; 
    }, 300000);
}

//Move the Document using ajax
function callback(value, ev, data) {
    if (value) {
    	//Add the document to the new Doc Group list
        var dataObject = document.getElementById(data);
    	jQuery(ev.target).closest('.treeNode').find('.docHolder').append(document.getElementById(data));
    	
    	//Move to the new document location, if you don't do this the page jumps
    	document.getElementById(dataObject.id).scrollIntoView();
    	
    	//If the document list is not open then you must show it and get rid of the stacked paper affect
    	var collapse = jQuery(ev.target).closest('.treeNode').find('.collapse');
    	var button = jQuery(ev.target).closest('.treeNode').find('.docButton');
		jQuery(button).removeClass("papers").addClass("nopaper").end();
    	jQuery(collapse).collapse('show');
    	
    	//Ajax Call: Pass the document and new parent
    	jQuery.ajax({
    	    type:'POST',
    	    data:{'docGroup':jQuery(button).attr("id").slice(9), 'document': dataObject.id.slice(3)},
    	    url:'moveDocument.html',
    	    success:function(data) {
    	      //alert(SCANNELL_TRANSLATIONS.successMove);
    	    }
    	  });
    }
}

//Move the Doc Group using ajax
function callbackDocGroup(value, ev, data, source, dest) {
	if (value) {
		//Check that the destination is not a child of the source Doc Group
		if(isChild(source, dest)) {
			alert(SCANNELL_TRANSLATIONS.cannotAddToChild);
			return;
		}
    	//Add the document to the new Doc Group list
        var dataObject = document.getElementById(data);
        
        //If the destination Doc Group has no children then we need to show the doc group list again
        var destId = jQuery(ev.target).closest('.docGroup').find('.docGroupList').attr("id");
    	var sourceId = jQuery("#"+data).closest('.docGroup').parent().parent().find('.docGroupList').attr("id");
    	if(jQuery("#"+destId).hasClass("hideDocGroupChildren")) {
    		jQuery("#"+destId).removeClass("hideDocGroupChildren");
    	}
    	jQuery(ev.target).closest('.docGroup').find('.docGroupList').first().append(jQuery("#"+data).closest('.docGroup'));

    	//If after moving the Doc Group has no more children then hide the group list at the source
    	if(jQuery("#"+sourceId).find("li").length == 0) {
    		jQuery("#"+sourceId).addClass("hideDocGroupChildren");
    	}
    	
    	//Ajax Call: Change the parent Doc Group
    	jQuery.ajax({
    	    type:'POST',
    	    data: {'docGroupParent': jQuery(ev.target).closest('.treeNode').attr("id"), 'docGroup': dataObject.id},
    	    url:'moveDocGroup.html',
    	    success:function(data) {
    	      //alert(SCANNELL_TRANSLATIONS.successMove);
    	    }
    	  }); 
    }
}

