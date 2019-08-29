<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>

<title><fmt:message key="quickLink.edit" /></title>

</head>
<script type="text/javascript" src="<c:url value="/js/boot.js" />"></script>
<link rel="stylesheet" href="<c:url value='/css/crop/main.css'/>"
	type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/demos.css' />"
	type="text/css" />
<link rel="stylesheet"
	href="<c:url value='/css/crop/jquery.Jcrop.css'/>" type="text/css" />
<script src="<c:url value='/js/crop/jquery.Jcrop.js' />"></script>
<style type="text/css" media="print">
.printImageSize {
	max-width: 500px;
	width: 550px
}
</style>
<script type="text/javascript">
	function toggle(source) {
		  checkboxes = document.getElementsByName('activeInSites');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }
		
	}
	
	function load_image(id, ext, input) {

		if (validateExtension(ext) == false) {
			alert("Upload only JPEG, PNG, GIFF, GIF or JPG format ");
			//document.getElementById("imagePreview").src = "#";
			document.getElementById("content").focus();
			document.getElementById("form_submit").disabled = 1;
			return;
		}
		document.getElementById("form_submit").disabled = 0;

		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				jQuery('#imageDiv').text('');
				jQuery("#imageDiv").show();
				jQuery('#imageDiv')
						.prepend(
								'<img id="theImg" src="e.target.result" alt="" border=3  style="max-height:200px" />');
				jQuery("#theImg").attr("src", e.target.result);
				//jQuery('#theImg').Jcrop();
				cropImage();
			}

			reader.readAsDataURL(input.files[0]);
		}

	}
	function validateExtension(v) {
		var allowedExtensions = new Array("jpg", "JPG", "jpeg", "JPEG", "giff",
				"GIFF", "gif", "GIF", "png", "PNG");
		for (var ct = 0; ct < allowedExtensions.length; ct++) {
			sample = v.lastIndexOf(allowedExtensions[ct]);
			if (sample != -1) {
				return true;
			}
		}
		return false;
	}
	function hideDivs() {
		jQuery(".department").hide();
		jQuery(".status").hide();
		jQuery(".openClosed").hide();
		jQuery(".subtype").hide();
		jQuery(".legRegister").hide();
		jQuery("#legRegister").prop('required',false);
		jQuery(".attachmentType").hide();
		jQuery(".taskType").hide();
		jQuery(".dataType").hide();
	}
	jQuery(document).ready(function() {
		hideDivs();
		jQuery("select").select2({
			width : '90%'
		});
		jQuery('#module').change(function() {
			hideDivs();
			var module = jQuery('#module').find(":selected").val();
			jQuery('#url').select2('val', '');
			jQuery('#url').children().remove();
			jQuery('#url').append(jQuery('<option>', {
				value : "",
				text : "<fmt:message key='choose' />"
			}));
			<c:forEach items="${actionOptions}" var="action">
			var thismodule = "${action.module}";
			
			if (module == thismodule) {
				jQuery('#url').append(jQuery('<option>', {
					value : "${action.url}",
					text : "${action.text} "
				}));
			}
			</c:forEach>
			jQuery('#url').val('');
			jQuery('#action').val('');
		});
		jQuery('#url').change(function() {
			hideDivs();
			var url = jQuery('#url').val().toUpperCase();
			<c:forEach items="${actionOptions}" var="action">
			var thisURL = "${action.url}".toUpperCase();

			if (thisURL == url) {
				if ("${action.subType}" == "true") {
					jQuery(".subtype").show();
				}
				if ("${action.status}" == "true") {
					jQuery(".status").show();
				}
				if ("${action.openClosed}" == "true") {
					jQuery(".openClosed").show();
				}
				if ("${action.department}" == "true") {
					jQuery(".department").show();
				}
				if ("${action.legRegister}" == "true") {
					jQuery(".legRegister").show();
					jQuery("#legRegister").prop('required',true);
				}
				if ("${action.attachmentType}" == "true") {
					jQuery(".attachmentType").show();
				}
				if ("${action.taskType}" == "true") {
					jQuery(".taskType").show();
				}
				if ("${action.dataType}" == "true") {
					jQuery(".dataType").show();
				}
			}
			</c:forEach>
		});
		if ('${imageEncoded}'.trim() == '') {
			jQuery('#imageDiv').hide();
		}
		setValues();
	});

	function setValues() {
		var module = '${command.module}';
		if (module) {
			jQuery('#module').val(module);
			jQuery('#module').change();
			jQuery('#module option[value="${command.module}"]').attr('selected',
			'selected');
			jQuery('#url').val('${command.url}');
			jQuery('#url option[value="${command.url}"]').change();
			jQuery('#url option[value="${command.url}"]').attr('selected',
					'selected');
			jQuery('#IncidentType').val('${command.type}');
			jQuery('#IncidentType option[value="${command.type}"]').change();
			jQuery('#IncidentType option[value="${command.type}"]').attr(
					'selected', 'selected');
			jQuery('#taskType').val('${command.taskType}');
			jQuery('#taskType option[value="${command.taskType}"]').change();
			jQuery('#taskType option[value="${command.taskType}"]').attr(
					'selected', 'selected');
			jQuery('#dataType').val('${command.dataType}');
			jQuery('#dataType option[value="${command.dataType}"]').change();
			jQuery('#dataType option[value="${command.dataType}"]').attr(
					'selected', 'selected');
			jQuery('#status').val('${command.status}');
			jQuery('#status option[value="${command.status}"]').change();
			jQuery('#status option[value="${command.status}"]').attr(
					'selected', 'selected');
			jQuery('#openClosed').val('${command.openClosed}');
			jQuery('#openClosed option[value="${command.openClosed}"]').change();
			jQuery('#openClosed option[value="${command.openClosed}"]').attr(
					'selected', 'selected');
			jQuery('#department').val('${command.department}');
			jQuery('#department option[value="${command.department}"]')
					.change();
			jQuery('#department option[value="${command.department}"]').attr(
					'selected', 'selected');
			jQuery('#legRegister').val('${command.legRegister}');
			jQuery('#legRegister option[value="${command.legRegister}"]')
					.change();
			jQuery('#legRegister option[value="${command.legRegister}"]').attr(
					'selected', 'selected');
			jQuery('#attachmentType').val('${command.attachmentType}');
			jQuery('#attachmentType option[value="${command.attachmentType}"]')
					.change();
			jQuery('#attachmentType option[value="${command.attachmentType}"]')
					.attr('selected', 'selected');
		}
		jQuery('#accessRight').val('${command.accessRight}');
	}
	
	 function getStatusOfSelctedView(){
		 if(jQuery("#url").val() == "/doccontrol/documentSearchForm.htm") {
			 resetStatus();
		     <c:forEach var="status" items="${docStatusList}">
		     	jQuery("#status").append(jQuery('<option>', {value:"${status.name}", text:"<fmt:message key='${status}'/>"}));
		     </c:forEach>
		 }
		 else {
			 if(jQuery('#status option').size() > 2) {
				resetStatus()
		     	jQuery("#status").append(jQuery('<option>', {value:"IN_PROGR", text:"IN_PROGR"}));
		     	jQuery("#status").append(jQuery('<option>', {value:"COMPLETE", text:"COMPLETE"}));
			 } 
			 var viewUrl = jQuery('#url').val();
			 jQuery.ajax({
			 	  type: 'POST', 
				  dataType: "json",
				  url: "getStatusOfSelctedView.json",
				  data: 'viewUrl='+viewUrl,
				  success: function(data){
		           jQuery('#status option[value="IN_PROGR"]').text(data.IN_PROGR).change();
		           jQuery('#status option[value="COMPLETE"]').text(data.COMPLETE).change();
				  }
				});
		 }
	     jQuery('#status').val(jQuery("#status option:first").val());
	     jQuery('#status option:first').attr('selected','selected');
	 }
	 
	 function resetStatus() {
		jQuery('#status').select2('val', '');
    	jQuery('#status option[value=""]').attr('selected','selected');
		 jQuery('#status option').each(function() {
		   jQuery(this).remove();
		 });
	     jQuery("#status").append(jQuery('<option>', {value:"", text:"<fmt:message key='choose'/>"}));
	 }
