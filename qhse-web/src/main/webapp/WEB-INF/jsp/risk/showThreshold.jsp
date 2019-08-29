<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="threshold" value="${assessment.threshold}" />
<!-- Attachment driven template like Permit to work does not have normal score they maintain status in color like Red, Amber, Green depending on attachment  -->
<c:if test="${not assessment.template.attachmentDriven}">
<c:choose>
	<c:when test="${assessment.template.critical == true}">
		<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${threshold.criticalLimit}"/>
		<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${threshold.upperLimit}"/>
		<img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${threshold.lowerLimit}"/>
	</c:when>
	<c:otherwise>
		<img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${threshold.upperLimit}" />
		<img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${threshold.lowerLimit}" />
	</c:otherwise>
</c:choose>
</c:if>