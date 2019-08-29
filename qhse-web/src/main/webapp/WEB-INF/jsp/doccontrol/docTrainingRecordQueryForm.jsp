<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<!--<meta name="printable" content="true">-->
	<title></title>
<style type="text/css">
			@import "<c:url value='/css/doccontrol.css'/>";
</style>
</head>

 <script type="text/javascript"> 
 	var emptyMessage = '<fmt:message key="choose"/>';
	var enterChars = '<fmt:message key="select2.enterChars"/>';
 	
 jQuery(document).ready(function () {	
	 
	 //Submit form with document selected so can get versions
	 jQuery("#documentId").change(function() {
		 var selectedDoc = jQuery("#documentId").val();
		 if(selectedDoc > 0) {
			 jQuery("#selectDoc").hide();
			 jQuery("#submitButton").attr("disabled", false);
			 jQuery.ajax({
				  url: 'versionListForDocument.json',
				  type: 'GET',
			      data: { 'docId' : selectedDoc},
				  success: function(returnData) {
					helpers.buildDropdown(
			                    returnData,
			                    jQuery('#version')
			        );
					selectLatestVersion();
				  }
				});
		 }
		 else {
			 disableSubmit();
		 }
	 });
	 jQuery('#notAck').change(function() {
	        if(jQuery(this).is(":checked")) {
	 			jQuery('.doNotShowForNotAck').hide();
	        }
	        else {
				jQuery('.doNotShowForNotAck').show();
	        }
	 });
	 
	 restoreSearchCriteria();
	 
	 if(!jQuery("#recordDateFrom").val()) {
		var today = new Date();
	  	var yyyy = today.getFullYear();
	 	var fromFinaDate= '01'+'-'+"Jan"+'-'+yyyy;	
	  	jQuery("#recordDateFrom").val(fromFinaDate);
	 }
	 selectLatestVersion();
	 if(jQuery("#accepted").val() == null) {
	 	jQuery('#accepted').val("false");
	 }
	 
	 jQuery('#queryForm').submit();
	 //jQuery('#user').select2({width:'70%'});
	 setUpUsers();
	 jQuery('#version').select2({width:'70%'});
	 jQuery('#accepted').select2({width:'70%'});
	 jQuery('#department').select2({width:'70%'});
	 jQuery('#docdepartment').select2({width:'70%'});
	 jQuery('#documentId').select2({width:'70%'});
	 jQuery('#sortName').select2({width:'70%'});
	 
	 //Disable sumbit button if nothing selected & show warning if from search page
	 disableSubmit();
	 displayQueryDiv(false);
	});

 	//Disable sumbit button if nothing selected & show warning if from search page
 	function disableSubmit() {
 		 //Do not allow user to search if no document selected
 		  if(jQuery("#documentId").length > 0 && !jQuery("#documentId").val() > 0) {
 			 jQuery("#selectDoc").show();
 			 jQuery("#submitButton").attr("disabled", true);
 			// Remove version options
  	         jQuery("#version").html('');
  	        // Add the empty option with the empty message
  	        jQuery("#version").append('<option value="">' + emptyMessage + '</option>');
 			jQuery('#version').trigger('change');  
 		 }
 		  else {
  			 jQuery("#selectDoc").hide();
 		  }
	 }
 	
 	//By default select latest document version
 	function selectLatestVersion() {
 		if(!jQuery("#version").val()) {
 			jQuery('#version option:eq(1)').attr("selected", "selected");
 			jQuery('#version').trigger('change');  
 		 }
 	}

	function restoreSearchCriteria() {
		if('${generalSearch}' == 'true') {
			jQuery("#version").val(
			'${sessionScope["generalSearch.docTrainee.version"]}');
			jQuery("#user").val(
					'${sessionScope["generalSearch.docTrainee.user"]}');
			jQuery("#department").val(
					'${sessionScope["generalSearch.docTrainee.department"]}');
			jQuery("#docdepartment").val(
			'${sessionScope["generalSearch.docTrainee.docdepartment"]}');
			jQuery("#version").val(
				'${sessionScope["generalSearch.docTrainee.version"]}').attr("selected", "selected");
			jQuery("#accepted").val(
				'${sessionScope["generalSearch.docTrainee.accepted"]}');
			jQuery("#documentId").val(
			'${sessionScope["generalSearch.docTrainee.documentId"]}');
			jQuery('#notAck').attr('checked', '${sessionScope["generalSearch.docTrainee.notAck"]}');
		}
		else {
			jQuery("#version").val(
					'${sessionScope["docTrainee.version"]}');
			jQuery("#user").val(
					'${sessionScope["docTrainee.user"]}');
			jQuery("#department").val(
					'${sessionScope["docTrainee.department"]}');
			jQuery("#docdepartment").val(
			'${sessionScope["docTrainee.docdepartment"]}');
			jQuery("#version").val(
				'${sessionScope["docTrainee.version"]}').change();
			jQuery("#accepted").val(
				'${sessionScope["docTrainee.accepted"]}');
			jQuery('#notAck').attr('checked', '${sessionScope["docTrainee.notAck"]}' == 'true' ? true : false);
		}
		jQuery('#notAck').trigger("change");
		jQuery("#documentId").trigger('change'); 

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
	    var inputs = form.getElementsByTagName('input');
	    for (var i = 0; i<inputs.length; i++) {
	        switch (inputs[i].type) {
	          case 'text':
	                inputs[i].value = '';
	                break;
	        }
		}
	 jQuery("#documentId").select2('val', jQuery('#documentId option:eq(0)').val());
	 jQuery("#user").select2('val', jQuery('#user option:eq(0)').val());
	 jQuery("#version").select2('val', jQuery('#version option:eq(0)').val());
	 jQuery("#accepted").select2('val', jQuery('#accepted option:eq(0)').val());
	 jQuery("#department").select2('val', jQuery('#department option:eq(0)').val());
	 jQuery("#docdepartment").select2('val', jQuery('#docdepartment option:eq(0)').val());
	 jQuery("#sortName").select2('val', jQuery('#sortName option:eq(0)').val());
	 jQuery('#notAck').attr('checked', false);
	 jQuery('#notAck').trigger("change");
	 jQuery("#documentId").trigger('change'); 
 }
 	var helpers =
 	{
 	    buildDropdown: function(result, dropdown)
 	    {
 	        // Remove current options
 	        dropdown.html('');
 	        // Add the empty option with the empty message
 	        dropdown.append('<option value="">' + emptyMessage + '</option>');
 	        // Check result isnt empty
 	        if(result != '')
 	        {
 	            // Loop through each of the results and append the option to the dropdown
 	            jQuery.each(result, function(k, v) {
 	                dropdown.append('<option value="' + v + '">' + v + '</option>');
 	            });
 	        }
 	    }
 	}
 	
	function setUpUsers() {
		jQuery('#user').select2({				  
			  width:'70%',
			  minimumInputLength : 3,
			  placeholder :  enterChars,
			  escapeMarkup: function(m) {
			        // Do not escape HTML in the select options text
			        return m;
			     },
			  ajax: {
			        url: "userList.json",
			        dataType: 'json',
			        type: "GET",
			        quietMillis: 100,
			        data: function (term) {
			            return {
			                term: term, docGroup : jQuery('#docGroup').val()
			            };
			        },
			        results: function (data) {
			            return {
			                results: $.map(data, function (item) {
			                    return {
			                        text: item.userName,	
			                        slug: item.slug,
			                        id: item.id
			                    }
			                })
			            };
			        }
			    },
			    initSelection: function (element, callback) {				    	
					var data = [];
				    callback(data); 
				},

			      // NOT NEEDED: These are just css for the demo data
			      dropdownCssClass : 'capitalize',
			      containerCssClass: 'capitalize',
			      // configure as multiple select
			      multiple         : false,
			      // NOT NEEDED: text for loading more results
			      formatLoadMore   : 'Loading more...',	
			      cache: true,
			});
	}
 </script>
