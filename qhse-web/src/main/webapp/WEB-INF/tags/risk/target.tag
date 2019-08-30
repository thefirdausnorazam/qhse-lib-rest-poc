<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="target" required="true" type="com.scannellsolutions.modules.risk.domain.ObjectiveTarget" %>
<%@ attribute name="style" required="true" type="java.lang.String" %>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showLegacyIds" required="true" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:set var="targetLabel"><fmt:message key="target"/></c:set>
<tr class="<c:out value="${style}" />">
	  <c:url var="targetURL" value="/risk/targetView.htm"><c:param name="id" value="${target.id}"/></c:url>
	  <td>
          <c:choose>
          	<c:when test="${not empty currentSite}"><a onclick='changeSiteOfType("${targetURL}", ${target.site.id}, "${target.site}", ${currentSite}, "${targetLabel}")' href="#" ></c:when>
          	<c:otherwise><a href="<c:out value="${targetURL}"/>"></c:otherwise>
          </c:choose>
          <c:out value="${target.id}" /></a></td>
	  <td><c:out value="${target.name}" /></td>
	  <td><fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	  <td><fmt:message key="task.${target.status}" /></td>
	  <td><c:out value="${target.responsibleUser.displayName}" /></td>
	  <c:if test="${showSiteColumn}"><td><c:out value="${target.site}" /></td></c:if>
	  	<c:if test="${showLegacyIds}">
       	<td> <c:out value="${target.legacyId}" /> </td>
     </c:if>
</tr>