<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
}
</style>
<!-- <meta name="printable" content="true"> -->
<title></title>

	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
<script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/incident.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/savedSearchCriteria.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
    <c:set value="500" var="maxListSize"/>
<script type="text/javascript">
var resUserId = '';
var resUserName = '';
var verUserId = '';
var verUserName = '';
jQuery(document).ready(function() {	
	/* jQuery('select').not('#pageSize').prepend("<option value=''> Choose </option>").val(''); */
	jQuery('select').select2();
	jQuery("#trash").val("false");
	jQuery('#openClosed').change(function() {
		var completed = "";
		var overdue = "";
		var trash = "";

		switch(jQuery(this).val()) {
		case "open":
			completed = "false";
			trash = "false";
			break;
		case "overdue":
			completed = "false";
			overdue = "true"
			trash = "false";
			break;
		case "closed":
			completed = "true";
			trash = "false";
			break;
		case "trash":
			trash = "true";
			completed = "";
			overdue = "";
			break;
		}
		jQuery("#completed").val(completed);
		jQuery("#overdue").val(overdue);
		jQuery("#trash").val(trash);
	});
	restoreSearchCriteria('queryForm'); 
	copyFormValuesIfPopup('queryForm'); 
	showResponsibleUserList(${fn:length(users)}, "100", "actionUserList.json", resUserId,resUserName);
	showUserList(${fn:length(users)}, "verifyingUser", "100", "actionUserList.json", verUserId,verUserName);
	jQuery('#queryForm').submit();
	displayQueryDiv(false);
});

