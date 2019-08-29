<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="javascript" src="<c:url value="/js/utils.js" />"></script>
<style type="text/css" media="all">
	@import "<c:url value='/css/doccontrol.css'/>";
</style>
<script>
	jQuery(document).ready(function() {		
		restoreSearchCriteria();
		displayQueryDiv(false);
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({width:'100%'});
	});
	
	function restoreSearchCriteria() {
		jQuery("#departmentId").val('${sessionScope["distDocumentSearch.departmentId"]}');
		jQuery('#approverId').val('${sessionScope["distDocumentSearch.approverId"]}');
		jQuery('#reviewerId').val('${sessionScope["distDocumentSearch.reviewerId"]}');
		jQuery('#docGroupId').val('${sessionScope["distDocumentSearch.docGroupId"]}');
		jQuery('#activeSite').val('${sessionScope["distDocumentSearch.activeSite"]}');
		jQuery('#sortName').val('${sessionScope["distDocumentSearch.sortName"]}');
	}
	
	function hardResetForm(form) {
	    var inputs = form.getElementsByTagName('input');
	    for (var i = 0; i<inputs.length; i++) {
	        switch (inputs[i].type) {
	          case 'text':
	                inputs[i].value = '';
	                break;
	        }
		}
		jQuery('#departmentId').select2('val', '');
    	jQuery('#departmentId option[value=""]').attr('selected','selected');
		jQuery('#approverId').select2('val', '');
    	jQuery('#approverId option[value=""]').attr('selected','selected');
		jQuery('#reviewerId').select2('val', '');
    	jQuery('#reviewerId option[value=""]').attr('selected','selected');
		jQuery('#docGroupId').select2('val', '');
    	jQuery('#docGroupId option[value=""]').attr('selected','selected');
		jQuery('#activeSite').select2('val', '');
    	jQuery('#activeSite option[value=""]').attr('selected','selected');
		jQuery('#sortName').select2('val', '');
    	jQuery('#sortName option[value=""]').attr('selected','selected');
	}

</script>

</head>
<body >

	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
						<input type="text" id="refreshCheck" value="no"
							style="display: none;">
						<form id="goToForm" action="<c:url value="/doccontrol/documentView.htm" />" method="get"	onSubmit="if(!jQuery('#gotoId')) return false;">
							<input type="hidden" name="page" value="audit"/>
							<fmt:message key="doccontrol.documentSearchForm.goTo" />
							<input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;<fmt:message key="search.hideSearch" /></button>
							<c:if test="${addButtonEnabled == true }">
								<button type="button" class="g-btn g-btn--primary" onclick="location.href='documentEdit.htm'">
									<i class="fa fa-edit" style="color: white"></i>
									<fmt:message key="docControl.addDocument" />
								</button>
							</c:if>
							<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print printcolor" style="color:white"></i><span class="printcolor"></span></button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
		<scannell:form id="queryForm" action="/doccontrol/distributedDocuments.htmf" onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" id="calculateTotals" name="calculateTotals" value="true">
			<scannell:hidden path="pageNumber" />
			<scannell:hidden path="pageSize" />
			
			<input type="hidden" name="docType" id="docType" value="" />
			<div class="content" id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.docGroupSearchForm.name" />:</label>
					<div class="col-sm-6">
						 <input name="name" id="name" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="description" />:</label>
					<div class="col-sm-6">
						 <input name="description" id="description" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="department" />:</label>
					<div class="col-sm-6">
						 <select name="departmentId" id="departmentId" items="${departments}" itemValue="id" itemLabel="name" class="wide" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.approver.label" />:</label>
					<div class="col-sm-6">
						 <select name="approverId" id="approverId" items="${approvers}" itemValue="id" itemLabel="sortableName" class="wide" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap" id="reviewerLabel"><fmt:message key="changeAssessment.reviewer" /> :</label>
					<div class="col-sm-6">
						<scannell:select id="reviewerId" path="reviewerId" items="${reviewers}" itemValue="id" itemLabel="sortableName" class="wide" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.docGroup.label" />:</label>
					<div class="col-sm-6">
						 <select name="docGroupId" id="docGroupId" items="${docGroups}" itemValue="id" itemLabel="displayName" class="wide" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="template.sites" />:</label>
					<div class="col-sm-6">
						<scannell:select id="activeSite" path="activeInSiteId" lookupItemLabel="true" class="wide" renderEmptyOption="true" items="${siteList}" itemValue="id"/>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
					<div class="col-sm-6">
						 <scannell:select id="sortName" path="sortName" items="${sorts}" lookupItemLabel="true" renderEmptyOption="true" class="wide" />
					</div>
				</div>


				<div class="spacer2 text-center">
					<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);">
						<fmt:message key="search" />
					</button>
					<button id="resetAll" type="button" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);">
						<fmt:message key="reset" />
					</button>
				</div>


			</div>
			<div id="resultsDiv"></div>
		</scannell:form>
	
</body>
</html>

