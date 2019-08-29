<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="threshold" value="${assessment.threshold}" />
<c:choose>
	<c:when test="${(assessment.template.prefix =='PTW' || assessment.template.prefix == 'RAPtW')}">
      <img src="<c:url value="/images/risk/score_${assessment.nrag}light.giff" />" />
    </c:when>
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
    <c:when test="${assessment.status.name == 'IN_PROGR' && (assessment.template.prefix =='RAMS' || assessment.template.prefix == 'HS-PPE')}">
      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />&nbsp&nbsp(Next Step: Approval to turn Green.)
    </c:when>
    <c:when test="${assessment.status.name == 'REJECTED' && (assessment.template.prefix =='RAMS' || assessment.template.prefix == 'HS-PPE')}">
      <img src="<c:url value="/images/risk/score_redlight.giff" />" />&nbsp&nbsp<fmt:message key="assessment.PtWStatus.${latestAssessmentRevision.nrag}.next"/>
    </c:when>
    <c:otherwise><img src="<c:url value="/images/risk/score_greenlight.giff" />" /></c:otherwise>
</c:choose>