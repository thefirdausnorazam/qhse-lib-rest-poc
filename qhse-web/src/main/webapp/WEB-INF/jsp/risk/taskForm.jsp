<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title>
    
  </title>
  
  <style type="text/css">
 td.search {
/*padding-left: 5%!important; this padding was causing some strange behaviour on IE*/ 
margin-left: 10px;
}
td.search2 {
	padding-left: 50px !important;
	background-color: white !important;
	border-width: 0px !important;
	text-align: left;

}
 </style>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script language="javascript" src="<c:url value="/js/date.js" />"> </script>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
  
  <script>

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
	  jQuery('select').select2();
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
		userSelectedDetails.department="${command.responsibleDepartment.id}";
		userSelectedDetails.workArea="${command.responsibleWorkArea.id}";
		userSelectedDetails.location="${command.responsibleLocation.id}";
		if('${command.responsibleUser.id}'.length>0){
		userSelectedDetails.newDepartment=usersToDepartment[parseInt('${command.responsibleUser.id}')];
		}
		setDepartmentforUser(userSelectedDetails);
		
		if(userCount < maxListSize)
		{	
			jQuery('#user').select2({width:'40%'});
		}
		else 
		{
	   		jQuery('#user').select2({				  
			  width:'40%',
			  minimumInputLength : 3,
			  placeholder :  enterChars,
			  escapeMarkup: function(m) {
			        // Do not escape HTML in the select options text
			        return m;
			     },
			  ajax: {
			        url: "taskUserList.json",
			        dataType: 'json',
			        type: "GET",
			        quietMillis: 500,
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
					
			});
		}
	   	
		
		var obj2 = jQuery("#cal2 .error");
		if(obj2.text().length > 0) {
			var obj = jQuery("#cal2");
			jQuery("#cal2 .error").remove();
			jQuery("#completionDateDiv").append(obj2);
		}
  });

  function limitText(limitField, limitCount, limitNum) {
  	if (limitField.value.length > limitNum) {
  		limitField.value = limitField.value.substring(0, limitNum);
  	} else {
  		limitCount.value = limitNum - limitField.value.length;
  	}
  }

  function dateValidation(cal, dateStr) {

		if (document.getElementById("targetCompletionDate") != null) {
			var dateStr = document.getElementById("targetCompletionDate").value;
			var completionTargetDate = Date.parseExact(dateStr, "dd-MMM-yyyy");
			if (completionTargetDate != null) {
				// add popup check here
				// var occurredDate = Date.setTime(parseInt('<c:out value="${occurredDateMs}" />'));
				var myDate = new Date();
				// var occurredDate = new Date(parseInt('<c:out value="${occurredDateMs}" />'));
				// var occurredDate = occurredDateStr.parseExact(occuredDateStr, "yyyy-MM-dd");
				var daysToAdd = parseInt("<fmt:message key="incident.completionTargetWarningDays" />");
				myDate.add(daysToAdd).days();
				if (completionTargetDate.getTime()> myDate.getTime()) {
					//return confirm("This action has a completion target of more than 60 days. All CAPAs should be completed within 60 days. Do you want to continue?");
				}
			}
		}
		return true;
  }
  </script>
  
  
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
</head>
<body>
<div class="header nowrap">
<h2>
<c:choose>
      <c:when test="${command.parentTask != null}"><fmt:message key="subTaskForm.title" /></c:when>
      <c:otherwise><fmt:message key="taskForm.title" /></c:otherwise>
    </c:choose>
