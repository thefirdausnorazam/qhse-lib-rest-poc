<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="change" value="${command.entity}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<script type="text/javascript">
<!--
	function openPopup(url, w, h) {
		var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
		var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="
				+ w + ",height=" + h + ",top=" + x + ",left=" + y + "";
		var win = window.open(url, "links", att);
		win.focus();
	}

	function onPopupClose() {
		<c:url var="url" value="/change/expressView.htm">
		<c:param name="id" value="${param.id}" />
		</c:url>
		window.location.href = "<c:out value="${url}" />";
	}
// -->

jQuery(document).ready(function() {
	if('${change.status.name}' == 'TRASH'){
		jQuery('#saveButton').val('<fmt:message key="untrash" />');
	}
	});
</script>

</head>
<body>
<div class="header nowrap">
<h2 id="titlePage">
<c:if test="${change.status.name == 'TRASH'}"><fmt:message key="changeAssessmentUntrashForm.title" /></c:if>
<c:if test="${change.status.name != 'TRASH'}"><fmt:message key="changeAssessmentTrashForm.title" /></c:if>
</h2>
</div>
<scannell:form>
<div class="content">  
	<div class="table-responsive">
		<div class="panel panel-danger">
			<table class="table table-responsive table-bordered ">
			<tbody>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
					<td><c:out value="${change.id}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.status" />:</td>
					<td id="changeAssessmentStatus"><fmt:message
							key="changeAssessment${change.status}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeProgramme" />:</td>
					<td><c:out
							value="${change.programme.description}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.initiator" />:</td>
					<td><c:out value="${change.initiator.displayName}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.owner" />:</td>
					<td><c:out value="${change.owner.displayName}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.department" />:</td>
					<td><scannell:text
							value="${change.department.name}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.title" />:</td>
					<td><scannell:text value="${change.name}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="description" />:</td>
					<td><scannell:text value="${change.description}" /></td>
				</tr>

				<%-- 	<c:choose>
		<c:when test="${explicit}">	 --%>
				<td class="scannellGeneralLabel"><fmt:message
						key="changeAssessment.lockdownOwner" />:</td>
				<td><fmt:message
						key="changeAssessment.lockdownOwner[${change.lockdownOwner}]" /></td>
				<%-- </c:when>
		<c:otherwise>
			<tr>
				<td  class="scannellGeneralLabel"><fmt:message key="changeAssessment.itemAffected" />:</td>
				<td><scannell:text value="${change.itemAffected}" /></td>
			</tr>	
		
			
			<tr>
				<td  class="scannellGeneralLabel"><fmt:message key="changeAssessment.reason" />:</td>
				<td><scannell:text value="${change.reason}" /></td>
			</tr>	
		</c:otherwise>
	</c:choose> --%>
				<c:if test="${change.approvedByUser != null}">
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.type" />:</td>
						<td><fmt:message
								key="changeAssessment${change.type}" /></td>
					</tr>

					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.postImplementationReview" />:</td>
						<td><fmt:message
								key="${change.postImplementationReview}" /></td>
					</tr>

					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.returnToOriginalStatus" />:</td>
						<td><fmt:message
								key="${change.returnToOriginalStatus}" /></td>
					</tr>
				</c:if>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.reviewers" />:</td>
					<td><c:forEach items="${change.reviewers}" var="reviewer"
							varStatus="r">
							<c:if test="${!r.first}">, </c:if>
							<c:out value="${reviewer.displayName}" />
						</c:forEach></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.percentCompleted" />:</td>
					<td><scannell:text value="${change.percentCompleted}%" /></td>
				</tr>

				<tr>
					<%-- <c:choose>
			<c:when test="${explicit}">		 --%>
					<td class="scannellGeneralLabel"><fmt:message
							key="changeAssessment.targetApprovedDate" />:</td>
					<td><fmt:formatDate value="${change.targetApprovedDate}" pattern="dd-MMM-yyyy" /></td>
					<%-- </c:when>
			<c:otherwise>
				<td  class="scannellGeneralLabel"><fmt:message key="changeAssessment.targetTechnicalCloseoutDate" />:</td>
				<td><scannell:text value="${change.targetTechnicalCloseoutDate}" /></td>
			</c:otherwise>
		</c:choose> --%>
				</tr>

				<c:if test="${change.completed}">
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.technicalCloseoutComment" />:</td>
						<td><scannell:text value="${change.technicalCloseoutComment}" /></td>
					</tr>

					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.technicalCloseoutBy" />:</td>
						<td><c:out
								value="${change.technicalCloseoutByUser.displayName}" /> <fmt:message
								key="at" /> <fmt:formatDate
								value="${change.technicalCloseoutTime}" pattern="dd-MMM-yyyy" /></td>
					</tr>
				</c:if>

				<c:if test="${change.approved}">
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.approvedBy" />:</td>
						<td><c:out value="${change.approvedByUser.displayName}" /> <fmt:message
								key="at" /> <fmt:formatDate value="${change.approvalDate}"
								pattern="dd-MMM-yyyy" /></td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.approvedComment" />:</td>
						<td><c:out value="${change.approvalComment}" /></td>
					</tr>
				</c:if>

				<c:if test="${!change.approved && change.approvalComment != null}">
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.disapprovedBy" />:</td>
						<td><c:out value="${change.approvedByUser.displayName}" /> <fmt:message
								key="at" /> <fmt:formatDate value="${change.approvalDate}"
								pattern="dd-MMM-yyyy" /></td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message
								key="changeAssessment.disapprovedComment" />:</td>
						<td><c:out value="${change.approvalComment}" /></td>
					</tr>
				</c:if>


				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
					<td><c:out value="${change.createdByUser.displayName}" /> <fmt:message
							key="at" /> <fmt:formatDate value="${change.createdTs}"
							pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>

				<tr>
					<c:if test="${change.lastUpdatedByUser != null}">
						<td class="scannellGeneralLabel"><fmt:message
								key="lastUpdatedBy" />:</td>
						<td><c:out value="${change.lastUpdatedByUser.displayName}" />
							<fmt:message key="at" /> <fmt:formatDate
								value="${change.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
					</c:if>
				</tr>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="4" align="center"><input type="submit" id="saveButton" class="g-btn g-btn--primary"
						value="<fmt:message key="trash" />"> <input type="button" class="g-btn g-btn--primary"
						value="<fmt:message key="cancel" />"
						onclick="window.location='<c:url value="/change/changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url>'">
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
