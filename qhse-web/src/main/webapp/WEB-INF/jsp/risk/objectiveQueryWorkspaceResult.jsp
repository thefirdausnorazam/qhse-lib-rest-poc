<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>

<!DOCTYPE html">
<html>
<head>
  <title><fmt:message key="objectiveQueryResult.title" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTablesForClass('dataTableRisk');
	});
</script>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >7</c:when> 
	  <c:otherwise>6</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3>
<fmt:message key="objectiveQueryResult.searchResults" />
</h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel" > 
	<c:forEach items="${sites}" var="site" varStatus="s">     
		<c:if test="${found}">
          	<scannell:paging result="${result}" />
    	</c:if>
		<table class="table table-bordered table-responsive dataTableRisk">
		   <c:if test="${groupSite == true}"><caption><c:out value="${site}" /></caption></c:if>
		  <thead style="text-align: center;">   
		    <c:if test="${found}">
		    <tr>
		      <th><fmt:message key="id" /></th>
		      <th><fmt:message key="objective.name" /></th>
		      <th><fmt:message key="objective.category" /></th>
		      <th><fmt:message key="objective.targetCompletionDate"/></th>
		      <th><fmt:message key="objective.status" /></th>
		      <th><fmt:message key="objective.sponsor" /></th>
			  <c:if test="${showSiteColumn and not groupSite}"><th><fmt:message key="site" /></th></c:if>
		    </tr>
		    </c:if>
		  </thead>
		
		  <tbody>
		      		<c:forEach items ="${result.results}"  var="objective" varStatus="s">
		      			<c:if test="${objective.site.name == site}">
						      <c:choose>
						        <c:when test="${s.index mod 2 == 0}">
						          <c:set var="style" value="even" />
						        </c:when>
						        <c:otherwise>
						          <c:set var="style" value="odd" />
						        </c:otherwise>
						      </c:choose>
						      <risk:objective objective="${objective}" style="${style}" showSiteColumn="false" showLegacyIds="${showLegacyId}"/>
						 </c:if>
				    </c:forEach> 
			    <tfoot>
				    <c:if test="${found}">
					    <tr>
					      <td colspan="6"><scannell:paging result="${result}" /></td>
					    </tr>
				    </c:if>
			    </tfoot>
	  	</tbody>
	</table> 
</c:forEach>
</div>
</div>
</div>
</body>
</html>
