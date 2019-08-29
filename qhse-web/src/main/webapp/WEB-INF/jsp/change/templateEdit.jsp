<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="change" tagdir="/WEB-INF/tags/change" %>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="changeTemplateEdit" />
	<c:if test="${command.id == 0}">
		<c:set var="title" value="changeTemplateCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/change.css'/>";
		.sortable { list-style-type: none; margin: 0; padding: 0; }
		.sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
		.sortable li span { position: absolute; margin-left: -1.3em; }
		
		.list-group li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
	</style>
  	<script>
		var newGroupIndex;
		var newGroupLabel;
		
	  	jQuery(document).ready(function() {
	  		newGroupIndex = 0;
			newGroupLabel = "<fmt:message key='auditTemplateQuestion.newGroup'/>";
			
			resetDelete();
 	  		resetSortable();
 	  		resetEditable();
		  });
	  	
		  	var list = jQuery('ul');
		  	var editList = jQuery('.edit-list');
	
		  	editList.onclick = function() {
		    //or you can use list.setAttribute("contentEditable", true);
		    list.contentEditable = true;
		}

		function addNewGroup(parent) {
			var parentDiv = jQuery("#"+parent);
			var a = jQuery("<a>", {href: "#", title:"delete group", onclick:"deleteGroup('ng"+newGroupIndex+"')", style:"float:right;"}).append("X");
			var h2 = jQuery("<h2>", {class:"list-group-item-heading"}).append('<span class="edit-on-click">'+newGroupLabel+'</span>').append(a);
			var ul = jQuery("<ul>", {id:"newGroup"+newGroupIndex,  class:"sortable" });
  	  		var div = jQuery("<div>", {id: "ng"+newGroupIndex, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"questionGroup", value:newGroupLabel});
  	  		div.append(h2);
  	  		div.append(ul);
  	  		jQuery("#"+parent).append(div);
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
				var li =  $(this);
				var name = li[0].innerText.replace(/X([^X]*)$/,'$1');
	  	  		var str = "<li id='"+li[0].id+"' draggable='true' ondragstart='drag(event);' ondrop='drop(event)' ondragover='allowDrop(event)' class='question list-group-item  list-group-item-warning' >"+name+"</li>";

	  	  		if(li[0].id.indexOf("client") > -1)
	  	  		{
	  	  			jQuery("#clientQuestionsList").append(str);
	  	  		}
	  	  		else
	  	  		{
	  	  			jQuery("#commonQuestionsList").append(str);
	  	  		}
	  	  		li.remove();
			});
  	  		
  	  		
	  	  	//delete group
			jQuery("#"+group).remove();
  	  		resetSortable();
  	  		resetDelete();
		}
  	</script>
  	
	<script>
	
		function allowDrop(ev) {
		    ev.preventDefault();
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
	  	  		var li = jQuery(this).closest('li');
	  	  		var name = li[0].innerText.replace(/X([^X]*)$/,'$1');
	  	  		var str = "<li id='"+li[0].id+"' draggable='true' ondragstart='drag(event);' ondrop='drop(event)' ondragover='allowDrop(event)' class='question list-group-item  list-group-item-warning' >"+name+"</li>";

	  	  		if(li[0].id.indexOf("client") > -1)
	  	  		{
	  	  			jQuery("#clientQuestionsList").append(str);
	  	  		}
	  	  		else
	  	  		{
	  	  			jQuery("#commonQuestionsList").append(str);
	  	  		}
	  	  		li.remove();
	  	  	});
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
			            $(this).removeClass("ui-state-default");
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

		    var data = ev.dataTransfer.getData("text");
		    var dataObject = document.getElementById(data);
		    if(dataObject === undefined || dataObject == null)
		    {
		    	return;
		    }
		    jQuery("#"+dataObject.id).remove();
		    var list = ev.target.getElementsByTagName("ul");
			for (var i = 0; i < list.length; i++) {
				var name = dataObject.innerText.replace(/X([^X]*)$/,'$1');
	  	  		var li = jQuery("<li>", {id: dataObject.id, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"question list-group-item  list-group-item-warning", ondragstart:'drag(event);'}).append(name+"<a href='#' title='delete' class='itemDelete' style='float:right;'>X</a>");
	  	  		li.attr("draggable","true");
				jQuery("#"+list[i].id).append(li);
			}
			resetSortable();
		}
		
		
		var jsonObjDetails = [];
		var jsonObjChecklist = [];
		var done = false;
		function populateQuestions()
		{
			jQuery('#detailQuestionPane .questionGroup').each(function(){
			    var obj = {
			        id: this.id,
			        name: this.getAttribute("value"),
			        questions: ""
			    };
			    $(".question", this).each(function() {
			    	obj.questions+=this.id.replace(/client-([^client-]*)$/,'$1')+",";
			    });
			    jsonObjDetails.push(obj);
			});

			jQuery('#checklistQuestionPane .questionGroup').each(function(){
			    var obj = {
			        id: this.id,
			        name: this.getAttribute("value"),
			        questions: ""
			    };
			    $(".question", this).each(function() {
			    	obj.questions+=this.id.replace(/client-([^client-]*)$/,'$1')+",";
			    });
			    jsonObjChecklist.push(obj);
			});


			for(var i = 0; i < jsonObjDetails.length; i++) {
				var obj = jsonObjDetails[i];

			    var url=contextPath + '/change/updateQuestionGroup.json?groupId='+obj.id+'&name='+obj.name+'&questions='+obj.questions;
			    jQuery.getJSON(url, function(json) {	   
		  			jQuery('#detailsQuestionGroups').append("<option id='"+json+"' value='"+json+"' selected/>");
		  		});
		  		
			}
			for(var i = 0; i < jsonObjChecklist.length; i++) {
				var obj = jsonObjChecklist[i];

			    var url=contextPath + '/change/updateQuestionGroup.json?groupId='+obj.id+'&name='+obj.name+'&questions='+obj.questions;
			    var promise = jQuery.getJSON(url);

			    promise.done(function(json) {	      
		  			jQuery('#checklistQuestionPane').append("<option id='"+json+"' value='"+json+"' selected/>");
		  		});
		  		
			}
			alert("Creating groups");

		}
	</script>
