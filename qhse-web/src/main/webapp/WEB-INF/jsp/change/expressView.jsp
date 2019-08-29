<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title><fmt:message key="auditExpress.title" /></title>
	<script type="text/javascript">
	<!--
	function openPopup(url, w, h) {
		var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
		var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
		var win = window.open(url, "links", att);
		win.focus();
	}

	function onPopupClose() {
		<c:url var="url" value="/audit/expressView.htm">
			<c:param name="id" value="${param.id}" />
		</c:url>
		window.location.href = "<c:out value="${url}" />";
	}
	// -->
	</script>

</head>
<body>

<c:set var="foundNotes" value="${!empty audit.notes}" />
<c:set var="foundAttachments" value="${!empty audit.attachments}" />


<a name="audit"></a>
<table class="viewForm">
<col class="label" />
<thead>
	<tr>
		<td colspan="4">
			<div class="navLinks">
				<a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
				<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
			<fmt:message key="auditExpress.title" />
		</td>
	</tr>
</thead>

<tbody>
	<tr>
		<th><fmt:message key="id" />:</th>
		<td><c:out value="${audit.id}" /></td>
	</tr>

	<tr>
		<th><fmt:message key="audit" /> <fmt:message key="name" />:</th>
		<td colspan="3"><scannell:text value="${audit.name}" /></td>
	</tr>
	<c:if test="${audit.programme.type.saveAndReview}">
		<tr>
			<th><fmt:message key="auditee" />
			<td colspan="3"><scannell:text value="${audit.auditee.name}" /></td>
		</tr>
	</c:if>

	<tr>
		<th><fmt:message key="auditProgramme" />:</th>
		<td><c:out value="${audit.programme.description}" /></td>
	</tr>

	<tr>
		<th><fmt:message key="leadAuditor" />:</th>
		<td><c:out value="${audit.leadAuditor.displayName}" /></td>

		<th><fmt:message key="otherParticipants" />:</th>
		<td><c:out value="${audit.otherParticipants}" /></td>
	</tr>

	<tr>
	<fmt:message key="incident.enableAdditionalFields" var="enable" />
  	<c:if test="${enable}">
  		<c:if test="${audit.location != null}">
	    	<td><fmt:message key="location" /></td>
    		<td><c:out value="${audit.location.name}" /></td>
  		</c:if>
  	</c:if>	
 	<c:if test="${!enable}">  		
		<th><fmt:message key="location" />:</th>
		<c:if test="${audit.deptLocation != null}"><td><c:out value="${audit.deptLocation}" /></td></c:if>
	</c:if>

		<th><fmt:message key="startTime" />:</th>
		<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
	</tr>

	<c:if test="${audit.review.text != null}">
		<tr>
			<th><fmt:message key="review" />:</th>
			<td colspan="3"><scannell:text value="${audit.review.text}" /></td>
		</tr>
	</c:if>

	<tr>
		<th><fmt:message key="additionalInfo" />:</th>
		<td colspan="3"><scannell:text value="${audit.additionalInfo}" /></td>
	</tr>


	<tr>
		<th><fmt:message key="associatedDocuments" />:</th>
		<td colspan="3">
			<c:set var="showLatest" value="${audit.status != 'COMPLETE'}" scope="request"/>
			<jsp:include page="../doclink/showLinkedDocs.jsp" />
		</td>
	</tr>

	<tr>
		<th><fmt:message key="createdBy" />:</th>
		<td><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

		<c:if test="${audit.lastUpdatedByUser != null}">
		<th><fmt:message key="lastUpdatedBy" />:</th>
		<td><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</c:if>
	</tr>
</tbody>

<tfoot>
	<tr>
		<td colspan="4"><scannell:url urls="${urls}" /></td>
	</tr>
</tfoot>
</table>




<a name="questions"></a>
<table class="viewForm bordered">
<col class="label" />
<thead>
	<tr>
		<td colspan="6">
			<div class="navLinks">
				<a href="#audit"><fmt:message key="auditExpress.title" /></a>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
				<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
			<fmt:message key="questions.title" />
		</td>
	</tr>
</thead>

