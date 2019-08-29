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
<meta name="confidential" content="false">
<c:set var="title" value="addEditTask" />
<title><fmt:message key="${title}" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script language="javascript" src="<c:url value="/js/date.js" />"> </script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
<script type="text/javascript" >
var enterChars = '<fmt:message key="select2.enterChars"/>';
var userCount = ${fn:length(users)};
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
	var usersToDepartment = {
		<c:forEach var="user" items="${users}" varStatus="s">"${user.id}": "${user.department.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
	};
	var responsibleUserSelect = jQuery('#user');
	var responsibleDepartmentSelect = jQuery('#department');
	

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
	jQuery('select').select2({width:'300px'});
	jQuery('#cal .requiredHinted').remove();
	jQuery('.datetime').datepicker({format: "dd-MM-yyyy",autoclose: true,clearBtn:true});
	var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
	if(responsibleUser != null){
		jQuery('#user').val(responsibleUser);
	}
	if(userCount < maxListSize)
	{
		jQuery('#user').select2({width:'300px'});
	}else 
	{
   		jQuery('#user').select2({				  
		  width:'300px',
		  minimumInputLength : 3,
		  placeholder :  enterChars,
		  escapeMarkup: function(m) {
		        // Do not escape HTML in the select options text
		        return m;
		     },
		  ajax: {
		        url: "userTaskList.json",
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
		    	var data = {id: "<c:out value='${command.responsibleUser.id}'/>", text: "<c:out value='${command.responsibleUser.sortableName}'/>"};
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
<div class="content">
<scannell:form  onsubmit="return dateValidation();">
<scannell:hidden path="id" />
<scannell:hidden path="version" />
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="businessAreas" />
			</label>
			<div class="col-sm-6">
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
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="description" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="description"  class="form-control" cssStyle="float:left;width:95%"/>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="task.additionalInformation" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="additionalInformation"  class="form-control" cssStyle="float:left;width:95%"/>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="targetDate" />
			</label>
			<div class="col-sm-6">
				<div id="cal" style="float:left;width:200px;" class="input-group date datetime">
		           <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
		           <scannell:input class="form-control" path="targetDate" id="targetDate" readonly="true"  />
		             <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
		           </div>			
		          </div>
		          <span class="requiredHinted">*</span>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="responsibleUser" />
			</label>
			<div class="col-sm-6">
				<c:choose>
					<c:when test="${fn:length(users) lt 500}">
						<scannell:select id="user" path="responsibleUser" items="${users}" itemLabel="sortableName" itemValue="id" emptyOptionValue="" />
					</c:when>
					<c:otherwise>
						<input type="hidden" id="user" style="width:300px !important;"  name="responsibleUser" /><scannell:errors path="responsibleUser"/>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="responsibleDepartment" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="department" path="responsibleDepartment" items="${departments}" itemValue="id"
					itemLabel="name" activeItemsOnly="true" cssStyle="float:left;width:80%" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
				<fmt:message key="priority" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="priority" path="priority" items="${priorities}" itemValue="name" itemLabel="name" lookupItemLabel="true" emptyOptionValue="" emptyOptionLabel="blankOption" />
			</div>
		</div>

			<div style="clear: both;"></div>
			<div class="spacer2 text-center">
				<input type="submit" value="<fmt:message key="submit" />" class="g-btn g-btn--primary">
			</div>

</scannell:form>
</div>
</body>
</html>
