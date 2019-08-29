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
<a name="user"></a>
<div class="content">
<div class="header">
<h3><fmt:message key="userView" /> : <c:out value="${theUser.firstName} ${theUser.lastName}" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered">  
<col class="label" />
<%-- <thead>
  <tr>
    <td colspan="2">
      <div class="navLinks"></div>
      <fmt:message key="userView" /> : <c:out value="${theUser.firstName} ${theUser.lastName}" />
    </td>
  </tr>
</thead> --%>

<tbody>
  <tr>
    <td ><fmt:message key="id" /></td>
    <td><c:out value="${theUser.id}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userName" />:</td>
    <td><c:out value="${theUser.userName}" /></td>
  </tr>
  <c:if test="${showDomain}">
	  <tr>
	    <td ><fmt:message key="userDomain" />:</td>
	    <td><c:out value="${theUser.domain.name}" /></td>
	  </tr>
  </c:if>
  <tr>
    <td ><fmt:message key="firstName" /></td>
    <td><c:out value="${theUser.firstNameDisplay}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="lastName" /></td>
    <td><c:out value="${theUser.lastNameDisplay}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="title" /></td>
    <td><c:out value="${theUser.title}" /></td>
  </tr>
  <tr>
     <td ><fmt:message key="user.gender" /></th>
     <td ><c:out value="${theUser.gender}" /></td>
  </tr>
   <tr>
        <td><fmt:message key="user.age" /></td>
        <td><c:out value="${theUser.age}" /></td>
    </tr>
    <tr >
        <td ><fmt:message key="user.commenceDate" /></td>
        <td ><fmt:formatDate value="${theUser.commenceDate}" pattern="dd-MM-yyyy"  /></td>
      </tr>
  <tr>
    <td ><fmt:message key="division" /></td>
    <td><c:out value="${theUser.division}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="empId" /></td>
    <td><c:out value="${theUser.empId}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="emailAddress" /></td>
    <td><c:out value="${theUser.emailAddress}" /></td>
  </tr>
    <tr>
    <td><fmt:message key="user.postToManagerPost" /></td>
    <td><c:out value="${theUser.postReportPost}" /></td>
  </tr>
    <tr>
    <td ><fmt:message key="user.postNumber" /></td>
    <td><c:out value="${theUser.postNumber}" /></td>
  </tr>
    <tr>
    <td ><fmt:message key="user.avialable" /></td>
    <td><c:out value="${theUser.userFieldDescription}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="phoneNumber" /></td>
    <td><c:out value="${theUser.phoneNumber}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="active" /></td>
    <td><fmt:message key="${theUser.active}" /></td>
  </tr>
  <tr>
    <td><fmt:message key="defaultSite" /></td>
    <td><c:out value="${theUser.defaultSite}" /></td>
  </tr>
  <tr>
    <td><fmt:message key="department" /></td>
    <td><c:out value="${theUser.department.name}" /></td>
  </tr>
  <tr>
    <td><fmt:message key="workArea" /></td>
    <td><c:out value="${theUser.dptCodeDescription}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="groups" /></td>
    <td>
      <ul>
      <c:forEach items="${theUser.displayGroups}" var="group" varStatus="s">
        <li>
        	<a href="<c:url value="groupView.htm"><c:param name="id" value="${group.id}" /></c:url>"><c:out value="${group.name}" /></a>
        	<c:if test="${currentLicence.modulesAssignableToGroups}">
        		<ul>
        			<c:forEach var="moduleAndAccessLevel" items="${group.modules}">
				        <li><fmt:message key="${moduleAndAccessLevel.key.name}" /> - <fmt:message key="AccessLevel.${moduleAndAccessLevel.value}" /></li>
        			</c:forEach>
        		</ul>
        	</c:if>
        </li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="modules" /></td>
    <td>
      <c:if test="${empty theUser.modules}"><fmt:message key="none" /></c:if>
      <ul>
      <c:forEach items="${theUser.modules}" var="moduleAndAccessLevel" varStatus="s">
        <li><fmt:message key="${moduleAndAccessLevel.key.name}" /> - <fmt:message key="AccessLevel.${moduleAndAccessLevel.value}" /></li>
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
  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${theUser.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${theUser.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${theUser.lastUpdatedByUser != null}">
	  <tr>
	    <td ><fmt:message key="lastUpdatedBy" /></td>
	    <td>
	      <c:out value="${theUser.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${theUser.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
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
