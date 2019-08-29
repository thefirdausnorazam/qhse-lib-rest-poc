<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript">
 jQuery(document).ready(function() {
		restoreSearchCriteria();
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({width:'300px'});
		
		jQuery('#queryTable').hide();
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryTable(false);
	})
  /* function toggleQueryTable() {
    $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
    $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
  } */
  function restoreSearchCriteria(){
	 jQuery("#categoryId").val('${sessionScope["ppeSearch.categoryId"]}');
	  
		if('${sessionScope["ppeSearch.active"]}' == '') {
			jQuery("#active").val('true');
		} else {
			jQuery("#active").val('${sessionScope["ppeSearch.active"]}');
		}
	  jQuery("#dueDateFrom").val('${sessionScope["ppeSearch.dueDateFrom"]}');
	  jQuery("#dueDateTo").val('${sessionScope["ppeSearch.dueDateTo"]}');
	  jQuery("#lastDateFrom").val('${sessionScope["ppeSearch.lastDateFrom"]}');
	  jQuery("#lastDateTo").val('${sessionScope["ppeSearch.lastDateTo"]}');
	  jQuery("#userTrainee").val('${sessionScope["ppeSearch.userTrainee"]}');
	  jQuery("#thirdPartyTrainee").val('${sessionScope["ppeSearch.thirdPartyTrainee"]}');
	  jQuery("#company").val('${sessionScope["ppeSearch.company"]}');
	  jQuery("#departmentId").val('${sessionScope["ppeSearch.departmentId"]}');
	  jQuery("#sortName").val('${sessionScope["ppeSearch.sortName"]}');
}
  
  function resetOtherValues() {
	  jQuery("#categoryId").select2({width:'300px'}).select2('val', jQuery('#categoryId option:eq(0)').val());
	  jQuery("#active").select2("val", "true");
	  jQuery("#userTrainee").select2({width:'300px'}).select2('val', jQuery('#userTrainee option:eq(0)').val());
	  jQuery("#thirdPartyTrainee").select2({width:'300px'}).select2('val', jQuery('#thirdPartyTrainee option:eq(0)').val());
	  jQuery("#company").select2({width:'300px'}).select2('val', jQuery('#company option:eq(0)').val());
	  jQuery("#departmentId").select2({width:'300px'}).select2('val', jQuery('#departmentId option:eq(0)').val());
	  jQuery("#sortName").select2({width:'300px'}).select2('val', jQuery('#sortName option:eq(0)').val());
	  jQuery("#pageSize").select2({width:'300px'}).select2('val', jQuery('#pageSize option:eq(1)').val());
  }
  </script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
@import "<c:url value='/css/survey.css'/>";

.selectSize300{
	width:300px !important;
}
</style>

