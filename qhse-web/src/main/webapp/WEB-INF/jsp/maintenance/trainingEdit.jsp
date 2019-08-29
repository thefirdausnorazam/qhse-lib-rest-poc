<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<c:set var="title" value="maintenance.trainingEdit.title" />
<c:if test="${command.exam['new']}">
	<c:set var="title" value="maintenance.trainingCreate.title" />
</c:if>

	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>	
	<script type="text/javascript" src="<c:url value="/js/maintenance/frequencyOption.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/showUsers.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('select').not('#siteLocation').not("#user").select2({width:'300px'});
		
		showUserList(${fn:length(users)}, "user", "30", "activeUserList.json", "<c:out value="${command.exam.responsible.id}"/>", "<c:out value="${command.exam.responsible.sortableName}"/>");
		
		onLoadFunction();
		//exam.dueDate.errors
		var spanErrorMessage = jQuery('#dateTimeDiv span.error');
		jQuery('#dateTimeDiv').find('span.error').remove();
		jQuery('#dateDiv').append(spanErrorMessage);
		
		onTraineeTypeChange();
		
 });
	function onTraineeTypeChange() {
		if (jQuery('#traineeType').val() == 'u') {
			jQuery('#userTraineeForm').show();
			jQuery('#t_traineesDiv').hide();			

		} else {
			jQuery('#t_traineesDiv').show();
			jQuery('#userTraineeForm').hide();
		}
		setNewTraineeVisibility();
	}

	function setNewTraineeVisibility() {
		if (jQuery('#traineeType').val() == 't' && jQuery('#t_trainees').val() == '0') {
			jQuery('#newTraineeForm').show();			
		} else {
			jQuery('#newTraineeForm').hide();			
		}
	}

	function onLoadFunction(){
		frequencyOptionAction();

	}
	</script>

	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
		
	</style>
	<title><fmt:message key="${title}" /></title>
</head>
<body >
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
<table class="table table-bordered table-responsive">
	
	<col  />
	<tbody>
		<c:set var="onChangeAction"                value="setNewTraineeVisibility()" />
		<c:set var="emptyOptionLabel"              value="thirdPartyTraineeCreate" />
		<c:set var="multipleIntervalTypeAction"    value="multipleIntervalTypeAction()" />
		<c:set var="fractionIntervalTypeAction"    value="fractionIntervalTypeAction()" />
		<c:set var="userDefinedIntervalTypeAction" value="userDefinedIntervalTypeAction()" />
		<c:set var="frequencyOptionAction"         value="frequencyOptionAction()" />
		<c:set var="multipleIntervalAmountAction"  value="multipleIntervalAmountAction()" />

		<c:if test="${!command.exam['new']}">
			<tr class="form-group">
				<td class="searchLabel" ><fmt:message key="training.category" />:</td>
				<td class="search"><c:out value="${command.exam.category.name}" /></td>
			</tr>
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="maintenance.trainingEdit.trainee" />:</td>
				<td class="search"><c:out value="${command.exam.trainee.description}" /></td>
			</tr>
		</c:if>

		<c:if test="${command.exam['new']}">
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="training.category" />:</td>
				<td class="search"><scannell:select class="wide" id="exam.category" path="exam.category" items="${categories}" itemValue="id" itemLabel="name"
					renderEmptyOption="true" emptyOptionLabel="noneOrNew" /></td>
			</tr>

			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="training.newCategory" />:</td>
				<td class="search"><input type="text" name="newCategory" size="50" /></td>
			</tr>

			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="traineeType" />:</td>
				<td class="search">
					<scannell:select id="traineeType" path="traineeType" onchange="onTraineeTypeChange();" renderEmptyOption="false">
						<scannell:option value="u" labelkey="traineeType[u]" />
						<scannell:option value="t" labelkey="traineeType[t]" />
					</scannell:select>
				</td>
			</tr>

			<tr class="form-group">
				<td class="searchLabel" style="width:40%"><fmt:message key="trainee" />:</td>
				<td class="search">
					<table id="userTraineeForm"
						<c:if test="${command.traineeType != 'u'}"> style="display: none;"</c:if>>
						<tbody>
							<tr>
								<td style="width:30%"><fmt:message key="employee" />:</td>
								<td>
									<scannell:select id="u_trainees" path="user" items="${userTrainees}" itemValue="id" itemLabel="sortableName" class="wide" />
									<scannell:errors path="userTrainee.user" />
								</td>
							</tr>
							<tr>
								<td ><fmt:message key="department" />:</td>
								<td>
									<select name="department" items="${locations}" itemValue="id" itemLabel="name" class="wide" />
									<scannell:errors path="userTrainee.department" />
								</td>
							</tr>
						</tbody>
					</table>
