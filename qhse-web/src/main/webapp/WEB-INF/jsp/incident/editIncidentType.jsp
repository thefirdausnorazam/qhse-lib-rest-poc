<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>

  	<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
<script type="text/javascript">
String.prototype.inList=function(){
	   return ( list.indexOf(this.toString()) != -1)
	}
function localStorageAvailable() {
    if (typeof(Storage) !== "undefined") {
        return true;
    }
    else {
        return false;
    }
}

jQuery('#checkbox').click(function(){
    if (jQuery('#checkbox').attr('checked')) {
        if (localStorageAvailable())
            localStorage.DoNotShowMessageAgain = "true";
    }
}) 

var newGroupIndex;
var newGroupLabel;
var mandatoryLabel;
var searchableLabel;
var exportableLabel;
var list = ["durationForm",
			"causeCategory","reportable","numberManDaysLost","operatingHoursLost","areaOwner","investigationAppByAreaOwner","areaOwnerComments"];
var investigationFields = "durationFormcauseCategoryreportablenumberManDaysLostoperatingHoursLostareaOwnerinvestigationAppByAreaOwnerareaOwnerComments";
	
	jQuery(document).ready(function() {
		newGroupIndex = 0;

	newGroupLabel = "New Group";
	mandatoryLabel="<fmt:message key='clientQuestionMandatory' />";
	searchableLabel='<fmt:message key="clientQuestionSearchable" />';
	exportableLabel='<fmt:message key="clientQuestionExportable" />';
	
	resetDelete();
		resetSortable();
		resetEditable();

		jQuery("select").select2({width:'60%'});
		 var itemEdit = jQuery('.itemEdit');
		 itemEdit.click(function(){
			 showEditDialog(jQuery(this));
			});
		jQuery("#investigationConfigured").change(function(){ 
		    jQuery("#investigationRow").toggle(this.checked); 
		    jQuery("#investigationOptionalRow").toggle(this.checked); 
		}).change();
		/*jQuery('#applyToApp').change(function () {
		 	var rows = jQuery('table.iType tr');
	        if (!this.checked) {
	        	var appConfig = rows.filter('.appConfig').hide();
	        }
	        else {
	       	 	var appConfig = rows.filter('.appConfig').show();
			}
		});
		jQuery('#applyToApp').change(); */
		//accessControlClick();
		//confidentialClick();
		if('${incidentType.name}' == 'compliance' || '${incidentType.name}' == 'nonconform'){
			jQuery(".checkAccess").attr('disabled', true);
		}
  });
	
  	var list = jQuery('ul');
  	var editList = jQuery('.edit-list');

editList.onclick = function() {
    //or you can use list.setAttribute("contentEditable", true);
    list.contentEditable = true;
}
 
 function showEditDialog(el)
 {
	var li = jQuery(el).parent('li');
	if(li.hasClass('expanded'))
	{
		 li.animate({height:'30px'}, 500);
		 li.removeClass('expanded');
		 li.find('div.checkboxes')[0].style.display='none';
	}
	else
	{
		 li.addClass('expanded');
		 li.animate({height:'100px'}, 500);
		 li.find('div.checkboxes')[0].style.display='';
	}
 }

function addNewGroup(parent) {
	var parentDiv = jQuery("#"+parent);
	var index = parentDiv.find("div.questionGroup").length;
	var a = jQuery("<a>", {href: "#"+parent, title:"delete group", onclick:"deleteGroup('ng"+newGroupIndex+"')", style:"float:right;"}).append("<span class='glyphicon glyphicon-remove'></span>");
	var ul = jQuery("<ul>", {id:"newGroup"+newGroupIndex,  class:"sortable" });
		var div = jQuery("<div>", {id: "ng"+newGroupIndex, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"questionGroup", value:"New Group",  style:"padding-bottom: 60px;"});
		div.append('<input type="text" class="groupName" id="'+parent+'['+index+'].name" name="'+parent+'['+index+'].name" value="'+newGroupLabel+'"/>').append(a);
		div.append(ul);
		jQuery("#"+parent).append(div);
		document.getElementById("ng"+newGroupIndex).scrollIntoView();
		newGroupIndex++;
		resetSortable();
		resetDelete();
		resetEditable();
}

function deleteGroup(group) {
	var g = jQuery("#"+group);
	
	//Return all questions
	jQuery("#"+group+" li").each(function(i)
	{
		var li =  jQuery(this);
    	var icon = jQuery(this).find(".glyphicon");
		var name = li[0].innerText.replace(/X([^X]*)$/,'$1');
		var backgroundColor = '';//'list-group-item-success';
		if(li[0].id.indexOf('InvestigationField') > -1){
			//backgroundColor = 'list-group-item-info';
		}
		// now instead to use a different logic to do the same thing when the user delete any LI of the Question List, now it uses the same logic as we can see in the bellow method
		removeLis(jQuery(this));
		
	});
		
		
	  	//delete group
	jQuery("#"+group).remove();
		resetSortable();
		resetDelete();
}

function highlightDropableDiv(){
		jQuery('.questionGroup').addClass('dropArea');
		if(jQuery('.appendtext').length<=0){
		jQuery('.questionGroup').append('<span class="appendtext" style="color:red"> **Drop on highlighted Area** </span>');
		}
	    setTimeout(function(){
	    	jQuery('.questionGroup').removeClass('dropArea');
	    	jQuery(".appendtext").remove();
	    }, 6000);
		
	 }

