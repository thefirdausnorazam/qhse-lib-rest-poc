<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="checklist" required="true" type="com.scannellsolutions.modules.law.domain.Checklist" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<%@ tag import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@ tag import="com.scannellsolutions.modules.law.web.ProfileChecklistHelper"%>

<script>
function openAttach(url, param) {
	window.open(contextPath+url+'?id='+param, '_blank');
}
</script>
<c:set var="doclinks" value="<%=DocLinkManager.getLinks(\"checklist\" + checklist.getId() + \"-\" + profile.getId())%>" />
<c:set var="docRevisions" value="<%=DocLinkManager.getDocRevisions(\"checklist\" + checklist.getId() + \"-\" + profile.getId())%>" />
<c:set var="attachments" value="<%=DocLinkManager.getUploadedDocsActive(checklist.getId(),profile.getId())%>" />        
		<c:if test="${not empty doclinks}">
		<div class="header"><h3><fmt:message key="linkedDocuments"/></h3></div>
        <div class="content">		 
		  <c:forEach items="${doclinks}" var="doclink">
            <c:choose>
				<c:when test="${doclink.file}"><fmt:message key="id" />
					<div><a onclick='openLinkFile("<c:url value="${doclink.id}"></c:url>")' target="blank">
								${doclink.name}</a> - ${doclink.description}</div>
				</c:when>
				<c:otherwise>
					<div><a href="<law:doclinkUrl doclink="${doclink}" />" target="linkedDoc">${doclink.name}</a> - ${doclink.description}</div>
				</c:otherwise>
			</c:choose>
		  </c:forEach>
		  </div>
		</c:if> 
		<c:if test="${empty doclinks}">
		<div class="header"><h3><fmt:message key="linkedDocuments"/></h3></div>
         <div class="content">		 
		  <i class="fa fa-times"></i>&nbsp;<fmt:message key="none"/>
		  </div>
		</c:if>
		<c:if test="${not empty docRevisions and fn:contains(licences, 'doccontrol')}">
			<div class="header"><h3><fmt:message key="doccontrol.documentLabel"/></h3></div>
	        <div class="content">		 
			  	<c:forEach items="${docRevisions}" var="docRevision">
					<c:choose>
						<c:when test="${!docRevision.document.downloadable}">
							<!-- User does not have access to download this document -->
							<a href="#" onclick="return confirm('<fmt:message key="doccontrol.docLink.noAccess"/>')">
						</c:when>
						<c:otherwise>
							<!-- Always download the latest version for Law -->
							<a download="<c:out value="${docRevision.document.downloadFileName}"/> <fmt:message key="general.versionShortcut"/><c:out value="${docRevision.document.lastDistributedRevision.downloadDocRevision}"/>" 
								href="<c:url value="../doccontrol/downloadDocument.htm">
									<c:param name="docRevisionId" value="${docRevision.document.lastDistributedRevision.id}" />
								</c:url>">
						</c:otherwise>
					</c:choose>
					<c:out value="${docRevision.document.name}" /> <fmt:message key="general.versionShortcut"/><c:out value="${docRevision.document.lastDistributedRevision.displayVersion}" /></a> - <c:out value="${docRevision.document.description}" />
			  		<br />
			  	</c:forEach>
			  </div>
		</c:if>
		<c:if test="${empty docRevisions and fn:contains(licences, 'doccontrol')}">
			<div class="header"><h3><fmt:message key="doccontrol.documentLabel"/></h3></div>
         	<div class="content">		 
		  		<i class="fa fa-times"></i>&nbsp;<fmt:message key="none"/>
		  	</div>
		</c:if>
		<c:if test="${empty attachments}">
		<div class="header"><h3><fmt:message key="uploadedDocuments"/></h3></div>
         <div class="content">		 
		  <i class="fa fa-times"></i>&nbsp;<fmt:message key="none"/>
		  </div>
		</c:if>
		<c:if test="${not empty attachments}">
		<div class="header"><h3><fmt:message key="uploadedDocuments"/></h3></div>		
		 <div class="content"> 
		  <c:forEach items="${attachments}" var="attachment">
          <div><c:choose>
			 <c:when test="${attachment.type.name == 'attach'}">
		 		 <a target="attachment" onclick="openAttach('/law/viewLawAttachment.${attachment.fileExtension}viewLawAttachment.${attachment.fileExtension}', '${attachment.id}')"> 
				<c:out value="${attachment.name}" /></a> - <c:out value="${attachment.description}" />
	    	 </c:when>
			 <c:otherwise>
				<a target="attachment"	href="<c:out value="${attachment.externalUrl}" />">
				<c:out value="${attachment.name}" /></a> - <c:out value="${attachment.description}" />
			 </c:otherwise>
			 </c:choose> 
		   </div>
		  </c:forEach>
		  </div>
		</c:if>     
		
		 
