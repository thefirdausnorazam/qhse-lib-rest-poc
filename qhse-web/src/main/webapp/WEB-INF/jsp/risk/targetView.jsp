<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
  <style type="text/css" media="all">    
     @import "<c:url value='/css/risk.css'/>";
  </style>
  	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="targetView.title" /></h2>
</div>
<a name="target"></a>
<div class="content">
<!-- <div class="header nowrap"> -->
<%-- <h3><fmt:message key="target" /></h3> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<div class="panel">

<table class="table table-bordered table-responsive" style="width:100%;border-top:1px solid #DADADA;">
  <col/>  
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td><c:out value="${target.displayId}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="target.status" />:</td>
    <td><fmt:message key="task.${target.status}" /></td>
  </tr>
    <c:if test="${showLegacyId}">
    <tr>
  		<td class="scannellGeneralLabel"><fmt:message key="legacyId" /></td>
     	<td colspan="3"><c:out value="task.${target.legacyId}" /></td>
    </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.name" />:</td>
    <td colspan="3"><scannell:text value="${target.name}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="target.creationDate" />:</td>
    <td><fmt:formatDate value="${target.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="target.targetCompletionDate" />:</td>
    <td  colspan="4"><fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.responsibleUser" />:</td>
    <td colspan="4"><c:out value="${target.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.objective" />:</td>
    <td colspan="4">
      <c:if test="${target.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${target.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${target.objective.displayId}" /></a> -
        <c:out value="${target.objective.name}" />
      </c:if>
    </td>
  </tr>

  <c:if test="${target.completed}" >
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.completedBy" />:</td>
    <td><c:out value="${target.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.completionDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="target.achieved" />:</td>
    <td><fmt:message key="boolean.${target.achieved}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="target.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${target.completionComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td ><c:out value="${target.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${target.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${target.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
    <c:if test="${target.lastUpdatedByUser == null}">
    <td></td>
    <td></td>
     </c:if>
  </tr>
  </tbody>
  <tfoot class="hidden-print">
    <tr>
      <td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="target" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${target.site.name}" />
							 </fmt:message>
				</c:otherwise>
			</c:choose>
      </td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
<c:if test="${not empty targetComments}">
<div class="header">
<h3><fmt:message key="objective.target.comments" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive dataTable">
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="targetComment.comment" /></th>
      <th><fmt:message key="createdBy" /></th>
      <th style="width:100px"><fmt:message key="targetComment.targetAchievement" /></th>
    </tr>
  </thead>
  <tbody id="questionsTbody">
  <c:forEach items="${targetComments}" var="targetComment" >
    <tr>
    	<c:choose>
    	<c:when test="${targetComment.editable}">
      		<td><a href="<c:url value="/risk/targetComment.htm"><c:param name="showId" value="${targetComment.id}" /></c:url>"><c:out value="${targetComment.id}" /></a></td>
      	</c:when>
      	<c:otherwise>
      		<td><c:out value="${targetComment.id}" /></td>
      	</c:otherwise>
      	</c:choose>
      <td><c:out value="${targetComment.comment}" /></td>
      <td><c:out value="${targetComment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${targetComment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      <td class="${targetComment.targetAchievement.name}" style="width:20px"></td>
    </tr>
  </c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>
</div>               
</body>
</html>
