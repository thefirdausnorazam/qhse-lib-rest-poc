<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<!-- 	<meta name="printable" content="true"> -->
	<title></title>
	<script type="text/javascript">
    jQuery(document).ready(function() {		
    	jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		jQuery('#queryForm').submit();
		jQuery('#sortName').select2({width:'100%'});
		jQuery('#active').select2({width:'100%'});
		
		toggleQueryTable();

	 });	
    
    function hardResetForm(form) {
	    var inputs = form.getElementsByTagName('input');
	    for (var i = 0; i<inputs.length; i++) {
	        switch (inputs[i].type) {
	          case 'text':
	                inputs[i].value = '';
	                break;
	        }
	    }
		jQuery('#sortName').select2({width:'100%'}).select2('val', $('#sortName option:eq(0)').val());
		jQuery('#active').select2({width:'100%'}).select2('val', jQuery('#active option:eq(0)').val());
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
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		     <form action="<c:url value="/audit/thirdPartyView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
			    Go to Third Party Auditee
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Hide Search</button>
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='thirdPartyEdit.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;New Third Party Auditee</button>
					</c:if>
				<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>

<div id="block" class="block" >
  
<div class="content">

<scannell:form id="queryForm" action="/audit/thirdPartyQuery.htmf" onsubmit="return search(this, 'resultsDiv');">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<div id="queryTable">
		<div id ="queryTableTitle" class="header">
			<h3 ><fmt:message key="searchCriteria" /></h3>
		</div>

                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="thirdPartyName" /></label>
									<div class="col-sm-6">
										<input name="name" id="name" class="form-control" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="active" /></label>
									<div class="col-sm-6">	
										<select name="active" id="active" class="narrow">
											<option value="true" selected="selected"><fmt:message key="true"/></option>
											<option value="false"><fmt:message key="false" /></option>
										</select>
									</div>
								</div>
								
								 <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="company" /></label>
									<div class="col-sm-6">
										<scannell:input id="company" path="company" class="form-control" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="address" /></label>
									<div class="col-sm-6">
										<input name="address" id="address" class="form-control" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">
										 <scannell:select id="sortName" path="sortName" items="${sorts}" lookupItemLabel="true" renderEmptyOption="true" class="wide" />
									</div>
								</div>

                              <div class="spacer2 text-center">
			                     <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryTable(false);trimDescription();"><fmt:message key="search" /></button>
			                     <button type="reset" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);"><fmt:message key="reset" /></button>
			                  </div>
     


</div>

<div id="resultsDiv"></div>

</scannell:form>
</div>
</div>
</body>
</html>
