<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="templateQueryResult" /></title>
</head>
<body>
<script type="text/javascript">  
 jQuery('.recordsPerPage > select').select2();
 jQuery(document).ready(function() {
		initSortTablesForClass('dataTableTemplate');
	} );
 </script>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="templateQueryForm" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<c:if test="${found}"> <div class="div-for-pagination"><scannell:paging result="${result}" /></div></c:if>
<table class="table table-bordered table-responsive dataTableTemplate">
<thead>
<c:if test="${!found}">
	<tr>
		<td colspan="4">
			<fmt:message key="search.empty" />
		</td>
	</tr>
</c:if>	
	<c:if test="${found}">
	<tr>
		<th><fmt:message key="name" /></th>
	    <th><fmt:message key="scorable" /></th>
	    <th><fmt:message key="active" /></th>
	    <th><fmt:message key="template.activeInCurrentSite" /></th>
	</tr>
	</c:if>
</thead>

<tbody>
	

	<c:forEach items="${result.results}" var="template" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><a href="<c:url value="templateView.htm"><c:param name="id" value="${template.id}"/></c:url>" ><c:out value="${template.name}" /></a></td>
      		<td><fmt:message key="${template.scorable}" /></td>
			<td><fmt:message key="${template.activeTemplate}" /></td>
			<td><fmt:message key="${template.activeInCurrentSite}" /></td>
		</tr>
	</c:forEach>
</tbody>

	<c:if test="${found}">
	<tfoot>
	<tr>
		<td colspan="4"><scannell:paging result="${result}" /></td>
	</tr>
	</tfoot>
	</c:if>

</table>
</div>
</div>
</div>
</body>
</html>
