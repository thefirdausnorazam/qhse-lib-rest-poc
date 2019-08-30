<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"%>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="required" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="labelOverride" required="false" rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="configured" value="${incidentAvailableFieldsByName[name] != null}" />
<c:set var="fieldValue" value="${command.incident[name]}" />
<!-- always show existing fields if they have a value -->
<c:set var="displayed" value="${configured || (fieldValue != null && fieldValue != '' && not empty fieldValue)}" />


<c:set var="label" value="${name}" />
<c:if test="${labelOverride != null}">
	<c:set var="label" value="${labelOverride}" />
</c:if>

<c:if test="${displayed}">
	<div class="form-group" style="${style}">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
			<fmt:message key="${label}" />
		</label>
		<div class="col-sm-6">
			<spring:bind path="${name}">
				<jsp:doBody />
				<c:if test="${required}"><span class="requiredHinted">*</span></c:if>
				<span class="errorMessage">
					<c:out value="${status.errorMessage}" />
				</span>
			</spring:bind>
		</div>
	</div>
</c:if>
