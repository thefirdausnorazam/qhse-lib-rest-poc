<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="wasteConsignmentQueryResult" /></title>
</head>
<body>
<div class="header">
<h3><fmt:message key="wasteConsignmentQueryForm" /></h3>
</div>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
	<c:set var="colspan">
		<c:choose> 
		  <c:when test="${showSiteColumn}" >11</c:when> 
		  <c:otherwise>10</c:otherwise> 
		</c:choose> 
	</c:set>
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
        <th><fmt:message key="shipmentNo" /></th>
        <th><fmt:message key="carrier" /></th>
        <th><fmt:message key="broker" /></th>
        <th><fmt:message key="consignee" /></th>
        <th><fmt:message key="shippingCompleted" /></th>
        <th><fmt:message key="shippedDate" /></th>
        <th><fmt:message key="reconcilliationCompleted" /></th>
        <th><fmt:message key="active" /></th>
        <th><fmt:message key="createdBy" /></th>
	  	<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
      </tr>
  </thead>

  <tbody>
	   <c:forEach items="${result.results}" var="wasteConsignment" varStatus="s">
	      <c:choose>
	        <c:when test="${s.index mod 2 == 0}">
	          <c:set var="style" value="even" />
	        </c:when>
	        <c:otherwise>
	          <c:set var="style" value="odd" />
	        </c:otherwise>
	      </c:choose>
	      <tr class="<c:out value="${style}" />">
	        <td><a
	          href="<c:url value="wasteConsignmentView.htm"><c:param name="id" value="${wasteConsignment.id}"/></c:url>"><c:out
	          value="${wasteConsignment.id}" /></a></td>
	        <td><spring:message code="${wasteConsignment.shipmentDocumentType}" text="" /> - <c:out value="${wasteConsignment.shipmentNo}" /></td>
	        <td><c:out value="${wasteConsignment.carrier.name}" /></td>
	        <td><c:out value="${wasteConsignment.broker.name}" /></td>
	        <td><c:out value="${wasteConsignment.consignee.name}" /></td>
	        <td><fmt:message key="${wasteConsignment.shippingCompleted}" /></td>
	        <td><fmt:formatDate value="${wasteConsignment.shippedDate}" pattern="dd-MMM-yyyy" /></td>
	        <td><fmt:message key="${wasteConsignment.reconcilliationCompleted}" /></td>
	        <td><fmt:message key="${wasteConsignment.active}" /></td>
	        <td><c:out value="${wasteConsignment.createdByUser.displayName}" /></td>
			<c:if test="${showSiteColumn}"><td><c:out value="${wasteConsignment.site}" /></td></c:if>
	      </tr>
	    </c:forEach>
	    <tfoot>
		    <c:if test="${found}">
			      <tr>
			        	<td colspan="${colspan}"><scannell:paging result="${result}" /></td>
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
