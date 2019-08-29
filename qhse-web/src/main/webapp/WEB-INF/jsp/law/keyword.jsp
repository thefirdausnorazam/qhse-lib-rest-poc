<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>
<head>
<jsp:include page="headInclude.jsp" />
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>
<script>
jQuery(document).ready(function(){	
	
	var pr = jQuery('.dataDetails').attr("profile") ;// activated tab	
	
	  var ch = jQuery('.dataDetails').attr("checklist") ;	
	 var url = contextPath+"/law/showChecklistDetail.htmf?checklistId="+ch+"&profileId="+pr;
 	  var checklistDiv = jQuery('#lawLegislation-'+ch);	      
     checklistDiv.load(url, function() {
   	 
     });
     var changesDiv = jQuery('#changes-'+ch);	      
     changesDiv.load(url, function() {
   	 
     });
     var relatedDiv = jQuery('#related-'+ch);	      
     relatedDiv.load(url, function() {
   	 
     });
     
     jQuery('.legAnchor').on('click', function() {
    	var viewType = getUrlParameter("viewType");
    	if(viewType == null || viewType == "undefined") {
    		viewType = "relevant";
    	}
 	    var url;
 	    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery('#lawTabs').val() + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true&viewType='+viewType;
 	    location.href = url;
 	  });
     jQuery("#relevant").click(function() {
    	var id = getUrlParameter('id');
     	var legRegister = getUrlParameter('legRegister');
     	var profileId = getUrlParameter('profileId');
     	var url = contextPath+"/law/keyword.htm?id=" + id + "&legRegister=" + legRegister + "&profileId=" + profileId + "&viewAll=true&viewType=relevant";
    	//contextPath+"/law/checklists.htm?viewAll=true&viewType=relevant&legRegister="+jQuery('#lawTabs').val();
   	  	window.location.href = url;
    	});
     jQuery("#nonRelevant").click(function() {	
    	var id = getUrlParameter('id');
    	var legRegister = getUrlParameter('legRegister');
    	var profileId = getUrlParameter('profileId');
    	var urll = contextPath+"/law/keyword.htm?id=" + id + "&legRegister=" + legRegister + "&profileId=" + profileId + "&viewAll=true&viewType=notRelevant";
   	  	//contextPath+"/law/checklists.htm?viewAll=true&viewType=notRelevant&legRegister="+jQuery('#lawTabs').val();
   	  	window.location.href = urll;
   	});
	  
});
function viewTask(id){
	  //alert('Task id is '+id);
	jQuery("#dialogFrame").attr("src", contextPath + '/law/taskView.htm?id='+id);
    jQuery("#dialogDiv").dialog("open");
    
    
}
</script>

<title></title>

<style type="text/css">

.title {
  color:#000000;
  font-size:18px;
  font-weight:bold;
  text-align:center;
  margin-bottom: 25px;
}

</style>

