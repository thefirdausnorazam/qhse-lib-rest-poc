<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html>
<html>
	<head>
		<title><fmt:message key="docControl.distribute" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<style type="text/css" media="all">
			@import "<c:url value='/css/doccontrol.css'/>";
		</style>

		<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
		<script type="text/javascript">
		function confirmSendEmail() {
		    return confirm("<fmt:message key='doccontrol.distributeList.confirm'/>");
		}
		 jQuery(document).ready(function(){			 
			 var $sourceFields = $("#sourceFields");
             var $destinationFields = $("#destinationFields");
             var $chooser = $("#fieldChooser").fieldChooser(sourceFields, destinationFields);             
             var $sourceFields2 = $("#sourceFields2");
             var $destinationFields2 = $("#destinationFields2");
             var $chooser2 = $("#fieldChooser2").fieldChooser(sourceFields2, destinationFields2);         
             var $sourceFields3 = $("#sourceFields3");
             var $destinationFields3 = $("#destinationFields3");
             var $chooser3 = $("#fieldChooser3").fieldChooser(sourceFields3, destinationFields3);        
             var $sourceFields4 = $("#sourceFields4");
             var $destinationFields4 = $("#destinationFields4");
             var $chooser4 = $("#fieldChooser4").fieldChooser(sourceFields4, destinationFields4);

		 });
		 function sorDivs(id, obj) {

				var sortedDivs = jQuery(id).children('div');
				if(sortedDivs.length > 0) {
					included = false;
					jQuery.each(sortedDivs, function (index, value) {
						if(obj.text() < value.textContent && included == false) {
							jQuery(id).append(obj);
							included = true;
						}
						jQuery(id).append(value);   //adding them to the body
						if(included == false) {
							jQuery(id).append(obj);
						}
					});
				} else {
					jQuery(id).append(jQuery(".fc-selected"));
				}
		 }

		 function moveSelected(obj) {
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields"){
				 moveSelectedRight();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields") {
				 moveSelectedLeft();
			 }
		 }
		function moveSelectedGroups(obj) {
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields2"){
				 moveSelectedRightGroups();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields2") {
				 moveSelectedLeftGroups();
			 }
		 }
		function moveSelectedSites(obj) {
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields3"){
				 moveSelectedRightSites();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields3") {
				 moveSelectedLeftSites();
			 }
		 }
		function moveSelectedDepts(obj) {
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields4"){
				 moveSelectedRightDepts();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields4") {
				 moveSelectedLeftDepts();
			 }
		 }
		 function moveSelectedRight() {
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").append(jQuery(".fc-selected"));		 
		 }
		 function moveSelectedLeft() {			 
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 sorDivs("#sourceFields", jQuery("#destinationFields .fc-selected"));
		 }
		 function moveAllRight(){
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields").find('div').addClass('fc-selected');
			 jQuery("#destinationFields").append(jQuery(".fc-selected"));
			 unselect() 			 	
		 }
		 function moveAllLeft(){	
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').addClass('fc-selected');
			 jQuery("#sourceFields").append(jQuery(".fc-selected"));
			 unselect() 			 	
		 }		 
		 function moveSelectedRightGroups() {
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").append(jQuery(".fc-selected"));			 
		 }
		  function moveSelectedLeftGroups() {
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 sorDivs("#sourceFields2", jQuery("#destinationFields2 .fc-selected"));
		 }
		  function moveAllRightGroups(){
			  jQuery("#sourceFields").find('div').removeClass('fc-selected');
			  jQuery("#destinationFields").find('div').removeClass('fc-selected'); 
			  jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			  jQuery("#destinationFields3").find('div').removeClass('fc-selected'); 
				 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
				 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields2").find('div').addClass('fc-selected');
			 jQuery("#destinationFields2").append(jQuery(".fc-selected"));
			 unselect() 
		 }
		   function moveAllLeftGroups(){
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');  
			 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields3").find('div').removeClass('fc-selected'); 
			 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').addClass('fc-selected');
			 jQuery("#sourceFields2").append(jQuery(".fc-selected"));	
			 unselect() 
		 } 
		   
			 
			 function moveSelectedRightSites() {
				 jQuery("#sourceFields").find('div').removeClass('fc-selected');
				 jQuery("#destinationFields").find('div').removeClass('fc-selected');
				 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
				 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
				 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
				 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
				 jQuery("#destinationFields3").append(jQuery("#sourceFields3 .fc-selected"));					 
			 }
			  function moveSelectedLeftSites() {
					 jQuery("#sourceFields").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields").find('div').removeClass('fc-selected');
					 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
					 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
					 sorDivs("#sourceFields3", jQuery("#destinationFields3 .fc-selected"));
			 }
			  function moveAllRightSites(){
				  jQuery("#sourceFields").find('div').removeClass('fc-selected');
				  jQuery("#destinationFields").find('div').removeClass('fc-selected'); 
				  jQuery("#sourceFields2").find('div').removeClass('fc-selected');
				  jQuery("#destinationFields2").find('div').removeClass('fc-selected'); 
					 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields4").find('div').removeClass('fc-selected');
				 jQuery("#sourceFields3").find('div').addClass('fc-selected');
				 jQuery("#destinationFields3").append(jQuery(".fc-selected"));
				 unselect() 
			 }
			   function moveAllLeftSites(){
					 jQuery("#sourceFields").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields").find('div').removeClass('fc-selected');  
					 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
					 jQuery("#sourceFields4").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields4").find('div').removeClass('fc-selected'); 
					 jQuery("#destinationFields3").find('div').addClass('fc-selected');
					 jQuery("#sourceFields3").append(jQuery(".fc-selected"));	
					 unselect() 
			 } 
			   
			   function moveSelectedRightDepts() {
					 jQuery("#sourceFields").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields").find('div').removeClass('fc-selected');
					 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
					 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
					 jQuery("#destinationFields4").append(jQuery("#sourceFields4 .fc-selected"));					 
				 }
				  function moveSelectedLeftDepts() {
						 jQuery("#sourceFields").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields").find('div').removeClass('fc-selected');
						 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
						 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
						 sorDivs("#sourceFields4", jQuery("#destinationFields4 .fc-selected"));
				 }
				  function moveAllRightDepts(){
					  jQuery("#sourceFields").find('div').removeClass('fc-selected');
					  jQuery("#destinationFields").find('div').removeClass('fc-selected'); 
					  jQuery("#sourceFields2").find('div').removeClass('fc-selected');
					  jQuery("#destinationFields2").find('div').removeClass('fc-selected'); 
					  jQuery("#sourceFields3").find('div').removeClass('fc-selected');
					  jQuery("#destinationFields3").find('div').removeClass('fc-selected'); 
					 jQuery("#sourceFields4").find('div').addClass('fc-selected');
					 jQuery("#destinationFields4").append(jQuery(".fc-selected"));
					 unselect() 
				 }
				   function moveAllLeftDepts(){
						 jQuery("#sourceFields").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields").find('div').removeClass('fc-selected');  
						 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields2").find('div').removeClass('fc-selected'); 
						 jQuery("#sourceFields3").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields3").find('div').removeClass('fc-selected');
						 jQuery("#destinationFields4").find('div').addClass('fc-selected');
						 jQuery("#sourceFields4").append(jQuery(".fc-selected"));	
						 unselect() 
				 } 
		   function unselect() {
				var array = jQuery('div.fc-selected');
				for (var i = 0; i < array.length; i++) {
					jQuery(array[i]).removeClass('fc-selected');
				}
			}

