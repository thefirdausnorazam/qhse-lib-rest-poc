<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:choose>
	<c:when test="${empty command.name}">
		<title><fmt:message key="addAttachment" /></title>
	</c:when>
	<c:otherwise>
		<title><fmt:message key="attachmentEdit" /></title>
	</c:otherwise>
</c:choose>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#attachForm").submit(function() {	
			settingFileNameForNewUpload();
			// submit more than once return false
			jQuery(this).submit(function() {
				
				return false;
			});
			// submit once return true
			return true;
		});
	});
	var isNew = null;
	function onTypeChange() {		
		var isAttachment = jQuery("#type").val() == "attach";	
		jQuery("#content").prop( "disabled", !isAttachment );
		jQuery("#filename").prop( "disabled", !isAttachment );
		jQuery("#externalUrl").prop( "disabled", isAttachment );

		if (isNew == null) {
			isNew = jQuery("#name").val() == "";
		}

		if (isNew) {
			jQuery("#filenameRow").hide();
			jQuery("#activeDiv").hide();
		} else {
			jQuery("#filenameRow").show();
			jQuery("#filename").prop( "disabled", true );
			jQuery("#type").prop( "disabled", true );
			jQuery("#activeDiv").show();
		}
		if(jQuery('#type').val() == '' ){
			jQuery("#submitButton").prop( "disabled", true );
		} else {
			jQuery("#submitButton").prop( "disabled", false );
		}
	}
	function manageExternalLink(){
		if(!jQuery('#type').is(':disabled')){
 	   var fileName = jQuery('#content').val().split('/').pop().split('\\').pop();
	    jQuery('#filename').attr('value', fileName);
		}

	}
	function settingFileNameForNewUpload(){
		if(jQuery('input[type=file]').val().split('\\').pop() != ''){ 
			jQuery("#filename").prop("disabled", false );
			jQuery("#filename").val(jQuery('input[type=file]').val().split('\\').pop());
		}
	}
	</script>
<style>
.form-control {
	width: 90%;
	clear:both;
}
.form-control.higher{
	height: 100px;
}

span.requiredHinted {
	margin-right: 5px; display: initial;
}
.col-sm-6{
	display: flex;
}
input {
	float:left;
}
select {
float:left;
}
</style>
</head>
<body onload="onTypeChange()">
	<div class="content">
		<scannell:form id="attachForm" enctype="multipart/form-data" onsubmit="manageExternalLink();">
			<scannell:hidden path="filename" id="filename"/>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="type" />
				</label>
				<div class="col-sm-6">
					<scannell:select id="type" path="type" items="${types}" itemValue="name" lookupItemLabel="true" class="form-control" onchange="onTypeChange();" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="name" />
				</label>
				<div class="col-sm-6">
					<scannell:input id="name" path="name" class="form-control" />
				</div>
			</div>
			<div class="form-group higher">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="description" />
				</label>
				<div class="col-sm-6">
					<scannell:textarea path="description" cols="50" rows="3" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="externalUrl" />
				</label>
				<div class="col-sm-6">
					<scannell:input id="externalUrl" path="externalUrl" class="form-control" />
				</div>
			</div>
			<div id="contentRow" class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="content" />
				</label>
				<div class="col-sm-6">
					<input id="content" type="file" name="content" class="form-control" />
				</div>
			</div>
			<div id="activeDiv" class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="active" />
				</label>
				<div class="col-sm-6">
					<scannell:checkbox id="active" path="active" />
				</div>
			</div>
			<div class="spacer2 text-center">
				<button type="submit" class="g-btn g-btn--primary" id="submitButton">
					<fmt:message key="submit" />
				</button>
			</div>
		</scannell:form>
	</div>
</body>
</html>
