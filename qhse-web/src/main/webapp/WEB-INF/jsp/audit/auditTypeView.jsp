<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	
	<style type="text/css">
	.group-div-inputs {
		vertical-align: middle;
		background-color: #F6F6F6
	}
	td.searchLabel {
		padding-left: 0px !important;
		padding-right: 5%!important;
	}
	.groupName {
		background-color: #F6F6F6;
		border: 1px solid rgba(0,0,0,0);
		width: 98%;
		color:#92007B;
		font-size: 150%;
	}
	.groupName:focus {
		border: 1px solid;
	}
	.questionGroup {
		display: inline-block;
		padding-bottom: 100px;	
		width:100%;
	}
	.list-group-item {
		padding-bottom: 30px;
	}
	li.jQuery(el).parent('li') {
    	height: 70px;
	}
	.panelHover:not(:focus):hover {
    	background-color: #e6e6e6 !important;
	}
	.dropArea {
    	margin-bottom: 30px !important;
    	background-color: #f4e5f1 !important;
	}
	
.custom-menu {
    display: none;
    z-index: 1000;
    position: absolute;
    overflow: hidden;
    border: 1px solid #CCC;
    white-space: nowrap;
    font-family: sans-serif;
    background: #FFF;
    color: #333;
    border-radius: 5px;
}

.custom-menu li {
    padding: 8px 12px;
    cursor: pointer;
}

.custom-menu li:hover {
    background-color: #DEF;
}
</style>


<style>
  .sortable2 { list-style-type: none; margin: 0; padding: 0; width: 50%; }
  .sortable2 li { margin: 0 3px 3px 3px; padding: 0.8em; padding-left: 1.5em; /*font-size: 1.4em;*/ }
  .sortable2 li span { position: absolute; margin-left: -1.3em; }
  </style>
	<script>
function load_image(id,ext,input){
	if(ext == ""){
		return;
	}
	if(validateExtension(ext) == false){
		    alert("Upload only JPEG, PNG, GIFF, GIF or JPG format ");
	        //document.getElementById("imagePreview").src = "#";
	        document.getElementById("content").focus();
	        //document.getElementById("save").disabled = 1;
	        return;
	 }
	 if (input.files && input.files[0]) {
		 var imageSize = parseInt((input.files[0].size/1024));
		 if(imageSize > 3000){
			 jQuery("#content").replaceWith(jQuery("<input>", {id:"content", type:"file", name:"picture", class:"wide", accept:"image/*", onChange:"load_image(this.id,this.value,this)"})); 
			 
			 jQuery("#imageDiv").text("");
			 alert('<fmt:message key="imageTooBig" />');
			 return;
		 }
	      var reader = new FileReader();
	      reader.onload = function (e) {
	          jQuery('#imageDiv').text('');
	          jQuery("#imageDiv").show();
	           jQuery('#imageDiv').prepend('<img id="theImg" src="e.target.result" alt="" border=3  style="max-height:200px" />');
	           jQuery("#theImg").attr("src",e.target.result);
	            	//jQuery('#theImg').Jcrop();
	           //cropImage();
	        }
	      reader.readAsDataURL(input.files[0]);
	      //setTimeout(function() { cropImage(); }, 1500);
	 }
}
function cropImage(){			 
	 var w = 100;
       var h = 100;
       var W = jQuery('#theImg').width();
       var H = jQuery('#theImg').height();
       var x = W / 2 - w / 2;
       var y = H / 2 - h / 2;
       var x1 = x + w;
       var y1 = y + h;

       jQuery('#theImg').Jcrop({
           onChange : showCoords,
           onSelect : showCoords,

           setSelect : [ x, y, x1, y1 ]
           ,minSize : [ 100, 100 ] // use for crop min size
           ,maxSize : [ 260, 260 ] // use for crop min size
           ,aspectRatio : 1 / 1    // crop ration 
       });
	}
function showCoords(c) {
    // get image natural height/width for server site crop image.
      var imageheight = document.getElementById('theImg').naturalHeight;
      var imagewidth = document.getElementById('theImg').naturalWidth;
      var xper = (c.x * 100 / jQuery('#theImg').width());
      var yper = (c.y * 100 / jQuery('#theImg').height());
      var wPer = (c.w * 100 / jQuery('#theImg').width());
      var hper = (c.h * 100 / jQuery('#theImg').height());

      var actX = (xper * imagewidth / 100);
      var actY = (yper * imageheight / 100);
      var actW = (wPer * imagewidth / 100);
      var actH = (hper * imageheight / 100);
      jQuery('#cropX').val(parseInt(actX));
      jQuery('#cropY').val(parseInt(actY));
      jQuery('#cropW').val(parseInt(actW));
      jQuery('#cropH').val(parseInt(actH));

  };
