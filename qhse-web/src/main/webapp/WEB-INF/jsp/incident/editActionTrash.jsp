<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
</head>
<body>

<scannell:form action="/incident/actionTrashUnTrash.htm?id=${action.id}" >
<fmt:message key="${action['class'].name}" var="typeName" />
<div class="header">
        <h3>  
       <c:choose>
 	   	<c:when test="${action.trash}"><fmt:message key="actionUnTrash" /></c:when>
   	   	<c:otherwise> <fmt:message key="actionTrash" /></c:otherwise>
   		</c:choose>
        </h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel "> 

<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <tr>
    <td ><fmt:message key="id" /></td>
    <td colspan="4"><c:out value="${action.id}" /></td>
  </tr>
  <c:if test="${showLegacyId}">
  <tr>
    <td >Legacy Id</td>
    <td><scannell:text value="${action.legacyId}" /></td>
  </tr>
  </c:if>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
		<td colspan="4">
		     <ul>
		      <c:forEach var="ba" items="${action.businessAreas}">
		        	<li><c:out value="${ba.name}" /></li>
		      </c:forEach>
		      </ul>
		</td>
	</tr>
  <tr>
    <td ><fmt:message key="type" /></td>
    <td colspan="4"><c:out value="${typeName}" /></td>
  </tr>
  <c:if test="${action.category != null}">
	  <tr>
	    <td ><fmt:message key="category" /></td>
	    <td colspan="4"><c:out value="${action.category.name}" /></td>
	  </tr>
  </c:if>
  <tr>
    <td ><fmt:message key="description" /></td>
    <td colspan="4"><scannell:text htmlEscape="true" value="${action.description}"  /></td>
  </tr>
  <tr>
    <td ><fmt:message key="capaType" /></td>
    <td colspan="4"><scannell:text htmlEscape="true" value="${action.capaType.name}"  /></td>
  </tr>
  <tr>
    <td ><fmt:message key="status" /></td>
    <td colspan="4">
    <c:choose>
    <c:when test="${action.trash}"><fmt:message key="trash" /></c:when>
    <c:otherwise> <fmt:message key="${action.statusCode}" /></c:otherwise>
    </c:choose>
  </td>
  </tr> 
  <c:if test="${action.priority != null}">
  <tr>
    <td ><fmt:message key="priority" /></td>
    <td colspan="4"><fmt:message key="${action.priority}" /></td>
  </tr>
  </c:if>
    
  <tr>
    <td ><fmt:message key="completionTargetDate" /></td>
    <td colspan="4"><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="responsibleUser" /></td>
    <td colspan="4"><c:out value="${action.responsibleUser.displayName}" /></td>

  </tr>
  <tr>
    <td ><fmt:message key="responsibleDepartment" /></td>
    <td colspan="4"><c:out value="${action.responsibleDepartment.name}" /></td>
  </tr>
<c:if test="${action.completed}">
  <tr>
    <td ><fmt:message key="completedBy" /></td>
    <td colspan="4"><c:out value="${action.completedBy.displayName}" /> <fmt:message key="at" />
      <fmt:formatDate value="${action.completedTime}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="completedComment" /></td>
    <td colspan="4"><scannell:text value="${action.completedComment}" /></td>
  </tr>
<c:if test="${action.verifiable}">
  <tr>
    <td ><fmt:message key="verificationTargetDate" />:</td>
    <td colspan="4"><fmt:formatDate value="${action.verificationTargetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="verifyingUser" /></td>
    <td colspan="4"><c:out value="${action.verifyingUser.displayName}" /></td>
  </tr>
</c:if>
</c:if>
<c:if test="${action.verified}">
  <tr>
    <td ><fmt:message key="verifiedBy" /></td>
    <td colspan="4"><c:out value="${action.verifiedBy.displayName}" /> <fmt:message key="at" />
      <fmt:formatDate value="${action.verifiedTime}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="verificationSuccessful" /></td>
    <td colspan="4"><fmt:message key="${action.verificationSuccessful}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="verifiedComment" /></td>
    <td colspan="4"><scannell:text value="${action.verificationComment}" /></td>
  </tr>
</c:if>
  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td colspan="4"><c:out value="${action.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${action.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <c:if test="${action.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" /></td>
    <td colspan="4">
      <c:out value="${action.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${action.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
</tbody>
<c:if test="${!empty action.tasks and !action.trash}">
<tbody>  <tr>
		 <th colspan="5">
		 <font style="color: red">
		 <fmt:message key="actionTrashTasks" />
		 </font>
		 </th>
		 </tr>
		  <tr>
		  		<th><fmt:message key="task" /></th>
			    <th><fmt:message key="description" /></th>
			    <th><fmt:message key="targetDate" /></th>
			    <th><fmt:message key="responsibleUser" /></th>
			    <th><fmt:message key="status" /></th>
		  </tr>
		</tbody>
		<tbody>
		      <c:forEach items="${action.tasks}" var="item">
			      	<c:choose>
				      <c:when test="${item != null and !item.trash and !item.completed}">
					      <tr>
					            <td><a href="<c:url value="viewTask.htm"><c:param name="id" value="${item.id}" /></c:url>">${item.id}</a></td>
						        <td><scannell:text value="${item.description}" /></td>
						        <td><fmt:formatDate value="${item.targetDate}" pattern="dd-MMM-yyyy" /></td>
						        <td><c:out value="${item.responsibleUser.displayName}" /></td>
						        <td><fmt:message key="closed.${item.completed}" /></td>
						        
					      </tr>
					  </c:when>
					</c:choose>
		      </c:forEach>
		</tbody>
	</c:if>
<tfoot>
  <tr>
    <td colspan="5" align="center">
    <c:if test="${action.trash == false}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
    </c:if>
   <c:if test="${action.trash == true}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />">
    </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/incident/viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
