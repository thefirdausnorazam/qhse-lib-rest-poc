<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<c:set var="task" value="${command.entity}" />
<html>
<head>
<style type="text/css">
td.search {
	padding-left: 5% !important;
}
.showSubTask {
}
</style>
<title>

</title>
<script type="text/javascript">
jQuery(document).ready(function() {
	var objs = jQuery(".showSubTask");
	if(objs.length < 1) {
		jQuery("#showSubTask").hide();
	}
	
	jQuery("#submitButton").click(function() {
		setTimeout(function() {
			jQuery("#submitButton").prop("disabled", true);
		}, 1);
	});
});
</script>
</head>
<body>
	<div class="header">
		<h2>
			<c:choose>
				<c:when test="${archiveEntity and task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
					<fmt:message key="subTaskArchiveForm.title" />
				</c:when>
				<c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
					<fmt:message key="subTaskTrashForm.title" />
				</c:when>
				<c:when test="${archiveEntity}">
					<fmt:message key="taskArchiveForm.title" />
				</c:when>
				<c:otherwise>
					<fmt:message key="taskTrashForm.title" />
				</c:otherwise>
			</c:choose>
		</h2>
	</div>
	<scannell:form>
		<div class="content">  
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<%-- <col  /> --%>
						<tbody>
  							<tr>
  								<td class="scannellGeneralLabel">
  									<fmt:message key="id" />
  								</td>
  								<td>
  									<scannell:hidden writeRequiredHint="false" path="id" />
									<scannell:hidden writeRequiredHint="false" path="version" />
									<c:out value="${task.displayId}" />
  								</td>
  								<td class="scannellGeneralLabel">
  									<fmt:message key="task.status" />
  								</td>
  								<td>
  									<fmt:message key="task.${task.status}" />
  								</td>
  							</tr>
  							<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
  							<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.parentTask" />
    							</td>
    							<td colspan="3">
    								<c:if test="${task.parentTask != null}">
										<c:url var="url" value="/risk/taskView.htm">
											<c:param name="id" value="${task.parentTask.id}" />
										</c:url>
										<a href="<c:out value="${url}" />"><c:out value="${task.parentTask.displayId}" /></a> -
					        			<scannell:text value="${task.parentTask.name}" />
									</c:if>
    							</td>
    						</tr>
    						</c:if>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.name" />
    							</td>
    							<td colspan="3">
    								<scannell:text value="${task.name}" />
    							</td>
    						</tr>
    						<tr>
    							<td  class="scannellGeneralLabel">
    								<fmt:message key="task.additionalInformation" />
    							</td>
    							<td colspan="3">
    								<scannell:text value="${task.additionalInformation}" />
    							</td>
    						</tr>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.creationDate" />
    							</td>
    							<td >
    								<fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" />
    							</td>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.targetCompletionDate" />
    							</td>
    							<td >
    								<fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" />
    							</td>
    						</tr>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.responsibleUser" />
    							</td>
    							<td colspan="3">
    								<c:out value="${task.responsibleUser.displayName}" />
    							</td>
    						</tr>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.managementProgramme" />
    							</td>
    							<td colspan="3">
    								<c:choose>
										<c:when test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.SubTask'}">
											<c:set var="managementProgramme" value="${task.parentTask.managementProgramme}" />
										</c:when>
										<c:otherwise>
											<c:set var="managementProgramme" value="${task.managementProgramme}" />
										</c:otherwise>
									</c:choose>
									<c:if test="${managementProgramme != null}">
										<c:url var="url" value="/risk/managementProgrammeView.htm">
											<c:param name="id" value="${managementProgramme.id}" />
										</c:url>
										<a href="<c:out value="${url}" />"><c:out value="${managementProgramme.displayId}" /></a> -
						      			<c:out value="${managementProgramme.name}" />
									</c:if>
    							</td>
    						</tr>
    						<c:if test="${task['class'].name == 'com.scannellsolutions.modules.risk.domain.RiskAssessmentTask'}">
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.targetScore" />
    							</td>
    							<td ${task.completed == false ? "colspan='3'" : ""}>
    								<c:out value="${task.targetScore.score} - ${task.targetScore.name}" />
    							</td>
    							<c:if test="${task.completed}">
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.actualScore" />
    							</td>
    							<td>
    								<c:out value="${task.actualScore.score} - ${task.actualScore.name}" />
    							</td>
    							</c:if>
    						</tr>
    						</c:if>
    						<c:if test="${task.completed}">
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.achieved" />
    							</td>
    							<td >
    								<fmt:message key="boolean.${task.achieved}" />
    							</td>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="task.completedBy" />
    							</td>
    							<td >
    								<c:out value="${task.completedByUser.displayName}" />
									<fmt:message key="at" />
									<fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" />
    							</td>
    						</tr>
    						<tr>
    							<td class="scannellGeneralLabel"><fmt:message key="task.completionComment" /></td>
    							<td colspan="3"><scannell:text value="${task.completionComment}" /></td>
    						</tr>
    						</c:if>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="associatedDocuments" />
    							</td>
    							<td colspan="3">
									<c:set var="showLatest" value="${task.status.name != 'COMPLETE'}" scope="request"/>
									<jsp:include page="../doclink/showLinkedDocs.jsp" />
								</td>
    						</tr>
    						<tr>
    							<td class="scannellGeneralLabel">
    								<fmt:message key="createdBy" />
    							</td>
    							<td ${task.lastUpdatedByUser == null ? "colspan='3'" : ""}>
    								<c:out value="${task.createdByUser.displayName}" />
									<fmt:message key="at" />
									<fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    							</td>
    							<c:if test="${task.lastUpdatedByUser != null}">
    							<td class="scannellGeneralLabel">
    								<fmt:message key="lastUpdatedBy" />
    							</td>
    							<td>
    								<c:out value="${task.lastUpdatedByUser.displayName}" />
									<fmt:message key="at" />
									<fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    							</td>
    							</c:if>
    						</tr>
    						<tr id="showSubTask"><c:set var="displayedWarningMessage" value="false" />
    							<td></td>
    							<td colspan="3">
    								<ul>
										<c:forEach var="subTask" items="${task.subTasks}">
											<c:if test="${not (subTask.archived or subTask.completed or subTask.trashed)}">
												<c:if test="${not displayedWarningMessage}">
													<c:set var="displayedWarningMessage" value="true" />
													<fmt:message key="assessmentTrashForm.openTasks" />
												</c:if>
												<li class="showSubTask"><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${subTask.id}"/></c:url>"><c:out
															value="${subTask.displayId}" /></a></li>
											</c:if>
										</c:forEach>
									</ul>
    							</td>
    							
    						</tr>
    					</tbody>
    					<tfoot>
    						<tr>
    							<td colspan="4" align="center">
		    						<c:choose>
										<c:when test="${archiveEntity}">
											<fmt:message var="submitButton" key="archive" />
										</c:when>
										<c:when test="${task.trashed}">
											<fmt:message var="submitButton" key="untrash" />
										</c:when>
										<c:otherwise>
											<fmt:message var="submitButton" key="trash" />
										</c:otherwise>
									</c:choose> 
									<input id="submitButton" type="submit" class="g-btn g-btn--primary" value="<c:out value="${submitButton}" />"> <input type="button"
										class="g-btn g-btn--primary" value="<fmt:message key="cancel" />"
										onclick="window.location='<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>'">
    							</td>
    						</tr>
    					</tfoot>
  					</table>
  					
  				</div>
  			</div>
  		</div>
  	
  							
  							

	</scannell:form>

</body>
</html>
