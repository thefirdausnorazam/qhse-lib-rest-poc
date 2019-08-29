<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="templateQuestion" required="true" type="com.scannellsolutions.modules.client.domain.ClientTemplateQuestion" %>
<%@ attribute name="typeId" required="true" type="java.lang.Long" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<c:set var="question" value="${templateQuestion.question}"/>
<li
	class="items list-group-item" style="height:30px">
	&nbsp;
	<c:choose>
		<c:when test="${templateQuestion.type == null}">
			<client:questionImage questionType="${templateQuestion.fieldOptionType}"  questionName="${templateQuestion.questionName}"/><fmt:message key="${templateQuestion.questionName}" />
		</c:when>
		<c:otherwise>
			<client:questionImage questionType="${question.optionType}"/>${question.name}
		</c:otherwise>
	</c:choose>
	<c:if test="${templateQuestion.questionName != 'department' && templateQuestion.questionName != 'causeCategory'}">
		<a title='Configure Question Site' href="<c:url value="configureTemplateQuestionSites.htm"><c:param name="showId" value="${templateQuestion.id}" /><c:param name="typeId" value="${typeId}" /></c:url>" style='float:right;padding-right:2%;'><span class='glyphicon glyphicon-cog'></span></a>
	</c:if>
</li>