function validateExtension(v){
      var allowedExtensions = new Array("jpg","JPG","jpeg","JPEG", "giff", "GIFF", "gif", "GIF", "png", "PNG");
      for(var ct = 0; ct < allowedExtensions.length; ct++){
          sample = v.lastIndexOf(allowedExtensions[ct]);
          if(sample != -1){return true;}
      }
      return false;
}
	jQuery.postJSON = function(url, data, callback) {  
		return jQuery.ajax({
	       url: url,
	       type: "POST",
	       data: data,
	       processData: false,
	       contentType: false,
	       success: callback
	    });
	};
	var mapGgroup = new Object();
function loadResearch(methodTargetName){
		
		var objectIdArray = new Array(); 
		jQuery(".object-id").each(function (){
			var objectIdObj = {objectId: jQuery(this).val()}
			objectIdArray.push(objectIdObj);
		});
		var jsonData = new FormData();
		jsonData.append("objectIdArray", JSON.stringify(objectIdArray));
		jQuery.postJSON(methodTargetName, jsonData, function(responseFromController){
			var imageList = responseFromController.imageList;
			for(var i = 0; i < imageList.length; i++){
				var fontSize = "16px";
				jQuery("<img>", {class:"questionImg",id:"img-"+imageList[i].question, src: "data:image/jpg;base64,"+imageList[i].imageInBase64, style:"margin-right:15px;float:right; height:"+fontSize+";width:"+fontSize, onclick:"imageOpenModal(this)"}).appendTo(jQuery("#"+imageList[i].question));
				
				//jQuery("#img-"+imageList[i].question).attr("src", "data:image/jpg;base64,"+imageList[i].imageInBase64)
				//jQuery("#img-"+imageList[i].question).removeClass("not-image");
			}
			jQuery(".not-image").remove();
			
		}).error(function(jqXHR, error, errorThrown) {
			jQuery(".not-image").remove();
			if (jqXHR.status && jqXHR.status == 400) {
				alert('<fmt:message key="noImageFoundPageNotFound" />')
			} else if (jqXHR.status && jqXHR.status == 500) {
				alert('<fmt:message key="noImageFoundInternalError" />')
			} else {
				alert('<fmt:message key="noImageFound" />')
			}
		});
	}
	jQuery(document).ready(function() {
		jQuery("#save-button-2").hide();
		setTimeout(function() {
			loadResearch("auditQuestionImagesLazyLoad.htm");
		}, 1500);
		
		jQuery(".errorMessage").hide();
//		jQuery( ".sortable2" ).sortable({update: function( event, ui ) {alert(78)}});
		var optionList = new Array();
		var lastGroup = '0';
		<c:forEach items="${questionGroup.questions}" var="question" varStatus="s">
		<c:if test="${question.visible}">
			<c:choose>
			<c:when test="${question.answerType.name == 'label' }">
				var objGroupName = jQuery("#hidden-escaped-${question.id}").val();
				var groupId = "group-${question.id}";
				jQuery("<div>", {id: groupId, class:"questionGroup", style:"padding-bottom: 60px;width:100%"}).appendTo(jQuery("#auditQuestionGroups"));
				jQuery("<div>", {id: groupId+"-div-inputs", class:"group-div-inputs", style: "vertical-align: middle;background-color: #F6F6F6"}).appendTo(jQuery("#"+groupId));
				jQuery("<input>", {id: groupId+"-input1", class:"groupId", style:"display:none", type:"text"}).appendTo(jQuery("#"+groupId+"-div-inputs"));
				jQuery("<input>", {id: groupId+"-checkbox", name:"radioGroup", value: groupId, class:"groupId radioGroups", style:"display:inline-block;margin-right:10px;", type:"radio"}).appendTo(jQuery("#"+groupId+"-div-inputs"));
				jQuery("<input>", {id: groupId+"-input2", class:"groupName", style:"display:inline-block;color:#13ab94;width:98%;", type:"text", value: objGroupName}).appendTo(jQuery("#"+groupId+"-div-inputs"));
				jQuery("<ul>", {id: groupId+"-ulQuestionsId", style:"width:50%", class: "sortable2 sortable-dragging"}).appendTo(jQuery("#"+groupId));
				groupArray.push({id: groupId, questionId: "${question.id}", name: objGroupName, questions: []});
				mapGgroup[groupId] = {id: groupId, questionId: "${question.id}", name: objGroupName, questions: new Object()}
				lastGroup = groupId;
			</c:when>
			<c:otherwise>
				var objQuestionName = jQuery("#hidden-escaped-${question.id}").val();
				jQuery("<li>", {class:"ui-state-default sortable-dragging scannell-tooltip", id: "${question.id}", parentGroup: lastGroup}).appendTo(jQuery("#"+groupId+"-ulQuestionsId"));
				jQuery("<span>", {class:"ui-icon ui-icon-arrowthick-2-n-s sortable-dragging"}).appendTo(jQuery("#${question.id}"));
				jQuery("<font>", {text: objQuestionName, style:"color:#13ab94"}).appendTo(jQuery("#${question.id}"));
				jQuery("<span>", {class:"tooltiptext", text:getQuestionType("${question.answerType.name}")}).appendTo(jQuery("#${question.id}"));
				jQuery("<input>", {type:"button",style:"float:right", value:"...", onclick:"openLIMenu('${question.id}')"}).appendTo(jQuery("#${question.id}"));
				jQuery("<input>", {type:"hidden",class:"object-id", value:"${question.id }"}).appendTo(jQuery("#${question.id}"));
				
				optionList = new Array();
				<c:if test="${question.answerType.name == 'option-multi-choice' || question.answerType.name == 'option' }">
					<c:forEach items="${question.activeOptions}" var="option" varStatus="s">
						var objOptionName = jQuery("#hidden-escaped-option-${option.id}").val();
						jQuery("<input>", {class: "questionOption", value: objOptionName, type:"hidden"}).appendTo(jQuery("#${question.id}"));
						optionList.push({id: "${option.id}", optionId: "${option.id}", name: objOptionName, active: "true"});
					</c:forEach>
				</c:if>
				var objQuestion = {id: "${question.id}", questionId: "${question.id}", name: objQuestionName, order:'${s}', type: "${question.answerType.name}", info: "${question.furtherInfo}", options: optionList};
				groupArray[(groupArray.length - 1)].questions.push();
				mapGgroup[lastGroup].questions['${question.id}'] = objQuestion;
				showCustomMenu("${question.id}");
			</c:otherwise>	
		</c:choose>
		</c:if>
		//jQuery(".sortable2").sortable({"update": function( event, ui ) {alert(79)}});
		jQuery(".sortable2").sortable();
		
	</c:forEach>
	showSaveButton2();
	});
	
