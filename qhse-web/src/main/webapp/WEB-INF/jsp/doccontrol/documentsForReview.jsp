<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTablesForClass('dataTableReview');
		} );
	</script>
	<div class="content">
		<!--  My Documents to Review -->
		<c:set var="found" value="${!empty reviewDocuments.results}" />
		<a name="reviewDocuments"></a>
		<div class="header">
			<h3>
				<fmt:message key="doccontrol.reviewDocuments" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">				
				    <c:if test="${found}">
				         <div class="div-for-pagination"><scannell:paging result="${reviewDocuments}" /></div>
				    </c:if>
					<table class="table table-bordered table-responsive dataTableReview">
  						<thead>							
								<tr>
									<th><fmt:message key="id" /></th>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="description" /></th>
									<th><fmt:message key="department" /></th>
									<th><fmt:message key="percentCompleted" /></th>
								</tr>							
						</thead>
	
						<tbody>
	
						<c:forEach items="${reviewDocuments.results}" var="doc" varStatus="s">
							<tr>
								<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${doc.id}"/></c:url>" ><c:out value="${doc.id}" /></a></td>
								<td><c:out value="${doc.name}" /></td>
								<td><scannell:text value="${doc.description} " /></td>
								<td>
							        <c:forEach var="dept" items="${doc.departments}" varStatus="loop">
								     	<c:out value="${dept.name}" /><c:if test="${!loop.last}">,</c:if>
								    </c:forEach>
								</td>
								<td><c:out value="${doc.percentCompleted} " />%</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot> 
					    <c:if test="${found}">
						    <tr>
						      <td colspan="5"><scannell:paging result="${reviewDocuments}" /></td>
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
