<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
<c:set var="found" value="${!empty result.results}" />
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<div class="header nowrap">
<h3><fmt:message key="assessmentRevisionQueryResult.searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel  panel-danger" >
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
    
<table class="table table-bordered table-responsive dataTable">
  <thead>    
    <c:if test="${found}">
    <tr>
      <th style="width:50%;"><fmt:message key="id" /></th>
      <th><fmt:message key="assessment.revisionReason" /></th>
      <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven}">
        <th><fmt:message key="assessment.score" /></th>
        <th><fmt:message key="assessment.threshold" /></th>
      </c:if>
      <th><fmt:message key="assessment.approvedBy" /></th>
      <c:if test="${assessment.template.multiApproval==true}">
      	<th><fmt:message key="status" /></th>
      </c:if>
    </tr>
    </c:if>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="assessment" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <c:set var="threshold" value="${assessment.threshold}" />
      <tr class="<c:out value="${style}" />">
        <td>
          <c:choose>
            <c:when test="${assessment.type eq riskType}">
                <c:url var="url" value="/risk/expressAssessmentRevisionView.htm">
          			<c:param name="id" value="${assessment.id}"/>
          			<c:param name="rev" value="${assessment.revision}"/>
          		</c:url>
        		<a href="<c:out value="${url}" />"><c:out value="${assessment.displayId}" /></a>
		    </c:when>
		    <c:otherwise>
		       	<c:url var="url" value="/risk/assessmentRevisionView.htm">
          			<c:param name="id" value="${assessment.id}"/>
          			<c:param name="rev" value="${assessment.revision}"/>
          		</c:url>
        		<a href="<c:out value="${url}" />"><c:out value="${assessment.displayId}" /></a>
		    </c:otherwise>
	     </c:choose>

          
        </td>
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
        <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven}">
        <td style="white-space: nowrap;">

   			<c:set var="threshold" value="${assessment.threshold}" />
			<c:choose>
			    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
			      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
			    </c:when>
			    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
			      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
			    </c:when>
			    <c:when test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
			      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
			    </c:when>
			    <c:when test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
			      <img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
			    </c:when>
			    <c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
			      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
			    </c:when>
			    <c:otherwise><img src="<c:url value="/images/risk/score_greenlight.giff" />" /></c:otherwise>
			</c:choose> 
          <c:out value="${assessment.score}" />
        </td>
        <td style="white-space: nowrap;">
         <c:choose>
				<c:when test="${assessment.template.critical == true && threshold.criticalLimit>0}">
					<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${threshold.criticalLimit}"/>
					<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${threshold.upperLimit}"/>
					<img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${threshold.lowerLimit}"/>
				</c:when>
				<c:otherwise>
					<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${threshold.upperLimit}" />
					<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${threshold.lowerLimit}" />
				</c:otherwise>
			</c:choose>
        </td>
        </c:if>
        <%--  The createdByUser/createdTs is used here because the each assessment revision object is a newly created object.  --%>
        <td>
        	<c:choose>
			    		<c:when test="${assessment.template.multiApproval==true}"><c:if test="${assessment.status.name == 'COMPLETE'}">
			    			<c:out value="${assessment.approvedByUser.displayName}" /> 
        	<c:if test="${not empty assessment.approvalDate}">
        	<fmt:message key="at" /> 
        	</c:if>
        <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" />
			    		</c:if></c:when>
			    		<c:when test="${assessment.template.multiApproval==false}">
        <c:out value="${assessment.approvedByUser.displayName}" /> 
        	<c:if test="${not empty assessment.approvalDate}">
        	<fmt:message key="at" /> 
        	</c:if>
        <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" />
        </c:when>
        </c:choose>
        </td>
        <c:if test="${assessment.template.multiApproval==true}">
	      		<td style="white-space: nowrap;">
	      			<c:choose>
			    		<c:when test="${assessment.status.name == 'IN_PROGR'}">
					      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
					    </c:when>
					    <c:when test="${assessment.status.name == 'REJECTED'}">
					      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
					    </c:when>
					    <c:otherwise><img src="<c:url value="/images/risk/score_greenlight.giff" />" /></c:otherwise>
			    	</c:choose>
	      		</td>
	      </c:if>
      </tr>
    </c:forEach>
    <tfoot>
	    <c:if test="${found}">
		    <tr>
		      	<td colspan="5"><scannell:paging result="${result}" /></td>
		    </tr>
	    </c:if>
    </tfoot>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
