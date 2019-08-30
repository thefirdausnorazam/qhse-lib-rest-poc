<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="task" required="true" type="com.scannellsolutions.entity.AbstractNamedEntity" %>
<%@ attribute name="style" required="true" type="java.lang.String" %>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showLegacyIds" required="true" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:set var="taskLabel"><fmt:message key="task"/></c:set>
<tr class="<c:out value="${style}" />">
	<c:url var="taskURL" value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>
	<td>
          <c:choose>
          	<c:when test="${not empty currentSite}"><a onclick='changeSiteOfType("${taskURL}", ${task.site.id}, "${task.site}", ${currentSite}, "${taskLabel}")' href="#" ></c:when>
          	<c:otherwise><a href="<c:out value="${taskURL}"/>"></c:otherwise>
          </c:choose>
  			<c:out value="${task.displayId}" /></a>
  	</td>
  	<td><scannell:text value="${task.name}" /></td>
	<td><fmt:message key="task.${task.status}" /></td>
	<td><c:out value="${task.responsibleDepartment.name}" />&nbsp;</td>
	<td><c:out value="${task.responsibleUser.displayName}" /></td>
	<td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	<c:if test="${showSiteColumn}"><td><c:out value="${task.site.name}" /></td></c:if>
	<c:if test="${showLegacyIds}"><td> <c:out value="${task.legacyId}" /></td></c:if>
</tr>