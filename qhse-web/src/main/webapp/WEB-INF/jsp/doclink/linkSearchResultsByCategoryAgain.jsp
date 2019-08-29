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
<table class="viewForm bordered">
<thead>
	<tr>
		<td colspan="6"><fmt:message key="searchResults" /></td>
	</tr>
	<c:if test="${found}">
	<tr>
		<th><fmt:message key="id" /></th>
		<th><fmt:message key="doclink.linkSearchFormByCategory.name" /></th>
		<th><fmt:message key="doclink.linkSearchFormByCategory.category" /></th>
		<th><fmt:message key="doclink.linkSearchFormByCategory.description" /></th>
		<th><fmt:message key="doclink.linkSearchFormByCategory.active" /></th>
		<th><fmt:message key="doclink.linkSearchFormByCategory.link" /></th>
	</tr>
	</c:if>
</thead>

<tbody>
	<tr>
		<td colspan="6">
			<c:if test="${!found}"><fmt:message key="search.empty" /></c:if>
			<c:if test="${found}"><scannell:paging result="${result}" /></c:if>
		</td>
	</tr>

	<c:forEach items="${result.results}" var="item" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${item.id}" /></td>
			<c:choose>
					<c:when test="${item.url=='Upload'}">
						<td><a target="attachment" href="<c:url value="viewDocAttachment.${item.fileExtension}"><c:param name="id" value="${item.attachmentType}" /></c:url>">
						   <c:out value="${item.name}" /></a>
						</td>
					</c:when>
					<c:otherwise>
						<td><a href="<c:out value="${item.url}" />" target="_blank"><c:out value="${item.name}" /></a></td>
					</c:otherwise>
				</c:choose>
			
			<td>
				<c:choose>
					<c:when test="${userCanEdit}">
						<a href="<c:url value="categoryEdit.htm"><c:param name="showId" value="${item.category.id}" /></c:url>"><c:out value="${item.category.name}" /></a>
					</c:when>
					<c:otherwise>
						<c:out value="${item.category.name}" />
					</c:otherwise>
				</c:choose>
			</td>
			<td><c:out value="${item.description}" /></td>
			<td><fmt:message key="${item.active}" /></td>
			<td>
			<c:choose>
				<c:when test="${item.url=='Upload'}">
				  <a href="javascript:onSelectDoc('<c:out value="${item.id}" />')"><fmt:message key="docEdit" /></a>
				</c:when>
				<c:otherwise>
					<c:if test="${userCanEdit}">
				        <a href="javascript:onSelectLink('<c:out value="${item.id}" />')"><fmt:message key="linkEdit" /></a>
				    </c:if>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
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

