<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@page import="com.scannellsolutions.users.UserUtils"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.halign {
    text-align: centre;
}
th {
    text-align: centre !important;
}
.leftSpace{
padding-left: 2%;
}
</style>
<script type="text/javascript" src="<scannell:resource value="/js/highcharts.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/exporting.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.pie.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/lawDashboard.js" />"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	var levelOfCompliance;
	levelOfCompliance=function() {
		  url = '<c:url value="/law/checklists.htmf?refine=false&viewAll=true&panel=true&panelLOC=true&legRegister="/>' + jQuery('#lawTabs').val();;
			jQuery.ajax({
			  url: url,
			  type: 'post',
			  dataType: 'html',
			  success: function(returnData) {
			    jQuery('#container3').html(returnData);				     
			  },
			  error: function(e) {
			    
			  }
			});
	  };	  
	 levelOfCompliance();
});
</script>
</head>
<body>
<law:profileVersionCheck profile="${profile}" />
<div class="row dash-cols">

				<div class="col-sm-10 col-md-10 col-lg-4">
			
					 <div class="block" <%
							if (UserUtils.currentUser().isInRole(com.scannellsolutions.modules.law.domain.Profile.ROLE_CREATE)
																		|| UserUtils.currentUser().isInRole(com.scannellsolutions.modules.law.domain.Profile.ROLE_SHARE)) {
							%>onclick="openProfileManager()"<%}%>>
						<div class="header complianceChecklist">
							<h4><i class="fa fa-user"></i><span style="color: #3380FF;" class="leftSpace"><fmt:message key='lawdashboard.profileOwner' /></span></h4>
						</div>
						<div class="content no-padding">
							<div class="fact-data text-center">
								<h4 id="profileName" style="color: #3380FF;"></h4>&nbsp;
								<h4 id="countryName" style="color: #3380FF;"></h4>
							</div>
							<div class="fact-data text-center">
								<h4 style="color: #3380FF;" class="leftSpace"><fmt:message key='lawdashboard.profileOwner.lastUpdate'/></h4>&nbsp;
								<h4> <i class="fa fa-refresh" style="color: red;"></i> <span id="contentUpdateDate" style="color: black;"></span> </h4>
							</div>
						</div>
					</div> 
				</div>
				<div class="col-sm-10 col-md-10 col-lg-4">
					<div class="block" onclick="showQuickLegislation(4);">
						<div class="header">
							<h4><i class="fa fa-file-text-o"></i><span style="color: #3380FF;" class="leftSpace"><fmt:message key='lawdashboard.legUpdate' /></span></h4>
						</div>
						<div class="content no-padding">
							<div class="fact-data text-center">
								<h4 style="color: #3380FF;"><fmt:message key='lawdashboard.legUpdate.new' /></h4>&nbsp;
								<h4 style="color: #3380FF;" id="newLeg"></h4>
							</div>
							<div class="fact-data text-center">
								<h4 style="color: #3380FF;"><fmt:message key='lawdashboard.legUpdate.ammendments'/></h4>&nbsp;
								<h4 style="color: #3380FF;" id="newAmd"></h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-10 col-md-10 col-lg-4">
					<fmt:message key='lawdashboard.considerSite' var="consider"/>	
					<div class="block" onclick="showQuickLegislation(6);">
						<div class="header">
							<h4><i class="fa fa-comment-o"></i><span style="color: #3380FF;"class="leftSpace"><fmt:message key='lawdashboard.tasks'/></span></h4>
						</div>
						<div class="content no-padding">
							<div class="fact-data text-center">
								<h4 style="color: #3380FF;"><fmt:message key='lawdashboard.tasks.due'/></h4>&nbsp;
								<h4 style="color: #3380FF;" id="dueCount"></h4>
							</div>
							<div class="fact-data text-center">
								<h4 style="color: #3380FF;"><fmt:message key='lawdashboard.tasks.overdue'/></h4>&nbsp;
								<h4 style="color: #3380FF;" id="overDueCount"></h4>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div id="le-alert" class="alert alert-danger fade  col-md-10 col-lg-10">
			<button href="#" type="button" class="close">&times;</button>
            <strong><fmt:message key='lawdashboard.lealert'/></strong> 
            <div class="content col-md-10 col-lg-10"> 
             <div style="padding-left:0;"><fmt:message key='lawdashboard.lealert.message'/> </div>            
             </div>
            </div> 		
			
			<div class="row dash-cols">				
				<div class="col-sm-10 col-md-10 col-lg-6" id="locDiv">
							<div class="block">						 
						  <div class="header">
							<!-- <h2>Level of Compliance</h2> --><label class="control-label"><fmt:message key='lawdashboard.levelofcompliance'/></label>
						</div>								
								<div id="container3" style="width: 100%; height: 100%;">
							   	
								
						        </div>
				</div>
				
			   </div>
			   <div class="col-sm-12 col-md-10 col-lg-6" id="chkComp">
							<div class="block">						 
						  <div class="header">
						  <label class="control-label"><fmt:message key='lawdashboard.checklistscompleted'/></label>
						</div>								
								<div id="container4" style="width: 100%; height: 110%;"></div>
								<table  class="red" style="width: 100%; height: 100%;">
								<thead>
									<tr>
										<th class="halign"><fmt:message key='lawdashboard.category'/></th>
										<th class="halign"><fmt:message key='lawdashboard.complcompleted'/></th>
										<th class="halign"><fmt:message key='lawdashboard.relcompleted'/></th>
										
									</tr>
								</thead>
								<tbody id="display" class="no-border-x">									
								</tbody>
							</table>
				</div>				
			</div>
			 <div class="col-sm-10 col-md-10 col-lg-10" id="hidDiv" style="visibility: hidden;">
			 
			 </div>
			<div class="col-sm-12 col-md-10 col-lg-6">
						<div class="block">						 
						  <div class="header" style="pdding-right:0px;">
						  <label class="control-label"><fmt:message key='lawdashboard.legislation'/></label>
							<!-- <h2>Legislation</h2> -->
						</div>								
								<div id="container1" style="width: 100%; height: 100%;"></div>								
						  </div>						
				</div>
				<div class="col-sm-12 col-md-10 col-lg-6">
							<div class="block">						 
						  <div class="header">
							<!-- <h2>CheckList</h2> --><label class="control-label"><fmt:message key='lawdashboard.checklist'/></label>
						</div>								
								<div id="container2" style="width: 100%; height: 100%;"></div>	
								
						  </div>
				</div>
			
			</div>
</body>
</html>