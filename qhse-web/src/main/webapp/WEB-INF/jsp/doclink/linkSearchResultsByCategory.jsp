<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="linkSearch" /></title>
</head>
<body>

<c:set var="found" value="${!empty result.results}" />
<table id="taskResultTable" class="viewForm bordered">
<thead>
<tr>
	<th><fmt:message key="doclink.linkSearchFormByCategory.name" /></th>
	<th><fmt:message key="doclink.linkSearchFormByCategory.description" /></th>
	<c:if test="${userCanEdit}">
	<th><fmt:message key="doclink.linkSearchFormByCategory.link" /></th>
	</c:if>
</tr>
</thead>

<tbody>
	<tr>
		<td colspan="6">
			<c:if test="${!found}"><fmt:message key="search.empty" /></c:if>
			<c:if test="${found}"><scannell:paging result="${result}" /></c:if>
		</td>
	</tr>

	<c:set var="last" value="${null}" />
	<c:forEach items="${result.results}" var="item" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>

	<c:if test="${item.category != last.category}">
		<tr>
			<th colspan="5" style="text-align: left;">
				<img src="<c:url value="/images/plus.gif"/>" id="toggle-<c:out value="${item.category.id}"/>" onclick="toggleCategory(<c:out value="${item.category.id}" />);" />
				<c:choose>
				<c:when test="${userCanEdit}">
					<a href="<c:url value="categoryEdit.htm"><c:param name="showId" value="${item.category.id}" /></c:url>"><c:out value="${item.category.name}" /></a>
				</c:when>
				<c:otherwise><c:out value="${item.category.name}" /></c:otherwise>
				</c:choose>
			</th>
		</tr>
	</c:if>

	<tr style="display: none; "class="<c:out value="${style}" />" id="category-<c:out value="${item.category.id}"/>-<c:out value="${item.id}"/>">
		<td><a href="<c:out value="${item.url}" />" target="_blank"><c:out value="${item.name}"/></a></td>
		<td><c:out value="${item.description}"/></td>
		<c:if test="${userCanEdit}">
			<td><a href="javascript:onSelectLink('<c:out value="${item.id}" />')"><fmt:message key="linkEdit" /></a></td>
		</c:if>
	</tr>
	<c:set var="last" value="${item}" />
	</c:forEach>

	<c:if test="${found}">
	<tr>
		<td colspan="6"><scannell:paging result="${result}" /></td>
	</tr>
	</c:if>
</tbody>
</table>

</body>
</html>