function restoreSearchCriteria(formId){
	jQuery("#pageNumber").val('${sessionScope["actionSearch.pageNumber"]}' || 1);
    var type='<%= request.getSession().getAttribute("actionSearch.type") %>';
   	if(type != 'null'){
		jQuery("#type").val(type);
		jQuery("#type").parent().find('span.select2-chosen').text(jQuery("#type option[value='"+type+"']").text());
   	}
    var priority='<%= request.getSession().getAttribute("actionSearch.priority") %>';
	if(priority != 'null'){
		jQuery("#priority").val(priority);
		jQuery("#priority").parent().find('span.select2-chosen').text(jQuery("#priority option[value='"+priority+"']").text());
	}
	var openClosed='<%= request.getSession().getAttribute("actionSearch.openClosed") %>';
  	if(openClosed != 'null')
  	{
  		if(openClosed == 'open')
		{
			jQuery("#completed").val("false");
			jQuery("#overdue").val("");
			jQuery("#trash").val("false");
		}
		else if(openClosed == 'overdue')
		{
			jQuery("#completed").val("false");
			jQuery("#overdue").val("true");
			jQuery("#trash").val("false");
		}
		else if(openClosed == 'closed')
		{
			jQuery("#completed").val("true");
			jQuery("#overdue").val("");
			jQuery("#trash").val("false");
		} else if(openClosed == 'trash')
		{
			jQuery("#trash").val("true");
			jQuery("#completed").val("");
			jQuery("#overdue").val("");
		}
		else
		{
			jQuery("#completed").val("");
			jQuery("#overdue").val("");
			jQuery("#trash").val("false");
		}
  		
		jQuery("#openClosed").val(openClosed);
		jQuery("#openClosed").parent().find('span.select2-chosen').text(jQuery("#openClosed option[value='"+openClosed+"']").text());
  	}
  	
  	var verified='<%= request.getSession().getAttribute("actionSearch.verified") %>';
  	if(verified != 'null'){
  		jQuery("#verified").val(verified);
  		jQuery("#verified").parent().find('span.select2-chosen').text(jQuery("#verified option[value='"+verified+"']").text());
  	}
  	
  	var createdDateFrom='<%= request.getSession().getAttribute("actionSearch.createdDateFrom") %>';
  	if(createdDateFrom != 'null')
  		jQuery("#createdDateFrom").val(createdDateFrom);
  	
  	var createdDateTo='<%= request.getSession().getAttribute("actionSearch.createdDateTo") %>';
  	if(createdDateTo != 'null')
  		jQuery("#createdDateTo").val(createdDateTo);
  	
   	var completedDateFrom='<%= request.getSession().getAttribute("actionSearch.completedDateFrom") %>';
  	if(completedDateFrom != 'null')
  		jQuery("#completedDateFrom").val(completedDateFrom);
  	
	var completedDateTo='<%= request.getSession().getAttribute("actionSearch.completedDateTo") %>';
  	if(completedDateTo != 'null')
  		jQuery("#completedDateTo").val(completedDateTo);
  	
  	var verifiedDateFrom='<%= request.getSession().getAttribute("actionSearch.verifiedDateFrom") %>';
  	if(verifiedDateFrom != 'null')
  		jQuery("#verifiedDateFrom").val(verifiedDateFrom);
  	
	var verifiedDateTo='<%= request.getSession().getAttribute("actionSearch.verifiedDateTo") %>';
  	if(verifiedDateTo != 'null')
  		jQuery("#verifiedDateTo").val(verifiedDateTo);
  	
	var completionTargetDateFrom='<%= request.getSession().getAttribute("actionSearch.completionTargetDateFrom") %>';
  	if(completionTargetDateFrom != 'null')
  		jQuery("#completionTargetDateFrom").val(completionTargetDateFrom);
  	
  	var completionTargetDateTo='<%= request.getSession().getAttribute("actionSearch.completionTargetDateTo") %>';
  	if(completionTargetDateTo != 'null')
  		jQuery("#completionTargetDateTo").val(completionTargetDateTo);
  	
  	var responsibleUser='<%= request.getSession().getAttribute("actionSearch.responsibleUser") %>';
  	if(responsibleUser != 'null'){
  		resUserId = '<%= request.getSession().getAttribute("actionSearch.responsibleUser") %>';
  		resUserName = '<%= request.getSession().getAttribute("actionSearch.responsibleUserName") %>';
  		jQuery("#responsibleUser").val(responsibleUser);
  		jQuery("#responsibleUser").parent().find('span.select2-chosen').text(jQuery("#responsibleUser option[value='"+responsibleUser+"']").text());
  	}
  	
	var category='<%= request.getSession().getAttribute("actionSearch.category") %>';
  	if(category != 'null'){
  		jQuery("#category").val(category);
  		jQuery("#category").parent().find('span.select2-chosen').text(jQuery("#category option[value='"+category+"']").text());
  	}
  	
	var ownerType='<%= request.getSession().getAttribute("actionSearch.ownerType") %>';
  	if(ownerType != 'null'){
  		jQuery("#ownerType").val(ownerType);
  		jQuery("#ownerType").parent().find('span.select2-chosen').text(jQuery("#ownerType option[value='"+ownerType+"']").text());
  	}
  	
  	var verifyingUser='<%= request.getSession().getAttribute("actionSearch.verifyingUser") %>';
  	if(verifyingUser != 'null'){
  		verUserId = '<%= request.getSession().getAttribute("actionSearch.verifyingUser") %>';
  		verUserName = '<%= request.getSession().getAttribute("actionSearch.verifyingUserName") %>';
  		jQuery("#verifyingUser").val(verifyingUser);
  		jQuery("#verifyingUser").parent().find('span.select2-chosen').text(jQuery("#verifyingUser option[value='"+verifyingUser+"']").text());
  	}
  	
  	var capaType='<%= request.getSession().getAttribute("actionSearch.capaType") %>';
  	if(capaType != 'null'){
  		jQuery("#capaType").val(capaType);
  		jQuery("#capaType").parent().find('span.select2-chosen').text(jQuery("#capaType option[value='"+capaType+"']").text());
  	}
  	
  	var departmentId='<%= request.getSession().getAttribute("actionSearch.departmentId") %>';
  	if(departmentId != 'null'){
  		jQuery("#departmentId").val(departmentId);
  		jQuery("#departmentId").parent().find('span.select2-chosen').text(jQuery("#departmentId option[value='"+departmentId+"']").text());
  	}
  	
  	var businessAreaId='<%= request.getSession().getAttribute("actionSearch.businessAreaId") %>';
  	if(businessAreaId != 'null'){
  		jQuery("#businessAreaId").val(businessAreaId);
  		jQuery("#businessAreaId").parent().find('span.select2-chosen').text(jQuery("#businessAreaId option[value='"+businessAreaId+"']").text());
  	}
  	
  	var pageSize='<%= request.getSession().getAttribute("actionSearch.pageSize") %>';
  	if(pageSize != 'null')
  		jQuery("#pageSize").val(pageSize);
  	
  	var description='<%= request.getSession().getAttribute("actionSearch.description") %>';
  	if(description != 'null')
  		jQuery("#description").val(description);
}
  /* function toggleQueryTable() {
    $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
    $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
  } */
  
  function excelRequest(){	  
	  jQuery("#excel").val('YES');	  
  }
  function resetExcelRequest(){	  
	  jQuery("#excel").val('NO');
  }
  var scrollToResultDiv = false;
  function searchExcelCheckAction(form, targetElementId, scrollToResults) {	
		var exc=jQuery("#excel").val();
		 if(exc == 'YES'){
			targetElementId=null;
		} 
		if (scrollToResults) {
			scrollToResultDiv = true;
		}	
		
		
		jQuery('#'+targetElementId).html('<table class="table table-bordered table-responsive"><thead><tr><th>Loading data...</th></tr></thead></table>');	
		if(exc == 'NO'){
		jQuery.ajax({
			   url:  jQuery(form).attr('action'),
			   type: "post",
			   dataType: "html",
			   data:jQuery(form).serialize(form),
			   success: function(returnData){			 
			   jQuery('#'+targetElementId).html(returnData);				   
			   },
			   error: function(e){
			     alert('Error : '+e);
			   }
			});	
		}else{	 
			jQuery('body').append('<div id="preparing-file-modal" title="Preparing report..." style="display: none;"> We are preparing your excel report, please wait... <img src="../images/loading.gif" /> </div>');
			jQuery('body').append('<div id="error-modal" title="Error" style="display: none;">There was a problem generating your report, please try again.</div>');
			var preparingFileModal = jQuery("#preparing-file-modal");
			preparingFileModal.dialog({ modal: true });
			jQuery.fileDownload(jQuery(form).attr('action'), {	        	 
	            httpMethod: "POST",
	            //data: $(this).serialize()
	            successCallback: function (url) {
	                preparingFileModal.dialog('close');
	            },
	            failCallback: function (responseHtml, url) {
	            	preparingFileModal.dialog('close');
	            	jQuery("#error-modal").dialog({ modal: true });
	            },
	            data: jQuery(form).serialize(form)
	        });
			resetExcelRequest();// ENV-7675
	        return false; //this is critical to stop the click event which will trigger a normal Excel file download!			
		}
		 scrollToResultDiv = true;		 
		return false; 
	}
  
  function clearForm(){
	  jQuery("#type").select2().select2('val', jQuery('#type option:eq(0)').val());
	  jQuery("#priority").select2().select2('val', jQuery('#priority option:eq(0)').val());
	  jQuery("#openClosed").select2().select2('val', jQuery('#openClosed option:eq(0)').val());
	  jQuery("#verified").select2().select2('val', jQuery('#verified option:eq(0)').val());
	  jQuery('#responsibleUser').val('').change();
	  jQuery("#responsibleUser").select2().select2('val', jQuery('#responsibleUser option:eq(0)').val());
	  jQuery("#category").select2().select2('val', jQuery('#category option:eq(0)').val());
	  
	  jQuery("#ownerType").select2().select2('val', jQuery('#ownerType option:eq(0)').val());
	  jQuery('#verifyingUser').val('').change();
	  jQuery("#verifyingUser").select2().select2('val', jQuery('#verifyingUser option:eq(0)').val());
	  jQuery("#capaType").select2().select2('val', jQuery('#capaType option:eq(0)').val());
	  jQuery("#departmentId").select2().select2('val', jQuery('#departmentId option:eq(0)').val());
	  jQuery("#pageSize").select2().select2('val', jQuery('#pageSize option:eq(0)').val());
	  jQuery("#businessAreaId").select2().select2('val', jQuery('#businessAreaId option:eq(0)').val());
	  
	  jQuery("#completed").val(""); 
	  jQuery("#overdue").val("");
	  jQuery("#trash").val("");
  }
  
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/incident/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/incident/searchActions.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/incident/searchActions.htmf');
	}
	function setTrashFalse(){
		if(jQuery("#openClosed").val() != "trash"){
			jQuery("#trash").val("false");
		}
	}
	function trimDescription(){
	  	jQuery("#description").val(jQuery.trim(jQuery("#description").val()));
  	}
  </script>
