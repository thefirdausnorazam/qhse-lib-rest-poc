<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html">
<html>
<head>
  	<title><fmt:message key="targetQueryResult.title" /></title>   
  <style type="text/css" media="all">    
     @import "<c:url value='/css/risk.css'/>";
  </style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTablesForClass('dataTableTarget');
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/risk/targetView.htm.htm?id=${result.results[0].id}';
		}
	}
</script>
</head>
<body>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >6</c:when> 
	  <c:otherwise>5</c:otherwise> 
	</c:choose> 
</c:set>
<c:if test="${showLegacyId}"><c:set var="colspan" value="${colspan + 1}" /></c:if>
<div class="header">
<h3><fmt:message key="targetQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel" >
	<c:choose>
	     <c:when test="${!found}">
	     	<table class="table table-bordered  table-responsive dataTableTarget">
	     		<thead style="text-align: center;">    
				    <tr>
				      <th><fmt:message key="id" /></th>
				      <th><fmt:message key="target.name" /></th>
				      <th><fmt:message key="target.targetCompletionDate" /></th>
				      <th><fmt:message key="target.status" /></th>
				      <th><fmt:message key="target.responsibleUser" /></th>
                      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
				    </tr>
		  		</thead>
	     	</table>
	     </c:when>
    <c:otherwise>
		<c:choose>
		    <c:when test="${groupSite == true}">
		    	<c:forEach items="${sites}" var="site" varStatus="s">  
		    		<table class="table table-bordered table-responsive dataTableTarget">
			   			<caption><c:out value="${site}" /></caption>
						  <thead style="text-align: center;">    
						    <tr>
						      <th><fmt:message key="id" /></th>
						      <th><fmt:message key="target.name" /></th>
						      <th><fmt:message key="target.targetCompletionDate" /></th>
						      <th><fmt:message key="target.status" /></th>
						      <th><fmt:message key="target.responsibleUser" /></th>
		                      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
						    </tr>
						  </thead>
						
						  <tbody>
	       
					      		<c:forEach items ="${result.results}"  var="target" varStatus="s">
					      			<c:if test="${target.site.name == site}">
									      <c:choose>
									        <c:when test="${s.index mod 2 == 0}">
									          <c:set var="style" value="even" />
									        </c:when>
									        <c:otherwise>
									          <c:set var="style" value="odd" />
									        </c:otherwise>
									      </c:choose>
				      		  <risk:target target="${target}" style="${style}" showSiteColumn="false" showLegacyIds="${showLegacyId}"/>
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
		    	<table class="table table-bordered table-responsive dataTableTarget">
			   			<c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption></c:if>
						  <thead style="text-align: center;">    
						    <tr>
						      <th><fmt:message key="id" /></th>
						      <th><fmt:message key="target.name" /></th>
						      <th><fmt:message key="target.targetCompletionDate" /></th>
						      <th><fmt:message key="target.status" /></th>
						      <th><fmt:message key="target.responsibleUser" /></th>
							  <c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
							  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
						    </tr>
						  </thead>
						
						  <tbody>
							    <c:forEach items="${result.results}" var="target" varStatus="s">
								      <c:choose>
								        <c:when test="${s.index mod 2 == 0}">
								          <c:set var="style" value="even" />
								        </c:when>
								        <c:otherwise>
								          <c:set var="style" value="odd" />
								        </c:otherwise>
								      </c:choose>
				      <risk:target target="${target}" style="${style}" showSiteColumn="${showSiteColumn}" showLegacyIds="${showLegacyId}"/>
								</c:forEach>
								<tfoot> 
								    <c:if test="${found}">
									    <tr>
									      <td colspan="${colspan}"><scannell:paging result="${result}" /></td>
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
