<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="survey.monitoringProgrammeQueryResult.title" /></title>
</head>
<body>
<script type="text/javascript"> 
 jQuery('.recordsPerPage > select').select2();
 </script>
<c:set var="found" value="${!empty result.results}" />

<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <thead>
  	<tr>
      <td colspan="5">
	      <fmt:message key="survey.monitoringProgrammeQueryForm.searchResults" />
      </td>
    </tr>
    <tr>
      <th><fmt:message key="survey.monitoringProgrammeQueryForm.quantity" /></th>
      <th><fmt:message key="survey.monitoringProgrammeQueryForm.measure" /></th>
      <th><fmt:message key="survey.monitoringProgrammeQueryForm.readingPoint" /></th>
      <th><fmt:message key="survey.monitoringProgrammeQueryForm.frequency" /></th>
      <th><fmt:message key="survey.monitoringProgrammeQueryForm.responsibleUser" /></th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td colspan="5">
        <c:if test="${!found}">
          <fmt:message key="search.empty" />
        </c:if>
        <c:if test="${found}">
          <scannell:paging result="${result}" />
        </c:if>
      </td>
    </tr>

    <c:set var="last" value="${null}" />
    <c:forEach items="${result.results}" var="measurement" varStatus="s">
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
          <a href="<c:url value="javascript:showChart('measurementReadingsChart.jpeg"><c:param name="id" value="${measurement.id}" /></c:url>')"><img src="<c:url value="/images/survey/chartLink.giff" />" alt="View Chart" width="14" height="14"></a>
          <a href="<c:url value="readingQueryForm.htm"><c:param name=".quantityId" value="${measurement.quantity.id}" /><c:param name=".measureId" value="${measurement.measure.id}" /><c:param name=".readingPointId" value="${measurement.readingPoint.id}" /><c:param name="hideControls" value="true" /></c:url>"><c:out value="${measurement.readingPoint.name}" /></a>
        </td>
        <td><c:out value="${measurement.frequencyDisplay}" /></td>
        <td><c:out value="${measurement.quantity.responsibleUser.displayName}" /></td>
      </tr>
    <c:set var="last" value="${measurement}" />
    </c:forEach>
     <c:if test="${found}">
    <tr>
      <td colspan="5"><scannell:paging result="${result}" /></td>
    </tr>
    </c:if>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
