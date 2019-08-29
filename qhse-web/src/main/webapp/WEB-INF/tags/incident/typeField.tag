<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String" description="field name, also used as label code" %>
<%@ attribute name="type" required="true" rtexprvalue="true" type="java.lang.String" description="field name, also used as label code" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<li id="field-$name}" draggable="true" ondragstart="drag(event);" 
	class="list-group-item  list-group-item-success" value="${name}" 
	ondrop="drop(event, this)" ondragover="allowDrop(event)">
	&nbsp;TEXT, LIST, DATE, NONE, USERLIST
	<c:choose>
		<c:when test="${type == 'FieldType[TEXT]'}"><span class="glyphicon glyphicon-text-size" aria-hidden="true"></span></c:when>
		<c:when test="${type == 'FieldType[LIST]'}"><span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span></c:when>
		<c:when test="${type == 'FieldType[DATE]'}"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></c:when>
		<c:when test="${type == 'FieldType[NONE]'}"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></c:when>
		<c:when test="${type == 'FieldType[USERLIST]'}"><span class="gglyphicon glyphicon-option-vertical" aria-hidden="true"></span></c:when>
		<c:otherwise><span class="glyphicon glyphicon-search" aria-hidden="true"></span></c:otherwise>
	</c:choose>
	${name}
</li>