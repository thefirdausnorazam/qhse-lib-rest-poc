<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="changeQueryResult" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
<c:set var="found" value="${!empty result.results}" />
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >8</c:when> 
	  <c:otherwise>7</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3><fmt:message key="changeAssessmentQueryResult.searchResults" /></h3>
</div>
<div class="content">  
	<div class="table-responsive">
	        <c:if test="${found}">
          	<div class="div-for-pagination" ><scannell:paging result="${result}" /></div>
        </c:if>
		<div class="panel" > 
			<table class="table table-bordered table-responsive dataTable">
				<thead>
					<tr>
						<th><fmt:message key="id" /></th>
						<th><fmt:message key="name" /></th>
						<th><fmt:message key="changeProgramme" /></th>
						<th><fmt:message key="status" /></th>
						<th><fmt:message key="changeAssessment.initiator" /></th>
						<th><fmt:message key="changeAssessment.owner" /></th>
						<th><fmt:message key="percentCompleted" /></th>		
		  				<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
					</tr>
				</thead>
				<tbody>
			
					<c:forEach items="${result.results}" var="change" varStatus="s">
						<c:choose>
							<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
							<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
						</c:choose>
						<tr class="<c:out value="${style}" />">
							<td><a href="<c:url value="changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url>" ><c:out value="${change.id}" /></a></td>
							<td width="20%"><c:out value="${change.name}" /></td>
							<td><c:out value="${change.programme.description} " /></td>
							<td><fmt:message key="changeAssessment${change.status}" /></td>
							<td><c:out value="${change.initiator.displayName}" /></td>		
							<td><c:out value="${change.owner.displayName}" /></td>		
							<td width="5%"><c:out value="${change.percentCompleted}%"/></td>
							<c:if test="${showSiteColumn}"><td><c:out value="${change.site}" /></td></c:if>	
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
