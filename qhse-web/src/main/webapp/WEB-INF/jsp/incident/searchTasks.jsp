<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/incident/viewTask.htm?id=${result.results[0].id}';
		}
	}
</script>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >8</c:when> 
	  <c:otherwise>7</c:otherwise> 
	</c:choose> 
</c:set>
<c:if test="${showLegacyId}"><c:set var="colspan" value="${colspan + 1}" /></c:if>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="tasks" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
        <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
        </c:if>
<table id="datatable" class="table table-bordered table-responsive dataTable">
  <thead>   
    <tr>
            <th><fmt:message key="id" /></th>
            <th><fmt:message key="description" /></th>
            <th><fmt:message key="status" /></th>
            <th><fmt:message key="department" /></th>
            <th><fmt:message key="responsibleUser" /></th>
            <th><fmt:message key="completedTime" /></th>
            <th><fmt:message key="createdBy" /></th>
      		<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
      		<c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${result.results}" var="task" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
              <td><a href="<c:url value="viewTask.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="${task.id}" /></a></td>
              <td><c:out value="${task.description}" /></td>
              <td>
        		<c:choose>
    				<c:when test="${task.trash}"><fmt:message key="trash" /></c:when>
    				<c:otherwise> <fmt:message key="${task.statusCode}" /></c:otherwise>
   		 		</c:choose>
       		 </td>
              <td><c:out value="${task.responsibleDepartment.name}" /></td>
              <td><c:out value="${task.responsibleUser.displayName}" /></td>
              <td><fmt:formatDate value="${task.completedTime}" pattern="dd-MMM-yyyy" /></td>
              <td><c:out value="${task.createdByUser.displayName}" /></td>
              <c:if test="${showSiteColumn}">
        		<td><c:out value="${task.site.name}" /></td>
        	  </c:if>
        	  <c:if test="${showLegacyId}">
       			<td> <c:out value="${task.legacyId}" /> </td>
     		  </c:if>
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
