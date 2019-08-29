<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
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
	<div class="header nowrap">
		<h2>
			<fmt:message key="auditExpress.title" />
		</h2>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<td colspan="4">
								<div class="navLinks">
									<a href="#questions">
										<fmt:message key="questions.title" />
									</a>
									<c:if test="${foundNotes}">| <a href="#notes">
											<fmt:message key="notes" />
										</a>
									</c:if>
									<c:if test="${audit.hasCurrentActions}">| <a href="#action">
											<fmt:message key="actions" />
										</a>
									</c:if>
									<c:if test="${foundAttachments}">| <a href="#attachments">
											<fmt:message key="attachments" />
										</a>
									</c:if>
								</div> <!--<fmt:message key="auditExpress.title" /> -->
							</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
							<td colspan="6"><c:out value="${audit.id}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="audit" /> <fmt:message key="name" />:</td>
							<td colspan="6"><scannell:text value="${audit.name}" /></td>
						</tr>
						<c:if test="${audit.programme.type.saveAndReview}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditee" /></td>
								<td colspan="6"><scannell:text value="${audit.auditee.name}" /></td>
							</tr>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="audit.personObserved" />:</td>
								<td colspan="6"><c:forEach items="${audit.observers}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
						</c:if>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="auditProgramme" />:</td>
							<td colspan="6"><c:out value="${audit.programme.description}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
							<td colspan="2"><c:out value="${audit.leadAuditor.displayName}" /></td>

							<td class="scannellGeneralLabel"><fmt:message key="otherParticipants" />:</td>
							<td colspan="4"><c:out value="${audit.otherParticipants}" /></td>
						</tr>

						<tr>
							<fmt:message key="incident.enableAdditionalFields" var="enable" />
							<c:if test="${enable}">
								<c:if test="${audit.location != null}">
									<td class="scannellGeneralLabel label"><fmt:message key="location" /></td>
									<td><c:out value="${audit.location.name}" /></td>
								</c:if>
							</c:if>
							<c:if test="${!enable}">
								<td class="scannellGeneralLabel"><fmt:message key="location" />:</td>
								<c:if test="${audit.deptLocation != null}">
									<td colspan="2"><c:out value="${audit.deptLocation}" /></td>
								</c:if>
							</c:if>

							<td class="scannellGeneralLabel"><fmt:message key="startTime" />:</td>
							<td colspan="4"><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
						</tr>

						<c:if test="${audit.review.text != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="review" />:</td>
								<td colspan="6"><scannell:text value="${audit.review.text}" /></td>
							</tr>
						</c:if>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
							<td colspan="6"><scannell:text value="${audit.additionalInfo}" /></td>
						</tr>


						<tr>
							<td class="scannellGeneralLabel nowrap"><fmt:message key="associatedDocuments" />:</td>
							<td colspan="6">
								<c:set var="showLatest" value="${audit.status != 'COMPLETE'}" scope="request"/>
								<jsp:include page="../doclink/showLinkedDocs.jsp" />
							</td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
							<td colspan="6"><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
									value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>
						<c:if test="${audit.lastUpdatedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td colspan="6"><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>


					</tbody>

					<tfoot>
						<tr>
							<td colspan="6"><c:choose>
									<c:when test="${urls != null}">
										<scannell:url urls="${urls}" />
									</c:when>
									<c:otherwise>
										<fmt:message key="audit.title" />
										<fmt:message key="notCurrentSelectedSiteMsg">
											<fmt:param value="${audit.site.name}" />
										</fmt:message>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>


	<a name="questions"> </a>
	<br />
	<br />
	<div class="header">
		<h2>
			<fmt:message key="questions.title" />
		</h2>
	</div>

	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<td colspan="6">
								<div class="navLinks">
									<a href="#audit">
										<fmt:message key="auditExpress.title" />
									</a>
									<c:if test="${foundNotes}">| <a href="#notes">
											<fmt:message key="notes" />
										</a>
									</c:if>
									<c:if test="${audit.hasCurrentActions}">| <a href="#action">
											<fmt:message key="actions" />
										</a>
									</c:if>
									<c:if test="${foundAttachments}">| <a href="#attachments">
											<fmt:message key="attachments" />
										</a>
									</c:if>
								</div> <!--<fmt:message key="questions.title" /> -->
							</td>
						</tr>
					</thead>

					<tbody>
						<c:set var="group" value="${audit.programme.type.expressQuestionGroup}" />
						<c:if test="${group.active}">
							<c:if test="${group.name != null && group.name != ''}">
								<tr>
									<td colspan="4" class="scannellGeneralLabel nowrap"><c:out value="${group.name}" /></td>
								</tr>
							</c:if>
							<c:forEach items="${group.questions}" var="q">
								<c:if test="${q.active and q.visible}">
									<tr>
										<c:choose>
											<c:when test="${q.answerType.name == 'label'}">
												<td colspan="4" class="riskLabel">
												<div style="height: 200px; width: 100%;">
												<c:out value="${q.name}" />
												</div>
												</td>
											</c:when>
											<c:otherwise>
												<td class="scannellGeneralLabel">
												<div style="height: 200px; width: 100%;">
												<c:out value="${q.name}" /></div>
												</td>
												
												<td id="answers[<c:out value="${q.id}"/>]" colspan="3" style="height: 200px; width: 50%;">
												
												<enviromanager:answer question="${q}" answers="${audit.answers}" />
												
												</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4"><scannell:url urls="${urls1}" /></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	<c:if test="${foundNotes}">
		<a name="notes"> </a>
		<br />
		<br />
		<div class="header">
			<h3>
				<fmt:message key="notes" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<tr>
								<td colspan="4">
									<div class="navLinks">
										<a href="#audit">
											<fmt:message key="auditExpress.title" />
										</a>
										|
										<a href="#questions">
											<fmt:message key="questions.title" />
										</a>
										<c:if test="${audit.hasCurrentActions}">| <a href="#action">
												<fmt:message key="actions" />
											</a>
										</c:if>
										<c:if test="${foundAttachments}">| <a href="#attachments">
												<fmt:message key="attachments" />
											</a>
										</c:if>
									</div> <!-- <fmt:message key="notes" /> -->
								</td>
							</tr>
							<tr>
								<th><fmt:message key="title" /></th>
								<th><fmt:message key="text" /></th>
								<th><fmt:message key="createdBy" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${audit.notes}" var="note" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><c:out value="${note.name}" /></td>
									<td><scannell:text value="${note.text}" /></td>
									<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</c:if>

	<a name="action"> </a>
	<br />
	<br />
	<div class="header">
		<h3>
			<fmt:message key="actions" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive dataTable">
					<c:choose>
						<c:when test="${!audit.hasCurrentActions}">
							<thead>
								<tr>
									<td colspan="2">No Action Associated with this Audit</td>
								</tr>
							</thead>
						</c:when>

						<c:otherwise>
							<thead>
								<tr>
									<td colspan="7">
										<div class="navLinks">
											<a href="#audit">
												<fmt:message key="auditExpress.title" />
											</a>
											|
											<a href="#questions">
												<fmt:message key="questions.title" />
											</a>
											<c:if test="${foundNotes}">| <a href="#notes">
													<fmt:message key="notes" />
												</a>
											</c:if>
											<c:if test="${foundAttachments}">| <a href="#attachments">
													<fmt:message key="attachments" />
												</a>
											</c:if>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="7">Action Summary</td>
								</tr>
								<tr>
									<th><fmt:message key="id" /></th>
									<th><fmt:message key="type" /></th>
									<th><fmt:message key="description" /></th>
									<th><fmt:message key="completionTargetDate" /></th>
									<th><fmt:message key="responsibleUser" /></th>
									<th><fmt:message key="status" /></th>
									<th></th>
								</tr>
							</thead>

							<c:forEach items="${audit.currentActions}" var="item">
								<c:choose>
									<c:when test="${item != null}">
										<tr class="<c:out value="${style}" />">
											<td><c:out value="${item.id}" /></td>
											<td><fmt:message key="ActionType[${item.type}]" /></td>
											<td><div>
													<c:out value="${item.description}" />
												</div></td>
											<td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
											<td><c:out value="${item.responsibleUser.displayName}" /></td>
											<td><fmt:message key="${item.statusCode}" /></td>
											<td><a href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>">
													<fmt:message key="view" />
												</a></td>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
	</div>

	<c:if test="${foundAttachments}">
		<a name="attachments"> </a>
		<br />
		<br />
		<div class="header">
			<h3>
				<fmt:message key="attachments" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<tr>
								<td colspan="3">
									<div class="navLinks">
										<a href="#audit">
											<fmt:message key="auditExpress.title" />
										</a>
										|
										<a href="#questions">
											<fmt:message key="questions.title" />
										</a>
										<c:if test="${foundNotes}">| <a href="#notes">
												<fmt:message key="notes" />
											</a>
										</c:if>
										<c:if test="${audit.hasCurrentActions}">| <a href="#action">
												<fmt:message key="actions" />
											</a>
										</c:if>
									</div>

								</td>
							</tr>
							<tr>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="description" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${audit.attachments}" var="item" varStatus="s">
								<c:if test="${item.active}">
									<c:choose>
										<c:when test="${s.index mod 2 == 0}">
											<c:set var="style" value="even" />
										</c:when>
										<c:otherwise>
											<c:set var="style" value="odd" />
										</c:otherwise>
									</c:choose>
									<tr class="<c:out value="${style}" />">
										<td><c:choose>
												<c:when test="${item.type.name == 'attach'}">
													<a target="attachment"
														href="<c:url value="auditAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>">
														<c:out value="${item.name}" />
													</a>
												</c:when>
												<c:otherwise>
													<a target="attachment" href="<c:out value="${item.externalUrl}" />">
														<c:out value="${item.name}" />
													</a>
												</c:otherwise>
											</c:choose> <br /> <fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message
												key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" /></td>
										<td><scannell:text value="${item.description}" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2"><c:if test="${audit.editable}">
										<a href="<c:url value="auditAttachmentEdit.htm"><c:param name="showId" value="${audit.id}" /></c:url>">
											<fmt:message key="addAttachment" />
										</a>
									</c:if> <c:if test="${audit != null && audit.editable && !empty audit.attachments}">
										<a href="<c:url value="auditAttachmentList.htm"><c:param name="id" value="${audit.id}" /></c:url>">
											<fmt:message key="editAttachments" />
										</a>
									</c:if></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</c:if>

</body>
</html>
