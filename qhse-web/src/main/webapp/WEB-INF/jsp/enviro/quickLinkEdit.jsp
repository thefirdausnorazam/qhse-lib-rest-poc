<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<%-- <c:set var="title" value="editTask" />
<c:if test="${command['new']}">
	<c:set var="title" value="createTask" />
</c:if> --%>
<style type="text/css">
.errorValidation {
	display: none; margin-left: 10px;
}

.error_show {
	padding: 0; list-style: none; color: #cc0000;
}

input.invalid,textarea.invalid,div.invalid,select.invalid {
	border: 1px solid #c00 !important;
}

input.valid,textarea.valid,select.valid,div.valid {
	border: 1px solid #2598f9 !important; box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
}

.addon {
	background-color: transparent; border: transparent;
}

.radioActive{
    background:grey !important;
}

</style>
<title><fmt:message key="quickLink.heading" /></title>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>

<script type="text/javascript">

	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var userCount = ${fn:length(users)};
	var maxListSize = 500;
	
	function toggle(source) {
		  checkboxes = document.getElementsByName('activeInSites');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }
		
	}
	
	jQuery(document).ready(function() {
		jQuery("select").select2({width:'90%'});

		jQuery('#module').change(function() {
			var module = jQuery('#module').find(":selected").val();
			jQuery('#url').select2('val', '');
			jQuery('#url').children().remove();
			jQuery('#url').append(jQuery('<option>', { 
		        value: "",
		        text : "<fmt:message key='choose' />" 
		    }));
			<c:forEach items="${actionOptions}" var="action">
				var thismodule = "${action.module}";
		       	if(module == thismodule) {
		              jQuery('#url').append(jQuery('<option>', { 
					        value: "${action.url}",
					        text : "${action.text}" 
					    }));
		    	}
		     </c:forEach>
		     jQuery('#url').val('');
	    });
		setValues();
		jQuery('input:radio[name=options]').change(function() {
			jQuery('.radioButton').each(function () {
				jQuery(this).removeClass("radioActive");
			});
	            jQuery('#'+this.value).addClass( "radioActive" );
	            jQuery('#symbol').val(this.value);
	    });});
	
	function setValues(){
		var symbol = '${command.symbol}';
		jQuery("#"+symbol).addClass( "radioActive" );
		jQuery('#symbol').val(symbol);
		
		var module = '${command.module}';
		jQuery('#url').val('${command.url}');
        jQuery('#module').val('${command.module}');
		jQuery('#module').change();
		jQuery('#module option[value="${command.module}"]').attr('selected',
		'selected');
        if(module){
			jQuery('#url').val('${command.url}');
        	jQuery('#url option[value="${command.url}"]').change();
        	jQuery('#url option[value="${command.url}"]').attr('selected','selected');
        }
        jQuery('#accessRight').val('${command.accessRight}');
	}
	</script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body>
	<scannell:form>
		<input type="hidden" id="row"/>
		<input type="hidden" id="col"/>
		<input type="hidden" id="type"/>
		<input type="hidden" id="symbol" name="symbol"/>
		
		<div class="form-group" >
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.label" />
			</label>
			<div class="col-sm-6">
				<scannell:input class="form-control" path="label" cssStyle="width:90%"/>
			</div>
		</div>
		<div class="form-group" >
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.hint" />
			</label>
			<div class="col-sm-6">
				<scannell:input class="form-control"  path="hint" cssStyle="width:90%"/>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.module" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<select name="module" id="module">
					<option value="general">
						<fmt:message key="generalMenu" />
					</option>
					<option value="docs">
						<fmt:message key="docsMenu" />
					</option>
					<c:forEach var="module" items="${moduleList}">
						<c:if test="${module.code != 'admin' && module.code != 'law'}">
							<option value="${module.code}">
								<fmt:message key="${module.code}Menu" />
							</option>
						</c:if>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="module"/>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.activity" />
			</label>
			<div class="col-sm-6" style="display: flex;">
				<select name="url" id="url">
					<c:forEach var="action" items="${actionOptions}">
 						<option value="${action.url}" >
 						 	<c:out value="${action.text}" />
 						</option>
					</c:forEach>
				</scannell:select>
				<scannell:errors path="url"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.colour" />
			</label>
			<div class="col-sm-6" >
				<select name="bgcolour" >
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Red')}" >selected</c:if> value="red"><fmt:message key="redIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Orange')}" >selected</c:if> value="orange"><fmt:message key="orangeIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Blue')}" >selected</c:if> value="blue"><fmt:message key="blueIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Green')}" >selected</c:if> value="green"><fmt:message key="greenIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Purple')}" >selected</c:if> value="purple"><fmt:message key="purpleIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Plum')}" >selected</c:if> value="plum"><fmt:message key="plumIcon" /></option>
					<option <c:if test="${fn:toLowerCase(command.bgcolour) == fn:toLowerCase('Cyan')}" >selected</c:if> value="cyan"><fmt:message key="cyanIcon" /></option>
				</scannell:select>
				<scannell:errors path="bgcolour"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="quickLink.symbol" />
			</label>
			<div class="col-sm-6" >
				<div class="btn-group radio-btns-wrapper" data-toggle="buttons" style="float:left;width:90%">
					  <label class="btn btn-primary radioButton" id="pencil">
					    <input type="radio" name="options" autocomplete="off" value="pencil"> <span  class="fa fa-pencil unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="home">
					    <input type="radio" name="options" autocomplete="off" value="home"> <span  class="fa fa-home unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="flag">
					    <input type="radio" name="options" autocomplete="off" value="flag"> <span  class="fa fa-flag unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="user">
					    <input type="radio" name="options" autocomplete="off" value="user"> <span  class="fa fa-user unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="comment">
					    <input type="radio" name="options" autocomplete="off" value="comment"> <span  class="fa fa-comment unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="comments">
					    <input type="radio" name="options" autocomplete="off" value="comments"> <span  class="fa fa-comments unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="comment-o">
					    <input type="radio" name="options" autocomplete="off" value="comment-o"> <span  class="fa fa-comment-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="comments-o">
					    <input type="radio" name="options" autocomplete="off" value="comments-o"> <span  class="fa fa-comments-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="file">
					    <input type="radio" name="options" autocomplete="off" value="file"> <span  class="fa fa-file unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="file-o">
					    <input type="radio" name="options" autocomplete="off" value="files-o"> <span  class="fa fa-files-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="file-excel-o">
					    <input type="radio" name="options" autocomplete="off" value="file-excel-o"> <span  class="fa fa-file-excel-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="file-pdf-o">
					    <input type="radio" name="options" autocomplete="off" value="file-pdf-o"> <span  class="fa fa-file-pdf-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="file-image-o">
					    <input type="radio" name="options" autocomplete="off" value="file-image-o"> <span  class="fa fa-file-image-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="tag">
					    <input type="radio" name="options" autocomplete="off" value="tag"> <span  class="fa fa-tag unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bell">
					    <input type="radio" name="options" autocomplete="off" value="bell"> <span  class="fa fa-bell unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bookmark">
					    <input type="radio" name="options" autocomplete="off" value="bookmark"> <span  class="fa fa-bookmark unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="star">
					    <input type="radio" name="options" autocomplete="off" value="star"> <span  class="fa fa-star unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="plus">
					    <input type="radio" name="options" autocomplete="off" value="plus"> <span  class="fa fa-plus unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="asterisk">
					    <input type="radio" name="options" autocomplete="off" value="asterisk"> <span  class="fa fa-asterisk unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="thermometer-quarter">
					    <input type="radio" name="options" autocomplete="off" value="thermometer-quarter"> <span  class="fa fa-thermometer-quarter unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="thermometer-4">
					    <input type="radio" name="options" autocomplete="off" value="thermometer-4"> <span  class="fa fa-thermometer-4 unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="warning">
					    <input type="radio" name="options" autocomplete="off" value="warning"> <span  class="fa fa-warning unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="calendar">
					    <input type="radio" name="options" autocomplete="off" value="calendar"> <span  class="fa fa-calendar unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="folder-open">
					    <input type="radio" name="options" autocomplete="off" value="folder-open"> <span  class="fa fa-folder-open unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="thumbs-up">
					    <input type="radio" name="options" autocomplete="off" value="thumbs-up"> <span  class="fa fa-thumbs-up unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="dashboard">
					    <input type="radio" name="options" autocomplete="off" value="dashboard"> <span  class="fa fa-dashboard unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="wrench">
					    <input type="radio" name="options" autocomplete="off" value="wrench"> <span  class="fa fa-wrench unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="medkit">
					    <input type="radio" name="options" autocomplete="off" value="medkit"> <span  class="fa fa-medkit unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="heartbeat">
					    <input type="radio" name="options" autocomplete="off" value="heartbeat"> <span  class="fa fa-heartbeat unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="plus-square">
					    <input type="radio" name="options" autocomplete="off" value="plus-square"> <span  class="fa fa-plus-square unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="floppy-saved">
					    <input type="radio" name="options" autocomplete="off" value="edit"> <span  class="fa fa-edit unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bookmark-o">
					    <input type="radio" name="options" autocomplete="off" value="bookmark-o"> <span  class="fa fa-bookmark-o unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bug">
					    <input type="radio" name="options" autocomplete="off" value="bug"> <span  class="fa fa-bug unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bullhorn">
					    <input type="radio" name="options" autocomplete="off" value="bullhorn"> <span  class="fa fa-bullhorn unchecked"></span>
					  </label>
					  <label class="btn btn-primary radioButton" id="bullseye">
					    <input type="radio" name="options" autocomplete="off" value="bullseye"> <span  class="fa fa-bullseye unchecked"></span>
					  </label>
					<scannell:errors path="symbol"/>
				</div>
			</div>
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
		<br/><br/><br/>
		<div class="spacer2 text-center">
			<input type="submit" id="form_submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>

		</div>
	</scannell:form>

</body>
</html>
