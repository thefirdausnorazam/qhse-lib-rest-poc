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
<h2><fmt:message key="wasteTypeCategoryView" /></h2>
</div>
<div class="content"> 
<div class="header">
<h3><fmt:message key="wasteTypeCategory" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">   
<table class="table table-bordered table-responsive">
  
  
  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${wasteTypeCategory.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="name" />:</td>
      <td><c:out value="${wasteTypeCategory.name}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="categoryClass" />:</td>
      <td><c:out value="${wasteTypeCategory.categoryClass.name}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="additionalInfo" />:</td>
      <td><scannell:text value="${wasteTypeCategory.additionalInfo}" /></td>
    </tr>

    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${wasteTypeCategory.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${wasteTypeCategory.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${wasteTypeCategory.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${wasteTypeCategory.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${wasteTypeCategory.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
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
</div>
</body>
</html>
