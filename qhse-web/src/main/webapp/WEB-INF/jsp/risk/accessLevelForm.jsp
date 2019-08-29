<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE>
<html>
	<head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<style type="text/css" media="all">    
        @import "<c:url value='/css/risk.css'/>";
        </style>

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
            	 moveResponsible(document.getElementById('${command.owner.responsibleUser.id}'));
            	 if('${command.owner.responsibleUser.id}' != '${command.owner.approvalByUser.id}'){
            		 moveResponsible(document.getElementById('${command.owner.approvalByUser.id}'));
            	 }
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
			 unselect();
		 }
		 function moveAllLeft(){	
			 jQuery("#sourceFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields2").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').addClass('fc-selected');
			 jQuery("#sourceFields").append(jQuery(".fc-selected"));	
			 unselect();
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
			 unselect();
		 }
		   function moveAllLeftGroups(){
			 jQuery("#sourceFields").find('div').removeClass('fc-selected');
			 jQuery("#destinationFields").find('div').removeClass('fc-selected');  
			 jQuery("#destinationFields2").find('div').addClass('fc-selected');
			 jQuery("#sourceFields2").append(jQuery(".fc-selected"));
			 unselect();
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
	document.getElementById("confidential").onclick();
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

function onConfidential(form)
{
	
	if(jQuery("#confidential").is(':checked'))
	{
		moveAllLeftGroups();
		jQuery("#userRightButton1").attr("disabled", true); 
		jQuery("#userRightButton2").attr("disabled", true); 
		jQuery("#userLeftButton1").attr("disabled", true);
		jQuery("#userLeftButton2").attr("disabled", true);
	}
	else 
	{
		jQuery("#userRightButton1").attr("disabled", false);  
		jQuery("#userRightButton2").attr("disabled", false);  
		jQuery("#userLeftButton1").attr("disabled", false);  
		jQuery("#userLeftButton2").attr("disabled", false);  
 
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
     /* border-style: solid;
    border-color: #F2DEDE; */
}

.fc-destination-fields {
    float: right;
    display: block;
   /* border-style: solid;
    border-color: #F2DEDE; */
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
		</style>
	</head>

	<body onload="onPermissionLoad()" >
<div class="header">
<h2>Confidentiality and Access Permissions</h2>
</div>
	
<div style="font-weight: bold; font-size: larger; text-align: center;">Select Users and/or Groups who are allowed to view this page</div>
<div style="color: red; text-align: center; font-weight: bold">[If no Users or Groups are selected then all Users will have access]</div>


<br/>
<div style="color: red; text-align: center; font-weight: bold">To make this Risk Assessment Confidential ensure the box below is ticked.</div>
<div style="text-align: center">Confidential Assessments can only be viewed by the selected users on the right hand side.</div>
<div style="text-align: center">Select Groups is disabled for Confidential Assessments.</div>

<spring:hasBindErrors name="command">
  <font color="red">Please fix all errors</font>
</spring:hasBindErrors>
 
<br style="clear:both">

<form method="post" name="permissionForm" onsubmit="onPermissionSubmit();">
	<input name="id" type="hidden" value="<c:out value="${command.id}"/>" />
	<input name="version" type="hidden" value="<c:out value="${command.version}"/>" />
<div class="header">
<h3><fmt:message key="selectUsers" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print" id="accordion1">

 <div id="collapse1" class="panel-collapse collapse in"  align="center">
 <div id="fieldChooser" tabIndex="1" class="fieldChooser">
 		<div align="center">
 			<spring:bind path="command.owner.confidential">
					<input type="hidden" name="<c:out value="_${status.expression}"/>" />
					<input type="checkbox" id="confidential" name="<c:out value="${status.expression}"/>"
			    <c:choose>
			    	<c:when test="${confidentialSet}">
						<c:if test="${confidential}">checked="checked"</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${status.value}">checked="checked"</c:if></c:otherwise>
				</c:choose>
				 onclick="onConfidential(this.form);"/> CONFIDENTIAL
				<span class="errorMessage"><c:out
					value="${status.errorMessage}" /></span>
			</spring:bind>
		</div>
        <div id="sourceFields"  >
            <c:forEach items="${users}" var="item">            
                <div id="<c:out value="${item.id}" />" ondblclick="moveSelected(this)"><c:out value="${item.sortableName}" /></div>                
            </c:forEach>                
        </div>
        <div align="center" class="middle" >
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRight();" id="userRightButton" /><br /> <br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRight();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeft();" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeft();" />
	   </div>	   
            <div id="destinationFields" >
            
            
            
            </div>
   </div> 
   </div>
 </div>	
</div>
</div>	

<div class="header">
<h3><fmt:message key="selectGroups" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="accordion2">

 <div id="collapse2" class="panel-collapse collapse in"  align="center">
 <div id="fieldChooser2" tabIndex="1" class="fieldChooser" >
            <div id="sourceFields2"  >
            <c:forEach items="${groups}" var="item">            
                <div id="<c:out value="${item.id}" />" ondblclick="moveSelectedGroups(this)"><c:out value="${item.name}" /></div>                
             </c:forEach>                
            </div>
        <div align="center" class="middle" >
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRightGroups();" id="userRightButton1" /><br /> <br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRightGroups();" id="userRightButton2"/><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeftGroups();" id="userLeftButton1" /><br /><br />
		<input type="button" class="g-btn g-btn--primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeftGroups();" id="userLeftButton2"/>
	   </div>
	   
            <div id="destinationFields2" >
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
	<td align="center">
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
		<input type="button" class="rightGroup btn-info" name="right" value="&gt;&gt;"     onclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" id="groupRightButton" /><br /><br />
		<input type="button" class="rightGroup btn-info" name="right" value="all &gt;&gt;" onclick="moveAllOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" id="groupRightAllButton" /><br /><br />
		<input type="button" class="rightGroup btn-info" name="left"  value="&lt;&lt;"     onclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])"  id="groupLeftButton" /><br /><br />
		<input type="button" class="rightGroup btn-info" name="left"  value="all &lt;&lt;" onclick="moveAllOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])" id="groupLeftAllButton" />
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