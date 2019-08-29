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
		  <c:when test="${showSiteColumn}" >9</c:when> 
		  <c:otherwise>8</c:otherwise> 
		</c:choose> 
	</c:set>
<div class="header">
<h3> <fmt:message key="searchResults" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<c:set var="found" value="${!empty result.results}" />
    <c:if test="${found}">
          <scannell:paging result="${result}" />
    </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="training.category" /></th>
      <th><fmt:message key="training.receiver" /></th>
      <th><fmt:message key="training.responsible" /></th>
      <th><fmt:message key="training.receiversDepartment" /></th>
      <th><fmt:message key="training.dueDate" /></th>
      <th><fmt:message key="training.lastDate" /></th>
      <th><fmt:message key="training.replacementFrequency" /></th>
	  <c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
    </tr>
    </c:if>
  </thead>
  <tbody>
	    <c:forEach items="${result.results}" var="subject" varStatus="s">
	      <c:choose>
	        <c:when test="${s.index mod 2 == 0}">
	          <c:set var="style" value="even" />
	        </c:when>
	        <c:otherwise>
	          <c:set var="style" value="odd" />
	        </c:otherwise>
	      </c:choose>
	      <tr class="<c:out value="${style}" />">
	        <td><a href="<c:url value="recordView.htm"><c:param name="id" value="${subject.id}"/></c:url>" ><c:out value="${subject.id}" /></a></td>
	        <td><c:out value="${subject.category.name}" /></td>
	        <td><c:out value="${subject.receiver.displayName}" /></td>
	        <td><c:out value="${subject.responsible.displayName}" /></td>
	        <td><c:out value="${subject.receiversDepartment.name}" /></td>
	        <td><fmt:formatDate value="${subject.dueDate}" pattern="dd-MMM-yyyy" /></td>
	        <td><fmt:formatDate value="${subject.lastDate}" pattern="dd-MMM-yyyy" /></td>
	        <td><c:out value="${subject.intervalAmount}" /> <fmt:message key="${subject.intervalType}" /></td>
			<c:if test="${showSiteColumn}"><td><c:out value="${subject.site}" /></td></c:if>
	      </tr>
	    </c:forEach>
	    <tfoot>
		    <c:if test="${found}">
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
