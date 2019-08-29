<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="question" required="true" type="com.scannellsolutions.modules.client.domain.ClientQuestion" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<li id="ClientQuestion-${question.id}" draggable="true" ondragstart="drag(event);" 
	class="question items list-group-item  list-group-item-warning"  
	ondrop="drop(event, this)" ondragover="allowDrop(event)"><client:questionImage questionType="${question.answerType}"/>${question.name}<c:if test="${question.required}"><span class="requiredHinted">*</span></c:if>
	<input type="hidden" class="mandatory" value="${question.required}"/>
	<input type="hidden" class="questionType" value="${question.answerType}"/>
</li>