<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<form id="form" class="form-horizontal" action="<c:url value="/setup/setPassword.html" />" target="_top" method="GET">
	<div class="content">
		<h3 class="title"><spring:message code="passwordExpiredTitle"/></h3>
		
		<div class="form-group">
			<div class="col-sm-12">
				<div class="input-group">
					<spring:message code="passwordExpiredMessage" />
				</div>
			</div>
		</div>
		<div class="form-group text-right">
			<div class="col-sm-12">
				<button class="g-btn g-btn--primary btn-lg" type="submit">
					<spring:message code="passwordExpiredButton" />
				</button>
			</div>
		</div>
	</div>
</form>