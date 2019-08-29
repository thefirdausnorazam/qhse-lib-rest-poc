<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ideagen" uri="https://www.ideagen.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
 <!--  <meta name="printable" content="true"> -->
  <title><fmt:message key="taskQueryForm.title" /></title>

	<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/showUsers.css'/>" type="text/css" />
  <c:set value="500" var="maxListSize"/>
  <script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
		jQuery('select').not('#siteLocation').not('#responsibleUser').select2({width:'100%'});
		var responsibleUserText='';
		var responsibleUserId= '<c:out value="${command.responsibleUser.id}"/>';
		if(responsibleUserId != null){
			responsibleUserText= '<c:out value="${command.responsibleUser.sortableName}"/>';
			jQuery('#responsibleUser').val(responsibleUserId);
		}
		showResponsibleUserList(${fn:length(userList)}, "100", "userTaskList.json", responsibleUserId,responsibleUserText);
		if('${quickLink}' != '') {
			clearForm();
			var selectedStatus = '${selectedStatus}';
			var selectDepartment = '${selectedDepartment}';
			if(selectedStatus || selectDepartment) {
				jQuery("#status").val(selectedStatus).trigger('change');
				jQuery("#departmentId").val(selectDepartment).trigger('change');
			}
		}
		init();
		jQuery('#queryDiv').hide();

		jQuery('#status option').each(function () {
			if(this.value == 'REJECTED'){
				jQuery(this).remove();
			}
		});
	});
  function clearForm(){
	  jQuery('#responsibleUser').val('').change();
	  if(jQuery("#responsibleUser").is("input") == false){
	  		jQuery("#responsibleUser").select2().select2('val', jQuery('#responsibleUser option:eq(0)').val());
		}
	  jQuery('select').not('#siteLocation').not('#lawTabs').not('#profileSelect').not('.recordsPerPage > select').select2('val', '');
	  jQuery('#queryForm')[0].reset();
	  jQuery('#status').val('');
	  jQuery('#name').val('');
	  jQuery("#businessArea").val("");
  }

  function init() {
  	copyFormValuesIfPopup('queryForm');
  	jQuery('#queryForm').submit();
  }

  function trimDescription(){
	jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  }
  </script>
</head>
<body>

<div class="noprint">
  <div style="text-align:right;">
  <form action="<c:url value="/law/taskViewSearch.htm" />" method="get" onsubmit="if(!$F('gotoId')) return false;">
    <fmt:message key="GoToLT" /><input type="text" id="gotoId" name="id" size="3"><input type="submit" value=<fmt:message key="go"/> class="g-btn g-btn--primary">
   <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;<fmt:message key='search.displaySearch'/></button>
   <button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print printcolor" style="color:white"></i><span class="printcolor"></span></button>
  </form>
  </div>

 </div>

