<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="questionGroupView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
	<col  />
	<%-- <thead>
		<tr>
			<td colspan="2">
				<fmt:message key="questionGroupView" />
			</td>
		</tr>
	</thead> --%>
	<tbody>
		<tr>
			<td ><fmt:message key="codeName" />:</td>
			<td><c:out value="${group.codeName}" /></td>
		</tr>
		<tr>
			<td ><fmt:message key="displayName" />:</td>
			<td><c:out value="${group.name}" /></td>
		</tr>
		<tr>
			<td ><fmt:message key="active" />:</td>
			<td><fmt:message key="${group.active}" /></td>
		</tr>
	 </tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<scannell:url urls="${urls}" />
			</td>
		</tr>
	</tfoot>
</table>
</div>
</div>
</div>
<div class="header">
<h2><fmt:message key="questions" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
	<thead>
		
		<tr>
			<th>&nbsp;</th>
			<th><fmt:message key="codeName" /></th>
			<th><fmt:message key="displayName" /></th>
			<th><fmt:message key="active" /></th>
			<th><fmt:message key="visible" /></th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${empty group.questions}">
		<tr>
			<td colspan="5"><fmt:message key="search.empty" /></td>
		</tr>
	</c:if>

	<c:forEach items="${group.questions}" var="question" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}">
				<c:set var="style" value="even" />
			</c:when>
			<c:otherwise>
				<c:set var="style" value="odd" />
			</c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${s.count}" /></td>
			<td><a href="<c:url value="questionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><c:out value="${question.codeName}" /></a></td>
			<td><c:out value="${question.name}" /></td>
			<td><fmt:message key="${question.active}" /></td>
			<td><fmt:message key="${question.visible}" /></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
