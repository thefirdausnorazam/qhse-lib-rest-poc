<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="docLink.categoryEdit.title" /></title>
	<style type="text/css" media="all">
@import "<c:url value='/css/docs.css'/>";
</style>
</head>
<body>
<div class="header nowrap">
<h3><fmt:message key="docLink.categoryEdit.title" /></h3>
</div>
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered">
<tbody>
	<tr class="form-group" >
		<td class="searchLabel" style="width: 35%"><fmt:message key="docLink.categoryEdit.categoryName" />:</td>
		<td class="search"><input name="docLinkCategory.name" class="form-control" cssStyle="width:80%;"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel" style="width: 35%"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="docLinkCategory.active"/></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
		<c:choose>
			<c:when test="${command.allowedInCurrentSite }">
				<button class="g-btn g-btn--primary" type="submit"><fmt:message key="submit" /></button>
			</c:when>
			<c:otherwise>
				<fmt:message key="docLink.notAllowedInCurrentSite" /> ${command.docLinkCategory.site.name}
			</c:otherwise>
		</c:choose>
			<button type="button" class="g-btn g-btn--secondary" onclick="window.location='<c:url value="/doclink/linkSearchForm.htm" />'"><fmt:message key="cancel" /></button>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</body>
</html>
