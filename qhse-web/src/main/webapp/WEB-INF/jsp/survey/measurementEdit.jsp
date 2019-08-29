<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="command_new" value="${false}" />
<c:set var="title" value="measurementEdit" />
<c:if test="${command.id == 0}">
	<c:set var="title" value="measurementCreate" />
	<c:set var="command_new" value="${true}" />
</c:if>
<style type="text/css">
/* td.search {
    padding-left: 15%!important;
    } */
</style>
<title><fmt:message key="${title}" /></title>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/measurement/frequencyOption.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {		
		onLoadFunction();
		jQuery("#dueOverdueReadings").hide();
		jQuery('select').not('#siteLocation').not("#user").select2({width:'300px'});

		
		var userList = [];
		<c:forEach items="${command.authorisedUsers}" var="authorisedUser" >
		userList.push({id:'<c:out value="${authorisedUser.id}"/>', text:'<c:out value="${authorisedUser.sortableName}" />'});
		</c:forEach>
		
		showMultipleUserList(${fn:length(users)}, "user", "30", "userListReadingCreate.json", userList);
		
		jQuery(".date").find(".requiredHinted").remove();
		jQuery("#save").on( "click", function() {
	    	return trashReadingsList();
	    });
    });

	var unitOptArr = new Array ( new Array()
	<c:forEach items="${measures}" var="measure">, new Array(new Option('<c:out value="${measure.name}"/>','<c:out value="${measure.id}" />', false, false)
		<c:forEach items="${measure.alternateUnits}" var="altUnit" >
			, new Option('<c:out value="${altUnit.name}"/>','<c:out value="${altUnit.id}" />', false, false)
		</c:forEach>)
	</c:forEach>);

	function onMeasureChange() {		
		var measureSel = document.getElementById("measureSel");
		var defaultUnitSel = document.getElementById("defaultUnitSel");
		defaultUnitSel.options.length = 1;
		var newOpts = unitOptArr[measureSel.selectedIndex];				
		for(var i = 0; i < newOpts.length; i++) {			
			if(newOpts[i].text !='' && newOpts[i].text !='unit'){			
			defaultUnitSel.options[defaultUnitSel.options.length] = newOpts[i];
			}
		}
	}
	
	function customUnitTest() {
		var expresion = jQuery('#customUnitExpression').val();
		openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=" + encodeURIComponent(expresion)+"&symbol="+encodeURIComponent(jQuery("#customUnitSymbol").val()), 500, 300, true, "Test", true);
	}

	function customUnitTestExample() {
		openWindow("<c:url value="/waste/customUnitSampleView.htm" />?expression=x*8&sample=true"+"&symbol="+encodeURIComponent(document.getElementById("customUnitSymbol").value), 500, 300, true, "Sample", true);
	}

	function onLoadFunction(){
		frequencyOptionAction();
	}
	function removeHourFrequency(){
		alert($(multipleFrequencies));
	    
		    var listFreq = [];
		    for (var i = 0; i < ${multipleFrequencies}.length; i++){
		    	alert(multipleFrequencies[i].value);
		    alert( "safsfsa"+removeCounter);
		    }
		    
	}
	</script>