function saveInspectionProgramme(btObj){
	jQuery("#saveButton").attr("disabled", true);
	jQuery("#saveButton2").attr("disabled", true);
	var jsonData = new FormData();
	
	jsonData.append("auditInspectionProgrammeTypeJson", JSON.stringify(updateJson()));
	jsonData.append('id', '<c:out value="${questionGroup.id}" />');
	
	var request = new XMLHttpRequest();
	request.open("POST", "auditTypeView.htm");
	request.send(jsonData);
	request.onreadystatechange = function() {
		
		if (request.readyState == XMLHttpRequest.DONE) {
			 if(request.status === 200){  //check if "OK" (200)
				if(request.responseText.indexOf("result:OK") > -1){
						location.href = "auditTypeQueryForm.htm";
				} else {
					alert('<fmt:message key="inspectionTemplateSaveError" />');
				}
		     }
			 jQuery("#saveButton").attr("disabled", false);	
			 jQuery("#saveButton2").attr("disabled", false);
		}
    }
	
}
function updateJson(){
	var groupTest = null;
	var groupArrayToSendToServer = new Array();
	
	var elementGroupArray = jQuery(".questionGroup").toArray();
	for(var i = 0; i < elementGroupArray.length; i++){
		var groupId= jQuery(elementGroupArray[i]).attr("id");
		var questionArrayBelongToGroup = new Array();
		var liQuestionArray = jQuery("#"+groupId+"-ulQuestionsId").find("li");
		for(var c = 0; c < liQuestionArray.length; c++){
			var questioId =  jQuery(liQuestionArray[c]).attr("id");
			var parentGroup = jQuery(liQuestionArray[c]).attr("parentGroup");
			
			mapGgroup[parentGroup].questions[questioId].order = c;
			questionArrayBelongToGroup.push(mapGgroup[parentGroup].questions[questioId]);
			groupTest = mapGgroup[parentGroup];
		}
		// cloning the object
		var newObject = JSON.parse(JSON.stringify(mapGgroup[groupId]));
		newObject.name = jQuery("#"+newObject.id+"-input2").val();
		newObject.questions = new Array();
		newObject.questions = questionArrayBelongToGroup;
		groupArrayToSendToServer.push(newObject);
	}
	
	return groupArrayToSendToServer;
}
	</script>
	<style>
.scannell-tooltip {
   
}

.scannell-tooltip .tooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: #13ab94;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;

    /* Position the tooltip */
    position: relative;
    z-index: 1;
    left: 5%
}

.scannell-tooltip:hover .tooltiptext {
    visibility: visible;
}
/* ************************   Image modal popup ***************************  */
/* Style the Image Used to Trigger the Modal */
#myImg {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.5); /* Black w/ opacity */
}

/* Modal Content (Image) */
.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
}

/* Caption of Modal Image (Image Text) - Same Width as the Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation - Zoom in the Modal */
.modal-content, #caption { 
    animation-name: zoom;
    animation-duration: 0.6s;
}

@keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    /*position: absolute;*/
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}

.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
    }
}
</style>
</head>
<body>
<div class="header">
<h2><span class="nowrap"><fmt:message key="inspectionProgrammeType" /><!--<fmt:message key="programmeView" />--></span></h2>
</div>

<a name="auditType"></a>
<!-- <div class="header"> -->
<%-- <h3><span class="nowrap"><fmt:message key="programme.title" /></span></h3> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<col class="label" />

<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${questionGroup.id}" /></td>
	</tr>
   
	<tr style="display:none">
		<td class="scannellGeneralLabel"><fmt:message key="codeName" />:</td>
		<td >
	      <c:out value="${questionGroup.codeName}" />
		</td>
	</tr>
	
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><c:out value="${questionGroup.name}" /></td>
	</tr>
	
	
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<c:if test="${urls != null}"><scannell:url urls="${urls}" /></c:if>
			| <a href="#" onclick="addGroup()">Add Group(Label)</a>
			| <a href="#" onclick="removeGroup()">Remove Group(Label)</a>
			| <a href="#" onclick="addQuestion()">Add Question</a>	
			<c:if test="${showHistory == true}">| <a href="javascript:openHistory('${questionGroup.id }','com.scannellsolutions.modules.system.domain.QuestionGroup')"><fmt:message key="viewHistory" /></a></c:if>
			
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>

<div class="header">
<h3><span class="nowrap"><fmt:message key="questions" /></span></h3>
</div>
<a name="questions"></a>
<div class="content">
<div class="table-responsive">

<scannell:form enctype="multipart/form-data">
<div class=" text-center" id="save-button-2">
			<input class="g-btn g-btn--primary" type="button" id="saveButton2" onclick="saveInspectionProgramme()" value="Save" >
			<button type="button" class="g-btn g-btn--secondary" onclick="location.href='auditTypeQueryForm.htm'">Cancel</button>
		</div>
<input type="hidden" id="auditTypeJson" name="auditTypeJson" value="">
<div id="auditQuestionGroups" style="height:100%;width:100%; margin-top:10px">
	
</div>

	 <div id="dialogGroup" style="display:none" title="New Group">
	 		<div class="content">
				<div class="table-responsive">
					<table class="table table-bordered table-responsive">
						<tbody>
							<tr class="form-group">
								<td class="searchLabel nowrap"><fmt:message key="name" />:</td>
								<td class="search"><textarea id="new-group-name" rows="3" cols="75" style="overflow: hidden; word-wrap: break-word; resize: horizontal; height: 54px;"></textarea>
									<span class="requiredHinted">*</span>
									<span class="errorMessage" id="group-name-mandatory">
										<fmt:message key="required" />
									</span>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" align="center"><input type="button" onclick="createNewGroup()" class="g-btn g-btn--primary" value="Create"><input type="button" onclick="closeGroupDialog()" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />"></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
	 </div>
	 
	 <div id="dialogQuestion" style="display:none" title="New Question">
	 		<div class="content">
				<div class="table-responsive">
					<table class="table table-bordered table-responsive">
						<tbody>
							<tr >
								<td ><fmt:message key="name" />:</td>
								<td ><textarea id="new-question-name" rows="3" cols="75" style="overflow: hidden; word-wrap: break-word; resize: horizontal; height: 54px;"></textarea>
									<span class="requiredHinted">*</span>
									<span class="errorMessage" id="new-question-name-mandatory">
										<fmt:message key="required" />
									</span>
								</td>
							</tr>
							<tr >
								<td ><fmt:message key="type" />:</td>
								<td >
									<select id="question-type" onchange="showAddOption(this)">
										<option value="textarea">Text Area</option>
										<option value="option">Option</option>
										<option value="option-multi-choice">Option Multi Choice</option>
									</select>
									<span class="requiredHinted">*</span>
									<span class="errorMessage" id="question-type-mandatory">
										<fmt:message key="required" />
									</span>
								</td>
							</tr>
							<tr>
								<td><fmt:message key="mandatory" />:</td>
								<td>
									<select id="question-info" >
										<option value="required=true">Mandatory</option>
										<option value="required=false">Optional</option>
									</select>
								</td>
							</tr>
							<tr class="add-option-tr">
								<td ><fmt:message key="optionName" />:</td>
								<td ><input type="text" id="option-name" size="50" >&nbsp;<button onclick="addOption('fromElement')">Add</button>
									<span class="requiredHinted">*</span>
									<span class="errorMessage" id="add-option-mandatory">
										<fmt:message key="required" />
									</span>
								</td>
							</tr>
							<tr class="add-option-tr">
								<td ><fmt:message key="options" />:</td>
								<td >
									<input type="hidden" value="" id="question-popup">
									<ul id="ul-options"></ul>
									<span class="requiredHinted">*</span>
									<span class="errorMessage" id="ul-options-mandatory">
										<fmt:message key="required" />
									</span>
								</td>
							</tr>
							<tr class="questionsLabelRow" id="contentRow">
								<td><fmt:message key="chooseImage" /></td>
								 <td><input id="content" type="file" name="picture" class="wide" accept="image/*" onChange="load_image(this.id,this.value,this)"/>
						        <div class="mandatoryFile"  id="mandatoryFile"  ><span class="requiredHinted"><c:if test="${imageSizeError}"><fmt:message key="imageSizeErrorRA"/></c:if> </span></div>
						
								 <div class="image" id='imageDiv' style="max-height: 200; ${imageEncoded!=null && imageEncoded != '' ? '' : 'display: none;'}">
								 	<c:if test="${imageEncoded!=null && imageEncoded != ''}"><img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${imageEncoded}" alt="" border=3 style="max-height:200px"/></c:if> 
								 	  <input type="hidden" id="cropX" value="">
								      <input type="hidden" id="cropY" value="">
								      <input type="hidden" id="cropW" value="">
								      <input type="hidden" id="cropH" value="">
								 </div>
								</td>
							 </tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" align="center"><input type="button" onclick="createNewQuestion()" id="create-button" class="g-btn g-btn--primary" value="Create"><input type="button" onclick="editExistingQuestion()" id="edit-button" class="g-btn g-btn--primary" value="Update"><input type="button" onclick="closeQuestionDialog();" class="g-btn g-btn--secondary" value="Cancel"></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
	 </div>
	 
	 <div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="button" id="saveButton" onclick="saveInspectionProgramme()" value="Save" >
			<button type="button" class="g-btn g-btn--secondary" onclick="location.href='auditTypeQueryForm.htm'">Cancel</button>
		</div>
