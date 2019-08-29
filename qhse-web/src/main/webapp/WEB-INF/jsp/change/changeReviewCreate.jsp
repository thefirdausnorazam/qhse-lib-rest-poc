<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
</head>
<body>

<div class="header ">
<h2><fmt:message key="changeReview.create" /></h2>
</div>
<scannell:form>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="reviewComment" />:</td>
		<td><scannell:textarea path="comment" cols="75" rows="3" /></td>
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
</scannell:form>

</body>
</html>
