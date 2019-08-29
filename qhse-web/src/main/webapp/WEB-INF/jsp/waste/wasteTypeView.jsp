<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>

<div class="content">
<div class="header">
<h3><fmt:message key="wasteType" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
  <col >
  
  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${wasteType.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="category" />:</td>
      <td><c:out value="${wasteType.category.name}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="name" />:</td>
      <td><c:out value="${wasteType.name}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="additionalInfo" />:</td>
      <td><scannell:text value="${wasteType.additionalInfo}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="wasteTypeCode" />:</td>
      <td>
        <div><c:out value="${wasteType.code.superCode.superCode}" /></div>
        <div><c:out value="${wasteType.code.superCode}" /></div>
        <div><c:out value="${wasteType.code}" /></div>
      </td>
    </tr>
    <tr>
      <td ><fmt:message key="hazardous" />:</td>
      <td><fmt:message key="${wasteType.hazardous}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="hazardCodes" />:</td>
      <td>
        <c:forEach items="${wasteType.hazardCodes}" var="code">
          <div><c:out value="${code.name}" /></div>
        </c:forEach>
      </td>
    </tr>
    <tr>
      <td ><fmt:message key="physicalCharacteristic" />:</td>
      <td><fmt:message key="${wasteType.physicalCharacteristic}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="active" />:</td>
      <td><fmt:message key="${wasteType.active}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="convertToWeightExpression" />:</td>
      <td><c:out value="${wasteType.customUnit.convertToBaseFunction.expression}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${wasteType.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${wasteType.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${wasteType.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${wasteType.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${wasteType.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
      </td>
    </tr>
    </c:if>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2">
      	<common:bindURL editable="${urls != null}" name="wasteType" site="${wasteType.site.name}">
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
