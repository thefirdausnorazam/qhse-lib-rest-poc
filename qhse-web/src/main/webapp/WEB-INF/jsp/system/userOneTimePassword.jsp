<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<script type="text/javascript" src="<c:url value="/js/setup/passwordStrengthFeedback.js?force_reload=123" />"></script>
<style type="text/css">
th.searchLabel {
width: 30%;
}
</style>
<div class="header">
	<h2>
		<fmt:message key="userOneTimePassword.title" >
			<fmt:param value="${theUser.description}" />
			<fmt:param value="${theUser.name}" />
		</fmt:message>
	</h2>
</div>
<scannell:form>
	<div class="content">
		<div class="table-responsive">
			<table class="table table-responsive table-bordered">  
			    <col class="label" />
			    <tbody>
					<tr class="form-group">
						<th class="searchLabel"><label>One-Time Use Password</label></th>
						<td class="search">
							<div id="complexity-character-count" style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<fmt:message key="passwordStrengthLength"/>
							 </div>
							
							<div id="complexity-avoid-common-passwords" style="width: 50%" class="alert alert-info alert-white rounded">
								<div class="icon"><i class="fa fa-info-circle"></i></div>
								<fmt:message key="passwordStrengthCommonPassword"/>
							</div>
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
			        <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="Set One-Time Password"></td>
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
