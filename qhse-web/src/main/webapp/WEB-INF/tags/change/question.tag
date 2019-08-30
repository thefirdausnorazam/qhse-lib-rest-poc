<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="question" required="true" type="com.scannellsolutions.modules.change.domain.ChangeTemplateQuestion" %>
<%@ attribute name="displayId" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<li id="${displayId}" 
	draggable="true" ondragstart="drag(event);" ondrop="drop(event, this)" ondragover="allowDrop(event)"
	class="question list-group-item  list-group-item-warning" value="${question.displayName}" >
	&nbsp;
	<c:choose>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[option]'}"><span class="glyphicon glyphicon-option-horizontal" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[option-multi-choice]'}"><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[integer]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[float]'}"><span class="gglyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[double]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[text]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[textarea]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[label]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[date]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[datetime]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[table]'}"><span class="glyphicon glyphicon-th-large" aria-hidden="true"></span></c:when>
		<c:when test="${question.question.answerType == 'QuestionAnswerType[sub-table]'}"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></c:when>
		<c:otherwise><span class="glyphicon glyphicon-search" aria-hidden="true"></span></c:otherwise>
	</c:choose>
	${question.question.name}
	<c:if test="${question.mandatory}">
		&nbsp;&nbsp;&nbsp;&nbsp;<span class="requiredHinted">*</span>
	</c:if>
	<a href="#" title="delete question" class="itemDelete" style="float:right;">X</a>
</li>