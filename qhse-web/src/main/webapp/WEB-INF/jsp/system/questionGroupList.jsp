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
<h2><fmt:message key="questionGroupList" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
  <thead>
    <tr>
      <td colspan="10"><scannell:url urls="${urls}" /></td>
    </tr>
    <tr>
      <th><fmt:message key="codeName" /></th>
      <th><fmt:message key="displayName" /></th>
      <th><fmt:message key="active" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${groups}" var="group" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="questionGroupView.htm"><c:param name="id" value="${group.id}"/></c:url>" ><c:out value="${group.codeName}" /></a></td>
        <td><c:out value="${group.name}" /></td>
        <td><fmt:message key="${group.active}" /></td>
      </tr>
    </c:forEach>
   </tbody>
  <tfoot>
    <tr>
      <td colspan="10"><scannell:url urls="${urls}" /></td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
