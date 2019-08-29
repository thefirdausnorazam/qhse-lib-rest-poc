<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>

<c:set var="title" value="maintenance.equipmentEdit.title" />
<c:if test="${command.exam['new']}">
	<c:set var="title" value="maintenance.equipmentCreate.title" />
</c:if>

	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/maintenance/frequencyOption.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		onLoadFunction();
		jQuery('select').not('#siteLocation').select2({width:'300px'});		
		
		onTraineeTypeChange();
});
	function onTraineeTypeChange() {
		if (jQuery('#traineeType').val() == 'u') {
			jQuery('#userTraineeForm').show();
			jQuery('#t_traineesDiv').hide();
			jQuery('#companyContact').hide();
			
		} else {
			jQuery('#userTraineeForm').hide();
			jQuery('#t_traineesDiv').show();
			jQuery('#companyContact').show();			
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
		onTraineeTypeChange();
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

	<tbody>
		<c:set var="onChangeAction"                value="setNewTraineeVisibility()" />
		<c:set var="emptyOptionLabel"              value="equipment.responsible.third.party" />
		<c:set var="multipleIntervalTypeAction"    value="multipleIntervalTypeAction()" />
		<c:set var="fractionIntervalTypeAction"    value="fractionIntervalTypeAction()" />
		<c:set var="userDefinedIntervalTypeAction" value="userDefinedIntervalTypeAction()" />
		<c:set var="frequencyOptionAction"         value="frequencyOptionAction()" />
		<c:set var="multipleIntervalAmountAction"  value="multipleIntervalAmountAction()" />

		<c:if test="${!command.exam['new']}">
			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="equipment.category" />:</td>
				<td class="search"><c:out value="${command.exam.category.name}" /></td>
			</tr>
		</c:if>

		<c:if test="${command.exam['new']}">
			<tr class="form-group">
				<td class="searchLabel" ><fmt:message key="equipment.category" />:</td>
				<td class="search"><scannell:select class="wide" id="exam.category" path="exam.category" items="${categories}" itemValue="id" itemLabel="name"
					renderEmptyOption="true" emptyOptionLabel="noneOrNew" /></td>
			</tr>

			<tr class="form-group">
				<td class="searchLabel"><fmt:message key="equipment.newCategory" />:</td>
				<td class="search"><input type="text" name="newCategory" class="wide" /></td>
			</tr>
		</c:if>


		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.responsible.type" />:</td>
			<td class="search">
				<scannell:select id="traineeType" path="traineeType" onchange="onTraineeTypeChange();" renderEmptyOption="false">
					<scannell:option value="u" labelkey="TraineeType[u]" />
					<scannell:option value="t" labelkey="TraineeType[t]" />
				</scannell:select>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel" style="width:40%"><fmt:message key="equipment.responsible" />:</td>
			<td class="search">
				<table id="userTraineeForm" class="table table-bordered table-responsive"
					<c:if test="${command.traineeType != 'u'}"> style="display: none;"</c:if>>
					<tbody>
						<tr>
							<td style="width:30%"><fmt:message key="employee" />:</td>
							<td>
								<scannell:select id="u_trainees" path="user" items="${userTrainees}" itemValue="id" itemLabel="sortableName"
									renderEmptyOption="true" emptyOptionLabel="blankOption" class="wide" />
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
				<table id="newTraineeForm" style="display: none;  margin-top:10px">
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

		<tr class="form-group" id="companyContact" style="display: none;">
			<td class="searchLabel"><fmt:message key="maintenance.equipmentEdit.companyContact" />:</td>
			<td class="search">
				<scannell:select id="responsible" path="exam.responsible" items="${users}" itemValue="id" itemLabel="sortableName"
					class="wide" renderEmptyOption="true" emptyOptionLabel="blankOption" />
				<%-- We have to add the required hint manually as responsible is a conditionally required field and depends on the selected trainee type --%>
				<span class="requiredHinted">*</span>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.assetId" />:</td>
			<td class="search"><input name="exam.assetId" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="description" />:</td>
			<td class="search"><scannell:textarea path="exam.description" cols="75" rows="3" /></td>
		</tr>
		
		<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="exam.additional_info" cols="75" rows="3"/></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.serialNo" />:</td>
			<td class="search"><input name="exam.serialNo" cssStyle="width:300px;"/></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.dateOfManufacture" />:</td>
			<td class="search">
				<%-- <input name="exam.dateOfManufacture" id="dateOfManufacture" readonly="true" />
				<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'dateOfManufacture', true);"> --%>
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.dateOfManufacture" id="dateOfManufacture" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.countryOfManufacture" />:</td>
			<td class="search"><input name="exam.countryOfManufacture" cssStyle="width:300px;" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.standardMark" />:</td>
			<td class="search"><input name="exam.standardMark" cssStyle="width:300px;" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.datePutInService" />:</td>
			<td class="search">
				<%-- <input name="exam.datePutInService" id="datePutInService" readonly="true" />
				<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'datePutInService', true);"> --%>
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.datePutInService" id="datePutInService" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.equipmentEdit.initialMaintenanceDate" />:</td>
			<td class="search">
				<c:choose>
					<c:when test="${!command.exam['new']}">
						<%-- <scannell:input id="exam.initialMaintenanceDate" path="exam.initialMaintenanceDate" readonly="${true}" />
						<c:if test="${editInitialMaintenanceDate != true}">
							<img id="serviceDateCalendar" src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'exam.initialMaintenanceDate', true);">
						</c:if> --%>
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.initialMaintenanceDate" id="exam.initialMaintenanceDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
					</c:when>
					<c:otherwise>
					
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.initialMaintenanceDate" id="exam.initialMaintenanceDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>						
					</c:otherwise>
				</c:choose>
				</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.location" />:</td>
			<td class="search"><input name="exam.location" cssStyle="width:300px;" /></td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.dateRemovedFromService" />:</td>
			<td class="search">
				<%-- <input name="exam.dateRemovedFromService" id="dateRemovedFromService" readonly="true" />
				<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'dateRemovedFromService', true);"> --%>
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.dateRemovedFromService" id="dateRemovedFromService" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.replacementFrequency" />:</td>
			<td class="search"><scannell:select id="frequencyOption" path="exam.frequencyOption" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" items="${frequencyOptions}" onchange="${frequencyOptionAction}" />

			<div id="multiple" style="display: none;">
				<fmt:message key="maintenance.equipmentEdit.everytime" />
				<scannell:input id="multipleIntervalAmount" path="exam.multipleIntervalAmount" class="narrow" onchange="${multipleIntervalAmountAction}" />
				<scannell:select id="multipleIntervalType" path="exam.multipleIntervalType" lookupItemLabel="true"
					itemValue="name" emptyOptionLabel="blankOption" items="${multipleFrequencies}" onchange="${multipleIntervalTypeAction}" />
			</div>
			<div id="fraction" style="display: none;">
				<scannell:input id="fractionIntervalAmount" path="exam.fractionIntervalAmount" class="narrow" />
				<fmt:message key="maintenance.equipmentEdit.pertimes" />
				<scannell:select id="fractionIntervalType" path="exam.fractionIntervalType" items="${fractionFrequencies}" lookupItemLabel="true" itemValue="name"
					emptyOptionLabel="blankOption" onchange="${fractionIntervalTypeAction}" />
			</div>
			<div id="userDefined" style="display: none;">
				<scannell:select id="userDefinedIntervalType" path="exam.userDefinedIntervalType" items="${userDefinedFrequencies}" lookupItemLabel="true" itemValue="name"
					emptyOptionLabel="blankOption" onchange="${userDefinedIntervalTypeAction}" />
			</div>

			<div id="amount" style="display: none;">
				<scannell:input id="userDefinedIntervalAmount" path="exam.userDefinedIntervalAmount" class="narrow" />
			</div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.equipmentEdit.dueDate" />:</td>
			<td class="search">
				<%-- <scannell:input id="exam.dueDate" path="exam.dueDate" readonly="${true}" />
				<img id="serviceDateCalendar" src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'exam.dueDate', true);"> --%>
				<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="exam.dueDate" id="exam.dueDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
			</td>
		</tr>
		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="maintenance.equipmentEdit.notificationRequested" />:</td>
			<td class="search"><scannell:checkbox id="notificationRequested" path="exam.notificationRequested" /></td>
		</tr>
		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="equipment.alertLeadDays" />:</td>
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
			<button type="button" class="g-btn g-btn--secondary" onclick="javascript:location.href='<c:url value="equipmentRecordView.htm"><c:param name="id" value="${command.exam.id}"/></c:url>'"><fmt:message
				key="cancel" /></button>
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
