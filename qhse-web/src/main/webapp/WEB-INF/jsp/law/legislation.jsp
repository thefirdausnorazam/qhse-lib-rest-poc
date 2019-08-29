<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta name="confidential" content="false">
<meta name="printCopyright" content="true">
<style type="text/css">
.synoH3{
color:#DF4B33;
}
</style>

<jsp:include page="headInclude.jsp" />

<script type="text/javascript"
	src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {		
		var aTag=jQuery(".legislation-synopsis").find("a");
		aTag.append('&nbsp;<i class="fa fa-external-link" data-toggle="tooltip" title="Link to full text"></i>'); 
		var h3Tag=jQuery(".legislation-synopsis").find("h3");
		h3Tag.addClass('synoH3');
		jQuery('.printCopyright').hide();
		jQuery('#categoryMenuSelect').change(function(e) {
			window.location.hash = '#' + jQuery(this).val();
		});
		
		jQuery(".container-fluid.clickable").click(function () {
	    	openPopUp();
	        return false;
	    });
		jQuery('.legAnchor').on('click', function(event) {
	    	event.preventDefault ? event.preventDefault() : event.returnValue = false;
		    var url = '<law:url value="/law/legislation.htm?legRegister=" />' + jQuery(this).attr('leg-regiLeg') + '&legId=' + jQuery(this).attr('leg-id');
		    if(${viewType == 'relevant'}){	
		    	url = url+'&profileId='+jQuery('#profileSelect').val();
		    }
		    else {
		    	url = url+"&view='all'";
		    }
		    location.href = url;
		  });
		jQuery('.legAnchorCheck').on('click', function() {    	
		    var url;
		    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery(this).attr('leg-regi') + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true&checklistsPage=true';
		    location.href = url;
		  });
		if(jQuery('#divBottom').text().trim().length < 1) {
			jQuery('#divBottom').hide();
		}
	});
function openPopUp(){
	if(${hasRiskLicence}){	
		window.open('<c:url value="/law/legislationRelatedRiskAssessments.htm"><c:param name="legId" value="${legislation.id}" /><c:param name="profileId" value="${profile.id}" /><c:param name="comeFromLaw" value="true" /></c:url>', 'lawRelatedRisk','height=600,width=1400,status=yes,toolbar=no,scrollbars=yes');  
	if (window.focus) {newwindow.focus()}
	}else{
		if(jQuery('#alertLicence').length<=0){
		jQuery('#frameMcont').prepend('<div class="alert alert-danger" id="alertLicence"><button type="button" data-dismiss="alert" aria-hidden="true" class="close">×</button><i class="fa fa-times-circle sign"></i><strong><fmt:message key="law.licence" /></strong> <fmt:message key="law.risk.licece.message" /></div>');
	
		}
	}
}

</script>

<!--<title>legislation</title>-->

<style type="text/css">
.clickable{
cursor: pointer;
}
.tab-content { 
   padding: 0px; 
   border-bottom: 0px solid #E2E2E2;
   border-left: 0px solid #ECECEC;
   border-right:0px solid #ECECEC;
 
}
.panel-default > .panel-heading .badge {
    color: #f5f5f5;
    background-color: #00b1ac!important;
}
 /*h3, .h3 {
  font-size: 150%;
  font-family: "Raleway", Helvetica, sans-serif !important;
  font-weight: 200;
} */

/* .header {
  border-bottom: 1px solid #dadada !important;
}
.newNavbar {
  border: 0;
  color: #FFF !important;
  padding-left: 10px;
  padding-right: 25px;
  font-size: 150%;
  font-family: 'Open Sans', sans-serif;
  font-weight: 200
}
/**********************************/
.version {
  margin-top: 5px;
  font-size: 120%;
  font-weight: 500;
}
.cont p {
  color: #333;
  font-size: 100%;
  font-weight: 300;
  line-height: 23px;
  font-family: 'Open Sans', sans-serif;
}
.cl-mcont {
  background-color: #F6F6F6;
  color: inherit;
  font-size: 100%;
  font-weight: 300;
  line-height: 21px;
  padding: 15px 30px 30px 30px;
  margin-top: 0;
  font-family: 'Open Sans', sans-serif;
} 
</style>

</head>
<body>
<!-- <a name="top"></a> -->
<div class="block-flat">
   	<div class="tab-container">
   		<ul class="nav nav-tabs">
   			<li class="active"><a href="#home" data-toggle="tab"><fmt:message key='tab.english'/></a></li>
   			     <c:forEach items="${lang}" var="item">				           
				 <c:set var="language" value="${item.key}" />	
				 <li>
				 <a href="#language-${language.id}${language.name}" data-toggle="tab">${language.nativeName}</a></li>						 
				 </c:forEach>	
   			
<!--    			<li><a href="#Francaise" data-toggle="tab">Francaise</a></li> -->

     
   		</ul>
