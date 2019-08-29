<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title>
  	<fmt:message key="taskView.title" />
  </title>
 
 
</head>
<body onload="onPageLoad();">
<a name="task"></a>
<table class="table table-bordered table-responsive" style="width:100%;border-top:1px solid #DADADA;">
  <tbody>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</td>
    <td><c:out value="${task.displayId}" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="${task.status}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
	 	<ul>
      		<c:forEach var="ba" items="${task.businessAreas}">
        		<li><c:out value="${ba.name}" /></li>
      		</c:forEach>
	    </ul>
	</td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <c:if test="${task.priority != null}">      
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="priority" /></td>
    <td><fmt:message key="${task.priority}" /></td>
  </tr>  
  </c:if>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleDepartment" />:</td>
    <td colspan="3"><c:out value="${task.responsibleDepartment.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.profile" />:</td>
    <td colspan="3">
       	<c:out value="${task.profile.name}" />
    </td>
   </tr>
   <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.checklist" />:</td>
    <td colspan="3">
        <c:out value="${task.checklistId}" /></a> 
    </td>
   </tr>

  <c:if test="${task.completed}">
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.achieved" />:</td>
    <td colspan="3"><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completedBy" />:</td>
    <td colspan="3"><c:out value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>
<!-- 
  <tr>
    <td class="label"><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="link" items="${docLinkHolder.links}">
        <li><a href="<c:out value="${link.url}" />" target="linkedDoc"><c:out value="${link.name}" /></a> - <c:out value="${link.description}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
 -->
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
		<c:choose>
			<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
			<c:otherwise><fmt:message key="taskView.title" /> <fmt:message key="notCurrentSelectedSiteMsg" >
						<fmt:param value="${task.site.name}" />
					 </fmt:message>
			</c:otherwise>
	</c:choose></td>
    </tr>
  </tfoot>
</table>
</tbody>
</table>
</body>
</html>
