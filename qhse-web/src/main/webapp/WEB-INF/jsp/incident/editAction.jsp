<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
}
</style>
<fmt:message key="${command['class'].name}" var="typeName" />
<c:set var="title" value="editAction" />
<c:if test="${command['new']}"><c:set var="title" value="addAction" /></c:if>
<title><fmt:message key="${title}"><fmt:param value="${typeName}" /></fmt:message></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script language="javascript" src="<c:url value="/js/date.js" />"> </script>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/showUsers.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>

<script type="text/javascript" >
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var userCount = ${fn:length(users)};
	var maxListSize = 500;
	
jQuery(document).ready(function() {
	/* jQuery("#capaType").prepend("<option value=''> Choose </option>").val(''); */
		jQuery("#category").select2();
	jQuery("#capaType").select2();
	 jQuery(".date").find(".requiredHinted").remove();
	/* jQuery("#responsibleUser").prepend("<option value=''> Choose </option>").val(''); */
	//jQuery("#user").select2();
	/* jQuery("#responsibleDepartment").prepend("<option value=''> Choose </option>").val(''); */
	jQuery("#department").select2();
	/* jQuery("#priority").prepend("<option value=''> Choose </option>").val(''); */
	jQuery("#priority").select2();

	var usersToDepartment = {
			<c:forEach var="user" items="${users}" varStatus="s">"${user.id}": "${user.department.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
	};
	var usersToDepartmentName = {
		<c:forEach var="user" items="${users}" varStatus="s">"${user.id}": "${user.department.name}"<c:if test="${!s.last}">,</c:if></c:forEach>
	};
	updatePageOptions(usersToDepartment, usersToDepartmentName);
	jQuery('#user').change(function() {
		updateUserDepartmentOptions(usersToDepartment, usersToDepartmentName);
	});
	
	var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
	if(responsibleUser != null){
		jQuery('#user').val(responsibleUser);
	}

	showUserList(${fn:length(users)}, "user", "30", "actionUserList.json", "<c:out value="${command.responsibleUser.id}"/>", "<c:out value="${command.responsibleUser.sortableName}"/>");
	
	var responsibleDept= '<c:out value="${command.responsibleDepartment.id}"/>';
	if(responsibleDept != null){
		jQuery('#department').val(responsibleDept);
	}  
	
	//when page reloads then also we need to update functional group.
	updateUserDepartmentOptions(usersToDepartment, usersToDepartmentName);
	setTimeout(function() { populateDepartment(); }, 350);
	
	var divErrorMessage = jQuery('#dateTimeDiv').find("span.error");
	jQuery('#dateTimeDiv').find("span.error").remove();
	jQuery('#cal').append(divErrorMessage);
});
function populateDepartment() {
	var responsibleDept= '<c:out value="${command.responsibleDepartment.id}"/>';
	if(responsibleDept != null){
		jQuery("#department").select2().select2('val', responsibleDept);
		jQuery('#department').select2({ 'width':'resolve' });
	}
}

function dateChanged(cal, dateStr) {
	cal.sel.value = dateStr; // just update the date in the input field.
	if (cal.dateClicked && cal.isPopup) {
		cal.callCloseHandler();
	}
	if (cal.sel.id == "completionTargetDate") {
		if (document.getElementById("completionTargetDate") != null) {
			var dateStr = document.getElementById("completionTargetDate").value;
			var completionTargetDate = Date.parseExact(dateStr, "dd-MMM-yyyy");
			if (completionTargetDate != null) {
				// add popup check here
				// var occurredDate = Date.setTime(parseInt('<c:out value="${occurredDateMs}" />'));
				var occurredDate = new Date(parseInt('<c:out value="${occurredDateMs}" />'));
				// var occurredDate = occurredDateStr.parseExact(occuredDateStr, "yyyy-MM-dd");
				var daysToAdd = parseInt("<fmt:message key="incident.completionTargetWarningDays" />");
				occurredDate.add(daysToAdd).days();
				if (completionTargetDate.getTime()> occurredDate.getTime()) {
					//alert("This Action has a completion Target Date of more than 60 days");
				}
			}
		}
	}
}
// onCalendarSelectHandler = dateChanged;

function dateValidation(cal, dateStr) {

	if (document.getElementById("completionTargetDate") != null) {
		var dateStr = document.getElementById("completionTargetDate").value;
		var completionTargetDate = Date.parseExact(dateStr, "dd-MMM-yyyy");
		if (completionTargetDate != null) {
			// add popup check here
			// var occurredDate = Date.setTime(parseInt('<c:out value="${occurredDateMs}" />'));
			var occurredDate = new Date(parseInt('<c:out value="${occurredDateMs}" />'));
			// var occurredDate = occurredDateStr.parseExact(occuredDateStr, "yyyy-MM-dd");
			var daysToAdd = parseInt("<fmt:message key="incident.completionTargetWarningDays" />");
			occurredDate.add(daysToAdd).days();
			if (completionTargetDate.getTime()> occurredDate.getTime()) {
				//return confirm("This action has a completion target of more than 60 days. All CAPAs should be completed within 60 days. Do you want to continue?");
			}
		}
	}
	return true;
}

