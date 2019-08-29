<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<style type="text/css" media="all">
		@import "<c:url value='/css/doccontrol.css'/>";
	</style>
<meta name="printable" content="true">
<title></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
	<div class="content">
		<c:set var="found" value="${!empty distributedDocuments.results}" />
		<div class="header">
			<h3>
				<fmt:message key="doccontrol.distributedDocuments" />
			</h3>
		</div>
		<div class="content">
			<div class="table table-bordered table-responsive">
				<div class="panel">
					<c:if test="${found}">
				         <div class="div-for-pagination"><scannell:paging result="${distributedDocuments}" /></div>
				    </c:if>
					<table class="table table-bordered table-responsive dataTable">
						<thead>
						<c:if test="${found}">
							<tr>
								<th><fmt:message key="id" /></th>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="description" /></th>
								<th><fmt:message key="department" /></th>
								<th><fmt:message key="doccontrol.distributedDate" /></th>
							</tr>
						</c:if>
						</thead>
						<tbody>
						<c:forEach items="${distributedDocuments.results}" var="distributedDoc" varStatus="s">
							<tr class="<c:out value="${style}" />">
								<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${distributedDoc.id}"/></c:url>" ><c:out value="${distributedDoc.id}" /></a></td>
								<td><c:out value="${distributedDoc.name}" /></td>
								<td><scannell:text value="${distributedDoc.description} " /></td>
								<td>
								      <c:forEach var="dept" items="${distributedDoc.departments}" varStatus="loop">
									  	<c:out value="${dept.name}" /><c:if test="${!loop.last}">,</c:if>
									  </c:forEach>
								</td>		
								<td><fmt:formatDate value="${distributedDoc.distributionList.createdTs}" pattern="dd-MMM-yyyy" /></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot> 
					    <c:if test="${found}">
						    <tr>
						      <td colspan="5"><scannell:paging result="${distributedDocuments}" /></td>
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
