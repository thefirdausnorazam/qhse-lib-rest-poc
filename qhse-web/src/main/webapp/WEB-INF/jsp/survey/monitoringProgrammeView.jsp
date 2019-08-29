<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title>
</title>
</head>
<body>
<div class="header">
<h2>
<c:if test="${type != null}"><fmt:message key="${type}" /></c:if>
<fmt:message key="monitoringProgrammeView" />
</h2>
</div>
<c:if test="${types != null}">
  <c:if test="${type != null}">
    <a href="<c:url value="monitoringProgrammeView.htm" />" ><fmt:message key="view" /> <fmt:message key="all" /></a>
  </c:if>
  <c:forEach items="${types}" var="item">
    <c:if test="${item != type}">
      <a href="<c:url value="monitoringProgrammeView.htm"><c:param name="type" value="${item.name}" /></c:url>" ><fmt:message key="view" /> <fmt:message key="${item}" /></a>
    </c:if>
  </c:forEach>
</c:if>

<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <thead>
    <tr>
      <th><fmt:message key="quantity" /></th>
      <th><fmt:message key="measure" /></th>
      <th><fmt:message key="readingPoint" /></th>
      <th><fmt:message key="frequency" /></th>
      <th><fmt:message key="responsibleUser" /></th>
    </tr>
  </thead>

  <tbody>
    <c:set var="last" value="${null}" />
    <c:forEach items="${measurements}" var="measurement" varStatus="s">
      <c:if test="${measurement.quantity.category != last.quantity.category}">
        <tr>
          <th colspan="5" style="text-align: left;"><c:out value="${measurement.quantity.category.name}" /></th>
        </tr>
      </c:if>

      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>" ><c:out value="${measurement.quantity.name}" /></a></td>
        <td>
          <a href="<c:url value="readingQueryForm.htm"><c:param name=".quantityId" value="${measurement.quantity.id}" /><c:param name=".measureId" value="${measurement.measure.id}" /><c:param name="hideControls" value="true" /></c:url>"><c:out value="${measurement.measure.measureName}" /></a>
        </td>
        <td>
          <a href="<c:url value="measurementReadingsChart.htm"><c:param name="id" value="${measurement.id}" /></c:url>')"><img src="<c:url value="/images/survey/chartLink.giff" />" alt="View Chart" width="14" height="14"></a>
          <a href="<c:url value="readingQueryForm.htm"><c:param name=".quantityId" value="${measurement.quantity.id}" /><c:param name=".measureId" value="${measurement.measure.id}" /><c:param name=".readingPointId" value="${measurement.readingPoint.id}" /><c:param name="hideControls" value="true" /></c:url>"><c:out value="${measurement.readingPoint.name}" /></a>
        </td>
        <td><fmt:message key="${measurement.frequency}" /></td>
        <td><c:out value="${measurement.quantity.responsibleUser.displayName}" /></td>
      </tr>
    <c:set var="last" value="${measurement}" />
    </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