</script>

<style type="text/css" media="all">
@import "<c:url value='/css/scannell-tooltip.css'/>";
    @import "<c:url value='/css/calendar.css'/>";
</style>


</head>
<body onload="onPageLoad();">
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}"><fmt:param value="${typeName}" /></fmt:message></h2> --%>
<!-- </div> -->
<script type="text/javascript" >
var isActionExisting;
function onPageLoad() {
    //onTypeChange();
}

//function onTypeChange() {
//document.getElementById("type").value;
//  var isActionExisting = document.getElementById("type").value != "";
//  document.getElementById("type").disabled = isActionExisting;
// }
</script>

<scannell:form  onsubmit="return dateValidation();">
<scannell:hidden path="id" />
<scannell:hidden path="version" />
<input type="hidden" id="userDefaultSite"/>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
<table class="table table-bordered table-responsive">
    <col  />
<tbody>  
  <c:if test="${not empty categories}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="category" /></td>
    <td class="search"><scannell:select id="category" path="category" items="${categories}" itemValue="id" itemLabel="name" cssStyle="width:300px;" /></td>
  </tr>
  </c:if>

	<tr class="form-group">
    	<td class="searchLabel"><fmt:message key="businessAreas" />:</td>
    	<td class="search">
      		<fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
	        <spring:bind path="command.businessAreas">
	          <c:forEach var="ba" items="${businessAreaList}">
	            <c:set var="selected" value="${false}" />
	            <c:forEach items="${command.businessAreas}" var="selectedBA">
	              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
	            </c:forEach>
	
	            <input class="ckbBA" type="checkbox" id="businessAreas"
	                name="<c:out value="${status.expression}"/>"
	                value="<c:out value="${ba.id}" />"
	                <c:if test="${selected}">checked="checked"</c:if> />
	            <c:out value="${ba.name}" /><br>
	
	            <c:remove var="selected" />
	          </c:forEach>
	          <span class="requiredHinted">*</span>
	          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
	        </spring:bind>
    	</td>
  	</tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="description" /></td>
    <td  class="search"><scannell:textarea path="description" cols="50" rows="3" /></td>
  </tr>
  <tr class="form-group">		
	<td class="searchLabel"><fmt:message key="capaType" /></td>	
    <td  class="search"><scannell:select id="capaType" path="capaType" items="${capaTypes}" itemValue="name" lookupItemLabel="true" cssStyle="width:300px;" />
    <div class="scannell-tooltip"><img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>" ><span class="tooltiptext"><fmt:message key="actionCapaTypeTooltip" /></span></div></td>
  <tr class="form-group">		
	<td class="searchLabel"><fmt:message key="priority" /></td>	
    <td  class="search"><scannell:select id="priority" path="priority" cssStyle="width:300px;" items="${priorities}" itemValue="name" itemLabel="name" lookupItemLabel="true" emptyOptionValue="" emptyOptionLabel="blankOption" /></td>
  </tr>	
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="completionTargetDate" /></td>
    <td class="search">
    <div id="cal" style="width:300px;">
    	<c:choose>
	    	<c:when test="${command.completionDateEditableByCurrentUser}">
                <div id="dateTimeDiv" class="input-group date datetime" data-min-view="2" data-date-format="dd-MM-yyyy" style="float:left;width:200px;">
                 	<input name="completionTargetDate" id="completionTargetDate" class="form-control" readonly="true"  />
              		<!--   <input type="text" id="idPlaceHolderEndDate" name="incident.investigation.recouperationPeriods.periodEndDate" class="form-control" readonly="readonly">	 -->					     
                    <span class="input-group-addon btn btn-primary" ><span class="glyphicon glyphicon-th"></span></span>
                  </div>		
                <span class="requiredHinted">*</span>
			</c:when>
			<c:otherwise>
            	<input name="completionTargetDate" id="completionTargetDate" class="form-control" readonly="true" />
			</c:otherwise>
		</c:choose>  </div>            
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="responsibleUser" /></td>
    <td class="search">
		<c:choose>
			<c:when test="${fn:length(users) lt 500}">
				<scannell:select id="user" cssStyle="width:300px;" path="responsibleUser" items="${users}" itemLabel="sortableName" itemValue="id" emptyOptionValue="" />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="user" style="width:300px !important;"  name="responsibleUser"/>
				<scannell:errors path="responsibleUser"/>
			</c:otherwise>
		</c:choose>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="responsibleDepartment" /></td>
    <td class="search"><scannell:select id="department" cssStyle="width:300px;" path="responsibleDepartment" items="${departments}" itemValue="id" itemLabel="name" activeItemsOnly="true" class="wide" />
    <div class="scannell-tooltip"><img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>" ><span class="tooltiptext"><fmt:message key="actionResponsibleDepartmentTooltip" /></span></div></td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input class="g-btn g-btn--primary" type="submit" value="<fmt:message key="submit"/>"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