function onPermissionLoad() {
	<c:forEach items="${command.audUsers}" var="item">
	var idLoad ="<c:out value="${item.id}"/>";	
	jQuery('#sourceFields #u'+idLoad).addClass('fc-selected');	    
	</c:forEach>
	moveSelectedRight();

	<c:forEach items="${command.audDepts}" var="item">
	    var idLoad4 ="<c:out value="${item.id}"/>";	
	    jQuery('#sourceFields4 #x'+idLoad4).addClass('fc-selected');	
	</c:forEach>
	moveSelectedRightDepts();

	<c:forEach items="${command.audGroups}" var="item">
	    var idLoad2 ="<c:out value="${item.id}"/>";	
	    jQuery('#sourceFields2 #g'+idLoad2).addClass('fc-selected');	
	</c:forEach>
	moveSelectedRightGroups();
	
	<c:forEach items="${command.audSites}" var="item">
	    var idLoad3 ="<c:out value="${item.id}"/>";	
	    jQuery('#sourceFields3 #s'+idLoad3).addClass('fc-selected');	
	</c:forEach>
	moveSelectedRightSites();

	window.focus();
}

function onPermissionSubmit() {
	jQuery('div[id]').each(function(){
	    var id = jQuery(this).attr('id');
	    if (id.indexOf('s') == 0 || id.indexOf('u') == 0 || id.indexOf('g') == 0 || id.indexOf('x') == 0) {			
	    	this.id = this.id.substr(1,this.id.length);
	    }
	});
	var authorisedUsers1 = jQuery("#destinationFields").find("div").length;
	var authorisedUsers = document.getElementById("authorisedUsers");
	
	for (var i = 0; i < authorisedUsers1; i++) {
		var valu = jQuery("#destinationFields").find("div").eq(i).attr('id');		
		jQuery("#authorisedUsers").append(jQuery("<option></option>").val(valu).html("One"));
		authorisedUsers.options[i].selected = true;		
	}
    
	var authorisedGroups1 = jQuery("#destinationFields2").find("div").length;	
	var authorisedGroups = document.getElementById("authorisedGroups");	
	
	for (var k = 0; k < authorisedGroups1; k++) {		
		var valu2 = jQuery("#destinationFields2").find("div").eq(k).attr('id');		
		jQuery("#authorisedGroups").append(jQuery("<option></option>").val(valu2).html("One"));
		authorisedGroups.options[k].selected = true;
	}
	
	var authorisedSites1 = jQuery("#destinationFields3").find("div").length;
	var authorisedSites = document.getElementById("authorisedSites");
	
	for (var k = 0; k < authorisedSites1; k++) {		
		var valu2 = jQuery("#destinationFields3").find("div").eq(k).attr('id');		
		jQuery("#authorisedSites").append(jQuery("<option></option>").val(valu2).html("One"));
		authorisedSites.options[k].selected = true;
	}
	
	var authorisedDept1 = jQuery("#destinationFields4").find("div").length;	
	var authorisedDepts = document.getElementById("authorisedDepts");	
	
	for (var k = 0; k < authorisedDept1; k++) {		
		var valu2 = jQuery("#destinationFields4").find("div").eq(k).attr('id');
		jQuery("#authorisedDepts").append(jQuery("<option></option>").val(valu2).html("One"));
		authorisedDepts.options[k].selected = true;
	}
}


