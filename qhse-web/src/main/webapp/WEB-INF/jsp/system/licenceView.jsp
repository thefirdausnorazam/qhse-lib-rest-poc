<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>

<body>
<div class="header">
<h2><fmt:message key="licenceView" /></h2>
</div>
<a name="licence"></a>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>


<tbody>
  <tr>
    <td ><fmt:message key="licence.importedBy" /></td>
    <td><c:out value="${licence.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${licence.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="licence.expiryDate" />:</td>
    <td><c:out value="${licence.expiryDate}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="licence.comment" />:</td>
    <td><c:out value="${licence.comment}" /></td>
  </tr>
  
  <c:choose>

  	<c:when test="${licence.type == 'LIMITED'}">
	  <tr>
	    <td ><fmt:message key="licence.licencedModuleUsers" />:</td>
	    <td>
	     	<table class='table table-responsive table-bordered'>
	     		<thead>
	     			<tr>
	     				<th><fmt:message key="licencedModule.module" /></th>
	     				<c:forEach items="${accessLevels}" var="accessLevel">
	      				<th><fmt:message key="licencedModule.${accessLevel}.maxUsers" /></th>
	     				</c:forEach>
	     			</tr>
	     		</thead>
	     		<tbody>
		      <c:forEach items="${licencedModules}" var="entry">
		      	<c:set var="module" value="${entry.key}" />
		      	<c:set var="accessLevelMaxUsers" value="${entry.value}" />
	     			<tr>
	     				<th><fmt:message key="${module.name}" /></th>
	     				<c:forEach items="${accessLevels}" var="accessLevel">
	      				<td>${accessLevelMaxUsers[accessLevel]} </td>
	     				</c:forEach>
	     			</tr>
	     		  </c:forEach>
	     		</tbody>
	     	</table>
	    </td>
  	  </tr>
  	</c:when>

  	<c:when test="${licence.type == 'UNLIMITED'}">
	  <tr>
	    <td ><fmt:message key="licence.licencedModulesUnlimmited" />:</td>
	    <td>
			<c:set var="roles" value="${licencedAccessLevel.value}" />
			<ul>
				<c:forEach items="${licencedModules}" var="licencedModule">
				  <li><fmt:message key="${licencedModule.key.name}" /></li>
				</c:forEach>
      		</ul>
	    </td>
  	  </tr>
  	</c:when>

  </c:choose>
   
  <tr>
    <td ><fmt:message key="licence.MobileEnabled" />:</td>
    <td>
    	<c:choose>
			<c:when test="${licence.mobile == 'NONE'}">
				<ul>
					<li><fmt:message key="no" /></li>
	      		</ul>
			</c:when>
			<c:when test="${licence.mobile == 'INCIDENT'}">
				<ul>
					<li><fmt:message key="enviroINCIDENT" /></li>
	      		</ul>
			</c:when>
			<c:when test="${licence.mobile == 'AUDIT'}">
				<ul>
					<li><fmt:message key="enviroAUDIT" /></li>
	      		</ul>
			</c:when>
			<c:when test="${licence.mobile == 'INCIDENT_AUDIT'}">
				<ul>
					<li><fmt:message key="enviroINCIDENT" /></li>
					<li><fmt:message key="enviroAUDIT" /></li>
	      		</ul>
			</c:when>
			<c:when test="${licence.mobile == 'ALL'}">
				<ul>
					<li><fmt:message key="enviroINCIDENT" /></li>
					<li><fmt:message key="enviroAUDIT" /></li>
	      		</ul>
			</c:when>
			<c:otherwise>
				<ul>
					<li><fmt:message key="no" /></li>
	      		</ul>
			</c:otherwise>
		</c:choose>
    </td>
 	  </tr>
  
  <tr>
    <td ><fmt:message key="licence.licencedAccessLevels" />:</td>
    <td>
      <ul>
      <div class="panel">
      	<table class='table table-responsive table-bordered'>
      		<thead>
      			<tr>
      				<th width="25%"><fmt:message key="licencedAccessLevel.accessLevel" /></th>
      				<th><fmt:message key="licencedAccessLevel.roles" /></th>
      			</tr>
      		</thead>
      		<tbody>
		      <c:forEach items="${licencedAccessLevelsToRoleNames}" var="licencedAccessLevel">
      			<tr>
      				<th><fmt:message key="AccessLevel.${licencedAccessLevel.key}" /></th>
      				<td>
      					<c:set var="roles" value="${licencedAccessLevel.value}" />
      					<c:if test="${empty roles}"><fmt:message key="none" /></c:if>
					    <ul>
      					<c:forEach items="${roles}" var="role">
        				  <li><c:out value="${role}" /></li>
      					</c:forEach>
      					</ul>
      				</td>
      			</tr>
      		  </c:forEach>
      		</tbody>
      	</table>
      	</div>
      </ul>
    </td>
  </tr>
   
  <tr>
    <td ><fmt:message key="licence.assignableAccessRights" />:</td>
    <td>
	  <ul>
	      <c:forEach items="${assignableAccessRights}" var="role" varStatus="s">
	        <li><c:out value="${role.right}" /></li>
	      </c:forEach>
  	  </ul>
    </td>
  </tr>
</tbody>

<tfoot>
  <tr><td colspan="2"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
