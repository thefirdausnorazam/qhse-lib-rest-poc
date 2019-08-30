<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="attachments" required="true" type="java.util.Collection"%>
<%@ attribute name="urlPrefix" required="true" type="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:forEach items="${attachments}" var="item">
	<c:if test="${item.active}">
		<tr>
			<td>
			  <c:choose>
					<c:when test="${item.type.name == 'attach'}">
						<a target="attachment" href="<c:url value="${urlPrefix}.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
						  <c:out value="${item.name}" /></a>
					</c:when>
					<c:otherwise>
						<a target="attachment"
							href="<c:out value="${item.externalUrl}" />"><c:out
								value="${item.name}" /></a>
					</c:otherwise>
				</c:choose> 
				<br /> <c:out value="${item.createdByUser.displayName}" /><br />
				<fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
			<td>
			  
			</td>
		</tr>
	</c:if>
</c:forEach>
