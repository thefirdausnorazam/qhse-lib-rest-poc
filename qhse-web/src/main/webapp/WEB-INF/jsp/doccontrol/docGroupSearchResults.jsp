<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="docControlDocGroups" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
 <div class="header">
<h3><fmt:message key="docControl.docGroups" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-bordered table-responsive dataTable">
	<thead>	
		<c:if test="${found}">
			<tr>
				<th><fmt:message key="id" /></th>
				<th><fmt:message key="doccontrol.prefix" /></th>
				<th><fmt:message key="name" /></th>
				<th><fmt:message key="doccontrol.reviewFrequency" /></th>
				<th><fmt:message key="status" /></th>
				<th><fmt:message key="template.sites" /></th>
				<th class="datatable-nosort"><fmt:message key="doccontrol.hierarchy" /></th>
			</tr>
		</c:if>
	</thead>
	<tbody>
		<c:forEach items="${result.results}" var="docGroup" varStatus="s">
			<c:choose>
				<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
				<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
			</c:choose>
			<tr class="<c:out value="${style}" />">
				<td><a href="<c:url value="docGroupView.htm"><c:param name="id" value="${docGroup.id}"/></c:url>" ><c:out value="${docGroup.id}" /></a></td>
				<td><c:out value="${docGroup.prefix}" /></td>
				<td><c:out value="${docGroup.name} " /></td>
				<td><c:out value="${docGroup.frequency}" /></td>
				<td><fmt:message key="${docGroup.status}" /></td>
				<td>		
			      	<c:forEach items="${docGroup.sortedActiveInSites}" var="selectedSite" varStatus="loop">
		      			<c:out value="${selectedSite.name}" /><c:if test="${!loop.last}">,</c:if> 
					</c:forEach>
				</td>
				<td>
					<a class="<c:if test="${!docGroup.activeStatus}">inactiveGroup</c:if>" 
						title="<c:choose> 
			  						<c:when test="${docGroup.activeStatus}" ><fmt:message key="doccontrol.docGroupsHierarchy" /></c:when> 
			  						<c:otherwise><fmt:message key="doccontrol.docGroupsHierarchy.inactive" /></c:otherwise> 
								</c:choose> " 
						href="<c:url value="/doccontrol/docGroupsView.htm" ><c:param name="navTo" value="${docGroup.id}" /><c:param name="showActiveOnly" value="${docGroup.activeStatus}" /><c:param name="source" value="search" /></c:url>">
						<i class="fa fa-sitemap"></i>
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<c:if test="${found}">
			<tr>
				<td colspan="7"><scannell:paging result="${result}" /></td>
			</tr>
		</c:if>
	</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
