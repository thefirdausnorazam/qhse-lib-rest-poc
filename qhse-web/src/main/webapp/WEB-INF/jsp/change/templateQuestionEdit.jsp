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
<style>
#div1, #div2
{float:left; width:100px; height:35px; margin:10px;padding:10px;border:1px solid #aaaaaa;}
</style>
<script>
	function allowDrop(ev) {
	    ev.preventDefault();
	}
	
	function drag(ev) {
	    ev.dataTransfer.setData("text", ev.target.id);
	}
	
	function drop(ev) {
	    ev.preventDefault();
	    var data = ev.dataTransfer.getData("text");
	    ev.target.appendChild(document.getElementById(data));
	}
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

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="active" /></td>
	</tr>
	
	<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)">
  		<img src="img_w3slogo.gif" draggable="true" ondragstart="drag(event)" id="drag1" width="88" height="31">  
	</div>
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
