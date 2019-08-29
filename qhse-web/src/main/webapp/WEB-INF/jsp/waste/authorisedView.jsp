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
<h2><fmt:message key="${authorisedType}View" /></h2>
</div>
<div class="content">

<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
  <col >
  <thead>
    <tr>
      <td colspan="2">
        <fmt:message key="${authorisedType}" />
      </td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td ><fmt:message key="id" />:</td>
      <td><c:out value="${authorised.id}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="name" />:</td>
      <td><c:out value="${authorised.name}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="address" />:</td>
      <td><scannell:text value="${authorised.address}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="phoneNumber" />:</td>
      <td><c:out value="${authorised.phoneNumber}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="emailAddress" />:</td>
      <td><c:out value="${authorised.emailAddress}" /></td>
    </tr>
   
    <c:if test="${authorisedType == 'consignee'}">
    
    <tr>
      <td ><fmt:message key="disposalLocation" />:</td>
      <td><scannell:text value="${authorised.disposalLocation}" /></td>
    </tr>
    <tr>
      <td ><fmt:message key="treatmentTypes" />:</td>
      <td>
        <c:forEach items="${authorised.treatmentTypes}" var="treatmentType">
          <c:out value="${treatmentType}" /><br />
        </c:forEach>
      </td>
    </tr>
      
    </c:if>
    
    <tr>
      <td ><fmt:message key="createdBy" />:</td>
      <td><c:out value="${authorised.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${authorised.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
    <c:if test="${authorised.lastUpdatedByUser != null}">
    <tr>
      <td ><fmt:message key="lastUpdatedBy" />:</td>
      <td>
        <c:out value="${authorised.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${authorised.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
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

<div class="content">
<div class="table-responsive">
<div class="header">
<h3><fmt:message key="wasteCodeAuthorisations" /></h3>
</div>
<table class="table table-bordered table-responsive">
  <thead>
   
    <tr>
      <th><fmt:message key="referenceNo" /></th>
      <th><fmt:message key="startDate" /></th>
      <th><fmt:message key="endDate" /></th>
      <th><fmt:message key="notes" /></th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${authorised.authorisations}" var="authorisation" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="authorisationView.htm"><c:param name="id" value="${authorisation.id}" /></c:url>"><c:out value="${authorisation.referenceNo}" /></a></td>
        <td><fmt:formatDate value="${authorisation.startDate}" pattern="dd-MMM-yyyy" /></td>
        <td><fmt:formatDate value="${authorisation.endDate}" pattern="dd-MMM-yyyy" /></td>
        <td><scannell:text value="${authorisation.notes}" /></td>
      </tr>
    </c:forEach>
   </tbody>
</table>
</div>
</div>

</body>
</html>
