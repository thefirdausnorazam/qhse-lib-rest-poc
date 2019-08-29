<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="templateEdit" />
	<c:if test="${command.id == 0}">
		<c:set var="title" value="templateCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<style type="text/css" media="all">    
/*     	@import "<c:url value='/css/risk.css'/>"; */
  </style>
</head>
<script type="text/javascript">
jQuery(document).ready(function () {	 
	jQuery('#defaultFindingType').select2({width:'40%'});

});

function showAuditTemplateAppUsageMessage(chbox){
	if(jQuery(chbox).is(":checked")){
		alert('<fmt:message key="auditTemplateAppUsageMessage" />');
	}
}
</script>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<fmt:message var="blankChoose" key="blankChoose" />
<table class="table table-bordered table-responsive">
<tbody>
	<tr class="form-group">
		<td class="searchLabel" style="width: 40%;"><fmt:message key="name" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="scorable" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox path="scorable" visible="${hasTemplateAudits==false }"/></label></div></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="additionalInfo" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox path="active" /></label></div></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="applyToApp" />:</td>
		<td class="search">
			<div class="checkbox">
				<label>
					<c:set var="selected" value="${command.applyToApp}" />
					<c:choose>
						<c:when test="${mobileEnabled}">
							<scannell:checkbox path="applyToApp" onclick="showAuditTemplateAppUsageMessage(this)"/>
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="x" <c:if test="${selected}">checked="checked"</c:if> disabled="disabled"/>
							<input type="hidden" name="command.applyToApp" value="${selected}" />
							&nbsp;**<fmt:message key="licence.auditMobileDisabled" />**
						</c:otherwise>
					</c:choose>
				</label>
			</div>
		</td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="auditTemplate.notIncidentAssigned"/>:</td>
		<td class="search"><scannell:checkbox path="assignIncidentToAuditee" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="defaultFindingType" />:</td>
		<td class="search"><select name="defaultFindingType"  items="${findingTypes}" id="defaultFindingType" itemValue="name" lookupItemLabel="true" class="wide"
			emptyOptionLabel="${blankChoose}"></scannell:select></td>
	</tr>
	<tr class="form-group">
		<td class="search" colspan="2" class="noteLabel" style="text-align:center"><fmt:message key="auditTemplate.notIncidentCreated"/></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/templateQueryForm.htm" />'">
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
