<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>

<body>
<div class="header">
<h2><fmt:message key="groupView" /></h2>
</div>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
<tbody>
  <tr>
    <td ><fmt:message key="name" />:</td>
    <td><c:out value="${group.name}" /></td>
  </tr>
  <c:if test="${showModules}">
	  <tr>
	    <td ><fmt:message key="modules" /></td>
	    <td>
          <c:if test="${empty group.modules}"><fmt:message key="none" /></c:if>
	      <ul>
	      <c:forEach items="${group.modules}" var="moduleAndAccessLevel" varStatus="s">
	        <li><a href="<c:url value="licenceView.htm"><c:param name="id" value="${licenceId}" /></c:url>"><fmt:message key="${moduleAndAccessLevel.key.name}" /> - <fmt:message key="AccessLevel.${moduleAndAccessLevel.value}" /></a></li>
	      </c:forEach>
	      </ul>
	    </td>
	  </tr>
	  <tr>
	    <td ><fmt:message key="user.effectiveAccessRights" /></td>
	    <td>
	      <c:if test="${empty roles}"><fmt:message key="none" /></c:if>
	      <ul>
	      <c:forEach items="${roles}" var="role" varStatus="s">
	        <li><c:out value="${role.right}" /></li>
	      </c:forEach>
	      </ul>
	    </td>
	  </tr>
  </c:if>
  <tr>
    <td><fmt:message key="usersCountActive" />:</td>
    <td>
    	<c:set var="activeUsers" value="${activeUsers}"/>${fn:length(activeUsers)}
    </td>
  </tr>
  <tr>
    <td><fmt:message key="usersCount" />:</td>
    <td>
    	<c:set var="myUsers" value="${group.users}"/>${fn:length(myUsers)}
    </td>
  </tr>
  <tr>
    <td><fmt:message key="users" />:</td>
    <td>
      <ul>
      <c:forEach items="${group.users}" var="user" varStatus="s">
        <li><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}" /></c:url>"><c:out value="${user.sortableName}" /></a></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${group.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${group.lastUpdatedByUser != null}">
	  <tr>
	    <td ><fmt:message key="lastUpdatedBy" /></td>
	    <td>
	      <c:out value="${group.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
	    </td>
	  </tr>
	</c:if>
</tbody>

<tfoot>
  <tr><td colspan="2"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
