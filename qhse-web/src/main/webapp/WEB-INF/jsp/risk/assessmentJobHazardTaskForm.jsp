<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"> 
</script>
  <title>
   
  </title>
   <style type="text/css">
  

  </style>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script language="javascript" src="<c:url value="/js/date.js" />"> </script>
  <script language="javascript"  type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
  
  <script>
  var enterChars = '<fmt:message key="select2.enterChars"/>';
  var responsibleCount = ${fn:length(userList)};
  var maxListSize = 500;
  
  var hazardScoringAnswers=null;
  var scoringAnswersValue=null;
  jQuery(document).ready(function() {
	  jQuery('#targetTD').find('span').removeClass ( 'col-sm-10 sp' );

	  jQuery("form").submit(function() {
		  var user = jQuery('#user').val();
		  $.cookie('respUser', user);		 
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
	  jQuery('select').not('#siteLocation').not('#user').select2({width:"40%"});
	  hazardScoringAnswers='<%=request.getAttribute("hazardScoringAnswers")%>';
	  scoringAnswersValue='<%=request.getAttribute("scoringAnswersValue")%>';
  	
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
			updateWorkAreaOptions();
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
		
 		var userId = '<c:out value="${command.expressTask.responsibleUser.id}"/>';
		if(userId != null){
			jQuery('#user').val(userId);
		}
 		if(responsibleCount < maxListSize)
		{
 			if (jQuery(".errorMessage").text().length > 0) {
 				  var ckUser=$.cookie('respUser');
 				 jQuery("#user").select2().select2('val',ckUser);
 				   
 			  } 
			
			
			jQuery('#user').select2({width:'40%'});
		}else 
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
				        url: "userList.json",
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
				    	var id = '';
				    	var name = '';
				    	<c:if test="${command.expressTask != null && command.expressTask.responsibleUser != null}">
				    		id = '${command.expressTask.responsibleUser.id}';
				    		name = '${command.expressTask.responsibleUser.sortableName}';
				    	</c:if>
				    	var data = {id: id, text: name};
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
 			var msgError = '<span class=\"error\">'+jQuery('#cal2').find('.error').text()+'</span>'
 			jQuery('#cal2').find('.error').remove();
			jQuery('.targetDateError').append(msgError);
			
		}
 		var maxOriginalScore = false;
 		jQuery(".targetScore > option").each(function (){
 			if('${command.originalScore}' == jQuery(this).text()){
 				maxOriginalScore = true;
 				return;
 			}
 			if(maxOriginalScore){
 				jQuery(this).remove();
 			}
 		});
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
					return confirm("This action has a completion target of more than 60 days. All CAPAs should be completed within 60 days. Do you want to continue?");
				}
			}
		}
		return true;
  }
  
  function showScore(elem){
  		var form = jQuery("#taskForm"); 
  		jQuery("#creationDate").val("");
		form.submit();
  }
</script>
 <script type="text/javascript">
  jQuery(document).ready(function() {	 
	 	
		  jQuery(".date").find(".requiredHinted").remove();
	 
  });  
 
  </script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
</head>
<body>
<div class="header">
<h2> 
 <c:choose>
      <c:when test="${command.parentTask != null}"><fmt:message key="subTaskForm.title" /></c:when>
      <c:otherwise><fmt:message key="taskForm.title" /></c:otherwise>
    </c:choose>
</h2>
</div>