jQuery(window).bind('load', onPermissionLoad);
		</script>
		
		<style type="text/css">
.fieldChooser {
    width: 1200px;
    height: 470px;
    display: block;    
    padding-left:3cm;
    padding:1;    
    padding-top: 7px;
}

.fc-field {
    width: 250px;     
    margin: 10px;
    margin-bottom: 10px;
    padding: 5px;
    background-color: #ffffff;
    box-shadow: 0px 0px 10px 0px rgba(222, 222, 222, 1.0);
}

.fc-field:hover {
    outline: #cacaca solid 1px;
}

.fc-selected {
    background-color: #ffe284;
}

.fc-selected:hover {
    background-color: #ffd448;
}

.fc-field-list {
    width: 400px;
    height: 450px; 
    margin: 0px;
    padding: 3px;
    overflow: scroll;
}

.fc-source-fields {
     float: left; 
     display: block;
     padding-left: 2cm;
    
}

.fc-destination-fields {
    float: right;
    display: block;
   
}
.middle{
float: left;
display: block;
width: 200px;
height: 48px;
padding-left:4cm;
padding-top: 2cm;
}

 .panel-heading .accordion-toggle:after {
    /* symbol for "opening" panels */
    font-family: 'Glyphicons Halflings';  /* essential for enabling glyphicon */
    content: "\e114";    /* adjust as needed, taken from bootstrap.css */
    float: right;        /* adjust as needed */
    color: grey;         /* adjust as needed */
}
.panel-heading .accordion-toggle.collapsed:after {
    /* symbol for "collapsed" panels */
    content: "\e080";    /* adjust as needed, taken from bootstrap.css */
}


