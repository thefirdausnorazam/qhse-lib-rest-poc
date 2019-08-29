<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="changeProgrammeType" />
		</h2>
	</div>
	<div class="content">
<!-- 		<div class="header nowrap"> -->
<!-- 			<h3> -->
<%-- 				<fmt:message key="programmeType" /> --%>
<!-- 			</h3> -->
<!-- 		</div> -->
		<div class="content">
			<div class="table-responsive">
				<table class="table table-responsive table-bordered">
					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
							<td><c:out value="${programmeType.id}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
							<td><c:out value="${programmeType.name}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
							<td><fmt:message key="${programmeType.active}" /></td>
						</tr>
						
						 <tr>
						    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
						    <td colspan="3">
						    	<jsp:include page="../doclink/showLinkedDocs.jsp" />
						    </td>
						  </tr>
  
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
							<td><c:out value="${programmeType.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
									value="${programmeType.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>

						<c:if test="${programmeType.lastUpdatedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${programmeType.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${programmeType.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="3"><scannell:url urls="${urls}" /></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
