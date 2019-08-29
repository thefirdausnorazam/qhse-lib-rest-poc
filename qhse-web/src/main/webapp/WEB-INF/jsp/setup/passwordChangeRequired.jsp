<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="g-container__subheader">
	<h2 class="g-heading"><spring:message code="passwordChange.title"/></h2>
</div>

<form id="form" class="g-form" action="<c:url value="/setup/setPassword.html" />" target="_top" method="GET">
	<div class="row">
		<div class="col-md-12 g-form__element">
			<p>
				<spring:message code="passwordChange.message"/>
			</p>
			<p>
				<spring:message code="followInstructionsSetup"/>
			</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 text-right">
			<button class="g-btn g-btn--primary btn-lg" type="submit">
				<spring:message code="passwordChange.button"/>
			</button>
		</div>
	</div>
</form>
