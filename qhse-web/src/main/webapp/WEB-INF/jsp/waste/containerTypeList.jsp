<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="containerTypeList" /></h2>
</div>
<div class="content">
<scannell:url urls="${urls}" />
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
  <thead>
    <tr>
      <td colspan="5"><fmt:message key="containerTypeList" /></td>
    </tr>
    <tr>
      <th><fmt:message key="name" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${containerTypes}" var="containerType" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td>
          <a href="<c:url value="containerTypeView.htm"><c:param name="id" value="${containerType.id}"/></c:url>" >
            <c:out value="${containerType.name}" />
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="5"><scannell:url urls="${urls}" /></td>
    </tr>
  </tfoot>
  
</table>
</div>
</div>
</div>
</body>
</html>
