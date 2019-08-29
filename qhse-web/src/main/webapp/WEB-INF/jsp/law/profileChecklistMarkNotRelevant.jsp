<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
<meta http-equiv="robots" content="noindex, nofollow, noarchive">


<c:set var="moduleColor" value="#a5b5d9" />
<style type="text/css" media="all">
/*  	@import "<c:url value='/css/default.css'/>";  */

/* 	h2, a, a:visited, table.viewForm a, div.menuContainer, table.viewForm tfoot tr td {color: <c:out value="${moduleColor}" />;} */
/* 	table.viewForm thead tr td {border-bottom-color: <c:out value="${moduleColor}" />; color: <c:out value="${moduleColor}" />; } */
/* 	div.menuTitle {background-color: <c:out value="${moduleColor}" />;} */
/* 	table.viewForm {border-color: <c:out value="${moduleColor}" />;} */
	
</style>
<script type="text/javascript">
function onBodyLoad(){
	//method created just to satisfy the obligation of popup decorator
}
</script>
</head>
<body >
<div class="content"> 


<scannell:form>
	<table class="table table-bordered table-responsive">
	<col class="label" />
	<tbody>
		<tr class="form-group">
			<td class="searchLabel scannellGeneralLabel"><fmt:message key="comment" />:</td>
			<td class="search"><scannell:textarea path="relevantComment" cols="50" rows="8" /></td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4" style="text-align: center">
				<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
<%-- 				<input type="submit" value="<fmt:message key="submit" />"> --%>
			</td>
		</tr>
	</tfoot>
	</table>
</scannell:form>

</div>
</body>
</html>
