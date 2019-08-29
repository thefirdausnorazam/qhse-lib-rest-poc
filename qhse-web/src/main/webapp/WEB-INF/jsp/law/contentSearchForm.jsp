<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
  
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<c:url value="/js/jquery.validate.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>

<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
<script type="text/javascript">
var enterChars = '<fmt:message key="select2.enterKeywordChars"/>';
var enterSearchText = '<fmt:message key="lawSearch.enterSearchText"/>';
var allPublications = '<fmt:message key="searchTheLatestVersion"/>';
jQuery(document).ready(function() {
	jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
	jQuery('select').not("#keywordSearch").select2();	

	jQuery('#keywordSearch').select2({				  
	  width:'100%',
	  allowClear: true,
	  minimumInputLength : 3,
	  placeholder :  enterChars,
	  escapeMarkup: function(m) {
	        // Do not escape HTML in the select options text
	        return m;
	     },
	  ajax: {
	        url: "keywordSearchList.json",
	        dataType: 'json',
	        type: "GET",
	        quietMillis: 100,
	        data: function (term) {
	            return {
	                term: term
	            };
	        },
	        results: function (data) {
	            return {
	                results: $.map(data, function (item) {
	                    return {
	                        text: item.keyword,	
	                        slug: item.slug,
	                        id: item.id
	                    }
	                })
	            };
	        }
	    },
	    initSelection: function (element, callback) {	
	    	var data;
	    	if("<c:out value='${command.keywordSearch}'/>" != 0) {
	    		data = {id: "<c:out value='${command.keywordSearch}'/>", text: "<c:out value='${command.keywordSearchName}'/>"};
	    	}
	    	else {
	    		data = {id: 0, text: enterChars};
	    	}
		    callback(data);
		},

	      // NOT NEEDED: These are just css for the demo data
	      dropdownCssClass : 'capitalize',
	      containerCssClass: 'capitalize',

	      // configure as multiple select
	      multiple         : false,

	      // NOT NEEDED: text for loading more results
	      formatLoadMore   : 'Loading more...',				      
	      // query with pagination	
	      cache: true
			
	});
	jQuery("#queryForm").validate({
	    rules: {
	    	searchString: {
	            required: true,
	            minlength: 1
	        }
	    },
	    messages: {
	    	searchString: {
	            required: enterSearchText
	        }
	    },
	    invalidHandler: function(event, validator) {
	        displayQueryDiv(true);
	      }
	});
	jQuery("#queryForm").get()[0].onsubmit();
	if (jQuery("#queryForm").valid() ) {
		toggleQueryDiv();
	}
	jQuery('#searchSynopsis').attr('checked', 'checked');
	jQuery('#searchChecklists').attr('checked', 'checked');
	jQuery('#searchRelevance').attr('checked', 'checked');
	jQuery('#searchEvaluationOfCompliance').attr('checked', 'checked');
	jQuery("#keywordSearch").change(function() {
	  	var val = jQuery("#keywordSearch").val();
	  	if(val == "" || val == "0") {
	  		showAllOptions();
	  		jQuery("#clearMesg").hide();
	  	}
	  	else {
	  		hideAllOptions();
	  		jQuery("#clearMesg").show();
	  	}
   	});
  	jQuery("#keywordSearch").change();
  	jQuery("#currentProfile").change(function() {
	  	var val = jQuery("#currentProfile :selected").text();
	  	if(val == allPublications) {
	  		disableOptions();
	  		jQuery("#keywordSearchDiv").show().focus();
  			jQuery("#keywordSearch").change();
	  	}
	  	else {
	  		enabledOptions();
	  		jQuery('.nonKeyword').show();
	  		jQuery("#keywordSearchDiv").hide();
	  		jQuery('#keywordSearch').val('');
	  	}
   	});
  	jQuery("#currentProfile").change();
  	
  	jQuery('#searchString').show().focus();
  	
  	jQuery(':checkbox[readonly]').click(function(){
  		if(jQuery('#searchSynopsis').prop('readonly')) {
  	        return false;
  		}
    });
});

