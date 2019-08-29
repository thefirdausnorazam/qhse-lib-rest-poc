
var dialog;
var setVisible;


function onPageSubmit(aForm) {
/*	var assignees = document.getElementById("assignees");
	if(assignees) {
		for (var i = 0; i < assignees.length; i++) {
			assignees[i].selected = true;
		}
	}
	
	var communicatedTo = document.getElementById("communicatedTo");
	if(communicatedTo) {
		for (var i = 0; i < communicatedTo.length; i++) {
			communicatedTo[i].selected = true;
		}
	}
	*/
	jQuery("#incidentType").val(jQuery('#superType').val());
	addIndicesToCollectionElements(aForm, "incident.participants", "participantsSize");
}

function checkCR(evt) {
	var evt = (evt) ? evt : ((event) ? event : null);
	var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
	if ((evt.keyCode == 13) && (node.type=="text")) {return false;}
}
document.onkeypress = checkCR;




function addIndicesToCollectionElements(aForm, prefix, sizeElementId) {
	
	var rows = jQuery('#participants tr#participantRow');
	jQuery('#participantsSize').val(rows.length);

	
}

function disableSubmit() {  
	var submitButton = jQuery('[type="submit"]'); 
	submitButton.attr("disabled", "disabled");
    return true;
}

// get the parent of an object of a particular type
function getParent(type, obj) {
  if (obj != null) {
    if(obj.nodeName.toUpperCase() == type.toUpperCase()) {
      return obj;
    } else {
      return getParent(type, obj.parentNode);
    }
  }
  return null;
}



function onTypeChange(superTypeSel) {
  jQuery("#overlay").show();
  jQuery("#incidentType").val(jQuery(superTypeSel).val());
  jQuery("#incidentTypeChange").val(jQuery(superTypeSel).val());
  jQuery("#subTypeSel").val("0");
  var rows = jQuery('#participants tr#participantRow');
  jQuery('#participantsSize').val(rows.length);
  
  var form = document.getElementById("incidentForm"); 
  selectAllCommunicatedTo();
  form.submit();
}
function selectAllCommunicatedTo() {
	jQuery("#communicatedTo option").each(function()
			{
				this.selected = true;
			});
	jQuery("#assignees option").each(function()
			{
				this.selected = true;
			});
}


function dateChanged(cal, dateStr) {
	cal.sel.value = dateStr; // just update the date in the input field.
	if (cal.dateClicked && cal.isPopup) {
		cal.callCloseHandler();
	}
	if (cal.sel.id == "occurredDate") {
		if (document.getElementById("occurredDate") != null) {
			var dateStr = document.getElementById("occurredDate").value;
			var date = Date.parseExact(dateStr, "dd-MMM-yyyy");
			if (date != null) {
				var daysToAdd = parseInt("<fmt:message key='incident.investigationDueForClosureDays'/>");
				date.add(daysToAdd).days();
				var invClosureDate = document.getElementById("incident.investigationClosureDate")
				if(invClosureDate){
					invClosureDate.value = date.toString("dd-MMM-yyyy");
				}
			}
		}
	}
}
onCalendarSelectHandler = dateChanged;

function init() {
	initDependsOn("incidentForm");
  }
  
function setVisible(objId, edit, targetRow) {
	if(targetRow != null)
	{
		document.getElementById("editPersonIndex").value = targetRow.rowIndex;
	}
	var obj = document.getElementById(objId);
	document.getElementById("addPersonForm").reset();
	obj.style.visibility = (obj.style.visibility == 'visible') ? 'hidden' : 'visible';
	var unassigned = document.getElementById("unassigned");
	var assignees = document.getElementById("assignees");
	var firstAidOutcome = document.getElementById("firstAidOutcome");
	var activeUsers = document.getElementById("activeUsers");
	var communicatedTo = document.getElementById("communicatedTo");
	unassigned.style.visibility = (obj.style.visibility =='visible') ? 'hidden' : 'visible';
	assignees.style.visibility = (obj.style.visibility =='visible') ? 'hidden' : 'visible';
	activeUsers.style.visibility = (obj.style.visibility =='visible') ? 'hidden' : 'visible';
	communicatedTo.style.visibility = (obj.style.visibility =='visible') ? 'hidden' : 'visible';
	if(firstAidOutcome != null)
	{
		firstAidOutcome.style.visibility = (obj.style.visibility =='visible') ? 'hidden' : 'visible';
	}
	
	var viewForm = document.getElementById("viewForm");
	//viewForm.style.backgroundColor = (viewForm.style.backgroundColor =='gray') ? 'white' : 'gray';
	if (edit == true) {
		editRow(targetRow);
	}
	else
	{
		document.getElementById("editPersonIndex").value = "";	
	}
}


