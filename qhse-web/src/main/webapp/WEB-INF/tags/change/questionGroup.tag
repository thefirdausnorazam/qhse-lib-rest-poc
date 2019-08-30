<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="group" required="true" type="com.scannellsolutions.modules.change.domain.ChangeQuestionGroup" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="change" tagdir="/WEB-INF/tags/change" %>

<div id="g${group.id}" class="questionGroup" ondrop="drop(event, this)" ondragover="allowDrop(event)" value="${group.name}">
	<h2 class="list-group-item-heading"><span class="edit-on-click"><c:out value="${group.name}"/></span><a href="#" title="delete group" onclick="deleteGroup('g${group.id}')" style="float:right;">X</a></h2>					             
	<ul id="group${group.id}" class="sortable" >
	<c:forEach var="q" items="${group.questions}">
 		<change:question question="${q}" displayId="${q.displayId}"/>
 	</c:forEach>
    </ul>
</div>