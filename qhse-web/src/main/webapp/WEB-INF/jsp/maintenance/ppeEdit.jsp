<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>

<c:set var="title" value="maintenance.ppeEdit.title" />
<c:if test="${command.exam['new']}">
	<c:set var="title" value="maintenance.ppeCreate.title" />
</c:if>

	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	
	<script type="text/javascript" src="<c:url value="/js/maintenance/frequencyOption.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('select').not('#siteLocation').select2({width:'40%'});
		onLoadFunction();
		
	});
	function onTraineeTypeChange() {
		if (jQuery('#traineeType').val() == 'u') {
			jQuery('#userTraineeForm').show();
			jQuery('#traineeForm').show();	
			jQuery('#t_trainees').hide();
			jQuery('#responsible').hide();			
			jQuery('#receiverText').show();
		} else {
			jQuery('#userTraineeForm').hide();
			jQuery('#traineeForm').hide();	
			jQuery('#t_trainees').show();
			jQuery('#responsible').show();
			jQuery('#receiverText').hide();
		}
		setNewTraineeVisibility();
		<%-- While editing PPE if User is employee(u) we should not show supervisor field. Supervisor field is only when user selected is third party (t) --%>
		if('${command.exam['new']}' == 'false' && '${command.traineeType}' == 'u'){
			jQuery('#responsible').hide();
		}
	}

	function setNewTraineeVisibility() {
		if (jQuery('#traineeType').val() == 't' && jQuery('#traineesSelect').val() == '0') {
			jQuery('#newTraineeForm').show();	
			jQuery('#traineeForm').show();	
		} else {
			jQuery('#newTraineeForm').hide();
		}
		
		if (jQuery('#traineeType').val() == 't' && jQuery('#traineesSelect').val() != '0'){
			jQuery('#traineeForm').hide();	
		}
	}

	function onLoadFunction(){
		frequencyOptionAction();
		onTraineeTypeChange();
	}
	</script>

	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
		@import "<c:url value='/css/data.css'/>";
		
		input.higher {
			line-height: 26px;
			width: 80%;
		}
	</style>
	<title><fmt:message key="${title}" /></title>