function copyPerson(id) {
	var obj = document.getElementById(id);
	var readOnlyParticipantsTable = document.getElementById('readOnlyParticipantsTable');
	addRow('readOnlyParticipantsTable', id);
	setVisible('addPerson');
}

function toggleCapaAnswears(select){

	var selected = jQuery("#capaProjectSelect option:selected").val();
	var row = jQuery('#capaProjectAnswearsDiv');	
	if(selected=='yes'){
		row.show();
	}else{
		jQuery('#capaProjectAnswearsDiv').find('input[type=checkbox]:checked').removeAttr('checked');
		row.hide();
	}
}

function showBodyImageDive(elementId){
	var incidentParticipantsOpenId = elementId.replace("bodyPart", "bodyPartCanvas");
	var incidentParticipantsSaveId = elementId.replace("bodyPart", "bodyPartPicture");
	var incidentParticipantsClearId = elementId.replace("bodyPart", "bodyPartPic");
	jQuery('#'+incidentParticipantsOpenId).hide();
	jQuery('#'+incidentParticipantsSaveId).hide();
	jQuery('#'+incidentParticipantsClearId).hide();
}


function saveBodyPartImage(e){
	var bodyPartCanvasId = e.replace("save", "bodyPartCanvas");
	var bodyPartPictureId = e.replace("save", "bodyPartPicture");
	var bodyPartPic = e.replace("save", "bodyPartPic");

	var clearLinkId = e.replace("save", "clear");
	var saveLinkId = e.replace("save", "save");
	jQuery(document.getElementById(clearLinkId)).hide();
	jQuery(document.getElementById(saveLinkId)).hide();
	
	var canvas = document.getElementById(bodyPartCanvasId);
	var imgData = canvas.toDataURL("image/png");
	document.getElementById(bodyPartPic).value=imgData;
	document.getElementById(bodyPartPictureId).src=imgData;

	jQuery(document.getElementById(bodyPartCanvasId)).hide();
	jQuery(document.getElementById(bodyPartPictureId)).show();
}

function openBodyPartImage(e){
	var bodyPartCanvasId = e.replace("open", "bodyPartCanvas");
	var bodyPartPictureId = e.replace("open", "bodyPartPicture");
	jQuery(document.getElementById(bodyPartPictureId)).hide();
	jQuery(document.getElementById(bodyPartCanvasId)).show();
	var clearLinkId = e.replace("open", "clear");
	var saveLinkId = e.replace("open", "save");
	jQuery(document.getElementById(clearLinkId)).show();
	jQuery(document.getElementById(saveLinkId)).show();
	
  	var canvas = document.getElementById(bodyPartCanvasId);

  	var settings = {
  			width:				237,
  			height: 			272,
  			backgroundImage:	false,
  			backgroundImageX: 	0,
  			backgroundImageY: 	0,
  			backgroundColor:	"#ffffff",
  			saveMimeType: 		"image/png",
  			saveFunction: 		BasicCanvasSave,
  			brush:				BasicBrush,
  			brushSize:			2,
  			brushColor:			"rgb(255,0,0)"
  		};

	jQuery(document.getElementById(bodyPartCanvasId)).jqScribble(settings);
	addImage(e);
}


function clearCanvas(e) {
	var bodyPartCanvasId = e.replace("clear", "bodyPartCanvas");
	jQuery(document.getElementById(bodyPartCanvasId)).data("jqScribble").update({backgroundImage: '../images/body.JPG'});
}

function addImage(e) {
	var bodyPartCanvasId = e.replace("open", "bodyPartCanvas");
	var bodyPartPictureId = e.replace("open", "bodyPartPicture");

	var img = document.getElementById(bodyPartPictureId);
	img.onerror = function(){
		// perhaps image is not found so change src to default image:
		img.src = '../images/body.JPG';
		jQuery(document.getElementById(bodyPartCanvasId)).data("jqScribble").update({backgroundImage: img});
		return;
	};
	
	var canvas = document.getElementById(bodyPartCanvasId);
	canvasContext = canvas.getContext("2d");
	canvasContext.drawImage(img, 0, 0);
}