</scannell:form>
</div>
</div>
<ul class='custom-menu'>
  <li data-action = "remove-question"><fmt:message key="removeQuestion" /></li>
  <li data-action = "edit-question"><fmt:message key="editQuestion" /></li>
</ul>
<!-- The Modal -->
<div id="myModal" class="modal" onclick="document.getElementById('myModal').style.display='none'">

  <!-- The Close Button -->
  <span class="close">&times;</span>

  <!-- Modal Content (The Image) -->
  <img class="modal-content" id="img01" >

  <!-- Modal Caption (Image Text) -->
  <div id="caption"></div>
</div>
<c:forEach items="${questionGroup.questions}" var="question" varStatus="s">
		<c:if test="${question.visible}">
			<input type="hidden" id="hidden-escaped-${question.id}" value="<c:out value="${question.name}" />" >
			<c:forEach items="${question.activeOptions}" var="option" varStatus="s">
				<input type="hidden" id="hidden-escaped-option-${option.id}" value="<c:out value="${option.name}" />" >
			</c:forEach>
		</c:if>
</c:forEach>
<script type="text/javascript">
var groupArray = new Array();

function addGroup (){
    jQuery("#dialogGroup").dialog({width:'50%'});
}
function removeGroup (){
	if(!jQuery("input:radio[name='radioGroup']").is(":checked")) {
         alert('<fmt:message key="selectGroup" />');       
	} else {
		var selected = jQuery("input[type='radio']:checked");
		if (selected.length > 0) {
		    jQuery("#"+selected.val()).remove();
		    delete mapGgroup[selected.val()];
		}
	}
}
function addQuestion (){
	resetValues();
	jQuery(".errorMessage").hide();
	if(!jQuery("input:radio[name='radioGroup']").is(":checked")) {
		alert('<fmt:message key="selectGroup" />');       
	} else {
		jQuery("#ul-options").children().remove();
		jQuery("#dialogQuestion").dialog({width:'50%'});
		jQuery("#create-button").show();
		jQuery("#edit-button").hide();
	}
}