<div id="t_traineesDiv" ${command.traineeType == 't' ? '' : 'style="display:none"'}>
					<scannell:select id="t_trainees" path="thirdPartyTrainee.id" items="${thirdPartyTrainees}" itemValue="id"
						itemLabel="description" 
						onchange="${onChangeAction}" emptyOptionValue="0" emptyOptionLabel="${emptyOptionLabel}" class="wide" />
					<scannell:errors path="thirdPartyTrainee" class="errorMessage" />
					<scannell:errors path="exam.trainee" class="errorMessage" writeRequiredHint="false" />
					<scannell:errors path="userTrainee" class="errorMessage" />
            </div>        
					<table class="table table bordered table-responsive" id="newTraineeForm" style="display: none; margin-top:10px">
						<tbody>
							<tr>
								<td style="width:30%"><fmt:message key="name" />:</td>
								<td><input name="thirdPartyTrainee.name" class="wide" /></td>
							</tr>
							<tr>
								<td ><fmt:message key="company" />:</td>
								<td><input name="thirdPartyTrainee.company" class="wide" /></td>
							</tr>
							<tr>
								<td ><fmt:message key="address" />:</td>
								<td><input name="thirdPartyTrainee.address" class="wide" /></td>
							</tr>
							<tr>
								<td ><fmt:message key="phoneNumber" />:</td>
								<td><input name="thirdPartyTrainee.phoneNumber" /></td>
							</tr>
							<tr>
								<td ><fmt:message key="emailAddress" />:</td>
								<td><input name="thirdPartyTrainee.emailAddress" /></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</c:if>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="description" />:</td>
			<td class="search"><scannell:textarea path="exam.description" cssStyle="width:50%" /></td>
		</tr>

		<tr class="form-group">
			<spring:bind path="command.exam.responsible">
				<td class="searchLabel"><fmt:message key="training.responsible" />:</td>
				<td class="search">
					<c:choose>
						<c:when test="${fn:length(users) lt 500}">
							<scannell:select id="user" cssStyle="width:300px;" path="exam.responsible" items="${users}" itemLabel="sortableName" itemValue="id" emptyOptionValue="" />
						</c:when>
						<c:otherwise>
							<input type="hidden" id="user" style="width:300px !important;" name="exam.responsible" />
							<scannell:errors path="exam.responsible"/>
						</c:otherwise>
					</c:choose>
				</td>
			</spring:bind>
		</tr>


		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.trainingEdit.initialMaintenanceDate" />:</td>
			<td class="search">
			<c:choose>
				<c:when test="${!command.exam['new']}">
					 <c:if test="${editInitialMaintenanceDate == true}">
					 	<scannell:input id="exam.initialMaintenanceDate" class="narrow" path="exam.initialMaintenanceDate" readonly="${true}" cssStyle="background-color:#E0E0E0"/>
					 </c:if>
			<c:if test="${editInitialMaintenanceDate != true}">
						<div style="width:350px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input id="exam.initialMaintenanceDate" class="form-control" path="exam.initialMaintenanceDate" readonly="${true}" />
                   <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                 
                  </div>					
                </div>
			</c:if>
				</c:when>
				<c:otherwise>
				<div style="width:350px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input id="exam.initialMaintenanceDate" class="form-control" path="exam.initialMaintenanceDate" readonly="${true}" />
                   <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                 
                  </div>					
                </div>					
				</c:otherwise>
			</c:choose>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="training.replacementFrequency" />:</td>
			<td class="search"><scannell:select id="frequencyOption" path="exam.frequencyOption" items="${frequencyOptions}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${frequencyOptionAction}" />

			<div id="multiple" style="display: none;">
				<fmt:message key="maintenance.trainingEdit.everytime" />
				<scannell:input id="multipleIntervalAmount" path="exam.multipleIntervalAmount" class="narrow" onchange="${multipleIntervalAmountAction}"/>
				<scannell:select id="multipleIntervalType" path="exam.multipleIntervalType" items="${multipleFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${multipleIntervalTypeAction}" />
			</div>

			<div id="fraction" style="display: none;">
				<scannell:input id="fractionIntervalAmount" path="exam.fractionIntervalAmount" class="narrow" />
				<fmt:message key="maintenance.trainingEdit.pertimes" />
				<scannell:select id="fractionIntervalType" path="exam.fractionIntervalType" items="${fractionFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${fractionIntervalTypeAction}" />
			</div>

			<div id="userDefined" style="display: none;">
				<scannell:select id="userDefinedIntervalType" path="exam.userDefinedIntervalType" items="${userDefinedFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${userDefinedIntervalTypeAction}" />
			</div>

			<div id="amount" style="display: none;">
				<scannell:input id="userDefinedIntervalAmount" path="exam.userDefinedIntervalAmount" class="narrow" />
			</div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.trainingEdit.dueDate" />:</td>
			<td class="search">
			<div style="width:350px;" id='dateDiv'>
                  <div id='dateTimeDiv' class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input id="exam.dueDate" class="form-control" path="exam.dueDate" readonly="${true}" />
                   <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                 
                  </div>					
                </div>
				<%-- <scannell:input id="exam.dueDate" path="exam.dueDate" readonly="${true}" />
				<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'exam.dueDate', true);"> --%>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.trainingEdit.notificationRequested" />:</td>
			<td class="search"><scannell:checkbox id="notificationRequested" path="exam.notificationRequested" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="training.alertLeadDays" />:</td>
			<td class="search"><scannell:input id="alertLeadDays" path="exam.alertLeadDays" class="narrow" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="active" />:</td>
			<td class="search"><scannell:checkbox path="exam.active" /></td>
		</tr>
	</tbody>

	<tfoot>
		<tr>
			<td colspan="2" align="center">
			<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
			<button type="button" class="g-btn g-btn--secondary"
				onclick="javascript:location.href='<c:url value="trainingRecordView.htm"><c:param name="id" value="${command.exam.id}"/></c:url>'"><fmt:message key="cancel" /></button>
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
