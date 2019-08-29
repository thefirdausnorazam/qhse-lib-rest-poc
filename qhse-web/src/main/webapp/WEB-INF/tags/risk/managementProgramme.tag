<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="programme" required="true" type="com.scannellsolutions.modules.risk.domain.ManagementProgramme" %>
<%@ attribute name="style" required="true" type="java.lang.String" %>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showLegacyIds" required="true" type="java.lang.Boolean"%>
<%@ attribute name="currentSite" required="false" type="java.lang.Long" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:set var="manLabel"><fmt:message key="managementProgramme"/></c:set>
<tr class="<c:out value="${style}" />">
	  <c:url var="link" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${programme.id}"/></c:url>
	  <td>
	  	<c:choose>
          	<c:when test="${not empty currentSite}"><a onclick='changeSiteOfType("${link}", ${programme.site.id}, "${programme.site}", ${currentSite}, "${manLabel}")' href="#" ></c:when>
          	<c:otherwise><a href="${link}"></c:otherwise>
          </c:choose>
	  	  <c:out value="${programme.displayId}" /></a></td>
	  <td><scannell:text value="${programme.name}" /></td>
	  <td><fmt:formatDate value="${programme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	  <td><fmt:message key="task.${programme.status}" /></td>
	  <td><c:out value="${programme.responsibleUser.displayName}" /></td>
	  <c:if test="${showSiteColumn}"><td><c:out value="${programme.site}" /></td></c:if>
	  <c:if test="${showLegacyIds}"><td> <c:out value="${programme.legacyId}" /></td></c:if>
</tr>