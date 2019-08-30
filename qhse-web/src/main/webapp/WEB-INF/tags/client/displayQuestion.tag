<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="question" required="true" type="com.scannellsolutions.modules.system.domain.Question" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<li id="StandardQuestion-${question.id}" draggable="true" ondragstart="drag(event);" 
	class="items list-group-item  list-group-item-warning" value="${question.name}" 
	ondrop="drop(event, this)" ondragover="allowDrop(event)">
	&nbsp;
	<input type="hidden" class="mandatory" value="false"/>
	<client:questionImage questionType="${question.answerType}"/>
	${question.name}
</li>