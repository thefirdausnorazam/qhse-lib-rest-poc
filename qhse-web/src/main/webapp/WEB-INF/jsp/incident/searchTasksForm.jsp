<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>
<style type="text/css">
td.searchLabel {
	padding-left: 0px !important; padding-right: 5% !important;
}
</style>
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
jQuery(document).ready(function() {	 
	jQuery("form#queryForm select:not('#pageSize')").prepend("<option value=''> Choose </option>").val('');	
	jQuery('select').select2();
	jQuery("#trash").val("false");
	jQuery('#openClosed').change(function() {
		var completed = "";
		var overdue = "";
		var trash="false";

		switch(jQuery(this).val()) {
		case "open":
			completed = "false";
			break;
		case "overdue":
			completed = "false";
			overdue = "true"
			break;
		case "closed":
			completed = "true";
			break;
		case "trash":
			trash="true";
			break;
		}
		jQuery("#completed").val(completed);
		jQuery("#overdue").val(overdue);
		jQuery("#trash").val(trash);
	});
	
	restoreSearchCriteria('queryForm'); 
	copyFormValuesIfPopup('queryForm'); 
	showResponsibleUserList(${fn:length(users)}, "40", "taskUserList.json", resUserId,resUserName);
	jQuery('#queryForm').submit();
	
	displayQueryDiv(false);
});
  
  /* function toggleQueryTable() {
    $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
    $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
  } */
  function restoreSearchCriteria(formId){
	    jQuery("#pageNumber").val('${sessionScope["taskSearch.pageNumber"]}' || 1);
	    var responsibleUser='<%=request.getSession().getAttribute("taskSearch.responsibleUser")%>';
	   	if(responsibleUser != 'null') {
	   		resUserId = responsibleUser;
  			resUserName = '<%= request.getSession().getAttribute("taskSearch.responsibleUserName") %>';	
	   		jQuery("#responsibleUser").val(responsibleUser);
	   		jQuery("#responsibleUser").select2("val", responsibleUser);
	   	}
	   	
	    var openClosed='<%=request.getSession()
					.getAttribute("taskSearch.openClosed")%>';
		if(openClosed != 'null')
		{
			if(openClosed == 'open')
			{
				jQuery("#completed").val("false");
				jQuery("#overdue").val("");
			}
			else if(openClosed == 'overdue')
			{
				jQuery("#completed").val("false");
				jQuery("#overdue").val("true");
			}
			else if(openClosed == 'closed')
			{
				jQuery("#completed").val("true");
				jQuery("#overdue").val("");
			}
			else if(openClosed == 'trash')
			{
				jQuery("#completed").val("");
				jQuery("#overdue").val("");
				jQuery("#trash").val("true");
			}
			else
			{
				jQuery("#completed").val("");
				jQuery("#overdue").val("");
				jQuery("#trash").val("false");
			}
			jQuery("#openClosed").select2("val", openClosed);			
		}
		
		var createdDateFrom='<%=request.getSession().getAttribute("taskSearch.createdDateFrom")%>';
	  	if(createdDateFrom != 'null')
	  		jQuery("#createdDateFrom").val(createdDateFrom);
	  	
	  	var createdDateTo='<%=request.getSession().getAttribute("taskSearch.createdDateTo")%>';
	  	if(createdDateTo != 'null')
	  		jQuery("#createdDateTo").val(createdDateTo);
	  	
	  	var completionTargetDateFrom='<%=request.getSession().getAttribute("taskSearch.completionTargetDateFrom")%>';
	  	if(completionTargetDateFrom != 'null')
	  		jQuery("#completionTargetDateFrom").val(completionTargetDateFrom);
	  	
	  	var completionTargetDateTo='<%=request.getSession().getAttribute("taskSearch.completionTargetDateTo")%>';
	  	if(completionTargetDateTo != 'null')
	  		jQuery("#completionTargetDateTo").val(completionTargetDateTo);
	  	
	   	var completedDateFrom='<%=request.getSession().getAttribute("taskSearch.completedDateFrom")%>';
	  	if(completedDateFrom != 'null')
	  		jQuery("#completedDateFrom").val(completedDateFrom);
	  	
	  	var completedDateTo='<%=request.getSession().getAttribute(
					"taskSearch.completedDateTo")%>';
	  	if(completedDateTo != 'null')
	  		jQuery("#completedDateTo").val(completedDateTo);
	  	
	  	var departmentId='<%=request.getSession().getAttribute("taskSearch.departmentId")%>';
	  	if(departmentId != 'null')
	  		jQuery("#departmentId").select2("val", departmentId);
	  	
	  	var businessAreaId='<%=request.getSession().getAttribute("taskSearch.businessAreaId")%>';
	  	if(businessAreaId != 'null')
	  		jQuery("#businessAreaId").select2("val", businessAreaId);
	  		
	  	
	  	var pageSize='<%=request.getSession().getAttribute("taskSearch.pageSize")%>';
	  	if(pageSize != 'null')
	  		jQuery("#pageSize").select2("val", pageSize);
	  		
	  	
	  	var priority='<%=request.getSession().getAttribute("taskSearch.priority")%>';
	  	if(priority != 'null')
	  		jQuery("#priority").select2("val", priority);
	  		
	  	
	  	var description='<%=request.getSession().getAttribute("taskSearch.description")%>';
		if (description != 'null')
			jQuery("#description").val(description);
	}
	 
	function getCookie(name) {
	    var dc = document.cookie;
	    var prefix = name + "=";
	    var begin = dc.indexOf("; " + prefix);
	    if (begin == -1) {
	        begin = dc.indexOf(prefix);
	        if (begin != 0) return null;
	    }
	    else
	    {
	        begin += 2;
	        var end = document.cookie.indexOf(";", begin);
	        if (end == -1) {
	        end = dc.length;
	        }
	    }
	    return unescape(dc.substring(begin + prefix.length, end));
	} 