select {
	width: 200px;
}
.panel-danger > .panel-heading {
color: #FFFFFF !important;
background-color: #00b1ac!important;
border-color: #00b1ac!important;
}
		</style>
	</head>

<body onload="onPermissionLoad()" background="../appstart/images/scannelApp_BackgroundTile2.gif">
<%-- <div class="header">
<h2><fmt:message key="docControl.distribute" /></h2>
</div> --%>
<div style="font-weight: bold; font-size: larger; text-align: center;"><fmt:message key="doccontrol.distribute"/></div>
<div style="color: red; text-align: center; font-weight: bold"><fmt:message key="doccontrol.distribute.info"/></div>

<form method="post" name="permissionForm" onsubmit="onPermissionSubmit();return confirmSendEmail();">
<br style="clear:both">
<div align="center">
	<button type="submit" class="g-btn g-btn--primary"><fmt:message key="docControl.distribute" /></button>

	<c:choose>
		<c:when test="${param.printable == true}">
			<button class="g-btn g-btn--secondary" type="button" onclick="window.close()"><fmt:message key="cancel" /></button>
		</c:when>
		<c:otherwise>
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</c:otherwise>
	</c:choose>
</div>
 
<br style="clear:both">

<div style="font-weight: bold; font-size: larger; text-align: center;"><fmt:message key="docControl.distributeAdditional" /></div>

	<input name="id" type="hidden" value="<c:out value="${command.id}"/>" />
	<input name="version" type="hidden" value="<c:out value="${command.version}"/>" />
	
<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion1">
<div class="panel-heading" style="text-align:center">
<fmt:message key="doccontrol.selectUsers" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion1" href="#collapse1" ></a>
   
 </div>
 <div id="collapse1" class="panel-collapse collapse in">
 <div id="fieldChooser" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
        <div id="sourceFields"  >
            <c:forEach items="${users}" var="item">            
                <div id="u<c:out value="${item.id}" />" ondblclick="moveSelected(this)" data-text="${item.sortableName}"><c:out value="${item.sortableName}" /></div>                
            </c:forEach>                
        </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="btn btn-primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRight();" id="userRightButton" /><br /> <br />
		<input type="button" class="btn btn-primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRight();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeft();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeft();" />
	   </div>
	   
            <div id="destinationFields" style="float: left;">
            
            
            
            </div>
   </div> 
   </div>
 </div>	
</div>
</div>	


<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion4">
<div class="panel-heading" style="text-align:center">
   <fmt:message key="doccontrol.selectDepts" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion4" href="#collapse4" ></a>
 </div>
 <div id="collapse4" class="panel-collapse collapse in">
 <div id="fieldChooser4" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
            <div id="sourceFields4"  >
            <c:forEach items="${departments}" var="item">            
                <div id="x<c:out value="${item.id}" />" ondblclick="moveSelectedDepts(this)"><c:out value="${item.name}" /></div>                
             </c:forEach>                
            </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="btn btn-primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRightDepts();" id="userRightButton" /><br /> <br />
		<input type="button" class="btn btn-primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRightDepts();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeftDepts();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeftDepts();" />
	   </div>
	   
            <div id="destinationFields4" style="float: left;">
            </div>
   </div> 
   </div>
 </div>	
</div>
</div>	

