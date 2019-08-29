<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="taskQueryResult.title" /></title>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTablesForClass('dataTableTask');
		
		//jQuery('.dataTableTask').find('th').eq(0).addClass('sortByNumber');
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/risk/taskView.htm?id=${result.results[0].id}';
		}
	}
</script>
</head>
<body>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >7</c:when> 
	  <c:otherwise>6</c:otherwise> 
	</c:choose> 
</c:set>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="taskQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel" >
	<c:choose>
	     <c:when test="${!found}">
	     	<table class="table table-bordered  table-responsive dataTableTask">
	     		<thead>    
			    	<tr>
				      <th><fmt:message key="id" /></th>
				      <th><fmt:message key="task.name" /></th>
				      <th><fmt:message key="task.status" /></th>
				      <th><fmt:message key="department" /></th>
				      <th><fmt:message key="task.responsibleUser" /></th>
				      <th><fmt:message key="task.targetCompletionDate" /></th>
	    				  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
				    </tr>
			 	</thead>
	     	</table>
	     </c:when>
    <c:otherwise>
		<c:choose>
		    <c:when test="${groupSite == true}">
		    	<c:forEach items="${sites}" var="site" varStatus="s">   
			    	<table class="table table-bordered table-responsive dataTableTask">
			    		<c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption></c:if>
					  <thead>    
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="task.name" /></th>
					      <th><fmt:message key="task.status" /></th>
					      <th><fmt:message key="department" /></th>
					      <th><fmt:message key="task.responsibleUser" /></th>
					      <th><fmt:message key="task.targetCompletionDate" /></th>
	     				  <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
					    </tr>
					  </thead>
					
					  <tbody>  
			      		
				      		<c:forEach items ="${result.results}"  var="task" varStatus="s">
				      			<c:if test="${task.site.name == site}">
								      <c:choose>
								        <c:when test="${s.index mod 2 == 0}">
								          <c:set var="style" value="even" />
								        </c:when>
								        <c:otherwise>
								          <c:set var="style" value="odd" />
								        </c:otherwise>
								      </c:choose>
						      <risk:task task="${task}" style="${style}" showSiteColumn="false" showLegacyIds="${showLegacyId}"/>
								 </c:if>
						    </c:forEach>
						    
					  </tbody>
					</table>  
		      	</c:forEach>
		    </c:when> 
		    <c:otherwise>
			    <c:if test="${found}">
			         <div class="div-for-pagination"> <scannell:paging result="${result}" /></div>
			    </c:if>
		    	<table class="table table-bordered table-responsive dataTableTask">
				  <thead>    
				    <tr>
				      <th class="sortByNumber"><fmt:message key="id" /></th>
				      <th><fmt:message key="task.name" /></th>
				      <th><fmt:message key="task.status" /></th>
				      <th><fmt:message key="department" /></th>
				      <th><fmt:message key="task.responsibleUser" /></th>
				      <th><fmt:message key="task.targetCompletionDate" /></th>
				      <c:if test="${showSiteColumn}">
				      	<th><fmt:message key="site" /></th>
				      </c:if>
				      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
				    </tr>
				  </thead>
				
				  <tbody>
				    <c:forEach items ="${result.results}"  var="task" varStatus="s">
				      <c:choose>
				        <c:when test="${s.index mod 2 == 0}">
				          <c:set var="style" value="even" />
				        </c:when>
				        <c:otherwise>
				          <c:set var="style" value="odd" />
				        </c:otherwise>
				      </c:choose>
			      <risk:task task="${task}" style="${style}" showSiteColumn="${showSiteColumn}" showLegacyIds="${showLegacyId}"/>
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
