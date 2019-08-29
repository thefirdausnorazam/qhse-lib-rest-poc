<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="thirdPartyEdit" />
	<c:if test="${command.id == 0}">
		<c:set var="title" value="thirdPartyCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<style type="text/css">
	td.search {
background-color: white !important;
border-width: 0px !important;
padding-top: 17px !important;
padding-right: 80px!important;
}
	</style>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<tbody>
	<tr class="form-group">
		<td class="searchLabel" style="width: 35%;"><fmt:message key="name" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="company" />:</td>
		<td class="search"><input name="company" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="address" />:</td>
		<td class="search"><input name="address" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="phoneNumber" />:</td>
		<td class="search"><input name="phoneNumber" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="emailAddress" />:</td>
		<td class="search"><input name="emailAddress" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="generalInfo" />:</td>
		<td class="search"><scannell:textarea path="generalInfo" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox id="active" path="active" /></label></div> </td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/thirdPartyQueryForm.htm" />'">
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
