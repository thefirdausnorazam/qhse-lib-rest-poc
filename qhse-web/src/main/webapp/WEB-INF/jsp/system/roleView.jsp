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
<h2><fmt:message key="roleView" /></h2>
</div>
<a name="role"></a>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
<col class="label" />
<tbody>
  <tr>
    <td ><fmt:message key="name" />:</td>
    <td><fmt:message key="userRole.${role.code}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="users" />:</td>
    <td>
      <ul>
      <c:forEach items="${role.users}" var="user" varStatus="s">
        <li><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}" /></c:url>"><c:out value="${user.lastName}, ${user.firstName}" /></a></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="groups" />:</td>
    <td>
      <ul>
      <c:forEach items="${role.groups}" var="group" varStatus="s">
        <li><a href="<c:url value="groupView.htm"><c:param name="id" value="${group.id}" /></c:url>"><c:out value="${group.name}" /></a></li>
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
