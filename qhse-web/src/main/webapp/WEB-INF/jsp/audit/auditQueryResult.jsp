<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="auditQueryResult" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/audit/auditView.htm?id=${result.results[0].id}';
		}
	}
</script>
 <div class="header">
<h3><fmt:message key="audits" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >9</c:when> 
	  <c:otherwise>8</c:otherwise> 
	</c:choose> 
</c:set>
<c:if test="${showLegacyId}"><c:set var="colspan" value="${colspan + 1}" /></c:if>
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
		<th><fmt:message key="auditProgramme" /></th>
		<th><fmt:message key="leadAuditor" /></th>
		<th><fmt:message key="auditee" /></th>
		<th><fmt:message key="startDate" /></th>
		<th><fmt:message key="completed" /></th>
		<th><fmt:message key="targetCompletionTime"/></th>
	  	<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
	  	<c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
	</tr>
</thead>
<tbody>
<c:forEach items="${result.results}" var="audit" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="auditView.htm"><c:param name="id" value="${audit.id}"/></c:url>" ><c:out value="${audit.id}" /></a></td>
		<td><c:out value="${audit.name}" /></td>
		<td><c:out value="${audit.programme.description} " /></td>
		<td><c:out value="${audit.leadAuditor.displayName}" /></td>
		<td><c:if test="${audit.auditee != null}"><c:out value="${audit.auditee.name}" /></c:if></td>
		<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy" /></td>
		<td><fmt:message key="${audit.completed}" /></td>
		<td><fmt:formatDate value="${audit.targetCompletionTime}" pattern="dd-MMM-yyyy HH:mm"  /></td>
		<c:if test="${showSiteColumn}"><td><c:out value="${audit.site}" /></td></c:if>
		<c:if test="${showLegacyId}">
       		<td> <c:out value="${audit.legacyId}" /> </td>
     	</c:if>
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
</div>
</body>
</html>
