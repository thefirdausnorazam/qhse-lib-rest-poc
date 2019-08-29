<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="auditPlans" /></h2>
</div>

<div class="content">
<div class="table-responsive">
<scannell:url urls="${urls}" />
<table class="table table-bordered table-responsive">
<thead>
	
	<tr>
		<th><fmt:message key="year" /></th>
		<th><fmt:message key="percentCompleted" /></th>
	</tr>
</thead>

<tbody>
<c:forEach items="${plans}" var="plan" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="planView.htm"><c:param name="id" value="${plan.id}"/></c:url>" ><c:out value="${plan.displayName}" /></a></td>
		<td><c:out value="${plan.percentCompleted}%" /></td>
	</tr>
</c:forEach>
</tbody>

<tfoot>
	<tr><td colspan="2"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</body>
</html>
