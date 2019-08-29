<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident" %>


<!DOCTYPE html>
<html>
<head>

<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
}
</style>
<style type="text/css" media="all">
		.sortable { list-style-type: none; margin: 0; padding: 0; }
		.sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
		.sortable li span { position: absolute; margin-left: -1.3em; }
		.unsortable { list-style-type: none; margin: 0px 0px 3px 0px; padding: 0; pointer-events:none; opacity:0.6; }
	    .unsortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
		.unsortable li span { position: absolute; margin-left: -1.3em; }
		.list-group li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; }
		
		
	</style>
  	<script>		
  	/* Manjush Start */
  	jQuery(document).ready(function() {
  	  var arr;
  	  arr = [];
  	  jQuery('#exLayout').submit(function(event) {
  	    var ids;
  	    ids = jQuery('[name^="excelSortedId"]');
  	    jQuery('.excelSortedId').each(function(i) {
  	      arr.push(jQuery(this).attr('id'));
  	    });
  	    jQuery('#sourcePage').val(arr);  
  	  }); 
  	resetSortable();
  	});
	/* Manjush End */ 	
		
  	</script>
  	
	<script>
	
		function allowDrop(ev) {
			if (ev.preventDefault) {
				ev.preventDefault();
			}
			ev.dataTransfer.dropEffect = "all";
		}
		
		function drag(ev) {
			if(ev != undefined && ev.target.getAttribute("draggable") == "true")
			{
		    	ev.dataTransfer.setData("text", ev.target.id);
			}
		}
		
		function resetSortable()
		{
			jQuery( ".sortable" ).sortable({
			      revert: true,
			      //items : ':not(.note)',
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
		    var data = ev.dataTransfer.getData("text");
		    var dataObject = document.getElementById(data);		   
		    if(dataObject === undefined || dataObject == null)
		    {
		    	return;
		    }
		   // jQuery("#"+dataObject.id).remove();
		    var list = ev.target.getElementsByTagName("ul");
		    if(list.length > 0)
		    {
				for (var i = 0; i < list.length; i++) {
					var name = dataObject.innerText.replace(/X([^X]*)$/,'$1');
		  	  		var li = jQuery("<li>", {id: dataObject.id, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"question list-group-item  list-group-item-warning", ondragstart:'drag(event);'}).append(name+"<a href='#' title='delete' class='itemDelete' style='float:right;'>X</a>");
		  	  		li.attr("draggable","true");
					jQuery("#"+list[i].id).append(li);
				}
		    }
			resetSortable();
		}
		
		
		var jsonObjDetails = [];
		var jsonObjChecklist = [];
		var done = false;
	
	</script>
<title></title>
</head>
<body>
 <div class="header">
<h3>Specify Incident Excel Layout</h3>
</div> 
<scannell:form action="/incident/editExcelLayoutSubmit.htm" id="exLayout">
 <div class="content"> 
 <div class="panel-group accordion accordion-semi" id="accordionLeg">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title">
<a class="collapsed" data-toggle="collapse" data-parent="#accordion3" href="#checkAccord" aria-expanded="true" style="border: 1px solid #CCCCCC;"> <i class="fa fa-angle-right"></i> 
<!-- <span class="badge">Version :44</span> -->
<span> Excel Columns:</span>												  
</a>

</h4>
</div>
<div id="checkAccord" class="panel-collapse collapse" aria-expanded="true">	
<div class="panel-body"> 
			<div id="detailQuestionPane"  >
	<h2 class="list-group-item-heading"></h2>		
	<div class="questionGroup">	
	<div>		             
<ul class="unsortable" >
 <li
	class="note question list-group-item  list-group-item-info"  draggable="false">
	&nbsp;	
	ID

</li> 
<li 
	class="note question list-group-item  list-group-item-info"  draggable="false">
	&nbsp;	
	Type
	
</li>
<li 
	class="note question list-group-item  list-group-item-info"  draggable="false">
	&nbsp;	
	Sub Type
	
</li>
</ul>
</div>
<div ondrop="drop(event, this)" ondragover="allowDrop(event)">
<ul id="group10005" class="sortable" >
<c:forEach var="field" items="${allFields}">
<li id="<c:out value="${field.id}"/>-<c:out value="${field.type}"/>" 
	draggable="true" ondragstart="drag(event);" ondrop="drop(event, this)" ondragover="allowDrop(event)"
	class="excelSortedId question list-group-item  list-group-item-warning"  >
	&nbsp;
	<c:choose>
		<c:when test="${field.type == 'Permanent' }"><fmt:message key="${field.questionName}" /></c:when>
		<c:when test="${not field.clientQuestion}"><fmt:message key="${field.questionName}"/></c:when>
		<c:otherwise><c:out value="${field.question.name}"/></c:otherwise>
	</c:choose>	
	
</li>
</c:forEach>
    </ul>
    <input type="hidden" name="excelSort"  id="sourcePage" value="">
</div>
<div style="clear: both;"></div>
<div style="margin-top:3px;">		             
<ul class="unsortable" >
 <li
	class="note question list-group-item  list-group-item-info"  draggable="false">
	&nbsp;	
	<fmt:message key="createdByDepartment" />

</li> 
</ul>
</div>
</div>
			</div>
</div> <!-- Panel Body -->
</div> 
</div>				
</div> 
 <div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
</div>
</div>
</scannell:form>


</body>
</html>
