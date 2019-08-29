<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<style type="text/css" media="all">
		@import "<c:url value='/css/doccontrol.css'/>";
	</style>
<meta name="printable" content="true">
<title></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
		    jQuery(".pageSize").val('${defaultPageSize}');
		    if('${isCreator}' == 'true') {
				jQuery('#reviewQueryForm').submit();
				jQuery('#approvalQueryForm').submit();
				jQuery('#overdueQueryForm').submit();
		    }
			jQuery('#ackQueryForm').submit();
		} );
	</script>
	<div class="content">
		<!--  My Documents to Review -->
		<form id="reviewQueryForm" action="<c:url value="/doccontrol/documentsForReview.ajax" />" onSubmit="return search(this, 'docReviewResultsDiv');">
		  	<input type="hidden" name="calculateTotals" value="true" />
		  	<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" class="pageSize" name="pageSize" />
			<input type="hidden" name="reviewerId" value="${currentUserId}"/>
			<input type="hidden" name="status" value="DRAFT"/>
			<input type="hidden" name="notReviewedBy" value="${currentUserId}"/>
			<input type="hidden" name="statusActive" value="true"/>
		  	<div id="docReviewResultsDiv"></div>
		</form>
		
		<!--  My Documents to Approve -->
		<form id="approvalQueryForm" action="<c:url value="/doccontrol/documentsForApproval.ajax" />" onSubmit="return search(this, 'docApprovalResultsDiv');">
			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" class="pageSize" name="pageSize" />
			<input type="hidden" name="approverId" value="${currentUserId}"/>
			<input type="hidden" name="status" value="REVIEW"/>
			<input type="hidden" name="statusActive" value="true"/>
			<div id="docApprovalResultsDiv"></div>
		</form>		
		
		<!--  My Documents that are Overdue -->
		<form id="overdueQueryForm" action="<c:url value="/doccontrol/documentsOverdue.ajax" />" onSubmit="return search(this, 'docOverdueResultsDiv');">
		  	<input type="hidden" name="calculateTotals" value="true" />
		  	<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" class="pageSize" name="pageSize" />
			<input type="hidden" name="approverId" value="${currentUserId}"/>
			<input type="hidden" name="overdue" value="true"/>
			<input type="hidden" name="statusActive" value="true"/>
		  	<div id="docOverdueResultsDiv"></div>
		</form>
			
			
		<!--  My Documents due for Acknowledgment -->
		<form id="ackQueryForm" action="<c:url value="/doccontrol/documentsForAck.ajax" />" onSubmit="return search(this, 'docAckResultsDiv');">
		  	<input type="hidden" name="calculateTotals" value="true" />
		  	<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" class="pageSize" name="pageSize" />
			<input type="hidden" name="statusActive" value="true"/>
			<input type="hidden" name="isAck" value="true"/>
			<input type="hidden" name="hasDistributedAccess" value="true"/>
			<input type="hidden" name="notAckUserId" value="${currentUserId}"/>
		  	<div id="docAckResultsDiv"></div>
		</form>
			
	</div>
</body>
</html>
