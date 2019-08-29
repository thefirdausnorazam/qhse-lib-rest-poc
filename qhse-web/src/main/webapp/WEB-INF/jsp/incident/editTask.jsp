<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="editTask" />
<c:if test="${command['new']}">
	<c:set var="title" value="createTask" />
</c:if>
<style type="text/css">
.errorValidation {
	display: none; margin-left: 10px;
}

.error_show {
	padding: 0; list-style: none; color: #cc0000;
}

input.invalid,textarea.invalid,div.invalid,select.invalid {
	border: 1px solid #c00 !important;
}

input.valid,textarea.valid,select.valid,div.valid {
	border: 1px solid #2598f9 !important; box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
}

.addon {
	background-color: transparent; border: transparent;
}
</style>
<title><fmt:message key="${title}" /></title>
<%-- <script language="javascript" src="<c:url value="/js/date.js" />"> </script> --%>
<script type="text/javascript" src="<scannell:resource value="/js/scannellDateCompare.js" />"></script>
  	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>

<script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var userCount = ${fn:length(users)};
	var maxListSize = 500;

jQuery(document).ready(function() {
	//jQuery("#user").select2();	
	jQuery("#priority").select2();
	jQuery("#department").select2();
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
		// When user is already selected in edit page change event does not get fired, maunally firing change event.
	//	jQuery('#user').trigger("change");
		
		var userSelectedDetails=[];
		userSelectedDetails.userId="${command.responsibleUser.id}";
		userSelectedDetails.department="${command.responsibleDepartment.id}";
		if('${command.responsibleUser.id}'.length>0){
		userSelectedDetails.newDepartment=usersToDepartment[parseInt('${command.responsibleUser.id}')];
		}
		setDepartmentforUser(userSelectedDetails);
		
		var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
		if(responsibleUser != null){
			jQuery('#user').val(responsibleUser);
		}
		if(userCount < maxListSize)
		{
			jQuery('#user').select2({width:'80%'});
		}
		else 
		{
			jQuery('#user').select2({				  
			  width:'80%',
			  placeholder :  enterChars,
			  minimumInputLength : 3,
			  escapeMarkup: function(m) {
			        // Do not escape HTML in the select options text
			        return m;
			     },
			  ajax: {
			        url: "taskUserList.json",
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
});


function dateValidation(cal, dateStr) {

	if (document.getElementById("targetDate") != null) {
		var dateStr = document.getElementById("targetDate").value;
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
<!-- 	<div class="header"> -->
<!-- 		<h2> -->
<%-- 			<fmt:message key="${title}" /> --%>
<!-- 		</h2> -->
<!-- 	</div> -->
	<div class="alert alert-danger hide" id="alrt">
		<a href="#" class="close" data-dismiss="alert">&times;</a>
		<strong>Warning!</strong> Please fix all required fields.
	</div>
	<scannell:form onsubmit="return dateValidation();">

		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<input type="hidden" id="userDefaultSite"/>

	<div class="form-group"  style="min-height:100px;">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</label>
    	<div class="col-sm-6">
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
    	</div>
  	</div>
		<div style="clear: both;"></div>
		<div class="form-group" >
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="description" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="description" id="description" cssStyle="float:left;width:80%" />
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="targetDate" />
			</label>
			<div class="col-sm-6" style="display: flex;">
	        	<spring:bind path="command.targetDate">
					<div style="width: 250px;">
						<c:choose>
							<c:when test="${command.completionDateEditableByCurrentUser}">
								<div class="input-group date datetime" data-min-view="2" data-date-format="dd-MM-yyyy" style="float:left">
										<%-- <scannell:input class="form-control" path="targetDate" id="targetDate" readonly="true"  />  --%>
										<input class="form-control" path="targetDate" id="targetDate" name="targetDate" size="6" type="text" readonly
											value="<fmt:formatDate type="date" value="${command.targetDate}" pattern="dd-MMM-yyyy" />" />
										<span class="input-group-addon btn btn-primary">
											<span class="glyphicon glyphicon-th"></span>
										</span>
								</div>
							</c:when>
							<c:otherwise>
								<input class="form-control" path="targetDate" id="targetDate" name="targetDate" size="6" type="text" readonly
											value="<fmt:formatDate type="date" value="${command.targetDate}" pattern="dd-MMM-yyyy" />" style="float:left;width:80%"/>
							</c:otherwise>
						</c:choose>
					</div>
					<span class="requiredHinted">*</span>
					<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
				</spring:bind>
			</div>

		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="responsibleUser" />
			</label>
			<div class="col-sm-6" id="responsible">
				<c:choose>
					<c:when test="${fn:length(users) lt 500}">
						<select name="responsibleUser" id="user" items="${users}" itemLabel="sortableName" itemValue="id" cssStyle="width:80%" />
					</c:when>
					<c:otherwise>
						<input type="hidden" id="user" style="width:80% !important;"  name="responsibleUser"/>
						<scannell:errors path="responsibleUser"/>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="responsibleDepartment" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="department" path="responsibleDepartment" items="${departments}" itemValue="id"
					itemLabel="name" activeItemsOnly="true" cssStyle="float:left;width:80%" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="priority" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="priority" cssStyle="float:left;width:80%" path="priority" items="${priorities}" itemValue="name"
					itemLabel="name" lookupItemLabel="true" />
			</div>
		</div>
		<div class="spacer2 text-center">
			<input type="submit" id="form_submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>

		</div>
	</scannell:form>

</body>
</html>
