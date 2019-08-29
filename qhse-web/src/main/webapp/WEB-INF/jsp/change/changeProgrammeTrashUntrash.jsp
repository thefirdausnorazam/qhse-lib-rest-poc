<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="programme" value="${command.entity}" />
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
</script>

</head>
<body>
<div class="header nowrap">
<h2><fmt:message key="changeProgrammeTrashForm.title" /></h2>
</div>
<scannell:form>
<div class="content">  
	<div class="table-responsive">
		<div class="panel panel-danger">
			<table class="table table-responsive table-bordered ">
			<tbody>
				<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${programme.id}" /></td>
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
					<td colspan="4" align="center">
					<c:choose>
						<c:when test="${programme.status.name == 'TRASH' }"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />"></c:when>
						<c:otherwise><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />"></c:otherwise>
					</c:choose>
						 
						<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />"
						onclick="window.location='<c:url value="/change/programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>'">
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
