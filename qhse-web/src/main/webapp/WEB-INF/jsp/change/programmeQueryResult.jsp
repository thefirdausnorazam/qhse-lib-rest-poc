<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="programmeQueryResult" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >7</c:when> 
	  <c:otherwise>6</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3><fmt:message key="changeProgrammes" /></h3>
</div>
<div class="content">
<div class="table-responsive">
    <c:if test="${found}">
          	<div class="div-for-pagination" ><scannell:paging result="${result}" /></div>
        </c:if>
<div class="panel">
	<table class="table table-bordered table-responsive dataTable">
		<thead>
			<tr>
				<th><fmt:message key="id" /></th>
				<th><fmt:message key="changePlan" /></th>
				<th><fmt:message key="type" /></th>
				<th><fmt:message key="owner" /></th>
				<th><fmt:message key="reviewDate" /></th>
				<th><fmt:message key="completed" /></th>
				<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach items="${result.results}" var="programme" varStatus="s">
				<c:choose>
					<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
					<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
				</c:choose>
				<tr class="<c:out value="${style}" />">
					<td><a href="<c:url value="programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>" ><c:out value="${programme.id}" /></a></td>
					<td><c:out value="${programme.plan.year}" /></td>
					<td><c:out value="${programme.type.name}" /></td>
					<td><c:out value="${programme.owner.displayName}" /></td>
					<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
					<td><fmt:message key="${programme.completed}" /></td>
					<c:if test="${showSiteColumn}"><td><c:out value="${programme.plan.site}" /></td></c:if>
				</tr>
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
</div>
</div>

</body>
</html>
