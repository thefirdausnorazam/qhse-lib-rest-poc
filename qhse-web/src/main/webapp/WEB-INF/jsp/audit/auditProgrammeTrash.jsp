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
<h3><fmt:message key="auditProgrammeTrash.title" /></h3>
</div>
<scannell:form>
<a name="programme"></a>
<div class="content">
<div class="table-responsive">
<table class="table table-responsive table-bordered">
<col class="label" />
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${auditProgramme.id}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="auditPlan" />:</td>
		<td><c:out value="${auditProgramme.plan.displayName}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="type" />:</td>
		<td><c:out value="${auditProgramme.type.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="owner" />:</td>
		<td><c:out value="${auditProgramme.owner.displayName}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
		<td><c:out value="${auditProgramme.percentCompleted}%" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
		<td>
		<c:if test="${auditProgramme.completed}">
			<fmt:message key="audit.status.completed" />
		</c:if>
		<c:if test="${!auditProgramme.completed}">
			<fmt:message key="audit.status.inProgress" />
		</c:if>
		</td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${auditProgramme.additionalInfo}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="reviewDate" />:</td>
		<td><fmt:formatDate value="${auditProgramme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="auditors" />:</td>
		<td><c:forEach items="${auditors}" var="auditor" varStatus="s">
			<c:out value="${auditor.displayName}" /><c:if test="${!s.last}">, </c:if>
		</c:forEach></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${auditProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${auditProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	<c:if test="${auditProgramme.lastUpdatedByUser != null}">
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${auditProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${auditProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	</tr>
	</c:if>
</tbody>
<tfoot>
<tfoot>
  <tr>
    <td colspan="4" align="center">
    <c:if test="${auditProgramme.programmeStatus != 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
    </c:if>
   <c:if test="${auditProgramme.programmeStatus == 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />">
    </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/programmeView.htm"><c:param name="id" value="${auditProgramme.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
