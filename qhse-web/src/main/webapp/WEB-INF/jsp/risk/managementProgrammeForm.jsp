<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="managementProgrammeForm.title" /></title>
<script type='text/javascript' src="<c:url value="/dwr/interface/RiskDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script> 
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script language="javascript" type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
	
  <style type="text/css" media="all">   
     @import "<c:url value='/css/risk.css'/>";
  </style>
  <style type="text/css">
  td.search {
padding-left: 20px !important;
}

  </style>
  <script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var userCount = ${fn:length(userList)};
		var maxListSize = 500;

  
  jQuery(document).ready(function() {	
	  jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
	   jQuery("#department").select2();
	   jQuery("#workarea").select2();
	   jQuery("#location").select2();
	   jQuery("#objectiveId").select2({ width: '50%' });	  
	   jQuery("#percentCompleted").select2();	  
	   jQuery(".date").find(".requiredHinted").remove();
	   var usersToDepartment = {
				<c:forEach var="user" items="${userList}" varStatus="s">"${user.id}": "${user.department.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
			};
			var usersToDepartmentName = {
				<c:forEach var="user" items="${userList}" varStatus="s">"${user.id}": "${user.department.name}"<c:if test="${!s.last}">,</c:if></c:forEach>
			};
			
			updatePageOptions(usersToDepartment, usersToDepartmentName);
			
			jQuery('#user').change(function() {
				updateUserOptions(usersToDepartment, usersToDepartmentName);
			});
			jQuery('#department').change(function() {
				updateWorkAreaOptions2(usersToDepartment);
			});
			jQuery('#workarea').change(function() {
				updateLocationOptions();
			});
			
			var userSelectedDetails=[];
			userSelectedDetails.userId="${command.responsibleUser.id}";
			userSelectedDetails.department="${command.department.id}";
			userSelectedDetails.workArea="${command.workArea.id}";
			userSelectedDetails.location="${command.location.id}";
			if('${command.responsibleUser.id}'.length>0){
				userSelectedDetails.newDepartment=usersToDepartment[parseInt('${command.responsibleUser.id}')];
				}
			setDepartmentforUser(userSelectedDetails);

			if(userCount < maxListSize)
			{	
				jQuery('#user').select2({width:'50%'});
			}
			else 
			{
				jQuery('#user').select2({				  
				  width:'50%',
				  minimumInputLength : 3,
				  placeholder :  enterChars,
				  escapeMarkup: function(m) {
				        // Do not escape HTML in the select options text
				        return m;
				     },
				  ajax: {
				        url: "mPUserList.json",
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
				                        text: item.userName,	
				                        slug: item.slug,
				                        id: item.id
				                    }
				                })
				            };
				        }
				    },
				    initSelection: function (element, callback) {    	
				    	var data = {id: "<c:out value="${command.responsibleUser.id}"/>", text: "<c:out value="${command.responsibleUser.sortableName}"/>"};
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
			}
			
			if(jQuery('#cal2').find('.error').text() != ''){
				jQuery('.targetDateError').append('<span class="error">'+jQuery('#cal2').find('.error').text()+'</span>');
				jQuery('#cal2').find('.error').remove();
			}
  });
  
  function onChangeBusinessArea() {
	    var element = document.getElementById('objectiveId');	  
	    var selectedValue = jQuery('#'+element.id+' option:selected').text();	    
	    DWRUtil.removeAllOptions(element.id);
	    DWRUtil.addOptions(element.id, {"":"Please Wait..."});
	    var val = [];
	    jQuery('#businessAreas:checked').each(function(i){
          val[i] = jQuery(this).val();
        });	    
	    RiskDWRService.listActiveObjectives(val, function(data) { populateCallback(element, selectedValue, data); });  
  }
  function populateCallback(element, selectedValue, data) {
	DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":"Choose"});    
    DWRUtil.addOptions(element.id, data);
    // If the originally selected value can be selected, do so.
    for (i=0; i<element.options.length; i++) {
      if (element.options[i].value == selectedValue) {    	  
        element.selectedIndex = i;
      }
    }
    jQuery("#objectiveId").select2({ width: '50%' });
  }


  function limitText(limitField, limitCount, limitNum) {
  	if (limitField.value.length > limitNum) {
  		limitField.value = limitField.value.substring(0, limitNum);
  	} else {
  		limitCount.value = limitNum - limitField.value.length;
  	}
  }
  </script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><span class="nowrap"><fmt:message key="managementProgrammeForm.title" /></span></h2> --%>
