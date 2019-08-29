<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="legislation" required="true" type="com.scannellsolutions.modules.law.domain.Legislation" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>
<%@ attribute name="text" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>




 <%-- <div class="col-sm-10">
  <a href="<law:legislationUrl legislation="${legislation}" profile="${profile}" viewType="${viewType}" />">
<c:choose>
	<c:when test="${empty text}">	
	<c:out value="${legislation.name}" escapeXml="false" /> <br> </c:when>
	<c:otherwise>${text} <br> </c:otherwise>
</c:choose>
</a> 

<c:if test="${empty text}"><law:legislationAltNames legislation="${legislation}" /></c:if>
</div> --%> 

<a href="<law:legislationUrl legislation="${legislation}" profile="${profile}" viewType="${viewType}" />">
<c:choose>
	<c:when test="${empty text}"><c:out value="${legislation.name}" escapeXml="false" /> <br> </c:when>
	<c:otherwise>${text} <br> </c:otherwise>
</c:choose>
</a>
<c:if test="${empty text}"><law:legislationAltNames legislation="${legislation}" /></c:if>