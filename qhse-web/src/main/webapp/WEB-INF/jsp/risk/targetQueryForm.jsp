<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html">
<html>
<head>
<!--   <meta name="printable" content="true"> -->
  <title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
  <script type='text/javascript' src="<c:url value="/dwr/interface/RiskDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
  
  <script type="text/javascript">
  jQuery(document).ready(function() {	
	  jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
	   jQuery("#businessAreaId").select2();
	   jQuery("#status").select2();	   
	   jQuery("#createdByUser").select2();
	   jQuery("#sortName").select2();
	   jQuery("select").select2();
	   displayQueryDiv(false);
 });
<!--
	function clearForm(){
	   jQuery("#businessAreaId").select2('val', '');
	   jQuery("#status").select2('val', ''); 
	   jQuery("#createdByUser").select2('val', '');
	   jQuery("#sortName").select2('val', '');
	  var elem = document.getElementById('queryForm').elements;
	  for(var i = 0; i < elem.length; i++){
	  	  	var type = elem[i].type, tag = elem[i].tagName.toLowerCase();
			if (type == 'text' || tag == 'textarea'){
				elem[i].value = '';
			}
			else if (type == 'checkbox' || type == 'radio'){
				elem[i].checked = false;
			}
			else if (tag == 'select'){
				elem[i].selectedIndex = 0;
			}
		}
  }
 /*  function toggleQueryTable() {
     displayQueryTable(jQuery('#queryTable').show());
  } */
  function onChangeBusinessArea() {
	jQuery("#categoryId" ).val();
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":"Please Wait..."});
    RiskDWRService.listActiveCategories($F('businessAreaId'), function(data) { populateCallback(element, data); });
  }
  function populateCallback(element, data) {
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":" "});
    DWRUtil.addOptions(element.id, data);
  }
  
// -->
jQuery(window).bind('load', formOnLoad);
  
  function formOnLoad(){	  

		if('${quickLink}' != '') {
			clearForm();
			var selectedStatus = '${selectedStatus}';
			if(selectedStatus) {
				jQuery("#status").val(selectedStatus).trigger('change');
			}
		}
		else {
	  		copyFormValuesIfPopup('queryForm');
		}
	  
	  jQuery('#queryForm').submit();
  }
  
  function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/risk/legacyIdTarget.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/targetQueryResult.ajax?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/risk/targetQueryResult.ajax');
	}
  
  function trimDescription(){
	jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  }
  </script>
  <style type="text/css" media="all">   
    LI.target {
	  padding-left: 20px; padding-top: 5px;
    }
  </style>
</head>
<body>

<div class="col-md-12">
	<div id="block" class="">
		<div>
		    <div class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		    	<input type="text" id="refreshCheck" value="no" style="display: none;">
		     <form id="goToForm" action="<c:url value="/risk/targetView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
		     <input type="hidden" name="page" value="target"/>
		     <c:if test="${showLegacyId}">
		        <label>Legacy ID</label> 
		        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
		     </c:if>
			    Go to TAR
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Hide Search</button>
			    <button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
			</div>
	 	</div>
	</div>
	</div>
</div>

<div class="content">
 <scannell:form id="queryForm" action="/risk/targetQueryResult.ajax" onsubmit="  return search(this,'resultsDiv');updateSearchCriteriaSummary();">
<div id="queryDiv">
<div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
<input type="hidden" id="calculateTotals" name="calculateTotals" value="true">
<scannell:hidden path="pageNumber" />
<scannell:hidden path="pageSize" />


                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="businessArea" /></label>
									<div class="col-sm-6">
									<select name="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" onchange="onChangeBusinessArea()" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="objective.name" /></label>
									<div class="col-sm-6">																			
										 <scannell:textarea path="name" id="name" cssStyle="width:100%" class="form-control"/>
									</div>
								</div>								 
								<div style="clear: both;"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="objective.status" /></label>
									<div class="col-sm-6">
										<select name="status" id="status" renderEmptyOption="true" cssStyle="width:100%">
											<c:forEach items="${statusList}" var="status">
												<scannell:option value="${status.name}" labelkey="${status.name}" />
											</c:forEach>
										</scannell:select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                       <scannell:input class="form-control" id="startDateFrom"  cssStyle="size:16;" path="startDateFrom"  readonly="true"/>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                         <scannell:input class="form-control" id="startDateTo"  cssStyle="size:16;" path="startDateTo"  readonly="true"/>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>								
								
<%-- 							<jsp:include page="../SearchAttributes.jsp">
			        			<jsp:param name="structureFormat" value="divFormat"/>
			    			</jsp:include> --%>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="overdue" /></label>
									<div class="col-sm-6">
										 <scannell:checkbox  path="overdue" id="overdue" value="true" />
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">
										<select name="sortName" id="sortName" items="${sortList}" lookupItemLabel="true" renderEmptyOption="true" cssStyle="width:100%" />
									</div>
								</div>

								<div class="form-group">
									<label id="sortNameLabel" class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="saveCriteria" /></label>
									
									<div>
										<div>
											<input type="checkbox" style="float:left;" onclick="showCriteriaSaveForm(this)" name="saveCriteriaChk" id="saveCriteriaChk"> 
											<div id="saveCriteriaDiv" style="float:left;margin-left:7px;display:none">
												<fmt:message key="searchCriteriaPrivate" />: <input type="radio" checked="checked" name="saveCriteria" id="saveCriteria" value="personal">
				      							<fmt:message key="searchCriteriaGlobal" />: <input type="radio" name="saveCriteria" id="saveCriteria" value="global"> 
				      							<input id="criteriaName" name="criteriaName" onkeyup="verifySaveCriteriaName(this)" size="40" maxlength="40" value="" placeholder="<fmt:message key="searchCriteriaDefaultMessage" />">
				                            	<div>
				                            		&nbsp;<label style="display:none;" id="saveCriteriaError"><span class="errorMessage"><fmt:message key="searchCriteriaError"/></span></label>
												</div>
				                            </div>
										</div>
		                            </div>
								</div>
	

                              <div class="spacer2 text-center">
			                     <button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();"><fmt:message key="search" /></button>
                                 <button type="button" class="g-btn g-btn--primary" onClick="clearForm();"><fmt:message key="reset" /></button>
			                  </div>
     


</div>

<div id="resultsDiv"></div>

</scannell:form>
</div>




</body>
</html>
