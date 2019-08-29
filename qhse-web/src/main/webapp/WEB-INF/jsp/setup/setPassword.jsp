<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="<c:url value="/js/setup/passwordStrengthFeedback.js?force_reload=123" />"></script>

<div class="g-container__subheader">
	<h2 class="g-heading"><spring:message code="setPassword"/></h2>
</div>

<form id="form" class="g-form" action="<c:url value="/setup/setPassword.html" />" target="_top" method="POST" data-parsley-validate>	
	<div class="g-form__element">
		<div class="row">
			<div class="col-md-12">
				<div id="complexity-character-count" class="alert alert-info alert-white rounded">
					<div class="icon"><i class="fa fa-info-circle"></i></div>
					<spring:message code="passwordStrengthLength"/>
				 </div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<div id="complexity-avoid-common-passwords" class="alert alert-info alert-white rounded">
					<div class="icon"><i class="fa fa-info-circle"></i></div>
					<spring:message code="passwordStrengthCommonPassword"/>
				</div>
			</div>
		</div>
		
		<c:if test="${isRecentPasswordHistoryEnabled}">
		<div class="row">
			<div class="col-md-12">
				<div id="enforce-password-history" class="alert alert-info alert-white rounded">
					<div class="icon"><i class="fa fa-info-circle"></i></div>
					<spring:message code="password.recentlyUsed"/>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${isForcePasswordComplexityEnabled}">
		<div class="row">
			<div class="col-md-12">
				<div id="enforce-password-complexity-alphanumeric" class="alert alert-info alert-white rounded">
					<div class="icon"><i class="fa fa-info-circle"></i></div>
					<spring:message code="password.passwordComplexityAlphanumeric"/>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<div id="enforce-password-complexity-special" class="alert alert-info alert-white rounded">
					<div class="icon"><i class="fa fa-info-circle"></i></div>
					<spring:message code="password.passwordComplexitySpecial"/>
				</div>
			</div>
		</div>
		</c:if>
	</div>
		
	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="newPassword"/></label>
				<div class="g-input g-input--fluid">
					<input type="password" maxlength="100" name="newPassword"  required id="password">
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<div class="g-form__element">
				<label class="g-label"><spring:message code="confirmPassword"/></label>
				<div class="g-input g-input--fluid">
					<input type="password" maxlength="100" name="confirmNewPassword" required />
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12 text-right">
			<button class="g-btn g-btn--primary" data-dismiss="modal" type="submit" id="loginSubmit"><spring:message code="setPassword"/></button>
		</div>
	</div>

</form>

<script type="text/javascript">

function getContextUrl() {
	return "<c:url value="/"/>"; 
}
</script>