<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion2">
<div class="panel-heading" style="text-align:center">
   <fmt:message key="doccontrol.selectGroups" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion2" href="#collapse2" ></a>
 </div>
 <div id="collapse2" class="panel-collapse collapse in">
 <div id="fieldChooser2" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
            <div id="sourceFields2"  >
            <c:forEach items="${groups}" var="item">            
                <div id="g<c:out value="${item.id}" />" ondblclick="moveSelectedGroups(this)"><c:out value="${item.name}" /></div>                
             </c:forEach>                
            </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="btn btn-primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRightGroups();" id="userRightButton" /><br /> <br />
		<input type="button" class="btn btn-primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRightGroups();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeftGroups();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeftGroups();" />
	   </div>
	   
            <div id="destinationFields2" style="float: left;">
            </div>
   </div> 
   </div>
 </div>	
</div>
</div>	

<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion2">
<div class="panel-heading" style="text-align:center">
   <fmt:message key="doccontrol.selectSites" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion2" href="#collapse2" ></a>
 </div>
 <div id="collapse2" class="panel-collapse collapse in">
 <div id="fieldChooser3" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
            <div id="sourceFields3"  >
            <c:forEach items="${sites}" var="item">            
                <div id="s<c:out value="${item.id}" />" ondblclick="moveSelectedSites(this)"><c:out value="${item.name}" /></div>                
             </c:forEach>                
            </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="btn btn-primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRightSites();" id="userRightButton" /><br /> <br />
		<input type="button" class="btn btn-primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRightSites();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeftSites();" /><br /><br />
		<input type="button" class="btn btn-primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeftSites();" />
	   </div>
	   
            <div id="destinationFields3" style="float: left;">
            </div>
   </div> 
   </div>
 </div>	
</div>
</div>	

<table class="table table-bordered table-responsive">

<tr style="display:none;">
	<td align="center">
		
	</td>
	<td align="center" >
		<input type="button" class="btn btn-success" name="right" value="&gt;&gt;"     onclick="moveSelectedOptions(this.form['unauthorisedUsers'],this.form['authorisedUsers'])" id="userRightButton" /><br /> <br />
		<input type="button" class="btn btn-success" name="right" value="all &gt;&gt;" onclick="moveAllOptions(this.form['unauthorisedUsers'],this.form['authorisedUsers'])" /><br /><br />
		<input type="button" class="btn btn-success" name="left"  value="&lt;&lt;"     onclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unauthorisedUsers'])" /><br /><br />
		<input type="button" class="btn btn-success" name="left"  value="all &lt;&lt;" onclick="moveAllOptions(this.form['authorisedUsers'],this.form['unauthorisedUsers'])" />
	</td>

	<td align="center" >
		<select id="authorisedUsers"  class="dropfalse" name="audUsers" multiple="multiple" size="10" style="display:none;" ondblclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unselected'])" >
		</select>
	</td>
</tr>



<tr style="display:none;">
	<td align="center">
		<select id="unauthorisedGroups" name="unauthorisedGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" >
		</select>
	</td>
	<td align="center">
		<select id="authorisedGroups" name="audGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unselected'])" >
		</select>
	</td>
</tr>


<tr style="display:none;">
	<td align="center">
		<select id="unauthorisedDepts" name="unauthorisedDepts" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedDepts'],this.form['authorisedDepts'])" >
		</select>
	</td> 
	<td align="center">
		<select id="authorisedDepts" name="audDepts" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedDepts'],this.form['unselected'])" >
		</select>
	</td>
</tr>

<tr style="display:none;">
	<td align="center">
		<select id="unauthorisedSites" name="unauthorisedSites" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedSites'],this.form['authorisedSites'])" >
		</select>
	</td> 
	<td align="center">
		<select id="authorisedSites" name="audSites" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedSites'],this.form['unselected'])" >
		</select>
	</td>
</tr>

<tr>
	<td align="center" colspan="3">
		<button type="submit" class="g-btn g-btn--primary"><fmt:message key="docControl.distribute" /></button>

		<c:choose>
			<c:when test="${param.printable == true}">
				<button class="g-btn g-btn--secondary" type="button" onclick="window.close()"><fmt:message key="cancel" /></button>
			</c:when>
			<c:otherwise>
				<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
</table>

</form>

</body>
</html>