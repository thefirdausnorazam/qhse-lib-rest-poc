<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>
<c:choose>
			<c:when test="${empty param.showId}">
				
					<fmt:message key="addDocLinks" />
				
			</c:when>
			<c:otherwise>
				
					<fmt:message key="editDocLinks" />
				
			</c:otherwise>
		</c:choose>
</title>
<style type="text/css" media="all">
@import "<c:url value='/css/docs.css'/>";
</style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		if(document.getElementById("docLink.name.errors") != null && document.getElementById("docLink.name.errors").innerHTML.toLowerCase() != "required") {
			document.getElementById("nameNotUnique").innerHTML = document.getElementById("docLink.name.errors").innerHTML;
			document.getElementById("docLink.name.errors").innerHTML = "";
		}
		
	});


	function onTypeChange() {
		if (jQuery('#type').val() == 'attach') {
			hideBlock('webUrlDiv');
			showBlock('fileUrlDiv');
		} else {
			hideBlock('fileUrlDiv');
			showBlock('webUrlDiv');
		}
	}

	function onFormSubmit() {
		var url = null;
		if (jQuery('#type').val() == 'attach') {
			var fileUrl = jQuery('#content').val();
			var name = fileUrl;getName(fileUrl);
			if(name != "") {
				jQuery('#filename').val('file:\\' + name);
			} 
			jQuery('#url').val(null);

		} else {
			var url = jQuery('#url').val();
			var urlPrefix = "http://";
			var urlPrefixS = "https://";
			if (url.length != 0
					&& url.substring(0, urlPrefix.length) != urlPrefix
					&& url.substring(0, urlPrefixS.length) != urlPrefixS) {
				url = urlPrefix + url;
			}
			jQuery('#url').val(url);
			jQuery('#filename').val(null);
		}
	}
	function newCategory() {
		if (jQuery('#categoryName').val() == '0') {
			showBlock('newCategory');
		} else {
			hideBlock('newCategory');
		}
	}

	function getName(s) {
		var arr = s.split('\\');
		var name = arr[(arr.length - 1)];
		return name;
	}

	window.onload = function() {
		var url = jQuery('#filename').val();
		var link = jQuery('#url').val()
		var type = null;
		
		if (link != null && link != "" && url.indexOf("http") > -1) {
			jQuery('#type').val('link');
		}else if (url != null && url != "") {
			jQuery('#type').val('attach');
			jQuery("#file-info").html(url);
		} 
		$('type').selectedIndex = (type == 'attach') ? 0 : 1;
		onTypeChange();
		newCategory();
	}

	function urlFile() {
		var content = jQuery('#filename').val();
		if (content != null && content.length > 0) {
			jQuery("#file-info").html(content);
		}
	}
	function changeFile() {
		var content = jQuery('#content').val();
		var name = getName(content);
		jQuery('#filename').val(name);
		jQuery("#file-info").html(name);
	}
</script>

</head>
<body>
<!-- 	<div class="header"> -->
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${empty param.showId}"> --%>
<!-- 				<h2> -->
<%-- 					<fmt:message key="addDocLinks" /> --%>
<!-- 				</h2> -->
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
<!-- 				<h2> -->
<%-- 					<fmt:message key="editDocLinks" /> --%>
<!-- 				</h2> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>
<!-- 	</div> -->
	<scannell:form onsubmit="onFormSubmit();document.getElementById('submit').disabled = 1;" enctype="multipart/form-data">

		<scannell:hidden path="docLink.id" />
		<scannell:hidden path="docLink.version" />
		<span  class="errorMessage"><c:if test="${categoryUniqueName != null }"><fmt:message key="${categoryUniqueName}"/></c:if></span>
<span id="nameNotUnique" class="errorMessage"></span>
		<div class="form-group">
			<div class="label label-mandatory">
				<fmt:message key="required.category.doc" />
				<span class="mandatory"> *</span>
				
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="category" />
			</label>
			<div class="col-sm-6">
				<select name="docLink.category" id="categoryName" itemValue="id" itemLabel="name" items="${categories}"
					emptyOptionValue="0" emptyOptionLabel="[New category]" class="form-control wide" onchange="newCategory()" cssStyle="float:left;"  />
				<span class="mandatory">*</span>
			</div>
		</div>
		<div class="form-group" id="newCategory">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="newCategoryName" />
			</label>
			<div class="col-sm-6">
				<%-- <input name="categoryName" id="newCategoryName" class="form-control wide" cssStyle="float:left;" /> --%>
				<input type="text" name="categoryName" id="newCategoryName" class="form-control wide" style="width: 90%" maxlength="250"/>
				<span class="mandatory">*</span>
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="name" />
			</label>
			<div class="col-sm-6">
				<input name="docLink.name" class="form-control wide" cssStyle="float:left;" />
				<span class="mandatory">*</span>
			</div>
		</div>
		<div class="form-group ">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="description" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="docLink.description" cols="50" rows="3" class="form-control" cssStyle="float:left;" />
			</div>
		</div>
<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="type" />
			</label>
			<div class="col-sm-6">
				<select id="type" class="form-control" onchange="onTypeChange()" style="float:left;">
					<option value="attach"><fmt:message key="docLinkType.file" /></option>
					<option value="link"><fmt:message key="docLinkType.web" /></option>
				</select>
			</div>
		</div>

		<div class="form-group ">
			<div id="webUrlDiv">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="externalUrl" />
				</label>
				<div class="col-sm-6">
					<scannell:input id="url" path="docLink.url" cssStyle="width:500px" />
					<span class="mandatory">*</span>
				</div>
			</div>
			<div id="fileUrlDiv">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="content" />
				</label>
				<div class="col-sm-3">
					<span class="g-btn g-btn--primary btn-file">
						<fmt:message key="browseButton" />
						<input type="file" id="content" value="docLink.url" name="content" onchange='changeFile()'>
					</span>
					<span class='label label-info' id="file-info"></span>
					<scannell:hidden id="filename" path="docLink.url" />
					<div class="mandatory-file" id="mandatoryFile">
						<span class="mandatory">*</span>
					</div>
				</div>
			</div>
		</div>

		<div style="clear: both;"></div>

		<c:if test="${not empty param.showId}">
			<c:if test="${not empty command.docLink.lastUpdatedTs}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
						<fmt:message key="lastUpdatedTs" />
					</label>
					<div class="col-sm-6">
						<fmt:formatDate value="${command.docLink.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
					</div>
				</div>
			</c:if>
			<c:if test="${not empty command.docLink.lastUpdatedByUser}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
						<fmt:message key="lastUpdatedBy" />
					</label>
					<div class="col-sm-6">
						<c:out value="${command.docLink.lastUpdatedByUser.displayName}" />
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
				<scannell:checkbox path="docLink.active" />
			</div>
		</div>

		<div class="spacer2 text-center">
			<button id="submit" type="submit" class="g-btn g-btn--primary">
				<fmt:message key="submit" />
			</button>
			<button type="button" class="g-btn g-btn--primary" onclick="history.back()">
				<fmt:message key="cancel" />
			</button>
		</div>

	</scannell:form>
</body>
</html>