function allowDrop(ev) {
	if (ev.preventDefault) {
		ev.preventDefault();
	}

    if (ev.target.getAttribute("draggable") == "true"){
        ev.dataTransfer.dropEffect = "none"; // dropping is not allowed
    } 
    else if (ev.target.getAttribute("class") == "groupName"){
        ev.dataTransfer.dropEffect = "none"; // dropping is not allowed
    }
    else {
        ev.dataTransfer.dropEffect = "all"; // drop it like it's hot

    }
}

function drag(ev) {
	if(ev != undefined)
	{
    	ev.dataTransfer.setData("text", ev.target.id);
	}
}

function resetEditable()
{
	jQuery('.edit-on-click').click(function() {
		    var $text = jQuery(this),
		      $input = $('<input type="text" />')

		    $text.hide()
		      .after($input);

		    $input.val($text.html()).show().focus()
		      .keypress(function(e) {
		        var key = e.which
		        if (key == 13) // enter key
		        {
		          $input.hide();
		          $text.html($input.val())
		            .show();
		          $text.attr("value", $input.val());
		          $text.parent().parent().attr("value", $input.val());
		          return false;
		        }
		      })
		      .focusout(function() {
		        $input.hide();
		        $text.show();
		      })
		  });	
}

function resetDelete()
{
	jQuery('.sortable').on('click', '.itemDelete', function() {
		removeLis(jQuery(this).closest('li'));
	  	});
}
// I isolated this method from the runtime function above because it became easier to be used in many places dont needing to duplicate code
function removeLis(li){
	var icon = li.find(".glyphicon");
	li.find('div.checkboxes').remove();
		var type = li.find('.questionType').val();
		var qid = jQuery("#"+li[0].id).find(".questionQuestionId").val();
		if(qid != "" && qid != "0")
		{
    	var qid = jQuery("#"+li[0].id).find(".questionQuestionId").val();
	  		var url=contextPath + '/client/findTemplateQuestion.json?questionId='+qid;
	    jQuery.getJSON(url, function(question) {
	    	var str = "<li id='ClientQuestion-"+question.id+"' draggable='true' ondragstart='drag(event);' ondrop='drop(event)' ondragover='allowDrop(event)' class='question list-group-item  list-group-item-warning' >";
	    	str = str + "<input type='hidden' class='mandatory' value='"+question.mandatory+"'/><input type='hidden' class='questionType' value='"+question.optionType+"'/>&nbsp;"+icon[0].outerHTML;
			if(icon[1]) {
				li.append(icon[1].outerHTML);
			}
			str = str + "&nbsp;" + question.name;
			
			if(question.mandatory)
				str = str + "<span class='requiredHinted'>*</span>"
				
			str = str + "</li>";
	    	jQuery("#clientQuestionsList").append(str);
	    }); 
		}
		else
		{
			var name = jQuery("#"+li[0].id).find(".questionQuestionName").val();
			var type = "IncidentField-";
			var colour = "list-group-item-success";
			if(investigationFields.indexOf(name) >= 0) {
				type = "InvestigationField-";
				colour = "list-group-item-info";
			}
		var icon = li.find(".glyphicon");
    	var str = "<li id='"+type+name+"' draggable='true' ondragstart='drag(event);' ondrop='drop(event)' ondragover='allowDrop(event)' class='question list-group-item  "+colour+"' >";
    	str = str + "<input type='hidden' class='mandatory' value='false'/>&nbsp;"+icon[0].outerHTML;
    	if(icon[1]) {
			li.append(icon[1].outerHTML);
		}
    	
		str = str + "&nbsp;" + li[0].innerText + "</li>";
			jQuery("#commonQuestionsList").append(str);
		}
		li.remove();
}

function resetSortable()
{
	jQuery( ".sortable" ).sortable({
	      revert: true,
	      stop: function(event, ui) {
	          if(!ui.item.data('tag') && !ui.item.data('handle')) {
	              ui.item.data('tag', true);
	              ui.item.fadeTo(400, 0.1);
	          }
	      },
	      sort: function () {
	            // gets added unintentionally by droppable interacting with sortable
	            // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
	            jQuery(this).removeClass("ui-state-default");
	        },
	        over: function () {
	            removeIntent = false;
	        },
	        out: function () {
	            removeIntent = true;
	        },
	        beforeStop: function (event, ui) {
	            if(removeIntent == true){
	                ui.item.remove();   
	            }
	        }

	    });
  	jQuery( ".sortable" ).disableSelection();
}

