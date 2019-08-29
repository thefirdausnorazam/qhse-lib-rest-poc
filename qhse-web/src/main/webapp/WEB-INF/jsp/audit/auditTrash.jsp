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
<h3><fmt:message key="auditTrash.title" /></h3>
</div>
<scannell:form>
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-responsive table-bordered ">

<tbody>
 <tr>
	<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
		<td><c:out value="${audit.id}" /></td>
</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="audit" /> <fmt:message key="name" />:</td>
								<td><c:out value="${audit.name}" /></td>
							</tr>
							<c:if test="${audit.recurringAudit != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="recurringAudit" />:</td>
									<td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${audit.recurringAudit.id}"/></c:url>" ><c:out value="${audit.recurringAudit.name}" /></a></td>
								</tr>
							</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditProgramme" />:</td>
								<td><c:out value="${audit.programme.description}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
								<td><c:out value="${audit.leadAuditor.displayName}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditee" />:</td>
								<td><c:out value="${audit.auditee.name}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="audit.personObserved" />:</td>
								<td><c:forEach items="${audit.observers}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="secondaryAuditors" />:</td>
								<td><c:forEach items="${audit.secondaryAuditors}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="otherParticipants" />:</td>
								<td><scannell:text value="${audit.otherParticipants}" /></td>
							</tr>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
								<td><scannell:text value="${audit.additionalInfo}" /></td>
							</tr>

							<c:if test="${audit['class'].name == 'com.scannellsolutions.modules.audit.domain.AuditScheduled'}">
								<tr>
									<td class="scannellGeneralLabel">
										<c:if test="${audit.auditee['class'].simpleName == 'ThirdPartyAuditee'}"><fmt:message key="address" />:</c:if>
										<c:if test="${audit.auditee['class'].simpleName != 'ThirdPartyAuditee'}"><fmt:message key="department" />:</c:if> </td>
									<c:if test="${audit.deptLocation != null}">
										<td><c:out value="${audit.deptLocation}" /></td>
									</c:if>
								</tr>
							</c:if>

							<c:if test="${audit.recurringAudit != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="recurringAudit" />:</td>
									<td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${audit.recurringAudit.id}" /></c:url>">
											<c:out value="${audit.recurringAudit.name}" />
										</a></td>
								</tr>
							</c:if>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="startTime" />:</td>
								<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="duration" />:</td>
								<td><c:out value="${audit.duration.description}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="percentCompleted" />:</td>
								<td><c:out value="${audit.percentCompleted}%" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="status" />:</td>
								<td>
								<fmt:message key="${audit.status}" />
								</td>
							</tr>
							<c:if test="${audit.completed}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="completedBy" />:</td>
									<td><c:out value="${audit.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.completionTime}" pattern="dd-MMM-yyyy" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="completionComment" />:</td>
									<td><scannell:text value="${audit.completionComment}" /></td>
								</tr>
							</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
								<td><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
							<c:if test="${audit.lastUpdatedByUser != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
									<td><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:if>


</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
    <c:if test="${audit.status != 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
    </c:if>
   <c:if test="${audit.status == 'TRASH'}">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="untrash" />">
    </c:if>
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/audit/auditView.htm"><c:param name="id" value="${audit.id}"/></c:url>'">
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