</h2>
</div>
<scannell:form  onsubmit = "return dateValidation();">
<input type="hidden" id="userDefaultSite"/>
<c:set var="task" value="${command.task}" />
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered">
<col  />
<tbody>
  <c:if test="${task.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${task.displayId}" />
    </td>

    <td class="searchLabel" style="margin-left:-30px;padding-left: 0px !important"><fmt:message key="task.status" />:</td>
    <td class="search" style="margin-left:-30px;padding-left: 0px !important;width:20%"><fmt:message key="task.${task.status}" /></td>
  </tr>
  </c:if>

  <c:if test="${not (command.parentTask == null)}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.parentTask" />:</td>
    <td colspan="3" class="search">
      <c:url var="url" value="/risk/taskView.htm"><c:param name="id" value="${command.parentTask.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.parentTask.displayId}" /></a> -
      <scannell:text value="${command.parentTask.name}" />
    </td>
  </tr>
  </c:if>
	<tr class="form-group">
		<td class="searchLabel">
			<fmt:message key="businessAreas" />
		</td>
		<td colspan="3" class="search">
			<spring:bind path="command.businessAreas">
	         	<label style="font-weight: normal;">
	          		<c:forEach var="ba" items="${businessAreaList}">
	            		<c:set var="selected" value="${false}" />
	            		<c:forEach items="${command.businessAreas}" var="selectedBA">
	              			<c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
	            		</c:forEach>
	
	            		<input type="checkbox" id="businessAreas"
	                		name="<c:out value="${status.expression}"/>"
	                		value="<c:out value="${ba.id}" />"
	                		<c:if test="${selected}">checked="checked"</c:if> />
	            			<c:out value="${ba.name}" /><br>
	            		<c:remove var="selected" />
	          		</c:forEach>
	         	</label>
	          	<span class="requiredHinted">*</span>
	          	<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
	        </spring:bind>
		</td>
	</tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.name" />:</td>
    <td colspan="3" class="search">
    		<scannell:textarea path="name" cols="80" rows="3" onkeydown="limitText(this.form.name,this.form.countdown,250);"
		onkeyup="limitText(this.form.name,this.form.countdown,250);"/>
		<br>
		<font size="1">You have <input readonly type="text" name="countdown" size="3" value="${desclength}" style="border: none">characters left.</font>
	</td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3" class="search"><scannell:textarea path="additionalInformation" cols="80" rows="3" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="priority" />:</td>
	<td colspan="3" class="search"><spring:bind path="command.priority">
	<select id="priority" name="priority" >
		<option value=""><fmt:message key="blankOption" /></option>		
			<c:forEach items="${priorities}" var="item">
				<option value="<c:out value="${item.name}" />"
					<c:if test="${item == task.priority}">selected="selected"</c:if>><fmt:message
						key="${item}" /></option>
			</c:forEach>
		</select>
		<div class="errorMessage"><c:out
			value="${status.errorMessage}" /></div>

		</spring:bind>
		</td>		
  </tr>	

  <tr class="form-group">
  <td class="searchLabel"><fmt:message key="task.creationDate" />:</td>
		<td class="search">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="creationDate" id="creationDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
                  <span class="requiredHinted">*</span>
                </td>
  
  
  
  </tr>
  <tr>
       <td class="searchLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
        <td class="search" >			
			<div  id="completionDateDiv">
                  <div id="cal2" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="targetCompletionDate" id="targetCompletionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>                     
                  </div>			
                 <span class="requiredHinted">*</span>
                </div>
		  
		</td>
  </tr>

   <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.responsibleUser" />:</td>
    <td class="search" colspan="3">
    	<c:choose>
			<c:when test="${fn:length(userList) lt 500}">
				<scannell:select id="user" path="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id" cssStyle="width:40%"  />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="user" style="width:40% !important;"  name="responsibleUser" /><scannell:errors path="responsibleUser"/>
			</c:otherwise>
		</c:choose>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="responsibleDepartment" /></td>
    <td class="search" colspan="3"><scannell:select id="department" path="responsibleDepartment" items="${departments}" itemLabel="name" itemValue="id" cssStyle="width:40%"  /></td>
  </tr>
  
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="workArea" />:</td>
    <td class="search" colspan="3"><scannell:select id="workarea" path="responsibleWorkArea" items="${workareas}" itemLabel="name" itemValue="id" cssStyle="width:40%"  /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="locationArea" />:</td>
    <td class="search" colspan="3"><scannell:select id="location" path="responsibleLocation" items="${locations}" itemLabel="name" itemValue="id" cssStyle="width:40%"  /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.managementProgramme" />:</td>
    <td colspan="3" class="search">
    <c:choose>
    <c:when test="${command.parentTask != null and command.parentTask.managementProgramme != null}">
      <c:url var="url" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${command.parentTask.managementProgramme.id}" /></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.parentTask.managementProgramme.displayId}" /></a> -
      <c:out value="${command.parentTask.managementProgramme.name}"/>
    </c:when>
    <c:otherwise>
      <select name="managementProgramme" id="managementProgramme" items="${managementProgrammeList}" itemLabel="name" itemValue="id" cssStyle="width:40%" /><br>
