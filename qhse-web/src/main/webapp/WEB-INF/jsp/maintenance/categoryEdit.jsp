<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="maintenanceCategoryEdit" />
	<c:if test="${command['new']}"><c:set var="title" value="maintenanceCategoryCreate" /></c:if>
	<title><fmt:message key="${title}.${command.type.name}" /></title>
	<style type="text/css" media="all">
		@import "<c:url value='/css/survey.css'/>";
	</style>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}.${command.type.name}" /></h2> --%>
<!-- </div> -->

<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
	<tr class="form-group">
		<td class="editLabel"><fmt:message key="name" />:</td>
		<td class="search"><input name="name" class="wide" maxlength="50" /></td>
	</tr>

	<tr class="form-group">
		<td class="editLabel"><fmt:message key="active" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox path="active" /></label></div></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
