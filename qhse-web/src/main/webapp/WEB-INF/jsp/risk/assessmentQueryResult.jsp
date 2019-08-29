<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  	<style type="text/css" media="all">
		@import "<c:url value='/css/risk.css'/>";
	</style>
	<style type="text/css">
		/* Style the Image Used to Trigger the Modal */
		body {
		    background-color: white;
		} 
	</style>
  	<title><fmt:message key="assessmentQueryResult.title" /></title>    
</head>
<body bgcolor="#E6E6F;">
	<script type="text/javascript">
		jQuery(document).ready(function() {
			setFooterColSpan();
			jQuery(".popup-content+button").hide();
			initSortTablesForClass('dataTableRA');
			jQuery('table.templateTable').each(function(e){
				setFooterColSpanById(jQuery(this).attr('id'))
				initSortTablesForId(jQuery(this).attr('id'));
		    });
			 jQuery('select').select2();
			 if(getURLParam('comeFromLaw') == 'true'){
			 jQuery( ".div-for-pagination" ).find('select').select2('destroy').hide();
			 }
		} );
		if (typeof backChangeSelectNames !== 'undefined' && $.isFunction(backChangeSelectNames)) {
		 	backChangeSelectNames();
		 }
		
		if('${searchByLegacyId}' == 'true'){
			if('${fn:length(result.results)}' == '1'){
				location.href = '${pageContext.request.contextPath}' + '/risk/assessmentView.htm?id=${result.results[0].id}';
			}
		}
	</script>
<c:set var="found" value="${!empty result.results}" />
<c:if test="${fromLaw }">
	<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button> 
</c:if>
<jsp:include page="showCurrentThreshold.jsp" /> 
<c:if test="${fromLaw }">
<div class="row" style="padding-left: 10px;padding-right: 10px;">
<div id="block" class="block-flat">
</c:if>
<div class="header">
<h3><fmt:message key="assessmentQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
 