<%-- Removed as the data entered on this screen was lost when you clicked to create a new management programme.
      <c:if test="${userHasRiskManagementAccess}">
      <a href="<c:url value="/risk/managementProgrammeEdit.htm" />"><fmt:message key="task.createManagementProgramme" /></a>
      </c:if>
--%>
    </c:otherwise>
    </c:choose>
    </td>
  </tr>

  <c:if test="${not (command.score == null)}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.assessment" />:</td>
    <td colspan="3" class="search">
      <c:url var="url" value="/risk/assessmentView.htm"><c:param name="id" value="${command.score.assessment.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.score.assessment.displayId}" /></a> -
      <c:if test="${command.score.assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  <c:if test="${command.score.assessment.sensitiveDataViewable}"><scannell:text value="${command.score.assessment.name}" /></c:if>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="score.question" />:</td>
    <td colspan="3" class="search"><scannell:text value="${command.score.question.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.originalScore" />:</td>
    <td colspan="3" class="search"><scannell:text value="${command.score.selectedOption.score} - ${command.score.selectedOption.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="score.justification" />:</td>
    <td colspan="3" class="search"><scannell:text value="${command.score.justification}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.targetScore" />:</td>
    <td colspan="3" class="search"><select name="targetScore" id="targetScore" items="${command.score.options}" itemLabel="scoreName" itemValue="id" cssStyle="width:40%" /></td>
  </tr>
  </c:if>

  <c:if test="${task.completedByUser != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.completedBy" />:</td>
    <td class="search"><scannell:text value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="searchLabel"><fmt:message key="task.achieved" />:</td>
    <td><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.completionComment" />:</td>
    <td class="search"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
  <c:choose>
  <c:when test="${task.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><scannell:text value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${task.lastUpdatedByUser != null}">
    <td class="searchLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><scannell:text value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <c:choose>
        <c:when test="${task.id gt 0}">
          <c:url var ="cancelUrl" value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>
        </c:when>
        <c:when test="${param.showId != null}">
          <c:url var ="cancelUrl" value="/risk/taskView.htm"><c:param name="id" value="${param.showId}"/></c:url>
        </c:when>
        <c:when test="${param.taskId != null}"><%-- Parent task creating a sub task --%>
          <c:url var ="cancelUrl" value="/risk/taskView.htm"><c:param name="id" value="${param.taskId}"/></c:url>
        </c:when>
        <c:when test="${param.assessmentId != null}"><%-- Risk Assessment Task --%>
          <c:url var="cancelUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${param.assessmentId}" /></c:url>
        </c:when>
        <c:when test="${command.score != null}"><%-- Risk Assessment Task --%>
          <c:url var ="cancelUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${command.score.assessment.id}"/></c:url>
        </c:when>
        <c:when test="${param.managementProgrammeId != null}"><%-- Management Programme Task --%>
          <c:url var="cancelUrl" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${param.managementProgrammeId}" /></c:url>
        </c:when>
        <c:otherwise>
          <c:url var="cancelUrl" value="/risk/home.htm" />
        </c:otherwise>
      </c:choose>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelUrl}" />'">
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