function drop(ev, element) {
    ev.preventDefault();
    jQuery(this).find('.groupName').blur(); 
    var data = ev.dataTransfer.getData("text");
    if(element.parentElement.id == "investigationQuestionGroups" && data.indexOf("IncidentField") == 0)
    {
    	alert("Incident Fields cannot be added to investigation");
    	return;
    }

    if(element.parentElement.id == "incidentQuestionGroups" && data.indexOf("InvestigationField") == 0)
    {
    	alert("Investigation Fields cannot be added to incident");
    	return;
    }
    var dataObject = document.getElementById(data);
    if(dataObject === undefined || dataObject == null)
    {
    	return;
    }
    var list = ev.target.getElementsByTagName("ul");
    if(list.length > 0)
    {
    	//Get Manadatory
    	var mandatory = "";
    	var questionName = null;
    	var questionId = null;
    	if(jQuery("#"+dataObject.id).find(".mandatory").val() == "true" || jQuery("#"+dataObject.id).find(".mandatory").val() == "on") {
    		mandatory = "checked";
    		//remove the * after dropped
    		$("#" + data).children(".requiredHinted").remove();
    	}
    	
    	var questionType = jQuery("#"+dataObject.id).find(".questionType").val();
    	var icon = jQuery("#"+dataObject.id).find(".glyphicon");
	    jQuery("#"+dataObject.id).remove();
		for (var i = 0; i < list.length; i++) {
			var name = dataObject.innerText.replace(/X([^X]*)$/,'$1');
			var li = jQuery("<li>", {id: dataObject.id, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"question list-group-item", ondragstart:'drag(event);'}).append('&nbsp;&nbsp;&nbsp;&nbsp;').append(icon[0]);
			if(icon[1]) {
				li.append(icon[1]);
			}
			li.append(name).append("<a href='#"+element.id+"' title='delete' class='itemDelete' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a>&nbsp;<a title='edit' class='itemEdit' onclick='showEditDialog(this);' style='float:right;padding-right:2%;'><span class='glyphicon glyphicon-pencil'></span></a>");
			var idName = jQuery('#'+list[i].id).siblings()[0].name.replace('.name','').replace('.id','');
  	  		var partsOfStr = dataObject.id.split('-');
  	  		jQuery("#"+list[i].id).append(li);
  	  		var index = jQuery('#'+dataObject.id).index();
  	  		var params1;
  	  		if(partsOfStr[0] == 'IncidentField' || partsOfStr[0] == 'InvestigationField') {
  	  			questionName = partsOfStr[1];
	  	  		params1 = '<input type="hidden" class="questionQuestionId" name="'+idName+'.questions['+index+'].questionId" value="0"/><input type="hidden" class="questionQuestionName" name="'+idName+'.questions['+index+'].questionName" value="'+partsOfStr[1]+'"/>';
  	  		}
  	  		else {
  	  			questionId = partsOfStr[1];
  	  			params1 = '<input type="hidden" class="questionQuestionId" name="'+idName+'.questions['+index+'].questionId" value="'+partsOfStr[1]+'"/>';
  	  		}
		    
  	  		var params2 = '<input style="display:none" type="text" class="questionOrder" name="${groupName}.questions[${questionIndex}].questionOrder"/><input type="hidden" class="questionType" name="'+idName+'.questions['+index+'].type" value="'+partsOfStr[0]+'"/>';
  	  		var checkboxDiv = '<div class="checkboxes" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionMandatory" name="'+idName+'.questions['+index+'].mandatory" '+mandatory+'/> Mandatory<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionSearchable" name="'+idName+'.questions['+index+'].searchable" id="'+idName+'.questions['+index+'].searchable"/> Searchable<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionExportable" name="'+idName+'.questions['+index+'].exportable" id="'+idName+'.questions['+index+'].exportable"/> Exportable</div>';
  	  		if(questionType == "QuestionAnswerType[checkbox]") {
	  	  		checkboxDiv = '<div class="checkboxes" style="display:none"><input type="hidden" class="questionMandatory" name="'+idName+'.questions['+index+'].mandatory" value="false"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionSearchable" name="'+idName+'.questions['+index+'].searchable" id="'+idName+'.questions['+index+'].searchable"/> Searchable<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionExportable" name="'+idName+'.questions['+index+'].exportable" id="'+idName+'.questions['+index+'].exportable"/> Exportable</div>';
  	  		}
	  	  	var url1=contextPath + '/client/findTemplateQuestionSettings.json?questionId='+questionId+'&questionName='+questionName;
	  	  	jQuery.getJSON(url1, function(question) {
		    	document.getElementById(idName+'.questions['+index+'].searchable').checked = question.searchable;
		    	document.getElementById(idName+'.questions['+index+'].exportable').checked = question.exportable;
		    }); 
  	  		li.attr("draggable","true");
  	  		jQuery("#"+dataObject.id).prepend(params1).append(params2).append(checkboxDiv);
		}
		resetSortable();
    }
	document.getElementById(dataObject.id).scrollIntoView();
}

