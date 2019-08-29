<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${recaptchaEnabled}">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</c:if>

<%-- To avoid the jsessionid being appended to URLs initially, we build URLs on this page using contextURL --%>
<c:set var="contextURL" value="${pageContext.servletContext.contextPath}" />

<div class="g-container__subheader">
	<h2 class="g-heading"><spring:message code="forgotPasswordTitle"/></h2>
</div>

<form id="form" class="g-form" action="<c:out value="${contextURL}/doBeginRecovery" />" target="_top" method="POST" >
	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="usernameOrEmail"/></label>
				<div class="g-input g-input--fluid">
					<input id="username" name="username" type="username" required />
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 text-right">
			<div class="g-form__element">
				<a href="<c:out value="${contextURL}/login.html"/>" class="g-btn g-btn--secondary">Cancel</a>
				<button class="g-btn g-btn--primary g-recaptcha" 
					data-dismiss="modal" 
					data-sitekey="<c:out value="${recaptchaDataSiteKey}" />" 
					data-callback='onSubmit'><spring:message code="beginRecovery"/></button>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
function onSubmit() {
	document.getElementById("form").submit();
}
</script>