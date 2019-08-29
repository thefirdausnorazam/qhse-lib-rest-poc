<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthTestQueryResult.title" /></title>
</head>
<body>
<c:set var="found" value="${!empty result.results}" />
<table class="viewForm bordered">
  <thead>
    <tr>
      <td colspan="6" id="healthTestQueryResult.title"><fmt:message key="healthTestQueryResult.searchResults" /></td>
    </tr>
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="healthTestType" /></th>
      <th><fmt:message key="healthRecord.person" /></th>
      <th><fmt:message key="healthRecord.department" /></th>
      <th><fmt:message key="healthRecord.seg" /></th>
      <th><fmt:message key="healthTest.testDate" /></th>
      <th><fmt:message key="healthTest.retestDate" /></th>
    </tr>
    </c:if>
  </thead>

  <tbody>
    <tr>
      <td colspan="6">
        <c:if test="${!found}">
          <fmt:message key="search.empty" />
        </c:if>
        <c:if test="${found}">
          <scannell:paging result="${result}" />
        </c:if>
      </td>
    </tr>

    <c:forEach items="${result.results}" var="test" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="/health/testView.htm"><c:param name="id" value="${test.id}"/></c:url>" ><fmt:message key="${test['class'].simpleName}" /></a></td>
        <td><a href="<c:url value="/health/recordView.htm"><c:param name="id" value="${test.record.id}"/></c:url>" ><scannell:text value="${test.record.person.displayName}" /></a></td>
        <td><scannell:text value="${test.record.department.name}" /></td>
        <td><scannell:text value="${test.record.seg}" /></td>
        <td><fmt:formatDate value="${test.testDate}" pattern="dd-MMM-yyyy" /></td>
        <td><fmt:formatDate value="${test.retestDate}" pattern="dd-MMM-yyyy" /></td>
      </tr>
    </c:forEach>
    <c:if test="${found}">
    <tr>
      <td colspan="6"><scannell:paging result="${result}" /></td>
    </tr>
    </c:if>
  </tbody>
</table>

</body>
</html>
