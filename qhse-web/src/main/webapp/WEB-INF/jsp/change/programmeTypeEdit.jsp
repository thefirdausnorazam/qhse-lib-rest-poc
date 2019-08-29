<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<c:set var="title" value="changeProgramme.edit" />
	<c:if test="${command.id == null}">
		<c:set var="title" value="changeProgramme.create" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
			jQuery('#expressQuestionGroup').select2({width:'90%'});			
		});
	</script>
</head>
	<body>
		<div id="block" class="block" >
		
			<scannell:form id="queryForm">
		
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="name" />:</label>
				<div class="col-sm-6"><input name="name" class="wide" /></div>
			</div>
		
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="active" />:</label>
				<div class="col-sm-6"><scannell:checkbox path="active" /></div>
			</div>
		
			<div class="spacer2 text-center">
				<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
				<c:url var="cancelURL" value="/change/programmeTypeView.htm"><c:param name="id" value="${command.id}"/></c:url>
				<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">
			</div>
			</scannell:form>
		</div>
	</body>
</html>