function prepareGroups()
{
	updateGroup('incidentQuestionGroups', 'incident');
	updateGroup('investigationQuestionGroups', 'investigation');
}
<%-- This method check if departmet is selected or not if not selected cancel submit
If Assigned to is mandatory but this field is not configured again cancel the submit. 
If everything is in order prepareGroups and sbumit form--%>
function checkBeforeSubmitConditions(){
	
	jQuery(jQuery('.table')).block();
	jQuery(jQuery('.changeTemplateQuestionPanel')).block();
	var departmentCancelSubmit = true; // If Department is not selected do not submit
	var assignedToCancelSubmit = true;// If Assigned To is made mandatory but not configured do not submit
	jQuery('#incidentQuestionGroups .questionGroup').each(function(){

	    jQuery(this).find('li').each(function(){
	    	if('IncidentField-department' == this.id || jQuery(this).text().replace("Mandatory",'').replace("Searchable",'').replace('Exportable','').trim()=='Department'){
	    		departmentCancelSubmit = false;
	    	}
	    	if('IncidentField-assignees' == this.id || jQuery(this).text().replace("Mandatory",'').replace("Searchable",'').replace('Exportable','').trim()=='Assigned to'){
	    		assignedToCancelSubmit = false;
	    	}
	    });

	});
	if(departmentCancelSubmit==true){
		jQuery("#incidentType").submit(function( event ) {
			jQuery("#dialog").dialog({dialogClass: "no-close",draggable: false,
					  buttons: [
					            {
					              text: "Close",
					              click: function() {
					            	  jQuery(".ui-dialog-content").dialog("close");
					              }
					            }
					          ]});
			event.preventDefault();
			jQuery('#incidentType').unbind('submit');
			return false;
		});
		jQuery(jQuery('.table')).unblock();
		jQuery(jQuery('.changeTemplateQuestionPanel')).unblock();
		return;
	}
	
	if(assignedToCancelSubmit==true && jQuery('input[name="assignedMandatory"]').is(":checked")){
		jQuery("#incidentType").submit(function( event ) {
			jQuery("#dialogAssignedTo").dialog({dialogClass: "no-close",draggable: false,
					  buttons: [
					            {
					              text: "Close",
					              click: function() {
					            	  jQuery(".ui-dialog-content").dialog("close");
					              }
					            }
					          ]});
			event.preventDefault();
			jQuery('#incidentType').unbind('submit');
			return false;
		});
		jQuery(jQuery('.table')).unblock();
		jQuery(jQuery('.changeTemplateQuestionPanel')).unblock();
		return;
	}
	
	<%--Everything ok, now prepare group for sumit --%>
	prepareGroups();
	jQuery('#submit-button').hide();
	jQuery('#submit-button').parent().prepend('<button  class="g-btn g-btn--primary"  ><fmt:message key="submit" /></button>');
}
function updateGroup(gName, gSize)
{
	var rows = jQuery('#'+gName+' .questionGroup');
	jQuery('#'+gSize+'Size').val(rows.length);
	var index = 0;
	jQuery('#'+gName+' .questionGroup').each(function(){
		var qrows = jQuery(this).find('li').length;
		jQuery('<input/>').attr({
		    type: 'hidden',
		    name: gSize+"["+index+"]Size",
		    value : qrows
		}).appendTo('form');
		var groupName=gName+"["+index+"].";
		jQuery(this).find('.groupId').attr("name",groupName+"id");
		jQuery(this).find('.groupName').attr("name",groupName+"name");
		var qindex = 0;
	    jQuery(this).find('li input[name$=".questionOrder"]').each(function(){jQuery(this).val(qindex+'');qindex++;});
	    qindex = 0;
	    jQuery(this).find('li').each(function(){
	    	var questionName=groupName+"questions["+qindex+"].";
			jQuery(this).find('.questionId').attr("name",questionName+"id");
			jQuery(this).find('.questionQuestionId').attr("name",questionName+"questionId");
			jQuery(this).find('.questionQuestionName').attr("name",questionName+"questionName");
			jQuery(this).find('.questionType').attr("name",questionName+"type");
			jQuery(this).find('.questionOrder').attr("name",questionName+"questionOrder");
			jQuery(this).find('.questionMandatory').attr("name",questionName+"mandatory");
			jQuery(this).find('.questionSearchable').attr("name",questionName+"searchable");
			jQuery(this).find('.questionExportable').attr("name",questionName+"exportable");
			qindex++;
	    });

	    index++;
	});
}
var loadingPage = true;
function accessControlClick(){
    if (jQuery(".checkAccess").is(':checked')) {
    	//jQuery(".checkConfidential").prop('checked', false);
        //jQuery(".checkConfidential").attr('disabled', true);
        //jQuery(".confidentialText").show();
        showInfoAccessControlAndConfidential('<fmt:message key="infoIncidentAccessControl" />');
      } else {
    	  //jQuery(".checkConfidential").attr('disabled', false);
    	  //jQuery(".confidentialText").hide();
      }
}

function confidentialClick(){
    if (jQuery(".checkConfidential").is(':checked')) {
    	showInfoAccessControlAndConfidential('<fmt:message key="infoIncidentConfidential" />');
        jQuery("#confidentialAttachments").val("true");
        jQuery("#confidentialAttachmentsDisabled").prop('checked', true);
      } else {
    	  jQuery("#confidentialDescription").prop('checked', false);
    	  jQuery("#confidentialPeopleInvolved").prop('checked', false);
    	  jQuery("#confidentialAttachmentsDisabled").prop('checked', false);
    	  jQuery("#confidentialAttachments").val("false");
      }
}
function showInfoAccessControlAndConfidential(infoMessage){
	alert(infoMessage);
	
}
</script>
<style type="text/css">
	td.searchLabel {
		padding-left: 0px !important;
		padding-right: 5%!important;
	}
	.groupName {
		background-color: #F6F6F6;
		border: 1px solid rgba(0,0,0,0);
		width: 90%;
		color:#13ab94;
		font-size: 150%;
	}
	.groupName:focus {
		border: 1px solid;
	}
	.questionGroup {
		display: inline-block;
		padding-bottom: 100px;	
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
</style>

<style type="text/css" media="all">
		.sortable { list-style-type: none; margin: 0; padding: 0; }
		.sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }		
		.list-group li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
