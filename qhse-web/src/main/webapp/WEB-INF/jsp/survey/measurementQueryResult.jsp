<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="measurementQueryResult" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
	<c:set var="colspan">
		<c:choose> 
		  <c:when test="${showSiteColumn}" >7</c:when> 
		  <c:otherwise>6</c:otherwise> 
		</c:choose> 
	</c:set>
<div class="header">
<h3><fmt:message key="measurementQueryForm" /></h3>
</div>
<c:set var="found" value="${!empty measurements}" />
<div class="content"> 
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${measurements}" /></div>
    </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
    <c:if test="${found}">
	    <tr>
	      <th><fmt:message key="id" /></th>
	      <th><fmt:message key="quantity" /></th>
	      <th><fmt:message key="measure" /></th>
	      <th><fmt:message key="readingPoint" /></th>
	      <th><fmt:message key="frequency" /></th>
	      <%--th><fmt:message key="survey.measurementQueryResult.dueDate" /></th--%>
	      <th><fmt:message key="active" /></th>
		  <c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
	    </tr>
	    </c:if>
  </thead>

  <tbody>
    <c:forEach items="${measurements.results}" var="measurement" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>" ><c:out value="${measurement.id}" /></a></td>
        <td><c:out value="${measurement.quantity.longName}" /></td>
        <td><c:out value="${measurement.measure.measureName}" /></td>
        <td><c:out value="${measurement.readingPoint.name}" />-<c:out value="${measurement.readingPoint.location}" /></td>
        <td><c:out value="${measurement.frequencyDisplay}" /></td>
        <%--td><fmt:formatDate value="${measurement.dueDate}" pattern="dd-MMM-yyyy" /></td--%>
        <td><fmt:message key="${measurement.active}" /></td>
        <c:if test="${showSiteColumn}"><td><c:out value="${measurement.site}" /></td></c:if>
      </tr>
    </c:forEach>
    <tfoot>
	    <c:if test="${found}">
		    <tr>
		      <td colspan="${colspan}"> 
		        <scannell:paging result="${measurements}" />
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