</head>
<body>
<!-- 	<div class="header"> -->
<!-- 		<h2> -->
<%-- 			<fmt:message key="${title}" /> --%>
<!-- 		</h2> -->
<!-- 	</div> -->
	<scannell:form id="updateMeasurement">
		<input type="hidden" id="mid" value="${command.id}" />
		<input type="hidden" id="previousFreqOpt" value="${previousFreqOpt}" />
		<input type="hidden" id="previousMultipleIntervalType" value="${previousMultipleIntervalType}" />
		<input type="hidden" id="previousMultipleIntervalAmount" value="${previousMultipleIntervalAmount}" />
		<input type="hidden" id="previousFractionIntervalType" value="${previousFractionIntervalType}" />
		<input type="hidden" id="previousFractionIntervalAmount" value="${previousFractionIntervalAmount}" />
		
		<spring:nestedPath path="command">
			<div class="content">
				<div class="table-responsive">
					<div class="panel">
						<table class="table table-bordered table-responsive">
							<col />
							<tbody>
								<c:set var="multipleIntervalTypeAction" value="multipleIntervalTypeAction()" />
								<c:set var="fractionIntervalTypeAction" value="fractionIntervalTypeAction()" />
								<c:set var="userDefinedIntervalTypeAction" value="userDefinedIntervalTypeAction()" />
								<c:set var="frequencyOptionAction" value="frequencyOptionAction()" />

								<c:if test="${command_new}">
									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="quantity" />
										</td>
										<td class="search">
											<spring:bind path="quantity">
												<select name="<c:out value="${status.expression}"/>" class="wide" style="width: 700px;">
													<option id="blankOption" value=""><fmt:message key="blankOption" /></option>
													<c:forEach items="${quantityCategories}" var="category">
														<c:forEach items="${category.quantities}" var="item">
															<c:if test="${item.editable && (item.active || item.id == status.value)}">
																<option value="<c:out value="${item.id}" />"
																	<c:if test="${item.id == status.value}">selected="selected"</c:if>>
																	<c:out value="${item.longName}" /></option>
															</c:if>
														</c:forEach>
													</c:forEach>
												</select>
												<span class="requiredHinted">*</span>
												<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
												</span>
											</spring:bind>
										</td>
									</tr>

									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="measure" />
										</td>
										<td class="search">
											<scannell:select id="measureSel" path="measure" items="${measures}" itemLabel="measureName" itemValue="id"
												emptyOptionLabel="blankOption" class="wide" onchange="onMeasureChange()" />
										</td>
									</tr>

									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="readingPoint" />
										</td>
										<td class="search">
											<scannell:select id="readingPoint" path="readingPoint" items="${readingPoints}" itemLabel="description"
												itemValue="id" emptyOptionLabel="blankOption" class="wide" />
										</td>
									</tr>
								</c:if>

								<c:if test="${!command_new}">
									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="quantity" />
										</td>
										<td class="search">
											<c:out value="${command.quantity.longName}" />
										</td>
									</tr>

									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="survey.measurementEdit.parameterOwner" />
										</td>
										<td class="search">
											<c:out value="${command.quantity.responsibleUser.displayName}" />
										</td>
									</tr>

									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="measure" />
										</td>
										<td class="search">
											<c:out value="${command.measure.measureName}" />
										</td>
									</tr>

									<tr class="form-group">
										<td class="editLabel">
											<fmt:message key="readingPoint" />
										</td>
										<td class="search">
											<c:out value="${command.readingPoint.description}" />
										</td>
									</tr>
								</c:if>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="survey.measurementEdit.frequency" />
									</td>
									<td class="search">
										<scannell:select id="frequencyOption" path="frequencyOption" items="${frequencyOptions}" itemValue="name"
											emptyOptionLabel="blankOption" lookupItemLabel="true" onchange="${frequencyOptionAction}" />

										<div id="multiple" style="display: none;">
											<div style="margin-top: 5px;">
												<div style="display: inline;">
													<fmt:message key="maintenance.equipmentEdit.everytime" />
												</div>
												<scannell:input id="multipleIntervalAmount" path="multipleIntervalAmount" class="form-control narrow"
													cssStyle="width:50px; display:inline;" />
												<scannell:select id="multipleIntervalType" path="multipleIntervalType" itemValue="name"
													emptyOptionLabel="blankOption" lookupItemLabel="true" onchange="${multipleIntervalTypeAction}">
													<%-- We are doing it so that we can skip hourly value, user is not allowed to create reading hourly --%>
													<c:forEach items="${multipleFrequencies}" var="item" varStatus="loop">
														<c:choose>
															<c:when test="${loop.index > 0}">
																<scannell:option value="${item.name}" labelkey="${item}" />
															</c:when>
														</c:choose>
													</c:forEach>
												</scannell:select>
												
												<div id="shiftMessage" style="display: none;">
													<span class="requiredHinted">**</span> <fmt:message key="measurement.shiftMessage" />
												</div>
											</div>
										</div>

										<div id="fraction" style="display: none; margin-top: 10px;">
											<scannell:input id="fractionIntervalAmount" path="fractionIntervalAmount" class="form-control"
												cssStyle="float:left;width:100px;display:inline;" />
											<fmt:message key="maintenance.equipmentEdit.pertimes" />
											<scannell:select id="fractionIntervalType" path="fractionIntervalType" itemValue="name"
												emptyOptionLabel="blankOption" lookupItemLabel="true" onchange="${fractionIntervalTypeAction}">
												<%-- We are doing it so that we can skip hourly value, user is not allowed to create reading hourly --%>
												<c:forEach items="${fractionFrequencies}" var="item" varStatus="loop">
													<c:choose>
														<c:when test="${loop.index > 0}">
															<scannell:option value="${item.name}" labelkey="${item}" />
														</c:when>
													</c:choose>
												</c:forEach>
											</scannell:select>
										</div>

										<div id="userDefined" style="display: none; margin-top: 10px;">
											<scannell:select id="userDefinedIntervalType" path="userDefinedIntervalType"
												items="${userDefinedFrequencies}" itemValue="name" emptyOptionLabel="blankOption" lookupItemLabel="true"
												onchange="${userDefinedIntervalTypeAction}" />
										</div>

										<div id="amount" style="display: none; margin-top: 10px;">
											<scannell:input id="userDefinedIntervalAmount" path="userDefinedIntervalAmount" class="narrow" />
										</div>
									</td>
								</tr>

								<c:choose>
									<c:when test="${command_new}">
										<tr class="form-group">
											<td class="editLabel">
												<fmt:message key="survey.measurementEdit.initialMeasurmentDate" />
											</td>
											<td class="search">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 250px;float:left;">
													<scannell:input id="initialMeasurementDate" path="initialMeasurementDate" class="form-control" cssStyle="float:left;"
														readonly="true" />
													<!--   <input type="text" id="idPlaceHolderEndDate" name="incident.investigation.recouperationPeriods.periodEndDate" class="form-control" readonly="readonly">	 -->
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
												<span class="requiredHinted">*</span>
													<span class="errorMessage">
														<c:out value="${status.errorMessage}" />
													</span>
												</span>

											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr class="form-group">
											<td class="editLabel">
												<fmt:message key="survey.measurementEdit.initialMeasurmentDate" />
											</td>
											<td class="search">
												<fmt:formatDate value="${command.initialMeasurementDate}" pattern="dd-MMM-yyy" />
											</td>
										</tr>
									</c:otherwise>
								</c:choose>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="survey.measurementEdit.notificationRequested" />
									</td>
									<td class="search">
										<scannell:checkbox id="notificationRequested" path="notificationRequested" />
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="survey.measurementEdit.alertLeadDays" />
									</td>
									<td class="search">
										<scannell:input id="alertLeadDays" path="alertLeadDays" class="form-control" cssStyle="float:left;width:50px;" />
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="defaultUnit" />
									</td>
									<td class="search">
										<spring:bind path="defaultUnit">
											<select id="defaultUnitSel" name="<c:out value="${status.expression}"/>" class="wide">
												<option id="blankOption" value=""><fmt:message key="blankOption" /></option>
												<c:forEach items="${measures}" var="measure">
													<c:if test="${measure.id == command.measure.id}">
														<c:forEach items="${measure.allUnits}" var="unit">
															<option value="<c:out value="${unit.id}" />"
																<c:if test="${unit.id == status.value}">selected="selected"</c:if>>
																<c:out value="${unit.name}" /></option>
														</c:forEach>
													</c:if>
												</c:forEach>
											</select>
											<span class="requiredHinted">*</span>
											<span class="errorMessage">
												<c:out value="${status.errorMessage}" />
											</span>
										</spring:bind>
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="survey.measurementEdit.customUnit" />
									</td>
									<td class="search">

										<div class="form-group" style="margin-top: 0px; height: 40px;padding-top:10px">
											<label class="col-sm-2 control-label" style="text-align: right;">
												<fmt:message key="symbol" />
											</label>
											<div class="col-md-6">
												<input name="customUnitSymbol" id="customUnitSymbol" cssStyle="width: 100px;" />
											</div>
										</div>

										<div class="form-group" style="margin-top: 0px; height: 40px;padding-top:10px">
											<label class="col-sm-2 control-label" style="text-align: right;">
												<fmt:message key="expression" />
											</label>
											<div class="col-md-6">
												<input name="customUnitExpression" id="customUnitExpression" cssStyle="width: 100px;" />
											</div>
										</div>
										<div class="form-group">
											<button type="button" class="g-btn g-btn--primary" onclick="customUnitTest()">
												<fmt:message key="test" />
											</button>
											<button type="button" class="g-btn g-btn--primary" onclick="customUnitTestExample()">
												<fmt:message key="waste.wasteTypeEdit.sample" />
											</button>
										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="active" />
									</td>
									<td class="search">
										<div class="checkbox">
											<label>
												<scannell:checkbox path="active" />
											</label>
										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="authorisedUsers" />
									</td>
									<td class="search">
										<spring:bind path="authorisedUsers">
										
										<c:choose>
											<c:when test="${fn:length(users) lt 500}">
												<scannell:select id="user" cssStyle="width:300px;" path="authorisedUsers" multiple="true" items="${users}" itemLabel="sortableName" itemValue="id" emptyOptionValue="" />
											</c:when>
											<c:otherwise>
												<input type="hidden" id="user" style="width:300px !important;" name="authorisedUsers" />
												<scannell:errors path="authorisedUsers"/>
											</c:otherwise>
										</c:choose>
										</spring:bind>
									</td>
								</tr>

								<tr class="form-group">
									<td class="editLabel">
										<fmt:message key="additionalInfo" />
									</td>
									<td class="search">
										<scannell:textarea path="additionalInfo" cols="63" rows="3" />
									</td>
								</tr>
							</tbody>

							<tfoot>
								<tr>
									<td colspan="2" align="center">
										<button id="save" type="submit" class="g-btn g-btn--primary">
											<fmt:message key="submit" />
										</button>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</spring:nestedPath>
	</scannell:form>	
		
		<div id="dueOverdueReadings">
			<form id="queryForm" action="<c:url value="/survey/readingQuery.htmf" />"
				onsubmit="return search(this, 'resultsDiv', true);">
				<input type="hidden" name="calculateTotals" value="false" />
				<input type="hidden" name="pageNumber" value="0" />
				<input type="hidden" name="pageSize" value="0" />
				<input type="hidden" name="dueOverdue" value="true" />
				<input type="hidden" name="viewName" value="trashReadingQueryResult" />
				<input type="hidden" name="sortName" value="timePeriod" />
				<input type="hidden" name="typeId" value="<c:out value="${command.id}" />" />
				<button type="submit" id="queryButton" style="display: none;"></button>
				<div id="resultsDiv"></div>
			</form>
		</div>
</body>
</html>