</style>
 
<title></title>
</head>
<body>
<div class="header">
<h3><fmt:message key="editIncidentType" />: <fmt:message key="${incidentType.key}" /></h3>
</div>
<scannell:form id="incidentType">
<scannell:hidden path="id" />
<scannell:hidden path="version" />
<input type="hidden" id="incidentSize" name="incidentSize" value="" />
<input type="hidden" id="investigationSize" name="investigationSize" value="" />

<div class="content">
<div class="table-responsive">

<div class="content">
		<div class="table-responsive">	
			<div class="panel changeTemplatePanel">
				<table class="table table-bordered table-responsive iType">
				<tbody>
				
  <tr class="form-group">
    <td class="searchLabel" style="vertical-align: top"><fmt:message key="active" />:</td>
    <td class="search">
            <div class="checkbox" style="padding-left:25px;"><scannell:checkbox id="active" path="active" /></div></td>
  </tr>
  <tr class="form-group">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="singleAssign" /></td>
  <td class="search" style="width:50%">
 	 <spring:bind path="command.singleAssignable">
   		<c:set var="selected" value="${command.singleAssignable}" />
     	<input type="checkbox" name="singleAssignable"  <c:if test="${selected}">checked="checked"</c:if> />
     </spring:bind>
  </td>
</tr> 

<tr>
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="assignedMandatory" /></td>
  <td class="search" >
 	 <spring:bind path="command.assignedMandatory">
   		<c:set var="selected" value="${command.assignedMandatory}" />
     	<input type="checkbox" name="assignedMandatory"  <c:if test="${selected}">checked="checked"</c:if> />
     </spring:bind>
  </td>
</tr> 

<tr class="form-group">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="accessLevel" /></td>
  <td class="search" >
 	 <spring:bind path="command.incidentTypeAccessControl">
   		<c:set var="selected" value="${command.incidentTypeAccessControl}" />
     	<input type="checkbox" name="incidentTypeAccessControl" class="checkAccess"  <c:if test="${selected}">checked="checked"</c:if> onclick="accessControlClick();" /><span class="appendtext accessText" style="color:red;padding-left: 20px">  </span>
     </spring:bind>
  </td>
</tr>
 
<tr class="form-group">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="confidential" /> (<c:out value="${command.confidential.site}" />)</td>
  <td class="search" >
 	 <spring:bind path="command.confidential">
   		<c:set var="selected" value="${command.confidential.confidential}" />
     	<input type="checkbox" name="confidential" class="checkConfidential"  <c:if test="${selected}">checked="checked"</c:if>  onclick="confidentialClick()"/><span class="appendtext confidentialText" style="color:red;padding-left: 20px"> </span>
     </spring:bind>
  </td>
</tr>
  
<tr class="form-group">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="confidentialControlView" /> </td>
  <td class="search" >
     <div >
      	 <spring:bind path="command.confidentialDescription">
	   		<c:set var="selected" value="${command.confidentialDescription}" />
	     	<input type="checkbox" name="confidentialDescription" id="confidentialDescription"  <c:if test="${selected}">checked="checked"</c:if> /><span><fmt:message key="incident.confidentialDescription" /></span><br />
     	 </spring:bind>
	     <spring:bind path="command.confidentialPeopleInvolved">
	   		<c:set var="selected" value="${command.confidentialPeopleInvolved}" />
	     	<input type="checkbox" name="confidentialPeopleInvolved" id="confidentialPeopleInvolved" <c:if test="${selected}">checked="checked"</c:if> /><span><fmt:message key="incident.confidentialPeopleInvolved" /></span><br />
	     </spring:bind>
      	 <spring:bind path="command.confidentialAttachments">
	   		<c:set var="selected" value="${command.confidentialAttachments}" />
	   		<input type="hidden" name="confidentialAttachments" id="confidentialAttachments"  value="${selected}"/>
	     	<input type="checkbox" name="xxx" id="confidentialAttachmentsDisabled"  <c:if test="${selected}">checked="checked"</c:if> disabled/><span><fmt:message key="incident.confidentialAttachments" /></span><br />
	     </spring:bind>
     </div>
  </td>
</tr> 
  	<tr class="form-group">
  		<td class="searchLabel" style="vertical-align: top"><fmt:message key="autoClose" /></td>
  		<td class="search" style="width:50%">
		 	 <spring:bind path="command.autoClose">
		   		<c:set var="selected" value="${command.autoClose}" />
		     	<input type="checkbox" name="autoClose"  <c:if test="${selected}">checked="checked"</c:if> />
		     </spring:bind>
  		</td>
	</tr> 
 <tr  class="form-group">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="incident.allowAttachments" /></td>
  <td class="search" >
 	 <spring:bind path="command.attachmentsConfigured">
   		<c:set var="selected" value="${command.attachmentsConfigured}" />
     	<input type="checkbox" id="attachmentsConfigured" name="attachmentsConfigured"  <c:if test="${selected}">checked="checked"</c:if> />
     </spring:bind>
  </td>
