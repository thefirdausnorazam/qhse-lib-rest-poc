<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
<!--   	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script> -->
</head>
<body>

<div class="content">

<c:if test="${not empty progressComments}">
<div class="header">
<h3><fmt:message key="action.progress.comment" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive dataTable">
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="comment" /></th>
      <th><fmt:message key="createdBy" /></th>
    </tr>
  </thead>
  <tbody id="questionsTbody">
  <c:forEach items="${progressComments}" var="progressComment" >
    <tr>
       <td><c:out value="${progressComment.id}" /></td>
      <td><c:out value="${progressComment.comment}" /></td>
      <td><c:out value="${progressComment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${progressComment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
  </c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>
</div>               
</body>
</html>
