<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>

<style type="text/css">
td.search {
padding-left: 4% !important;
}
</style>
<c:set var="title" value="questionOptionEdit" />
<c:if test="${command.id == null}">
	<c:set var="title" value="questionOptionCreate" />
</c:if>

	<title></title>

	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript'>
	jQuery(document).ready(function() {	 
		jQuery('#dependsOnQuestion').select2({width:'40%'});
		jQuery('#dependsOn').select2({width:'40%'});
		jQuery('#question').select2({width:'40%'});
		});
	<!--
	function populateDependsOnOption() {
		DWRUtil.removeAllOptions("dependsOn");
		DWRUtil.addOptions("dependsOn", {" ":" ", "	":"Please Wait..."});
		SystemDWRService.getClientQuestionOptions(jQuery('#dependsOnQuestion').val(), populateDependsOnCallback);
	}

	function populateDependsOnCallback(data) {
		DWRUtil.removeAllOptions("dependsOn");
		DWRUtil.addOptions("dependsOn", {" ":" "});
		DWRUtil.addOptions("dependsOn", data);
	}
	// -->
	</script>

</head>
<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form>
	<scannell:hidden path="id" />
	<scannell:hidden path="version" />

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
		<col  />
		<tbody>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="name" />:</td>
				<td class="search"><input name="name" class="form-control" cssStyle="width:40%" /></td>
			</tr>

			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="question" />:</td>
				<td class="search"><c:out value="${question.name}"/></td>
			</tr>

			<tr class="form-group">
				<td  colspan="1" class="searchLabel"><fmt:message
					key="dependsOnQuestion" />:</td>
				<td class="search"><select id="dependsOnQuestion" name="dependsOnQuestion"
					onchange="populateDependsOnOption()" >
					<option value="">Choose</option>
					<c:forEach items="${questions}" var="question">
						<option value="<c:out value="${question.id}" />"
							<c:if test="${selectedDependsOn.question.id == question.id}">selected="selected"</c:if>>
						<c:out value="${question.codeName}" /></option>
					</c:forEach>
				</select></td>

			</tr>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="active" /></td>
				<td class="search"><scannell:checkbox path="active" /></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
			</tr>
		</tfoot>
	</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