<tbody>
<c:set var="group" value="${audit.programme.type.expressQuestionGroup}" />
<c:if test="${group.active}">
	<c:if test="${group.name != null && group.name != ''}">
	<tr><td colspan="4" class="scoringCategoryTitle"><c:out value="${group.name}"/></td></tr>
	</c:if>
	<c:forEach items="${group.questions}" var="q">
		<c:if test="${q.active and q.visible}">
		<tr>
		<c:choose>
			<c:when test="${q.answerType.name == 'label'}">
				<td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
			</c:when>
			<c:otherwise>
				<th><c:out value="${q.name}" />:</th>
				<td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${audit.answers}" /></td>
			</c:otherwise>
		</c:choose>
		</tr>
		</c:if>
	</c:forEach>
</c:if>
</tbody>
<tfoot>
	<tr>
		<td colspan="4"><scannell:url urls="${urls1}" /></td>
	</tr>
</tfoot>
</table>

<c:if test="${foundNotes}">
<a name="notes"></a>
<table class="viewForm bordered">
<thead>
	<tr>
		<td colspan="4">
			<div class="navLinks">
				<a href="#audit"><fmt:message key="auditExpress.title" /></a>
				| <a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
			<fmt:message key="notes" />
		</td>
	</tr>
	<tr>
		<th><fmt:message key="title" /></th>
		<th><fmt:message key="text" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${audit.notes}" var="note" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${note.name}" /></td>
			<td><scannell:text value="${note.text}" /></td>
			<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</tr>
	</c:forEach>
</tbody>
</table>
</c:if>

<a name="action"></a>
<table class="viewForm bordered">
  <c:choose>
    <c:when test="${!audit.hasCurrentActions}">
      <thead>
        <tr>
          <td colspan="2" >
          <div class="navLinks">
            <a href="#incident"><fmt:message key="incident" /></a> |
            <a href="#investigation"><fmt:message key="investigation" /></a>
          </div>
          No Action Associated with this Audit
          </td>
        </tr>
      </thead>
    </c:when>

    <c:otherwise>
      <thead>
      <tr>
        <td colspan="7" >
          Action Summary
        </td>
      </tr>
      <tr>
        <th><fmt:message key="id" /></th>
        <th><fmt:message key="type" /></th>
        <th><fmt:message key="description" /></th>
        <th><fmt:message key="completionTargetDate" /></th>
        <th><fmt:message key="responsibleUser" /></th>
        <th><fmt:message key="status" /></th>
        <th></th>
      </tr>
      </thead>

      <c:forEach items="${audit.currentActions}" var="item">
      <c:choose>
      <c:when test="${item != null}">
      <tr class="<c:out value="${style}" />">
        <td><c:out value="${item.id}" /></td>
        <td><fmt:message key="ActionType[${item.type}]" /></td>
        <td><div><c:out value="${item.description}" /></div></td>
        <td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
        <td><c:out value="${item.responsibleUser.displayName}" /></td>
	    <td><fmt:message key="${item.statusCode}" /></td>
        <td><a href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>" ><fmt:message key="view" /></a></td>
      </tr>
      </c:when>
      </c:choose>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</table>


<c:if test="${foundAttachments}">
<a name="attachments"></a>
<table class="viewForm bordered">
<thead>
	<tr>
		<td colspan="3">
			<div class="navLinks">
				<a href="#audit"><fmt:message key="auditExpress.title" /></a>
				| <a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
			<fmt:message key="attachments" />
		</td>
	</tr>
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="description" /></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${audit.attachments}" var="item" varStatus="s">
	<c:if test="${item.active}">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td>
			<c:choose>
				<c:when test="${item.type.name == 'attach'}">
					<a target="attachment" href="<c:url value="auditAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a>
				</c:when>
				<c:otherwise>
					<a target="attachment" href="<c:out value="${item.externalUrl}" />"><c:out value="${item.name}" /></a>
				</c:otherwise>
			</c:choose>
			<br />
			<fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" />
		</td>
		<td><scannell:text value="${item.description}" /></td>
	</tr>
	</c:if>
	</c:forEach>
</tbody>

<tfoot>
<tr>
	<td colspan="2">
		<c:if test="${audit.editable}">
			<a href="<c:url value="auditAttachmentEdit.htm"><c:param name="showId" value="${audit.id}" /></c:url>"><fmt:message key="addAttachment" /></a>
		</c:if>
		<c:if test="${audit != null && audit.editable && !empty audit.attachments}">
			<a href="<c:url value="auditAttachmentList.htm"><c:param name="id" value="${audit.id}" /></c:url>"><fmt:message key="editAttachments" /></a>
		</c:if>
	</td>
</tr>
</tfoot>
</table>
</c:if>

</body>
</html>
