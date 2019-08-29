<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="noteCreate" /></title>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="noteCreate" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="title" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:50%"/></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="text" />:</td>
		<td class="search"><scannell:textarea path="text" class="form-control" cssStyle="float:left;width:50%" /></td>
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