</tr>
<%-- <tr class="form-group">
  <td class="searchLabel" style="vertical-align: top">Apply to App</td>
  <td class="search" >
 	 <spring:bind path="command.attachmentsConfigured">
   		<c:set var="selected" value="${command.attachmentsConfigured}" />
     	<input type="checkbox" id="applyToApp" />
     </spring:bind>
  </td>
</tr> --%>
<tr class="form-group appConfig" style="display:none;background-color:grey">
	  <td class="searchLabel" style="vertical-align: top">App <fmt:message key="quickLink.label" /></td>
	  <td class="search" >
	 	 <input class="form-control" style="width:60%" placeholder="Enter 3-18 characters"/>
	          <span class="requiredHinted">*</span>
	  </td>
  </tr>
<tr class="form-group appConfig" style="display:none;">
	  <td class="searchLabel" style="vertical-align: top">
				App Icon <fmt:message key="quickLink.colour" />
		</td>
		<td class="search" >
				<select >
<%-- 					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Red')}" >selected</c:if> value="red"><fmt:message key="redIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Orange')}" >selected</c:if> value="orange"><fmt:message key="orangeIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Blue')}" >selected</c:if> value="blue"><fmt:message key="blueIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Green')}" >selected</c:if> value="green"><fmt:message key="greenIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Purple')}" >selected</c:if> value="purple"><fmt:message key="purpleIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Plum')}" >selected</c:if> value="plum"><fmt:message key="plumIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Cyan')}" >selected</c:if> value="cyan"><fmt:message key="cyanIcon" /></option> --%>
					<option value="red"><fmt:message key="redIcon" /></option>
					<option value="orange"><fmt:message key="orangeIcon" /></option>
					<option value="blue"><fmt:message key="blueIcon" /></option>
					<option value="green"><fmt:message key="greenIcon" /></option>
					<option value="purple"><fmt:message key="purpleIcon" /></option>
					<option value="plum"><fmt:message key="plumIcon" /></option>
					<option value="cyan"><fmt:message key="cyanIcon" /></option>
				</select>
	          <span class="requiredHinted">*</span>
		</td>
</tr>
<tr class="form-group appConfig" style="display:none;">
	  	<td class="searchLabel" style="vertical-align: top">
				App Icon <fmt:message key="quickLink.symbol" />
		</td>
		<td class="search" >
				<div class="btn-group radio-btns-wrapper" data-toggle="buttons" style="float:left;width:90%">
					  <label class="g-btn g-btn--primary radioButton" id="pencil">
					    <input type="radio" name="options" autocomplete="off" value="pencil"> <span  class="fa fa-pencil unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="home">
					    <input type="radio" name="options" autocomplete="off" value="home"> <span  class="fa fa-home unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="flag">
					    <input type="radio" name="options" autocomplete="off" value="flag"> <span  class="fa fa-flag unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="user">
					    <input type="radio" name="options" autocomplete="off" value="user"> <span  class="fa fa-user unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="comment">
					    <input type="radio" name="options" autocomplete="off" value="comment"> <span  class="fa fa-comment unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="comments">
					    <input type="radio" name="options" autocomplete="off" value="comments"> <span  class="fa fa-comments unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="comment-o">
					    <input type="radio" name="options" autocomplete="off" value="comment-o"> <span  class="fa fa-comment-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="comments-o">
					    <input type="radio" name="options" autocomplete="off" value="comments-o"> <span  class="fa fa-comments-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="file">
					    <input type="radio" name="options" autocomplete="off" value="file"> <span  class="fa fa-file unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="file-o">
					    <input type="radio" name="options" autocomplete="off" value="files-o"> <span  class="fa fa-files-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="file-excel-o">
					    <input type="radio" name="options" autocomplete="off" value="file-excel-o"> <span  class="fa fa-file-excel-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="file-pdf-o">
					    <input type="radio" name="options" autocomplete="off" value="file-pdf-o"> <span  class="fa fa-file-pdf-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="file-image-o">
					    <input type="radio" name="options" autocomplete="off" value="file-image-o"> <span  class="fa fa-file-image-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="tag">
					    <input type="radio" name="options" autocomplete="off" value="tag"> <span  class="fa fa-tag unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bell">
					    <input type="radio" name="options" autocomplete="off" value="bell"> <span  class="fa fa-bell unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bookmark">
					    <input type="radio" name="options" autocomplete="off" value="bookmark"> <span  class="fa fa-bookmark unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="star">
					    <input type="radio" name="options" autocomplete="off" value="star"> <span  class="fa fa-star unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="plus">
					    <input type="radio" name="options" autocomplete="off" value="plus"> <span  class="fa fa-plus unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="asterisk">
					    <input type="radio" name="options" autocomplete="off" value="asterisk"> <span  class="fa fa-asterisk unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="thermometer-quarter">
					    <input type="radio" name="options" autocomplete="off" value="thermometer-quarter"> <span  class="fa fa-thermometer-quarter unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="thermometer-4">
					    <input type="radio" name="options" autocomplete="off" value="thermometer-4"> <span  class="fa fa-thermometer-4 unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="warning">
					    <input type="radio" name="options" autocomplete="off" value="warning"> <span  class="fa fa-warning unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="calendar">
					    <input type="radio" name="options" autocomplete="off" value="calendar"> <span  class="fa fa-calendar unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="folder-open">
					    <input type="radio" name="options" autocomplete="off" value="folder-open"> <span  class="fa fa-folder-open unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="thumbs-up">
					    <input type="radio" name="options" autocomplete="off" value="thumbs-up"> <span  class="fa fa-thumbs-up unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="dashboard">
					    <input type="radio" name="options" autocomplete="off" value="dashboard"> <span  class="fa fa-dashboard unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="wrench">
					    <input type="radio" name="options" autocomplete="off" value="wrench"> <span  class="fa fa-wrench unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="medkit">
					    <input type="radio" name="options" autocomplete="off" value="medkit"> <span  class="fa fa-medkit unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="heartbeat">
					    <input type="radio" name="options" autocomplete="off" value="heartbeat"> <span  class="fa fa-heartbeat unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="plus-square">
					    <input type="radio" name="options" autocomplete="off" value="plus-square"> <span  class="fa fa-plus-square unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="floppy-saved">
					    <input type="radio" name="options" autocomplete="off" value="edit"> <span  class="fa fa-edit unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bookmark-o">
					    <input type="radio" name="options" autocomplete="off" value="bookmark-o"> <span  class="fa fa-bookmark-o unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bug">
					    <input type="radio" name="options" autocomplete="off" value="bug"> <span  class="fa fa-bug unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bullhorn">
					    <input type="radio" name="options" autocomplete="off" value="bullhorn"> <span  class="fa fa-bullhorn unchecked"></span>
					  </label>
					  <label class="g-btn g-btn--primary radioButton" id="bullseye">
					    <input type="radio" name="options" autocomplete="off" value="bullseye"> <span  class="fa fa-bullseye unchecked"></span>
					  </label>
				</div>
	          <span class="requiredHinted">*</span>
			</td>
	</tr>
