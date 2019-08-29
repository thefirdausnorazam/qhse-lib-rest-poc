<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
  	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
		 
		 function disableFormButtons() {
			 jQuery("#submitButton").prop("disabled", true);
		 }
 	</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="taskAssociateForm.title" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<col  />
<thead>
  <tr><td colspan="4"><fmt:message key="assessment" /></td></tr>
</thead>
<tbody>
  <tr>
    <td class=""><fmt:message key="id" />:</td>
    <td>
      <c:url var="assessmentViewUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}" /></c:url>
      <a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${assessment.displayId}" /></a>
      <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
    </td>

    <td class=""><fmt:message key="assessment.status" />:</td>
    <td><fmt:message key="assessment${assessment.status}" /></td>
  </tr>

  <tr>
    <td class=""><fmt:message key="businessAreas" />:</td>
    <td valign="top">
      <ul>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
	<c:if test="${assessment.template.scorable}">
    <td class=""><fmt:message key="assessment.score" />:</td>
    <td valign="top">
      <jsp:include page="showRiskScoreIcon.jsp" /> 
      <c:out value="${assessment.score}" />
    </td>
    </c:if>
  </tr>

  <tr>
    <td class="" width="150px"><fmt:message key="assessment.name" />:</td>
    <td colspan="3">
      
	  <c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
    </td>
  </tr>

  <tr>
    <td class=""><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class=""><fmt:message key="assessment.otherParticipants" />:</td>
    <td><c:out value="${assessment.otherParticipants}" /></td>
  </tr>


	<c:if test="${assessment.template.scorable}">
	  <tr>
	    <td class="">
	      <fmt:message var="scoreComment" key="assessment.scoreComment" />
	      <spring:message code="assessment[${assessment.template.id}].scoreComment" text="${scoreComment}" />:
	    </td>
	    <td colspan="3"><scannell:text value="${assessment.scoreComment}" /></td>
	  </tr>
	  <tr>
	    <td class=""><c:out value="${score.question.name}" />:</td>
	    <td colspan="3">
	      <c:out value="${score.selectedOption.score} - ${score.selectedOption.name}" /><br />
	      <scannell:text value="${score.justification}" />
	    </td>
	  </tr>
 </c:if>
</tbody>
</table>
</div>
</div>

<scannell:form onsubmit="disableFormButtons()">
  <scannell:hidden path="id" />

<c:set var="found" value="${!empty taskList}" />
<div class="header">
<h3><fmt:message key="tasks" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive dataTable">
  <thead>   
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="task.name" /></th>
      <th><fmt:message key="task.targetCompletionDate" /></th>
      <th><fmt:message key="task.status" /></th>
      <th><fmt:message key="task.responsibleUser" /></th>
    </tr>
    </c:if>
  </thead>

  <tbody>
    <c:forEach items="${taskList}" var="task" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><scannell:checkbox path="associatedTaskIds" value="${task.id}" /><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="${task.displayId}" /></a></td>
        <td><scannell:text value="${task.name}" /></td>
        <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
        <td><fmt:message key="task.${task.status}" /></td>
        <td><c:out value="${task.responsibleUser.displayName}" /></td>
      </tr>
    </c:forEach>

    <tr>
      <td colspan="5" align="center">
        <c:if test="${!found}"><fmt:message key="search.empty" /></c:if>
        <c:if test="${found}"><input id="submitButton" class="g-btn g-btn--primary" type="submit" value="<fmt:message key="associate" />"></c:if>
        <input type="button" class="g-btn g-btn--primary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>'">
      </td>
    </tr>
  </tbody>
</table>
</div>
</div>
</scannell:form>
</body>
</html>
