<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
<div class="content"> 
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="reviewQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-responsive table-bordered dataTable">
  <thead>    
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="review.comment" /></th>
      <th><fmt:message key="review.date" /></th>
      <th><fmt:message key="createdBy" /></th>
    </tr>
    </c:if>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="review" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><c:out value="${review.id}" /></td>
        <td><scannell:text value="${review.comment}" /></td>
        <td><fmt:formatDate value="${review.date}" pattern="dd-MMM-yyyy" /></td>
        <td><c:out value="${review.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm" /></td>
      </tr>
    </c:forEach>
    
  </tbody>
  <tfoot>
	    <c:if test="${found}">
	    <tr>
	      <td colspan="4"><scannell:paging result="${result}" /></td>
	    </tr>
	    </c:if>
	</tfoot>
</table>
</div>
</div>
</div>

</div>
</body>
</html>