<div class="row">
<div class="col-sm-6 col-md-6 col-lg-6"><br><h4><i class=" fa fa-folder-open"></i>&nbsp;<c:out value="${legislation.category.name}" /></h4></div>
<div class="col-sm-6 col-md-6 col-lg-6"><div class="pull-right">
	<c:if test="${viewType == 'relevant'}">
		<button type="button" class="g-btn g-btn--primary" style="margin-right: 5px;"onclick="openPopUp();"><i class="fa fa-search"></i> <fmt:message key="riskMenu" /></button>
	</c:if> 
	<button style="float: right;"  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button></div>
</div>

</div>
   		
   		<div class="tab-content">
			<div class="tab-pane active cont" id="home">
   				<!-- <div class="cl-mcont"> -->
		    		<div class="row">
						<div class="col-xs-12 col-sm-8 col-md-8 col-lg-8 pull-left">
						<div class="content">
						<div class="panel panel-default">
						  <div class="panel-heading">
						  <div class="pull-right"><span class="label label-default"><i class="fa fa-bookmark"></i> ID <c:out value="${legislation.id}"></c:out>.<c:out value="${legislation.version}"></c:out></span></div><h3 style="font-size: 24px !important;font-weight: bold !important;"><span class="legislation-title-name"> <c:out value="${legislation.name}"></c:out></span> &nbsp;
						  <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />"> <span class="legislation-title-econregion" style="font-size: 12px;"><c:out value="${legislation.economicRegion.name}"></c:out></span> 
						  <%-- <c:if test="${legislation.changedInLatestContentVersion}"><span style="font-size: 12px;" class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if> --%>
						  <c:if test="${legislation.legNew}"><span class="badge badge-danger" style="font-size: 12px;"><fmt:message key="newTitle" /></span></c:if>		
						  <c:if test="${legislation.changedInLatestContentVersionAmd}"><span class="badge badge-danger" style="font-size: 12px;"><fmt:message key="amdTitle" /></span></c:if>		</h3>
						 
						  </div>
			  <div class="panel-body">
			    	<div class="legislation-synopsis">									
									<scannell:text value="${legislation.synopsis}" htmlEscape="false" newlineEscape="true" />
				    </div>			
			  </div>
			</div>					
					</div>
							<div class="content">								
									<div class="header">
										<h3>
											<span class="legislation-title-name">
											<fmt:message key="statutoryInstrumentsTitle" /></span>
										</h3>
									</div>
									
								<div class="content">		
								<c:forEach items="${legislation.statutoryInstruments}" var="statutoryInstrument">				<!-- Added By Manjush on 15 Jan 2015  -->                                 
	                             
	                           <a href="#" class="list-group-item legAnchor"  style="overflow: hidden;" leg-id="${statutoryInstrument.id}" leg-regiLeg="${statutoryInstrument.registerType.id}">
							  <h4>							 
							     <c:choose>
							     <c:when test="${statutoryInstrument.dispalyOrder.id == 1}">
								 <div class="col-sm-1"><i class="fa fa-circle"></i>  </div>
								 </c:when>
								 <c:when test="${statutoryInstrument.dispalyOrder.id == 2}">
								 <div class="col-sm-1"><i class="fa fa-arrow-circle-down"></i> </div>
								 </c:when>
								 <c:otherwise>
								 <div class="col-sm-1"><i class="fa fa-circle-o"></i> </div> 
								  </c:otherwise>
								  </c:choose>								 
								
								<div class="col-sm-10">  
                                      <c:choose>
	                                  <c:when test="${empty text}">	
	                                  <c:out value="${statutoryInstrument.name}" escapeXml="false" /> <br> </c:when>
	                                  
	                                 <c:otherwise>${text} <br> </c:otherwise>
                                     </c:choose>
                                     
                                 </div>
                                <div style="float:right">
								<img src="<law:url value="/legal/images/${statutoryInstrument.economicRegion.id}.gif" />">
								<c:if test="${statutoryInstrument.legNew}"><span class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if>		
								<c:if test="${statutoryInstrument.changedInLatestContentVersionAmd}"><span class="badge badge-danger"><fmt:message key="amdTitle" /></span></c:if>															
								</div>
								</h4>
							    </a>	
								</c:forEach>
								</div>
								
								<div class="content">
									<div class="header">
										<h3><fmt:message key="relatedInformationTitle" /></h3>
									</div>
									<div class="content">
									<div class="list-group">
										<c:set var="relatedInformation" value="${legislation.relatedInformation}" />
										<c:if test="${empty relatedInformation}"><i class="fa fa-times"></i> &nbsp;<fmt:message key="none" /></c:if>
								<c:forEach items="${relatedInformation}" var="related">	                             
	                                    <a href="#" class="list-group-item legAnchor"  style="overflow: hidden;" leg-id="${related.id}" leg-regiLeg="${related.registerType.id}">
							           <h4>							 
							          <c:choose>
							         <c:when test="${related.dispalyOrder.id == 1}">
								     <div class="col-sm-1"><i class="fa fa-circle"></i>  </div>
								      </c:when>
								      <c:when test="${related.dispalyOrder.id == 2}">
								     <div class="col-sm-1"><i class="fa fa-arrow-circle-down"></i> </div>
								      </c:when>
								      <c:otherwise>
								     <div class="col-sm-1"><i class="fa fa-circle-o"></i> </div> 
								     </c:otherwise>
								    </c:choose>								 
								
								     <div class="col-sm-10">  
                                      <c:choose>
	                                  <c:when test="${empty text}">	
	                                  <c:out value="${related.name}" escapeXml="false" /> <br> </c:when>
	                                  
	                                 <c:otherwise>${text} <br> </c:otherwise>
                                     </c:choose>
                                     
                                    </div>
								<img src="<law:url value="/legal/images/${related.economicRegion.id}.gif" />">
								<%-- <c:if test="${related.changedInLatestContentVersion}"><span class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if> --%>	
								<c:if test="${related.legNew}"><span class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if>		
								<c:if test="${related.changedInLatestContentVersionAmd}"><span class="badge badge-danger"><fmt:message key="amdTitle" /></span></c:if>									
								</h4>
							    </a>	
								</c:forEach>										
				                </div>										
									</div>
									</div>
								
							</div>
						</div>
						
						<div class="col-xs-12 col-sm-8 col-md-8 col-lg-4" style="float: right;">
						<c:if test="${hasRiskLicence && viewType == 'relevant'}">												
              			</c:if>
              				<c:if test="${viewType == 'relevant'}">
								<div class="header">
									<h3><fmt:message key="complianceChecklists" /></h3>
								</div>
								<div class="content">							 			
							 			<c:forEach items="${legislation.relatedChecklists}" var="checklist">
							 			<c:choose>
                                        <c:when test="${not empty checklist.relevance && not empty checklist.compliance}">
                                        <div class="alert alert-info legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                        <i class="fa fa-check sign"></i><c:out value="${checklist.name}"  />
				                       </div>	
                                       </c:when>               
                                      <c:otherwise>
                                      <c:if test="${not empty checklist.relevance || not empty checklist.compliance}">
                                      <div class="alert alert-warning legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                      <i class="fa fa-warning"></i> <c:out value="${checklist.name}"  />
				                      </div>	
                                     </c:if>
                                     <c:if test="${empty checklist.relevance &&  empty checklist.compliance}">
                                     <div class="alert alert-danger legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                     <i class="fa fa-times-circle sign"></i><c:out value="${checklist.name}"  />
				                     </div>
				                     </c:if>              
                                    </c:otherwise>              
                                    </c:choose>												
									</c:forEach>							 		
								</div>
							</c:if>
							
								<div class="header">
									<h3><fmt:message key="timeTableTitle" /></h3>
								</div>
								<div class="content legislation-synopsis">
									<scannell:text value="${legislation.timetable}" htmlEscape="false"	newlineEscape="true" />
								</div>
							
							
								<div class="header">
									<h3><fmt:message key="changeHistoryTitle" /></h3>
								</div>
								<div class="content">
									<c:forEach items="${changeComment}"	var="item">
									 <div class="panel-group accordion accordion-semi" id="accordion<c:out value="${item.version}" />">
								    <div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse"
												data-parent="#accordion3" href="#${item.version}"> <i class="fa fa-angle-right"></i> 
												<span  class="badge"><fmt:message key='versionView'/> : <c:out value="${item.version}" /></span>
												<span style="float:right;"> <fmt:formatDate value="${item.publicationDate}"	pattern="dd MMMM yyyy" /></span>
												  
											</a>
										</h4>
									</div>
									<div id="${item.version}" class="panel-collapse collapse out"	>	
										<div class="panel-body"> 									
									    <div class="comment">${item.comment}</div>									
									    </div> <!-- Panel Body -->
								    </div>
							    </div>				
				
				                </div>
									
										
									</c:forEach>
								</div>
							
						</div>
						
						<div style="clear: both"></div>
						<br>
                        <jsp:include page="footerInclude.jsp" />
						<hr width="95%" noshade="" color="#666699">
						<div class="col-sm-12 col-md-12 col-lg-12">
							<div id="divBottom" class="block-flat">
							
							</div>
						</div>
					</div>
				<!-- </div> -->
			</div>
			
			        <c:forEach items="${lang}" var="item">	  
					<c:set var="language" value="${item.key}" />		  
					 <div class="tab-pane cont" id="language-${language.id}${language.name}">
					 <law:legislationView legislation="${legislation}" langId="${language.id}"/>
					 </div>
					 </c:forEach>
		</div>
	</div>
</div>



	

</body>
</html>
