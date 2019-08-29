<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskStatus" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript">  
  jQuery(document).ready(function() {	  
	 jQuery("#queryForm").submit(); 
  });
  </script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
  </style>
</head>
<body>
<div class="header ">
<h2><fmt:message key="assessmentRevisionQueryForm.title" /></h2>
</div>
<div class="content">
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<div class="header nowrap">
<h3><fmt:message key="assessment" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">

<table class="table table-responsive table-bordered table-hover" >
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
	    <c:choose>
	        	<c:when test="${assessment.type eq riskType}">
	        		<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
	        	</c:when>
	        	<c:otherwise>
	        		<c:url var="assessmentURL" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
	        	</c:otherwise>
	     </c:choose>
         <a href="<c:out value="${assessmentURL}" />"><c:out value="${assessment.displayId}" /></a>
         <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
    </td>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td><fmt:message key="assessment${assessment.status}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.revisionReason" />:</td>
    <td>
      <fmt:message key="${assessment.revisionReason}" />
         
      		<c:choose>
      			<c:when test="${assessment.type eq riskType}">
      				<c:if test="${assessment.completedExpressTask != null}">
	        		<c:url var="viewTaskUrl" value="/risk/hazardTaskView.htm"><c:param name="id" value="${assessment.completedTask.id}"/></c:url>
	        		<a href="<c:out value="${viewTaskUrl}" />"><c:out value="${assessment.completedTask.displayId}" /></a>
	        	</c:if>
	        	</c:when>
	        	<c:otherwise>
	        		<c:if test="${assessment.completedTask != null}">
		        		<c:url var="viewTaskUrl" value="/risk/taskView.htm"><c:param name="id" value="${assessment.completedTask.id}"/></c:url>
		        		<a href="<c:out value="${viewTaskUrl}" />"><c:out value="${assessment.completedTask.displayId}" /></a>
	        		</c:if>
	        	</c:otherwise>
	     	</c:choose>
   
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td <c:if test="${!(assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven)}"> colspan="5" </c:if>>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
	<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven}">
    <td class="scannellGeneralLabel"><fmt:message key="assessment.score" />:</td>
    <td>
      <jsp:include page="showRiskScoreIcon.jsp" /> 
      <c:out value="${assessment.score}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.threshold" />:</td>
    <td>
      <jsp:include page="showThreshold.jsp" /> 
    </td>
	</c:if>
  </tr>

  <tr>
  <td class="scannellGeneralLabel nowrap">Title:</td>
    <td><c:out value="${assessment.name}" /></td>
    <td class="scannellGeneralLabel" width="150px">
    <c:choose>
        	<c:when test="${assessment.type eq riskType}">
        		<fmt:message key="assessment.scope" />:
        	</c:when>
        	<c:otherwise>
        		<fmt:message key="assessment.name" />:
        	</c:otherwise>
     </c:choose>
    </td>
    <td>
  	  <c:choose>
		  <c:when test="${assessment.sensitiveDataViewable}">
		  	<c:out value="${assessment.type eq riskType ? assessment.description : assessment.name}"/>
		  </c:when>
	      <c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
	  </c:choose>
    </td>
    <td class="scannellGeneralLabel" width="150px">
	    <fmt:message key="reviewTargetDate" />:
    </td>
    <td>
		<fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" />
    </td>
    
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.otherParticipants" />:</td>
    <td colspan="3">
    	<c:choose>
    		<c:when test="${assessment.otherParticipants != null && assessment.otherParticipants != ''}"><c:out value="${assessment.otherParticipants}" /></c:when>
    		<c:otherwise><fmt:message key="risk.noneSpecified" /></c:otherwise>
    	</c:choose>
    </td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="6" align="center">      
      <input type="button" class="g-btn g-btn--primary" value="<fmt:message key="back" />" onclick="window.location='<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
<form id="queryForm" action="<c:url value="/risk/assessmentRevisionQueryResult.ajax" />" onSubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />
  <input type="hidden" name="id" value="<c:out value="${param.id}" />" />

  <div id="resultsDiv"></div>
</form>
</div>
</body>
</html>
