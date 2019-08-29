<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>

<style type="text/css" media="all">
/* @import "<c:url value='/css/risk.css'/>"; */

@import "<c:url value='/css/docs.css'/>";
</style>

<script type="text/javascript">
	function onTypeChange() {
		if (jQuery('#type').val() == 'attach') {
			hideBlock('webUrlDiv');
			showBlock('fileUrlDiv');
		} else {
			hideBlock('fileUrlDiv');
			showBlock('webUrlDiv');
		}
		if('${param.itemId}'){
			jQuery("#type").attr("disabled", true);
			jQuery("#content").attr("disabled", true);
			jQuery("#externalUrl").attr("disabled", true);
		}
	}
	
	window.onload = function() {
		var url = jQuery('#filename').val();
		var link = jQuery('#externalUrl').val()
		var type = null;
		if (url != null && url != "") {
			jQuery('#type').val('attach');
			url = url.substring(5, url.length);
			var colonIndex = url.indexOf(':');
			if (colonIndex > 0) {
				url = url.substring(colonIndex - 1, url.length);
			}
			jQuery("#file-info").html(url);
		} else if (link != null && link != "") {
			jQuery('#type').val('link');
		}
		$('type').selectedIndex = (type == 'attach') ? 0 : 1;
		onTypeChange();
	}

	function urlFile() {
		var content = jQuery('#filename').val();
		if (content != null && content.length > 0) {
			jQuery("#file-info").html(content);
		}
	}
	
	function getName(s){
		var arr=s.split('\\');
		var name= arr[(arr.length-1)];
		return name;
	}
	
	function changeFile() {
		var content = jQuery('#content').val();
		var name= getName(content);
		jQuery('#filename').val(name);
		jQuery("#file-info").html(name);
		checkFileSize();
	}

	function onFormSubmit() {
		if('${param.itemId}'){
			jQuery("#type").attr("disabled", false);
			jQuery("#content").attr("disabled", false);
			jQuery("#externalUrl").attr("disabled", false);
		}
		var url = null;
		if (jQuery('#type').val() == 'attach') {
			var fileUrl = jQuery('#content').val();
			if (fileUrl != null && fileUrl.length > 0) {
				if (fileUrl.indexOf('\\') >= 0) {
					// Replace windows path '\\' with '/'
					fileUrl = fileUrl.replace(/\\/g, '/');
				}
				if (fileUrl.indexOf(':') > 0) {
					fileUrl = "//" + fileUrl;
				}
				jQuery('#filename').val("file:" + fileUrl);
				jQuery('#externalUrl').val(null);
			}
			
			
		} else {
			var url = jQuery('#externalUrl').val();
			var urlPrefix = "http://";
			var urlPrefixS = "https://";
			if (url.length != 0
					&& url.substring(0, urlPrefix.length) != urlPrefix
					&& url.substring(0, urlPrefixS.length) != urlPrefixS) {
				url = urlPrefix + url;
			}
			jQuery('#externalUrl').val(url);
			jQuery('#filename').val(null);
		}
	}
</script>
<script type="text/javascript">
function checkFileSize(){
	var configuredSize = '${maxAttchmentSizeMb}';
	var configuredSizeNum = parseFloat(configuredSize);
    if(window.ActiveXObject){
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        var filepath = document.getElementById('content').value;
        var thefile = fso.getFile(filepath);
        var sizeinbytes = thefile.size;
    }else{
        var sizeinbytes = document.getElementById('content').files[0].size;
    }
    var sizeinMb = sizeinbytes/(1024*1024);
	 if(sizeinMb>=configuredSizeNum){
	 jQuery("#warningSizeDiv").show();
	 jQuery("#content").val('');
	 jQuery("#filename").val('');
	 jQuery("#file-info").html('');
 }else{
	 jQuery("#warningSizeDiv").hide();
 }
 
    
}
</script>
<c:choose>
			<c:when test="${empty command.name}">
				<title>
					<fmt:message key="addAttachment" />
				</title>
			</c:when>
			<c:otherwise>
				<title>
					<fmt:message key="attachmentEdit" />
				</title>
			</c:otherwise>
		</c:choose>
</head>
<body>
<!-- 	<div class="header nowrap"> -->
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${empty command.name}"> --%>
<!-- 				<h2> -->
<%-- 					<fmt:message key="addAttachment" /> --%>
<!-- 				</h2> -->
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
<!-- 				<h2> -->
<%-- 					<fmt:message key="attachmentEdit" /> --%>
<!-- 				</h2> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>

<!-- 	</div> -->
	<scannell:form enctype="multipart/form-data" onsubmit="onFormSubmit()">
	

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="type" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="type" path="type" items="${types}" itemValue="name" lookupItemLabel="true"
					onchange="onTypeChange();" renderEmptyOption="false" class="form-control wide" cssStyle="float:left;width:80%" />
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="name" />
			</label>
			<div class="col-sm-6">
				<scannell:input id="name" path="name" class="form-control wide" cssStyle="float:left;width:80%"/>
			</div>
		</div>

		<div class="form-group higher">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="description" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="description" cols="75" rows="3" class="form-control" cssStyle="float:left;width:80%"/>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group higher">
			<div id="webUrlDiv">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="externalUrl" />
				</label>
				<div class="col-sm-6">
					<scannell:input id="externalUrl" path="externalUrl" class="form-control wide" />
					<span class="requiredHinted">*</span>
				</div>
			</div>
			<div id="fileUrlDiv">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="content" />
				</label>
				<div class="col-sm-6">
					<span class="btn btn-primary btn-file">
						<fmt:message key="browseButton" />
						<input type="file" id="content" name="content" onchange='changeFile()'  class="form-control">
					</span>
					<span class='label label-info' id="file-info"></span>
					<scannell:hidden id="filename" path="filename" />
					<div class="mandatory-file" id="mandatoryFile">
						<span class="requiredHinted">*</span>
					</div>
				</div>
			</div>
		</div>

		<div style="clear: both;"></div>

		<c:if test="${not empty param.showId}">
			<c:if test="${not empty command.lastUpdatedTs}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
						<fmt:message key="lastUpdatedTs" />
					</label>
					<div class="col-sm-6">
						<fmt:formatDate value="${command.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
					</div>
				</div>
			</c:if>
			<c:if test="${not empty command.lastUpdatedByUser}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
						<fmt:message key="lastUpdatedBy" />
					</label>
					<div class="col-sm-6">
						<c:out value="${command.lastUpdatedByUser.displayName}" />
					</div>
				</div>
			</c:if>
		</c:if>

		<div style="clear: both;"></div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="active" />
			</label>
			<div class="col-sm-6">
				<scannell:checkbox id="active" path="active" />
			</div>
		</div>
		<div class="spacer2 text-center">
			<button type="submit" class="btn btn-primary">
				<fmt:message key="submit" />
			</button>
			<button type="button" class="btn btn-primary" onclick="history.back()">
				<fmt:message key="cancel" />
			</button>
		</div>
		<div class="alert alert-danger" id="warningSizeDiv" style="display:none">
 		 <strong><fmt:message key="warning" /></strong>&nbsp;<fmt:message key="attachment.max.size.configured"/>&nbsp;${requestScope.maxAttchmentSizeMb}&nbsp;Mb
 		 </div>
	</scannell:form>

</body>
</html>
