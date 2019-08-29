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
		loadCheckedObjects();
		 function loadCheckedObjects() {
			 if(jQuery('#measurementIds').val().length > 0) {
				 var arrayIds = jQuery.trim(jQuery('#measurementIds').val()).split('-');
				 for(var i = 0; i < arrayIds.length; i++){
					 jQuery('#'+arrayIds[i]).prop('checked', true);
				 }
			 }
		 }
	</script>
<div class="header">
<h3><fmt:message key="measurementQueryForm" /></h3>
</div>
<c:set var="found" value="${!empty measurements}" />
<div class="content"> 
<div class="table-responsive">
   	<c:if test="${!found}">
          <fmt:message key="search.empty" />
    </c:if>
    <c:if test="${found}">
          <scannell:paging result="${result}" />
    </c:if>
<table class="table table-bordered table-responsive">
  <thead>
    
    <c:if test="${found}">
    <tr>
    	<th></th>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="quantity" /></th>
      <th><fmt:message key="measure" /></th>
      <th><fmt:message key="readingPoint" /></th>
      <th><fmt:message key="frequency" /></th>
      <%--th><fmt:message key="survey.measurementQueryResult.dueDate" /></th--%>
      <th><fmt:message key="active" /></th>
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
      	<td><input type="checkbox" value="${measurement.id}" id="${measurement.id}" onclick="setMeasurementIds(this);"></td>
        <td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>" ><c:out value="${measurement.id}" /></a></td>
        <td><c:out value="${measurement.quantity.longName}" /></td>
        <td><c:out value="${measurement.measure.measureName}" /></td>
        <td><c:out value="${measurement.readingPoint.name}" /></td>
        <td><c:out value="${measurement.frequencyDisplay}" /></td>
        <%--td><fmt:formatDate value="${measurement.dueDate}" pattern="dd-MMM-yyyy" /></td--%>
        <td><fmt:message key="${measurement.active}" /></td>
      </tr>
    </c:forEach>
    <c:if test="${found}">
    <tr>
      <td colspan="7"> 
        <scannell:paging result="${measurements}" />
      </td>
    </tr>
    </c:if>
  </tbody>
</table>
</div>
</div>
</body>
</html>
