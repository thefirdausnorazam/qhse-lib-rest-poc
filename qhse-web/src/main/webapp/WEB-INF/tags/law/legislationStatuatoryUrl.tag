<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="legislation" required="true" type="com.scannellsolutions.modules.law.domain.Legislation" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" >
	  <c:url value="leg${legislation.id}-${profile.registerType.id}.html" />
	</c:when> 
	<c:otherwise>
      <c:url value="/law/legislation.htmf">
        <c:param name="legId" value="${legislation.id}" />
        <c:choose>
	        <c:when test="${profile != null}">
		        <c:param name="profileId" value="${profile.id}" />
		        <c:param name="legRegister" value="${profile.registerType.id}" />
	        </c:when>
	        <c:otherwise>
		        <c:param name="profileId" value="0" />
	        </c:otherwise>
        </c:choose>
        <c:param name="view" value="${viewType}" />
      </c:url>
	</c:otherwise>
</c:choose>
