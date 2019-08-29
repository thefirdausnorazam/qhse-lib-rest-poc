<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>
<style type="text/css" media="print">

.page     {
	font-size: .8em; 
	zoom: 1;
	overflow:hidden !important;size: landscape;
     }
.nowrap{}
div { width: 100%;     border: 0;   overflow: hidden; size: auto;} 
.printFont{
	font-size:70%;
	/* width: 80% !important; */
}


body{width: 100%;}
</style>
<script type="text/javascript" src="<c:url value="/js/survey.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/effects.js" />"></script> --%>
<script type="text/javascript">
 jQuery(document).ready(function() {
		restoreSearchCriteria();
		jQuery('#queryForm').submit();
		jQuery('select').not('#siteLocation').select2({width:'40%'});
		jQuery('#queryTable').hide();
		jQuery("#queryTableToggleLink").text("Hide Search Criteria");
		displayQueryDiv(false);
 });
  /* function toggleQueryTable() {
    $('queryTableToggleLink').innerHTML = $('queryTable').visible() ? "Display Search Criteria" : "Hide Search Criteria";
    $('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
  } */
  function restoreSearchCriteria(){
		jQuery("#categoryId").val('${sessionScope["trainingSearch.categoryId"]}');
	  if('${sessionScope["trainingSearch.active"]}' == ''){
		  jQuery("#active").val('true');
		  }else{
			  jQuery("#active").val('${sessionScope["trainingSearch.active"]}');
		  } 
	  
	  jQuery("#dueDateFrom").val('${sessionScope["trainingSearch.dueDateFrom"]}');
	  jQuery("#dueDateTo").val('${sessionScope["trainingSearch.dueDateTo"]}');
	  jQuery("#lastDateFrom").val('${sessionScope["trainingSearch.lastDateFrom"]}');
	  jQuery("#lastDateTo").val('${sessionScope["trainingSearch.lastDateTo"]}');
	  jQuery("#userTrainee").val('${sessionScope["trainingSearch.userTrainee"]}');
	  jQuery("#thirdPartyTrainee").val('${sessionScope["trainingSearch.thirdPartyTrainee"]}');
	  jQuery("#company").val('${sessionScope["trainingSearch.company"]}');
	  jQuery("#departmentId").val('${sessionScope["trainingSearch.departmentId"]}');
	  jQuery("#sortName").val('${sessionScope["trainingSearch.sortName"]}');
	  jQuery("#responsibleId").val('${sessionScope["trainingSearch.responsibleId"]}');
	  jQuery("#carriedOutBy").val('${sessionScope["trainingSearch.carriedOutBy"]}');
	  jQuery("#description").val('${sessionScope["trainingSearch.description"]}');
	}
  function resetForm(){		
		jQuery('select').not('#siteLocation').not('#pageSize').not('.recordsPerPage > select').select2("val", "");		
		jQuery("#active").select2("val", "true");
	}
  
  function trimDescription(){
		jQuery("#description").val(jQuery.trim(jQuery("#description").val()));
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
<body><div class="page">
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6">
					</div>
				<div class="col-md-12 col-sm-12">
					<div style="text-align: right;">
					<form action="<c:url value="/maintenance/trainingRecordView.htm" />" method="get"
						onsubmit="if(!jQuery('#gotoId')) return false;">
						<fmt:message key="maintenance.trainingQueryForm.goTo" />
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<c:if test="${!hideControls}">
							<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
								<fmt:message key="search.displaySearchCriteria" />
							</button>
						</c:if>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='trainingEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="trainingCreate" />
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
		<form id="queryForm" action="<c:url value="/maintenance/trainingQuery.htmf" />"
			onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" name="calculateTotals" value="true" />
			<input type="hidden" name="pageNumber" value="1" />
			<input type="hidden" id="pageSize" name="pageSize"/>
			<div id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>
				<div class="content">
					<div class="table-responsive">
						<div class="panel">
							<table id="queryTable" class="table table-bordered table-responsive printFont">


								<tbody>
									<tr class="form-group">
										<td class="searchLabel"><label for="categoryId">
												<fmt:message key="training.category" />
											</label></td>
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
										<td class="searchLabel"><label for="active">
												<fmt:message key="active" />
											</label></td>
										<td class="search"><select id="active" name="active" class="narrow" style="min-width: 100%">
												<option value="true" selected="selected"><fmt:message key="true" /></option>
												<option value="false"><fmt:message key="false" /></option>
											</select></td>
										<td class="searchLabel nowrap" style="width:200px;">
											<label for="description">
												<fmt:message key="description" />
											</label>
										</td>
										<td class="search"><input type="text" id="description" name="description" style="width:50%" /></td>
									</tr>
									
									<tr class="form-group">
										<td class="searchLabel"><label for="dueDateFrom">
												<fmt:message key="training.dueDate" />
												<fmt:message key="from" />
											</label></td>
										<td class="search" style="width: 20%;">
											<div style="width: 100%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%;">
													<input class="form-control" id="dueDateFrom" name="dueDateFrom" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>


										</td>
										
										<td class="searchLabel" style="width: 5%;"><fmt:message key="to" /></td>
										
										<!-- <td class="searchLabel2" style="width: 20px;"><fmt:message key="to" /></td> -->
										<td class="search" style="width: 40%;">
											<div style="width: 50%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%;">
													<input class="form-control" id="dueDateTo" name="dueDateTo" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="lastDateFrom">
												<fmt:message key="training.lastDate" />
												<fmt:message key="from" />
											</label></td>
										<td class="search" style="width: 20%;">
											<div style="width: 100%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%;">
													<input class="form-control" id="lastDateFrom" name="lastDateFrom" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>


										</td>
										<td class="searchLabel" style="width: 5%;"><fmt:message key="to" /></td>
										<!-- <td class="searchLabel2" style="width: 20px;"><fmt:message key="to" /></td> -->
										<td class="search" style="width: 40%;">
											<div style="width: 50%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 100%">
													<input class="form-control" id="lastDateTo" name="lastDateTo" size="6" type="text" readonly>
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>
										</td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="userTrainee">
												<fmt:message key="trainee" />
												(
												<fmt:message key="traineeType[u]" />
												)
											</label></td>
										<td colspan="3" class="search"><select id="userTrainee" name="userTrainee" class="wide selectSize300">
												<option value="">Choose</option>
												<c:forEach items="${userTrainees}" var="userTrainee">
													<option value="<c:out value="${userTrainee.id}" />"><c:out value="${userTrainee.sortableName}" /></option>
												</c:forEach>
											</select></td>
									</tr>
									<tr class="form-group">
										<td class="searchLabel nowrap"><label for="thirdPartyTrainee">
												<fmt:message key="trainee" />
												(
												<fmt:message key="traineeType[t]" />
												)
											</label></td>
										<td colspan="3" class="search"><select id="thirdPartyTrainee" name="thirdPartyTrainee" class="wide selectSize300">
												<option value="">Choose</option>
												<c:forEach items="${thirdPartyTrainees}" var="thirdPartyTrainee">
													<option value="<c:out value="${thirdPartyTrainee.id}" />"><c:out value="${thirdPartyTrainee.name}" /></option>
												</c:forEach>
											</select></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><label for="company">
												<fmt:message key="company" />
											</label></td>
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
										<td class="searchLabel"><label for="responsibleId">
												<fmt:message key="training.responsible" />
											</label></td>
										<td colspan="3" class="search"><select id="responsibleId" name="responsibleId" class="wide selectSize300">
												<option value="">Choose</option>
												<c:forEach items="${users}" var="user">
													<option value="<c:out value="${user.id}" />">
														<c:out value="${user.sortableName}" />
													</option>
												</c:forEach>
											</select></td>
									</tr>
									<tr class="form-group">
										<td class="searchLabel"><label for="departmentId">
												<fmt:message key="training.department" />
											</label></td>
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
										<td class="searchLabel"><label for="carriedOutBy">
												<fmt:message key="training.carriedOutBy" />
											</label></td>
										<td colspan="3" class="search"><input type="text" id="carriedOutBy" name="carriedOutBy"
												style="width: 300px;" /></td>
									</tr>

									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="sortName" /></td>
										<td class="search"><select id="sortName" name="sortName" class="wide selectSize300">
												<option value="">Choose</option>
												<c:forEach items="${sorts}" var="item">
													<option value="<c:out value="${item}" />">
														<fmt:message key="${item}" />
													</option>
												</c:forEach>
											</select></td>

										<td class="searchLabel nowrap" style="width: 200px;"><span style="display: none;"><fmt:message
												key="maintenance.trainingQueryForm.recordsPerPage" /></span></td>
										<td class="search"></td>
									</tr>
								</tbody>
								<tfoot style="text-align: center">
									<tr>
										<td colspan="4">
											<button type="submit" class="g-btn g-btn--primary"
												onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();">
												<fmt:message key="search" />
											</button>
											<button type="reset" class="g-btn g-btn--secondary" onClick="resetForm();">
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
</div>
</body>
</html>
