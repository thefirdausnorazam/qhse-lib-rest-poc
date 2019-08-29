<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<ul>
	<c:forEach var="link" items="${docLinkHolder.links}">
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
	<c:forEach var="docRevision" items="${docLinkHolder.docRevisions}">
		<li>
			<c:choose>
				<c:when test="${!docRevision.document.revisionDownloadable}">
					<!-- User does not have access to download this document -->
					<a href="#" onclick="return confirm('<fmt:message key="doccontrol.docLink.noAccess"/>')">
				</c:when>
				<c:when test="${showLatest != false}">
					<!-- Always download the latest version for open items -->
					<a download="<c:out value="${docRevision.document.downloadFileName}"/> <fmt:message key="general.versionShortcut"/><c:out value="${docRevision.document.lastDistributedRevision.downloadDocRevision}"/>" 
						href="<c:url value="../doccontrol/downloadDocument.htm">
							<c:param name="docRevisionId" value="${docRevision.document.lastDistributedRevision.id}" />
						</c:url>">
				</c:when>
				<c:otherwise>
					<!-- This is not the latest version -->
					<a download="<c:out value="${docRevision.document.downloadFileName}"/> <fmt:message key="general.versionShortcut"/><c:out value="${docRevision.downloadDocRevision}"/>" 
						href="<c:url value="../doccontrol/downloadDocument.htm">
							<c:param name="docRevisionId" value="${docRevision.id}" />
						</c:url>"
						<c:if test="${docRevision.id != docRevision.document.lastDistributedRevision.id}">
							onclick="return confirm('<fmt:message key="doccontrol.docLink.olderVersion"><fmt:param value="${docRevision.displayVersion}" /><fmt:param value="${docRevision.document.lastDistributedRevision.displayVersion}" /></fmt:message>')"
						</c:if>
					>
				</c:otherwise>
			</c:choose>
			 	<c:out value="${docRevision.document.name}" /> <fmt:message key="general.versionShortcut"/>
			 	<c:choose>
			 		<c:when test="${showLatest != false}">
			 			<c:out value="${docRevision.document.lastDistributedRevision.displayVersion}" />
			 		</c:when>
			 		<c:otherwise>
			 			<c:out value="${docRevision.displayVersion}" />
			 		</c:otherwise>
			 	</c:choose>
			 </a> - <c:out value="${docRevision.document.description}" />
		</li>
	</c:forEach>
</ul>