<tr class="form-group">
    <td class="search" colspan="2" style="vertical-align: top">
    	<div class="panel-group accordion accordion-semi incidentQuestionGroups" id="accordion8">
    		<div class="acc-panel-heading">
				<h4 class="panel-title ui-state-active">
    				<a class="collapsed acc panelHover" data-toggle="collapse" data-parent="#accordion8" href="#acc8">
											<i class="fa fa-angle-right"></i><fmt:message key="incident.fields" />:</a>
				</h4>
    	<div id="acc8" class="panel-collapse collapse out" >
    	<div class="table-responsive">
		<div class="panel panel-body">
	      <a ref='#' title='changeTemplate.addNewGroup' onclick='addNewGroup("incidentQuestionGroups")' style='float:right;'><fmt:message key="changeTemplate.addNewGroup"/></a></br>
	      
      				<spring:bind path="command.incidentQuestionGroups">
      		<div id="incidentQuestionGroups"  style="height:100%;width:100%">
      			<c:if test="${!empty command.incidentQuestionGroups}">
	      			<c:forEach var="group" items="${command.incidentQuestionGroups}" varStatus="s">
						<c:set var="groupDiv" value="g${group.id}"/>
						<div id="${groupDiv}" class="questionGroup" ondrop="drop(event, this)" ondragover="allowDrop(event)" style="padding-bottom: 60px;">							
							<scannell:input cssStyle="display:none" class="groupId" path="incidentQuestionGroups[${s.index}].id"
										id="incidentQuestionGroups[${s.index}].id" />
							<input type="text" class="groupName" id="incidentQuestionGroups[${s.index}].name"  name="incidentQuestionGroups[${s.index}].name" value="${group.name}"/>
									
							<a href='#incidentQuestionGroups' title='delete group' onclick='deleteGroup("${groupDiv}")' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a>					             
							<ul id="group${group.id}" class="sortable list-group" >
							<c:forEach var="templateQuestion" items="${group.activeQuestions}" varStatus="loop">
								<client:clientTemplateQuestion  templateQuestion="${templateQuestion}" groupName="incidentQuestionGroups[${s.index}]" questionIndex="${loop.index}"/>
						 	</c:forEach>
						    </ul>
						</div>
			         </c:forEach>
		         </c:if>
      		</div>
			         </spring:bind>
      </div></div>
      </div>
      </div>
      </div>
    </td>
  </tr>
  
 <tr>
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="investigation" /></td>
  <td class="search" >
 	 <spring:bind path="command.investigationConfigured">
   		<c:set var="selected" value="${command.investigationConfigured}" />
     	<input type="checkbox" id="investigationConfigured" name="investigationConfigured"  <c:if test="${selected}">checked="checked"</c:if> />
     </spring:bind>
  </td>
</tr>
 <tr id="investigationOptionalRow" style="display:none">
  <td class="searchLabel" style="vertical-align: top"><fmt:message key="incident.investigationOptional" /></td>
  <td class="search" >
 	 <spring:bind path="command.investigationOptional">
   		<c:set var="selected" value="${command.investigationOptional}" />
     	<input type="checkbox" id="investigationOptional" name="investigationOptional"  <c:if test="${selected}">checked="checked"</c:if> />
     </spring:bind>
  </td>
</tr>
<tr>
  <td class="searchLabel" style="vertical-align: top" colspan="2"></td>
