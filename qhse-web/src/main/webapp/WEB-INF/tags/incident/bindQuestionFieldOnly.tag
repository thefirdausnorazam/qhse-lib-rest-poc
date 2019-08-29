<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"  %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="question" required="true" rtexprvalue="true" type="com.scannellsolutions.modules.system.domain.Question" %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String"  %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="configured" value="${incidentAvailableFieldsByName[name] != null}" />
<c:set var="fieldValue" value="${command.incident[name]}" />
<c:set var="q" value="${question}" />
<!-- always show existing fields if they have a value -->
<c:set var="displayed" value="${configured || (fieldValue != null && fieldValue != '' && not empty fieldValue)}" />

<c:if test="${displayed}">
<c:choose>
  <c:when test="${q != null and q.active and q.visible}">
      <spring:bind path="${name}">
      	<div class="col-sm-2">
	        <jsp:doBody />
        </div>
      </spring:bind>
  </c:when>
</c:choose>
</c:if>
