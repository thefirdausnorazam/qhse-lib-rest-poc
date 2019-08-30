<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="objective" required="true" type="com.scannellsolutions.modules.risk.domain.Objective"%>
<%@ attribute name="style" required="true" type="java.lang.String"%>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean"%>
<%@ attribute name="showLegacyIds" required="true" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<c:set var="objLabel"><fmt:message key="objective"/></c:set>
<tr class="<c:out value="${style}" />">
	<c:url var="link" value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}"/></c:url>
	  <td>
	  	<c:choose>
          	<c:when test="${not empty currentSite}"><a onclick='changeSiteOfType("${link}", ${objective.site.id}, "${objective.site}", ${currentSite}, "${objLabel}")' href="#" ></c:when>
          	<c:otherwise><a href="${link}"></c:otherwise>
          </c:choose>
			<c:out value="${objective.displayId}" />
		</a></td>
	<td><scannell:text value="${objective.name}" /> <c:forEach items="${objective.targets}" var="target">
			<c:if test="${target.editable}">
				<li class='target'><c:out value="${target.name}" /> by <fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></li>
			</c:if>
		</c:forEach></td>
	<td><c:out value="${objective.category.name}" /></td>
	<td><fmt:formatDate value="${objective.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
	<td><fmt:message key="task.${objective.status}" /></td>
	<td><c:out value="${objective.sponsor}" /></td>
	<c:if test="${showSiteColumn}">
		<td><c:out value="${objective.site}" /></td>
	</c:if>
	<c:if test="${showLegacyIds}">
       	<td> <c:out value="${objective.legacyId}" /> </td>
     </c:if>
</tr>