<body>
<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;<fmt:message key="search.hideSearch" />
							<fmt:message key="search.displaySearch" />
					</button>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
</div>
					
				</div>
			</div>
    	</div>
	</div>

<scannell:form id="queryForm" action="/doccontrol/docTrainingRecordQuery.htmf" onsubmit="return search(this, 'resultsDiv');">
	<input type="hidden" id="calculateTotals" name="calculateTotals" value="true">
	<scannell:hidden path="pageNumber" />
	<scannell:hidden path="pageSize" />
	<scannell:hidden path="generalSearch"/>
	<input type="hidden" id="docGroup" name="docGroup" value="${docGroup}" />
		
	<div id="queryDiv">
		<div class="header">
			<h3><fmt:message key="searchCriteria" /></h3>
		</div>	
		<div id="selectDoc" style="color: red; font-weight: bold">* <fmt:message key="doccontrol.selectDocuments"/></div>	
		<c:choose>
			<c:when test="${generalSearch}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="docControl.document" /></label>
					<div class="col-sm-6">
						<select name="documentId" id="documentId" items="${documents}" itemValue="id" itemLabel="name" class="wide"/>
						<span class="requiredHinted">*</span>
					</div>				
				</div>
			</c:when>
			<c:otherwise>
				<scannell:hidden id="docId" path="documentId"/>
			</c:otherwise>
		</c:choose>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="doccontrol.recordUser" /></label>
			<div class="col-sm-6">
				<%-- <select name="user" id="user" items="${users}" itemValue="id" itemLabel="sortableName" class="wide" /> --%>
				<input type="hidden" id="user" class="wide" name="user" />
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="doccontrol.documentDepartment" /></label>
			<div class="col-sm-6">																
				<select name="docdepartment" id="docdepartment" items="${departments}" itemValue="id" itemLabel="name" class="wide" />
			</div>
		</div>	
		<div style="clear: both;"></div>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="doccontrol.userDepartment" /></label>
			<div class="col-sm-6">																
				<select name="department" id="department" items="${departments}" itemValue="id" itemLabel="name" class="wide" />
			</div>
		</div>	
		<div style="clear: both;"></div>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="doccontrol.version.label" /></label>
			<div class="col-sm-6">	
				<c:choose> 	
					<c:when test="${empty versions}">														
						<select name="version" id="version" class="wide" renderEmptyOption="true"/>
					</c:when>
					<c:otherwise>
						<select name="version" id="version" items="${versions}" class="wide" renderEmptyOption="true"/>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.trainee.accept" />:</label>
			<div class="col-sm-6">
				 <select id="accepted" name="accepted" style="width: 100%;">
					<option value="false" selected="selected"><fmt:message key="false" /></option>
					<option value="true"><fmt:message key="true" /></option>
				</select>
			</div>
		</div> --%>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.recordDate" /> <fmt:message key="from" /></label>
			<div class="col-sm-6">
                 <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                      <input class="form-control" size="16" id="recordDateFrom" name="recordDateFrom" type="text"  readonly>
                      <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
			</div>
		</div>
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.recordDate" /> <fmt:message key="to" /></label>
			<div class="col-sm-6">
				<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                      <input class="form-control" size="16" id="recordDateTo" name="recordDateTo" type="text"  readonly>
                      <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.notAck" /></label>
			<div class="col-sm-6">
				<scannell:checkbox  path="notAck" id="notAck" value="false"/>
			</div>
		</div>
		
		<div class="form-group doNotShowForNotAck">
			<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
			<div class="col-sm-6">
				 <scannell:select id="sortName" path="sortName" items="${sorts}" lookupItemLabel="true" renderEmptyOption="true" class="wide" />
			</div>
		</div>
		<div class="spacer2 text-center">
			<button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);">
				<fmt:message key="search" />
			</button>
			<button type="button" class="g-btn g-btn--secondary" onClick="hardResetForm(this.form);">
				<fmt:message key="reset" />
			</button>
		</div>
	</div>
	<div id="resultsDiv"></div>

</scannell:form>

</body>
</html>
