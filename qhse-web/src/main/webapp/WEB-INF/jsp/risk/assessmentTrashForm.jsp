<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<c:set var="assessment" value="${command.entity}" />
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <style type="text/css" media="all">
    @import "<c:url value='/css/risk.css'/>";
    @import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
  </style>
  
  <script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#submitButton").click(function() {
			setTimeout(function() {
				jQuery("#submitButton").prop("disabled", true);
			}, 1);
		});
	});
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
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td id="assessmentId">
      <scannell:hidden writeRequiredHint="false" path="id" />
      <scannell:hidden writeRequiredHint="false" path="version" />
      <c:out value="${assessment.displayId}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td valign="top" id="assessmentBusinessAreas" ${assessment.template.scorable and assessment.template.prefix != 'SA' ? "":"colspan='3'"}>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
    <c:if test="${assessment.template.scorable and assessment.template.prefix != 'SA'}">
    <td class="scannellGeneralLabel" id="assessmentScore"><fmt:message key="assessment.score" />:</td>
    <td valign="top">
	    <c:choose >
	    	<c:when test="${assessment.template.multiApproval}">
	    		
	    	</c:when>
		    <c:otherwise>
		    	 <jsp:include page="showRiskScoreIcon.jsp" /> 
		      <c:out value="${assessment.score}" />
		    </c:otherwise>
	    </c:choose>
    </td>
    </c:if>
  </tr>

	<c:if test="${assessment.type != riskType}">
		  <tr>
		    <td class="scannellGeneralLabel">
		    	<fmt:message key="assessment.name" />:
		    </td>
		    <td colspan="3" id="assessmentName">
				  <c:choose>
					  <c:when test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
				      <c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
				  </c:choose>
		    </td>
		  </tr>
  	</c:if>
  
  <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
      <c:if test="${g.name != null && g.name != ''}">
      <tr><td colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}"/></td></tr>
      </c:if>
      <c:forEach items="${g.questions}" var="q">
        <c:if test="${q.active and q.visible}">
          <tr>
          <c:choose>
            <c:when test="${q.answerType.name == 'label'}">
              <td colspan="4"  class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
            </c:when>
            <c:otherwise>
             	<td class="scannellGeneralLabel">
			    	<c:choose>
			      		<c:when test="${assessment.type eq riskType and q.name == 'Description'}">
			      			<fmt:message key="assessment.scope" />:
			      		</c:when>
			      			<c:otherwise>
			      			<c:out value="${q.name}" />:
			      		</c:otherwise>
			  		 </c:choose>
		  		 </td>
              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
            </c:otherwise>
          </c:choose>
          </tr>
        </c:if>
      </c:forEach>
    </c:if>
  </c:forEach>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser"><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><c:out value="${assessment.otherParticipants}" /></td>
  </tr>

  <c:if test="${assessment.approved}" >
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvedBy" />:</td>
    <td colspan="3" id="assessmentApprovedBy"><c:out value="${assessment.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvalComment" />:</td>
    <td colspan="3" id="assessmentApprovalComment"><scannell:text value="${assessment.approvalComment}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${assessment.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>

  <tr>
    <td></td>
    <td colspan="3">
      <c:set var="displayedWarningMessage" value="false" />
      <c:if test="${assessment.type.name != 'EXPRESS'}">
      <ul>
      <c:forEach var="task" items="${assessment.assessmentTasks}">
        <c:if test="${not (task.archived or task.completed or task.trashed) and (task.actualParentRA == null or task.actualParentRA == assessment.id)}">
          <c:if test="${not displayedWarningMessage}">
            <c:set var="displayedWarningMessage" value="true" />
            <fmt:message key="assessmentTrashForm.openTasksNew" />
          </c:if>
          <li><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="${task.displayId}" /></a></li>
        </c:if>
      </c:forEach>
      </ul>
      </c:if>
      <c:if test="${assessment.type.name == 'EXPRESS'}">
      <ul>
      <c:forEach var="task" items="${assessment.assessmentHazardTasks}">
        <c:if test="${not (task.archived or task.completed or task.trashed) }">
          <c:if test="${not displayedWarningMessage}">
            <c:set var="displayedWarningMessage" value="true" />
            <fmt:message key="assessmentTrashForm.openTasksNew" />
          </c:if>
          <li><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="${task.displayId}" /></a></li>
        </c:if>
      </c:forEach>
      </ul>
      </c:if>
    </td>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" id="submitButton" class="g-btn g-btn--primary" value="<fmt:message key="trash" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>'">
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
