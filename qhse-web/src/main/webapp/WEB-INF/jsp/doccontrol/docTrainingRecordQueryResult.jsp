<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="userQueryResult" /></title>
</head>
<body>
<script type="text/javascript"> 
	jQuery(document).ready(function() {
		initSortTables();
	} );
 </script>
 
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
<c:set var="found" value="${result != null && !empty result.results}" />
<div class="header">
<h3><fmt:message key="docControl.ackRecords" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
	<table class="table table-bordered table-responsive dataTable">
		<c:choose>
			<c:when test="${doc != null}">
				<thead>	
					<c:if test="${found}">
						<tr>
							<th><fmt:message key="docControl.document" /></th>
							<th><fmt:message key="doccontrol.version.label" /></th>
							<th><fmt:message key="doccontrol.notAckUser" /></th>
							<th><fmt:message key="department" /></th>
						</tr>
					</c:if>
				</thead>
				<tbody>
					<c:forEach items="${result.results}" var="user" varStatus="s">
						<tr>
							<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${doc.id}"/></c:url>" ><c:out value="${doc.name}" /></a></td>
							<td><a href="<c:url value="documentRevisionView.htm"><c:param name="id" value="${doc.lastDistributedRevision.id}"/><c:param name="parentId" value="${document.id}"/></c:url>" ><c:out value="${doc.lastDistributedRevision.displayVersion}" /></a></td>				
							<td><c:out value="${user.displayName}" /></td>
							<td><c:out value="${user.department.realName}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</c:when>
			<c:otherwise>
				<thead>	
					<c:if test="${found}">
						<tr>
							<th><fmt:message key="docControl.document" /></th>
							<th><fmt:message key="doccontrol.version.label" /></th>
							<th><fmt:message key="doccontrol.recordUser" /></th>
							<th><fmt:message key="doccontrol.userDepartment" /></th>
							<th><fmt:message key="doccontrol.recordDate" /></th>
						</tr>
					</c:if>
				</thead>
				<tbody>
					<c:forEach items="${result.results}" var="docTrainingRecord" varStatus="s">
						<tr>
							<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${docTrainingRecord.docRevision.document.id}"/></c:url>" ><c:out value="${docTrainingRecord.docRevision.document.name}" /></a></td>
							<td><a href="<c:url value="documentRevisionView.htm"><c:param name="id" value="${docTrainingRecord.docRevision.id}"/><c:param name="parentId" value="${docTrainingRecord.docRevision.document.id}"/></c:url>" ><c:out value="${docTrainingRecord.docRevision.displayVersion}" /></a></td>
							<td><c:out value="${docTrainingRecord.user.displayName}" /></td>
							<td><c:out value="${docTrainingRecord.user.department.name}"/></td>
							<td><fmt:formatDate value="${docTrainingRecord.recordTs}" pattern="dd-MMM-yyyy HH:mm"  /></td>
						</tr>
					</c:forEach>
				</tbody>
			</c:otherwise>
		</c:choose>
		<tfoot>
			<c:if test="${found}">
				<tr>
					<td colspan="5"><scannell:paging result="${result}" /></td>
				</tr>
			</c:if>
		</tfoot>
	</table>
</div>
</div>
</div>
</body>
</html>
