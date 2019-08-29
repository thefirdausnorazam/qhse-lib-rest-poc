<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="linkSearch" /></title>
  <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
	<script type="text/javascript">
		jQuery(document).ready(function() {
			//initSortTables();
			
			$('#testTable').dataTable( {
				"paging": true,
			    "pagingType": "simple",
			    "pageLength": 20,
			    "language": {
		            "lengthMenu": "_MENU_ ",
		            "zeroRecords": "Nothing found ",
		            "info": "Page _PAGE_ of _PAGES_",
		            "infoEmpty": "No records available",
		            "infoFiltered": "(filtered from _MAX_ total records)",
		            "paginate": {
		            	"previous": "[Prev] ",
		            	"next": "  [Next]"
		              },
		            "search": "Search On Page:"
		        }
			} );
			jQuery("select[name=testTable_length] option").each(function (){
				jQuery(this).text(jQuery(this).text() + " Records");
			});
			
			jQuery("select[name=testTable_length]").select2({width: "155px"});
			jQuery("select[name=testTable_length]").css({"margin-left": "10px"});
			jQuery("select[name=testTable_length]").after(jQuery("#testTable_paginate"));
			jQuery("#testTable_paginate").css({"float":"left", "margin-left": "10px", "margin-right": "10px"});
			
		} );
		
	</script>
</head>
<body>
<common:moveSite recordType="action"/>
	<div class="header">
		<h3>
			<fmt:message key="searchResults" />
		</h3>
	</div>
	<!-- final part -->
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >8</c:when> 
	  <c:otherwise>7</c:otherwise> 
	</c:choose> 
</c:set>
<div class="content" >
<div class="table-responsive">
<div class="panel">
        <c:if test="${found}">
							   
							 </c:if>
<table class="table table-bordered table-responsive dataTable" id="testTable">
<thead>	
	<c:if test="${found}">
	<tr>
		<th><fmt:message key="id" /></th>
		<th style="width:10%"><fmt:message key="itemType"/></th>
		<th style="width:40%"><fmt:message key="description"/></th>
		<th style="width:15%"><fmt:message key="responsibleOpen"/></th>
		<th style="width:10%"><fmt:message key="departmentOpen"/></th>
		<th  style="width:10%"><fmt:message key="targetDateOpen"/></th>
		<th  style="width:10%"><fmt:message key="site"/></th>
	</tr>
	</c:if>
</thead>
<tbody>
<c:forEach items="${result.results}" var="obj" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><c:out value="${obj.id}" /></td>
		<td><fmt:message key="${obj.type }" /> </td>
		<td><a href="#" onclick='changeSiteOfType("<c:url value="${obj.url }"></c:url>", ${obj.siteId}, "${obj.site}", ${currentSite}, "<fmt:message key="${obj.type }" />")' ><font><c:out value="${obj.name }" /></font></a></td>
		<td><c:out value="${obj.userResponsible }" /> </td>
		<td><c:out value="${obj.departmentName }" /> </td>
		<td><fmt:formatDate value="${obj.date }" pattern="dd-MMM-yyyy" /></td>
		<td><c:out value="${obj.site }" /></td>
	</tr>
</c:forEach>
</tbody>
<tfoot>
<c:if test="${found}">
	<tr>
		<td colspan="7">${result.totalResults} <fmt:message key="results"/></td>
	</tr>
</c:if>
</tfoot>

</table>
</div>
</div>
</div>

</body>
</html>
