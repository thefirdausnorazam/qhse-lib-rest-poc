<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
<body>

	<div class="content">
		<div class="header">
			<h3>
				<fmt:message key="readingPoint" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col />

						<tbody>
							<tr>
								<td><fmt:message key="id" />:</td>
								<td><c:out value="${readingPoint.id}" /></td>
							</tr>

							<tr>
								<td><fmt:message key="type" />:</td>
								<td><c:if test="${readingPoint.type != null}">
										<fmt:message key="${readingPoint.type}" />
									</c:if></td>
							</tr>

							<tr>
								<td><fmt:message key="name" />:</td>
								<td><scannell:text value="${readingPoint.name}" /></td>
							</tr>

							<tr>
								<td><fmt:message key="location" />:</td>
								<td><scannell:text value="${readingPoint.location}" /></td>
							</tr>

							<tr>
								<td><fmt:message key="active" />:</td>
								<td><fmt:message key="${readingPoint.active}" /></td>
							</tr>

							<c:if test="${readingPoint.individual}">
								<tr>
									<td><fmt:message key="survey.readingPoint.attribute1" />:</td>
									<td><scannell:text value="${readingPoint.attribute1}" /></td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute2" />:</td>
									<td><scannell:text value="${readingPoint.attribute2}" /></td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute3" />:</td>
									<td><scannell:text value="${readingPoint.attribute3}" /></td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute4" />:</td>
									<td><scannell:text value="${readingPoint.attribute4}" /></td>
								</tr>

								<tr id="attributex">
									<td colspan="2"><fmt:message key="survey.readingPoint.attributex" />:</td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute5" />:</td>
									<td><scannell:text value="${readingPoint.attribute5}" /></td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute6" />:</td>
									<td><scannell:text value="${readingPoint.attribute6}" /></td>
								</tr>

								<tr>
									<td><fmt:message key="survey.readingPoint.attribute7" />:</td>
									<td><scannell:text value="${readingPoint.attribute7}" /></td>
								</tr>
							</c:if>

							<tr>
								<td><fmt:message key="createdBy" />:</td>
								<td><c:out value="${readingPoint.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${readingPoint.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>

							<c:if test="${readingPoint.lastUpdatedByUser != null}">
								<tr>
									<td><fmt:message key="lastUpdatedBy" />:</td>
									<td><c:out value="${readingPoint.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${readingPoint.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:if>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">	
									<common:bindURL editable="${currentSiteRecord}" name="readingPoint" site="${readingPoint.site.name}">					
										<c:if test="${readingPoint.editable}">
											<button data-placement="top" data-toggle="tooltip" onclick="window.location.href='<c:url value="readingPointEdit.htm"><c:param name="showId" value="${readingPoint.id}" /></c:url>';"
												data-original-title="<fmt:message key="readingPointEdit" />" type="button" class="g-btn g-btn--primary">
												<i class="fa fa-chevron-circle-up"></i>
												<fmt:message key="readingPointEdit" />
											</button>
										</c:if> <c:if test="${readingPoint.lastUpdatedByUser != null}">
											<button data-placement="top" data-toggle="tooltip" onclick='javascript:openHistory(<c:out value="${readingPoint.id},'${readingPoint['class'].name}'" />);' data-original-title="<fmt:message key="viewHistory" />"
												type="button" class="g-btn g-btn--primary">
												<i class="fa fa-chevron-circle-up"></i>
												<fmt:message key="viewHistory" />
											</button>
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