</script>
<body>
	<!-- <div class="header"> -->
	<%-- <h2><fmt:message key="${title}" /></h2> --%>
	<!-- </div> -->
	<scannell:form enctype="multipart/form-data">
		<input type="hidden" id="cropX" name="cropX" value="">
		<input type="hidden" id="cropY" name="cropY" value="">
		<input type="hidden" id="cropW" name="cropW" value="">
		<input type="hidden" id="cropH" name="cropH" value="">
		<input type="hidden" id="row" />
		<input type="hidden" id="col" />
		<input type="hidden" id="type" />

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.label" />
			</label>
			<div class="col-sm-6">
				<scannell:input class="form-control" path="label"
					cssStyle="width:90%" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.hint" />
			</label>
			<div class="col-sm-6">
				<scannell:input class="form-control" path="hint"
					cssStyle="width:90%" />
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.module" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<select name="module" id="module">
					<option value="docs">
						<fmt:message key="docsMenu" />
					</option>
					<c:forEach var="module" items="${moduleList}">
						<c:if test="${module.code != 'admin'}">
							<option value="${module.code}">
								<fmt:message key="${module.code}Menu" />
							</option>
						</c:if>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="module" />
			</div>
		</div>
		<div class="form-group showImage">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.view" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<select name="url" id="url" onchange="getStatusOfSelctedView()">
					<c:forEach var="action" items="${actionOptions}">
						<option value="${action.url}">
							<c:out value="${action.text}" />
						</option>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="url" />
			</div>
		</div>
		<div class="form-group showImage department">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="department" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<scannell:select id="department" path="department">
					<option value="-1"><fmt:message
							key="quickLink.userDepartment" /></option>
					<c:forEach var="dept" items="${departments}">
						<option value="${dept.id}">
							<c:out value="${dept.name}" />
						</option>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="action" />
			</div>
		</div>
		<div class="form-group showImage status">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="status" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<scannell:select id="status" path="status">
					<option value="IN_PROGR">
						<fmt:message key="IN_PROGR" />
					</option>
					<option value="COMPLETE">
						<fmt:message key="complete" />
					</option>
				</scannell:select>
				<scannell:errors path="status" />
			</div>
		</div>
		<div class="form-group showImage openClosed">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="task.openClosed" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<scannell:select id="openClosed" path="openClosed">
					<option value="open"><fmt:message key="task.openClosed.open" /></option>
					<option value="overdue"><fmt:message key="task.openClosed.overdue" /></option>
					<option value="closed"><fmt:message key="task.openClosed.closed" /></option>
				</scannell:select>
				<scannell:errors path="openClosed" />
			</div>
		</div>
		<div class="form-group showImage legRegister">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="legRegister" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<scannell:select id="legRegister" path="legRegister">
					<option value="1"><fmt:message key="env" /></option>
					<option value="2"><fmt:message key="hs" /></option>
				</scannell:select>
				<span class="mandatory">*</span>
				<scannell:errors path="action" />
			</div>
		</div>
		<div class="form-group attachmentType">
			<label class="col-sm-3 control-label"> <fmt:message
					key="docType" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="attachmentType" path="attachmentType"
					items="${docTypes}" />
			</div>
		</div>
		<div class="form-group dataType">
			<label class="col-sm-3 control-label"> <fmt:message
					key="type" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="dataType" path="dataType">
					<c:forEach var="data" items="${dataTypes}">
						<option value="${data.name}">
							<fmt:message key="${data}" />
						</option>
					</c:forEach>
				</scannell:select>
			</div>
		</div>
		<div class="form-group showImage subtype">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="type" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<scannell:select id="IncidentType" path="type">
					<c:forEach var="type" items="${types}">
						<option value="${type.id}">
							<fmt:message key="IncidentType[${type.name}]" />
						</option>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="action" />
			</div>
		</div>

		<div class="form-group taskType">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message
					key="task.type" /></label>
			<div class="col-sm-6">
				<scannell:select id="taskType" path="taskType" cssStyle="width:100%">
					<scannell:option value="RA" label="Risk Assessment" />
					<scannell:option value="MP" label="Management Programme" />
					<scannell:option value="HT" label="Hazard/Aspect Task" />
				</scannell:select>
			</div>
		</div>

		<div class="form-group showImage">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="chooseImage" />
			</label>
			<div class="col-sm-6" id="responsible">
				<input id="content" type="file" name="picture" class="wide"
					accept="image/*" onChange="load_image(this.id,this.value,this)" />
				<div class="mandatoryFile" id="mandatoryFile">
					<span class="requiredHinted"><c:if test="${imageSizeError}">
							<fmt:message key="imageSizeErrorRA" />
						</c:if> </span>
				</div>
				<div class="image" id='imageDiv'
					style="width: 100; height: 100; ${command.id > 0 && imageEncoded != '' ? '' : 'display: none;'}">
					<c:if test="${command.id > 0 && imageEncoded != ''}">
						<img class="printImageSize matrixImageSize"
							src="data:image/jpg;base64,${imageEncoded}" alt="" border=3
							style="max-height: 200px" />
					</c:if>
				</div>
			</div>
			<scannell:errors path="picture" />
		</div>
