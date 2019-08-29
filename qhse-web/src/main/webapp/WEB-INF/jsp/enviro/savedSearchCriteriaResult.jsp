<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Saved Search Criteria Result</title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery('select').select2();
			initSortTablesForClass('dataTableSC');
			 
		} );
	</script>
<c:set var="found" value="${result != null}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >3</c:when> 
	  <c:otherwise>4</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
	<h3><fmt:message key="savedSearchCrRe" /></h3>
</div>
<div class="content">  
	<div class="table-responsive">
		<div class="panel" >
	        <c:if test="${found}">
	          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
	        </c:if>
			<table class="table table-bordered table-responsive dataTableSC">
			  <thead>
			    <c:if test="${found}">
			    <tr>
			      <th><fmt:message key="id" /></th>
			      <th><fmt:message key="name" /></th>
			      
			      <th><fmt:message key="createdBy" /></th>
			      <th><fmt:message key="delete" /></th>
			    </tr>
			    </c:if>
			  </thead>

			  <tbody>
					<c:forEach items ="${result.results}"  var="criteria" varStatus="s" >
						<c:choose>
								        <c:when test="${s.index mod 2 == 0}">
								          <c:set var="style" value="even" />
								        </c:when>
								        <c:otherwise>
								          <c:set var="style" value="odd" />
								        </c:otherwise>
								      </c:choose>
						 <tr class="${style }">
						  	<td  style="font-weight:bold;"> 
						  		<c:out value="${criteria.id}" />
						  	</td>
						  	<td  style="font-weight:bold;"> 
						  		<a href="<c:url value="${criteria.urlSearch }" />?criteriaId=${criteria.id}"><c:out value="${criteria.name}" /> </a> 
						  	</td>
						  	
						  	<td  style="font-weight:bold;"> 
						  		<c:out value="${criteria.createdByUser.displayName}" />
						  	</td>
						  	<td  style="font-weight:bold; width:20%"> 
						  		<button type="button" onClick="deleteSearchCriteria('${criteria.id}');"><fmt:message key="delete" /> </button>
						  	</td>
						  </tr>
					</c:forEach>
					
				  </tbody>
				  <tfoot>
					    <c:if test="${found}">
					    <tr>
					      <td colspan="${colspan}"> <scannell:paging result="${result}" /> </td>
					    </tr>
					    </c:if>
					    <c:if test="${found == false}">
					    <tr>
					      <td colspan="${colspan}"> <fmt:message key="search.empty" /></td>
					    </tr>
					    </c:if>
					 </tfoot>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
