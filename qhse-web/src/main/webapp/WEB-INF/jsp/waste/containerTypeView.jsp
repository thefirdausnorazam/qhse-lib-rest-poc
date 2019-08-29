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
<h2><fmt:message key="containerTypeView" /></h2>
</div>
<div class="content">
<div class="header">
<h3><fmt:message key="containerType" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
  <col >
 
  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${containerType.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="name" />:</td>
      <td><c:out value="${containerType.name}" /></td>
    </tr>

    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${containerType.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${containerType.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${containerType.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${containerType.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${containerType.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
      </td>
    </tr>
    </c:if>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2">
        <scannell:url urls="${urls}" />
      </td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