jQuery( "#dialogGroup" ).on( "dialogclose", function( event, ui ) {
	
} );
function createNewGroup(){
	if(validateGroup() == false){
		return;
	}
	var newGroupId = "group-"+new Date().getTime();
	jQuery("<div>", {id:newGroupId, class:"questionGroup", ondrop:"drop(event, this)", ondragover:"allowDrop(event)",style:"padding-bottom: 60px;width:100%"}).appendTo(jQuery("#auditQuestionGroups"));
	var divInputsId = newGroupId+"-div-inputs";
	jQuery("<div>", {id: divInputsId, style:"vertical-align: middle;"}).appendTo(jQuery("#"+newGroupId));
	var input1Id = newGroupId+"-input1";
	jQuery("<input>", {id: input1Id, class: "groupId", style:"display:none", type:"text"}).appendTo(jQuery("#"+divInputsId));
	var radioId = newGroupId+"-checkbox";
	jQuery("<input>", {id: radioId, name:"radioGroup", value:newGroupId, class: "groupId radioGroups", style:"display:inline-block;margin-right:10px;", type:"radio"}).appendTo(jQuery("#"+divInputsId));
	var input2Id = newGroupId+"-input2";
	jQuery("<input>", {id: input2Id, class: "groupName", style:"display:inline-block;color:#13ab94", type:"text", value: jQuery("#new-group-name").val()}).appendTo(jQuery("#"+divInputsId));
	
	var ulQuestionsId = newGroupId+"-ulQuestionsId";
	jQuery("<ul>", {id: ulQuestionsId, class:"sortable2"}).appendTo(jQuery("#"+newGroupId));
	 
	jQuery("#dialogGroup").dialog('close');
	groupArray.push({id: newGroupId, name: jQuery("#new-group-name").val(), questions: []});
	mapGgroup[newGroupId] = {id: newGroupId, name: jQuery("#new-group-name").val(), questions: {}}
	
	jQuery("#new-group-name").val('');
	showSaveButton2();
}
function showAddOption(obj){
	if(obj.value == "option" || obj.value == "option-multi-choice"){
		jQuery(".add-option-tr").show();
	} else {
		jQuery(".add-option-tr").hide();
	}
}

jQuery(".add-option-tr").hide();
var tempIdImprovement = 0;
function addOption(fromElement){
	
	for(var i = 0; i < jQuery("#ul-options").find(".class-options").length ; i++){
		  var o = jQuery("#ul-options").find(".class-options")[i];
		  if(jQuery(o).find("font").text() == jQuery.trim(jQuery("#option-name").val())){
			 	alert('<fmt:message key="duplicatedOption" />'); 
			  return;
		  }
	}
	
	tempIdImprovement++;
	var elementText = (fromElement == "fromElement") ? jQuery("#option-name").val() : fromElement;
	if(jQuery.trim(elementText) == ""){
		jQuery("#add-option-mandatory").show();
		return;
	}
	jQuery("#add-option-mandatory").hide();
	var optionId = new Date().getTime() + tempIdImprovement;
	jQuery("<li>", {class:"class-options", style:"margin-top:10px", id: optionId}).appendTo(jQuery("#ul-options"));
	jQuery("<font>", {  text: elementText}).appendTo(jQuery("#"+optionId));
	jQuery("<button>", {style:"margin-left:10px", onclick: "removeOption('"+optionId+"')", text: "Remove"}).appendTo(jQuery("#"+optionId));
	jQuery("#option-name").val('');
}

function createNewQuestion(){
	if(validateQuestion() == false){
		return;
	}
	var groupId = jQuery("input:radio[name='radioGroup']:checked").val();
	var ulQuestionId = groupId+"-ulQuestionsId";
	var tempId = new Date().getTime();
	var questionId = jQuery("#questionIdEdit").val();
	var questionObject = {id: tempId, questionId: "0", name: jQuery("#new-question-name").val(), order:"0", type: jQuery("#question-type").val(), info: jQuery("#question-info").val(), options: []};
	
	jQuery("<li>", {class:"ui-state-default  scannell-tooltip", id: tempId, parentGroup: groupId}).appendTo(jQuery("#"+ulQuestionId));
	jQuery("<span>", {class:"ui-icon ui-icon-arrowthick-2-n-s"}).appendTo(jQuery("#"+tempId));
	jQuery("<font>", {text: questionObject.name, style:"color:#13ab94"}).appendTo(jQuery("#"+tempId));
	jQuery("<span>", {class:"tooltiptext", text:getQuestionType(questionObject.type)}).appendTo(jQuery("#"+tempId));
	jQuery("<input>", {type:"button",style:"float:right", value:"...", onclick:"openLIMenu('"+tempId+"')"}).appendTo(jQuery("#"+tempId));
	//jQuery("<input>", {type:"hidden",class:"object-id", value:"${question.id }"}).appendTo(jQuery("#"+tempId));
	
	attachImageToQuestion(questionObject);
	if(questionObject.type == "option" || questionObject.type == "option-multi-choice"){
		var optionArray = new Array();
		jQuery(".class-options").each(function (){
			var optionObj = {id: "0", name: jQuery(this).find("font").text(), active: "true"};
			questionObject.options.push(optionObj);
			jQuery("<input>", {class: "questionOption", value: jQuery(this).find("font").text(), type:"hidden"}).appendTo(jQuery("#"+tempId));
		});
	}
	getGroupById(groupId).questions.push(questionObject);
	mapGgroup[groupId].questions[tempId] = questionObject;
	
	jQuery(".sortable2").sortable();
	
	resetValues();
	showCustomMenu(tempId);
	jQuery("#auditTypeJson").val(JSON.stringify(groupArray));
	showSaveButton2();
}

