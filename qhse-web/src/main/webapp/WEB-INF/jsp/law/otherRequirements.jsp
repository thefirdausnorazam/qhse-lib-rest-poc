<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  
<div class="block-flat">
<div class="header">
   <h3> <fmt:message key='otherRequirements'/></h3>
  </div>

  <c:choose>
    <c:when test="${empty docLinksByCategory}">
      <div>
      <fmt:message key="none" var="none"/>
       <i class="fa fa-times"></i> &nbsp; <fmt:message key="none" />
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach items="${docLinksByCategory}" var="item">
        <c:set var="category" value="${item.key}" />
        <c:set var="links" value="${item.value}" />
        <div class="content">
				
					<h4 style="color: #DF4B33;">
						<c:out value="${category.name}" />
					</h4>
				
                <div class="content">
				<c:forEach items="${links}" var="link">
				
				<c:choose>
					<c:when test="${link.file}">
						<div><a onclick='openLinkFile("<c:url value="${link.id}"></c:url>")' target="blank">
									${link.name}</a> - ${link.description}</div>
					</c:when>
					<c:otherwise>
						<div><a href="<law:doclinkUrl doclink="${link}" />" target="linkedDoc" ><c:out value="${link.name}" /></a></div>
					</c:otherwise>
				</c:choose>
				
          </c:forEach> </div>
        </div>
      </c:forEach>
		<c:if test="${not empty docLinksDocs}">
	        <div class="content">
				<h4 style="color: #DF4B33;">
					<fmt:message key="doccontrol.documentLabel"/>
				</h4>
					
	           	<div class="content">
	      			<c:forEach items="${docLinksDocs}" var="item">
	        			<c:set var="docRevision" value="${item}" />
						<div>
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
						</div>
	     	 		</c:forEach>
	         	</div>
       		</div>
         </c:if>
    </c:otherwise>
  </c:choose>
</div>