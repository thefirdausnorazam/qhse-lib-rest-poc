<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		

		<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
		<script type="text/javascript">
		 jQuery(document).ready(function(){			 
			 var $sourceFields = $("#sourceFields");
             var $destinationFields = $("#destinationFields");
             var $chooser = $("#fieldChooser").fieldChooser(sourceFields, destinationFields);             
             var $sourceFields2 = $("#sourceFields2");
             var $destinationFields2 = $("#destinationFields2");
             var $chooser2 = $("#fieldChooser2").fieldChooser(sourceFields2, destinationFields2);

             setTimeout(function(){
         		<c:forEach items="${command.owner.assignees}" var="item">
            		 moveResponsible(document.getElementById('${item.id}'));
            	 </c:forEach>
             }, 2000);
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

		function moveResponsible(obj) {
			 
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields2"){
            	 jQuery("#"+obj.id).addClass('fc-selected');
				 moveSelectedRight();
			 }
		 }
		 function moveSelected(obj) {
			 
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields2"){
				 moveSelectedRight();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields2" ) {
				 moveSelectedLeft();
			 }
		 }
		function moveSelectedGroups(obj) {
			 
			 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields2"){
				 moveSelectedRightGroups();
			 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields2" ) {
				 moveSelectedLeftGroups();
			 }
		 }
		 function moveSelectedRight() {
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").append(jQuery(".fc-selected"));			 
		 }
		 function moveSelectedLeft() {
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 //jQuery("#sourceFields").append(jQuery(".fc-selected"));
			 sorDivs("#sourceFields", jQuery("#destinationFields .fc-selected"));
		 }
		 function moveAllRight(){
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#sourceFields").find('div').addClass('fc-selected');
			 jQuery("#destinationFields").append(jQuery(".fc-selected"));
			 unselect() 			 	
		 }
		 function moveAllLeft(){	
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').addClass('fc-selected');
			 jQuery("#sourceFields").append(jQuery(".fc-selected"));
			 unselect() 			 	
		 }		 
		 function moveSelectedRightGroups() {
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").append(jQuery(".fc-selected"));			 
		 }
		  function moveSelectedLeftGroups() {
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');
			 //jQuery("#sourceFields2").append(jQuery(".fc-selected"));
			 sorDivs("#sourceFields2", jQuery("#destinationFields2 .fc-selected"));
		 }
		  function moveAllRightGroups(){
			  jQuery("#sourceFields").find('div').removeClass('fc-selected');
			  jQuery("#destinationFields").find('div').removeClass('fc-selected'); 
			 jQuery("#sourceFields2").find('div').addClass('fc-selected');
			 jQuery("#destinationFields2").append(jQuery(".fc-selected"));
			 unselect() 
		 }
		   function moveAllLeftGroups(){
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');  
			 jQuery("#destinationFields2").find('div').addClass('fc-selected');
			 jQuery("#sourceFields2").append(jQuery(".fc-selected"));	
			 unselect() 
		 } 
		   function unselect() {
				var array = jQuery('div.fc-selected');
				for (var i = 0; i < array.length; i++) {
					jQuery(array[i]).removeClass('fc-selected');
				}
			}
<!--
function onPermissionLoad() {
	
	<c:forEach items="${command.authorisedUsers}" var="item">
	var idLoad ="<c:out value="${item.id}"/>";	
	jQuery('#sourceFields #'+idLoad).addClass('fc-selected');	    
	</c:forEach>
	moveSelectedRight();
	

	<c:forEach items="${command.authorisedGroups}" var="item">
	    var idLoad2 ="<c:out value="${item.id}"/>";	
	    jQuery('#sourceFields2 #'+idLoad2).addClass('fc-selected');	
	</c:forEach>
	moveSelectedRightGroups();
	window.focus();
}

function onPermissionSubmit() {
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
}

// -->
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
<div class="header">
<h2>Permissions</h2>
</div>
<div style="font-weight: bold; font-size: larger; text-align: center;">Select Users and/or Groups who are allowed to view this page</div>
<div style="color: red; text-align: center; font-weight: bold">[If no Users or Groups are selected then all Users will have access]</div>

<spring:hasBindErrors name="command">
  <font color="red">${command.owner.setAccessLevelAllowed == true ? "Please fix all errors" : "Need to be Management Access Level"}</font>
</spring:hasBindErrors>
 
<br style="clear:both">

<form method="post" name="permissionForm" onsubmit="onPermissionSubmit();">
	<input name="id" type="hidden" value="<c:out value="${command.id}"/>" />
	<input name="version" type="hidden" value="<c:out value="${command.version}"/>" />
<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion1">
<div class="panel-heading" style="text-align:center">
<fmt:message key="selectUsers" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion1" href="#collapse1" ></a>
   
 </div>
 <div id="collapse1" class="panel-collapse collapse in">
 <div id="fieldChooser" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
        <div id="sourceFields"  >
            <c:forEach items="${users}" var="item">            
                <div id="<c:out value="${item.id}" />" ondblclick="moveSelected(this)" data-text="${item.sortableName}"><c:out value="${item.sortableName}" /></div>                
            </c:forEach>                
        </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRight();" id="userRightButton" /><br /> <br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRight();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeft();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeft();" />
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
<div class="panel hidden-print panel-danger" id="accordion2">
<div class="panel-heading" style="text-align:center">
   <fmt:message key="selectGroups" /><a class="accordion-toggle" data-toggle="collapse"  data-parent="#accordion2" href="#collapse2" ></a>
 </div>
 <div id="collapse2" class="panel-collapse collapse in">
 <div id="fieldChooser2" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
            <div id="sourceFields2"  >
            <c:forEach items="${groups}" var="item">            
                <div id="<c:out value="${item.id}" />" ondblclick="moveSelectedGroups(this)"><c:out value="${item.name}" /></div>                
             </c:forEach>                
            </div>
        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRightGroups();" id="userRightButton" /><br /> <br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRightGroups();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeftGroups();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeftGroups();" />
	   </div>
	   
            <div id="destinationFields2" style="float: left;">
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
		<select id="authorisedUsers"  class="dropfalse" name="authorisedUsers" multiple="multiple" size="10" style="display:none;" ondblclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unselected'])" >
		</select>
	</td>
</tr>



<tr style="display:none;">
	<td align="center">
		<select id="unauthorisedGroups" name="unauthorisedGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" >
			<%-- <c:forEach items="${groups}" var="item">
				<option id="<c:out value="group${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
			</c:forEach> --%>
		</select>
	</td>
	 <!-- <td align="center">
		<input type="button" class="button btn-info" name="right" value="&gt;&gt;"     onclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" id="groupRightButton" /><br /><br />
		<input type="button" class="button btn-info" name="right" value="all &gt;&gt;" onclick="moveAllOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" /><br /><br />
		<input type="button" class="button btn-info" name="left"  value="&lt;&lt;"     onclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])" /><br /><br />
		<input type="button" class="button btn-info" name="left"  value="all &lt;&lt;" onclick="moveAllOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])" />
	</td> --> 
	<td align="center">
		<select id="authorisedGroups" name="authorisedGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unselected'])" >
		</select>
	</td>
</tr>

<tr>
	<td align="center" colspan="3">
		<button type="submit" class="g-btn g-btn--primary" >Ok</button>

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