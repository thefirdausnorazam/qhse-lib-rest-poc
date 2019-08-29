<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="docControlDocuments" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
 <div class="header">
<h3><fmt:message key="docControl.documents" /></h3>
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
		<tr>
			<th><fmt:message key="id" /></th>
			<th><fmt:message key="name" /></th>
			<th><fmt:message key="description" /></th>
			<th><fmt:message key="department" /></th>
			<th><fmt:message key="status" /></th>
		</tr>
</thead>
<tbody>
<c:forEach items="${result.results}" var="document" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${document.id}"/></c:url>" ><c:out value="${document.id}" /></a></td>
		<td><c:out value="${document.name}" /></td>
		<td><scannell:text value="${document.description} " /></td>
		<td style="max-width:300px;">
	      <c:forEach var="dept" items="${document.departments}" varStatus="loop">
		  	<c:out value="${dept.name}" /><c:if test="${!loop.last}">,</c:if>
		  </c:forEach>
		</td>
		<td><fmt:message key="${document.status}" /></td>
	</tr>
</c:forEach>
<tfoot>
<c:if test="${found}">
	<tr>
		<td colspan="5"><scannell:paging result="${result}" /></td>
	</tr>
</c:if>
</tfoot>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