function removeOption(optionId){
	jQuery('#'+optionId).remove();
	
	//var qObj = getQuestionFromMap(jQuery("#question-popup").val());
	
	//delete qObj.options;
}
function resetValues(){
	jQuery(".class-options").each(function (){
		jQuery(this).remove();
	});
	jQuery("#question-type").val("textarea");
	jQuery("#question-info").val("required=true");
	jQuery("#new-question-name").val("");
	jQuery("#question-type").trigger("change");
	jQuery("#question-info").trigger("change");
	jQuery("#content").attr("src", "");
	jQuery("#content").replaceWith(jQuery("#content").clone( true ) );
	jQuery("#imageDiv").text("");
	jQuery("#content").val("");
}
function closeQuestionDialog(){
	jQuery("#dialogQuestion").dialog('close');
	resetValues();
}
function closeGroupDialog(){
	jQuery("#dialogGroup").dialog('close');
	jQuery("#new-group-name").val("");
}

function getGroupById(groupId){
	for(var i = 0; i < groupArray.length; i++){
		if(groupArray[i].id == groupId){
			return groupArray[i];
		}
	}
	return null;
}
// custom menu
var focusedObjectMenu = null;
function showCustomMenu(objId){
	var elementObj = jQuery( "#"+objId );
	
	elementObj.contextmenu(function (event) {
		focusedObjectMenu = this;
	    // Avoid the real one
	    event.preventDefault();
	    // Show contextmenu
	    jQuery(".custom-menu").finish().toggle(100).
	    // In the right position (the mouse)
	    css({
	        top: (event.pageY - 100) + "px",
	        left: event.pageX + "px"
	    });
	});
}
// If the document is clicked somewhere
jQuery(document).bind("mousedown", function (e) {
    
    // If the clicked element is not the menu
    if (!jQuery(e.target).parents(".custom-menu").length > 0) {
        // Hide it
        jQuery(".custom-menu").hide(100);
    }
});

// If the menu element is clicked
jQuery(".custom-menu li").click(function(){
    
    // This is the triggered action name
    switch(jQuery(this).attr("data-action")) {
        // A case for each action. Your actions here
        case "remove-question": removeQuestionElement(focusedObjectMenu); break;
        case "edit-question": editQuestion(focusedObjectMenu); break;
        case "third": alert("third"); break;
    }
    // Hide it AFTER the action was triggered
    jQuery(".custom-menu").hide(100);
  });
  function removeQuestionElement(obj){
	  	jQuery(obj).remove();
	  	
		delete getQuestionFromMap(obj);
	  	
  }
  function editQuestion(obj){
	  	var questionObj = getQuestionFromMap(obj);
	  	var parentGroupId = jQuery(obj).attr("parentGroup");
		jQuery("#"+parentGroupId+"-checkbox").prop("checked", true);
		addQuestion();
		jQuery("#create-button").hide();
		jQuery("#edit-button").show();
		
		jQuery("#new-question-name").val(questionObj.name);
		jQuery("#question-type").val(questionObj.type);
		if(questionObj.info.indexOf("required=true") > -1){
			jQuery("#question-info").val("required=true");
		} else {
			jQuery("#question-info").val("required=false");
		}
		jQuery("#question-info").trigger("change");
		if(questionObj.type == "option" || questionObj.type == "option-multi-choice"){
			showAddOption(document.getElementById("question-type"));
			for(var i = 0; i < questionObj.options.length; i++){
				var optionObj = questionObj.options[i];
				addOption(optionObj.name);
			}
		}
		jQuery('#imageDiv').text('');
        jQuery("#imageDiv").show();
        if(jQuery("#img-"+questionObj.id).attr("src") != undefined){
         	jQuery('#imageDiv').prepend(jQuery("<img>", {id:"theImg",style:"height:200px",src:jQuery("#img-"+questionObj.id).attr("src")}));
         	//setTimeout(function (){cropImage();}, 500);
        } 
		
  }
  function editExistingQuestion(){
	  if(validateQuestion() == false){
			return;
		}
	  	var questionObj = getQuestionFromMap(focusedObjectMenu);
	  	questionObj.name = jQuery("#new-question-name").val();
	  	questionObj.type = jQuery("#question-type").val();
	  	questionObj.info = jQuery("#question-info").val();
	  	jQuery("#"+questionObj.id).find("font").text(questionObj.name);
	  	jQuery("#"+questionObj.id).find("tooltiptext").text(getQuestionType(questionObj.type)); 
	  	attachImageToQuestion(questionObj);
	  	if(questionObj.type == "option" || questionObj.type == "option-multi-choice"){
			var optionArray = new Array();
			jQuery(".class-options").each(function (){
				var optionObj = {id: "0", name: jQuery(this).find("font").text(), active: "true"};
				optionArray.push(optionObj);
				jQuery("<input>", {class: "questionOption", value: jQuery(this).find("font").text(), type:"hidden"}).appendTo(jQuery("#"+questionObj.id));
			});
			for(var c = 0; c <  questionObj.options.length; c++){
				questionObj.options[c].active = false;
			}
			for(var i = 0; i < optionArray.length; i++){
				var obje = optionArray[i];
				var addToArray = true;
				for(var c = 0; c <  questionObj.options.length; c++){
					if(obje.name == questionObj.options[c].name){
						addToArray = false;
						questionObj.options[c].active = true;
					}
				}
				if(addToArray){
					questionObj.options.push(obje);
				}
			}
			//questionObj.options = optionArray;
		}
	  	closeQuestionDialog();
  }
