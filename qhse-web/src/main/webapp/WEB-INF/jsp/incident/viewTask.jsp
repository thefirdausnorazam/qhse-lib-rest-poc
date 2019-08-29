<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
   
    <script type="text/javascript" >
    jQuery(document).ready(function() {	 
    	onPageLoad();
    });
		function onPageLoad() {
			var inProgressWarning = '<c:out value="${object.inProgressWarning}" />';
			if (inProgressWarning == 'true') {
				//alert("This Task has been in progress for more than 60 days");
			}
		}	
   </script>
  
</head>
<body>
<div class="header">
<h2><fmt:message key="viewTask" /></h2>
</div>
<c:set var="updateIncidentAllowed" value="${actionSite.id == site.id}" />
<div class="content">
<div class="table-responsive">
<!-- <div class="header"> -->
<!-- <h3>Task Details</h3> -->
<!-- </div> -->
<div class="content">
<div class="panel">

<table class="table table-bordered table-responsive">
<tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td><c:out value="${object.id}" /></td>
  </tr>
  <c:if test="${showLegacyId}">
  <tr>
    <td >Legacy Id</td>
    <td><c:out value="${object.legacyId}" /></td>
  </tr>
  </c:if>
	<tr>
		<td><fmt:message key="businessAreas" />:</td>
		<td colspan="3">
		     <ul>
		      <c:forEach var="ba" items="${object.businessAreas}">
		        	<li><c:out value="${ba.name}" /></li>
		      </c:forEach>
		      </ul>
		</td>
	</tr>
  <tr>
    <td ><fmt:message key="description" />:</td>
    <td><div><c:out value="${object.description}" /></div></td>
  </tr>

  <tr>
    <td ><fmt:message key="targetDate" />:</td>
    <td><fmt:formatDate value="${object.targetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="responsibleUser" />:</td>
    <td><c:out value="${object.responsibleUser.displayName}" /></td>
<%--     <c:if test="${object.responsibleUser.department != ''}"> --%>
<%--     	<td ><fmt:message key="department" /></td> --%>
<%--     	<td><c:out value="${object.responsibleUser.department}" /></td> --%>
<%--     </c:if>       --%>
  </tr>
  <tr>
    <td ><fmt:message key="responsibleDepartment" /></td>
    <td><c:out value="${object.responsibleDepartment.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="status" />:</td>
    <td>
    	<c:choose>
 	   		<c:when test="${object.trash}"><fmt:message key="trash" /></c:when>
   	   		<c:otherwise> <fmt:message key="closed.${object.completed}" /></c:otherwise>
    	</c:choose>
   </td> 
  </tr>
  <c:if test="${object.priority != null}">
  <tr>
    <td ><fmt:message key="priority" /></td>
    <td><fmt:message key="${object.priority}" /></td>
  </tr>
  </c:if>
    

  <c:if test="${object.completed}">
  <tr>
    <td ><fmt:message key="completedBy" />:</td>
    <td><c:out value="${object.completedBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.completedTime}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="completedComment" />:</td>
    <td><div><c:out value="${object.completedComment}" /></div></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${object.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${object.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${object.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${object.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  </c:if>
</tbody>

<tfoot>
  <tr>
    <td colspan="2">
    	<c:choose>
	    	<c:when test="${updateIncidentAllowed}">
			      <c:if test="${editable && object.completed == false && object.trash==false }">
			        <a href="<c:url value="editTask.htm"><c:param name="showId" value="${object.id}" /></c:url>"><fmt:message key="editTask" /></a>&nbsp;|
			      </c:if>
			      <c:if test="${object.completable}">
			        <a href="<c:url value="completeTask.htm"><c:param name="showId" value="${object.id}" /></c:url>"><fmt:message key="completeTask" /></a>&nbsp;|
			      </c:if>
			      <a href="<c:url value="viewAction.htm" ><c:param name="id" value="${object.action.id}" /></c:url>"><fmt:message key="viewAction" ><fmt:param value="" /></fmt:message></a>&nbsp;|
			      <c:if test="${object.lastUpdatedByUser != null}">
			        <a href="javascript:openHistory(<c:out value="${object.id},'${object['class'].name}'" />)"><fmt:message key="viewHistory" /></a>&nbsp;|
			      </c:if>
			      <c:if test="${editable && !object.completed }">
				      	<c:choose>
						     <c:when test="${object.trash}">
						     	<a href="<c:url value="trashTask.htm"><c:param name="showId" value="${object.id}" /></c:url>">
						       	<fmt:message key="untrash" /></a>&nbsp;|
						     </c:when>
						     <c:otherwise>
							     <a href="<c:url value="trashTask.htm"><c:param name="showId" value="${object.id}" /></c:url>">
							         <fmt:message key="trash" /></a>&nbsp;|
						     </c:otherwise>
					     </c:choose>
				   </c:if>
			      <c:if test="${object.completable}">
			        <a href="<c:url value="addActionAttachment.htm"><c:param name="showId" value="${object.action.id}" /></c:url>"><fmt:message key="addAttachmentToAction" /></a>
			      </c:if>
			 </c:when>
			 <c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${actionSite.name}" /></fmt:message></c:otherwise>
		</c:choose>
   </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
