<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title> </title>
<script type="text/javascript" src="<c:url value="/js/setup/passwordStrengthFeedback.js?force_reload=123" />"></script>
<style type="text/css">
th.searchLabel {
width: 30%;
}
</style>
</head>
<body>
<div class="header">
	<h2>
		<fmt:message key="userChangePassword" ><fmt:param value="${user.description}" /><fmt:param value="${user.name}" /></fmt:message>
	</h2>
</div>
<scannell:form>
	<div class="content">
		<div class="table-responsive">
			<table class="table table-responsive table-bordered">  
			    <col class="label" />
			    <tbody>
					<tr class="form-group">
						<th class="searchLabel"><label><fmt:message key="oldPassword" /></label></th>
						<td class="search"><scannell:password path="oldPassword" class="form-control" cssStyle="width:50%" /></td>
					</tr>
					<tr class="form-group">
						<th class="searchLabel"><label><fmt:message key="newPassword" /></label></th>
						<td class="search">
							<div id="complexity-character-count" style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<fmt:message key="passwordStrengthLength"/>
							 </div>
							
							<div id="complexity-avoid-common-passwords" style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<fmt:message key="passwordStrengthCommonPassword"/>
							</div>
		
							<c:if test="${isRecentPasswordHistoryEnabled}">
							<div id="enforce-password-history" style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<spring:message code="password.recentlyUsed"/>
							</div>
							</c:if>

							<c:if test="${isForcePasswordComplexityEnabled}">
							<div id="enforce-password-complexity-alphanumeric"style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<spring:message code="password.passwordComplexityAlphanumeric"/>
							</div>
							<div id="enforce-password-complexity-special"style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<spring:message code="password.passwordComplexitySpecial"/>
							</div>
							</c:if>
							<scannell:password path="newPassword" id="password" class="form-control"  cssStyle="width:50%"/>
						</td>
					</tr>
					<tr class="form-group">
						<th class="searchLabel"><label><fmt:message key="confirmNewPassword" /></label></th>
						<td class="search"><scannell:password path="confirmNewPassword" class="form-control" cssStyle="width:50%"/></td>
					</tr>
			    </tbody>
			    <tfoot>
			      <tr>
			        <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="changePassword" />"></td>
			      </tr>
			    </tfoot>
			</table>
		</div>
	</div>
</scannell:form>


<script type="text/javascript">

function getContextUrl() {
	return "<c:url value="/"/>"; 
}
</script>

</body>
</html>
