<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="wasteConsignmentItemView" />HH</h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <col >

  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${consignmentItem.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="type" />:</td>
      <td><c:out value="${consignmentItem.type.description}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="estimatedWeight" />:</td>
      <td><c:out value="${consignmentItem.estimatedWeightDescription}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="containerQuantity" />:</td>
      <td><c:out value="${consignmentItem.containerQuantity}" /></td>
    </tr>
    
    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${consignmentItem.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${consignmentItem.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${consignmentItem.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${consignmentItem.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${consignmentItem.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
      </td>
    </tr>
    </c:if>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2">
      	<common:bindURL editable="${urls != null}" name="wasteConsignmentItem" site="${consignmentItem.site.name}">
        	<scannell:url urls="${urls}" />
        </common:bindURL>
      </td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