<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="template.selectAll"/>:
			</label>
			<div class="col-sm-6" >
				<input type="checkbox" onClick="toggle(this)" />
			</div>
		</div>
		<div class="form-group" style="overflow:auto;height: auto;">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="template.sites"/>:
			</label>
			<div class="col-sm-6" >
		      	<input type="hidden" name="_activeInSites" value="xxx" />
				<spring:bind path="command.activeInSites">
						<c:forEach items="${sites}" var="site">
							<c:set var="selected" value="${false}" />
							<c:forEach items="${command.activeInSites}" var="selectedSite">
								<c:if test="${site.id == selectedSite.id}"><c:set var="selected" value="${true}" /></c:if>
							</c:forEach>
							<c:set var="enabled" value="${false}" />
							<c:forEach items="${userSites}" var="enabledSite">
								<c:if test="${site.id == enabledSite.id}"><c:set var="enabled" value="${true}" /></c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${enabled}">
									<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" <c:if test="${selected}">checked="checked"</c:if>/><span><c:out value="${site.name}" /></span><br />
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="x" <c:if test="${selected}">checked="checked"</c:if> disabled="disabled"/><span><c:out value="${site.name}" /></span><br />
									<c:if test="${selected}">
										<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" />
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
				</spring:bind>
			</div>
		</div>

		<div style="clear: both;"></div>
		<div class="spacer2 text-center">
			<input type="submit" id="form_submit" class="g-btn g-btn--primary"
				value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary"
				onclick="window.history.go(-1)">
				<fmt:message key="cancel" />
			</button>

		</div>
	</scannell:form>

</body>
</html>
