<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags" %>


<html>
<head>
  <title></title>

<script type="text/javascript">
	jQuery(document).ready(function() {	
		jQuery('select').select2({        
            placeholder: "Choose",
            alowClear:true});
	});
	function onPageSubmit(aForm) {
		if(jQuery("#activeInSites").val() == null) {
			jQuery("#activeInSites").append( new Option("","",false,true) );
		}
	}
</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="dependsOnOptionConfigure"/></h2>
</div>
<scannell:form onsubmit="onPageSubmit(this);">
  <scannell:hidden path="version"/>

<div class="content">
<div class="table-responsive">
<div class="panel">
	<div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="question" /></label>
		<div class="col-sm-6"><input name="option.question.name" class="form-control" cssStyle="width:90%;display: inline-block;" disabled="true"/></div>
	</div>
	<div style="clear: both;"></div>
	<div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="optionDisplayName" /></label>
		<div class="col-sm-6"><input name="option.name" class="form-control" cssStyle="width:90%;display: inline-block;" disabled="true"/></div>
	</div>
	<div style="clear: both;"></div>
	<div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="dependsOnOptions" /></label>
		<div class="col-sm-6">
			<input name="dependsOnOption.name" class="form-control" cssStyle="width:90%;display: inline-block;" disabled="true"/>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="InActiveInSite" /></label>
		<div class="col-sm-6">
			<select name="inactiveInSites" id="activeInSites"
										cssStyle="width:90%" size="2" multiple="true" renderEmptyOption="false" itemValue="id" itemLabel="name" items="${sites}"/>
		</div>
	</div>	
	
	<div class="spacer2 text-center">
		<input class="g-btn g-btn--primary" type="submit"
				value="<fmt:message key="submit" />">
	</div>					      	 		
</div>
</div>
</div>
</scannell:form>

</body>
</html>
