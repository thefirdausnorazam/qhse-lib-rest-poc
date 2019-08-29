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
<h2><fmt:message key="wasteTreatmentDocumentView" /></h2>
</div>
<div class="content">
<%-- <div class="header">
<h3><fmt:message key="wasteTreatmentDocument" /></h3>
</div> --%>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col >
<thead>
  <tr><td colspan="2"></td></tr>
</thead>

<tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td><c:out value="${document.id}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="shipmentDocument" />:</td>
    <td><c:out value="${document.shipmentDocument.description}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="treatmentType" />:</td>
    <td><c:out value="${document.treatmentType.name}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="disposalLocation" />:</td>
    <td><c:out value="${document.disposalLocation}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="disposalDate" />:</td>
    <td><fmt:formatDate value="${document.actionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="weight" />:</td>
    <td><c:out value="${document.weight}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="comment" />:</td>
    <td><scannell:text value="${document.comment}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${document.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${document.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <c:if test="${document.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td>
      <c:out value="${document.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${document.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
</tbody>

<tfoot>
  <tr>
  	<td colspan="2">
  		<common:bindURL editable="${urls != null}" name="wasteTreatmentDocument" site="${document.consignment.site.name}">
  			<scannell:url urls="${urls}" />
  		</common:bindURL>
  	</td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>

<a name="attachments"></a>
<div class="header">
<h2><fmt:message key="attachments" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">

<table class="table table-bordered table-responsive">
<thead> 
  <tr>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="description" /></th>
  </tr>
</thead>

<tbody>
  <c:forEach items="${document.attachments}" var="item" varStatus="s">
  <c:choose>
    <c:when test="${s.index mod 2 == 0}">
      <c:set var="style" value="even" />
    </c:when>
    <c:otherwise>
      <c:set var="style" value="odd" />
    </c:otherwise>
  </c:choose>
  <tr class="<c:out value="${style}" />" ${item.active == false ? 'style="display:none"' : '' }>
    <td>
      <c:choose>
        <c:when test="${item.type.name == 'attach'}">
          <a target="attachment" href="<c:url value="wasteAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a>
        </c:when>
        <c:otherwise>
          <a target="attachment" href="<c:out value="${item.externalUrl}" />"><c:out value="${item.name}" /></a>
        </c:otherwise>
      </c:choose>
      <br />
      <fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
    <td><scannell:text value="${item.description}" /></td>
  </tr>
  </c:forEach>
</tbody>
<tfoot>
							<tr>
								<td colspan="2">
									<common:bindURL editable="${urls != null}" name="wasteTreatmentDocument" site="${document.consignment.site.name}">
										<a
											href="<c:url value="wasteDocumentAttachmentCreate.htm"><c:param name="showId" value="${document.id}" /></c:url>">
											<fmt:message key="addAttachment" />
										</a> |
			 							<c:if test="${document != null && !empty document.attachments}">
											<a
												href="<c:url value="editWasteDocumentAttachments.htm"><c:param name="showId" value="${document.id}" /></c:url>">
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
