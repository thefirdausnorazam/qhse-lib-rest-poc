<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthTestTypeList.title" /></title>
</head>
<body>

<c:set var="found" value="${!empty testTypeList}" />

<table class="viewForm">
  <col class="label" />
  <thead>
    <tr><td><fmt:message key="healthTestTypeList.msg" /></td></tr>
  </thead>

  <tbody>
  <c:if test="${!found}">
    <tr><td><fmt:message key="search.empty" /></td></tr>
  </c:if>
  <c:forEach items="${testTypeList}" var="testType" varStatus="s">
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
		<li><a href="<c:url value="/health/testAdd.htm"><c:param name="testType" value="${testType}" /><c:param name="recordId" value="${param.recordId}" /></c:url>"><fmt:message key="${testType}" /></a></li>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>
