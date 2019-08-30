<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="checklist" required="true" type="com.scannellsolutions.modules.law.domain.Checklist" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<%@ tag import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@ tag import="com.scannellsolutions.modules.law.web.ProfileChecklistHelper"%>

        <c:if test="${empty checklist.relevance}"><fmt:message key="notSpecifiedInProfile"/></c:if>
        <scannell:text value="${checklist.relevance}" newlineEscape="true" />
        <div class="content">        
        <div class="header"><h3><fmt:message key="evaluationOfCompliance"/></h3></div><br/><c:if test="${empty checklist.compliance}"><fmt:message key="notSpecifiedInProfile"/></c:if>
        <scannell:text value="${checklist.compliance}" newlineEscape="true" />
        </div>
        <div id="divProfileChecklistId" ss-pcid="<c:out value="${checklist.profileChecklistId}" />"></div>
        
<c:if test="${profile.loc eq true}">
<div class="header" >
<h3><fmt:message key="levelOfCompliance"/></h3>												
</div>
	<div class="content">
	<c:if test="${checklist.levelOfCompliance ge 80}">
		<div class="progress">
			<div class="progress-bar progress-bar-success" role="progressbar"
				aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
				aria-valuemin="0" aria-valuemax="100"
				style="width:<c:out value="${checklist.levelOfCompliance}"/>%">
				<c:out value="${checklist.levelOfCompliance}" />
				%
			</div>
		</div>
	</c:if>
	<c:if
		test="${checklist.levelOfCompliance ge 50 and checklist.levelOfCompliance le 79}">
		<div class="progress">
			<div class="progress-bar progress-bar-warning" role="progressbar"
				aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
				aria-valuemin="0" aria-valuemax="100"
				style="width:<c:out value="${checklist.levelOfCompliance}"/>%">
				<c:out value="${checklist.levelOfCompliance}" />
				%
			</div>
		</div>
	</c:if>
	<c:if
		test="${checklist.levelOfCompliance ge 1 and checklist.levelOfCompliance le 49}">
		<div class="progress">
			<div class="progress-bar progress-bar-danger" role="progressbar"
				aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
				aria-valuemin="0" aria-valuemax="100"
				style="width:<c:out value="${checklist.levelOfCompliance}"/>%">
				<c:out value="${checklist.levelOfCompliance}" />
				%
			</div>
		</div>
	</c:if>
	<c:if test="${checklist.levelOfCompliance eq 0}">
		<div class="progress">
			<div class="progress-bar progress-bar-info" role="progressbar"
				aria-valuenow="<c:out value="${checklist.levelOfCompliance}"/>"
				aria-valuemin="0" aria-valuemax="100"
				style="width:<c:out value="${checklist.levelOfCompliance}"/>%">
				<c:out value="${checklist.levelOfCompliance}" />
				%
			</div>
		</div>
	</c:if>
	</div>
</c:if>


