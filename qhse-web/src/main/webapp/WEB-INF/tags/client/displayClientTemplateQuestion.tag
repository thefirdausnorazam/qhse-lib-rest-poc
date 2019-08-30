<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="templateQuestion" required="true" type="com.scannellsolutions.modules.client.domain.ClientTemplateQuestion" %>
<%@ attribute name="active" required="true" rtexprvalue="true" type="java.lang.Boolean" description="if inactive in site should display question in red" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<c:set var="question" value="${templateQuestion.question}"/>
	
<li
	class="items list-group-item <c:if test="${not active}">list-group-item-danger</c:if>" style="height:30px">
	&nbsp;
	<c:choose>
		<c:when test="${templateQuestion.type == null}">
			<client:questionImage questionType="${templateQuestion.fieldOptionType}" questionName="${templateQuestion.questionName}"/><fmt:message key="${templateQuestion.questionName}" />
		</c:when>
		<c:otherwise>
			<client:questionImage questionType="${question.optionType}"/>${question.name}
		</c:otherwise>
	</c:choose>
</li>