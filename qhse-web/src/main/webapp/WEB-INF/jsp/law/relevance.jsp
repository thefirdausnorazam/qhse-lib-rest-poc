<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>
<head>
<jsp:include page="headInclude.jsp" />
<script type="text/javascript"
	src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript"
	src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>

<script type="text/javascript">
var langCheck;
jQuery(document).ready(function(){	
    jQuery("#myTab li:eq(0) a").tab('show');    
    var ll=jQuery('#hiddenLang1').val();
    jQuery('#lang').html(ll);   
    jQuery('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {    	
    	 var id= jQuery(e.target).attr('id');
    	 if(id == 1){    		
    		    jQuery('#lang').html("");
    		    jQuery('#lang').html(ll);
    	 }else{    		 
    		 var l=jQuery('#hiddenLang').val();
        	 jQuery('#lang').html(l); 
    	 }
    });
    
    jQuery('.legAnchor').on('click', function() {    	
	    var url;
	    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery('#lawTabs').val() + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true';
	    location.href = url;
	  });
    jQuery("#relevant").click(function() {
  	  var url = contextPath+"/law/checklists.htm?viewAll=true&viewType=relevant&legRegister="+jQuery('#lawTabs').val();
  	  window.location.href = url;
  	});
    jQuery("#nonRelevant").click(function() {		 
  	  var urll = contextPath+"/law/checklists.htm?refine=false&viewAll=true&viewType=notRelevant&legRegister="+jQuery('#lawTabs').val();
  	  window.location.href = urll;
  	});
    
   
    
	  
});	
	function viewTask(id) {		
		jQuery("#dialogFrame").attr("src",
		contextPath + '/law/taskView.htm?id=' + id);
		jQuery("#dialogDiv").dialog("open");
	}
</script>

<title></title>

<style type="text/css">
.legislation-title {
	vertical-align: bottom;
	font-size: 10px;
	margin-bottom: 25px;
}

.legislation-title-name {
	color: black;
	font-weight: bold;
	font-size: 18px;
}

.legislation-title-econregion {
	color: black;
	font-weight: bold;
	font-size: 10px;
}
</style>

</head>
<body>
	<div class="block-flat"> 
	<div class="tab-container">
			<ul class="nav nav-tabs" id="myTab">
				<li class="active"><a href="#home" id="1" data-toggle="tab"><fmt:message key='tab.english'/></a></li>				
				 <c:forEach items="${legislation.alternateLanguageNames}" var="item">				           
				           <c:set var="language" value="${item.key}" />					           
					       <li>	<a href="#language-${language.id}" id="${language.id}" data-toggle="tab">${language.name}</a></li>						 
			    </c:forEach> 				
			</ul>
	
	<div class="header">
						<h3>												
							<c:forEach items="${legislation.alternateLanguageNames}" var="altName">	 
							<c:set var="language" value="${item.key}" />
							<c:if test="${altName.key.id == language.id}">							 			
						    <c:out value="${altName.value}"  /> 
						    </c:if>
						    </c:forEach>							
							<span id="lang">
							<input type="hidden"  id="hiddenLang1" value="${legislation.name}" />							  
							</span> 
							 <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
							<c:out value="${legislation.economicRegion.name}" /> 	<!-- <span class="badge badge-danger" id="iconNew"></span> -->
							<c:if test="${legislation.legNew}"><span class="badge badge-danger" style="font-size: 12px;"><fmt:message key='new'/></span></c:if>		
                            <c:if test="${legislation.changedInLatestContentVersionAmd}"><span class="badge badge-danger" style="font-size: 12px;"><fmt:message key='amd'/></span></c:if>	
							<div class="content"><a href="<law:legislationUrl legislation="${legislation}" profile="${profile}" viewType="${viewType}" />"><fmt:message key='viewSynopsis'/></a></div>							
						</h3>
	</div>

		<div align="right" style="margin-top: 5px">
			<button data-placement="top" data-toggle="tooltip" id="relevant" data-original-title=<fmt:message key='btnShowRelevantChecklists'/> type="button" class="g-btn g-btn--primary btn-flat">
				<i class="fa fa-folder-open-o"></i>
			</button>
			<button data-placement="top" data-toggle="tooltip" id="nonRelevant" data-original-title=<fmt:message key='btnShowNONRelevantChecklists'/> type="button" class="g-btn g-btn--warning btn-flat">
				<i class="fa fa-times-circle"></i>
			</button>
		</div>	
		
				
			<div class="tab-content">
				<div class="tab-pane cont active" id="home">
					<div class="cl-mcont">
						<div class="row">
							<div class="col-md-12">

								<div class="content">  
								<c:if test="${fn:length(legislation.relatedChecklists) eq 0}">
                                <div class="alert alert-info"><button type="button" data-dismiss="alert" aria-hidden="true" class="close">×</button><i class="fa fa-info-circle sign"></i><strong><fmt:message key='olderLegislation'/></strong></div>
                                </c:if>                    
								
												 <c:forEach items="${legislation.relatedChecklists}" var="checklist" varStatus="sm"><a id="chl_${checklist.id}"><br/></a>
                                                    <ul class="list-group">
											         <li class="list-group-item">
													 <span style="float: right">
													 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
															      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																	ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																	ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
															      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																	<i class="fa fa-edit"></i> <fmt:message key='btnEdit'/>
															</button>
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
															<strong><fmt:message key='thingsToConsider'/> </strong>
														</h5>
														<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														

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
															<strong><fmt:message key='levelOfCompliance'/> </strong>
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
										            <br/>												
												</c:forEach>														

								</div>
							</div>
						</div>
					</div>
				</div>	
				<c:forEach items="${legislation.alternateLanguageNames}" var="item">
				<c:set var="language" value="${item.key}" />
				<div class="tab-pane cont" id="language-${language.id}"> 
					<div class="cl-mcont">
						<div class="row">
							<div class="col-md-12">
								<div class="content">    
									
												 <c:forEach items="${legislation.relatedChecklists}" var="checklist" varStatus="sm"><a id="chl_${checklist.id}"><br/></a>
                                                    <ul class="list-group">
											    <li class="list-group-item">                                                
													 <span style="float: right">
													 		<button type="button "  id="toolBar" ss-pid="<c:out value="${profile.id}" />" onclick="editChecklist(${checklist.id},${checklist.profileChecklistId},${profile.id},${profile.loc})"
															      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
																	ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}" leg-id="${checklist.registerType.id}"    
																	ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
															      check-id="${checklist.id}"  data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
																	<i class="fa fa-edit"></i> <fmt:message key='btnEdit'/>
															</button>
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
															<strong><fmt:message key='relevance'/> </strong>
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
										            <br/>												
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
<jsp:include page="footerInclude.jsp" />
</body>
</html>