function clearForm() {	
	  var elem = document.getElementById('queryForm').elements;
	  for(var i = 0; i < elem.length; i++){
	  	  	var type = elem[i].type, tag = elem[i].tagName.toLowerCase();
			if (type == 'text' || tag == 'textarea')
				elem[i].value = '';
		}
	  
	  jQuery('#legislationType').select2('val', jQuery('#legislationType option:eq(0)').val());
	  jQuery('#category').select2('val', jQuery('#category option:eq(0)').val());
	  jQuery('#region').select2('val', jQuery('#region option:eq(0)').val());
	  jQuery('#exactSearch').prop('checked', false);
	  jQuery("#currentProfile option:last").prop('selected', true).trigger('change');
	  jQuery('#sort').select2('val', 'NAME');
	  jQuery('#keywordSearch').val('').change();
	  clearPageAttributes();
	
}
function setHiddenValues(hideForm){
	if (jQuery("#searchString").valid() ) {
		jQuery('#searchSynopsis2').val(jQuery('#searchSynopsis').prop('checked'));
		jQuery('#searchChecklists2').val(jQuery('#searchChecklists').prop('checked'));
		jQuery('#searchRelevance2').val(jQuery('#searchRelevance').prop('checked'));
		jQuery('#searchEvaluationOfCompliance2').val(jQuery('#searchEvaluationOfCompliance').prop('checked'));
		displayQueryDiv(hideForm);
	}
	else {
		jQuery("#currentProfile").show().focus();
		jQuery("#searchString").show().focus();
		return false;
	}
	var value = jQuery("#keywordSearch").parent().find('span.select2-chosen').text();
  	jQuery('#keywordSearchName').val(value);
}
function disableOptions(){
	jQuery('#searchSynopsis').prop('checked', true);
	jQuery('#searchChecklists').prop('checked', false);
	jQuery('#searchRelevance').prop('checked', false);
	jQuery('#searchEvaluationOfCompliance').prop('checked', false);
	jQuery("#searchSynopsis").prop("readonly",true);
	jQuery('#searchChecklists').prop('disabled', true);
	jQuery('#searchRelevance').prop('disabled', true);
	jQuery('#searchEvaluationOfCompliance').prop('disabled', true);
	jQuery("#keywordSearchDiv").show().focus();
}

function hideAllOptions(){
	jQuery('.nonKeyword').hide();
	jQuery("#keywordSearchDiv").show().focus();
}

function showAllOptions(){
	jQuery('.nonKeyword').show();
	jQuery("#keywordSearchDiv").show().focus();
}

function enabledOptions(){
	jQuery('#searchSynopsis').prop('readonly', false);
	jQuery('#searchChecklists').prop('disabled', false);
	jQuery('#searchRelevance').prop('disabled', false);
	jQuery('#searchEvaluationOfCompliance').prop('disabled', false);
	jQuery("#keywordSearchDiv").hide();
}

function clearPageAttributes() {
	var defaultSize = '${defaultPageSize}';
	jQuery('#pageNumberCheck').val(1);
	jQuery('#pageSizeCheck').val(defaultSize);
	jQuery('#pageNumberRel').val(1);
	jQuery('#pageSizeRel').val(defaultSize);
	jQuery('#pageNumberLeg').val(1);
	jQuery('#pageSizeLeg').val(defaultSize);
	jQuery('#pageNumberKey').val(1);
	jQuery('#pageSizeKey').val(defaultSize);
	jQuery('#anchor').val('');
}

function trimText(){
	jQuery("#searchString").val(jQuery.trim(jQuery("#searchString").val()));
}
</script>
<title></title>


<style type="text/css">
.error{
	color: red;
}
</style>


</head>
<body>
<div class="col-md-12">
		<div id="block" >
			<div>
				<div class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form action="<c:url value="/risk/objectiveView.htm" />" method="get"
						onSubmit="if(!jQuery('#gotoId')) return false;">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;<fmt:message key="search.hideSearch" /></button>
						
						<button  type="button" onclick="window.open(jQuery('#printParam').val()+'&print2=true', '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
					</div>
					
				</div>
			</div>
    	</div>
	</div>
