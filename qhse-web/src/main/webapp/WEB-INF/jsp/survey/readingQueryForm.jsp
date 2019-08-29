<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>

<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		restoreSearchCriteria();
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({
			width : '300px'
		});
		jQuery('#queryTable').hide();
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryTable(false);
		checkDates();
	});

	function checkDates() {
		var v = document.getElementById('status').value;
		if (v == 'E') {
			document.getElementById('readingDateTo').style.color = "000";
			document.getElementById('readingDateFrom').style.color = "000";
			document.getElementById('calFrom').style.display="";
			document.getElementById('calTo').style.display="";
			document.getElementById('readingDateTo').disabled = false;
			document.getElementById('readingDateFrom').disabled = false;

		} else {
			document.getElementById('readingDateTo').value = "";
			document.getElementById('readingDateFrom').value = "";
			document.getElementById('readingDateTo').style.color = "CCC999";
			document.getElementById('readingDateFrom').style.color = "CCC999"; 
			document.getElementById('calFrom').style.display="none";
			document.getElementById('calTo').style.display="none";
			document.getElementById('readingDateTo').disabled = true;
			document.getElementById('readingDateFrom').disabled = true;
		}
		return
	}
	
	function toggleDate(el, disable) {
        try {
            el.disabled = disable;
        } catch (E) {}
        if (el.childNodes && el.childNodes.length > 0) {
            for (var x = 0; x < el.childNodes.length; x++) {
            	toggleDate(el.childNodes[x]);
            }
        }
    }

	function restoreSearchCriteria() {
		jQuery("#status").val('${sessionScope["readingSearch.status"]}');
		jQuery("#quantityId")
				.val('${sessionScope["readingSearch.quantityId"]}');
		jQuery("#quantityCategoryId").val(
				'${sessionScope["readingSearch.quantityCategoryId"]}');
		jQuery("#responsibleUserId").val(
				'${sessionScope["readingSearch.responsibleUserId"]}');
		jQuery("#readingPointId").val(
				'${sessionScope["readingSearch.readingPointId"]}');
		jQuery("#measureId").val('${sessionScope["readingSearch.measureId"]}');
		jQuery("#frequencyCode").val(
				'${sessionScope["readingSearch.frequencyCode"]}');
		jQuery("#readingDateFrom").val('${sessionScope["readingSearch.readingDateFrom"]}');
		jQuery("#readingDateTo").val('${sessionScope["readingSearch.readingDateTo"]}');
		jQuery("#scheduledDateFrom").val('${sessionScope["readingSearch.scheduledDateFrom"]}');
		jQuery("#scheduledDateTo").val('${sessionScope["readingSearch.scheduledDateTo"]}');

	}
	
	function clearForm(){
		//jQuery("#status").select2().select2('val', jQuery('#status option:eq(0)').val());
		jQuery('#status').select2('val','');
		jQuery('#quantityId').select2('val','');
		jQuery('#quantityCategoryId').select2('val','');
		jQuery('#responsibleUserId').select2('val','');
		jQuery('#measureId').select2('val','');
		jQuery('#readingPointId').select2('val','');
		jQuery('#frequencyCode').select2('val','');
		checkDates();
	}
	
	
</script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
@import "<c:url value='/css/survey.css'/>";
</style>

