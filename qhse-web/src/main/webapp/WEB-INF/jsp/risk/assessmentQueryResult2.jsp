<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="assessmentQueryResult.title" /></title>
 
</head>
<body>
<script type="text/javascript">
	
	jQuery(document).ready(function() {
		setFooterColSpan();
		initSortTablesForClass('dataTableRA');
	} );
	
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/risk/assessmentView.htm?id=${result.results[0].id}';
		}
	}
</script>
<c:set var="found" value="${!empty result.results}" />

<jsp:include page="showCurrentThreshold.jsp" /> 

<div class="header">
<h2><fmt:message key="assessmentQueryResult.searchResults" /></h2>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel">
<c:choose>
	    <c:when test="${groupSite == true}">
	    	<c:forEach items="${sites}" var="site" varStatus="s">     
	    		<table class="table table-bordered table-responsive dataTableRA">
		     		<c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption></c:if>
					  <thead>
					    
					    <c:if test="${found}">
					    <tr>
					      	<th><fmt:message key="id" /></th>
					    	<th><fmt:message key="assessment.title" /></th> 
					    	<th><fmt:message key="assessment.department" /></th> 
					    	<th><fmt:message key="assessment.approvalByUser" /></th>   
					     	<th><fmt:message key="assessment.responsibleUser" /></th>
					      
					       	<th><fmt:message key="assessment.score" /></th>
					       	<th><fmt:message key="assessment.lastReviewedDate" /></th>
					      	<c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
					      	<th class="printColumn">Print</th>
					    </tr>
					    </c:if>
					  </thead>
					
					  <tbody>
	    		
				      		<c:forEach items="${result.results}" var="assessment" varStatus="s">
						    	<c:if test="${assessment.site.name == site}">
							      <c:choose>
							        <c:when test="${s.index mod 2 == 0}">
							          <c:set var="style" value="even" />
							        </c:when>
							        <c:otherwise>
							          <c:set var="style" value="odd" />
							        </c:otherwise>
							      </c:choose>
							      <risk:assessment2 assessment="${assessment}" style="${style}" showSiteColumn="false" template="${template}"/>
							    </c:if>
						    </c:forEach> 
					</tbody>
				</table> 
			</c:forEach>  
    	</c:when> 
	    <c:otherwise>
		    <c:if test="${found}">
		          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
		    </c:if>
	    	<table class="table table-bordered table-responsive dataTableRA">
			  <thead>
			    
			    <c:if test="${found}">
			    <tr>
			      	<th><fmt:message key="id" /></th>
			    	<th><fmt:message key="assessment.title" /></th> 
			    	<th><fmt:message key="assessment.department" /></th> 
			    	<th><fmt:message key="assessment.approvalByUser" /></th>   
			     	<th><fmt:message key="assessment.responsibleUser" /></th>
			      
			       	<th><fmt:message key="assessment.score" /></th>
			       	<th><fmt:message key="assessment.lastReviewedDate" /></th>
			      	<c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
			      	<th class="printColumn">Print</th>
			    </tr>
			    </c:if>
			  </thead>
			
			  <tbody>
					<c:forEach items="${result.results}" var="assessment" varStatus="s">
					      <c:choose>
					        <c:when test="${s.index mod 2 == 0}">
					          <c:set var="style" value="even" />
					        </c:when>
					        <c:otherwise>
					          <c:set var="style" value="odd" />
					        </c:otherwise>
					      </c:choose>
						  <risk:assessment2 assessment="${assessment}" style="${style}" showSiteColumn="${showSiteColumn}" template="${template}"/>
				    </c:forEach>	  
					<tfoot>
					    <c:if test="${found}">
						    <tr>
						      <td><scannell:paging result="${result}" /></td>
						    </tr>
					    </c:if>
				    </tfoot>
			</tbody>
		</table>  
	</c:otherwise>
  </c:choose>
    
</div>
</div>
</div>
</body>
</html>
