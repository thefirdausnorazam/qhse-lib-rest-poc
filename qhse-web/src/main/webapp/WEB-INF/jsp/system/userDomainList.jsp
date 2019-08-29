<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<script type='text/javascript' src="<c:url value="/js/common.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/css.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/standardista-table-sorting.js"/>"></script>
</head>

<body>
<div class="header">
<h2><fmt:message key="userDomainList" /></h2>
</div>
<a name="user"></a>
<div style="padding-top: 1%;">
<scannell:url urls="${urls}" />
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
<thead>
	<%-- <tr><td colspan="10"><scannell:url urls="${urls}" /></td></tr> --%>
	<tr>
		<th><fmt:message key="userDomain.name" /></th>
		<th><fmt:message key="userDomain.type" /></th>
		<th><fmt:message key="userDomain.active" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${domains}" var="domain" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}">
				<c:set var="style" value="even" />
			</c:when>
			<c:otherwise>
				<c:set var="style" value="odd" />
			</c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><a href="<c:url value="userDomainView.htm"><c:param name="id" value="${domain.id}"/></c:url>" ><c:out value="${domain.name}" /></a></td>
			<td><fmt:message key="${domain['class'].simpleName}"/></td>
			<td><fmt:message key="${domain.active}"/></td>
		</tr>
	</c:forEach>
</tbody>

<tfoot>
	<tr><td colspan="10"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