</tr>

  <tr id="investigationRow" class="form-group" style="display:none">
    <td class="search" colspan="2" style="vertical-align: top">
    	<div class="panel-group accordion accordion-semi investigationQuestionGroups" id="accordion9">
    		<div class="acc-panel-heading">
				<h4 class="panel-title ui-state-active">
    				<a class="collapsed acc panelHover" data-toggle="collapse" data-parent="#accordion9" href="#acc9">
											<i class="fa fa-angle-right"></i><fmt:message key="investigation.fields" />:</a>
				</h4>
    	<div id="acc9" class="panel-collapse collapse out" >
    		<div class="table-responsive">
				<div class="panel panel-body">
	      		<a ref='#' title='changeTemplate.addNewGroup' onclick='addNewGroup("investigationQuestionGroups")' style='float:right;'><fmt:message key="changeTemplate.addNewGroup"/></a></br>
	      		
      				<spring:bind path="command.investigationQuestionGroups">
					<div id="investigationQuestionGroups"  style="height:100%;width:100%">
						<c:if test="${!empty command.investigationQuestionGroups}">
			      			<c:forEach var="group" items="${command.investigationQuestionGroups}" varStatus="s">
								<c:set var="groupDiv" value="g${group.id}"/>
								<div id="${groupDiv}" class="questionGroup" ondrop="drop(event, this)" ondragover="allowDrop(event)"  style="padding-bottom: 60px;">							
									<scannell:input cssStyle="display:none" class="groupId" path="investigationQuestionGroups[${s.index}].id"
												id="investigationQuestionGroups[${s.index}].id" />
									<input type="text" class="groupName" id="incidentQuestionGroups[${s.index}].name"  name="investigationQuestionGroups[${s.index}].name" value="${group.name}"/>
											
									<a href='#investigationQuestionGroups' title='delete group' onclick='deleteGroup("${groupDiv}")' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a>					             
									<ul id="group${group.id}" class="sortable list-group" >
									<c:forEach var="templateQuestion" items="${group.activeQuestions}" varStatus="loop">
										<client:clientTemplateQuestion  templateQuestion="${templateQuestion}" groupName="investigationQuestionGroups[${s.index}]" questionIndex="${loop.index}"/>
								 	</c:forEach>
								    </ul>
								</div>
					         </c:forEach>
				         </c:if>
					</div>
					</spring:bind>
      			</div>
      		</div>
      	</div>
      	</div>
      	</div>
     </td>
  </tr>
				</tbody>
				<tfoot>
  <tr>
    <td colspan="2" align="center">
    	<input type="submit" id="submit-button" class="g-btn g-btn--primary" value="<fmt:message key="submit" />" onclick="checkBeforeSubmitConditions();">
	    <button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
    </td>
  </tr>
</tfoot>
				</table>
		</div>
	</div>
	<div class="changeTemplateQuestionPanel" style="width:20%;position:fixed;left:70%;top:30%">
				<div class="panel-group accordion accordion-semi"  id="accordion2" style="height:50%;">
					<div class="panel-heading">
						<h4 class="panel-title ui-state-active">
							<a class="collapsed acc panelHover" data-toggle="collapse" data-parent="#accordion2" href="#client0">
								<i class="fa fa-angle-right"></i>
								<fmt:message key="changeTemplateClientCommonQuestions" />
							</a>
						</h4>
					</div> 
					<div id="client0" class="panel-collapse collapse out">
						<div id="clientQuestions" class="panel-body">
							<ul id="clientQuestionsList" class="list-group"  style="height:200px;overflow: auto !important">
								<c:forEach var="cQuestion" items="${clientQuestions}">
									<client:clientQuestion question="${cQuestion}"/>
					            </c:forEach>
				            </ul>
				      	</div>
					</div>
				</div>
				<div class="panel-group accordion accordion-semi"  id="accordion3" style="height:50%;">
					<div class="panel-heading">
						<h4 class="panel-title ui-state-active">
							<a class="collapsed acc panelHover" data-toggle="collapse" data-parent="#accordion3" href="#common1">
								<i class="fa fa-angle-right"></i>
								<fmt:message key="incidentTemplateEnviroMANAGERCommonQuestions" />
							</a>
						</h4>
					</div> 
					<div id="common1" class="panel-collapse collapse out">
						<div class="panel-body">
							<ul id="commonQuestionsList" class="list-group"  style="height:200px;overflow: auto !important">
								<c:forEach var="question" items="${commonQuestions}">
					             	<client:displayQuestion question="${question}"/>
					            </c:forEach>
					            <c:forEach var="field" items="${remainingFields}">
					            	<c:if test="${field.name != 'investigation' && field.name != 'attachments' && field.name != 'investigationOptional'}">
					            		<client:questionField type="IncidentField" name="${field.name}" fieldType="${field.fieldType}"/>
									</c:if>
					            </c:forEach>
					            <c:forEach var="invfield" items="${remainingInvestigationFields}">
					            	<client:questionField type="InvestigationField" name="${invfield}" fieldType=""/>
					            </c:forEach>
				            </ul>
				      	</div>
				    </div>
				</div>
			</div>
			</div>
</div>
</div>
<div id="dialog" title="Department is mandatory" style="display:none">
  <p><fmt:message key="department.missing" /></p>
</div>
<div id="dialogAssignedTo" title="Assigned To" style="display:none">
  <p><fmt:message key="assigendTo.missing" /></p>
</div>
</scannell:form>


</body>
</html>
