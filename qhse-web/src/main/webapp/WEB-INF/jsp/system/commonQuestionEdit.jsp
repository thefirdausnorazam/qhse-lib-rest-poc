<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="questionEdit" />
<c:if test="${command.id == null}">
	<c:set var="title" value="questionCreate" />
</c:if>
<title></title>
<script type="text/javascript">
jQuery(document).ready(function() {	 
jQuery('#answerType').select2();
});
</script>
<style type="text/css">
td.searchLabel {
width: 35%;
</style>
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
				<td class="searchLabel"><fmt:message key="codeName" /></td>
				<td class="search"><input name="codeName" class="form-control" cssStyle="width:40%" readonly="true" /></td>
			</tr>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="displayName" /></td>
				<td class="search"><input name="name" class="form-control" cssStyle="width:40%" readonly="true" /></td>
			</tr>
			<%-- <tr class="form-group">
				<td class="searchLabel"><fmt:message key="furtherInfo" /></td>
				<td class="search"><input name="furtherInfo" class="form-control" cssStyle="width:40%" readonly="true" /></td>
			</tr> --%>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="questionAnswerType" />:</td>
				<td class="search"><input name="answerType" class="form-control" cssStyle="width:40%" readonly="true"/></td>
			</tr>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="active" /></td>
				<td class="search"><scannell:checkbox path="active" visible="false"/><fmt:message key="${command.active}"/></td>
			</tr>
			<tr class="form-group">
    	 <td class="searchLabel"><fmt:message key="modules"/>:</td>
	      <td class="search">
	      <input type="hidden" name="_.modules" value="xxx" />
			<spring:bind path="command.modules">
					<c:forEach items="${modules}" var="module">
						<c:set var="selected" value="${false}" />
						<c:forEach items="${command.modules}" var="selectedModule">
							<c:if test="${module.id == selectedModule.id}"><c:set var="selected" value="${true}" /></c:if>
						</c:forEach>
						<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${module.id}" />" <c:if test="${selected}">checked="checked"</c:if>/><span>&nbsp;<c:out value="${module.name}" /></span><br />
					</c:forEach>
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
	      </td>
    </tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2" align="center"><input class="g-btn g-btn--primary" type="submit"
					value="<fmt:message key="submit" />"></td>
			</tr>
		</tfoot>
	</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
