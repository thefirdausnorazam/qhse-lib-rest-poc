<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="inspectionProgrammeType" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
	
</script>
<c:set var="found" value="${!empty result.results}" />


<div class="header">
<h3><fmt:message key="inspectionProgrammeType" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination" ><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-bordered table-responsive dataTable">
<thead>
	
	<tr>
		
		
		<th><fmt:message key="name" /></th>
	</tr>
</thead>
<tbody>

<c:forEach items="${result.results}" var="questionGroup" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="auditTypeView.htm"><c:param name="id" value="${questionGroup.id}"/></c:url>" ><c:out value="${questionGroup.name}" /></a></td>
		
		
	</tr>
</c:forEach>
</tbody>
<tfoot>
<c:if test="${found}">
	<tr>
		<td><scannell:paging result="${result}" /></td>
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
