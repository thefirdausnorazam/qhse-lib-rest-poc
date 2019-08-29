<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<%@page import="com.scannellsolutions.modules.law.web.ProfileChecklistHelper"%>


<html>
<head>
<jsp:include page="headInclude.jsp" />
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>
<c:set var="showChecklistLinks" value="${param['hideLinks'] != 'true'}" />

<link class="theme-css" rel="stylesheet" href="<c:url value="/groove/css/groove-qpulse.min.css" />" />

<script>
jQuery(document).ready(function(){	
	var comeFromRisk = false;
	if(window.location.href.indexOf('RiskRelatedChecklists.jsp') > -1 || window.location.href.indexOf('IncidentRelatedChecklists.jsp') > -1) {
		comeFromRisk = true;
	}
	
    jQuery("#myTab li:eq(0) a").tab('show');    
    jQuery('.legAnchor').on('click', function() {
	    var url;
	    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery(this).attr('leg-id') + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true&checklistsPage=true&viewType=${viewType}';
	    location.href = url;
	  });
    jQuery("#relevant").click(function() {    	
    	  var url = contextPath+"/law/checklists.htm?refine=false&viewAll=true&viewType=relevant&legRegister="+jQuery('#lawTabs').val();
    	  window.location.href = url;
     });
      jQuery("#nonRelevant").click(function() {    	  
    	  var urll = contextPath+"/law/checklists.htm?refine=false&viewAll=true&viewType=notRelevant&legRegister="+jQuery('#lawTabs').val();
    	  window.location.href = urll;
    }); 
    jQuery(".riskReleatedChecklist").on('click', function() {   
    	 var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
    	 var params = '?checklistDetail=true&checklistId='+jQuery(this).attr('check-id')+'&comeFromRisk='+comeFromRisk;
	     location.href = url+params;
	 });
    if(getUrlParameter('pageRisk') == "true" || getUrlParameter('pageRisk') == true) {
   	 jQuery('#riskMsgError').show();
    }
    
    //Popup
    var popup="<c:out value='${popup}' />";
    if(popup == 'yes'){
    	jQuery('#relDiv').hide();
    	jQuery('.legAnchor').hide();
    	jQuery("#backPopupDiv").show();
    }
    jQuery("#backPopup").on('click', function() {   
   	 var url =contextPath+'/law/taskView.htm?id=<c:out value="${taskId}" />&viewType=${viewType}';    	
	     location.href = url;
	 });
});
</script>
<title></title>
</head>
<body>
	<c:set var="menuChecklists" value="${checklists}" />
	<div id="backPopupDiv" style="display: none;">
	<button  id="backPopup"  type="button" class="g-btn g-btn--primary ">Back</button>
	</div>
	<div class="block-flat">		
		<c:choose>
			<c:when test="${not riskRelatedChecklists }">
				<div id="relDiv" align="right" >
					<button data-placement="left" data-toggle="tooltip" id="relevant" data-original-title=<fmt:message key='btnShowRelevantChecklists'/> type="button" class="g-btn g-btn--primary btn-flat" >
						<i class="fa fa-folder-open-o"></i>
					</button>
					<button data-placement="bottom" data-toggle="tooltip" id="nonRelevant" data-original-title=<fmt:message key='btnShowNONRelevantChecklists'/> type="button" class="g-btn g-btn--warning btn-flat">
						<i class="fa fa-times-circle"></i>
					</button>
				</div>
			</c:when>
			<c:otherwise>
				<div  align="left">
					<h4><c:out value="${subTitle}"/>
						<fmt:message key="checklist.relatedRiskSubHeader" />
						<c:out value="${profile.name}" /></h4>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="tab-container" align="left">
			<ul class="nav nav-tabs" id="myTab">
				<li class="active"><a href="#home" data-toggle="tab"><fmt:message key='tab.english'/></a></li>
				
				<c:forEach items="${lang}" var="item">				           
				           <c:set var="language" value="${item.key}" />					           
					       <li>	<a href="#language-${language.id}" data-toggle="tab">${language.nativeName}</a></li>						 
			    </c:forEach>				
			</ul>
			<div class="tab-content">
				<div class="tab-pane cont active" id="home">
					<div class="cl-mcont">
						<div class="row">
							<div class="col-md-12">
								<div class="content">
									<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">
										        <div class="row" style="padding-left: 14px;  padding-bottom: 10px;">										       
												<h4 class="list-group-item-heading">
													<strong><c:out value="${item.key.name}" /></strong>
												</h4>												
												</div>												
													<c:forEach items="${item.value}" var="checklist" varStatus="sm"> 
                                                     <ul class="list-group">
											         <li class="list-group-item">
													 <span style="float: right">
													 		<c:if test="${checklistEditable}">
														 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
																      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																		ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																		ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
																      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																		<i class="fa fa-edit"></i> <fmt:message key='btnEdit'/>
																</button>
															</c:if>
													 		<c:choose>	
														 		<c:when test="${not riskRelatedChecklists}">			
																	<button type="button" class="g-btn g-btn--primary btn-sm legAnchor" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"> 
																	<i class="fa fa-comments"></i> <fmt:message key='btnDetails'/>
																	</button>
																</c:when>
																<c:otherwise>	
																	<button type="button" class="g-btn g-btn--primary btn-sm riskReleatedChecklist" check-id="${checklist.id}" leg-id="${checklist.registerType.id}">
																		<i class="fa fa-comments"></i> <fmt:message key='btnDetails'/>
																	</button>
																</c:otherwise>
															</c:choose>
														</span>
														<h4 class="list-group-item-heading">
															<c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if><c:out value="${checklist.name}" />
														</h4>
														<hr><div align="right"><span class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>
														<h5>
															<strong><fmt:message key='thingsToConsider'/></strong>
														</h5>
														<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														<div <c:if test="${viewType == 'notRelevant'}">style="display: none;"</c:if> >
														<h5>
															<strong><fmt:message key='relevance'/></strong>
														</h5> <c:if test="${empty checklist.relevance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if> <c:out value="${checklist.relevance}"></c:out> 
														<%-- <c:if test="${!empty checklist.compliance}"> --%>
															<h5>
																<strong><fmt:message key='evaluationOfCompliance'/></strong>
															</h5><c:if test="${empty checklist.compliance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if>
														<%-- </c:if>  --%><c:out value="${checklist.compliance}"></c:out>
														
														<c:if test="${profile.loc eq true}">
														<h5>
															<strong><fmt:message key='levelOfCompliance'/></strong>
														</h5>														
														<c:if test="${checklist.levelOfCompliance ge 80}">
													   <div class="progress">
                                                       <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance ge 50 and checklist.levelOfCompliance le 79}">
														<div class="progress">
                                                       <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance ge 1 and checklist.levelOfCompliance le 49}">
														<div class="progress">
                                                       <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance eq 0}">
													   <div class="progress">
                                                       <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       </c:if>
                                                       </div>
														</li>
														
										               </ul>												
												</c:forEach>											
									</c:forEach>				
									<c:if test="${fn:length(checklistsByCategory) < 1}">
										<div id="riskMsgError" style="">
											<div style="text-align: center;" >
												<h2><strong><fmt:message key='profileIs'/> ${profile.name }</strong></h2>
												<h3><fmt:message key='noChecklistsAssociated'/></h3>
											</div>
											<hr style="border: 1px solid #0066CC">
											<div style="margin-top: 20px">
												<p><fmt:message key='pleaseNote'/></p>
												<p>Q-Pulse LAW © <a href="http://www.scannellsolutions.com"><font style="color: #0066CC;">Ideagen PLC</font></a></p>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
				<c:forEach items="${lang}" var="item">	  
					<c:set var="language" value="${item.key}" />		  
					 <div class="tab-pane cont" id="language-${language.id}">
					 <div class="cl-mcont">
						<div class="row">
							<div class="col-md-12">
								<div class="content">
									<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">										
												<div class="row" style="padding-left: 14px;  padding-bottom: 10px;">										       
												<h4 class="list-group-item-heading">
													<strong><c:out value="${item.key.name}" /></strong>
												</h4>												
												</div>
												<c:forEach items="${item.value}" var="checklist" varStatus="sm">
												<ul class="list-group">
											    <li class="list-group-item">                                                
													 <span style="float: right">
													 		<c:if test="${checklistEditable}">
														 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
																      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																		ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																		ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
																      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																		<i class="fa fa-edit"></i> <fmt:message key='btnEdit'/>
																</button>
															</c:if>
													 		<c:choose>	
														 		<c:when test="${not riskRelatedChecklists}">			
																	<button type="button" class="g-btn g-btn--primary btn-sm legAnchor" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"> 
																	<i class="fa fa-comments"></i> <fmt:message key='btnDetails'/>
																	</button>
																</c:when>
																<c:otherwise>	
																	<button type="button" class="g-btn g-btn--primary btn-sm riskReleatedChecklist" check-id="${checklist.id}" leg-id="${checklist.registerType.id}">
																		<i class="fa fa-comments"></i> <fmt:message key='btnDetails'/>
																	</button>
																</c:otherwise>
															</c:choose>
														</span>
														<h4 class="list-group-item-heading">
														<c:forEach items="${checklist.alternateLanguageNames}" var="altName">	 
							 	                       <c:if test="${altName.key.id == language.id}">							 			
								                       <c:out value="${altName.value}"  /> 
								                       </c:if>
								                       </c:forEach>															
														</h4>
														<hr><div align="right"><span class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>
														<h5>
															<strong><fmt:message key='thingsToConsider'/></strong>
														</h5>
														<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														<%-- <ul>
															<li>${checklist.thingsToConsider}</li>
														</ul> --%>

														<h5>
															<strong><fmt:message key='relevance'/></strong>
														</h5> <c:if test="${empty checklist.relevance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if> <c:out value="${checklist.relevance}"></c:out> 
														<%-- <c:if test="${!empty checklist.compliance}"> --%>
															<h5>
																<strong><fmt:message key='evaluationOfCompliance'/></strong>
															</h5><c:if test="${empty checklist.compliance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if>
														<%-- </c:if>  --%><c:out value="${checklist.compliance}"></c:out>
														
														<c:if test="${profile.loc eq true}">
														<h5>
															<strong><fmt:message key='levelOfCompliance'/></strong>
														</h5>														
														<c:if test="${checklist.levelOfCompliance ge 80}">
													   <div class="progress">
                                                       <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance ge 50 and checklist.levelOfCompliance le 79}">
														<div class="progress">
                                                       <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance ge 1 and checklist.levelOfCompliance le 49}">
														<div class="progress">
                                                       <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${checklist.levelOfCompliance eq 0}">
													   <div class="progress">
                                                       <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${checklist.levelOfCompliance}"/>%"><c:out value="${checklist.levelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       </c:if>
														
													</li>
										           </ul>											
												</c:forEach>											
									</c:forEach>
								</div>
							</div>
						</div>
					</div>					 
					 </div>
				</c:forEach>
		</div>
	</div>
</div>
</body>
</html>
