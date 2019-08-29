<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="thirdPartyView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">


<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${thirdParty.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><c:out value="${thirdParty.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="company" />:</td>
		<td><c:out value="${thirdParty.company}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="address" />:</td>
		<td><c:out value="${thirdParty.address}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="phoneNumber" />:</td>
		<td><c:out value="${thirdParty.phoneNumber}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="emailAddress" />:</td>
		<td><c:out value="${thirdParty.emailAddress}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="generalInfo" />:</td>
		<td><c:out value="${thirdParty.generalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
		<td><fmt:message key="${thirdParty.active}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${thirdParty.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${thirdParty.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${thirdParty.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${thirdParty.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${thirdParty.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<common:bindURL editable="${currentSiteRecord}" name="thirdParty" site="${thirdParty.site.name}">		
				<scannell:url urls="${urls}" />
			</common:bindURL>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
