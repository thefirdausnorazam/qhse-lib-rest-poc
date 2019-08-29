<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="userDomain.synchronise" /></title>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery("#cl-wrapper").append(jQuery("#inProgress"));	
			
			jQuery("#sync").on("click", function(e) {
				jQuery("#inProgress").modal("show");
			});
			
		});
	</script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="auditComplete" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col class="label" />
<tbody>
	<tr class="form-group">
		<th class="searchLabel" style="width:25%"><fmt:message key="comment" />:</th>
		<td class="search"><scannell:textarea path="comment" class="form-control" cssStyle="float:left;width:70%" /></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input id="sync" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="userDomain.synchronise" />" ></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

<common:inProgress/>

</body>
</html>