<ideagen:form cssClass="form-horizontal group-border-dashed" id="queryForm" action="/law/taskQueryResult.htmf" onsubmit="updateSearchCriteriaSummary(); displayQueryTable(false); return searchExcelCheck(this, 'resultsTaskDiv');">
	<input name="calculateTotals" type="hidden" value="true" />
	<input name="pageNumber" type="hidden" value="1" />
	<input name="pageSize" type="hidden" value="20" />
	<div class="content" id ="queryDiv">
		<div class="content" id ="queryTable">
			<div class="header">
				<h3><fmt:message key="searchCriteria" /></h3>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
					<fmt:message key="businessAreas" />
				</label>
				<div class="col-sm-6">
					<select id="businessArea" name="businessAreaId" class="wide" style="width:100%" tabindex="-1">
						<option value="">Choose</option>
						<option value="3">Business</option>
						<option value="1">Environmental</option>
						<option value="2">Health &amp; Safety</option>
						<option value="1003">Quality</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="task.name" /></label>
				<div class="col-sm-6">
					<input name="name" id="name" class="form-control" style="width:100%" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="task.type" /></label>
				<div class="col-sm-6">
					<select id="type" name="type" class="wide">
						<option value="">Choose</option>
						<option value="LT">Compliance Task</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="responsibleUser" /></label>
				<div class="col-sm-6">
					<c:choose>
						<c:when test="${fn:length(userList) lt maxListSize && fn:length(userList) > 0}">
							<select id="responsibleUser" name="responsibleUser" class="wide">
								<option value="">Choose</option>
								<option value="10000000071">Barnett, Derek</option>
							</select>
						</c:when>
						<c:otherwise>
								<input type="hidden" id="responsibleUser" class="wide" style="width:100% !important;"  name="responsibleUser" />
						</c:otherwise>
					</c:choose> (Choose = All)
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="task.status" /></label>
				<div class="col-sm-6">
					<select id="status" name="status" class="wide">
						<option value="">Choose</option>
						<option value="IN_PROGR" selected="true">In Progress</option>
						<option value="COMPLETE">Complete</option>
						<option value="TRASH">Trash</option>
						<option value="ARCHIVE">Archive</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="priority" /></label>
				<div class="col-sm-6">
					<select id="priority" name="priority" class="wide" >
						<option value="">Choose</option>
						<option value="Low">Low</option>
						<option value="Medium">Medium</option>
						<option value="High">High</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="department" /></label>
				<div class="col-sm-6">
					<ideagen:select id="departmentId" name="departmentId" items="${departments.list}" selected="${departments.selected}" cssClass="wide" cssStyle="width:100%"/>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<input class="form-control" size="16" id="startDateFrom" name="startDateFrom" type="text"  readonly>
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">

				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"> <fmt:message key="to" /></label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<input class="form-control" size="16" id="startDateTo" name="startDateTo" type="text"  readonly>
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="targetCompletionDateFrom" /> </label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<input class="form-control" size="16" id=targetCompletionDateFrom name="targetCompletionDateFrom" type="text"  readonly>
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="targetCompletionDateTo" /> </label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<input class="form-control" size="16" id="targetCompletionDateTo" name="targetCompletionDateTo" type="text"  readonly>
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="completionDate" /> <fmt:message key="from" /> </label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						   <input class="form-control" size="16" id=completionDateFrom name="completionDateFrom" type="text"  readonly>
						   <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="completionDate" /> <fmt:message key="to" /> </label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<input class="form-control" size="16" id="completionDateTo" name="completionDateTo" type="text"  readonly>
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="createdBy" /></label>
				<div class="col-sm-6">
					<select id="createdByUser" name="createdByUser" class="wide">
						<option value="">Choose</option>
						<option value="10000000071">Barnett, Derek</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="overdue" /></label>
				<div class="col-sm-6">
					<input id="overdue" name="overdue" class="narrow" type="checkbox" value="true">
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap rightAlign"><fmt:message key="sortName" /></label>
				<div class="col-sm-6">
					<select id="sortName" name="sortName" class="wide" tabindex="-1">
						<option value="">Choose</option>
						<option value="id">ID</option>
					</select>
				</div>
			</div>

			<div class="spacer2 text-center">
				<button type="submit" class="g-btn g-btn--primary" onClick="resetExcelRequest();this.form.pageNumber.value = 1;trimDescription();"><fmt:message key="search" /></button>
				<button type="button" class="g-btn g-btn--secondary" onClick="resetExcelRequest();clearForm()" ><fmt:message key="reset" /></button>
					<c:if test="${createExcel == true}">
							<button type="submit" class="g-btn g-btn--primary" onClick="excelRequest();this.form.pageNumber.value = 1;"><fmt:message key="exportToExcel" /></button>
					</c:if>
				<input type="hidden" id="excel" name="excel" value="NO" />
			</div>
		</div>
	</div>
	<div id="searchCriteria.summary"></div>
	<div id="resultsTaskDiv"></div>
</ideagen:form>

<script type="text/javascript">
toggleQueryTable();
</script>
</body>
</html>