function attachImageToQuestion(questionObj){
	questionObj.image = jQuery("#theImg").attr("src");
	var fontSize = "16px";
	if(questionObj.image != undefined){
		jQuery("#"+questionObj.id).find(".questionImg").remove();
	}
	if(questionObj.image != "" && questionObj.image != undefined){
		jQuery("<img>", {class:"questionImg", id:"img-"+questionObj.id, src: questionObj.image, style:"margin-right:15px;float:right; height:"+fontSize+"; width:"+fontSize, onclick:"imageOpenModal(this)"}).appendTo(jQuery("#"+questionObj.id));
	}
	/*	questionObj.cropX = jQuery("#cropX").val();
	questionObj.cropY = jQuery("#cropY").val();
	questionObj.cropW = jQuery("#cropW").val();
	questionObj.cropH = jQuery("#cropH").val();
	
	jQuery("#cropX").val();
	jQuery("#cropY").val();
	jQuery("#cropW").val();
	jQuery("#cropH").val();*/
}
  function getQuestionFromMap(questionElement){
	  return  mapGgroup[jQuery(questionElement).attr("parentGroup")].questions[jQuery(questionElement).attr("id")];
  }
  function validateGroup(){
	  jQuery(".errorMessage").hide();
	  if(jQuery.trim(jQuery("#new-group-name").val()) == ""){
		  jQuery("#group-name-mandatory").show();
		  return false;
	  }
	  return true;
  }
  function validateQuestion(){
	  jQuery(".errorMessage").hide();
	  if(jQuery.trim(jQuery("#new-question-name").val()) == ""){
		  jQuery("#new-question-name-mandatory").show();
		  return false;
	  }
	  if(jQuery.trim(jQuery("#question-type").val()) == ""){
		  jQuery("#question-type-mandatory").show();
		  return false;
	  }
	  
	  if(jQuery("#question-type").val() == "option" || jQuery("#question-type").val() == "option-multi-choice"){
		  if(jQuery(".class-options").length < 1){
			  jQuery("#ul-options-mandatory").show();
			  return false;
		  }
	  }
	  
	  var groupId = jQuery("input:radio[name='radioGroup']:checked").val();
	  for(var i = 0; i < jQuery("li[parentGroup = "+groupId+"]").length ; i++){
		  var o = jQuery("li[parentGroup = "+groupId+"]")[i];
		  if(jQuery(o).find("font").text() == jQuery.trim(jQuery("#new-question-name").val())){
			  alert('<fmt:message key="duplicatedQuestion" />');
			  return false;
		  }
	  }
	  
	  
	  return true;
  }
 function getQuestionType(questionType){
	 if(questionType == "textarea"){
		 return "Text Area";
	 }
	 if(questionType == "option"){
		 return "Option";
	 }
	 if(questionType == "option-multi-choice"){
		 return "Option Multi Choice";
	 }
 }
 
 function imageOpenModal(imgObj){
	 imgObj.onclick = function(){
		    //modal.style.display = "block";
		    jQuery("#myModal").show();
		    jQuery("#img01").attr("src", this.src);
		    //modalImg.src = this.src;
		    //captionText.innerHTML = this.alt;
		}
	 var span = document.getElementsByClassName("close")[0];
	 span.onclick = function() { 
		 jQuery("#myModal").hide();
		}
 }
 function openLIMenu(objId){
	 focusedObjectMenu = jQuery("#"+objId);
	 jQuery(".custom-menu").finish().toggle(100).
	    // In the right position (the mouse)
	    css({
	        top: (focusedObjectMenu.position().top ) + "px",
	        left: (focusedObjectMenu.width() + focusedObjectMenu.position().left + 50) + "px"
	    });
 }
 function showSaveButton2(){
	 var numberOfQuestions = 0;
	 jQuery("#auditQuestionGroups").find(".questionGroup").each(function (){
		 numberOfQuestions++;
		 jQuery(this).find(".scannell-tooltip").each(function (){
			 numberOfQuestions++;
		 });
	 });
	 if(numberOfQuestions > 6){
		 jQuery("#save-button-2").show();
	 }
 }
</script>
</body>
</html>