</head>
<body >
<!-- <div class="header"> -->
<%--  <h2><fmt:message key="${title}" /></h2>  --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
	
	
	<tbody>
		<c:set var="onChangeAction"                value="setNewTraineeVisibility()" />
		<c:set var="emptyOptionLabel"              value="ppe.receiver.New.Third.Party" />
		<c:set var="multipleIntervalTypeAction"    value="multipleIntervalTypeAction()" />
		<c:set var="fractionIntervalTypeAction"    value="fractionIntervalTypeAction()" />
		<c:set var="userDefinedIntervalTypeAction" value="userDefinedIntervalTypeAction()" />
		<c:set var="frequencyOptionAction"         value="frequencyOptionAction()" />
		<c:set var="multipleIntervalAmountAction"  value="multipleIntervalAmountAction()" />

		<c:if test="${!command.exam['new']}">
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="ppe.category" /></td>
				<td class="search"><c:out value="${command.exam.category.name}" /></td>
			</tr>
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="ppe.receiver" /></td>
				<td class="search"><c:out value="${command.exam.trainee.description}" /></td>
			</tr>
		</c:if>

		<c:if test="${command.exam['new']}">
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="ppe.category" /></td>
				<td class="search"><scannell:select class="wide" id="exam.category" path="exam.category" items="${categories}" itemValue="id" itemLabel="name"
					renderEmptyOption="true" emptyOptionLabel="noneOrNew" /></td>
			</tr>

			<tr class="form-group">
				<td class="editLabel"><fmt:message key="ppe.newCategory" /></td>
				<td class="search"><input type="text" name="newCategory" size="50" /></td>
			</tr>

			<tr class="form-group">
				<td class="editLabel"><fmt:message key="ppe.receiver.type" /></td>
				<td class="search">
					<scannell:select id="traineeType" path="traineeType" onchange="onTraineeTypeChange();" renderEmptyOption="false">
						<scannell:option value="u" labelkey="traineeType[u]" />
						<scannell:option value="t" labelkey="traineeType[t]" />
					</scannell:select>
				</td>
			</tr>
			
			<tr class="form-group" id="t_trainees">
				<td class="editLabel"><fmt:message key="ppe.receiver" /></td>
				<td class="search">
					<scannell:select id="traineesSelect" path="thirdPartyTrainee.id" items="${thirdPartyTrainees}" itemValue="id"
								itemLabel="description"
								onchange="${onChangeAction}" emptyOptionValue="0" emptyOptionLabel="${emptyOptionLabel}" class="" />
							<scannell:errors path="thirdPartyTrainee" class="errorMessage" />
							<scannell:errors path="exam.trainee" class="errorMessage" writeRequiredHint="false" />
							<scannell:errors path="userTrainee" class="errorMessage" />
				</td>
			</tr>

			<tr class="form-group" id="traineeForm">
				<td class="editLabel"><div id="receiverText"><fmt:message key="ppe.receiver" /></div></td>
				<td class="search">
					<div id="userTraineeForm" <c:if test="${command.traineeType != 'u'}"> style="display: none;"</c:if>>
						<div class="form-group smaller">
								<label class="col-sm-2 editLabel"><fmt:message key="employee" /></label>
								<div class="col-sm-6">
									<scannell:select id="u_trainees" path="user" items="${userTrainees}" itemValue="id" itemLabel="sortableName" class="wide" />
									<scannell:errors path="userTrainee.user" />
								</div>
							</div>
							<div class="form-group smaller" style="border-bottom:0px;">
								<label class="col-sm-2 editLabel"><fmt:message key="department" /></label>
								<div class="col-sm-6">
									<select name="department" items="${locations}" itemValue="id" itemLabel="name" class="wide" />
									<scannell:errors path="userTrainee.department" />
								</div>
							</div>
					</div>

					<div class="" id="newTraineeForm" style="display: none;">
							<div class="form-group smaller">
								<label class="col-sm-2 editLabel"><fmt:message key="name" /></label>
								<div class="col-sm-6"><input name="thirdPartyTrainee.name" class="higher" /></div>
							</div>
							<div class="form-group smaller">
								<label class="col-sm-2 editLabel"><fmt:message key="company" /></label>
								<div class="col-sm-6"><input name="thirdPartyTrainee.company" class="higher" /></div>
							</div>
							<div class="form-group smaller">
								<label class="col-sm-2 editLabel"><fmt:message key="address" /></label>
								<div class="col-sm-6"><input name="thirdPartyTrainee.address" class="higher" /></div>
							</div>
							<div class="form-group smaller">
								<label class="col-sm-2 editLabel"><fmt:message key="phoneNumber" /></label>
								<div class="col-sm-6"><input name="thirdPartyTrainee.phoneNumber" cssStyle="higher"/></div>
							</div>
							<div class="form-group smaller" style="border-bottom:0px;">
								<label class="col-sm-2 editLabel"><fmt:message key="emailAddress" /></label>
								<div class="col-sm-6"><input name="thirdPartyTrainee.emailAddress"  cssStyle="higher" /></div>
							</div>
					</div>
				</td>
			</tr>
		</c:if>

		<tr class="form-group" id="responsible" style="display: none;">
			<td class="editLabel"><fmt:message key="ppe.responsible" /></td>
			<td class="search"><scannell:select id="responsible" path="exam.responsible" items="${users}" itemValue="id" itemLabel="sortableName" class="wide" renderEmptyOption="true" emptyOptionLabel="blankOption" /></td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="description" /></td>
			<td class="search"><scannell:textarea path="exam.description" cssStyle="width:50%" /></td>
		</tr>


		<tr class="form-group">
			<td class="editLabel"><fmt:message key="maintenance.ppeEdit.initialMaintenanceDate" /></td>
			<td class="search">
			<c:choose>
				<c:when test="${!command.exam['new']}">
				 	<c:if test="${editInitialMaintenanceDate != true}">             
						<div style="width:350px;">
	                  		<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
	                  			<scannell:input id="exam.initialMaintenanceDate" class="form-control" path="exam.initialMaintenanceDate" readonly="${true}" />
	                          	<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>              
	                  		</div>					
	                	</div>
                    </c:if>
                    <c:if test="${editInitialMaintenanceDate != false}"> 
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
					<%-- <scannell:input id="exam.initialMaintenanceDate" path="exam.initialMaintenanceDate" readonly="${true}" />
					<img id="serviceDateCalendar" src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'exam.initialMaintenanceDate', true);"> --%>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="ppe.replacementFrequency" /></td>
			<td class="search"><scannell:select id="frequencyOption" path="exam.frequencyOption" items="${frequencyOptions}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${frequencyOptionAction}" />

			<div id="multiple" style="display: none;">
				<fmt:message key="maintenance.ppeEdit.everytime" />
				<scannell:input id="multipleIntervalAmount" path="exam.multipleIntervalAmount" class="narrow" onchange="${multipleIntervalAmountAction}"/>
				<scannell:select id="multipleIntervalType" path="exam.multipleIntervalType" items="${multipleFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption" onchange="${multipleIntervalTypeAction}" />
			</div>

			<div id="fraction" style="display: none;">
				<scannell:input id="fractionIntervalAmount" path="exam.fractionIntervalAmount" class="narrow" />
				<fmt:message key="maintenance.ppeEdit.pertimes" />
				<scannell:select id="fractionIntervalType" path="exam.fractionIntervalType" items="${fractionFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption"  onchange="${fractionIntervalTypeAction}" />
			</div>

			<div id="userDefined" style="display: none;margin-top:10px;">
				<scannell:select id="userDefinedIntervalType" path="exam.userDefinedIntervalType" items="${userDefinedFrequencies}" lookupItemLabel="true" itemValue="name" emptyOptionLabel="blankOption"  onchange="${userDefinedIntervalTypeAction}" />
			</div>

			<div id="amount" style="display: none;">
				<scannell:input id="userDefinedIntervalAmount" path="exam.userDefinedIntervalAmount" class="narrow" />
			</div>
			</td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="maintenance.ppeEdit.dueDate" /></td>
			<td class="search">
			<div style="width:350px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input id="exam.dueDate" class="form-control" path="exam.dueDate" readonly="${true}" />
                   <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                 
                  </div>					
                </div>
				
			</td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="maintenance.ppeEdit.notificationRequested" /></td>
			<td class="search"><scannell:checkbox id="notificationRequested" path="exam.notificationRequested" /></td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="equipment.alertLeadDays" /></td>
			<td class="search"><input name="exam.alertLeadDays" class="narrow" /></td>
		</tr>

		<tr class="form-group">
			<td class="editLabel"><fmt:message key="active" /></td>
			<td class="search"><scannell:checkbox path="exam.active" /></td>
		</tr>
	</tbody>

	<tfoot>
		<tr>
			<td colspan="2" align="center">
			<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
			<button type="button" class="g-btn g-btn--secondary"
				onclick="javascript:location.href='<c:url value="ppeRecordView.htm"><c:param name="id" value="${command.exam.id}"/></c:url>'"><fmt:message key="cancel" /></button>
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
