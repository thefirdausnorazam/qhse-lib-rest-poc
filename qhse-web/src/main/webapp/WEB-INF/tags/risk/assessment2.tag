<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="assessment" required="true" type="com.scannellsolutions.modules.risk.domain.RiskAssessment" %>
<%@ attribute name="template" required="true" type="com.scannellsolutions.modules.risk.domain.RiskTemplate" %>
<%@ attribute name="style" required="true" type="java.lang.String" %>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="threshold" value="${assessment.threshold}" />
<tr class="<c:out value="${style}" />">
      <td> 
      	<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
          <a href="<c:out value="${assessmentURL}"/>"><c:out value="${assessment.displayId}" /></a>
        	<br>
	<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if> 
      </td> 	
      <td> <scannell:text value="${assessment.name}" /> </td>
      <c:forEach items="${assessment.answers}" var="answer" varStatus="h">
	<c:choose> 
		<c:when test="${answer.question.id eq '42'}">
			<c:set var="dept" value="${answer.value}" />
			<td> <enviromanager:answer question="${answer.question}" answers="${assessment.answers}" /> </td>
	    </c:when>	
	     </c:choose>
		</c:forEach>
		      <td> <c:out value="${assessment.approvalByUser.displayName}" /> </td>
		      <td> <c:out value="${assessment.responsibleUser.displayName}" /> </td>
		<td> 
		<c:if test="${assessment.template.prefix != 'SA'}">
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
		</c:if>
			</td>
		<td> 
		<c:out value="${assessment.reviews[0].date}" /> 
		 </td>
        <c:if test="${showSiteColumn}">
        	<td> <c:out value="${assessment.site.name}" /> </td>
        </c:if>
         <td> 
          <a href="<c:out value="${assessmentURL}" />&printable=true" target="printWindow" ><img alt="Print" src="<c:url value="/images/print.gif" />"></a> <br>
        </td>
</tr>