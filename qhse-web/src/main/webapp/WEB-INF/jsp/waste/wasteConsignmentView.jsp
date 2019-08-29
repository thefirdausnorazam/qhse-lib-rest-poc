<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="wasteConsignmentView" />
		</h2>
	</div>
	<div class="content">
		<a name="consignment"></a>
		<div class="header">
			<h3>
				<fmt:message key="wasteConsignment" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col>
						<%-- <thead>
	<tr>
		<td colspan="2">
			<div class="navLinks">
				<a href="#wasteDocuments"><fmt:message key="wasteDocuments" /></a> |
				<a href="#items"><fmt:message key="items" /></a> |
				<a href="#attachments"><fmt:message key="attachments" /></a>
			</div>
			
		</td>
	</tr>
</thead> --%>
						<tbody>
							<tr>
								<td><fmt:message key="id" />:</td>
								<td><c:out value="${wasteConsignment.id}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="carrier" />:</td>
								<td><c:out value="${wasteConsignment.carrier.name}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="broker" />:</td>
								<td><c:out value="${wasteConsignment.broker.name}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="consignee" />:</td>
								<td><c:out value="${wasteConsignment.consignee.name}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="shipmentDocumentType" />:</td>
								<td><spring:message code="${wasteConsignment.shipmentDocumentType}" text="" /></td>
							</tr>
							<tr>
								<td><fmt:message key="shipmentNo" />:</td>
								<td><c:out value="${wasteConsignment.shipmentNo}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="vehicleNo" />:</td>
								<td><c:out value="${wasteConsignment.vehicleNo}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="shippedDate" />:</td>
								<td><fmt:formatDate value="${wasteConsignment.shippedDate}" pattern="dd-MMM-yyyy" /></td>
							</tr>
							<tr>
								<td><fmt:message key="comment" />:</td>
								<td><scannell:text value="${wasteConsignment.comment}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="shippingCompleted" />:</td>
								<td><fmt:message key="${wasteConsignment.shippingCompleted}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="totalWeight" />:</td>
								<td><c:out value="${wasteConsignment.totalWeight}" /></td>
							</tr>

							<c:if test="${wasteConsignment.shippingCompleted}">
								<tr>
									<td><fmt:message key="reconcilliationCompleted" />:</td>
									<td><fmt:message key="${wasteConsignment.reconcilliationCompleted}" /></td>
								</tr>
								<tr>
									<td><fmt:message key="reconciledBy" />:</td>
									<c:if test="${wasteConsignment.reconcilliationCompleted}">
										<td><c:out value="${wasteConsignment.reconciledBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
												value="${wasteConsignment.reconciledTime}" pattern="dd-MMM-yyyy" /></td>
									</c:if>
								</tr>
								<tr>
									<td><fmt:message key="reconcilliationSuccessful" />:</td>
									<td><spring:message code="${wasteConsignment.reconcilliationSuccessful}" text=" " /></td>
								</tr>
								<tr>
									<td><fmt:message key="reconcilliationComment" />:</td>
									<td><scannell:text value="${wasteConsignment.reconcilliationComment}" /></td>
								</tr>
								<tr>
									<td><fmt:message key="reconcillationOutcome" />:</td>
									<td><scannell:entityUrl entity="${wasteConsignment.reconcillationOutcome}" /></td>
								</tr>
							</c:if>

							<tr>
								<td><fmt:message key="active" />:</td>
								<td><fmt:message key="${wasteConsignment.active}" /></td>
							</tr>

							<tr>
								<td><fmt:message key="createdBy" />:</td>
								<td><c:out value="${wasteConsignment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${wasteConsignment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
							<c:if test="${wasteConsignment.lastUpdatedByUser != null}">
								<tr>
									<td><fmt:message key="lastUpdatedBy" />:</td>
									<td><c:out value="${wasteConsignment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${wasteConsignment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:if>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<common:bindURL editable="${urls != null}" name="wasteConsignment" site="${wasteConsignment.site.name}">
										<scannell:url urls="${urls}" />
									</common:bindURL>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>

		<a name="wasteDocuments"></a>
		<div class="header">
			<h3>
				<fmt:message key="wasteDocuments" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<%-- <tr>
		<td colspan="10">
			<div class="navLinks">
				<a href="#consignment"><fmt:message key="wasteConsignment" /></a> |
				<a href="#items"><fmt:message key="items" /></a> |
				<a href="#attachments"><fmt:message key="attachments" /></a>
			</div>
			
		</td>
	</tr> --%>
							<tr>
								<th><fmt:message key="description" /></th>
								<th><fmt:message key="receivedDate" /></th>
								<th><fmt:message key="actionDate" /></th>
								<th><fmt:message key="weight" /></th>
								<th><fmt:message key="comment" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${wasteConsignment.documents}" var="item" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><a href="<c:url value="documentView.htm"><c:param name="id" value="${item.id}" /></c:url>">
											<c:out value="${item.description}" />
										</a></td>
									<td><fmt:formatDate value="${item.receivedDate}" pattern="dd-MMM-yyyy" /></td>
									<td><fmt:formatDate value="${item.actionDate}" pattern="dd-MMM-yyyy" /></td>
									<td><c:out value="${item.weight}" /></td>
									<td><scannell:text value="${item.comment}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<a name="items"></a>
		<div class="header">
			<h3>
				<fmt:message key="wasteConsignmentItems" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<%-- <tr>
		<td colspan="5">
			<div class="navLinks">
				<a href="#consignment"><fmt:message key="wasteConsignment" /></a> |
				<a href="#wasteDocuments"><fmt:message key="wasteDocuments" /></a> |
				<a href="#attachments"><fmt:message key="attachments" /></a>
			</div>
			
		</td>
	</tr> --%>
							<tr>
								<th><fmt:message key="type" /></th>
								<th><fmt:message key="waste.wasteConsignmentView.estimatedWeight" /></th>
								<th><fmt:message key="waste.wasteConsignmentView.containers" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${wasteConsignment.items}" var="item" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><a href="<c:url value="wasteConsignmentItemView.htm"><c:param name="id" value="${item.id}" /></c:url>">
											<c:out value="${item.type.description}" />
										</a></td>
									<td><c:out value="${item.estimatedWeightDescription}" /></td>
									<td><c:out value="${item.numberOfUnits}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<a name="attachments"></a>
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
							<%-- <tr>
		<td colspan="3">
			<div class="navLinks">
				<a href="#consignment"><fmt:message key="wasteConsignment" /></a> |
				<a href="#wasteDocuments"><fmt:message key="wasteDocuments" /></a> |
				<a href="#items"><fmt:message key="items" /></a>
			</div>
			
		</td>
	</tr> --%>
							<tr>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="description" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${allAttachments}" var="item" varStatus="s">
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
														href="<c:url value="wasteAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>">
														<c:out value="${item.name}" />
													</a>
												</c:when>
												<c:otherwise>
													<a target="attachment" href="<c:out value="${item.externalUrl}" />">
														<c:out value="${item.name}" />
													</a>
												</c:otherwise>
											</c:choose> <br /> <fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message
												key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
										<td><scannell:text value="${item.description}" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<common:bindURL editable="${urls != null}" name="wasteConsignment" site="${wasteConsignment.site.name}">
										<c:if test="${wasteConsignment.active}">
											<a
												href="<c:url value="wasteDocumentAttachmentCreate.htm"><c:param name="showId" value="${wasteConsignment.primaryShipmentDocument.id}" /></c:url>">
												<fmt:message key="addAttachment" />
											</a> |
										</c:if> 
										<c:if test="${wasteConsignment != null && wasteConsignment.active && !empty wasteConsignment.attachments}">
											<a
												href="<c:url value="editWasteDocumentAttachments.htm"><c:param name="showId" value="${wasteConsignment.primaryShipmentDocument.id}" /></c:url>">
												<fmt:message key="editAttachments" />
											</a>
										</c:if>
									</common:bindURL>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>

	</div>
</body>
</html>
