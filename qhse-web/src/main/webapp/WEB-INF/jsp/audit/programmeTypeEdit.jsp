<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="programmeTypeEdit" />
	<c:if test="${command.id == null}">
		<c:set var="title" value="programmeTypeCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		jQuery('#expressQuestionGroup').select2({width:'90%'});			
	});
	
	function showApplyToApp(obj){
		if(obj.value == ""){
			jQuery("#applyToApp").prop("checked", false);
			jQuery("#apply-to-app").hide();
		} else {
			jQuery("#apply-to-app").show();
		}
	}
	</script>
</head>
<body>
<div id="block" class="block" >
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form id="queryForm" >
<fmt:message var="blankChoose" key="programmeType.nullExpressQuestionGroup" />
                              <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="name" /></label>
									<div class="col-sm-6">
										<input name="name" class="form-control" cssStyle="float:left;width:90%"/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="expressQuestionGroup" /></label>
									<div class="col-sm-6">																			
										<select name="expressQuestionGroup" id="expressQuestionGroup" onchange="showApplyToApp(this)" items="${questionGroupList}" itemValue="id" itemLabel="name" emptyOptionLabel="${blankChoose}" />
									</div>
								</div>
								
								<div class="form-group" id="apply-to-app" <c:if test="${command.expressQuestionGroup == null}">style="display:none" </c:if>>
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="applyToApp" /></label>
									<div class="col-sm-6">
										<c:choose>
											<c:when test="${mobileEnabled}">
												<scannell:checkbox path="applyToApp" id="applyToApp" />
											</c:when>
											<c:otherwise>
												<input type="checkbox" name="x" <c:if test="${selected}">checked="checked"</c:if> disabled="disabled"/>
												<input type="hidden" name="command.applyToApp" value="${selected}" />
												&nbsp;**<fmt:message key="licence.auditMobileDisabled" />**
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="active" /></label>
									<div class="col-sm-6">
										<scannell:checkbox path="active"  />
									</div>
								</div>
								
								<div class="spacer2 text-center">
			                    <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			                     <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/programmeTypeList.htm" />'">
			                  </div>
<%-- <div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">

<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="name" />:</td>
		<td class="search"><input name="name" class="form-control" cssStyle="width:100%"/></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="expressQuestionGroup" />:</td>
		<fmt:message var="emptyLabel" key="programmeType.nullExpressQuestionGroup" />
		<td class="search"><select name="expressQuestionGroup" id="expressQuestionGroup" items="${questionGroupList}" itemValue="id" itemLabel="name" class="wide" emptyOptionLabel="${emptyLabel}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="active" /></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/programmeTypeList.htm" />'">
		</td>
	</tr>
</tfoot>
</table>
</div>
</div> --%>
</scannell:form>
</div>
</body>
</html>
