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
<h2><fmt:message key="userDomainView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
<col  />
<thead>
  <tr>
    <td colspan="2">
      <div class="navLinks"></div>
      <fmt:message key="userDomainView" /> : <c:out value="${domain.name}" />
    </td>
  </tr>
</thead>

<tbody>
  <tr>
    <td ><fmt:message key="id" /></td>
    <td><c:out value="${domain.id}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.type" />:</td>
    <td><fmt:message key="${domain['class'].simpleName}"/></td>
  </tr>
  <tr>
    <td ><fmt:message key="active" /></td>
    <td><fmt:message key="${domain.active}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.permittedClientAddresses" /></td>
    <td><c:out value="${domain.permittedClientAddresses}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.userNameProperty" /></td>
    <td><c:out value="${domain.userNameProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.firstNameProperty" /></td>
    <td><c:out value="${domain.firstNameProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.surnameNameProperty" /></td>
    <td><c:out value="${domain.surnameNameProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.emailProperty" /></td>
    <td><c:out value="${domain.emailProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.groupsProperty" /></td>
    <td><c:out value="${domain.groupsProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.mappedGroups" /></td>
    <td>
      	<c:if test="${empty domain.mappedGroups}"><fmt:message key="none" /></c:if>
    	<ul>
    	<c:forEach var="item" items="${domain.mappedGroups}">
    		<li><c:out value="${item.key}" /> => <a href="<c:url value="groupView.htm"><c:param name="id" value="${item.value.id}" /></c:url>"><c:out value="${item.value.name}" /></a></li>
    	</c:forEach>
    	</ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.defaultGroups" /></td>
    <td>
      	<c:if test="${empty domain.defaultGroups}"><fmt:message key="none" /></c:if>
    	<ul>
    	<c:forEach var="item" items="${domain.defaultGroups}">
    		<li><a href="<c:url value="groupView.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a></li>
    	</c:forEach>
    	</ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.departmentProperty" /></td>
    <td><c:out value="${domain.departmentProperty}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.defaultDepartment" /></td>
    <td><c:out value="${domain.defaultDepartment}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="userDomain.mappedDepartments" /></td>
    <td>
      	<c:if test="${empty domain.mappedDepartments}"><fmt:message key="none" /></c:if>
    	<ul>
    	<c:forEach var="item" items="${domain.mappedDepartments}">
    		<li><c:out value="${item.key}" /> => <c:out value="${item.value.name}" /></li>
    	</c:forEach>
    	</ul>
    </td>
  </tr>
  <tr>
  	<td></td>
  	<td>
		<table class='table table-responsive table-bordered'>
		<thead>
			<tr>
				<th><fmt:message key="lastName" /></th>
				<th><fmt:message key="firstName" /></th>
				<th><fmt:message key="userName" /></th>
				<th><fmt:message key="active" /></th>
				<th><fmt:message key="title" /></th>
				<th><fmt:message key="department" /></th>
				<th><fmt:message key="division" /></th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${domain.users}" var="user" varStatus="s">
				<c:choose>
					<c:when test="${s.index mod 2 == 0}">
						<c:set var="style" value="even" />
					</c:when>
					<c:otherwise>
						<c:set var="style" value="odd" />
					</c:otherwise>
				</c:choose>
				<tr class="<c:out value="${style}" />">
					<td><c:out value="${user.lastNameDisplay}" /></td>
					<td><c:out value="${user.firstNameDisplay}" /></td>
					<td><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}"/></c:url>" ><c:out value="${user.userName}" /></a></td>
					<td><fmt:message key="${user.active}"/></td>
					<td><c:out value="${user.title}" /></td>
					<td><c:out value="${user.department.name}" /></td>
					<td><c:out value="${user.division}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	
		</table>
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
