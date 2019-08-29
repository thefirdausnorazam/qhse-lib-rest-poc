<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="hazard" required="true" type="com.scannellsolutions.modules.risk.domain.RiskAssessmentJobHazard" %>
<%@ attribute name="editable" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ tag import="com.scannellsolutions.modules.risk.domain.RiskAssessmentJobHazard" %>
<%@ tag import="com.scannellsolutions.modules.risk.domain.RiskStatus" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="riskStatus" value="<%=RiskStatus.COMPLETE%>" />
<c:if test="${editable}">
	<a href="<c:url value="/risk/assessmentJobHazardEdit.htm"><c:param name="showId" value="${hazard.id}"/><c:param name="parentRiskId" value="${hazard.job.assessment.id}"/></c:url>"><fmt:message key="edit" /></a><br>
 	<c:if test="${hazard.job.assessment.status eq riskStatus}">
		<a href="<c:url value="/risk/assessmentJobHazardTaskAdd.htm"><c:param name="showId" value="${hazard.id}"/><c:param name="parentRiskId" value="${hazard.job.assessment.id}"/></c:url>"><fmt:message key="hazard.addtask" /></a><br>
 	</c:if> 
	<a href="<c:url value="/risk/addRiskJobAttachment.htm"><c:param name="showId" value="${hazard.job.id}"/><c:param name="hazardId" value="${hazard.id}"/><c:param name="parentRiskId" value="${hazard.job.assessment.id}"/></c:url>"><fmt:message key="hazard.addattachment"/></a><br>
	<c:if test="${fn:length(hazard.job.attachments) > 0}">	
		<c:set var="found" value="false"/>
		<c:forEach items="${hazard.job.attachments}" var="attach">
			<c:if test="${!found and fn:endsWith(attach.name, hazard.name)}">
				<a href="<c:url value="/risk/editRiskJobAttachments.htm"><c:param name="showId" value="${hazard.job.id}"/><c:param name="hazardId" value="${hazard.id}"/><c:param name="parentRiskId" value="${hazard.job.assessment.id}"/></c:url>"><fmt:message key="hazard.editattachment"/></a><br>
				<c:set var="found" value="true"/>			
			</c:if>
		</c:forEach>
	</c:if>
    <a href="<c:url value="/risk/jobAddImageForm.htm"><c:param name="showId" value="${hazard.id}"/><c:param name="jobId" value="${hazard.job.id}"/><c:param name="parentRiskId" value="${hazard.job.assessment.id}"/></c:url>"><fmt:message key="job.addImage"/></a><br>
</c:if>
<c:if test="${hazard.selectedHazardOptionId != 0}">
	<a href="<c:url value="javascript:viewLegislation(${hazard.selectedHazardOptionId})"></c:url>"><fmt:message key="hazard.viewLegislation" /></a><br>
</c:if>

