<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="legislation" required="true" type="com.scannellsolutions.modules.law.domain.Legislation" %>
<%@ attribute name="langId" required="true" type="java.lang.Integer" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.Legislation"%>

<meta name="confidential" content="false">
<meta name="printCopyright" content="true">
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
<script type="text/javascript"
	src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			jQuery( "#frameMcont" ).removeClass( "cl-mcont" )
			}
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
		    var url;
		    url = '<law:url value="/law/legislation.htm?legRegister=" />' + jQuery(this).attr('leg-regiLeg') + '&legId=' + jQuery(this).attr('leg-id')+'&profileId='+jQuery('#profileSelect').val();
		    location.href = url;
		  });
		jQuery('.legAnchorCheck').on('click', function() {    	
		    var url;
		    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery(this).attr('leg-regi') + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true&checklistsPage=true';
		    location.href = url;
		  });
	});
function openPopUp(){
	window.open('<c:url value="/law/legislationRelatedRiskAssessments.htm"><c:param name="legId" value="${legislation.id}" /><c:param name="profileId" value="${profile.id}" /></c:url>', 'lawRelatedRisk','height=600,width=800,status=yes,toolbar=no,scrollbars=yes');  
	if (window.focus) {newwindow.focus()}
}
</script>

<!--<title>legislation</title>-->



 <div class="">
  <!--  	<div class="tab-container"> -->
<%--    		<ul class="nav nav-tabs">
   			<li class="active"><a href="#home" data-toggle="tab">English</a></li>
   			     <c:forEach items="${lang}" var="item">				           
				 <c:set var="language" value="${item.key}" />	<li>
				 <a href="#language-${language.id}" data-toggle="tab">${language.name}</a></li>						 
				 </c:forEach>	
   			
<!--    			<li><a href="#Francaise" data-toggle="tab">Francaise</a></li> -->

     
   		</ul> --%>
   		<div class="row">

