<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<div class="header nowrap">
<h3><fmt:message key="auditPlanTrash.title" /></h3>
</div>
<scannell:form>
<a name="plan"></a>
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<col class="label" />
<tbody>
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
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${plan.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="audit.yearFrom" />:</td>
		<td><c:out value="${plan.year}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="audit.yearTo" />:</td>
		<td><c:out value="${plan.yearEnd}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
		<td><c:out value="${plan.percentCompleted}%" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
		<td>
			<fmt:message key="${plan.status}" />
		</td>
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
<tfoot>
  <tr>
    <td colspan="4" align="center">
    <c:if test="${plan.status != 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
    </c:if>
   <c:if test="${plan.status == 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />">
    </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/planView.htm"><c:param name="id" value="${plan.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
