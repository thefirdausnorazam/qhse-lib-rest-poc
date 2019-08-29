<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="wasteConsignmentItemQueryResult" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
 </script>
	<c:set var="colspan">
		<c:choose> 
		  <c:when test="${showSiteColumn}" >9</c:when> 
		  <c:otherwise>8</c:otherwise> 
		</c:choose> 
	</c:set>
 <div class="header">
<h3><fmt:message key="wasteConsignmentItemQueryForm" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />
<div class="content">
<div class="table-responsive">
<div class="panel">
<div class="table-responsive">
        <c:if test="${found}">
          <div class="div-for-pagination" ><scannell:paging result="${result}" /></div>
        </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
      <tr>
        <th><fmt:message key="type" /></th>
        <th><fmt:message key="shipmentNo" /></th>
        <th><fmt:message key="carrier" /></th>
        <th><fmt:message key="broker" /></th>
        <th><fmt:message key="consignee" /></th>
        <th><fmt:message key="shippedDate" /></th>
        <th><fmt:message key="estimatedWeight" /></th>
        <th><fmt:message key="containerQuantity" /></th>
	  	<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
      </tr>
  </thead>

  <tbody>
    <c:forEach items="${result.results}" var="wasteConsignmentItem" varStatus="s">
      <tr>
        <td>
          <a href="<c:url value="wasteConsignmentItemView.htm"><c:param name="id" value="${wasteConsignmentItem.id}"/></c:url>">
            <c:out value="${wasteConsignmentItem.type.description}" />
          </a>
        </td>
        <td><spring:message code="${wasteConsignmentItem.consignment.shipmentDocumentType}" text="" /> - <c:out value="${wasteConsignmentItem.consignment.shipmentNo}" /></td>
        <td><c:out value="${wasteConsignmentItem.consignment.carrier.name}" /></td>
        <td><c:out value="${wasteConsignmentItem.consignment.broker.name}" /></td>
        <td><c:out value="${wasteConsignmentItem.consignment.consignee.name}" /></td>
        <td><fmt:formatDate value="${wasteConsignmentItem.consignment.shippedDate}" pattern="dd-MMM-yyyy" /></td>
        <td><c:out value="${wasteConsignmentItem.estimatedWeightDescription}" /></td>
        <td><c:out value="${wasteConsignmentItem.containerQuantity}" /></td>
		<c:if test="${showSiteColumn}"><td><c:out value="${wasteConsignmentItem.site}" /></td></c:if>
      </tr>
    </c:forEach>
    <c:if test="${found}">
    	<tfoot>
		    <c:if test="${runningTotal != null}">
			   	<tr>
			   	  <td colspan="${showSiteColumn ? colspan-3 : colspan-2}"><fmt:message key="runningTotal" />:</td>
			      <td><c:out value="${runningTotal}" /></td>
				  <td></td>
				  <c:if test="${showSiteColumn}"><td></td></c:if>
			   	</tr>
	    	</c:if>
		      <tr>
		        <td colspan="${colspan}"><scannell:paging result="${result}" /></td>
		      </tr>
      </tfoot>
    </c:if>
  </tbody>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
