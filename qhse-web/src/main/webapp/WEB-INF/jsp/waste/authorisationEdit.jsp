<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="wasteCodeAuthorisationEdit" />
<c:if test="${command.newAuthorisation}">
	<c:set var="title" value="wasteCodeAuthorisationCreate" />
</c:if>
<title></title>

<script type='text/javascript' src="<c:url value="/dwr/interface/WasteDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/waste.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script src="<c:url value="/js/jsj/jquery.multiselect/js/jquery.multi-select.js" />" type="text/javascript"></script>
<link href="<c:url value="/js/jsj/jquery.multiselect/css/multi-select.css" />" media="screen" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/js/jsj/bootstrap.multiselect/css/bootstrap-multiselect.css" />" />

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>
<style type="text/css">
#tableAuthorizationForm select {
	min-width: 30%;
}
</style>

<script type="text/javascript">
	jQuery(document).ready(function() {
		onPageSubmit();
		// jQuery('#wasteTypeCodes').multiSelect();
		jQuery('#superSuperCode').select2({
			width : '30%'
		});
		jQuery('#superCode').select2({
			width : '30%'
		});
	});

	function onPageSubmit() {
		selectAllOptions(document.getElementById("wasteTypeCodes"));
	}
</script>

</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="${title}" />
		</h2>
	</div>
	<div class="content">
		<scannell:form onsubmit="onPageSubmit();">

			<div class="content">
				<div class="table-responsive">
					<table id="tableAuthorizationForm" class="table  table-responsive">
						<col />
						<tbody>

							<tr>
								<td style="width: 20%"><fmt:message key="referenceNo" />:</td>
								<td><input name="referenceNo" cssStyle="width:30%" />
									<span class="errorMessage">
										<c:out value="${status.errorMessage}" />
									</span>
								</td>
							</tr>

							<tr>
								<td><fmt:message key="startDate" />:</td>
								<td>
									<div style="width: 50%;">
										<spring:bind path="command.startDate">
											<div class="input-group date datetime" data-min-view="2" data-date-format="dd-MM-yyyy" >
												<input class="form-control" id="startDate" name="startDate" size="6" type="text" readonly
													value="<fmt:formatDate type="date" value="${command.startDate}" pattern="dd-MMM-yyyy" />" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
												<span class="requiredHinted">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</div>
										</spring:bind>
									</div>
								</td>
							</tr>

							<tr>
								<td><fmt:message key="endDate" />:</td>
								<td>
									<div style="width: 50%;">
										<spring:bind path="command.endDate">
											<div class="input-group date datetime" data-min-view="2" data-date-format="dd-MM-yyyy">
												<input class="form-control" id="endDate" name="endDate" size="6" type="text" readonly
													value="<fmt:formatDate type="date" value="${command.endDate}" pattern="dd-MMM-yyyy" />" />
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
												<span class="requiredHinted">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</div>
										</spring:bind>
									</div>
								</td>
							</tr>

							<tr>
								<td><fmt:message key="notes" />:</td>
								<td><scannell:textarea path="notes" cols="75" rows="3" /></td>
							</tr>

							<tr>
								<td rowspan="3"><fmt:message key="wasteTypeCode" />:</td>
								<td><select id="superSuperCode" name="superSuperCode" onchange="populateSuperCodes()" class="wide">
										<option value="">Choose</option>
										<c:forEach items="${superSuperTypeCodes}" var="code">
											<option value="<c:out value="${code.id}" />">
												<c:out value="${code}" /></option>
										</c:forEach>
									</select></td>
							</tr>

							<tr>
								<td><select id="superCode" name="superCode" onchange="populateCodes()" class="wide">
										<option value="">Choose</option>
									</select></td>
							</tr>

							<tr>
								<td>
									
									<div style="width: 100%; text-align: right; padding-right: 40%">
										<fmt:message key="selected" />
										<fmt:message key="wasteTypeCodes" />
									</div>
									<div class="col-sm-4">
										<select id="code" name="code" multiple="multiple" size="10" cssStyle="overflow: auto;"
											onDblClick="moveSelectedOptions(this.form['code'],this.form['wasteTypeCodes'])" class="wide">
										</select>
									</div>
									<div class="col-sm-2" style="text-align: center;">
										<div style="margin-top: 50%; margin-bottom: 50%;">
											<input class="g-btn g-btn--primary" type="button" name="left" value="&lt;&lt;" onclick="moveSelectedOptions(this.form['wasteTypeCodes'],this.form['code'])" />
											<input id="rightButton" class="g-btn g-btn--primary" type="button" name="right" value="&gt;&gt;"onclick="moveSelectedOptions(this.form['code'],this.form['wasteTypeCodes'])" />
										</div>
									</div>
									<div class="col-sm-4">

										<scannell:select id="wasteTypeCodes" path="wasteTypeCodes" items="${command.wasteTypeCodes}" itemValue="id"
											cssStyle="overflow: auto;" multiple="true" size="10" class="wide"
											ondblclick="moveSelectedOptions(this.form['wasteTypeCodes'],this.form['code'])" renderEmptyOption="false" />
									</div>
								</td>
							</tr>

						</tbody>
						<%-- <tfoot>
							<tr>
								<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary"
										value="<fmt:message key="submit" />"></td>
							</tr>
						</tfoot> --%>
					</table>
				</div>
			</div>
			<div class="spacer2 text-center ">
           <button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
            </div>
		</scannell:form>
	</div>
</body>
</html>
