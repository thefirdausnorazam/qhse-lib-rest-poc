<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="printable" content="true">
<title><fmt:message key="maintenanceCategoryList.training" /></title>
</head>
<body>

<table class="viewForm bordered">
  <thead>
    <tr>
      <td><fmt:message key="MaintenanceType[training]" /></td>
    </tr>
    <tr>
      <th><fmt:message key="name" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${categories}" var="category" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />" >
        <td style="width: 300px;">
          <a href="<c:url value="categoryView.htm"><c:param name="id" value="${category.id}"/></c:url>" >
            <c:out value="${category.name}" /></a>
        </td>
      </tr>
    </c:forEach>
 
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
        <c:if test="${canConfigure}">
          <a href="<c:url value="categoryEdit.htm" ><c:param name="type" value="training" /></c:url>" >
            <fmt:message key="add" />
        </c:if>
      </td>
    </tr>
  </tfoot>
  
</table>

</body>
</html>
