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
<h2><fmt:message key="questionView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
	
	<thead>
		<tr>
			<td colspan="2">
				<fmt:message key="questionView" />
			</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="scannellGeneralLabel nowrap"  ><fmt:message key="codeName" />:</td>
			<td><c:out value="${question.codeName}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap"  ><fmt:message key="displayName" />:</td>
			<td><c:out value="${question.name}" /></td>
		</tr>
		<%-- <tr>
			<td class="scannellGeneralLabel nowrap"  ><fmt:message key="furtherInfo" />:</td>
			<td><c:out value="${question.furtherInfo}" /></td>
		</tr> --%>
		<tr>
			<td class="scannellGeneralLabel nowrap"  ><fmt:message key="active" />:</td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="questionAnswerType" />:</td>
			<td><fmt:message key="${question.answerType}" /></td>
		</tr>
<%-- 		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="parentTable" />:</td>
			<td><c:out value="${question.parent.name}" /></td>
		</tr> --%>
		<%-- <tr>
			<td class="scannellGeneralLabel nowrap"  ><fmt:message key="visible" />:</td>
			<td><fmt:message key="${question.visible}" /></td>
		</tr> --%>
<%-- 		<tr>
			<td class="scannellGeneralLabel nowrap" ><fmt:message key="modules" />:</td>
			<td>
				<c:forEach items="${question.modules}" var="module">
			 		<c:out value="${module.name}" />&nbsp;
			 	</c:forEach>
			</td>
		</tr> --%>
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
<h2><fmt:message key="options" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
	<thead>		
		<tr>
			<th>&nbsp;</th>
			<th><fmt:message key="name" /></th>
			<th><fmt:message key="active" /></th>
			<th><fmt:message key="visible" /></th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${empty question.options}">
		<tr>
			<td colspan="5"><fmt:message key="search.empty" /></td>
		</tr>
	</c:if>

	<c:forEach items="${question.options}" var="option" varStatus="s">
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
			<td><a href="<c:url value="questionOptionView.htm"><c:param name="id" value="${option.id}" />
										<c:param name="questionId" value="${question.id}" /></c:url>"><c:out value="${option.name}" /></a></td>
			<td><fmt:message key="${option.active}" /></td>
			<td><fmt:message key="${option.visible}" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
