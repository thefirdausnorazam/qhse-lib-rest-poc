<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${template != null && template.scorable}">
<div id="currentThreshold" style="text-align: right;">Current Threshold:
<c:choose>
	<c:when test="${template.critical == true}">
		<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${template.threshold.criticalLimit}"/>+
		<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${template.threshold.upperLimit}"/>+
		<img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${template.threshold.lowerLimit}"/>+
		<img src="<c:url value="/images/risk/score_greenlight.giff" />" />0+
	</c:when>
	<c:otherwise>
		<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${template.threshold.upperLimit}"/>+
		<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${template.threshold.lowerLimit}"/>+
		<img src="<c:url value="/images/risk/score_greenlight.giff" />" />0+
	</c:otherwise>
</c:choose>
</div>
</c:if>