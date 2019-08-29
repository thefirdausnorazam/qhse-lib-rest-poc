<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="auditQuestionEdit" />
	<c:if test="${command.newQuestion}">
		<c:set var="title" value="auditQuestionCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
</head>

<script type="text/javascript">
jQuery(document).ready(function() {
	var groupSelect = jQuery('#groupSelect');
	groupSelect.append('<option id="newGroupOption" value="">[<fmt:message key="auditTemplateQuestion.newGroup" />]</option>')
	
	groupSelect.change(function() {
		var selected = groupSelect.children("option:selected");
		var newGroup = selected.is("#newGroupOption");
		jQuery('#newGroupNameRow').toggle(newGroup);
		jQuery('#newGroupName').val('');
	})

	jQuery("input.only-numerical").keyup(function(){
	    this.value = this.value.replace(/[^0-99]/g, 0);
	    
	});
	
});

 jQuery(function(){ 
	jQuery('#scoreIncrement').keyup(function() {
  	var scoreIncrement=jQuery("#scoreIncrement").val();
		if(isNaN(scoreIncrement) || (scoreIncrement==0))
		{
			jQuery("#scoreIncrement").val('1');
		}
		return true;
	  });
	});
 function validateScoreValues(){
	 var max = jQuery(".scoreMax").val() * 1;
	 var min = jQuery(".scoreMin").val() * 1;
	 var increm = jQuery(".scoreIncrem").val() * 1;
	    if( max <  min){
			alert('<fmt:message key="maxScoreCanotBeLowerThanMinScore" />');	
			return true;
		}
	    if(((max - min) / increm) > 100){
			alert('<fmt:message key="scoreRangeIsTooBig" />');
			return true;
		}
	    if(increm > max){
			alert('<fmt:message key="incrementGreaterThanMax" />');
			return true;
		}
	    if(increm > 2000000000 || max > 2000000000 || min > 2000000000){
			alert('<fmt:message key="valuesAretoobig" />');
			return true;
		}
	    jQuery("#formPage").submit();
	}
</script>

<body >
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form id="formPage">
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="question" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="additionalInfo" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="group" />:</td>
		<td class="search"><select name="group" id="groupSelect" items="${groups}" itemValue="id" itemLabel="name" class="wide" /></td>
	</tr>
	<tr id="newGroupNameRow" class="form-group" style="display: none;">
		<td class="searchLabel"><fmt:message key="auditTemplateQuestion.newGroupName" />:</td>
		<td class="search"><input name="newGroupName" id="newGroupName" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>
	<c:if test="${command.scorable}">
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="scoreMin" />:</td>
		<td class="search"><input name="scoreMin" class="form-control only-numerical scoreMin" cssStyle="float:left;width:40%" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="scoreMax" />:</td>
		<td class="search"><input name="scoreMax" class="form-control only-numerical scoreMax" cssStyle="width:40%" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="scoreIncrement" />:</td>
		<td class="search"><input name="scoreIncrement" id="scoreIncrement" class="form-control  only-numerical scoreIncrem" cssStyle="width:40%" /></td>
	</tr>
	</c:if>


	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox path="active" /></label></div></td>
	</tr>
</tbody>

<tfoot>
	<tr>
		<td colspan="2" align="center"><input type="button" onclick="validateScoreValues()" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
