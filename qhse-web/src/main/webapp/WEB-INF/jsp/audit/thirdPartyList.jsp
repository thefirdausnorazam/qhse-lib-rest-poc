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
<h2><fmt:message key="thirdPartyList" /></h2>
</div>
<scannell:url urls="${urls}" />

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>
	
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="company" /></th>
		<th><fmt:message key="address" /></th>
		<th><fmt:message key="phoneNumber" /></th>
		<th><fmt:message key="emailAddress" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>

<tbody>
<c:forEach items="${thirdParties}" var="thirdParty" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="thirdPartyView.htm"><c:param name="id" value="${thirdParty.id}"/></c:url>" ><c:out value="${thirdParty.name}" /></a></td>
		<td><c:out value="${thirdParty.company}" /></td>
		<td><c:out value="${thirdParty.address}" /></td>
		<td><c:out value="${thirdParty.phoneNumber}" /></td>
		<td><c:out value="${thirdParty.emailAddress}" /></td>
		<td><c:out value="${thirdParty.active}" /></td>
	</tr>
</c:forEach>
</tbody>

<tfoot>
	<tr>
		<td colspan="6"><scannell:url urls="${urls}" /></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
