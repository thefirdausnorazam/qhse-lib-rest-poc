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
			initSortTablesForClass('dataTableAck');
		} );
	</script>
	<div class="content">	
			
		<!--  My Documents due for Acknowledgment -->
		<c:set var="found" value="${!empty ackDocuments.results}" />
		<div class="header">
			<h3>
				<fmt:message key="doccontrol.ackDocuments" />
			</h3>
		</div>
		<div class="content">
			<div class="table table-bordered table-responsive">
				<div class="panel">	
				    <c:if test="${found}">
				         <div class="div-for-pagination"><scannell:paging result="${ackDocuments}" /></div>
				    </c:if>
					<table class="table table-bordered table-responsive dataTableAck">
						<thead>							
								<tr>
									<th><fmt:message key="id" /></th>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="description" /></th>
									<th><fmt:message key="department" /></th>
									<th><fmt:message key="doccontrol.distributedDate" /></th>
								</tr>							
						</thead>
						<tbody>
						<c:forEach items="${ackDocuments.results}" var="ackDoc" varStatus="s">
							<tr>
								<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${ackDoc.id}"/></c:url>" ><c:out value="${ackDoc.id}" /></a></td>
								<td><c:out value="${ackDoc.name}" /></td>
								<td><scannell:text value="${ackDoc.description} " /></td>
								<td>
								     <c:forEach var="dept" items="${ackDoc.departments}" varStatus="loop">
									      <c:out value="${dept.name}" /><c:if test="${!loop.last}">,</c:if>
									  </c:forEach>
						        </td>		
								<td><fmt:formatDate value="${ackDoc.distributionList.createdTs}" pattern="dd-MMM-yyyy" /></td>
							</tr>
						</c:forEach>
						<tfoot> 
						    <c:if test="${found}">
							    <tr>
							      <td colspan="5"><scannell:paging result="${ackDocuments}" /></td>
							    </tr>
						    </c:if>
					    </tfoot>
					</tbody>
				</table>
				</div>
			</div>
		</div>
			
	</div>
</body>
</html>
