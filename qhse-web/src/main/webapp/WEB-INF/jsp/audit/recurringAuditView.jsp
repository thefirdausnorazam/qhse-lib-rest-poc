<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="recurringAuditView" />
		</h2>
	</div>
	<div class="content">
		<div class="header nowrap">
			<h3>
				<fmt:message key="recurringAudit.title" />
				-
				<c:out value="${recurringAudit.name}" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">


					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
							<td><c:out value="${recurringAudit.id}" /></td>
						</tr>
						<c:if test="${showLegacyId}">
							<tr>
								<td class="scannellGeneralLabel">Legacy <fmt:message key="id" />:</td>
								<td><c:out value="${recurringAudit.legacyId}" /></td>
							</tr>
						</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
								<td colspan="3">
								     <ul>
								      <c:forEach var="ba" items="${recurringAudit.businessAreas}">
								        	<li><c:out value="${ba.name}" /></li>
								      </c:forEach>
								      </ul>
								</td>
							</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="audit" /> <fmt:message key="name" />:</td>
							<td><c:out value="${recurringAudit.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel nowrap"><fmt:message key="auditProgrammeType" />:</td>
							<td><c:out value="${recurringAudit.programmeType.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
							<td><c:out value="${recurringAudit.leadAuditor.displayName}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="auditee" />:</td>
							<td><c:out value="${recurringAudit.auditee.name}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="audit.personObserved" />:</td>
							<td><c:forEach items="${recurringAudit.observers}" var="auditor" varStatus="s">
									<c:if test="${!s.first}">, </c:if>
									<c:out value="${auditor.displayName}" />
								</c:forEach></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="secondaryAuditors" />:</td>
							<td><c:forEach items="${recurringAudit.secondaryAuditors}" var="auditor" varStatus="s">
									<c:if test="${!s.first}">, </c:if>
									<c:out value="${auditor.displayName}" />
								</c:forEach></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="otherParticipants" />:</td>
							<td><scannell:text value="${recurringAudit.otherParticipants}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
							<td><scannell:text value="${recurringAudit.additionalInfo}" /></td>
						</tr>

						<c:if test="${recurringAuditType == 'RecurringScheduledAudit'}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="template" />:</td>
								<td><c:out value="${recurringAudit.template.name}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="location" />:</td>
								<c:if test="${recurringAudit.deptLocation != null}">
									<td><c:out value="${recurringAudit.deptLocation}" /></td>
								</c:if>
							</tr>
						</c:if>
						<tr>

							<td class="scannellGeneralLabel"><fmt:message key="duration" />:</td>
							<td><c:out value="${recurringAudit.duration.description}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="frequency" />:</td>
							<td><fmt:message key="RecurringAuditFrequency.${recurringAudit.frequency}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="initialDate" />:</td>
							<td><fmt:formatDate value="${recurringAudit.startTimestamp}" pattern="dd-MMM-yyyy HH:mm" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="notificationLeadDays" />:</td>
							<td><c:out value="${recurringAudit.leadDays}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
							<td><fmt:message key="${recurringAudit.active}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
							<td><c:out value="${recurringAudit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
									value="${recurringAudit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>

						<c:if test="${recurringAudit.lastUpdatedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${recurringAudit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${recurringAudit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="2"><c:choose>
									<c:when test="${urls != null}">
										<scannell:url urls="${urls}" />
									</c:when>
									<c:otherwise>
										<fmt:message key="recurringAudit.title" />
										<fmt:message key="notCurrentSelectedSiteMsg">
											<fmt:param value="${recurringAudit.site.name}" />
										</fmt:message>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	<c:if test="${!empty recurringAudit.programmeType.programmes}">
<a name="programmes"></a>
<div class="header">
<h2><fmt:message key="auditProgrammes" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive dataTable">
<thead>
	
	<tr>
		<th><fmt:message key="id" /></th>
		<th><fmt:message key="auditPlan" /></th>
		<th><fmt:message key="type" /></th>
		<th><fmt:message key="owner" /></th>
		<th><fmt:message key="reviewDate" /></th>
		<th><fmt:message key="status" /></th>
		<th><fmt:message key="completed" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${recurringAudit.programmeType.programmesHighestToLowest}" var="programme" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>" ><c:out value="${programme.id}" /></a></td>
		<td><c:out value="${programme.plan.displayName}" /></td>
		<td><c:out value="${programme.type.name}" /></td>
		<td><c:out value="${programme.owner.displayName}" /></td>
		<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
		<td><fmt:message key="${programme.programmeStatus}" /></td>
		<td><fmt:message key="${programme.completed}" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</c:if>

	</div>
</body>
</html>
