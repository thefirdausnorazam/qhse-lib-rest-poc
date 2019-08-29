<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTablesForClass('dataTableC');
			jQuery('.recordsPerPage').find("select").select2();
		} );
	</script>
<body>
<c:set var="taskLabel"><fmt:message key="task"/></c:set>
<div class="content"> 
<div class="panel">
    <c:if test="${!empty result.results}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>    
	    <table class="table table-bordered table-responsive dataTableC" >
			  <thead>
			    <tr>
			      <th><fmt:message key="id"/></th>
			      <th style="width:50%"><fmt:message key="description"/></th>
			      <th style="width:15%"><fmt:message key="responsibleUser"/></th>
			      <th style="width:15%"><fmt:message key="targetDate"/></th>
			      <th style="width:15%"><fmt:message key="site"/></th>
			    </tr>  
			  </thead>
			  <tbody>
		     
			    <c:forEach items="${result.results}" var="task" varStatus="s">
			        <tr>
			          <td><a 
			              	onclick='changeSiteOfType("<c:url value="viewTask.htm"><c:param name="id" value="${task.id}"/></c:url>", ${task.site.id}, "${task.site}", ${currentSite}, "${taskLabel}")' 
			              	href="#">
							<c:out value="${task.id}" /></a></td>
			          <td><div><c:out value="${task.description}" /></div></td>
			          <td><c:out value="${task.responsibleUser.displayName}" /></td>
			          <td><fmt:formatDate value="${task.targetDate}" pattern="dd-MMM-yyyy" /></td>
			          <td><c:out value="${task.site.name}" /></td>
			        </tr>
			    </c:forEach>
		  </tbody>  
		</table>
   
</div>
</div>

</body>
</html>