<style type="text/css" media="all">
  @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body>

<div class="col-md-12">
	<div id="block" class="">
		<div>
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12 pull-right">
		    	<div align="right">
		     <form id="goToForm" action="<c:url value="/incident/viewAction.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
		     <input type="hidden" name="page" value="Action"/>
			<c:if test="${showLegacyId}">
			 <label>Legacy ID</label> 
	            <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
			   </c:if>
			    <fmt:message key="incident.searchActionsForm.goTo"/>
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Hide Search</button>
			    <button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>


<form id="queryForm" class="form-horizontal group-border-dashed" action="<c:url value="/incident/searchActions.htmf" />" onsubmit="return searchExcelCheckAction(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
  <div id="queryDiv">
  
  <div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>

 <div class="col-sm-12 col-md-12" >
<div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="type" /></label>                      
             <select name="type" id="type" style="width:100%;">
             <option value=""><fmt:message key="choose" /></option>
             <c:forEach items="${types}" var="item">
             <option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
             </c:forEach>
            </select>   
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="priority" /></label>                         
              <select name="priority" id="priority" style="width:100%;">
             <option value=""><fmt:message key="choose" /></option>
             <c:forEach items="${priorities}" var="item">
              <option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
            </c:forEach>
            </select>   
             </div>
      </div>
 </div>
 
 <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="task.openClosed" /></label>                      
               <select id="openClosed" name="openClosed" style="width:100%;" onchange="setTrashFalse()">
               <option value=""><fmt:message key="choose" /></option>
               <option value="open"><fmt:message key="task.openClosed.open" /></option>
               <option value="overdue"><fmt:message key="task.openClosed.overdue" /></option>
               <option value="closed"><fmt:message key="task.openClosed.closed" /></option>
               <option value="trash"><fmt:message key="trash" /></option>
               </select>
               <input type="hidden" id="completed" name="completed" />
               <input type="hidden" id="overdue" name="completionOverdue" />
               <input type="hidden" id="trash" name="trash" />
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="verified" /></label>                         
             <select name="verified" style="width:100%;" id="verified">
             <option value=""><fmt:message key="choose" /></option>      
             <option value="true"><fmt:message key="true" /></option>
             <option value="false"><fmt:message key="false" /></option>
             </select> 
             </div>
      </div>
 </div>
 
 <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="createdDateFrom" /></label>                      
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="createdDateFrom" name="createdDateFrom" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>                         
             <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="createdDateTo" name="createdDateTo" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
             </div>
      </div>
 </div>
 
 
  <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="completedDateFrom" /></label>                      
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completedDateFrom" name="completedDateFrom" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>                         
             <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completedDateTo" name="completedDateTo" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
             </div>
      </div>
 </div>
 
   <%-- <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="completedDateFrom" /></label>                      
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completedDateFrom" name="completedDateFrom" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>                         
             <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completedDateTo" name="completedDateTo" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
             </div>
      </div>
 </div> --%>
 
 
 <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="verifiedDateFrom" /></label>                      
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="verifiedDateFrom" name="verifiedDateFrom" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>                         
             <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="verifiedDateTo" name="verifiedDateTo" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
             </div>
      </div>
 </div>
 
 <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="completionTargetDateFrom" /></label>                      
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completionTargetDateFrom" name="completionTargetDateFrom" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="to" /></label>                         
             <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
              <input class="form-control"  id="completionTargetDateTo" name="completionTargetDateTo" type="text"  readonly>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
             </div>
      </div>
 </div>
 
 <div class="row">
    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="responsibleUser" /></label>    
              	<c:choose>
					<c:when test="${fn:length(users)  lt maxListSize && fn:length(users) > 0}">
						<select name="responsibleUser" id="responsibleUser" style="width:100%;">
			              	<option value=""><fmt:message key="choose" /></option>
			              		<c:forEach items="${users}" var="item">
			              			<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
			              		</c:forEach>
			           </select>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="responsibleUser" name="responsibleUser" />
					</c:otherwise>
				</c:choose>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="category" /></label>                         
              <select name="category" id="category" style="width:100%;">
	          <option value=""><fmt:message key="choose" /></option>
	          <c:forEach items="${categories}" var="item">
	          <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
	          </c:forEach>
	          </select>
             </div>
      </div>
 </div>
 
  <div class="row">
    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="actionHolder.ownerType" /></label>                      
              <select name="ownerType" id="ownerType" style="width:100%;">
              <option value=""><fmt:message key="choose" /></option>
              <c:forEach items="${holderTypes}" var="item">
              <option value="<c:out value="${item}" />"><fmt:message key="actionHolderType.${item}" /></option>
              </c:forEach>
              </select>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="verifyingUser" /></label>                         
      			<c:choose>
					<c:when test="${fn:length(users)  lt maxListSize && fn:length(users) > 0}">
						<select name="verifyingUser" id="verifyingUser" style="width:100%;">
			               <option value=""><fmt:message key="choose" /></option>
			              	<c:forEach items="${users}" var="item">
			              		<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
			              	</c:forEach>
				      </select>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="verifyingUser" name="verifyingUser" />
					</c:otherwise>
				</c:choose>
             </div>
      </div>
 </div>

 
  <div class="row">
    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="capaType" /></label>                      
              <select name="capaType" id="capaType" style="width:100%;">
              <option value=""><fmt:message key="choose" /></option>
              <c:forEach items="${capatypes}" var="item">
              <option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
              </c:forEach>
              </select>
              </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="department" /></label>                         
               <select id="departmentId" name="departmentId" style="width:100%;">
               <option value=""><fmt:message key="choose" /></option>
               <c:forEach items="${departments}" var="item">
               <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
               </c:forEach>
               </select>
             </div>
      </div>
      
 </div>
