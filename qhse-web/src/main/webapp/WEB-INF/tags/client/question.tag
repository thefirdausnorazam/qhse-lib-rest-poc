<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="question" required="true" type="com.scannellsolutions.modules.system.domain.Question" %>
<%@ attribute name="groupName" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
 		
<li id="common-${question.id}" draggable="true" ondragstart="drag(event);" 
	class="list-group-item  list-group-item-success" value="${question.name}" 
	ondrop="drop(event, this)" ondragover="allowDrop(event)">
	&nbsp;
	<c:choose>
		<c:when test="${question.answerType == 'QuestionAnswerType[option]'}"><span class="glyphicon glyphicon-option-horizontal" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[option-multi-choice]'}"><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[integer]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[float]'}"><span class="gglyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[double]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[text]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[textarea]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[label]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[date]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[datetime]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[table]'}"><span class="glyphicon glyphicon-th-large" aria-hidden="true"></span></c:when>
		<c:when test="${question.answerType == 'QuestionAnswerType[sub-table]'}"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></c:when>
		<c:otherwise><span class="glyphicon glyphicon-search" aria-hidden="true"></span></c:otherwise>
	</c:choose>
	${question.name}
</li>