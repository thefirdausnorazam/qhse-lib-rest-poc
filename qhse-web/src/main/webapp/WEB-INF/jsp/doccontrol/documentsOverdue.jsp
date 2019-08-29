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
			initSortTablesForClass('dataTableOverdue');
		} );
	</script>
	<div class="content">
		
		<!--  My Documents that are Overdue -->
		<c:set var="found" value="${!empty approveOverdueDocuments.results}" />
		<div class="header">
			<h3>
				<fmt:message key="doccontrol.overdueDocuments" />
			</h3>
		</div>	
		<div class="content">
			<div class="table-responsive">
				<div class="panel">		
				    <c:if test="${found}">
				         <div class="div-for-pagination"><scannell:paging result="${approveOverdueDocuments}" /></div>
				    </c:if>
					<table class="table table-bordered table-responsive dataTableOverdue">
						<thead>							
								<tr>
									<th><fmt:message key="id" /></th>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="description" /></th>
									<th><fmt:message key="department" /></th>
									<th><fmt:message key="status" /></th>
									<th><fmt:message key="doccontrol.targetReview" /></th>
								</tr>		
						</thead>
						<tbody>

							<c:forEach items="${approveOverdueDocuments.results}" var="approveDoc" varStatus="s">
								<tr>
									<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${approveDoc.id}"/></c:url>" ><c:out value="${approveDoc.id}" /></a></td>
									<td><c:out value="${approveDoc.name}" /></td>
									<td><scannell:text value="${approveDoc.description}" /></td>
									<td>
									      <c:forEach var="dept" items="${approveDoc.departments}" varStatus="loop">
									        	<c:out value="${dept.name}" /><c:if test="${!loop.last}">,</c:if>
									      </c:forEach>
								    </td>
									<td><fmt:message key="${approveDoc.status}" /></td>
									<td>
										<c:if test="${approveDoc.approvedDate != null}">
											<fmt:formatDate value="${approveDoc.targetReviewDate}" pattern="dd-MMM-yyyy" />
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot> 
						    <c:if test="${found}">
							    <tr>
							      <td colspan="6"><scannell:paging result="${approveOverdueDocuments}" /></td>
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