<div style="visibility: hidden;">
<c:forEach items="${regions}" var="region">
  <img src="<c:url value="/legal/images/${region.id}.gif" />" />
</c:forEach>
</div>

	<div class="content">
		<scannell:form id="queryForm" action="/law/contentSearchResult.htmf" onsubmit="return search(this, 'resultsDiv');">
			<scannell:hidden path="calculateTotals"/>
			<scannell:hidden path="pageNumber"/>
			<scannell:hidden path="pageSize" />
			<scannell:hidden id="pageNumberCheck" path="pageNumberCheck"/>
			<scannell:hidden id="pageSizeCheck" path="pageSizeCheck" />
			<scannell:hidden id="pageNumberRel" path="pageNumberRel"/>
			<scannell:hidden id="pageSizeRel" path="pageSizeRel" />
			<scannell:hidden id="pageNumberLeg" path="pageNumberLeg"/>
			<scannell:hidden id="pageSizeLeg" path="pageSizeLeg" />
			<scannell:hidden id="pageNumberKey" path="pageNumberKey"/>
			<scannell:hidden id="pageSizeKey" path="pageSizeKey" />
			<scannell:hidden id="anchor" path="anchor" />
			<div id="queryDiv">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="select" />
					</label>
					<div class="col-sm-6">
						<select name="currentProfile" id="currentProfile" cssStyle="width:100%" items="${lawProfileSearchTypes}" itemValue="value" itemLabel="displayName" renderEmptyOption="false" class="wide" />
					</div>
				</div>
				<div style="clear: both;"></div>
				<div id="keywordSearchDiv" class="form-group" style="overflow:auto;height: auto;">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign" for="searchString">
						<fmt:message key="law.checklist.keywords" />
					</label>
					<div class="col-sm-6">
						<scannell:hidden id="keywordSearch" path="keywordSearch" />		
						<scannell:hidden id="keywordSearchName" path="keywordSearchName" />					    					   
						<%-- <div id="clearMesg"><fmt:message key="law.checklist.keywords.clear" /></div> --%>
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="form-group nonKeyword" style="overflow:auto;height: auto;">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign" for="searchString">
						<fmt:message key="law.checklist.text" />
					</label>
					<div class="col-sm-6">					    					   
						<scannell:textarea id="searchString" path="searchString" class="form-control requiredFields"/>
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="exactKeywordSearch" />
					</label>
					<div class="col-sm-6">						
						<label for="exactKeywordSearch" style="margin-right: 3px"><scannell:checkbox id="exactSearch" path="exactSearch"  class="checkbox" cssStyle="float: left;"/></label>
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="search" />
					</label>
					<div class="col-sm-6">
						  <label for="searchSynopsis" style="margin-right: 3px"><scannell:checkbox  class="checkbox" id="searchSynopsis" path="searchSynopsis"  cssStyle="float: left;" onclick="setHiddenValues(true);"/> <fmt:message key="lawSearchSynopsis" /></label>
						  <input type="hidden" name="searchSynopsis2" id="searchSynopsis2" value="true"> 
					      <label for="searchChecklists" style="margin-right: 3px"><scannell:checkbox class="checkbox" id="searchChecklists" path="searchChecklists"  cssStyle="float: left;" onclick="setHiddenValues(true);"/> <fmt:message key="lawSearchChecklists" /></label>
					      <input type="hidden" name="searchChecklists2" id="searchChecklists2" value="true">
					      <label for="searchRelevance" style="margin-right: 3px"><scannell:checkbox class="checkbox" id="searchRelevance" path="searchRelevance" cssStyle="float: left;" onclick="setHiddenValues(true);"/> <fmt:message key="lawSearchRelevance" /></label>
					      <input type="hidden" name="searchRelevance2" id="searchRelevance2" value="true">
					      <label for="searchEvaluationOfCompliance" style="margin-right: 3px"><scannell:checkbox class="checkbox" id="searchEvaluationOfCompliance" path="searchEvaluationOfCompliance" cssStyle="float: left;" onclick="setHiddenValues(true);"/> <fmt:message key="lawSearchEvaluation" /></label>
					      <input type="hidden" name="searchEvaluationOfCompliance2" id="searchEvaluationOfCompliance2" value="true">
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="register" />
					</label>
					<div class="col-sm-6">
					   <c:if test="${prfLeg == 3}">
						<c:forEach items="${registerTypes}" var="registerType">
					        <label for="registerType${registerType.id}" style="margin-right: 3px">					        
					        <scannell:checkbox class="checkbox" id="registerType${registerType.id}" path="registerTypes" value="${registerType.id}"  cssStyle="float: left;"/> ${registerType.name}
					        <c:if test="${prfLeg == 3}">
					        </c:if>
					        </label> 
					      </c:forEach>
					      </c:if>
					      <c:if test="${prfLeg == 2}">
					      	<label style="margin-right: 3px"><scannell:checkbox class="checkbox" id="registerType2" path="registerTypes" value="2"  cssStyle="float: left;" /> <fmt:message key="healthAndSafety" /></label>
					      	<label style="margin-right: 3px"><scannell:checkbox class="checkbox" id="registerType3" path="registerTypes" value="3"  cssStyle="float: left;" /> <fmt:message key="jointEnvAndHS" /></label>
					      </c:if>
					      <c:if test="${prfLeg == 1}">
					      	<label style="margin-right: 3px"><scannell:checkbox class="checkbox" id="registerType1" path="registerTypes" value="1"  cssStyle="float: left;" /> <fmt:message key="environmentLabel" /></label>
					      	<label style="margin-right: 3px"><scannell:checkbox class="checkbox" id="registerType3" path="registerTypes" value="3"  cssStyle="float: left;" /> <fmt:message key="jointEnvAndHS" /></label>
					      </c:if>
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="legislationType" />
					</label>
					<div class="col-sm-6">
						<select name="legislationTypeId" id="legislationType" items="${legislationTypes}" itemLabel="name" itemValue="id" renderEmptyOption="true" emptyOptionValue="0" class="wide" cssStyle="width:100%"/>
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="category" />
					</label>
					<div class="col-sm-6">
						<select name="contentCategoryId" id="category" items="${categories}" itemLabel="name" itemValue="id" renderEmptyOption="true" emptyOptionValue="0"  cssStyle="width:100%"/>
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="region" />
					</label>
					<div class="col-sm-6">
						<select name="economicRegionId" id="region" items="${regions}" itemLabel="name" itemValue="id" renderEmptyOption="true" emptyOptionValue="0" class="wide" cssStyle="width:100%"/>
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="from" />
					</label>
					<div class="col-sm-6">
						<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2"
							data-date-format="dd-MM-yyyy">
							<scannell:input class="form-control" id="fromDate" cssStyle="size:16;" path="origDateFrom" readonly="true" />
							<span class="input-group-addon btn btn-primary">
								<span class="glyphicon glyphicon-th"></span>
							</span>
						</div>
					
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="to" />
					</label>
					<div class="col-sm-6">
						<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2"
							data-date-format="dd-MM-yyyy">
							<scannell:input class="form-control" id="toDate" cssStyle="size:16;" path="origDateTo" readonly="true" />
							<span class="input-group-addon btn btn-primary">
								<span class="glyphicon glyphicon-th"></span>
							</span>
						</div>
					</div>
				</div>
				<div class="form-group nonKeyword">
					<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
						<fmt:message key="sort" />
					</label>
					<div class="col-sm-6">
						<select name="sort" id="sort" items="${sorts}" itemLabel="key" lookupItemLabel="true" renderEmptyOption="false" class="wide" cssStyle="width:100%"/>
					</div>
				</div>
				<div class="spacer2 text-center">
					<button type="submit" class="g-btn g-btn--primary" onclick="setHiddenValues(false);clearPageAttributes();trimText();"><fmt:message key="search" /></button>
      				<button type="button" onClick="clearForm()" class="g-btn g-btn--secondary"><fmt:message key="reset" /></button>
				</div>
			</div>
			<div id="resultsDiv"></div>
		</scannell:form>
	</div>





</body>
</html>
