<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="changeAssessment.technicalCloseout.title" /></title>
</head>
<body>

<scannell:form>
<c:forEach items="${command.change.programme.type.questionGroups}" var="group" varStatus="h">
<c:if test="${!empty group.questions}">
	<c:if test="${group.codeName == 'change.programeeTypeQuestionGroup.technical' }">
	
		<table class="viewForm">
		<col class="label" />
		<thead>
			<tr>
				<td colspan="4"><c:out value="${group.name}"/></td>
			</tr>
		</thead>
		<tbody>			
		<c:forEach items="${group.questions}" var="q" varStatus="s">
			<c:if test="${s.first}"><tr></c:if>
			<c:if test="${q.active and q.visible}">
				<c:choose>
					<c:when test="${q.answerType.name == 'label'}">
						<td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
					</c:when>
					<c:otherwise>	
						<td width="80%" class="label"><b><c:out value="${q.name}" />:</td>
						<td> <enviromanager:question path="change.answers" question="${q}" emptyOptionLabel="Choose" /></td>
					</c:otherwise>
				</c:choose>		
			</c:if>
			<tr/>
			<c:if test="${s.last}"></tr></c:if>
		</c:forEach>	
		</tbody>
		<c:if test="${h.last}">
		<tfoot>
			<tr>
				<td colspan="4" align="center">
					<c:url var="cancelURL" value="/change/changeAssessmentView.htm"><c:param name="id" value="${command.change.id}"/></c:url>						    		
					<input id="save" type="submit" value="<fmt:message key="submit" />">					
					<input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">							
				</td>
			</tr>
		</tfoot>					
		</c:if>
		</table>
		</c:if>
</c:if>
</c:forEach>


</scannell:form>

</body>
</html>
