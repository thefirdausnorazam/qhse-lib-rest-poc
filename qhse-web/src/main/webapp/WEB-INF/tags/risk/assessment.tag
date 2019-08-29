<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="assessment" required="true" type="com.scannellsolutions.modules.risk.domain.RiskAssessment" %>
<%@ attribute name="template" required="true" type="com.scannellsolutions.modules.risk.domain.RiskTemplate" %>
<%@ attribute name="riskType" required="true" type="com.scannellsolutions.modules.risk.domain.RiskType" %>
<%@ attribute name="style" required="true" type="java.lang.String" %>
<%@ attribute name="showSiteColumn" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showLegacyIds" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showAllRA" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>


<tr class="<c:out value="${style}" />">
        <td> 
        <c:choose>
        	<c:when test="${assessment.type eq riskType}">
        		<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
        	</c:when>
        	<c:otherwise>
        		<c:url var="assessmentURL" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
        	</c:otherwise>
          </c:choose>
          <c:choose>
          	<c:when test="${not empty currentSite}"><a onclick='changeSite("${assessmentURL}", ${assessment.site.id}, "${assessment.site}", ${currentSite})' href="#" ></c:when>
          	<c:otherwise><a href="<c:out value="${assessmentURL}"/>"></c:otherwise>
          </c:choose>
          <c:out value="${assessment.displayId}" /></a>
          <br>
          
			<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  		<c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if> 
        </td>
        <c:choose>
	        <c:when test="${assessment.type eq riskType}">
	        	<c:forEach items="${assessment.answers}" var="answer" varStatus="h">
					<c:if test="${answer.question.id eq '42' and prevanswer ne '42'}">
					<c:set var="prevanswer" value="${answer.question.id}" scope="page"/>
					<td> <enviromanager:answer question="${answer.question}" answers="${assessment.answers}" /> </td>
					</c:if>
				</c:forEach>
	        </c:when>
	        <c:otherwise>
		        <c:forEach items="${template.summaryQuestions}" var="sq">
			        <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
			        	<c:if test="${g.active}">
			        		<c:forEach items="${g.questions}" var="q">
			        			<c:if test="${sq.id == q.id and q.active and q.visible}">
			        				<td><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
			        			</c:if>
			        			<c:if test="${!empty q.columns}">
			        				<c:forEach items="${q.columns}" var="childQ">
			        					<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
			        						<td><enviromanager:answer question="${childQ}" answers="${assessment.answers}" /></td>
			        					</c:if>
			        				</c:forEach>
			        			</c:if>
			        		</c:forEach>
			        	</c:if>
		        	</c:forEach>
		        </c:forEach>
	        </c:otherwise>
         </c:choose>
      	<%--<c:if test="${showAllRA}"> dont need this as the status header is always being showed--%>
        	<td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
        <%--</c:if>--%>
        <td><c:choose><c:when test="${assessment.template.multiApproval}"><ul><c:forEach items="${assessment.approvalUserList}" var="user"><li><c:out value="${user.displayName}" /></li></c:forEach></ul></c:when><c:otherwise><c:out value="${assessment.approvalByUser.displayName}" /></c:otherwise></c:choose></td><td><c:out value="${assessment.responsibleUser.displayName}" /></td>
        <c:choose><c:when test="${assessment.template.scorable}">
	        <c:if test="${not assessment.template.attachmentDriven}">
	        <td class="nowrap">
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
	        </c:if>
	       <c:if test="${assessment.template.attachmentDriven}">
	        <td class="nowrap">
			      <c:if test="${assessment.nrag != null && assessment.nrag != 'nocolor'}">
				      <c:choose>
			        	<c:when test="${assessment.template.multiApproval && assessment.status.name == 'TRASH'}"></c:when>
			        	<c:otherwise>
				      		<img src="<c:url value="/images/risk/score_${assessment.nrag}light.giff" />" />
				     	</c:otherwise>
				      </c:choose>
			      </c:if>
	        </td>
	        </c:if>
	        </c:when>
      		<c:when test="${template == null || (template != null && template.scorable)}">
	        	<td> &nbsp; </td>
	        </c:when>
        </c:choose>
        
        <td> 
			<fmt:formatDate value="${assessment.reviews[0].date}" pattern="dd-MM-yyyy" /><%--<c:out value="${assessment.reviews[0].date}" /> --%>
        </td>
        <c:if test="${showSiteColumn}">
        	<td> <c:out value="${assessment.site.name}" /> </td>
        </c:if>
        <c:if test="${showLegacyIds}">
        	<td> <c:out value="${assessment.legacyId}" /> </td>
        </c:if>
         <td class="printColumn"> 
          <a href="<c:out value="${assessmentURL}" />&printable=true" target="printWindow" ><img alt="Print" src="<c:url value="/images/print.gif" />"></a> <br>
        </td>
      </tr>