</head>
<body onload=";">
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6">
					
				</div>
				<div class="col-md-12 col-sm-12">
					<div style="text-align: right;">
					<form action="<c:url value="/maintenance/ppeRecordView.htm" />" method="get"
						onsubmit="if(!jQuery('#gotoId')) return false;">
						<fmt:message key="maintenance.ppeQueryForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<c:if test="${!hideControls}">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
								<fmt:message key="search.displaySearchCriteria" />
							</button>
						</c:if>
						<c:if test="${addButtonEnabled == true}">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='ppeEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="ppeCreate" />
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
	<form id="queryForm" action="<c:url value="/maintenance/ppeQuery.htmf" />"
		onsubmit="return search(this, 'resultsDiv');">
		<input type="hidden" name="calculateTotals" value="true" />
		<input type="hidden" name="pageNumber" value="1" />
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
						<table id="queryTable" class="table table-bordered table-responsive">
							<col />

							<tbody>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="ppe.category" /></td>
									<td colspan="3" class="search"><select id="categoryId" name="categoryId" class="wide selectSize300">
											<option value="">Choose</option>
											<c:forEach items="${categories}" var="category">
												<option value="<c:out value="${category.id}" />">
													<c:out value="${category.name}" />
												</option>
											</c:forEach>
										</select></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="active" /></td>
									<td colspan="3" class="search"><select id="active" name="active" class="narrow selectSize300">
											<option value="true" selected="selected"><fmt:message key="true" /></option>
											<option value="false"><fmt:message key="false" /></option>
										</select></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel nowrap"><fmt:message key="ppe.dueDate" /> <fmt:message key="from" /></td>
									<td class="search" style="width: 20%;">
										<div style="width: 100%;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 100%;">
												<input class="form-control" id="dueDateFrom" name="dueDateFrom" size="6" type="text" readonly>
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>


									</td>
									<td class="searchLabel2" style="width: 5%;"><fmt:message key="to" /></td>
									<td class="search" style="width: 40%;">
										<div style="width: 50%;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 100%;">
												<input class="form-control" id="dueDateTo" name="dueDateTo" size="6" type="text" readonly>
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="ppe.lastDate" /> <fmt:message key="from" /></td>
									<td class="search" style="width: 20%;">
										<div style="width: 100%;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 100%;">
												<input class="form-control" id="lastDateFrom" name="lastDateFrom" size="6" type="text" readonly>
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>


									</td>

									<td class="searchLabel2" style="width: 5%;"><fmt:message key="to" /></td>

									<td class="search" style="width: 40%;">
										<div style="width: 50%;">
											<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 100%;">
												<input class="form-control" id="lastDateTo" name="lastDateTo" size="6" type="text" readonly>
												<span class="input-group-addon btn btn-primary">
													<span class="glyphicon glyphicon-th"></span>
												</span>
											</div>
										</div>
									</td>


								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="ppe.receiver" /> (<fmt:message key="traineeType[u]" />)</td>
									<td colspan="3" class="search"><select id="userTrainee" name="userTrainee" class="wide selectSize300">
											<option value="">Choose</option>
											<c:forEach items="${userTrainees}" var="userTrainee">
												<option value="<c:out value="${userTrainee.id}" />"><c:out value="${userTrainee.sortableName}" /></option>
											</c:forEach>
										</select></td>
								</tr>
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="ppe.receiver" /> (<fmt:message key="traineeType[t]" />)</td>
									<td colspan="3" class="search"><select id="thirdPartyTrainee" name="thirdPartyTrainee" class="wide selectSize300">
											<option value="">Choose</option>
											<c:forEach items="${thirdPartyTrainees}" var="thirdPartyTrainee">
												<option value="<c:out value="${thirdPartyTrainee.id}" />"><c:out value="${thirdPartyTrainee.name}" /></option>
											</c:forEach>
										</select></td>
								</tr>
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="company" /></td>
									<td colspan="3" class="search"><select id="company" name="company" class="wide selectSize300">
											<option value="">Choose</option>
											<c:forEach items="${thirdPartyCompanies}" var="thirdPartyCompany">
												<option value="<c:out value="${thirdPartyCompany.company}" />">
													<c:out value="${thirdPartyCompany.company}" />
												</option>
											</c:forEach>
										</select></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="department" /></td>
									<td colspan="3" class="search"><select id="departmentId" name="departmentId" class="wide selectSize300">
											<option value="">Choose</option>
											<c:forEach items="${departmentsobsolete}" var="department">
												<option value="<c:out value="${department.id}" />">
													<c:out value="${department.name}" />
												</option>
											</c:forEach>
										</select></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="sortName" /></td>
									<td colspan="3"  class="search" style="border: 1px solid red"><select name="sortName" class="wide selectSize300">
											<option value="id">
													<fmt:message key="choose" />
												</option>
											<c:forEach items="${sorts}" var="item">
												<option value="<c:out value="${item}" />">
													<fmt:message key="${item}" />
												</option>
											</c:forEach>
										</select>
								</tr>
								<tr class="form-group" style="display: none;">
									<td class="searchLabel"><span style="display: none;"><fmt:message key="maintenance.ppeQueryForm.recordsPerPage" /></span></td>
									<td colspan="3" class="search"><select name="pageSize" id="pageSize" style="display: none;">
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
							<tfoot style="text-align: center">

								<tr>
									<td colspan="4">
										<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);">
											<fmt:message key="search" />
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
