<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="assessmentQueryResult.title" /></title>
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/risk/expressAssessmentView.htm?showId=${result.results[0].id}';
		}
	}
</script>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >7</c:when> 
	  <c:otherwise>6</c:otherwise> 
	</c:choose> 
</c:set>
<div class="header">
<h3><fmt:message key="assessmentQueryResult.searchResults" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />

<jsp:include page="showCurrentThreshold.jsp" /> 
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
    	<div class="div-for-pagination">
          <scannell:paging result="${result}" />
        </div>
    </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
    <c:if test="${found}">
    <tr>
      	<th><fmt:message key="id" /></th>
    	<th><fmt:message key="assessment.description" /></th> 
    	<th><fmt:message key="assessment.job" /></th>
    	<c:choose>
    	   <c:when test="${isQualityTemplate}">
    		<th><fmt:message key="assessment.quality.keyIssues" /></th>  
	 		<th><fmt:message key="assessment.responsibleUser" /></th>
       		<th><fmt:message key="assessment.quality.score" /></th>
        	</c:when>
    	   <c:otherwise>
    		<th><fmt:message key="assessment.job.hazard" /></th>  
    		<th><fmt:message key="assessment.responsibleUser" /></th>
       		<th><fmt:message key="assessment.hazard.score" /></th>
    	   </c:otherwise>
    	</c:choose>
    	<c:if test="${showSiteColumn}">
    		<th><fmt:message key="site" /></th>
    	</c:if>
    	<th class="printColumn">Print</th>
    </tr>
    </c:if>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="hazard" varStatus="s">
     <c:set var="threshold" value="${hazard.job.assessment.threshold}" />
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
	        <td>
	        	<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${hazard.job.assessment.id}"/></c:url>
	            <a href="<c:out value="${assessmentURL}"/>#jobTable"><c:out value="${hazard.job.assessment.displayId}" /></a>
	          		          	
	        </td> 	
	        <td>
	        	<c:if test="${hazard.job.assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  			<c:if test="${hazard.job.assessment.sensitiveDataViewable}"><scannell:text value="${hazard.job.assessment.name}" /></c:if>
	        </td>
	        <td><scannell:text value="${hazard.job.name}" /></td>
	        <c:forEach items="${hazard.answers}" var="answer" varStatus="h">
				<c:if test="${fn:contains(answer.question.codeName,'icd_hs.hazards.hazard') or fn:contains(answer.question.codeName,'icd_env.aspects.environmental_aspect') or fn:contains(answer.question.codeName,'key.Issues') }">
				  <td> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
				</c:if>
			</c:forEach>
			<td><c:out value="${hazard.job.assessment.responsibleUser.displayName}" /></td>
         	<c:forEach items="${hazard.answers}" var="answer" varStatus="h">
					<c:choose> 
						<c:when test="${fn:contains(answer.question.codeName,'newrisk.job.rr.rating')}">
							<c:set var="critical" value="${hazard.job.assessment.template.critical}" />
							<c:set var="hazardScore" value="${answer.value}" />
							<td id="answers[<c:out value="${answer.question.id}"/>]" style="width:100px; word-wrap: break-word">
								<c:choose>
								    <c:when test="${critical == true && hazardScore ge threshold.criticalLimit}">
								      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
								    </c:when>
									<c:when test="${critical == true && hazardScore ge threshold.upperLimit}">
							      		<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
								    </c:when>
									<c:when test="${critical == false && hazardScore ge threshold.upperLimit}">
								    	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
								    </c:when>
								    <c:when test="${critical == true && hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
								      <img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
								    </c:when>
								    <c:when test="${hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
								      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
								    </c:when>
									<c:otherwise>
										<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
									</c:otherwise>
								</c:choose>
							<enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
						</c:when>
				  	</c:choose> 
				</c:forEach>
			<c:if test="${showSiteColumn}">
				<td><c:out value="${hazard.job.assessment.site.name}" /></td>
			</c:if>
			<td><a href="<c:out value="${assessmentURL}" />&printable=true" target="printWindow" ><img alt="Print" src="<c:url value="/images/print.gif" />"></a><br>
			</td>
      </tr>
    </c:forEach>
    <tfoot>
	    <c:if test="${found}">
	    <tr>
	      <td colspan="${colspan}"><scannell:paging result="${result}" /></td>
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
