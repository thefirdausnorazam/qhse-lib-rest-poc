<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="templateQuestionEdit" />
	<c:if test="${command.newQuestion}">
		<c:set var="title" value="templateQuestionCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<style type="text/css">
	th.searchLabel {
    padding-right: 0px !important;
    }
	</style>
	
<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery('#groupSelect').select2({width:'40%'});
	jQuery("#groupSelect").select2('val');
	var groupSelect = jQuery('#groupSelect');
	groupSelect.append('<option id="newGroupOption" value="">[<fmt:message key="auditTemplateQuestion.newGroup" />]</option>')
	
	groupSelect.change(function() {
		var selected = groupSelect.children("option:selected");
		var newGroup = selected.is("#newGroupOption");
		jQuery('#newGroupNameRow').toggle(newGroup);
		jQuery('#newGroupName').val('');
	})

});


</script>

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
	<tr class="form-group" >
		<td class="searchLabel" style="width: 35%; border: 0px"><fmt:message key="question" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="additionalInfo" class="form-control" cssStyle="width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="group" />:</td>
		<td class="search"><select name="group" id="groupSelect" items="${groups}" itemValue="id" itemLabel="name" class="wide" onclick="newGroup()" emptyOptionValue="0" /></td>
	</tr>
	<tr class="form-group" id="newGroupNameRow" style="display: none;">
		<td class="searchLabel"><fmt:message key="auditTemplateQuestion.newGroupName" />:</td>
		<td class="search"><input name="newGroupName" id="newGroupName" class="form-control" cssStyle="width:40%"/></td>
	</tr>
	<c:if test="${command.scorable}">
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="scoreMin" />:</td>
		<td class="search"><input name="scoreMin" class="form-control" cssStyle="width:40%" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="scoreMax" />:</td>
		<td class="search"><input name="scoreMax" class="form-control" cssStyle="width:40%" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="scoreIncrement" />:</td>
		<td class="search"><input name="scoreIncrement" class="form-control" cssStyle="width:40%"/></td>
	</tr>
	</c:if>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="active" /></td>
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
