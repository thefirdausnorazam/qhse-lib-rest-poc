<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${printable}">
	  <c:set var="threshold" value="${assessment.threshold}" />
	  <c:choose>
	    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}"> (<fmt:message key="scoreCritical" />)</c:when>
	    <c:when test="${assessment.score ge threshold.upperLimit}"> (<fmt:message key="scoreHigh" />)</c:when>
	    <c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}"> (<fmt:message key="scoreMedium" />)</c:when>
	    <c:otherwise> (<fmt:message key="scoreLow" />)</c:otherwise>
	  </c:choose>
</c:if>