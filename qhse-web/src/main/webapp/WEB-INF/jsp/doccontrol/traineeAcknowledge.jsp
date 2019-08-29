<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<style type="text/css" media="all">
		@import "<c:url value='/css/doccontrol.css'/>";
	</style>
</head>
<body>
<div class="header">
<h2><span class="nowrap"><c:out value="${docGroup.name}" /></span></h2>
</div>
<div class="content">
<div class="content">
	<div class="table-responsive">
		<table class="table table-bordered table-responsive">
			<tbody>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
					<td><c:out value="${docGroup.id}" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="doccontrol.docGroupSearchForm.prefix" />:</td>
					<td>
						<c:out value="${docGroup.prefix}" />
					</td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
					<td>
						<c:out value="${docGroup.name}" />
					</td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="frequency" />:</td>
					<td>
						<c:out value="${docGroup.frequency}" />
					</td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
					<td><c:out value="${docGroup.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${docGroup.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				<c:if test="${docGroup.lastUpdatedByUser != null}">
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
					<td><c:out value="${docGroup.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${docGroup.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<c:choose>
							<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
							<c:otherwise><fmt:message key="doccontrol.docGroup.label" /> <fmt:message key="notCurrentSelectedSiteMsg" >
											
										 </fmt:message>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<c:if test="${!empty docGroup.documents}">
<div class="header nowrap">
	<h3><fmt:message key="docControl.documents" /></h3>
</div>
<div class="content">
	<div class="table-responsive">
		<table class="table table-bordered table-responsive">
		<thead>
			<tr>
				<th><fmt:message key="id" /></th>
				<th><fmt:message key="name" /></th>
				<th><fmt:message key="description" /></th>
				<th><fmt:message key="status" /></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${docGroup.documents}" var="document" varStatus="s">
				<c:choose>
					<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
					<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
				</c:choose>
				<tr class="<c:out value="${style}" />">
					<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${document.id}"/></c:url>" ><c:out value="${document.id}" /></a></td>
					<td><c:out value="${document.name}" /></td>
					<td><scannell:text value="${document.description} " /></td>
					<td><fmt:message key="${document.status}" /></td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</div>
</div>
</c:if>
</div>
</body>
</html>
