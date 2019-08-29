<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="plan" value="${command.entity}" />
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
<h2><fmt:message key="assessmentTrashForm.title" /></h2>
</div>
<scannell:form>
<div class="content">  
	<div class="table-responsive">
		<div class="panel panel-danger">
			<table class="table table-responsive table-bordered ">
			<tbody>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
					<td><c:out value="${plan.id}" /></td>
				</tr>
	  			<tr>
	    			<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
	    			<td colspan="3">
					      <ul>
						      <c:forEach var="ba" items="${plan.businessAreas}">
						        	<li><c:out value="${ba.name}" /></li>
						      </c:forEach>
					      </ul>
	    			</td>
	  			</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="year" />:</td>
					<td><c:out value="${plan.year}" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
					<td><c:out value="${plan.percentCompleted}%" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
					<td><c:out value="${plan.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${plan.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				<c:if test="${plan.lastUpdatedByUser != null}">
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
					<td><c:out value="${plan.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${plan.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				</c:if>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="4" align="center">
					<c:choose>
						<c:when test="${plan.status.name == 'TRASH' }"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />"></c:when>
						<c:otherwise><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />"></c:otherwise>
					</c:choose>
						 
						<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />"
						onclick="window.location='<c:url value="/change/planView.htm"><c:param name="id" value="${plan.id}"/></c:url>'">
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
