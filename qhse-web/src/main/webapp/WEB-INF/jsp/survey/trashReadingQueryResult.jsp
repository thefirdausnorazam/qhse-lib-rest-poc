<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="readingQueryResult" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
		} );
	</script>
<div class="header">
<h3><fmt:message key="trashMeasurementReadingsConfirm" /></h3>
<br/>
</div>
<c:set var="found" value="${!empty result.results}" />
<div class="content">
<div class="table-responsive">
<div class="panel">


<table id="trashReadings" class="table table-bordered table-responsive">
  <thead>
   
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="timePeriod" /></th>
      <th><fmt:message key="quantity" /></th>
      <th><fmt:message key="measure" /></th>
      <th><fmt:message key="readingPoint" /></th>
      <th><fmt:message key="readingStatus" /></th>
    </tr>
    </c:if>
  </thead>

  <tbody>
	<c:if test="${!found}">
		<tr>
			<td colspan="4" align="center">
				<fmt:message key="search.noRecords" />
			</td>
		</tr>
	</c:if>
    <c:forEach items="${result.results}" var="reading" varStatus="s">
      <tr>
        <td><a href="<c:url value="readingView.htm"><c:param name="id" value="${reading.id}"/></c:url>" ><c:out value="${reading.id}" /></a></td>
        <td><fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></td>
        <td><c:out value="${reading.type.quantity.longName}" /></td>
        <td><c:out value="${reading.type.measure.measureName}" /></td>
        <td><c:out value="${reading.type.readingPoint.name}" /></td>
        <td><fmt:message key="${reading.status}" /></td>
      </tr>
    </c:forEach>
   <tfoot>
    </tfoot>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
