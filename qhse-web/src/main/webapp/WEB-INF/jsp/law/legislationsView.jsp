<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions' %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<!DOCTYPE html>
<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>
<head>
<jsp:include page="headInclude.jsp" /> 
<script>
jQuery(document).ready(function(){
    jQuery("#myTab li:eq(0) a").tab('show');    
    jQuery('.legAnchor').on('click', function(event) {
    	event.preventDefault ? event.preventDefault() : event.returnValue = false;
	    var url;
	    url = '<law:url value="/law/legislation.htm?legRegister=" />' + jQuery('#lawTabs').val() + '&legId=' + jQuery(this).attr('leg-id')+'&profileId='+jQuery('#profileSelect').val();
	    location.href = url;
	  });
	  
});

function openLinkFile(link) {
	
	window.open("<c:url value='/doclink/openLinkFile.htm?link="+link+"'/>");
	
	
}
</script>
<title></title>
</head>
<body>
<div class="row">				
				<div class="col-sm-12 col-md-12">
				<div class="tab-container">				
				 <ul class="nav nav-tabs" id="myTab">
				 <li><a href="#english" data-toggle="tab">&nbsp;<fmt:message key='tab.english'/></a></li> <!-- <fmt:message key='xxxxxxxxxxx'/> -->
				           <c:forEach items="${lang}" var="item">
				           
				           <c:set var="language" value="${item.key}" />	
				           <li>
						<a href="#language-${language.id}" data-toggle="tab">${language.nativeName}</a></li>						 
						   </c:forEach>						  
						  <li><a href="#messages" data-toggle="tab"><i class="fa fa-leaf"></i>&nbsp;<fmt:message key='tab.other.requirements'/></a></li> 
				</ul>
				<div class="tab-content">				
				<div class="tab-pane active cont" id="english">				
				<div class="cl-mcont">
				<div class="row">	
				<!--For Loop First -->
					 <c:forEach items="${categoryToLegislations}" var="categoryEntry">				
					<div class="col-sm-12 col-md-12 col-xs-12">	
					<div class="block-flat">
						<div class="header">
							<h3><c:out value="${categoryEntry.key.name}" /> </h3>
						</div>						
					<div class="content">
							<div class="list-group">
							<c:forEach items="${categoryEntry.value}" var="legislation">							
							  <a href="#" class="list-group-item legAnchor"  style="overflow: hidden;" leg-id="${legislation.id}" >
							  <h4>
							     <c:choose>
							     <c:when test="${legislation.dispalyOrder.id == 1}">
								 <div class="col-sm-1"><i class="fa fa-circle"></i>  </div>
								 </c:when>
								 <c:when test="${legislation.dispalyOrder.id == 2}">
								 <div class="col-sm-1"><i class="fa fa-arrow-circle-down"></i> </div>
								 </c:when>
								 <c:otherwise>
								 <div class="col-sm-1"><i class="fa fa-circle-o"></i> </div>
								  </c:otherwise>
								  </c:choose>	
								<div class="col-sm-10"><c:out value="${legislation.name}"  /> </div>
								<img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
								<c:if test="${legislation.legNew}"><span class="badge badge-danger"><fmt:message key='newTitle'/></span></c:if>		
								<c:if test="${legislation.changedInLatestContentVersionAmd}"><span class="badge badge-danger"><fmt:message key='amdTitle'/></span></c:if>							
								</h4>
							  </a>
							  <div class="clear"></div>  						  
							  </c:forEach>
							</div>
					  </div>					  
					</div>	
					</div>
					</c:forEach>	
					</div>		
					</div>
				</div>						  
						  
					<c:forEach items="${lang}" var="item">	  
					<c:set var="language" value="${item.key}" />		  
					 <div class="tab-pane cont" id="language-${language.id}">
					 <div class="cl-mcont">
				     <div class="row">
								<!--For Loop First -->
					 <c:forEach items="${categoryToLegislations}" var="categoryEntry">
					 <div class="col-sm-12 col-md-12">								
					<div class="block-flat">
						<div class="header">
							<h3><c:out value="${categoryEntry.key.name}" /></h3>
						</div>											
					<div class="content">					
							<div class="list-group">
								<c:forEach items="${categoryEntry.value}" var="legislation">							 		
							  <a href="#" class="list-group-item legAnchor"  style="overflow: hidden;" leg-id="${legislation.id}">							  
								<h4>
								<c:choose>
							     <c:when test="${legislation.dispalyOrder.id == 1}">
								 <div class="col-sm-1"><i class="fa fa-circle"></i>  </div>
								 </c:when>
								 <c:when test="${legislation.dispalyOrder.id == 2}">
								 <div class="col-sm-1"><i class="fa fa-arrow-circle-down "></i> </div>
								 </c:when>
								 <c:otherwise>
								 <div class="col-sm-1"><i class="fa fa-circle-o"></i> </div>
								  </c:otherwise>
								  </c:choose>	
								<c:forEach items="${legislation.alternateLanguageNames}" var="altName">	 
							 	<c:if test="${altName.key.id == language.id}">							 			
								<div class="col-sm-10"><c:out value="${altName.value}"  />  </div>
								 </c:if>
								 </c:forEach> 
								 <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />"> 
								&nbsp;<c:if test="${legislation.changedInLatestContentVersion}"><span class="badge badge-danger"><fmt:message key='newTitle'/></span></c:if>							 
								 </h4>	
								 <div class="clear"></div>							
							  </a>								   		  						 
							  </c:forEach>							
							</div>							
					  </div>					    
					</div>	
					</div>
					</c:forEach>
					</div>
					</div>
					
					</div>
					</c:forEach>					
						  <div class="tab-pane" id="messages">
						  <jsp:include page="otherRequirements.jsp" /> 						  
						  </div>
			</div>
			</div>					
				</div>			
			</div>
</body>
</html>