<scannell:form  id="taskForm" onsubmit = "return dateValidation(); ">
<input type="hidden" id="userDefaultSite"/>
<c:set var="task" value="${command.expressTask}" />
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive" id="taskTable">
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
	  </tr>

		<tr class="form-group">
		    <td class="searchLabel"><fmt:message key="task.status" />:</td>
		    <td class="search"><fmt:message key="task.${task.status}" /></td>
	    </tr>
  </c:if>
	<tr class="form-group">
		<td class="searchLabel">
			<fmt:message key="businessAreas" />
		</td>
		<td class="search">
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

  <c:if test="${not (command.parentTask == null)}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.parentTask" />:</td>
    <td class="search" >
      <c:url var="url" value="/risk/taskView.htm"><c:param name="id" value="${command.parentTask.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.parentTask.displayId}" /></a> -
      <scannell:text value="${command.parentTask.name}" />
    </td>
  </tr>
  </c:if>
  <c:if test="${task.id == null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="score.question" />:</td>
   	<td class="search" ><scannell:select id="scoringQuestion" path="scoringQuestion" items="${jobScoringQuestions}" itemLabel="name" itemValue="id" class="extraWide" onchange="showScore(this)"/></td>
  </tr>
  </c:if>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.name" />:</td>
    <td class="search" style="">
    		<scannell:textarea path="name" cols="80" rows="3" onkeydown="limitText(this.form.name,this.form.countdown,250);" cssStyle="clear: inherit;"
		onkeyup="limitText(this.form.name,this.form.countdown,250);"/>
		<br>
		<font size="1">You have <input readonly type="text" name="countdown" size="3" value="${desclength}" style="border: none">characters left.</font>
	</td>
  </tr>
  <tr class="form-group">
    <td  class="searchLabel"><fmt:message key="task.additionalInformation" />:</td>
    <td class="search" ><scannell:textarea path="additionalInformation" cols="80" rows="3" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="priority" />:</td>
	<td class="search" >
		<spring:bind path="command.priority">
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
    <td class="search"  >
      <%-- <input name="creationDate" id="creationDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'creationDate', true);"> --%>
      	<div id="cal"  style="width:450px;">
           <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
           		<scannell:input class="form-control" path="creationDate" id="creationDate" readonly="true" />
             	<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>

           </div>			
            <span class="requiredHinted">* </span>
         </div>
    </td>
  </tr>
 <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.targetCompletionDate" />:</td>
    <td class="search"  >
     <%--  <input name="targetCompletionDate" id="targetCompletionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'targetCompletionDate', true);"> --%>
       <div id="cal2"  style="width:450px;">
           <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
           		<scannell:input class="form-control" path="targetCompletionDate" id="targetCompletionDate" readonly="true" />
             	<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
           </div>			
            <span class="requiredHinted targetDateError">* </span>
       </div>
    </td>
  </tr>
  
  

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.responsibleUser" />:</td>
    <td class="search" >
    	<c:choose>
			<c:when test="${fn:length(userList) lt 500}">
				<scannell:select id="user" path="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id"  />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="user" name="responsibleUser"/> <scannell:errors path="responsibleUser" />		
			</c:otherwise>
		</c:choose>	
    </td>
  </tr>
  
  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="responsibleDepartment" /></td>
    <td class="search" ><scannell:select id="department" path="responsibleDepartment" items="${departments}" itemLabel="name" itemValue="id" class="wide" /></td>
  </tr>
  
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="workArea" />:</td>
    <td class="search" ><scannell:select id="workarea" path="responsibleWorkArea" items="${workareas}" itemLabel="name" itemValue="id" class="wide" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="locationArea" />:</td>
    <td class="search" ><scannell:select id="location" path="responsibleLocation" items="${locations}" itemLabel="name" itemValue="id" class="wide" /></td>
  </tr>
  
  <tr class="form-group" id="mprogramme">
    <td class="searchLabel"><fmt:message key="task.managementProgramme" />:</td>
    <td class="search">
    <c:choose>
    <c:when test="${command.parentTask != null and command.parentTask.managementProgramme != null}">
      <c:url var="url" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${command.parentTask.managementProgramme.id}" /></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.parentTask.managementProgramme.displayId}" /></a> -
      <c:out value="${command.parentTask.managementProgramme.name}"/>
    </c:when>
    <c:otherwise>
      <select name="managementProgramme" items="${managementProgrammeList}" itemLabel="name" itemValue="id" class="extraWide" /><br>
    </c:otherwise>
    </c:choose>
    </td>
  </tr>
	<!-- <c:forEach items="${jobScoringQuestions}" var="q" varStatus="s">
	<c:out value="${q.id}"/>
		<tr>
	 		<td id="${q.id}"><enviromanager:question path="answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false" /></td>
	 	</tr>
 	</c:forEach> -->
  <tr class="form-group" id="assessment">
    <td class="searchLabel" ><fmt:message key="task.assessment" />:</td>
    <td class="search">
      <c:url var="url" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${assessment.displayId}" /></a> -
      	<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
 		<c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
    </td>
  </tr>
  <c:if test="${selectedScoringQuestion != null}">
	   <tr class="form-group"><td class="searchLabel" ><fmt:message key="task.originalScore" />:</td>
	   		<td class="search" ><input name="originalScore" class="form-control" cssStyle="width:40%"  id="originalScore" readonly="true" /></td>
	   </tr>
		<tr class="form-group"><td class="searchLabel"><fmt:message key="task.targetScore" />:</td>
	   		<td id="targetTD" class="search" ><enviromanager:question class="targetScore extraWide" path="answers" question="${selectedScoringQuestion}" emptyOptionLabel="Choose" multiselectCheckboxes="false" cssStyle="width:40%" /></td>
	   </tr>
   </c:if>
 </tbody>
 <tfoot>
	  <tr id="footRow">
	    <td colspan="2" align="center">
	      <c:choose>
      			<c:when test="${task == null}"> 
      			 	<c:url var="cancelUrl" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}" /></c:url>
       			</c:when>
      			<c:otherwise>
      				<c:url var="cancelUrl" value="/risk/hazardTaskView.htm"><c:param name="id" value="${task.id}" /></c:url>
      			</c:otherwise>
    	  </c:choose>
	      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
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
