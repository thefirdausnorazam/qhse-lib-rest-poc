<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="managementProgrammeQueryResult.title" /></title>
 
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTablesForClass('dataTableMP', 'YES');
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/risk/managementProgrammeView.htm?id=${result.results[0].id}';
		}
	}
	
</script>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn and not groupSite}" >6</c:when> 
	  <c:otherwise>5</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3><fmt:message key="managementProgrammeQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel" >
	<c:choose>
	     <c:when test="${!found}">
	     	<table class="table table-bordered  table-responsive dataTableMP">
	     	<thead>    
			    <tr>
			      <th><fmt:message key="id" /></th>
			      <th><fmt:message key="managementProgramme.name" /></th>
			      <th><fmt:message key="managementProgramme.targetCompletionDate" /></th>
			      <th><fmt:message key="managementProgramme.status" /></th>
			      <th><fmt:message key="managementProgramme.responsibleUser" /></th>
	 			  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
			    </tr>
			</thead>
	     	</table>
	     </c:when>
    <c:otherwise>
		<c:choose>
		    <c:when test="${groupSite == true}">
		    <c:forEach items="${sites}" var="site" varStatus="s">
		    	<table class="table table-bordered table-responsive dataTableMP">
			   		<c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption></c:if>
				  <thead>    
				    <tr>
				      <th><fmt:message key="id" /></th>
				      <th><fmt:message key="managementProgramme.name" /></th>
				      <th><fmt:message key="managementProgramme.targetCompletionDate" /></th>
				      <th><fmt:message key="managementProgramme.status" /></th>
				      <th><fmt:message key="managementProgramme.responsibleUser" /></th>
		 			  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
				    </tr>
				  </thead>
				
				  <tbody>
				    	<%-- <c:forEach items="${sites}" var="site" varStatus="s">  --%>    
				      		<c:forEach items="${result.results}" var="programme" varStatus="s">
					      		<c:if test="${programme.site.name == site}">
								      <c:choose>
								        <c:when test="${s.index mod 2 == 0}">
								          <c:set var="style" value="even" />
								        </c:when>
								        <c:otherwise>
								          <c:set var="style" value="odd" />
								        </c:otherwise>
								      </c:choose>
						      <risk:managementProgramme programme="${programme}" style="${style}" showSiteColumn="false" showLegacyIds="${showLegacyId}"/>
								 </c:if>
				      		</c:forEach>
				      	<%-- </c:forEach> --%>
		      	
					
				  </tbody>
				</table>
				</c:forEach>
		    </c:when> 
		    <c:otherwise>
			    <c:if test="${found}">
			          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
			    </c:if>
		    	<table class="table table-bordered table-responsive dataTableMP">
		    		<thead>    
						    <tr>
						      <th><fmt:message key="id" /></th>
						      <th><fmt:message key="managementProgramme.name" /></th>
						      <th><fmt:message key="managementProgramme.targetCompletionDate" /></th>
						      <th><fmt:message key="managementProgramme.status" /></th>
						      <th><fmt:message key="managementProgramme.responsibleUser" /></th>
							  <c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
							  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
						    </tr>
					  </thead>
					  <tbody>
						  	<c:forEach items="${result.results}" var="programme" varStatus="s">
						  	
					      		<c:choose>
							        <c:when test="${s.index mod 2 == 0}">
							          <c:set var="style" value="even" />
							        </c:when>
							        <c:otherwise>
							          <c:set var="style" value="odd" />
							        </c:otherwise>
						      	</c:choose>
			      	<risk:managementProgramme programme="${programme}" style="${style}" showSiteColumn="${showSiteColumn}" showLegacyIds="${showLegacyId}"/>
						      	 
					    	</c:forEach>
				    		<tfoot>
						    <c:if test="${found}">
							    <tr>
	      <td colspan="${colspan }"><scannell:paging result="${result}" /></td>
							    </tr>
						    </c:if>
						 </tfoot>
					  </tbody>
		    	</table>
		    </c:otherwise>
		</c:choose>
	</c:otherwise>
	</c:choose>
</div>
</div>
</div>
</body>
</html>