//created by Manjush on 16/June/2014
  function deleteCookie(c_name) {
	    document.cookie = encodeURIComponent(c_name) + "=deleted; expires=" + new Date(0).toUTCString();
	}
//created by Manjush on 16/June/2014 
  function myTimer() {
	  var myCookie = getCookie("test");
	  if(myCookie != null){
		  deleteCookie("test");
		  window.location.reload(true);
		 
	  }
	}
	function searchExcelCheck(form, targetElementId, scrollToResults) {
		var exc = jQuery("#excel").val();
		if (exc == 'YES') {
			targetElementId = null;
		}
		if (scrollToResults) {
			scrollToResultDiv = true;
		}
		var myVar = setInterval(function(){myTimer()}, 100);
		jQuery('#' + targetElementId).html('<table class="viewForm bordered"><thead><tr><th>Loading data...</th></tr></thead></table>');
		if (exc == 'NO') {
			jQuery.ajax({
			url : jQuery(form).attr('action'),
			type : "post",
			dataType : "html",
			data : jQuery(form).serialize(form),
			success : function(returnData) {
				jQuery('#' + targetElementId).html(returnData);
			},
			error : function(e) {
				alert('Error : ' + e);
			}
			});
		} else {
			jQuery('body').append('<div id="preparing-file-modal" title="Preparing report..." style="display: none;"> We are preparing your excel report, please wait... <img src="../images/loading.gif" /> </div>');
			jQuery('body').append('<div id="error-modal" title="Error" style="display: none;">There was a problem generating your report, please try again.</div>');
			var preparingFileModal = jQuery("#preparing-file-modal");
			preparingFileModal.dialog({ modal: true });
			$.fileDownload(jQuery(form).attr('action'), {
			httpMethod : "POST",
			//data : $(this).serialize()
			successCallback: function (url) {
	                preparingFileModal.dialog('close');
	            },
	        failCallback: function (responseHtml, url) {
	            	preparingFileModal.dialog('close');
	            	jQuery("#error-modal").dialog({ modal: true });
	            },
			data: jQuery(form).serialize(form)
			});
			e.preventDefault();//this is critical to stop the click event which will trigger a normal file download!		
		}
		scrollToResultDiv = true;
		return false;
	}

	function clearForm() {
		jQuery('#responsibleUser').val('').change();
		jQuery("#responsibleUser").select2().select2('val', jQuery('#responsibleUser option:eq(0)').val());
		jQuery("#openClosed").select2().select2('val', jQuery('#openClosed option:eq(0)').val());
		jQuery("#departmentId").select2().select2('val', jQuery('#departmentId option:eq(0)').val());
		jQuery("#businessAreaId").select2().select2('val', jQuery('#businessAreaId option:eq(0)').val());
		jQuery("#priority").select2().select2('val', jQuery('#priority option:eq(0)').val());
		jQuery("#pageSize").select2('val', jQuery('#pageSize option:eq(0)').val());
		
		jQuery("#completed").val(""); 
		  jQuery("#overdue").val("");
		  jQuery("#trash").val("false")

	}
	
	function getObjects(){
		//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/incident/legacyId.htm').submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/incident/searchTasks.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
		jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/incident/searchTasks.htmf');
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
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<form id="goToForm" action="<c:url value="/incident/viewTask.htm" />" method="get"
						onSubmit="if(!jQuery('#gotoId')) return false;">
						<input type="hidden" name="page" value="Task"/>
						<c:if test="${showLegacyId}">
						<label>Legacy ID</label> 
	           			<input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
						</c:if>
						<fmt:message key="incident.searchTasksForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Hide
							Search</button>
						<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>


					</div>
				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
	</div>


	<form id="queryForm" action="<c:url value="/incident/searchTasks.htmf" />"
		onsubmit="return searchExcelCheck(this, 'resultsDiv');">
		<input type="hidden" name="calculateTotals" value="true" />
		<input type="hidden" id="pageNumber" name="pageNumber" value="1" />
		<div id="queryDiv">
			<div class="header">
				<h3>
					<fmt:message key="searchCriteria" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<div class="panel hidden-print" id="queryTablePanel">

						<table id="queryTable" class="table table-bordered table-responsive">
							<tbody>
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="responsibleUser" /></td>
									<td class="search">
										<%-- <select name="responsibleUser" id="responsibleUser" style="width: 250px;">
											<c:forEach items="${users}" var="item">
												<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
											</c:forEach>
										</select> --%>
									<c:choose>
										<c:when test="${fn:length(users)  lt maxListSize && fn:length(users) > 0}">
											<select name="responsibleUser" id="responsibleUser" style="width:100%;">
								              	<%-- <option value=""><fmt:message key="choose" /></option> --%>
								              		<c:forEach items="${users}" var="item">
								              			<option value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
								              		</c:forEach>
								           </select>
										</c:when>
										<c:otherwise>
											<input type="hidden" id="responsibleUser" name="responsibleUser" />
										</c:otherwise>
									</c:choose>	
									</td>
									<td class="searchLabel"><fmt:message key="task.openClosed" /></td>
									<td class="search"><select id="openClosed" name="openClosed" style="width: 250px;">

											<option value="open"><fmt:message key="task.openClosed.open" /></option>
											<option value="overdue"><fmt:message key="task.openClosed.overdue" /></option>
											<option value="closed"><fmt:message key="task.openClosed.closed" /></option>
											<option value="trash"><fmt:message key="trash" /></option>
										</select> <input type="hidden" id="completed" name="completed" /> <input type="hidden" id="overdue" name="overdue" />
										<input type="hidden" id="trash" name="trash" />
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="createdDateFrom" /></td>
									<td class="search">
										<%-- <input type="text" id="createdDateFrom" name="createdDateFrom" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'createdDateFrom', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="createdDateFrom" class="form-control" type="text" name="createdDateFrom" readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
									<td class="searchLabel"><fmt:message key="to" /></td>
									<td class="search">
										<%--  <input type="text" id="createdDateTo" name="createdDateTo" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'createdDateTo', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="createdDateTo" class="form-control" type="text" name="createdDateTo" readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="completedDateFrom" /></td>
									<td class="search">
										<%-- <input type="text" id="completedDateFrom" name="completedDateFrom" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completedDateFrom', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="completedDateFrom" class="form-control" type="text" name="completedDateFrom" readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
									<td class="searchLabel"><fmt:message key="to" /></td>
									<td class="search">
										<%-- <input type="text" id="completedDateTo" name="completedDateTo" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completedDateTo', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="completedDateTo" class="form-control" type="text" name="completedDateTo" readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel nowrap"><fmt:message key="completionTargetDateFrom" /></td>
									<td class="search">
										<%--  <input type="text" id="completionTargetDateFrom" name="completionTargetDateFrom" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionTargetDateFrom', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="completionTargetDateFrom" class="form-control" type="text" name="completionTargetDateFrom"
													readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
									<td class="searchLabel"><fmt:message key="to" /></td>
									<td class="search">
										<%--  <input type="text" id="completionTargetDateTo" name="completionTargetDateTo" size="30" readonly="readonly">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionTargetDateTo', true);"> --%>
										<div id="cal" style="width: 250px;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
												<input id="completionTargetDateTo" class="form-control" type="text" name="completionTargetDateTo"
													readonly="readonly">
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>

										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="department" /></td>
									<td colspan="3" class="search"><select id="departmentId" name="departmentId" style="width: 250px;">

											<c:forEach items="${departments}" var="item">
												<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
											</c:forEach>
										</select></td>
								</tr>
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="businessArea" /></td>
									<td colspan="3" class="search"><select id="businessAreaId" name="businessAreaId" style="width: 250px;">

											<c:forEach items="${businessAreaList}" var="item">
												<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
											</c:forEach>
										</select></td>
								</tr>
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="priority" /></td>
									<td colspan="3" class="search"><select name="priority" id="priority" style="width: 250px;">

											<c:forEach items="${priorities}" var="item">
												<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
											</c:forEach>
										</select></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="description" /></td>
									<td class="search"><textArea name="description" id="description" style="width: 250px;" /></textArea>
									<td class="searchLabel nowrap"><span style="display: none;"><fmt:message key="incident.searchTasksForm.recordsPerPage" /></span></td>
									<td class="search"><select name="pageSize" id="pageSize" style="width: 250px;display: none;" >
											<c:forEach items="${recordsPerPage}" var="recordPerPage">
												<option value="<c:out value="${recordPerPage.value}" />"
													<c:if test="${recordPerPage.value == pageSize}">selected="selected"</c:if>>
													<fmt:message key="${recordPerPage}" />
												</option>
												<option value="100">100 Records</option>
												<option value="500">500 Records</option>
											</c:forEach>
										</select></td>
								</tr>
								<tr class="form-group">
								    <td class="searchLabel" id="sortNameLabel">Save Criteria:</td>
								    <td class="search" colspan="3">
										<input type="checkbox" style="float:left;" onclick="showCriteriaSaveForm(this)" name="saveCriteriaChk" id="saveCriteriaChk"> 
										<div id="saveCriteriaDiv" style="float:left;margin-left:7px;display:none">
											<fmt:message key="searchCriteriaPrivate" />: <input type="radio" checked="checked" name="saveCriteria" id="saveCriteria" value="personal">
			      							<fmt:message key="searchCriteriaGlobal" />: <input type="radio" name="saveCriteria" id="saveCriteria" value="global"> 
			      							<input id="criteriaName" name="criteriaName" onkeyup="verifySaveCriteriaName(this)" size="40" maxlength="40" value="" placeholder="<fmt:message key="searchCriteriaDefaultMessage" />">
			                            	<div>
			                            		&nbsp;<label style="display:none;" id="saveCriteriaError"><span class="errorMessage"><fmt:message key="searchCriteriaError"/></span></label>
											</div>
			                            </div>
								    </td>
								  </tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center">
										<div class="spacer2 text-center">
											<button id="submitButton" type="submit" class="g-btn g-btn--primary"
												onClick="resetExcelRequest();this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();">
												<fmt:message key="search" />
											</button>
											<input style="display: none;" type="submit" name="submitBtn" />
											<c:if test="${createExcel == true}">
												<button type="submit" class="g-btn g-btn--primary" onClick="excelRequest();this.form.pageNumber.value = 1;">
													<fmt:message key="exportToExcel" />
												</button>
											</c:if>
											<button type="reset" class="g-btn g-btn--secondary" onClick="resetExcelRequest();clearForm()">
												<fmt:message key="reset" />
											</button>
											<input type="hidden" id="excel" name="excel" value="NO" />
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="resultsDiv"></div>

	</form>

</body>
</html>
