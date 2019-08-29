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
			initSortTables();
		} );
	</script>
	<c:set var="colspan">
		<c:choose> 
		  <c:when test="${showSiteColumn}" >8</c:when> 
		  <c:otherwise>7</c:otherwise> 
		</c:choose> 
	</c:set>
<div class="header">
<h3><fmt:message key="readings" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
   
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="timePeriod" /></th>
      <th><fmt:message key="quantity" /></th>
      <th><fmt:message key="measure" /></th>
      <th><fmt:message key="readingPoint" /></th>
      <th><fmt:message key="readingStatus" /></th>
      <th><fmt:message key="value" /></th>
	  <c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
    </tr>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="reading" varStatus="s">
      <%-- <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose> --%>
      <tr>
        <td><a href="<c:url value="readingView.htm"><c:param name="id" value="${reading.id}"/></c:url>" ><c:out value="${reading.id}" /></a></td>
        <td><fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></td>
        <td><c:out value="${reading.type.quantity.longName}" /></td>
        <td><c:out value="${reading.type.measure.measureName}" /></td>
        <td><c:out value="${reading.type.readingPoint.name}" /></td>
        <td><fmt:message key="${reading.status}" /></td>
        <td><spring:message code="${reading.customUnitValueOfUnitSelected}" text="${reading.customUnitValueOfUnitSelected}" /></td>
        <c:if test="${showSiteColumn}"><td><c:out value="${reading.site}" /></td></c:if>
      </tr>
    </c:forEach>
   <tfoot>
	  <c:if test="${found}">
	   
	   	<tr>
	   	  <td colspan="${colspan-1}"><fmt:message key="runningTotal" />:</td>
	      <td style="white-space: nowrap;"><c:out value="${runningTotal}" /></td>
	   	</tr>
	    <tr>
	      <td colspan="${colspan}">
	        <scannell:paging result="${result}" />
	      </td>
	    </tr>
	    </c:if>
    </tfoot>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
