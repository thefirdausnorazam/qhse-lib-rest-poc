<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>


<style type="text/css">
td.search {
	background-color: white !important; border-width: 0px !important; padding-top: 20px !important;
	padding-left: 5% !important;
}

.col-sm-3,.col-sm-6{
	font-family: 'Open Sans', sans-serif !important;  font-size: 100%;line-height: 1.42857143;
}
span.error{
font-size: 100%;
}
.requiredHinted{
	font-size: 100% !important;  "
	}

a:link {
		color: #CF3030;
	}

a:hover {
	    color: #CF3030;
	}

a:visited {
	    color: #CF3030;
	}
</style>

<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#achieved").select2();
		jQuery("#actualScore").select2({
			width : '100%'
		});
		jQuery(".date").find(".requiredHinted").remove();
		<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.RiskAssessmentTask'}">
		var maxOriginalScore = false;
		jQuery(".actualScore > option").each(function (){
			if('${task.originalScore.score} - ${task.originalScore.name}' == jQuery(this).text()){
				maxOriginalScore = true;
				return;
			}
			if(maxOriginalScore){
				jQuery(this).remove();
			}
		});
		</c:if>
	});
	
</script>
</head>
<body>
	<div class="header nowrap">
		<h2>
			<c:choose>
				<c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
					<fmt:message key="subTaskCompleteForm.title" />
				</c:when>
				<c:otherwise>
					<fmt:message key="taskCompleteForm.title" />
				</c:otherwise>
			</c:choose>
		</h2>
	</div>
	<scannell:form>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="id" />
			</label>
			<div class="col-sm-3">
				<scannell:hidden path="id" />
				<scannell:hidden path="version" />
				<c:out value="${task.displayId}" />
			</div>

			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="status" />
			</label>
			<div class="col-sm-3">
				<fmt:message key="task.${task.status}" />
			</div>
		</div>

		<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel right">
					<fmt:message key="task.parentTask" />
				</label>
				<div class="col-sm-6">
					<c:url var="url" value="/risk/taskView.htm">
						<c:param name="id" value="${task.parentTask.id}" />
					</c:url>
					<a href="<c:out value="${url}" />">
						<c:out value="${task.parentTask.displayId}" />
					</a>
					-
					<scannell:text value="${task.parentTask.name}" />
				</div>
			</div>

		</c:if>


		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.name" />
			</label>
			<div class="col-sm-6">
				<scannell:text value="${task.name}" />
			</div>
		</div>



		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.additionalInformation" />
			</label>
			<div class="col-sm-6">
				<scannell:text value="${task.additionalInformation}" />
			</div>
		</div>


		<c:if test="${task.priority != null}">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel right">
					<fmt:message key="priority" />
				</label>
				<div class="col-sm-6">
					<fmt:message key="${task.priority}" />
				</div>
			</div>

		</c:if>


		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.creationDate" />
			</label>
			<div class="col-sm-3">
				<fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" />
			</div>
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.targetCompletionDate" />
			</label>
			<div class="col-sm-3">
				<fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" />
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.responsibleUser" />
			</label>
			<div class="col-sm-6">
				<c:out value="${task.responsibleUser.displayName}" />
			</div>
		</div>

		<c:if test="${task['class'].name != 'com.scannellsolutions.modules.risk.domain.SubTask'}">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel right">
					<fmt:message key="task.managementProgramme" />
				</label>
				<div class="col-sm-6">
					<c:if test="${task.managementProgramme != null}">
						<c:url var="url" value="/risk/managementProgrammeView.htm">
							<c:param name="id" value="${task.managementProgramme.id}" />
						</c:url>
						<a href="<c:out value="${url}" />">
							<c:out value="${task.managementProgramme.displayId}" />
						</a> -
        					<c:out value="${task.managementProgramme.name}" />
					</c:if>
				</div>
			</div>
		</c:if>


		<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.RiskAssessmentTask'}">
			<c:if test="${empty task.assessments}">
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel right">
						<fmt:message key="task.targetScore" />
					</label>
					<div class="col-sm-3">
						<scannell:text value="${task.targetScore.score} - ${task.targetScore.name}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel right">
						<fmt:message key="task.actualScore" />
					</label>
					<div class="col-sm-3">
						<select name="actualScore" id="actualScore" items="${task.assessmentScores[0].options}"
							itemLabel="scoreName" itemValue="id" class="wide actualScore" />
					</div>
				</div>
			</c:if>
		</c:if>


		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.achieved" />
			</label>
			<div class="col-sm-6">
				<scannell:select id="achieved" path="achieved" renderEmptyOption="false" cssStyle="width:20%">
					<scannell:option value="true" label="Yes" />
					<scannell:option value="false" label="No" />
				</scannell:select>
			</div>
		</div>

		<div class="form-group higher">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.completionDate" />
			</label>
			<div class="col-sm-6">
				<%-- <input name="completionDate" id="completionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionDate', true);"> --%>
				<div id="cal" style="width:250px;">
					<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
						style="width:200px;float:left">
						<scannell:input class="form-control" path="completionDate" id="completionDate" readonly="true" />
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				</div>
				<span class="requiredHinted">*</span>
			</div>
		</div>
		<div class="form-group higher">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="task.completionComment" />
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="completionComment" cols="75" rows="3" class="form-control" cssStyle="float:left;width:80%"/>
			</div>
		</div>

<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel right">
				<fmt:message key="createdBy" />
			</label>
			<div class="col-sm-6">
				<scannell:text value="${task.createdByUser.displayName}" />
				<fmt:message key="at" />
				<fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
			</div>
		</div>
		
		<div class="form-group">
			<c:if test="${task.lastUpdatedByUser != null}">
				<label class="col-sm-3 control-label scannellGeneralLabel right">
					<fmt:message key="lastUpdatedBy" />
				</label>
			<div class="col-sm-6">
					<scannell:text value="${task.lastUpdatedByUser.displayName}" />
					<fmt:message key="at" />
					<fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
				</div>
			</c:if>
		</div>

		<div class="spacer2 text-center">
			<input type="submit" value="<fmt:message key="submit" />" class="g-btn g-btn--primary">
			<input type="button" value="<fmt:message key="cancel" />" class="g-btn g-btn--secondary"
				onclick="window.location='<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>'">
		</div>
	</scannell:form>

</body>
</html>
