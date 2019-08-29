<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="maintenance.equipmentView.title" />
		</h2>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<col />

					<tbody>
						<tr>
							<td><fmt:message key="id" />:</td>
							<td><c:out value="${subject.id}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.category" />:</td>
							<td><c:out value="${subject.category.name}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.assetId" />:</td>
							<td><c:out value="${subject.assetId}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="description" />:</td>
							<td><scannell:text value="${subject.description}" /></td>
						</tr>
						<tr>
							<td><fmt:message key="additionalInfo" />:</td>
							<td><scannell:text value="${subject.additional_info}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.serialNo" />:</td>
							<td><c:out value="${subject.serialNo}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.dateOfManufacture" />:</td>
							<td><fmt:formatDate value="${subject.dateOfManufacture}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.countryOfManufacture" />:</td>
							<td><c:out value="${subject.countryOfManufacture}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.standardMark" />:</td>
							<td><c:out value="${subject.standardMark}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.location" />:</td>
							<td><c:out value="${subject.location}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentView.responsibleType" />:</td>
							<td><fmt:message key="${subject.trainee.traineeType}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.responsible" />:</td>
							<td><c:out value="${subject.trainee.description}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentEdit.companyContact" />:</td>
							<td><c:out value="${subject.responsible.displayName}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.datePutInService" />:</td>
							<td><fmt:formatDate value="${subject.datePutInService}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.dateRemovedFromService" />:</td>
							<td><fmt:formatDate value="${subject.dateRemovedFromService}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentView.initialMaintenanceDate" />:</td>
							<td><fmt:formatDate value="${subject.initialMaintenanceDate}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="active" />:</td>
							<td><fmt:message key="${subject.active}" /></td>
						</tr>

						<tr>
							<td ><fmt:message key="uploadedDocuments" />:</td>
							<td colspan="3">
								<ul>
									<c:forEach items="${subject.attachments}" var="item">
										<c:if test="${item.active}">
											<c:choose>
												<c:when test="${item.type.name == 'attach'}">
													<li><a target="attachment" href="<c:url value="viewEquipmentAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
													<c:out value="${item.name}" /></a><c:if test="${not empty item.description}"> - </c:if><c:out value="${item.description}" /> (<c:out value="${item.createdByUser.sortableName}" />) </li>
												</c:when>
												<c:otherwise>
													<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
													<c:out value="${item.name}" /></a><c:if test="${not empty item.description}"> - </c:if><c:out value="${item.description}" /></li>
												</c:otherwise>
											</c:choose> 
										</c:if>
									</c:forEach>
								</ul>
							</td>
						</tr>
						<tr>
							<td><fmt:message key="equipment.replacementFrequency" />:</td>
							<td><c:out value="${subject.intervalTypeDisplay}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentView.dueDate" />:</td>
							<td><fmt:formatDate value="${subject.dueDate}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentView.notificationRequested" />:</td>
							<td><fmt:message key="${subject.notificationRequested}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.alertLeadDays" />:</td>
							<td><c:out value="${subject.alertLeadDays}" /></td>
						</tr>

						<tr>
							<td><fmt:message key="equipment.lastDate" />:</td>
							<td><fmt:formatDate value="${subject.lastServiceDate}" pattern="dd-MMM-yyyy" /></td>
						</tr>

						<tr>
							<td><fmt:message key="maintenance.equipmentView.documents" />:</td>
							<td colspan="3">
								<jsp:include page="../doclink/showLinkedDocs.jsp" />
							</td>
						</tr>

						<tr>
							<td><fmt:message key="createdBy" />:</td>
							<td><c:out value="${subject.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
									value="${subject.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>

						<c:if test="${subject.lastUpdatedByUser != null}">
							<tr>
								<td><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${subject.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${subject.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>
					</tbody>

					<tfoot>
						<tr>
							<td colspan="2">
								<common:bindURL editable="${urls !=  null}" name="maintenance.equipmentServiceAdd.title" site="${subject.site.name}">
									<scannell:url urls="${urls}" />
								</common:bindURL>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div class="header">
		<h3>
			<fmt:message key="maintenance.equipmentView.history" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<th><fmt:message key="equipment.actualDate" /></th>
							<th><fmt:message key="equipment.carriedOutBy" /></th>
							<th><fmt:message key="comment" /></th>
							<th><fmt:message key="createdBy" /></th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${subject.history}" var="record" varStatus="s">
							<tr>
								<td><fmt:formatDate value="${record.actualDate}" pattern="dd-MMM-yyyy" /></td>
								<td><c:out value="${record.carriedOutBy}" /></td>
								<td><scannell:text value="${record.comment}" /></td>
								<td><c:out value="${record.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${record.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
