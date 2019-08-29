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
			width : '400px'
		});
		jQuery('#queryTable').hide();
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryTable(false);
	});

	function restoreSearchCriteria() {
		jQuery("#quantityId").val(
				'${sessionScope["measurementSearch.quantityId"]}');
		jQuery("#quantityCategoryId").val(
				'${sessionScope["measurementSearch.quantityCategoryId"]}');
		jQuery("#readingPointId").val(
				'${sessionScope["measurementSearch.readingPointId"]}');
		jQuery("#measureId").val(
				'${sessionScope["measurementSearch.measureId"]}');
		jQuery("#frequencyCode").val(
				'${sessionScope["measurementSearch.frequencyCode"]}');

		/*  if(${sessionScope["measurementSearch.active"]}){
		 	$jQuery("#active").val('${sessionScope["measurementSearch.active"]}');
		 }else{
		  $jQuery("#active").val('No');
		 } */
		jQuery("#sortName")
				.val('${sessionScope["measurementSearch.sortName"]}');

	}
	function resetForm() {
		jQuery('select').not('#siteLocation').not('.recordsPerPage > select')
				.select2("val", "");
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
					<form action="<c:url value="/survey/measurementView.htm" />" method="get"
						onsubmit="if(!jQuery('#gotoId')) return false;">
						<fmt:message key="survey.measurementQueryForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
							<fmt:message key="search.displaySearchCriteria" />
						</button>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='measurementEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="measurementCreate" />
							</button>
						</c:if>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
					</div>

				</div>
			</div>
			<input type="text" id="refreshCheck" value="no" style="display: none;">
		</div>
	</div>

	<div class="content">
		<scannell:form id="queryForm" action="/survey/measurementQuery.htmf"
			onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" id="calculateTotals" value="true"/>
				<scannell:hidden path="pageNumber" />
				<scannell:hidden path="pageSize" />
			<div id="queryTable">
				<div class="header">
					<h2>
						<fmt:message key="searchCriteria" />
					</h2>
				</div>
				<div class="content">
					<div class="table-responsive">
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="quantityCategoryId">
									<fmt:message key="quantityCategory" />
								</label>
								<select id="quantityCategoryId" name="quantityCategoryId" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${quantityCategories}" var="item">
										<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="quantityId">
									<fmt:message key="quantity" />
								</label>
								<select id="quantityId" name="quantityId" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${quantityCategories}" var="category">
										<c:forEach items="${category.quantities}" var="quantity">
											<c:if test="${quantity.active}">
												<option value="<c:out value="${quantity.id}" />">
													<c:out value="${category.name}" /> -
													<c:out value="${quantity.name}" />
												</option>
											</c:if>
										</c:forEach>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="measureId">
									<fmt:message key="measure" />
								</label>
								<select id="measureId" name="measureId" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${measures}" var="item">
										<option value="<c:out value="${item.id}" />"><c:out value="${item.measureName}" /></option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="readingPointId">
									<fmt:message key="readingPoint" />
								</label>	
								<select id="readingPointId" name="readingPointId" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${readingPoints}" var="item">
										<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="frequencyCode">
									<fmt:message key="frequency" />
								</label>
								<select id="frequencyCode" name="frequencyCode" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${frequencies}" var="item">
										<option value="<c:out value="${item.name}" />"><fmt:message key="${item}" /></option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap" for="active">
									<fmt:message key="active" />
								</label>
								<select id="active" name="active" class="narrow">
									<option value="">Choose</option>
									<option value="true" selected="selected"><fmt:message key="true" /></option>
									<option value="false"><fmt:message key="false" /></option>
								</select>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="sortName" /></label>
								<select id="sortName" name="sortName" class="wide">
									<option value="">Choose</option>
									<c:forEach items="${sorts}" var="item">
										<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
									</c:forEach>
								</select>
							</div>

							<div class="spacer2 text-center">
								<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);">
									<fmt:message key="search" />
								</button>
								<button type="reset" class="g-btn g-btn--secondary" onClick="resetForm();">
									<fmt:message key="reset" />
								</button>
							</div>
					</div>
				</div>
				</div>
			<div id="resultsDiv"></div>
		</scannell:form>
	</div>
	
</body>
</html>
