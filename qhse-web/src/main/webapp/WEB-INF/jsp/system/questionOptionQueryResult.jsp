<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="questionOptionQueryResult" /></title>
</head>
<body>

<c:set var="found" value="${!empty result.results}" />
   	<c:if test="${!found}">
          <fmt:message key="search.empty" />
    </c:if>
    <c:if test="${found}">
          <scannell:paging result="${result}" />
    </c:if>
<table class="viewForm bordered">
	<thead>
		<tr>
			<td colspan="7"><fmt:message key="searchResults" /></td>
		</tr>
		<c:if test="${found}">
			<tr>
				<th><fmt:message key="group" /> <fmt:message key="name" /></th>
				<th><fmt:message key="question" /> <fmt:message key="name" /></th>
				<th><fmt:message key="name" /></th>
				<th><fmt:message key="active" /></th>
				<th><fmt:message key="visible" /></th>
				<th><fmt:message key="order" /></th>
			</tr>
		</c:if>
	</thead>
	<tbody>

		<c:forEach items="${result.results}" var="option" varStatus="s">
			<c:choose>
				<c:when test="${s.index mod 2 == 0}">
					<c:set var="style" value="even" />
				</c:when>
				<c:otherwise>
					<c:set var="style" value="odd" />
				</c:otherwise>
			</c:choose>
			<tr class="<c:out value="${style}" />">
				<td><a
					href="<c:url value="questionGroupView.htm"><c:param name="id" value="${option.question.group.id}" /></c:url>"><c:out
					value="${option.question.group.codeName}" /></a></td>
				<td><a
					href="<c:url value="questionView.htm"><c:param name="id" value="${option.question.id}" /></c:url>"><c:out
					value="${option.question.codeName}" /></a></td>
				<td><a
					href="<c:url value="questionOptionView.htm"><c:param name="id" value="${option.id}" /></c:url>"><c:out
					value="${option.name}" /></a></td>
				<td><fmt:message key="${option.active}" /></td>
				<td><fmt:message key="${option.visible}" /></td>
				<td><c:out value="${option.optionOrder}" /></td>
			</tr>
		</c:forEach>
		<c:if test="${found}">
			<tr>
				<td colspan="7"><scannell:paging result="${result}" /></td>
			</tr>
		</c:if>
	</tbody>
</table>

</body>
</html>
