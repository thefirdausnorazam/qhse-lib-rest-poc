<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:if test="${!empty test.attachments}">
<a name="attachments"></a>
<table class="viewForm bordered">
<thead>
	<tr><td colspan="2" ><fmt:message key="attachments" /></td></tr>
</thead>
<tbody>
	<c:forEach items="${test.attachments}" var="item">
	<c:if test="${item.active}">
	<tr>
		<td>
			<c:choose>
				<c:when test="${item.type.name == 'attach'}">
					<a target="attachment" href="<c:url value="attachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a>
				</c:when>
				<c:otherwise>
					<a target="attachment" href="<c:out value="${item.externalUrl}" />"><c:out value="${item.name}" /></a>
				</c:otherwise>
			</c:choose>
			<br />
			<c:out value="${item.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" />
		</td>
		<td><scannell:text value="${item.description}" /></td>
	</tr>
	</c:if>
	</c:forEach>
</tbody>
</table>
</c:if>