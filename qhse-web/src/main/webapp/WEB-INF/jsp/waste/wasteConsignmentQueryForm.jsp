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
<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/effects.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		restoreSearchCriteria();
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({
			width : '400px'
		});
		jQuery('#queryTable').hide();
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryTable(false);
	});
	/* function toggleQueryTable() {
	 $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
	 $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
	 } */
	function restoreSearchCriteria() {
		jQuery("#shipmentNo").val(
				'${sessionScope["wasteConsignmentSearch.shipmentNo"]}');
		if('${sessionScope["wasteConsignmentSearch.active"]}' == '') {
			jQuery("#active").val('true');
		} else {
			jQuery("#active").val('${sessionScope["wasteConsignmentSearch.active"]}');
		}
		
		jQuery("#brokerId").val(
				'${sessionScope["wasteConsignmentSearch.brokerId"]}');
		jQuery("#carrierId").val(
				'${sessionScope["wasteConsignmentSearch.carrierId"]}');
		jQuery("#consigneeId").val(
				'${sessionScope["wasteConsignmentSearch.consigneeId"]}');
		jQuery("#wasteTypeId").val(
				'${sessionScope["wasteConsignmentSearch.wasteTypeId"]}');
		jQuery("#shippedDateFrom").val(
				'${sessionScope["wasteConsignmentSearch.shippedDateFrom"]}');
		jQuery("#shippedDateTo").val(
				'${sessionScope["wasteConsignmentSearch.shippedDateTo"]}');
		jQuery("#shippingCompleted").val(
				'${sessionScope["wasteConsignmentSearch.shippingCompleted"]}');
		jQuery("#reconcilliationCompleted")
				.val(
						'${sessionScope["wasteConsignmentSearch.reconcilliationCompleted"]}');
	}
	 function resetOtherValues() {
		 
		  	
		  	jQuery("#active").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#brokerId").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#carrierId").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#consigneeId").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#wasteTypeId").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#shippingCompleted").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			jQuery("#reconcilliationCompleted").select2({width:'400px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
			//jQuery("#pageSize").select2({width:'400px'}).select2('val', jQuery('#pageSize option:eq(1)').val());
	  }
	 function trimDescription(){
			jQuery("#shipmentNo").val(jQuery.trim(jQuery("#shipmentNo").val()));
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
				<div class="col-md-12 col-sm-12 pull-right">
					<div style="text-align: right;">
					<form action="<c:url value="/waste/wasteConsignmentView.htm" />" method="get"
						onsubmit="if(!jQuery('#gotoId')) return false;">
						<fmt:message key="waste.wasteConsignmentQueryForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
							<fmt:message key="search.displaySearchCriteria" />
						</button>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='wasteConsignmentEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="wasteConsignmentCreate" />
							</button>
						</c:if>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<form id="queryForm" action="<c:url value="/waste/wasteConsignmentQuery.htmf" />"
			onSubmit="return search(this, 'resultsDiv'); ">

			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" name="chartWidth" value="700" />
			<input type="hidden" name="chartHeight" value="400" />
			<input type="hidden" name="aggregateName" value="weight" />
			<input type="hidden" name="primaryGroupByName" value="treatmentType" />
			<div id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>
				<div class="content">
					<div class="table-responsive">
						<div class="panel">
							<table id="queryTable" class="table table-bordered table-responsive">

								<tbody id="searchCriteria">

									<tr class="form-group">
										<td class="searchLabel"><label for="shipmentNo">
												<fmt:message key="shipmentNo" />
											</label></td>
										<td class="search">
										<input type="text" id="shipmentNo" name="shipmentNo" style="width: 400px;"  class="form-control"/>
										</td>

										<td class="searchLabel"><label for="active">
												<fmt:message key="active" />
											</label></td>
										<td class="search"><select id="active" name="active" class="narrow">
												<option value="">Choose</option>
												<option value="true" selected="selected"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
									</tr>

									<c:if test="${displayBrokers}">
										<tr class="form-group">
											<td class="searchLabel"><label for="brokerId">
													<fmt:message key="broker" />
												</label></td>
											<td colspan="3" class="search"><select id="brokerId" name="brokerId" class="wide">
													<option value="">Choose</option>
													<c:forEach items="${brokers}" var="broker">
														<option value="<c:out value="${broker.id}" />"><c:out value="${broker.name}" /></option>
													</c:forEach>
												</select></td>
										</tr>
									</c:if>

									<tr class="form-group">
										<td class="searchLabel"><label for="carrierId">
												<fmt:message key="carrier" />
											</label></td>
										<td colspan="3" class="search"><select id="carrierId" name="carrierId" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${carriers}" var="carrier">
													<option value="<c:out value="${carrier.id}" />"><c:out value="${carrier.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="consigneeId">
												<fmt:message key="consignee" />
											</label></td>
										<td colspan="3" class="search"><select id="consigneeId" name="consigneeId" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${consignees}" var="consignee">
													<option value="<c:out value="${consignee.id}" />"><c:out value="${consignee.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="wasteTypeId">
												<fmt:message key="wasteType" />
											</label></td>
										<td colspan="3" class="search"><select id="wasteTypeId" name="wasteTypeId" class="wide">
												<option value="">Choose</option>
												<c:forEach items="${wasteTypes}" var="wasteType">
													<option value="<c:out value="${wasteType.id}" />"><c:out value="${wasteType.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="fromDate">
												<fmt:message key="startDate" />
												<fmt:message key="from" />
											</label></td>
										<td class="search">
											<div style="width: 250px;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 200px;">
													<input class="form-control" id="shippedDateFrom" name="shippedDateFrom" size="6" type="text" value="" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
										<td class="searchLabel"><label for="toDate">
												<fmt:message key="to" />
											</label></td>
										<td class="search">
											<div style="width: 250px;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 200px;">
													<input class="form-control" id="shippedDateTo" name="shippedDateTo" size="6" type="text" value="" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="shippingCompleted">
												<fmt:message key="shippingCompleted" />
											</label></td>
										<td class="search"><select id="shippingCompleted" name="shippingCompleted" class="narrow">
												<option value="">Choose</option>
												<option value="true"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
									</tr>
									<tr class="form-group">
										<td class="searchLabel nowrap"><label for="reconcilliationCompleted">
												<fmt:message key="reconcilliationCompleted" />
											</label></td>
										<td class="search"><select id="reconcilliationCompleted" name="reconcilliationCompleted" class="narrow">
												<option value="">Choose</option>
												<option value="true"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
										<td class="searchLabel nowrap"><span style="display: none;"><fmt:message key="waste.wasteConsignmentItemQueryForm.recordsPerPage" /></span></td>
										<td class="search"><select name="pageSize" id="pageSize" style="display: none;">
												<c:forEach items="${recordsPerPage}" var="recordPerPage">
													<option value="<c:out value="${recordPerPage.value}" />"
														<c:if test="${recordPerPage.value == pageSize}">selected="selected"</c:if>>
														<fmt:message key="${recordPerPage}" />
													</option>
												</c:forEach>
												<option value="100">100 Records</option>
												<option value="500">500 Records</option>
											</select></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="4" style="text-align: center">
											<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryTable(false);trimDescription();">
												<fmt:message key="search" />
											</button>
											<button type="button" class="g-btn g-btn--primary"
												onClick="return summarise(this.form, '/waste/wasteConsignmentSummarise.jpeg')">
												<fmt:message key="viewSummaryChart" />
											</button>
											<button type="reset" class="g-btn g-btn--secondary" onclick="resetOtherValues()">
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
</body>
</html>
