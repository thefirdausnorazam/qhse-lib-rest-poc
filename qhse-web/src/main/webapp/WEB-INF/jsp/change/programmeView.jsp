<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>	
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<div class="header">
<h2><span class="nowrap"><fmt:message key="changeProgramme.title" /><!--<fmt:message key="programmeView" />--></span></h2>
</div>
<div class="content">

<c:set var="foundChangeAssessments" value="${!empty programme.changes}" />
<c:set var="foundNotes" value="${!empty programme.notes}" />



<a name="programme"></a>
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">

<col class="label" />
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${programme.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
		<td colspan="3">
	      <ul>
		      <c:forEach var="ba" items="${programme.businessAreas}">
		        	<li><c:out value="${ba.name}" /></li>
		      </c:forEach>
	      </ul>
		</td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="changePlan" />:</td>
		<td><c:out value="${programme.plan.year}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="type" />:</td>
		<td><c:out value="${programme.type.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="owner" />:</td>
		<td><c:out value="${programme.owner.displayName}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
		<td><c:out value="${programme.percentCompleted}%" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
		<td><fmt:message key="${programme.status}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${programme.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="reviewDate" />:</td>
		<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.initiator" />:</td>
		<td><c:forEach items="${initiators}" var="initiator" varStatus="s">
			<c:out value="${initiator.displayName}" /><c:if test="${!s.last}">, </c:if>
		</c:forEach></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${programme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${programme.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${programme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${programme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="2">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="programmeView" /> <fmt:message key="notCurrentSelectedSiteMsg" >
								<fmt:param value="${programme.site.name}" />
							 </fmt:message>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</tfoot>
</table>

				</div>
				</div>
				
<div class="header">
<h3><span class="nowrap"><fmt:message key="changeAssessments" /></span></h3>
</div>				
<a name="changes"></a>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered dataTable">
<thead>
	<tr>		
		<th><fmt:message key="name" /></th>		
		<th><fmt:message key="changeAssessment.initiator" /></th>
		<th><fmt:message key="changeAssessment.owner" /></th>
		<th><fmt:message key="changeAssessment.status" /></th>		
		<th><fmt:message key="percentCompleted" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${programme.changes}" var="change" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">		
		<c:choose>
			<c:when test="${change != null && change.status != 'ChangeStatus[TRASH]'}">
				<td><a href="<c:url value="changeAssessmentView.htm"><c:param name="id" value="${change.id}" /></c:url>"><c:out value="${change.name}" /></a></td>							
				<td><c:out value="${change.initiator.displayName}" /></td>
				<td><c:out value="${change.owner.displayName}" /></td>
				<td><fmt:message key="changeAssessment${change.status}" /></td>										
				<td><c:out value="${change.percentCompleted}%" /></td>
			</c:when>
		</c:choose>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</div>


<c:if test="${foundNotes}">
<div class="header">
<h3><fmt:message key="notes" /></h3>
</div>

<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<thead>
	<tr>
		<th><fmt:message key="title" /></th>
		<th><fmt:message key="text" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>
<tbody>
<c:forEach items="${programme.notes}" var="note" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><c:out value="${note.name}" /></td>
		<td><scannell:text value="${note.text}" /></td>
		<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</c:if>




<c:if test="${not empty sortedAssociatedAssessments}">
<a name="associatedAssessments"></a>
<c:set var="first" value="${false}" />
<c:set var="last" value="${null}" />
<c:forEach items="${sortedAssociatedAssessments}" var="assessment" varStatus="s">
			<c:if test="${assessment.template != last.template}">
				<c:choose>
					<c:when test="${first == false}">
						<c:set var="first" value="${true}" />
					</c:when>
					<c:otherwise>
						</tbody>
						</table>
						</div></div>
					</c:otherwise>
				</c:choose>

				<table class="viewForm bordered">
					<thead>
						<tr>
							<td colspan="99">
								<div class="navLinks">
									<a href="#assessment"><fmt:message key="assessment" /></a> | <a
										href="#tasks"><fmt:message key="assessment.tasks" /></a>
								</div> <fmt:message key="assessment.associatedAssessments" /> - <c:out
									value="${assessment.template.name}" />
							</td>
						</tr>
						<tr>
							<th><fmt:message key="id" /> / <fmt:message
									key="assessment.name" /></th>
							<c:forEach items="${assessment.template.summaryQuestions}"
								var="sq">
								<c:forEach items="${assessment.template.detailsQuestionGroups}"
									var="g">
									<c:if test="${g.active}">
										<c:forEach items="${g.questions}" var="q">
											<c:if test="${sq.id == q.id and q.active and q.visible}">
												<th><c:out value="${sq.name}" /></th>
											</c:if>
											<c:if test="${!empty q.columns}">
												<c:forEach items="${q.columns}" var="childQ">
													<c:if
														test="${sq.id == childQ.id and childQ.active and childQ.visible}">
														<th><c:out value="${sq.name}" /></th>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>

							</c:forEach>
							<th><fmt:message key="assessment.status" /></th>
							<th><fmt:message key="assessment.responsibleUser" /></th>
							<c:if test="${assessment.template.scorable}">
								<th><fmt:message key="assessment.score" /></th>
							</c:if>
						</tr>
					</thead>
					<tbody id="questionsTbody">
						</c:if>

						<c:choose>
							<c:when test="${s.index mod 2 == 0}">
								<c:set var="style" value="even" />
							</c:when>
							<c:otherwise>
								<c:set var="style" value="odd" />
							</c:otherwise>
						</c:choose>
						<tr class="<c:out value="${style}" />">
							<td><a
								href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>"><c:out
										value="${assessment.displayId}" /></a><br> <c:choose>
									<c:when test="${assessment.confidential}">
										<fmt:message key="assessment.confidential" />
									</c:when>
									<c:otherwise>
										<scannell:text value="${assessment.name}" />
									</c:otherwise>
								</c:choose></td>

							<c:forEach items="${assessment.template.summaryQuestions}"
								var="sq">
								<c:forEach items="${assessment.template.detailsQuestionGroups}"
									var="g">
									<c:if test="${g.active}">
										<c:forEach items="${g.questions}" var="q">
											<c:if test="${sq.id == q.id and q.active and q.visible}">
												<td><enviromanager:answer question="${q}"
														answers="${assessment.answers}" /></td>
											</c:if>
											<c:if test="${!empty q.columns}">
												<c:forEach items="${q.columns}" var="childQ">
													<c:if
														test="${sq.id == childQ.id and childQ.active and childQ.visible}">
														<td><enviromanager:answer question="${childQ}"
																answers="${assessment.answers}" /></td>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:forEach>

							<td><fmt:message key="assessment${assessment.status}" /></td>
							<td><c:out value="${assessment.responsibleUser.displayName}" /></td>
							<c:if test="${assessment.template.scorable}">
								<td><c:set var="threshold" value="${assessment.threshold}" />
									<c:choose>
										<c:when test="${assessment.score ge threshold.upperLimit}">
											<img src="<c:url value="/images/risk/score_redlight.giff" />" />
										</c:when>
										<c:when
											test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
											<img
												src="<c:url value="/images/risk/score_amberlight.giff" />" />
										</c:when>
										<c:otherwise>
											<img
												src="<c:url value="/images/risk/score_greenlight.giff" />" />
										</c:otherwise>
									</c:choose> <c:out value="${assessment.score}" /></td>
							</c:if>
						</tr>

						<c:set var="last" value="${assessment}" />
						<c:if test="${s.last}">
					</tbody>
				</table>
			</c:if>
		</c:forEach>
</c:if>



</div>

</body>
</html>