</head>
<body>
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div style="text-align: right;">
					<form action="<c:url value="/survey/readingView.htm" />" method="get" onsubmit="if(!$F('gotoId')) return false;">
						<fmt:message key="survey.readingQueryForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						
						<c:if test="${!hideControls}">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
								<fmt:message key="search.displaySearchCriteria" />
							</button>
						</c:if>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
						
					</div>

				</div>
			</div>
		</div>
	</div>
	
	<form id="queryForm" action="<c:url value="/survey/readingQuery.htmf" />" onsubmit="return search(this, 'resultsDiv');">
		<input type="hidden" name="calculateTotals" value="true" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" id="pageSize" name="pageSize" />
		<input type="hidden" name="chartWidth" value="700" />
		<input type="hidden" name="chartHeight" value="400" />
		<input type="hidden" name="sortByTimePeriod" value="false" />
		<input style="display: none;" type="submit" name="submitBtn" />

		<c:if test="${hideControls}">
			<c:forEach items="${filters}" var="p">
				<input type="hidden" name="<c:out value="${p.key}" />" value="<c:out value="${p.value}" />" />
			</c:forEach>
		</c:if>

		<c:if test="${!hideControls}">
			<div id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>
				<div class="content">
					<div class="table-responsive">
						<div class="panel">
							<table class="table table-bordered table-responsive">
								<col class="label" />
								<tbody>
									<tr class="form-group">
										<td class="searchLabel" style="width:40%"><label for="status">
												<fmt:message key="status" />
											</label></td>
										<td colspan="3" class="search">
										<select id="status" name="status" class="wide" onclick="checkDates();">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${statuses}" var="item">
													<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="quantityCategoryId">
												<fmt:message key="quantityCategory" />
											</label></td>
										<td colspan="3" class="search"><select id="quantityCategoryId" name="quantityCategoryId" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${quantityCategories}" var="category">
													<option value="<c:out value="${category.id}" />"><c:out value="${category.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="quantityId">
												<fmt:message key="quantity" />
											</label></td>
										<td colspan="3" class="search"><select id="quantityId" name="quantityId" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${quantityCategories}" var="category">
													<c:forEach items="${category.quantities}" var="quantity">
														<c:if test="${quantity.active}">
															<option value="<c:out value="${quantity.id}" />"><c:out value="${quantity.longName}" /></option>
														</c:if>
													</c:forEach>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="responsibleUserId">
												<fmt:message key="survey.measurementView.parameterOwner" />
											</label></td>
										<td colspan="3" class="search"><select id="responsibleUserId" name="responsibleUserId" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${quantityResponsibleUserList}" var="user">
													<option value="<c:out value="${user.id}" />"><c:out value="${user.sortableName}" /></option>
												</c:forEach>
											</select></td>
									</tr>


									<tr class="form-group">
										<td class="searchLabel"><label for="measureId">
												<fmt:message key="measure" />
											</label></td>
										<td colspan="3" class="search"><select id="measureId" name="measureId" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${measures}" var="item">
													<option value="<c:out value="${item.id}" />"><c:out value="${item.measureName}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="readingPointId">
												<fmt:message key="readingPoint" />
											</label></td>
										<td colspan="3" class="search"><select id="readingPointId" name="readingPointId" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${readingPoints}" var="item">
													<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="frequencyCode">
												<fmt:message key="measurement.frequency" />
											</label></td>
										<td colspan="3" class="search"><select id="frequencyCode" name="frequencyCode" class="wide">
												<option value=""><fmt:message key="choose" /></option>
												<c:forEach items="${frequencies}" var="item">
													<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="fromDate">
												<fmt:message key="readingsDateFrom" />
											</label></td>
										<td class="search" style="width: 200px;">
											<div id="fromDiv" style="width: 250px;">
												<div  class="input-group date datetime hideField" data-min-view="2" data-date-format="dd-MM-yyyy"
													data-date-calendar-weeks="true" style="width: 200px;">
													<input class="form-control" id="readingDateFrom" name="readingDateFrom" size="26" type="text" readonly>
													<span id="calFrom" class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>


										</td>
										<td class="searchLabel" style="width: 60px;">To</td>
										<td class="search" style="width: 720px;">
											<div id="toDiv" style="width: 350px;">
												<div class="input-group date datetime hideField" data-min-view="2" data-date-format="dd-MM-yyyy"
													data-date-calendar-weeks="true" style="width: 200px;">
													<input class="form-control" id="readingDateTo" name="readingDateTo" size="6" type="text" readonly>
													<span id="calTo" class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>


									</tr>


									
									<tr class="form-group">
										<td class="searchLabel"><label for="fromDate">
												<fmt:message key="readingsScheduledDateFrom" />
											</label></td>
										<td class="search" style="width: 200px;">
											<div id="fromDiv" style="width: 250px;">
												<div class="input-group date datetime hideField" data-min-view="2" data-date-format="dd-MM-yyyy"
													data-date-calendar-weeks="true" style="width: 200px;">
													<input class="form-control" id="scheduledDateFrom" name="scheduledDateFrom" size="26" type="text" readonly>
													<span id="calFrom" class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>


										</td>
										<td class="searchLabel" style="width: 60px;">To</td>
										<td class="search" style="width: 720px;">
											<div id="toDiv" style="width: 350px;">
												<div class="input-group date datetime hideField" data-min-view="2" data-date-format="dd-MM-yyyy"
													data-date-calendar-weeks="true" style="width: 200px;">
													<input class="form-control" id="scheduledDateTo" name="scheduledDateTo" size="6" type="text" readonly>
													<span id="calTo" class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
									</tr>

								</tbody>
								<tfoot style="text-align: center">
									<tr>
										<td colspan="4">
											<button type="submit" class="g-btn g-btn--primary"
												onClick="this.form.pageNumber.value = 1;displayQueryTable(false);">
												<fmt:message key="search" />
											</button>
											<button type="reset" class="g-btn g-btn--secondary" onclick="clearForm();">
												<fmt:message key="reset" />
											</button>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<div id="resultsDiv"></div>
	</form>

</body>
</html>
