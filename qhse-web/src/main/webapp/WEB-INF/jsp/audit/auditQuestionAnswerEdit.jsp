<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<div class="header nowrap">
<h2><fmt:message key="auditQuestionAnswer" /></h2>
</div>
<script type="text/javascript">
jQuery(document).ready(function () {	
	jQuery('#ThefindingType').select2({width:'40%'});
	jQuery('#score').select2({width:'40%'});
	if(!jQuery('#ThefindingType').val()){
	jQuery('#ThefindingType').select2('val', '${(defaultAuditFindingType == null) ? '' : defaultAuditFindingType.name}');
	var value = jQuery('#ThefindingType').val();
	 if(value === "b") {
		 jQuery('#ThefindingType').trigger('change');
	 }
	}
	jQuery(".checkbox").change(function() {
		nonConformance(${allowIncidentBeAssigned},${assigneIncidentToAuditee});
	});
	
});
var generateIncident='<fmt:message key="AuditFindingType.generateIncident"/>';
var generateCorrectiveAction='<fmt:message key="AuditFindingType.generateCorrectiveAction"/>';
var generatePreventativeAction='<fmt:message key="AuditFindingType.generatePreventativeAction"/>';
var generateIncidentNotAssign='<fmt:message key="AuditFindingType.generateIncidentNotAssign"/>';
var generateAssignedIncident = '<fmt:message key="AuditFindingType.generateAssignedIncident"/>';

function nonConformance(allow, assignIncident) {
	 var closed = jQuery("#completed").is(':checked');
	 var value = jQuery("#ThefindingType :selected").val();
	 	 
	 if(value != "b") {
	 	jQuery('#score').attr('disabled',false);
	 }
	 if(closed) 
	 {
		 if(value == 'j')
		 {
			 var msg = generateIncident;
			 if(assignIncident)
			 {
				 msg += '\n\n';
				 msg += allow ? generateAssignedIncident : generateIncidentNotAssign;
			 }
			 alert(msg);
		 }
		 else if(value === "n") {
			 	alert(generateIncident);
		 }
		 else if(value === "m") {
			 	alert(generateCorrectiveAction);
		 }
		 else if(value === "o") {
			 	alert(generatePreventativeAction);
		 }else if(value === "s") {
			 	alert(generateCorrectiveAction);
		 }
	 }
	 if(value === "b") {
		 jQuery('#score').select2('val', '');
		 	jQuery('#score').attr('disabled',true);
	 }
}
</script>
<div class="content">
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<fmt:message var="blankChoose" key="blankChoose" />
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="audit" />:</td>
		<td class="search"><c:out value="${question.audit.name}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="question" />:</td>
		<td class="search"><c:out value="${question.name}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:text value="${question.additionalInfo}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="findingComment" />:</td>
		<td class="search"><scannell:textarea path="findingComment" cols="75" rows="9" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="findingType" />:</td>
				<td class="search"><select name="findingType"  items="${findingTypes}" id="ThefindingType" itemValue="name" lookupItemLabel="true" class="wide"
					onchange="nonConformance(this,${allowIncidentBeAssigned},${assigneIncidentToAuditee});" emptyOptionLabel="${blankChoose}"></scannell:select></td>

	</tr>

	<c:if test="${question.scorable}">
		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="score" />:</td>
			<td class="search"><select name="score" id="score"  items="${question.scoreConfig.permittedScores}" class="narrow" ></scannell:select></td>
	
		</tr>
	</c:if>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="completed" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox id="completed" path="completed"/></label></div></td>
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
</div>
</body>
</html>
