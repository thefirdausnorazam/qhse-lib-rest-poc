<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="doccontrol.documentApprove.create" /></title>
  <style type="text/css" media="all">
    @import "<c:url value='/css/doccontrol.css'/>";
  </style>
  	<script type="text/javascript">		
		jQuery(document).ready(function() {
			jQuery("form").submit(function() {
				// submit more than once return false
				jQuery(this).submit(function() {
					return false;
				});
				// submit once return true
				return true;
			});
		});
	</script>
</head>
<body>
<scannell:form>

	<div class="content"> 
		<div class="form-group" style="min-height:110px;">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="assessment.approvalComment" />:
			</label>
			<div class="col-sm-6" >
				<scannell:textarea path="approvalComment" cols="75" rows="3" />
			</div>
		</div>
		<div style="clear: both;"></div>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="approve" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>
	</div>
</scannell:form>
</body>
</html>
