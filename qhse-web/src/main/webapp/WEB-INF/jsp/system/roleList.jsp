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
<h2><fmt:message key="roleList" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
  <thead>
    <tr>
      <th><fmt:message key="name" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${roles}" var="role" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="roleView.htm"><c:param name="id" value="${role.id}"/></c:url>" ><fmt:message key="userRole.${role.code}" /></a></td>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
