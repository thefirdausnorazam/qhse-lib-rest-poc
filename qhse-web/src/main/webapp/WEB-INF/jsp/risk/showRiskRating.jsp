<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="header">
<h3> <fmt:message key="riskRating" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
	<table class="table table-bordered table-responsive printFont">
<col class="label" />
<tbody>
	<c:choose>
		<c:when test="${assessment.template.critical == true}">
	  		<tr><td class="scannellGeneralLabel" style="width:20%"><fmt:message key="threshold.criticalLimit" />:</td><td><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${assessment.template.threshold.criticalLimit}" /></td><td class="scannellGeneralLabel"><fmt:message key="threshold.upperLimit" />:</td><td><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${assessment.template.threshold.upperLimit}" /></td><td class="scannellGeneralLabel"><fmt:message key="threshold.lowerLimit" />:</td><td><img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${assessment.template.threshold.lowerLimit}" /></td></tr>
	  	</c:when>
	  	<c:otherwise>
	  		<tr><td class="scannellGeneralLabel" style="width:20%"><fmt:message key="threshold.upperLimit" />:</td><td><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${assessment.template.threshold.upperLimit}" /></td><td class="scannellGeneralLabel"><fmt:message key="threshold.lowerLimit" />:</td><td ><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${assessment.template.threshold.lowerLimit}" /></td></tr>
	  	</c:otherwise>
  	</c:choose>
  <tr><td class="scannellGeneralLabel" style="text-align:right"><fmt:message key="riskScoreLabel" />:</td><td colspan="6">
	   <c:choose>
	      <c:when test="${fn:length(assessment.template.scoringCategories) != 0 and fn:contains(assessment.template.name, 'Manual Handling') }">
		  		<c:out value="max(${assessment.riskRating})" />
		  </c:when>
		  <c:when test="${fn:length(assessment.template.scoringCategories) != 0}">
		  		<c:out value="${assessment.riskRating}" />
		  </c:when>
		  <c:otherwise>
		  max(<c:out value="${assessment.template.scoringModel}"></c:out>)
		  		<%-- max(<c:forEach items="${assessment.jobs}" var="job" varStatus="jloop">
				  		<c:forEach items="${job.hazards}" var="hazard" varStatus="hloop">
				  			<c:out value="${hazard.score}" /><c:if test="${!hloop.last}">,</c:if>
						</c:forEach>
				</c:forEach>) --%>
		  </c:otherwise>
	  </c:choose>
  </td></tr>
  <tr ${assessment.template.scoreCalc == null ? 'style=display:none':''}><td class="scannellGeneralLabel" style="text-align:right"><fmt:message key="riskScoreCalc" />:</td><td colspan="7"><c:out value="${assessment.template.scoreCalc}" /></td></tr>
</tbody>
</table>
</div>
</div>
</div>