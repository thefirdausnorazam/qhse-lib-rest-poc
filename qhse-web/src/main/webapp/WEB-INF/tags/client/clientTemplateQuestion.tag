<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="templateQuestion" required="true" type="com.scannellsolutions.modules.client.domain.ClientTemplateQuestion" %>
<%@ attribute name="groupName" required="true" type="java.lang.String" %>
<%@ attribute name="questionIndex" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<c:set var="question" value="${templateQuestion.question}"/>

<li id="${templateQuestion.id}" draggable="true" ondragstart="drag(event);" 
	class="items list-group-item" value="${question.name}" 
	ondrop="drop(event, this)" ondragover="allowDrop(event)" ondragenter="allowDrop(event)" style="height:30px">
	&nbsp;
	<input style="display:none" type="text" class="questionId" name="${groupName}.questions[${questionIndex}].id" value="${templateQuestion.id}"/>
	<input style="display:none" type="text" class="questionQuestionName" name="${groupName}.questions[${questionIndex}].questionName" value="${templateQuestion.questionName}"/>
	<input style="display:none" type="text" class="questionType" name="${groupName}.questions[${questionIndex}].type" value="${templateQuestion.type}"/>
	<input style="display:none" type="text" class="questionOrder" name="${groupName}.questions[${questionIndex}].questionOrder"/>
	<c:choose>
		<c:when test="${templateQuestion.type == null}">
			<input style="display:none" type="text" class="questionQuestionId"  name="${groupName}.questions[${questionIndex}].questionId" value="0"/>
		</c:when>
		<c:otherwise>
			<input style="display:none" type="text" class="questionQuestionId" name="${groupName}.questions[${questionIndex}].questionId" value="${templateQuestion.questionId}"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${templateQuestion.type == null or templateQuestion.type ==''}">
			<client:questionImage questionType="${templateQuestion.fieldOptionType}" questionName="${templateQuestion.questionName}"/><fmt:message key="${templateQuestion.questionName}" />
		</c:when>
		<c:when test="${templateQuestion.incidentField}">
			<client:questionImage questionType="${templateQuestion.fieldOptionType}" questionName="${templateQuestion.questionName}"/><fmt:message key="${templateQuestion.questionName}" />
		</c:when>
		<c:otherwise>
			<client:questionImage questionType="${question.optionType}" questionName=""/>${question.name}
		</c:otherwise>
	</c:choose>
	<c:if test="${templateQuestion.questionName != 'department' && templateQuestion.questionName != 'causeCategory'}"><a href="#${groupName}" title='delete' class='itemDelete' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a></c:if>&nbsp;<a title='edit' class='itemEdit' style='float:right;padding-right:2%;'><span class='glyphicon glyphicon-pencil'></span></a>
	<div class="checkboxes" style="display:none">
		<c:choose>
			<c:when test="${question.answerType == 'QuestionAnswerType[checkbox]' || templateQuestion.questionName == 'processSafety'}">
				<input type="hidden" class="questionMandatory" name="${groupName}.questions[${questionIndex}].mandatory" value="false"/>
			</c:when>
			<c:when test="${templateQuestion.questionName == 'department' || templateQuestion.questionName == 'causeCategory'}">
				<input type="hidden" class="questionMandatory" name="${groupName}.questions[${questionIndex}].mandatory" value="true"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="x" checked="checked" disabled="disabled"/> <fmt:message key="clientQuestionMandatory" />	<br/>	
			</c:when>
			<c:otherwise>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionMandatory" name="${groupName}.questions[${questionIndex}].mandatory"  <c:if test="${templateQuestion.mandatory}">checked="checked"</c:if>/> <fmt:message key="clientQuestionMandatory" />	<br/>	
			</c:otherwise>
		</c:choose>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionSearchable" <c:if test="${templateQuestion.questionName == 'department'}">disabled="disabled" checked="checked"</c:if> name="${groupName}.questions[${questionIndex}].searchable"  <c:if test="${templateQuestion.searchable}">checked="checked"</c:if>/> <fmt:message key="clientQuestionSearchable" />
		<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionExportable" name="${groupName}.questions[${questionIndex}].exportable"  <c:if test="${templateQuestion.exportable}">checked="checked"</c:if>/> <fmt:message key="clientQuestionExportable" />
	</div>
</li>