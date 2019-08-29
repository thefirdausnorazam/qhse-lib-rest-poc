<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		
		jQuery( "#form" ).submit(function( event ) {
			if (jQuery("#form input:checkbox:checked").length <= 0) {			
				jQuery("input:checkbox[class=checkBox]").each(function () {
					jQuery( "#dialog" ).dialog();
					event.preventDefault();
		        });
				}
		});

	});

	function setMeasurementIds() {
		  var checkBoxId = "";
		  jQuery('.checkBox').each(function () {
		       var checkBoxValue = (this.checked ? this.checked : ""); 
		        if(checkBoxValue){
		        	if(checkBoxId){
		        		checkBoxId=checkBoxId+","+jQuery(this).attr("id");
		        	}else{
		        		checkBoxId=jQuery(this).attr("id");
		        	}
		        	
		        }
			  });
			  jQuery('#selectedMeasurements').val(checkBoxId); 
	}
</script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/survey.css'/>";
</style>
</head>
<body>
	<div class="content">
		<scannell:form id="form" onsubmit="setMeasurementIds();">
			<input type="hidden" id="selectedMeasurements"		name="selectedMeasurements" value="">
			<input type="hidden" id="mes" name="mes" value="">
			<div class="table-responsive">
				<div id="queryTable">
					<div class="header">
						<h3>
							<fmt:message key="createReportStep2" />
						</h3>
					</div>

					<div class="table-responsive">
						<div class="panel">
							<table class="table table-bordered table-responsive" style="width: 100%; border-top: 1px solid #DADADA;">
								<tbody>
									<tr>
										<td class="scannellGeneralLabel nowrap" width="30%"><fmt:message key="id" />:</td>
										<td><c:out value="${command.id}" /></td>

									</tr>
									<tr>
										<td class="scannellGeneralLabel nowrap" width="30%"><fmt:message key="title" />:</td>
										<td><c:out value="${command.title}" /></td>
									</tr>
									<tr>
										<td class="scannellGeneralLabel nowrap" width="30%"><fmt:message key="addMonitoringPoint" />:</td>
										<td colspan="3"><c:out	value="${measurements[0].readingPoint.description}" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="header">
						<h3>
							<fmt:message key="selectMeasurement" />
						</h3>
					</div>
					<table class="table table-bordered table-responsive"	style="width: 100%; border-top: 1px solid #DADADA;">
						<thead>

							<tr>
								<th></th>
								<th><fmt:message key="id" /></th>
								<th><fmt:message key="quantity" /></th>
								<th><fmt:message key="measure" /></th>
								<th><fmt:message key="readingPoint" /></th>
								<th><fmt:message key="frequency" /></th>
								<%--th><fmt:message key="survey.measurementQueryResult.dueDate" /></th--%>
								<th><fmt:message key="unit" /></th>
							</tr>

						</thead>

						<tbody>
							<c:forEach items="${measurements}" var="measurement"	varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><input type="checkbox" value="${measurement.id}" id="${measurement.id}" class="checkBox"></td>
									<td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>"><c:out	value="${measurement.id}" /></a></td>
									<td><c:out value="${measurement.quantity.longName}" /></td>
									<td><c:out value="${measurement.measure.measureName}" /></td>
									<td><c:out value="${measurement.readingPoint.name}" /></td>
									<td><c:out value="${measurement.frequencyDisplay}" /></td>
									<%--td><fmt:formatDate value="${measurement.dueDate}" pattern="dd-MMM-yyyy" /></td--%>
									<td>${measurement.defaultUnit.name}</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
				<div style="clear: both;"></div>
				<div class="spacer2 text-center">
					<input type="submit" value="<fmt:message key="next" />"	class="g-btn g-btn--primary">
				</div>
				</div>
		</scannell:form>
	</div>
			<div style="display:none;">
				<div id="dialog" title="Select Measurement" >
  					<p><fmt:message key="selectMeasurement"/></p>
				</div>
			</div>
</body>
</html>
