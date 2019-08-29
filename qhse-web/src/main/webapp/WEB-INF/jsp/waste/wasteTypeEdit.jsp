<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="wasteTypeEdit" />
	<c:if test="${command.id == 0}">
		<c:set var="title" value="wasteTypeCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>

	<script type='text/javascript' src="<c:url value="/dwr/interface/WasteDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/waste.js" />" ></script>
	
	<script type='text/javascript'>
	jQuery(document).ready(function() {
		jQuery('select').not('#siteLocation').select2({width:'70%'});
		setNewCategoryVisibility();
	});
	<!--
	function setNewCategoryVisibility() {
		var selectedIndex = jQuery('#categories :selected').index();
		if (selectedIndex == 1) {
			jQuery('#newCategoryForm').show();
		} else {
			jQuery('#newCategoryForm').hide();
		}
	}

	function customUnitTest(expression) {
		openWindow("customUnitSampleView.htm?expression=" + encodeURIComponent(expression), 500, 300, true, "Test", true);
	}

	function customUnitTestExample() {
		openWindow("customUnitSampleView.htm?expression=x*8&sample=true", 500, 300, true, "Sample", true);
	}
	// -->
	</script>

</head>
<body>
<scannell:form>
<div class="content">
<table class="table  table-responsive">
<col  />
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="category" />:</td>
		<td class="search">
			<scannell:select id="categories" path="category.id" items="${categories}" itemValue="id" itemLabel="name" onchange="setNewCategoryVisibility()" emptyOptionValue="" emptyOptionLabel="Choose" class="wide" />
			<scannell:errors path="category"/>
			<table id="newCategoryForm" class="table table-bordered table-responsive" style="display: none;">
			<tbody>
				<tr>
					<td ><fmt:message key="name" />:</td>
					<td><input name="category.name" cssStyle="width:30%" /><span class="requiredHinted requiredCat">*</span></td>
				</tr>
				<tr>
					<td ><fmt:message key="categoryClass" />:</td>
					<td><scannell:select id="categories" path="category.categoryClass" items="${categoryClassList}" itemValue="id" itemLabel="name" emptyOptionValue="" emptyOptionLabel="Choose" class="wide" /><span class="requiredHinted requiredCat">*</span></td>
				</tr>
				<tr>
					<td ><fmt:message key="additionalInfo" />:</td>
					<td><scannell:textarea path="category.additionalInfo" cols="75" rows="3" /></td>
				</tr>
			</tbody>
			</table>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="name" />:</td>
		<td class="search"><input name="name" cssStyle="width:30%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="additionalInfo" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group">
		<td  rowspan="3" class="searchLabel"><fmt:message key="wasteTypeCode" />:</td>
		<td class="search">
			<select id="superSuperCode" name="superSuperCode" onchange="populateSuperCodes()" class="wide">
				<option value="">Choose</option>
				<c:forEach items="${superSuperTypeCodes}" var="code">
					<option value="<c:out value="${code.id}" />" <c:if test="${command.code.superCode.superCode.id == code.id}">selected="selected"</c:if>>
						<c:out value="${code}" /></option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr class="form-group">
		<td class="search">
			<select id="superCode" name="superCode" onchange="populateCodes()" class="wide">
				<option value="">Choose</option>
				<c:forEach items="${superTypeCodes}" var="code">
					<option value="<c:out value="${code.id}" />" <c:if test="${command.code.superCode.id == code.id}">selected="selected"</c:if>>
						<c:out value="${code}" /></option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr class="form-group">
		<td class="search">
			<scannell:select id="code" path="code" items="${typeCodes}" itemValue="id" emptyOptionValue="0" emptyOptionLabel="Choose" class="wide" />
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="hazardCodes" />:</td>
		<td class="search">
			<input type="hidden" name="_hazardCodes" value="xxx" />
			<spring:bind path="command.hazardCodes">
				<div class="checkbox" >
				<label style="text-align: left">
					<c:forEach items="${hazardCodes}" var="anyCode">
						<c:set var="selected" value="${false}" />
						<c:forEach items="${command.hazardCodes}" var="selectedCode">
							<c:if test="${anyCode.id == selectedCode.id}"><c:set var="selected" value="${true}" /></c:if>
						</c:forEach>
						<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${anyCode.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
						<span><c:out value="${anyCode.name}" /></span><br />
					</c:forEach>
					</label>
				</div>
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="physicalCharacteristic" />:</td>
		<td class="search"><select name="physicalCharacteristic" items="${physicalCharacteristics}" itemValue="name" lookupItemLabel="true" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="reconciler" />:</td>
		<td class="search"><select name="reconciler" items="${reconcilers}" itemValue="id" itemLabel="sortableName" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="convertToWeightExpression" />:</td>
		<td class="search">
			<scannell:input id="customUnit" path="customUnit" cssStyle="width:30%" />
			<button class="g-btn g-btn--primary" type="button" onclick="customUnitTest(jQuery('#customUnit').val())"><fmt:message key="test" /></button>
			<button class="g-btn g-btn--primary" type="button" onclick="customUnitTestExample()"><fmt:message key="waste.wasteTypeEdit.sample" /></button>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><div class="checkbox"><label><scannell:checkbox path="active" /></label></div></td>
	</tr>
</tbody>

<%-- <tfoot>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
	</tr>
</tfoot> --%>
</table>
</div>
<div class="spacer2 text-center ">
<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
</div>
</scannell:form>

</body>
</html>