<%--   <jsp:include page="../SearchAttributes.jsp">
			   <jsp:param name="structureFormat" value="incident"/>
	</jsp:include> --%>
 
 <div class="row">
    <div class="col-sm-6 col-md-6">
              <div class="form-group">
				<label class="control-label scannellGeneralLabel nowrap"><fmt:message key="businessArea" /></label>
				<select id="businessAreaId" name="businessAreaId" style="width:100%;">
	               <option value=""><fmt:message key="choose" /></option>
	               	<c:forEach items="${businessAreaList}" var="item">
	               <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
	               </c:forEach>
               </select>
		</div>
	</div>
    <div class="col-sm-6 col-md-6">
         <div class="form-group">
         <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="description" /></label>                      
         <textarea name="description" id="description" style="width:100%;"></textarea>
    	</div>
     </div>
 </div>
 <div class="row">
    <div class="col-sm-6 col-md-6">
      	<div class="form-group">
    		<label class="control-label scannellGeneralLabel nowrap"><fmt:message key="saveCriteria" /></label>
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
	</div>
 </div>
 
 
 <div class="spacer2 text-center">
                   <button id="submitButton" type="submit" class="g-btn g-btn--primary" onClick="resetExcelRequest();this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();"><fmt:message key="search" /></button>
                     <c:if test="${createExcel == true}">
                  <button type="submit" class="g-btn g-btn--primary" onClick="excelRequest();this.form.pageNumber.value = 1;"><fmt:message key="exportToExcel" /></button>
                 </c:if>
                  <button type="reset" class="g-btn g-btn--secondary" onClick="resetExcelRequest();clearForm()"><fmt:message key="reset" /></button>      
                  <input type="hidden" id="excel" name="excel" value="NO" />
 
			                     	
 </div>

</div> 















</div>
<div id="resultsDiv"></div>
</form>

</body>
</html>
