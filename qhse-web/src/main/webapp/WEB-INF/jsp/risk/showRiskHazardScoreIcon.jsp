<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="threshold" value="${assessment.threshold}" />
<c:set var="hazardScore" value="${answer.value}" />

<td id="answers[<c:out value="${answer.question.id}"/>]" style="width:100px; word-wrap: break-word">
	<c:choose>
	    <c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit}">
	      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
	    </c:when>
		<c:when test="${assessment.template.critical == true && hazardScore ge threshold.upperLimit}">
      		<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
	    </c:when>
		<c:when test="${assessment.template.critical == false && hazardScore ge threshold.upperLimit}">
	    	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
	    </c:when>
	    <c:when test="${assessment.template.critical == true && hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
	      <img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
	    </c:when>
	    <c:when test="${hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
	      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
	    </c:when>
		<c:otherwise>
			<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
		</c:otherwise>
	</c:choose>
</td>