<!-- </div> -->
<scannell:form>
<input type="hidden" id="userDefaultSite"/>
<div class="content">  
<div class="table-responsive">
<div class="panel hidden-print panel-danger" id="queryTablePanel"> 
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <c:if test="${managementProgramme.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${managementProgramme.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.status" />:</td>
    <td class="search"><fmt:message key="task.${managementProgramme.status}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3" class="search">
      <fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
      <c:choose>
        <c:when test="${multiSelect}">
        <spring:bind path="command.businessAreas">
          <label>
          <c:forEach var="ba" items="${businessAreaList}">
            <c:set var="selected" value="${false}" />
            <c:forEach items="${command.businessAreas}" var="selectedBA">
              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
            </c:forEach>

            <input type="checkbox" id="businessAreas"
                name="<c:out value="${status.expression}"/>"
                value="<c:out value="${ba.id}" />"
                <c:if test="${selected}">checked="checked"</c:if> onchange="onChangeBusinessArea();" />
            <c:out value="${ba.name}" /><br>

            <c:remove var="selected" />
          </c:forEach>
          </label>
          </div>
          <span class="requiredHinted">*</span>
          <%-- <span class="errorMessage"><c:out value="${status.errorMessage}" /></span> --%>
        </spring:bind>
        </c:when>
        <c:otherwise>

          <scannell:select id="businessAreas" path="businessAreas"
              items="${businessAreaList}" itemLabel="name" itemValue="id"
              cssStyle="width:40%" onchange="onChangeBusinessArea();"/>

        </c:otherwise>
      </c:choose>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.name" />:</td>
    <td colspan="3" class="search">
		<scannell:textarea path="name" cssStyle="width:60%" class="form-control" onkeydown="limitText(this.form.name,this.form.countdown,250);"
		onkeyup="limitText(this.form.name,this.form.countdown,250);"/>
		<font size="1">You have <input readonly type="text" name="countdown" size="3" value="${desclength}" style="border: none">characters left.</font>

	</td>

  </tr>
  <tr class="form-group">
		<td class="searchLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
		<td class="search nowrap">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="creationDate" id="creationDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
                  <span class="requiredHinted">*</span>
                </td>

	</tr>
	
	  <tr class="form-group">
                <td class="searchLabel nowrap"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
                <td class="search nowrap">			
			<div  style="width:250px;">
                  <div id="cal2" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left;">
                  <scannell:input class="form-control" path="targetCompletionDate" id="targetCompletionDate" readonly="true" />
                                  <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>       
                  </div>			
                 
                </div>
                
		  <span class="requiredHinted targetDateError" >*</span>
		</td>
	</tr>
  

  <%-- <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
    <td class="col-md-3 search" >      
      <input name="creationDate" id="creationDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'creationDate', true);">
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
    <td class="col-md-3 search">      
      <input name="targetCompletionDate" id="targetCompletionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'targetCompletionDate', true);">
    </td>
  </tr> --%>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.responsibleUser" />:</td>
    <td colspan="3" class="search">
       <c:choose>
			<c:when test="${fn:length(userList) lt 500}">
				<select name="responsibleUser" id="user" items="${userList}" itemLabel="sortableName" itemValue="id" cssStyle="width:50%" />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="user" style="width:50% !important;"  name="responsibleUser" />
				<scannell:errors path="responsibleUser"/>
			</c:otherwise>
		</c:choose>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="managementProgramme.department" />:</td>
    <td colspan="3" class="search"><select name="department" id="department" items="${departments}" itemLabel="name" itemValue="id" cssStyle="width:50%" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="workArea" />:</td>
    <td colspan="3" class="search"><scannell:select id="workarea" path="workArea" items="${workareas}" itemLabel="name" itemValue="id" class="wide" cssStyle="width:50%" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="locationArea" />:</td>
    <td colspan="3" class="search"><scannell:select id="location" path="location" items="${locations}" itemLabel="name" itemValue="id" class="wide" cssStyle="width:50%" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.objective" />:</td>
    <td colspan="3" class="search">
    <fmt:message var="emptyObjectiveLabel" key="emptyObjectiveDropdownLabel" />
      <scannell:select id="objectiveId" path="objectiveId" items="${objectiveList}" itemLabel="name" itemValue="id" class="wide" emptyOptionLabel="${emptyObjectiveLabel}" /><br>
<!-- Removed as the data entered on this screen was lost when you clicked to create a new objective.
      <c:if test="${userHasRiskManagementAccess}">
      <a href="<c:url value="/risk/objectiveEdit.htm" />"><fmt:message key="managementProgramme.createObjective" /></a>
      </c:if>
-->
    </td>
  </tr>

<%
java.util.Collection<Integer> c = new java.util.ArrayList<Integer>();
for (int i=0; i<=20; i++) {
  c.add(new Integer(i*5));
}
pageContext.setAttribute("percentages", c);
%>
  <c:if test="${managementProgramme.id != null}"><%-- Percent fields are only displayed for an edit. --%>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.percentCompleted" />:</td>
    <td class="search"><select name="percentCompleted" id="percentCompleted" items="${percentages}" renderEmptyOption="false"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.progressComment" />:</td>
    <td colspan="3" class="search"><scannell:textarea cssStyle="width:40%" path="progressComment"  /></td>
  </tr>
  </c:if>

  <c:if test="${managementProgramme.completedByUser != null}" >
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.completedBy" />:</td>
    <td  class="search"><c:out value="${managementProgramme.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.completionComment" />:</td>
    <td class="search" ><c:out value="${managementProgramme.completionComment}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
  <c:choose>
  <c:when test="${managementProgramme.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${managementProgramme.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td  class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="3" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <c:choose>
        <c:when test="${managementProgramme.id gt 0}">
          <c:url var="cancelUrl" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}"/></c:url>
        </c:when>
        <c:when test="${param.objectiveId gt 0}">
          <c:url var="cancelUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${param.objectiveId}"/></c:url>
        </c:when>
        <c:otherwise>
	        <c:url var="cancelUrl" value="/risk/managementProgrammeQueryForm.htm" />
        </c:otherwise>
      </c:choose>
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelUrl}" />';">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
