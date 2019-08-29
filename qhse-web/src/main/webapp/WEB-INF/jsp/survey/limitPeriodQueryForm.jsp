<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>

<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/effects.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		restoreSearchCriteria();
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({
			width : '40%'
		});
	});
	/* function toggleQueryTable() {
		$('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
		$('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
	} */
	function restoreSearchCriteria() {
		jQuery("#reviewed")
				.val('${sessionScope["limitPeriodSearch.reviewed"]}');
		jQuery("#complianceStatus").val(
				'${sessionScope["limitPeriodSearch.complianceStatus"]}');
		jQuery("#quantityId").val(
				'${sessionScope["limitPeriodSearch.quantityId"]}');
		if('${sessionScope["limitPeriodSearch.measurementActive"]}' == '') {
			jQuery("#measurementActive").val('true');
		} else {
			jQuery("#measurementActive").val('${sessionScope["limitPeriodSearch.measurementActive"]}');
		}
		jQuery("#sortName")
				.val('${sessionScope["limitPeriodSearch.sortName"]}');
		jQuery("#primaryGroupByName").val(
				'${sessionScope["limitPeriodSearch.primaryGroupByName"]}');
		jQuery('#primaryGroupByName').val('complianceStatus');
		jQuery("#secondaryGroupByName").val(
				'${sessionScope["limitPeriodSearch.secondaryGroupByName"]}');
		jQuery("#fromDate")
				.val('${sessionScope["limitPeriodSearch.fromDate"]}');
		jQuery("#toDate").val('${sessionScope["limitPeriodSearch.toDate"]}');

	}
	
	function hardResetForm(form) {
	    var inputs = form.getElementsByTagName('input');
	    for (var i = 0; i<inputs.length; i++) {
	        switch (inputs[i].type) {
	          case 'text':
	                inputs[i].value = '';
	                break;
	        }
	    }
	jQuery('#reviewed').select2('val', '');
	jQuery('#complianceStatus').select2('val', '');
	jQuery('#quantityId').select2('val', '');
	jQuery('#sortName').select2('val', '');
	jQuery("#primaryGroupByName").select2('val',jQuery('#primaryGroupByName option:eq(0)').val());
	jQuery("#measurementActive").select2('val',jQuery('#measurementActive option:eq(0)').val());
	jQuery("#secondaryGroupByName").select2('val',jQuery('#secondaryGroupByName option:eq(0)').val());
	jQuery("#pageSize").select2('val',jQuery('#pageSize option:eq(0)').val());

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
				<form action="<c:url value="/survey/limitPeriodView.htm" />" method="get" onsubmit="if(!$F('gotoId')) return false;">
					<fmt:message key="survey.complianceStatus.goTo" />
					<input type="text" id="gotoId" name="id" size="3">
					<input type="submit" class="g-btn g-btn--primary" value="Go">
					<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
							<fmt:message key="search.displaySearchCriteria" />
					</button>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
				</form>

					</div>
				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
		
	</div>

	<div class="content">
		<form id="queryForm" action="<c:url value="/survey/limitPeriodQuery.htmf" />"
			onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" name="pageNumber" value="1" />
			
			<input type="hidden" id="pageSize" name="pageSize" />
			<input type="hidden" name="chartWidth" value="700" />
			<input type="hidden" name="chartHeight" value="400" />
			<input type="hidden" name="aggregateName" value="total" />
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
								<tbody>
									<tr class="form-group">
										<td class="searchLabel"><label for="fromDate">
												<fmt:message key="readingDate" />
												<fmt:message key="from" />
											</label></td>
										<td class="search" style="width: 20%;">
											<div style="width: 100%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%;">
													<input class="form-control" id="fromDate" name="fromDate" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>


										</td>
										<td class="searchLabel2" style="width: 5%;"><fmt:message key="to" /></td>
										<td class="search" style="width: 40%;">
											<div style="width: 50%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%;">
													<input class="form-control" id="toDate" name="toDate" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="reviewed" /></td>
										<td class="search" colspan="3"><select id="reviewed" name="reviewed" class="narrow">
												<option value="">Choose</option>
												<option value="true"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="complianceStatus" /></td>
										<td class="search" colspan="3"><select id="complianceStatus" name="complianceStatus" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${complianceStatuses}" var="item">
													<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="quantity" /></td>
										<td class="search" colspan="3"><select id="quantityId" name="quantityId" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${quantityCategories}" var="category">
													<c:forEach items="${category.quantities}" var="quantity">
														<c:if test="${quantity.active}">
															<option value="<c:out value="${quantity.id}" />"><c:out value="${category.name}" /> -
																<c:out value="${quantity.name}" /></option>
														</c:if>
													</c:forEach>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel nowrap"><fmt:message key="measurement.active" /></td>
										<td colspan="3" class="search"><select id="measurementActive" name="measurementActive" class="narrow">
												<option value="true" selected="selected"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="sortName" /></td>
										<td class="search" colspan="3"><select id="sortName" name="sortName" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${sorts}" var="item">
													<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="primaryGroupByName" /></td>
										<td class="search" colspan="3"><select id="primaryGroupByName" name="primaryGroupByName">
												<c:forEach items="${primaryGroupBys}" var="item">
													<option value="<c:out value="${item}" />" selected="selected"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="secondaryGroupByName" /></td>
										<td class="search"><select id="secondaryGroupByName" name="secondaryGroupByName">
												<option value="">Choose</option>
												<c:forEach items="${secondaryGroupBys}" var="item">
													<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
												</c:forEach>
											</select></td>

										<td class="searchLabel2 nowrap" style="width: 200px;"><span style="display: none;"><fmt:message
												key="survey.limitPeriodQueryForm.recordsPerPage" /></span></td>
										<td class="search"></td>
									</tr>
								</tbody>

								<tfoot style="text-align: center">
									<tr>
										<td colspan="4">
											<button type="submit" class="g-btn g-btn--primary"
												onClick="this.form.pageNumber.value = 1;displayQueryTable(false);">
												<fmt:message key="search" />
											</button>
											<button type="button" class="g-btn g-btn--primary"
												onClick="return summarise(this.form, '/survey/limitPeriodSummarise.jpeg')">
												<fmt:message key="viewSummaryChart" />
											</button>
											<button type="reset" class="g-btn g-btn--secondary" onClick="hardResetForm(this.form);">
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
			<div id="resultsDiv"></div>

		</form>
	</div>

	<script type="text/javascript">
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryTable(false);
	</script>
</body>
</html>
