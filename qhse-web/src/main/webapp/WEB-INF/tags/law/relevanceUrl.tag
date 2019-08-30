<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="legislation" required="true" type="com.scannellsolutions.modules.law.domain.Legislation" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>
<%@ attribute name="text" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" >
	  <c:url value="rel${legislation.id}-${profile.registerType.id}.html" />
	</c:when> 
	<c:otherwise>
	  <c:url value="/law/relevance.htm">
	    <c:param name="legId" value="${legislation.id}" />
        <c:param name="profileId" value="${profile.id}" />
	    <c:param name="legRegister" value="${profile.registerType.id}" />
	    <c:param name="view" value="${viewType}" />
      </c:url>
	</c:otherwise>
</c:choose>
