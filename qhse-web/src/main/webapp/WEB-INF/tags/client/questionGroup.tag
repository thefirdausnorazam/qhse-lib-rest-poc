<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="group" required="true" type="com.scannellsolutions.modules.client.domain.ClientQuestionGroup" %>
<%@ attribute name="groupName" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>

<c:set var="groupDiv" value="g${group.id}"/>
<div id="${groupDiv}" class="questionGroup" ondrop="drop(event, this)" ondragover="allowDrop(event)" value="${group.name}">
	<h2 class="list-group-item-heading"><span class="edit-on-click"><c:out value="${group.name}"/></span><a href='#${groupName}' title='delete group' onclick='deleteGroup("${groupDiv}")' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a></h2>					             
	<ul id="group${group.id}" class="sortable" >
	<c:forEach var="q" items="${group.questions}" varStatus="loop">
		<client:question question="${q}" groupName="${groupName}"/>
 	</c:forEach>
    </ul>
</div>