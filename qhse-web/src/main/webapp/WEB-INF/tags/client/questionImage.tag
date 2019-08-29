<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="questionType" required="true" type="java.lang.String" %>
<%@ attribute name="questionName" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 &nbsp;
<c:choose>
	<c:when test="${questionType == ''}">
		<c:choose>
			<c:when test="${questionName == 'durationForm'}"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'causeCategory'}"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'reportable'}"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'numberManDaysLost'}"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'operatingHoursLost'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'areaOwner'}"><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'investigationAppByAreaOwner'}"><span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span></c:when>
			<c:when test="${questionName == 'areaOwnerComments'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:otherwise><span class="glyphicon glyphicon-search" aria-hidden="true"></span></c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${questionType == 'QuestionAnswerType[option]'}"><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[option-multi-choice]'}"><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[integer]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[float]'}"><span class="gglyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[double]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[text]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[textarea]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[label]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[date]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[datetime]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[table]'}"><span class="glyphicon glyphicon-th-large" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[checkbox]'}"><span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'QuestionAnswerType[sub-table]'}"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'TEXT'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'TEXTAREA'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'LIST'}"><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'DATE'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'NONE'}"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></c:when>
			<c:when test="${questionType == 'USERLIST'}"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></c:when>
			<c:otherwise><span class="glyphicon glyphicon-search" aria-hidden="true"></span></c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>&nbsp;
