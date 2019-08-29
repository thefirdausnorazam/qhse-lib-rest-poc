<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ attribute name="fieldType" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<li id="${type}-${name}" draggable="true" ondragstart="drag(event);" 
	class="question items list-group-item    <c:choose><c:when test="${type == 'IncidentField'}">list-group-item-success</c:when><c:otherwise>list-group-item-info</c:otherwise></c:choose>"
	ondrop="drop(event, this)" ondragover="allowDrop(event)">
	&nbsp;
	<client:questionImage questionType="${fieldType}" questionName="${name}"/>
	<fmt:message key="${name}"/>
	<input type="hidden" class="mandatory" value="false"/>
</li>