</div>
   		
   		<!-- <div class="tab-content"> -->
			<!-- <div class="tab-pane active cont" id="home"> -->
   				<!-- <div class="cl-mcont"> -->
		    		<div class="row">
						<div class="col-xs-12 col-sm-8 col-md-8 col-lg-8 pull-left">
						<div class="content">
						<div class="panel panel-default">
						  <div class="panel-heading">
						  <div class="pull-right"><span class="label label-default"><i class="fa fa-bookmark"></i> ID <c:out value="${legislation.id}"></c:out></span></div><h3 style="font-size: 24px;"><span class="legislation-title-name"> 
						  <c:forEach items="${legislation.alternateLanguageNames}" var="altNameLe">	 
							 	      <c:if test="${altNameLe.key.id == langId}">	
							 	       <c:out value="${altNameLe.value}" escapeXml="false" />								     
								      </c:if>
								      </c:forEach>
						 
						  <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />"> <span class="legislation-title-econregion" style="font-size: 12px;"><c:out value="${legislation.economicRegion.name}"></c:out></span></h3></div>
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
											<fmt:message key='statutoryInstrumentsTitle'/></span>
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
                                      <%-- <c:choose>
	                                  <c:when test="${empty text}">
	                                  	
	                                  <c:out value="${statutoryInstrument.name}" escapeXml="false" /> <br> </c:when>
	                                  
	                                 <c:otherwise>${text} <br> </c:otherwise>
                                     </c:choose> --%>
                                     <c:forEach items="${statutoryInstrument.alternateLanguageNames}" var="altName">	 
							 	<c:if test="${altName.key.id == langId}">							 			
								<div class="col-sm-10"><c:out value="${altName.value}"  />  </div>
								 </c:if>
								 </c:forEach>
                                     
                                 </div>
								<img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
								<c:if test="${legislation.changedInLatestContentVersionIncludingChildren}"><span class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if>								
								</h4>
							    </a>	
								</c:forEach>
								</div>
								
								<div class="content">
									<div class="header">
									
										<h3><fmt:message key='relatedInfo'/></h3>
									</div>
									<div class="content">
									<div class="list-group">
										<c:set var="relatedInformation" value="${legislation.relatedInformation}" />
										<c:if test="${empty relatedInformation}"><i class="fa fa-times"></i>&nbsp;<fmt:message key='none'/></c:if>
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
								      <c:forEach items="${related.alternateLanguageNames}" var="altNameRe">	 
							 	      <c:if test="${altNameRe.key.id == langId}">							 			
								      <div class="col-sm-10"><c:out value="${altNameRe.value}"  />  </div>
								      </c:if>
								      </c:forEach>
                                  <%--     <c:choose>
	                                  <c:when test="${empty text}">	
	                                  <c:out value="${related.name}" escapeXml="false" /> <br> </c:when>
	                                  
	                                 <c:otherwise>${text} <br> </c:otherwise>
                                     </c:choose> --%>
                                     
                                    </div>
								<img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
								<c:if test="${legislation.changedInLatestContentVersionIncludingChildren}"><span class="badge badge-danger"><fmt:message key="newTitle" /></span></c:if>								
								</h4>
							    </a>	
								</c:forEach>
				
											<%-- <img src="<law:url value="/legal/images/${related.economicRegion.id}.gif" />">
											<c:if test="${related.changedInLatestContentVersion}">
												<img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />">
											</c:if>
											<law:legislationLink legislation="${related}"		profile="${profile}" viewType="${viewType}" /> --%>
				                </div>
										
									</div>
									</div>
								
							</div>
						</div>
						
						<div class="col-xs-12 col-sm-8 col-md-8 col-lg-4" style="float: right;">
						<c:if test="${hasRiskLicence}">
						<!-- <div class="block-flat" style="text-align: right;padding: 0px 20px;">							
						<button type="button" class="btn btn-danger"  onclick="openPopUp();"><i class="fa fa-search"></i> Risk</button>						
						</div> -->							
              			</c:if>
              				
								<div class="header">
									<h3><fmt:message key='complianceChecklists'/></h3>
								</div>
								<div class="content">							 			
							 			<c:forEach items="${legislation.relatedChecklists}" var="checklist">
							 			 <c:forEach items="${checklist.alternateLanguageNames}" var="altNameCh">	 
							 	      <c:if test="${altNameCh.key.id == langId}">	
							 	       								     
								     
								      
							 			<c:choose>
                                        <c:when test="${not empty checklist.relevance && not empty checklist.compliance}">
                                        <div class="alert alert-info legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                        <i class="fa fa-check sign"></i><c:out value="${altNameCh.value}" escapeXml="false" />
				                       </div>	
                                       </c:when>               
                                      <c:otherwise>
                                      <c:if test="${not empty checklist.relevance || not empty checklist.compliance}">
                                      <div class="alert alert-warning legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                      <i class="fa fa-warning"></i> <c:out value="${altNameCh.value}" escapeXml="false" />
				                      </div>	
                                     </c:if>
                                     <c:if test="${empty checklist.relevance &&  empty checklist.compliance}">
                                     <div class="alert alert-danger legAnchorCheck" style="cursor:pointer" check-id="${checklist.id}" leg-regi="${checklist.registerType.id}">
                                     <i class="fa fa-times-circle sign"></i><c:out value="${altNameCh.value}" escapeXml="false" />
				                     </div>
				                     </c:if>              
                                    </c:otherwise>              
                                    </c:choose>	
                                     </c:if>
                                    </c:forEach>											
									</c:forEach>							 		
								</div>
							
							
								<div class="header">
									<h3><fmt:message key='timeTableTitle'/></h3>
								</div>
								<div class="content">
									<scannell:text value="${legislation.timetable}" htmlEscape="false"
										newlineEscape="true" />
								</div>
							
							
								<div class="header">
									<h3><fmt:message key='changeHistory'/></h3>
								</div>
								<div class="content">
									<c:forEach items="${legislation.changeCommentsNewestFirst}"	var="item">
									 <div class="panel-group accordion accordion-semi" id="accordion<c:out value="${item.version}" /><c:out value='${langId}' />">
								    <div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse"
												data-parent="#accordion3" href="#${item.version}<c:out value='${langId}' />"> <i class="fa fa-angle-right"></i> 
												<span  class="badge"><fmt:message key='versionView'/> : <c:out value="${item.version}" /></span>
												<span style="float:right;"> <fmt:formatDate value="${item.publicationDate}"	pattern="dd MMMM yyyy" /></span>
												  
											</a>
										</h4>
									</div>
									<div id="${item.version}<c:out value='${langId}' />" class="panel-collapse collapse out"	>	
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
							<div class="block-flat">
							
							</div>
						</div>
					</div>
				<!-- </div> -->
			<!-- </div> -->
			
			<%-- <c:forEach items="${lang}" var="item">	  
					<c:set var="language" value="${item.key}" />		  
					 <div class="tab-pane cont" id="language-${language.id}">
					 <law:legislationView legislation="${legislation}" />
					 </div>
					 </c:forEach> --%>
		<!-- </div> -->
	<!-- </div> -->
</div> 
 