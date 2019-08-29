<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
  
<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>
<head>
<jsp:include page="headInclude.jsp" />
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>

<c:set var="showChecklistLinks" value="${param['hideLinks'] != 'true'}" />

<c:if test="${showChecklistLinks}" >
<script>
function viewTask(id){
	  //alert('Task id is '+id);
	jQuery("#dialogFrame").attr("src", contextPath + '/law/taskView.htm?id='+id);
    jQuery("#dialogDiv").dialog("open");
}

 
</script>
<script type="text/javascript">
jQuery(document).ready(function(){	
	// Added by Fernando to able show detail of relevant and noRelevant objects
	var viewTypeName = getUrlParameter('viewType');
	if(viewTypeName != null && viewTypeName != 'undefined') {
		viewTypeName = "&viewType=" + viewTypeName;
	} else {
		viewTypeName = "";
	}
	// the end of Fernando's code
    jQuery("#myTab li:eq(0) a").tab('show');    
    jQuery('.legAnchor').on('click', function() {    	
	    var url;
	    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery(this).attr('leg-id') + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true'+viewTypeName;
	    location.href = url;
	  });
    jQuery("#relevant").click(function() {
    	var legId = jQuery(this).attr('leg-id');
    		if(legId == null){
    			legId = jQuery('.legID2').val();
    		}
    		if(legId == null){
    			legId = jQuery('#profileChecklists_legRegister').val();
    		}
  	  var url = contextPath+"/law/checklists.htm?viewAll=true&viewType=relevant&legRegister="+legId;
  	  window.location.href = url;
  	});
    jQuery("#nonRelevant").click(function() {
    	var legId = jQuery(this).attr('leg-id');
		if(legId == null){
			legId = jQuery('.legID2').val();
		}
		if(legId == null){
			legId = jQuery('#profileChecklists_legRegister').val();
		}
  	  var urll = contextPath+"/law/checklists.htm?viewAll=true&viewType=notRelevant&legRegister="+legId;
  	  window.location.href = urll;
  	});
	  
});

  
  
</script>
</c:if>

 <title>
   
  </title>


</head>
<body>
<c:set var="menuChecklists" value="${checklists}" />

<div class="block-flat">
<input type="hidden" value="${profileChecklists_legRegister}" id="profileChecklists_legRegister">
		<div class="header">
			<h3>
				<c:choose>
							<c:when test="${viewType == 'relevant'}">Relevant Compliance Checklists</c:when>
							<c:when test="${viewType == 'notRelevant'}">Non Relevant Compliance Checklists</c:when>
							<c:otherwise>Relevant Compliance Checklists</c:otherwise>
						</c:choose>
						for Profile:
						<c:out value="${profile.name}" />

			</h3>
		</div>
		
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
			<div class="tab-content">
				<div class="tab-pane cont active" id="home">
					<div class="cl-mcont">
						<div class="row">
							<div class="col-md-12">

								<div class="content">

									<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">

										<ul class="list-group">
											<li class="list-group-item">
												<h4 class="list-group-item-heading">
													<c:out value="${item.key.name}" />
												</h4>
												<hr> <c:forEach items="${item.value}" var="checklist" varStatus="sm">
													<input type="hidden" class="legID2" value="${checklist.registerType.id}">
													 <span style="float: right">
													<button type="button" class="g-btn g-btn--primary btn-sm" id="toolBar" ss-pid="<c:out value="${profile.id}" />" 
													      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
															ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}"     leg-id="${checklist.registerType.id}"
															ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
													      check-id="${checklist.id}" ss-action="edit" data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
															<i class="fa fa-edit"></i> Edit
													</button>
															<button type="button" class="g-btn g-btn--primary btn-sm legAnchor" check-id="${checklist.id}" leg-id="${checklist.registerType.id}">
																<i class="fa fa-comments"></i> Details
															</button></span>
														<h4 class="list-group-item-heading">
															<c:out value="${checklist.name}" />
														</h4>
														<hr>
														<h5>
															<strong>Things to Consider </strong>
														</h5>
														
															<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														

														<h5>
															<strong>Relevance </strong>
														</h5> <c:if test="${empty checklist.relevance}"><fmt:message key="notSpecifiedInProfile" /></c:if> <c:out value="${checklist.relevance}"></c:out> <c:if test="${!empty checklist.compliance}">
															<h5>
																<strong>Evaluation of Compliance:</strong>
															</h5>
														</c:if><c:if test="${empty checklist.compliance}"><fmt:message key="notSpecifiedInProfile" /></c:if> <c:out value="${checklist.compliance}"></c:out>
																										
												</c:forEach> 

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

									<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">

										<ul class="list-group">
											<li class="list-group-item">
												<h4 class="list-group-item-heading">
													<c:out value="${item.key.name}" />
												</h4>
												<hr> 
												<c:forEach items="${item.value}" var="checklist" varStatus="sm">
													<input type="hidden" class="legID2" value="${checklist.registerType.id}">
													<span  check-id="${checklist.id}"> <span style="float: right">
													
													<button type="button" class="g-btn g-btn--primary btn-sm" id="toolBar" ss-pid="<c:out value="${profile.id}" />" 
													      ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
															ss-pcid="<c:out value="${checklist.profileChecklistId}" />" check-id="${checklist.id}"     leg-id="${checklist.registerType.id}"
															ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"
													      check-id="${checklist.id}" ss-action="edit" data-placement="top" target="_self" class="g-btn g-btn--primary btn-sm chkAnchor ed" >
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
							 	                       <c:if test="${altName.key.id == language.id}">	
							 	                       <h4 class="list-group-item-heading">
															<c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if><c:out value="${altName.value}"  />
														</h4>
														<%-- <hr><div align="right"><span class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div> --%>
							 	                       						 			
								                       <%-- <span class="col-sm-10"><c:out value="${altName.value}"  />  </span> --%>
								                       </c:if>
								                       </c:forEach> 
															
														</h4>
														<hr>
														<h5>
															<strong>Things to Consider</strong>
														</h5>
														
															<div id="toConsider${checklist.id}">${checklist.thingsToConsider}</div>
														

														<h5>
															<strong>Relevance </strong>
														</h5> <c:if test="${empty checklist.relevance}"><fmt:message key="notSpecifiedInProfile" /></c:if> <c:out value="${checklist.relevance}"></c:out> <c:if test="${!empty checklist.compliance}">
															<h5>
																<strong>Evaluation of Compliance:</strong>
															</h5>
														</c:if> <c:if test="${empty checklist.compliance}"><fmt:message key="notSpecifiedInProfile" /></c:if>  <c:out value="${checklist.compliance}"></c:out>
													</span>													
												</c:forEach> 

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
		
		
</div>
</body>
</html>