</head>
<body >
<scannell:form id="changeTemplate">
	<div class="content">
		<div class="table-responsive">	
			<div class="panel changeTemplatePanel">
				<table class="table table-bordered table-responsive">
				<tbody>
					<tr class="form-group">
						<td class="searchLabel" style="width: 40%;"><fmt:message key="name" />:</td>
						<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:40%" /></td>
					</tr>
				
					<tr class="form-group">
						<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
						<td class="search"><scannell:textarea path="additionalInfo" class="form-control" cssStyle="float:left;width:40%" /></td>
					</tr>
				
					<tr class="form-group">
						<td class="searchLabel"><fmt:message key="active" />:</td>
						<td class="search"><div class="checkbox"><label><scannell:checkbox path="active" /></label></div></td>
					</tr>
					<tr class="form-group">
						<td colspan="2" class="bigLabel">
							<div class="panel-group accordion accordion-semi" id="accordion4">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a class="collapsed" data-toggle="collapse" data-parent="#accordion4" href="#acc3">
											<i class="fa fa-angle-right"></i>
											<fmt:message key="changeTemplateStep1" /></a>
									</h4>
								</div> 
								<div id="acc3" class="panel-collapse collapse out" >
									<a ref='#' title='changeTemplate.addNewGroup' onclick='addNewGroup("detailQuestionPane")' style='float:right;'><fmt:message key="changeTemplate.addNewGroup"/></a></br>
									<div id="detailQuestionPane"  style="height:90%;width:90%">
										<c:forEach var="g" items="${detailsGroups}">
											<change:questionGroup group="${g}"/>
								         </c:forEach>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr class="form-group">
						<td colspan="2" class="bigLabel">
							<div class="panel-group accordion accordion-semi" id="accordion1">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a class="collapsed" data-toggle="collapse" data-parent="#accordion1" href="#acc2">
											<i class="fa fa-angle-right"></i>
											<fmt:message key="changeTemplateStep2" />
										</a>
									</h4>
								</div> 
								<div id="acc2" class="panel-collapse collapse out" >
									<a ref='#' title='changeTemplate.addNewGroup' onclick='addNewGroup("checklistQuestionPane")' style='float:right;'><fmt:message key="changeTemplate.addNewGroup"/></a></br>
									<div id="checklistQuestionPane" style="height:90%;width:90%">
										<c:forEach var="g2" items="${checklistGroups}">
											<change:questionGroup group="${g2}"/>
							            </c:forEach>
									</div>
								</div>
							</div>
						</td>	
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="center">
						
							<scannell:select id="detailsQuestionGroups" path="detailsQuestionGroups" itemValue="id" multiple="true" cssStyle="display:none" itemLabel="name"/>
							<scannell:select id="checklistQuestionGroups" path="checklistQuestionGroups" itemValue="id" multiple="true" cssStyle="display:none"/>
							<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"  onclick="populateQuestions();">
							<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/change/templateQueryForm.htm" />'">
						</td>
					</tr>
				</tfoot>
				</table>
			</div>
				
			<div class="changeTemplateQuestionPanel" style="width:20%;position:fixed;left:70%;top:16%">
				<div class="panel-group accordion accordion-semi"  id="accordion2" style="height:50%;">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion2" href="#0">
								<i class="fa fa-angle-right"></i>
								<fmt:message key="changeTemplateClientCommonQuestions" />
							</a>
						</h4>
					</div> 
					<div id="0" class="panel-collapse collapse out">
						<div id="clientQuestions" class="panel-body">
							<ul id="clientQuestionsList" class="list-group"  style="height:200px;overflow: auto !important">
								<c:forEach var="cQuestion" items="${clientQuestions}">
									<system:clientQuestion question="${cQuestion}"/>
					            </c:forEach>
				            </ul>
				      	</div>
					</div>
				</div>
				<div id="commonQuestions" class="panel-group accordion accordion-semi"  id="accordion3">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion3" href="#1">
								<i class="fa fa-angle-right"></i>
								<fmt:message key="changeTemplateEnviroMANAGERCommonQuestions" />
							</a>
						</h4>
					</div> 
					<div id="1" class="panel-collapse collapse out">
						<div class="panel-body">
							<ul id="commonQuestionsList" class="list-group"  style="height:200px;overflow: auto !important">
								<c:forEach var="question" items="${commonQuestions}">
					             	<system:question question="${question}"/>
					            </c:forEach>
				            </ul>
				      	</div>
				    </div>
				</div>
			</div>
		</div>
	</div>
</scannell:form>

</body>
</html>
