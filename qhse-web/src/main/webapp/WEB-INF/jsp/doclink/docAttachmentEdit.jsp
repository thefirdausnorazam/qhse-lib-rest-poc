<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title>
<c:choose>
			<c:when test="${empty command.name}">
				
					<fmt:message key="addAttachment" />
				
			</c:when>
			<c:otherwise>
				
					<fmt:message key="attachmentEdit" />
				
			</c:otherwise>
		</c:choose>
</title>
<style type="text/css" media="all">
@import "<c:url value='/css/docs.css'/>";
</style>
<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery('.requiredHinted:first').hide();
	
	//jQuery('span:first').remove();
	//jQuery(this).prev('.label-mandatory').remove();
});
	function newCategory() {
		if (jQuery('#categoryName').val() == '0') {
			showBlock('newCategory');
		} else {
			hideBlock('newCategory');
		}
	}
	
	function getName(s){
		var arr=s.split('\\');
		var name= arr[(arr.length-1)];
		return name;
	}
	
	function urlFile() {
		var content = jQuery('#filename').val();
		if (content != null && content.length > 0) {
			jQuery("#file-info").html(content);
		}
	}
	function changeFile() {
		var content = jQuery('#content').val();
		var name= getName(content);
		jQuery('#filename').val(name);
		jQuery("#file-info").html(name);
		checkFileSize();

	}
	window.onload = function() {
		urlFile();
		newCategory();
		jQuery('#type').val('attach');
	}
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
</head>
<body onload="onTypeChange();">
<!-- 	<div class="header"> -->
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${empty command.name}"> --%>
<!-- 				<h3> -->
<%-- 					<fmt:message key="addAttachment" /> --%>
<!-- 				</h3> -->
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
<!-- 				<h3> -->
<%-- 					<fmt:message key="attachmentEdit" /> --%>
<!-- 				</h3> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>
<!-- 	</div> -->
	<scannell:form enctype="multipart/form-data" onsubmit="document.getElementById('submit').disabled = 1;">
		<scannell:hidden path="type" id="type"/>
		<span  class="errorMessage"><c:if test="${categoryUniqueName != null }"><fmt:message key="${categoryUniqueName}"/></c:if></span>
		<div class="form-group">
			<div class="label label-mandatory">
				<fmt:message key="required.category.doc" />
				<span class="requiredHinted"> *</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="category" /></label>
			<div class="col-sm-6">
				<select name="docLink.category" id="categoryName" itemValue="id" itemLabel="name" emptyOptionValue="0"
					emptyOptionLabel="[New category]" items="${categories}" class="form-control wide" onchange="newCategory()" cssStyle="float:left;" />
			</div>
		</div>
		<div class="form-group" id="newCategory">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="newCategoryName" /></label>
			<div class="col-sm-6">
				<%-- <input name="categoryName" id="newCategoryName" class="form-control wide" cssStyle="float:left;width:80%" /> --%>
				<input type="text" name="categoryName" id="newCategoryName" class="form-control wide" style="width: 90%" maxlength="250"/>
				<span class="requiredHinted">*</span>
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="name" /></label>
			<div class="col-sm-6">
				<scannell:input id="name" path="name" class="form-control wide" cssStyle="float:left;" />
			</div>
		</div>

		<div class="form-group ">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="description" /></label>
			<div class="col-sm-6">
				<scannell:textarea path="description" cols="75" rows="3" class="form-control wide textarea" />
			</div>
		</div>
<div style="clear: both;"></div>
		<div class="form-group " id="contentRow">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="content" /></label>
			<div class="col-sm-3">
				<span class="g-btn g-btn--primary btn-file"><fmt:message key="browseButton" />
				<input type="file" id="content" name="content" onchange='changeFile()'></span>
				<span class='label label-info' id="file-info"></span>
				<scannell:hidden id="filename" path="filename" />
				<div class="mandatory-file" id="mandatoryFile">
					<span class="requiredHinted">*</span>
				</div>
			</div>
		</div>
<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="active" /></label>
			<div class="col-sm-6">
				<scannell:checkbox id="active" path="active" />
			</div>
		</div>
		<c:if test="${not empty param.showId}">
		<c:if test="${not empty command.lastUpdatedTs}">
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedTs" /></label>
			<div class="col-sm-6">
				<fmt:formatDate value="${command.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
			</div>
		</div>
		</c:if>
				<c:if test="${not empty command.lastUpdatedByUser}">
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" /></label>
			<div class="col-sm-6">
				<c:out value="${command.lastUpdatedByUser.displayName}" />
			</div>
		</div>
		</c:if>
		</c:if>
		
		<div class="spacer2 text-center">
			<button id="submit" type="submit" class="g-btn g-btn--primary">
				<fmt:message key="submit" />
			</button>
			<button type="button" class="g-btn g-btn--secondary"
				onclick="window.location='<c:url value="/doclink/linkSearchForm.htm" />'">
				<fmt:message key="cancel" />
			</button>
		</div>
		
		<div class="spacer2 alert alert-danger" id="warningSizeDiv" style="display:none">
			<strong><fmt:message key="warning" /></strong>&nbsp;<fmt:message key="attachment.max.size.configured"/>&nbsp;${requestScope.maxAttchmentSizeMb}&nbsp;Mb
	 	</div>

	</scannell:form>

</body>
</html>
