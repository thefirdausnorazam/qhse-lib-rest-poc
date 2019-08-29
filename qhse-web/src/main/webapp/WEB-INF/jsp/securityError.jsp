<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="g-container__subheader">
	<h2 class="g-heading"><spring:message code="securityError"/></h2>
</div>

<div class="row">
	<div class="col-md-12 info-page-content">	
		<spring:message code="security.error.processingFailed" var="defaultMessage"/>
		<p><spring:message code="${securityErrorMessage}" text="${defaultMessage}"/></p>

		<p><spring:message code="securityContactAdmin"/></p>
	</div>
</div>

