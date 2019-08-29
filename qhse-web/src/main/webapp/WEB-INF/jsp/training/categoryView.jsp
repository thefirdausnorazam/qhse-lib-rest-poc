<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="printable" content="true">
<title><fmt:message key="maintenanceCategoryView.training" /></title>
</head>
<body>

<table class="viewForm">
    <col class="label" />
<tbody>
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td><c:out value="${category.id}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="name" />:</td>
    <td><scannell:text value="${category.name}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${category.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${category.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <c:if test="${category.lastUpdatedByUser != null}">
  <tr>
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td>
      <c:out value="${category.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${category.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
</tbody>
<tfoot>
  <tr>
    <td colspan="2">
       <c:if test="${canConfigure}">
        <a href="<c:url value="categoryEdit.htm"><c:param name="showId" value="${category.id}" /></c:url>">
          <fmt:message key="maintenanceCategoryEdit" /></a>
       </c:if>
       <a href="<c:url value="/training/categoryList.htm" ><c:param name="type" value="training" /></c:url>"><fmt:message key="maintenanceCategoryList.${category.type.name}" /></a>
    </td>
  </tr>
</tfoot>
</table>

</body>
</html>
