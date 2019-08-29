<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="thirdPartQueryResult" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="thirdPartyAuditees" /></h3>
</div>
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
		<th><fmt:message key="company" /></th>
		<th><fmt:message key="address" /></th>
		<th><fmt:message key="phoneNumber" /></th>
		<th><fmt:message key="emailAddress" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>
<tbody>

	<c:forEach items="${result.results}" var="auditee" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
		    <td><a href="<c:url value="thirdPartyView.htm"><c:param name="id" value="${auditee.id}"/></c:url>" ><c:out value="${auditee.id}" /></a></td>
			<td><c:out value="${auditee.name}" /></td>
			<td><c:out value="${auditee.company}" /></td>
			<td><c:out value="${auditee.address}" /></td>
			<td><c:out value="${auditee.phoneNumber}" /></td>
			<td><c:out value="${auditee.emailAddress}" /></td>
			<td><fmt:message key="${auditee.active}" /></td>
		</tr>
	</c:forEach>
	<tfoot>
		<c:if test="${found}">
			<tr>
				<td colspan="7"><scannell:paging result="${result}" /></td>
			</tr>
		</c:if>
	<tfoot>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
