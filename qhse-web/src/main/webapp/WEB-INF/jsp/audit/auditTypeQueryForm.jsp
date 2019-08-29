<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<!-- 	<meta name="printable" content="true"> -->
<title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
<script type="text/javascript">

	jQuery(document).ready(function() {
		jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		jQuery('#businessAreaId').select2({width:'100%'});
		jQuery('#completed').select2({
			width : '100%'
		});
		jQuery('#ownerId').select2({
			width : '100%'
		});
		jQuery('#programmeStatus').select2({
			width : '100%'
		});
		if('${quickLink}' != '') {
			 	hardResetForm(document.getElementById('queryForm'));
				if('${selectedStatus}' != '') {
					jQuery('#programmeStatus').val('${selectedStatus}');
					jQuery('#programmeStatus option[value="${selectedStatus}"]').change();
				}
		 }
		jQuery('#queryForm').submit();
		
	});
</script>


<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript">
	/* function toggleQueryTable() {
		$('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
		$('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
	} */

	function hardResetForm(form) {
		jQuery('#completed').select2('val', '');
		jQuery('#ownerId').select2('val', '');
		jQuery('#programmeStatus').select2('val', '');
		jQuery('#businessAreaId').select2('val', '');
	}
	
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/audit/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/programmeQuery.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/programmeQuery.htmf');
	}
	
	function trimDescription(){
		jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  	}
</script>

</head>
<body>
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;"></div>
				<div>
					<div class="col-md-12 col-sm-12">
						<div align="right">
							<form id="goToForm" action="<c:url value="/audit/auditTypeView..htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
							 <input type="hidden" name="page" value="programme"/>
							    <c:if test="${showLegacyId}">
							    <label>Legacy ID</label> 
		                        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
								</c:if>
								<fmt:message key="audit.inspectionQueryForm.goTo" />
								<input type="text" id="gotoId" name="id" size="3">
								<input type="submit" class="g-btn g-btn--primary" value="Go">
								<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Hide Search</button>
								<c:if test="${addButtonEnabled == true }">
									<button type="button" class="g-btn g-btn--primary" onclick="location.href='auditTypeEdit.htm'">
										<i class="fa fa-edit" style="color: white"></i>&nbsp;<fmt:message key="newInspectionTemplate" />
									</button>
								</c:if>
								<button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary">
									<i class="fa fa-print" style="color: white"></i>
									<span></span>
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
	</div>
	<div id="block" class="block">



		<scannell:form id="queryForm" action="/audit/auditTypeQueryResult.htmf" onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" id="pageSize" name="pageSize" />
			<div class="content" id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>		
                <div class="form-group" style="display:none">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="codeName" /></label>
					<div class="col-sm-6">
						 <input name="codeName" id="codeName"   />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel">
						<fmt:message key="name" />
					</label>
					<div class="col-sm-6">
						 <input name="name" id="name"  class=" form-control" />
					</div>
				</div>
				
				
				<div class="spacer2 text-center">
					<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;toggleQueryTable();trimDescription();">
						<fmt:message key="search" />
					</button>
					<button type="reset" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);">
						<fmt:message key="reset" />
					</button>
				</div>
				
			</div>
			<div id="resultsDiv"></div>
		</scannell:form>




	</div>
	<script type="text/javascript">
		toggleQueryTable();
	</script>
</body>
</html>
