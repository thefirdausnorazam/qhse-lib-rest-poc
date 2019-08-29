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
<h2><fmt:message key="wasteCodeAuthorisationView" /></h2>
</div>
<div class="content">
<div class="header">
<h3> <fmt:message key="wasteCodeAuthorisation" /> <fmt:message key="for" /> <c:out value="${authorisation.owner.name}" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
  <col>
  
  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${authorisation.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="referenceNo" />:</td>
      <td><c:out value="${authorisation.referenceNo}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="startDate" />:</td>
      <td><fmt:formatDate value="${authorisation.startDate}" pattern="dd-MMM-yyyy" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="endDate" />:</td>
      <td><fmt:formatDate value="${authorisation.endDate}" pattern="dd-MMM-yyyy" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="notes" />:</td>
      <td><scannell:text value="${authorisation.notes}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="wasteTypeCodes" />:</td>
      <td>
        <c:forEach items="${authorisation.wasteTypeCodes}" var="code">
          <div><scannell:text value="${code}" /></div>
        </c:forEach>  
      </td>
    </tr>

    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${authorisation.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${authorisation.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${authorisation.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${authorisation.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${authorisation.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
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