<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
	<c:choose>
	    <c:when test="${groupSite == true}">
	    	<div class="panel" >
	    	<c:forEach items="${sites}" var="site" varStatus="s">
	    		<c:forEach items="${templateResults}" var="result" varStatus="templateStatus">
			    	<c:set var="found" value="${!empty result.results}" />
					<c:choose>
				    	<c:when test="${found}">
							<c:set var="recordsExists" value="true"/>
				    		<c:forEach items="${result.results}" var="assessment" varStatus="s">
				    			<c:if test="${site.id == assessment.site.id}">	
									<c:if test="${s.index == 0}">
						    		<div class="panel" >
							    	<table id="RA${assessment.template.id}" class="table table-responsive table-bordered templateTable">
				     					<c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption><c:set var="previousSiteTittle" value="${assessment.site.name}" scope="page"/></c:if>
						  				<thead>
											    <tr>
											      <th><fmt:message key="id" />/<fmt:message key="assessment.name" /></th> 
											      	<c:choose>
	        											<c:when test="${assessment.type eq riskType}">    
	        												<th><fmt:message key="assessment.department" /></th> <c:set var="siteTittleColspan" value="${siteTittleColspan + 1 }" scope="page"/>
	        											</c:when>
	        											<c:otherwise>
		        											<c:forEach var="q" items="${assessment.template.summaryQuestions}">
														      	<c:if test="${q.active and q.visible}">
														      	<th><c:out value="${q.name}" /></th><c:set var="siteTittleColspan" value="${siteTittleColspan + 1 }" scope="page"/>
														      	</c:if>
														     </c:forEach>    
	        											</c:otherwise>
        											</c:choose>
									  			  <th><fmt:message key="assessment.status" /></th> 
												  <th><fmt:message key="assessment.approvalByUser" /></th>      
											      <th><fmt:message key="assessment.responsibleUser" /></th>
											      <c:if test="${assessment.template.scorable}">
											      	<th><fmt:message key="assessment.score" /></th><c:set var="siteTittleColspan" value="${siteTittleColspan + 1 }" scope="page"/>
											      </c:if>
											      <th style="width: 150px"><fmt:message key="assessment.lastReviewedDate" /></th>
											      
											      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th><c:set var="siteTittleColspan" value="${siteTittleColspan + 1 }" scope="page"/></c:if>
											      <th>Print</th> 
											    </tr>
										  </thead>
										  <tbody>
										            <c:forEach items="${result.results}" var="assessment" varStatus="s">
										            <c:if test="${previousSiteTittle != assessment.site.name }"><caption>${assessment.site}</caption></c:if>
													<c:if test="${groupSite == true}"><c:set var="previousSiteTittle" value="${assessment.site.name}" scope="page"/></c:if>
									  				<risk:assessment assessment="${assessment}" style="${style}" showSiteColumn="${false}" riskType="${riskType}" template="${assessment.template}" showLegacyIds="${showLegacyId}" showAllRA="${showAllRA}"/>
												    </c:forEach>
										</tbody>
										
									</table>
									</div>	
								  				</c:if><!-- if s.last -->
							</c:if><!-- if site -->
						</c:forEach>
					</c:when>
					<c:when test="${templateStatus.index == 0 && templateStatus.last}">
						<c:set var="recordsExists" value="true"/>
						<div class="panel" >
					    	<table class="table table-responsive table-bordered datatable dataTableRA">
					    	</table>
					    </div>
					</c:when>
				</c:choose>
			</c:forEach> 
			<c:if test="${recordsExists != 'true'}">
				<div class="panel" >
			    	<table class="table table-responsive table-bordered datatable dataTableRA">
			    	</table>
			    </div>
			</c:if>
			</c:forEach>
			<c:if test="${empty sites}">
				<table class="table table-responsive table-bordered datatable dataTableRA">
				<thead>
		     		<tr>
		     			<th><fmt:message key="id" />/<fmt:message key="assessment.name" /></th>
		     			<th><fmt:message key="assessment.department" /></th>
		     			<th><fmt:message key="assessment.status" /></th> 
					  	<th><fmt:message key="assessment.approvalByUser" /></th>      
				      	<th><fmt:message key="assessment.responsibleUser" /></th>
				      	<th style="width: 150px"><fmt:message key="assessment.lastReviewedDate" /></th>
		     		</tr>
		     	</thead>
			    	</table>
			</c:if>
			</div>
    	</c:when> 
	    <c:otherwise> 
	    	<c:forEach items="${templateResults}" var="result" varStatus="templateStatus">
				<c:set var="found" value="${!empty result.results}" />
					<c:choose>
				    	<c:when test="${found}">
							<c:set var="recordsExists" value="true"/>
				    		<c:forEach items="${result.results}" var="assessment" varStatus="s">
				    				
								<c:if test="${s.index == 0}">
						    		<div class="panel" > 
						          	<div class="div-for-pagination"><scannell:paging result="${result}" /></div>
							    	<table id="RA${assessment.template.id}" class="table table-responsive table-bordered templateTable">
										  <thead>
											    <tr>
											      <th><fmt:message key="id" />/<fmt:message key="assessment.name" /></th> 
											      	<c:choose>
	        											<c:when test="${assessment.type eq riskType}">    
												        	<c:forEach items="${assessment.answers}" var="answer" varStatus="h">
																<c:choose> 
																	<c:when test="${answer.question.id eq '42'  and prevanswer ne '42'}">
																			<c:set var="prevanswer" value="${answer.question.id}" scope="page"/>
																			<th><fmt:message key="departmentResponsible" /></th>
															    	</c:when>	
															    </c:choose>
															</c:forEach> 
	        											</c:when>
	        											<c:otherwise>
		        											<c:forEach var="sq" items="${assessment.template.summaryQuestions}">
														      	<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
														        	<c:if test="${g.active}">
														        		<c:forEach items="${g.questions}" var="q">
														        			<c:if test="${sq.id == q.id and q.active and q.visible}">
																	      		<th><c:out value="${q.name}" /></th>
																	      	</c:if>
														        			<c:if test="${!empty q.columns}">
														        				<c:forEach items="${q.columns}" var="childQ">
														        					<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
														        						<th><c:out value="${q.name}" /></th>
														        					</c:if>
														        				</c:forEach>
														        			</c:if>
																	     </c:forEach>   
																	</c:if>
																</c:forEach>
															</c:forEach> 
	        											</c:otherwise>
        											</c:choose>
									  			  <th><fmt:message key="assessment.status" /></th> 
												  <th><fmt:message key="assessment.approvalByUser" /></th>      
											      <th><fmt:message key="assessment.responsibleUser" /></th>
											      <c:if test="${assessment.template.scorable}">
											      	<th><fmt:message key="assessment.score" /></th>
											      </c:if>
											      <th style="width: 150px"><fmt:message key="assessment.lastReviewedDate" /></th>
											      <c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
											      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
											      <th class="printColumn">Print</th> 
											    </tr>
										  </thead>
										  <tbody>
										  
									</c:if>
						  				<risk:assessment assessment="${assessment}" style="${style}" showSiteColumn="${showSiteColumn}" riskType="${riskType}" template="${assessment.template}" showLegacyIds="${showLegacyId}" showAllRA="${showAllRA}"/>
									<c:if test="${s.last}">
										<tfoot>
										    <tr>
										      <td><scannell:paging result="${result}" /></td>
										    </tr>
									    </tfoot>
								</tbody>
							</table>
						</div>	
								    </c:if>
						</c:forEach>
					</c:when>
					<c:when test="${templateStatus.index == 0 && templateStatus.last}">
						<c:set var="recordsExists" value="true"/>
						<div class="panel" >
					    	<table class="table table-responsive table-bordered datatable dataTableRA">
					    	</table>
					    </div>
					</c:when>
				</c:choose>
			</c:forEach> 
			<c:if test="${recordsExists != 'true'}">
				<div class="panel" >
			    	<table class="table table-responsive table-bordered datatable dataTableRA">
			    	</table>
			    </div>
			</c:if>
	    </c:otherwise>
    </c:choose>
</div>
</div>
<c:if test="${fromLaw }">
</div>
</div>
</c:if>
</body>
</html>
