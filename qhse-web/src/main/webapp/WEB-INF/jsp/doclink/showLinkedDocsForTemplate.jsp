<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul>
	<c:forEach var="link" items="${docLinkHolderTemplate.links}">
		<li>
	 		<c:choose>
				<c:when test="${link.file}">
					<a onclick="window.open('<c:url value="/doclink/openLinkFile.htm?link=${link.id}"/>')" target="linkedDoc">
				</c:when>
				<c:otherwise>
					<a href="<c:out value="${link.url}" />" target="linkedDoc">
				</c:otherwise>
			</c:choose>
			<c:out value="${link.name}" /></a> - <c:out value="${link.description}" />
		</li>
	</c:forEach>
</ul>