</head>
<body>
<c:set var="menuChecklists" value="${checklists}" />
<div class="block-flat">
		<%-- <div class="header">
			<h3>
				<c:choose>
					<c:when test="${viewType == 'relevant'}">Relevant Compliance Checklists</c:when>
					<c:when test="${viewType == 'notRelevant'}">Non Relevant Compliance Checklists</c:when>
					<c:otherwise>Relevant Compliance Checklists</c:otherwise>
				</c:choose>
				for Profile:
				<c:out value="${profile.name}" />

			</h3>
		</div> --%>
	
	<div align="right">
			<button data-placement="top" data-toggle="tooltip" id="relevant" data-original-title="Show Relevant Checklists" type="button" class="g-btn g-btn--primary btn-flat">
				<i class="fa fa-folder-open-o"></i>
			</button>
			<button data-placement="top" data-toggle="tooltip" id="nonRelevant" data-original-title="Show Non Relevant Checklists" type="button" class="btn btn-warning btn-flat">
				<i class="fa fa-times-circle"></i>
			</button>
	</div>
	<div class="tab-container">
		<ul class="nav nav-tabs" id="myTab">
			<li class="active"><a href="#home" data-toggle="tab">English</a></li>				
			<c:forEach items="${lang}" var="item">				           
				<c:set var="language" value="${item.key}" />						           
				<li>	<a href="#language-${language.id}" data-toggle="tab">${language.name}</a></li>						 
			</c:forEach>
		</ul>
	</div>
	<div class="tab-content">
		<div class="tab-pane cont active" id="home">
			<div class="cl-mcont">
				<div class="row">
					<div class="col-md-12">

						<div class="content">

							
							
							<div class="row" style="padding-left: 14px;  padding-bottom: 10px;">										       
									<h4 class="list-group-item-heading">																 			
								        <c:out value="${keyword.name}"  />															
									</h4>												
							</div>						

								<c:if test="${fn:length(keyword.relatedChecklists) < 1}">
									<ul class="list-group">
										<li class="list-group-item">
											<span style="float: center">
												<div style="text-align: center;" >
													<c:choose>
														<c:when test="${viewType == 'relevant'}">
															<h3>The checklist(s) under this keyword are marked not relevant</h3>
														</c:when>
														<c:otherwise>
															<h3>The checklist(s) under this keyword are marked relevant</h3>
														</c:otherwise>
													</c:choose>
												</div>
											</span>
										</li>
									</ul>
								</c:if>
										
										 <c:forEach items="${keyword.relatedChecklists}" var="checklist" varStatus="sm">
										 <ul class="list-group">
											         <li class="list-group-item">
													 <span style="float: right">
													 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
															      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																	ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																	ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
															      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																	<i class="fa fa-edit"></i> Edit
															</button>
													 		<c:choose>	
														 		<c:when test="${not riskRelatedChecklists}">			
																	<button type="button" class="g-btn g-btn--primary btn-sm legAnchor" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"> 
																	<i class="fa fa-comments"></i> Details
																	</button>
																</c:when>
																<c:otherwise>	
																	<button type="button" class="g-btn g-btn--primary btn-sm riskReleatedChecklist" check-id="${checklist.id}" leg-id="${checklist.registerType.id}">
																		<i class="fa fa-comments"></i> Details
																	</button>
																</c:otherwise>
															</c:choose>
														</span>
														<h4 class="list-group-item-heading">
															<c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if><c:out value="${checklist.name}" />
														</h4>
														<hr><div align="right"><span class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>
														<h5>
															<strong>Things to Consider </strong>
														</h5>
														<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														

														<h5>
															<strong>Relevance </strong>
														</h5> <c:if test="${empty checklist.relevance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if> <c:out value="${checklist.relevance}"></c:out> 
														<%-- <c:if test="${!empty checklist.compliance}"> --%>
															<h5>
																<strong>Evaluation of Compliance:</strong>
															</h5><c:if test="${empty checklist.compliance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if>
														<%-- </c:if>  --%><c:out value="${checklist.compliance}"></c:out>
														
														<c:if test="${profile.loc eq true}">
														<h5>
															<strong>Level Of Compliance </strong>
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
								
								<div class="row" style="padding-left: 14px;  padding-bottom: 10px;">										       
									<h4 class="list-group-item-heading">									
									 <c:forEach items="${keyword.alternateLanguageNames}" var="altName">
									<c:if test="${altName.key.id == language.id}">							 			
								     <c:out value="${altName.value}"  /> 
								    </c:if>	
								    </c:forEach> 								       															
									</h4>												
							</div>
									
										 <c:forEach items="${keyword.relatedChecklists}" var="checklist" varStatus="sm">
										 <ul class="list-group">
											    <li class="list-group-item">                                                
													 <span style="float: right">
													 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
															      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																	ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																	ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
															      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																	<i class="fa fa-edit"></i> Edit
															</button>
													 		<c:choose>	
														 		<c:when test="${not riskRelatedChecklists}">			
																	<button type="button" class="g-btn g-btn--primary btn-sm legAnchor" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"> 
																	<i class="fa fa-comments"></i> Details
																	</button>
																</c:when>
																<c:otherwise>	
																	<button type="button" class="g-btn g-btn--primary btn-sm riskReleatedChecklist" check-id="${checklist.id}" leg-id="${checklist.registerType.id}">
																		<i class="fa fa-comments"></i> Details
																	</button>
																</c:otherwise>
															</c:choose>
														</span>
														<h4 class="list-group-item-heading">								                       
												        <c:forEach items="${checklist.alternateLanguageNames}" var="altName">												      
												         <c:out value="${altName.value}"  /> 
									                   <c:if test="${altNameCh.key.id == language.id}">							 			
								                       <c:out value="${altNameCh.value}"  /> 
								                       </c:if>	
								                       </c:forEach>	
															<%-- <c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if><c:out value="${checklist.name}" /> --%>
														</h4>
														<hr><div align="right"><span class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>
														<h5>
															<strong>Things to Consider</strong>
														</h5>
														<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														<%-- <ul>
															<li>${checklist.thingsToConsider}</li>
														</ul> --%>

														<h5>
															<strong>Relevance </strong>
														</h5> <c:if test="${empty checklist.relevance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if> <c:out value="${checklist.relevance}"></c:out> 
														<%-- <c:if test="${!empty checklist.compliance}"> --%>
															<h5>
																<strong>Evaluation of Compliance:</strong>
															</h5><c:if test="${empty checklist.compliance}"><c:out value="${viewType != \"notRelevant\" ? \"Not Specified in Profile\" : \"Not Relevant\"}"></c:out></c:if>
														<%-- </c:if>  --%><c:out value="${checklist.compliance}"></c:out>
														
														<c:if test="${profile.loc eq true}">
														<h5>
															<strong>Level Of Compliance </strong>
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
													

								</div>
							</div>
						</div>
					</div>					 
					 </div>
				</c:forEach>		
	</div>
</div>


<a name="top"></a>
	

</body>
</html>
