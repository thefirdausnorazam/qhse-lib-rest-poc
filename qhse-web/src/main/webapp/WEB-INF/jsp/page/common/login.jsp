<%@ page language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	
<%-- To avoid the jsessionid being appended to URLs initially, we build URLs on this page using contextURL --%>
<c:set var="contextURL" value="${pageContext.servletContext.contextPath}" />

<c:if test="${recaptchaEnabled}">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</c:if>
		
<div class="g-container__subheader">
	<h2 class="g-heading"><spring:message code="loginTitle"/></h2>
</div>

<form id="form" class="g-form" action="<c:out value="${contextURL}/login" />" target="_top" method="POST">
	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="usernameLabel"/></label>
				<div class="g-input g-input--fluid">
					<input type="text" name="username" data-parsley-trigger="change" required id="username" value="<c:out value="${prepopulatedUsername}"/>"/>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="passwordLabel"/></label>
				<div class="g-input g-input--fluid">
					<input type="password" name="password"  data-parsley-trigger="change" required id="password" />
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="domainPickerTitle"/></label>
				<!--<c:set var="cookieDomain" value="${cookie.loginDomain.value}" />-->
				<select name="domain" class="g-select-fallback" data-parsley-excluded>
						<option value="">Standard</option>
						<option value="demo">Demo</option>
				</select>
			</div>
		</div>
	</div>
	
	<div class="row">
		<c:if test="${sso}">
		<<div class="col-md-6">
			<div class="g-form__element">
				<a class="g-btn g-btn--link" style="padding-left: 0px;" href="<c:out value="${contextURL}/forgotPassword.html" />"><spring:message code="forgotPassword"/></a>
			</div>
		</div>
		</c:if>
		<div class="col-md-12 text-right">
			<div class="g-form__element">
			<button id="loginSubmit" 
					class="g-btn g-btn--primary g-recaptcha"
					type="submit"
					data-dismiss="modal" 
					data-sitekey="<c:out value="${recaptchaDataSiteKey}" />" 
					data-callback="onSubmit"
					data-dismiss="modal"><spring:message code="loginButton"/></button>
			</div>
		</div>
	</div>
	
	<!-- SSO -->
	<c:if test="${sso}"> 
	<div class="row">
		<div class="col-md-12 text-right">
			<button type="button" 
					class="g-btn" 
					onclick="location.href='${contextURL}'" 
					data-toggle="tooltip" 
					title="SSO Login">One Login</button>
		</div>
	</div>
	</c:if>
</form>
	
<script type="text/javascript">

function onSubmit() {
	document.getElementById("form").submit();
}

</script>