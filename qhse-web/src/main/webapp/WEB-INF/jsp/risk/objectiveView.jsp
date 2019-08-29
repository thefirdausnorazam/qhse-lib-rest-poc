<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
  	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>
  <style type="text/css" media="all">   
     @import "<c:url value='/css/risk.css'/>";
  </style>
</head>
<body>
<div class="header ">
<h2><fmt:message key="objectiveView.title" /></h2>
</div>
<div class="content">
<a name="objective"></a>
<!-- <div class="header nowrap"> -->
<%-- <h3><fmt:message key="objective" /></h3> --%>
<!-- </div> -->
<div class="content">  
<div class="table-responsive">
<div class="panel">

<table class="table table-bordered table-responsive" >
  <col  />  
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td><c:out value="${objective.displayId}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="objective.status" />:</td>
    <td><fmt:message key="task.${objective.status}" /></td>
  </tr>
  <c:if test="${showLegacyId}">
    <tr>
  		<td class="scannellGeneralLabel"><fmt:message key="legacyId" /></td>
     	<td colspan="3"><c:out value="${objective.legacyId}" /></td>
    </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="ba" items="${objective.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.name" />:</td>
    <td colspan="3"><scannell:text value="${objective.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.benefit" />:</td>
    <td colspan="3"><scannell:text value="${objective.benefit}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.creationDate" />:</td>
    <td><fmt:formatDate value="${objective.creationDate}" pattern="dd-MMM-yyyy"/></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="objective.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${objective.targetCompletionDate}" pattern="dd-MMM-yyyy"/></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.category" />:</td>
    <td colspan="3"><c:out value="${objective.category.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.externalObjective" />:</td>
    <td colspan="3"><c:out value="${objective.externalObjective}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.sponsor" />:</td>
    <td colspan="3"><c:out value="${objective.sponsor}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="objective.percentCompleted" />:</td>
    <td colspan="3"><c:out value="${objective.percentCompleted}" />%</td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.progressComment" />:</td>
    <td colspan="3"><scannell:text value="${objective.progressComment}" /></td>
  </tr>

  <c:if test="${objective.completed}">
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.completedBy" />:</td>
    <td colspan="3"><c:out value="${objective.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="objective.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${objective.completionComment}" /></td>
  </tr>
  </c:if>
  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="uploadedDocuments" />:</td>
		    <td colspan="3">
		     <ul>
		      <c:forEach items="${objective.attachments}" var="item">
			  <c:if test="${item.active}">
			  <c:choose>
				<c:when test="${item.type.name == 'attach'}">
				  <li>
				 <%--  <a href="<c:url value="objectiveAttachmentEdit.htm"><c:param name="itemId" value="${item.id}" /><c:param name="showId" value="${objective.id}" /></c:url>"><c:out value="${item.name}" /></a> --%>
				  <a target="attachment" href="<c:url value="viewObjectiveAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
					<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /></li>
			    </c:when>
				<c:otherwise>
					<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
						<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /></li>
				</c:otherwise>
			  </c:choose> 
			  </c:if>
			  </c:forEach>
			  </ul>
		    </td>
		  </tr>

	<tr>
    	<td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
    	<td colspan="3">
			<c:set var="showLatest" value="${objective.status.name != 'COMPLETE'}" scope="request"/>
			<jsp:include page="../doclink/showLinkedDocs.jsp" />
		</td>
  	</tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${objective.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${objective.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${objective.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="objective" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${objective.site.name}" />
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

<%--
  String url = request.getRequestURL()+"?"+request.getQueryString();
  int x = url.indexOf("&displayAll=true");
  url = (x == -1) ? url+"&displayAll=true" : url.substring(0, x) + url.substring(x + "&displayAll=true".length());
  String label = (x == -1) ? "Display Completed" : "Hide Completed";
--%>

<c:if test="${not empty objective.targets}">
<a name="objectiveTargets"></a>
<div class="header">
<h3><fmt:message key="objective.targets" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive dataTable">
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="target.name" /></th>
      <th><fmt:message key="target.targetCompletionDate" /></th>
      <th><fmt:message key="target.status" /></th>
      <th><fmt:message key="target.responsibleUser" /></th>
    </tr>
  </thead>
  <tbody id="questionsTbody">
  <c:forEach items="${objective.targetsHighestToLowest}" var="target" varStatus="s">
  <c:if test="${(param.showAllOTs  || param.showCompletedOTs && target.completed) || (!param.showCompletedOTs  && target.inProgress)}">
    <tr>
      <td><a href="<c:url value="/risk/targetView.htm"><c:param name="id" value="${target.id}" /></c:url>"><c:out value="${target.displayId}" /></a></td>
      <td><c:out value="${target.name}" /></td>
      <td><fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="task.${target.status}" /></td>
      <td><c:out value="${target.responsibleUser.displayName}" /></td>
    </tr>
  </c:if>
  </c:forEach> 
 </tbody>
<tfoot>
  <tr>
    <td colspan="5" style="text-align:center;">
        <c:url var="url" value="/risk/objectiveView.htm">
          <c:param name="id" value="${objective.id}"/>
        </c:url>
        <span>Show: </span>
        <select id="targetStatus" name="targetStatus" onchange="location = '${url}' + '&' + this.options[this.selectedIndex].value + '=true&' + jQuery('select[name=\'managementProgrammeStatus\']').val()+ '=true' + '#objectiveTargets';">
        		
                 <option value="inProgressOTs">In Progress</option>
                 <option value="showCompletedOTs" <c:if test="${param.showCompletedOTs}">selected="selected"</c:if>>Complete</option>
                 <option value="showAllOTs" <c:if test="${param.showAllOTs}">selected="selected"</c:if>>All</option>
        </select>
    </td>
  </tr>
  </tfoot>
 
</table>
</div>  
</div>
</div>
</c:if>


<c:if test="${not empty objective.managementProgrammes}">
<a name="managementProgrammes"></a>
<div class="header">
<h3><fmt:message key="objective.managementProgrammes" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel">

<table class="table table-bordered table-responsive dataTable">
  <thead>   
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="managementProgramme.name" /></th>
      <th><fmt:message key="managementProgramme.targetCompletionDate" /></th>
      <th><fmt:message key="managementProgramme.status" /></th>
      <th><fmt:message key="managementProgramme.responsibleUser" /></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${objective.managementProgrammesHigestToLowest}" var="managementProgramme" varStatus="s">
  <c:if test="${param.showAllMPs || (param.showCompletedMPs && managementProgramme.completed) || (!param.showCompletedMPs  && managementProgramme.inProgress)}">
    <tr>
      <td><a href="<c:url value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}" /></c:url>"><c:out value="${managementProgramme.displayId}" /></a></td>
      <td><c:out value="${managementProgramme.name}" /></td>
      <td><fmt:formatDate value="${managementProgramme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
      <td><fmt:message key="task.${managementProgramme.status}" /></td>
      <td><c:out value="${managementProgramme.responsibleUser.displayName}" /></td>
    </tr>
  </c:if>
  </c:forEach>
  </tbody>
 <tfoot>
  <tr>
    <td colspan="5" style="text-align:center;">
        <c:url var="url" value="/risk/objectiveView.htm">
          <c:param name="id" value="${objective.id}"/>
        </c:url>
        <span>Show: </span>
        <select name="managementProgrammeStatus" onchange="location = '${url}' + '&' + this.options[this.selectedIndex].value + '=true&' + jQuery('select[name=\'targetStatus\']').val()+'=true' + '#managementProgrammes' ;">
        		
                 <option value="inProgressMPs">In Progress</option>
                 <option value="showCompletedMPs" <c:if test="${param.showCompletedMPs}">selected="selected"</c:if>>Complete</option>
                 <option value="showAllMPs" <c:if test="${param.showAllMPs}">selected="selected"</c:if>>All</option>
        </select>

    </td>
  </tr>
  </tfoot>
</table>
</div>  
</div>
</div>
</c:if>
</div>
</body>
</html>
