<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="keyword" required="true" type="com.scannellsolutions.modules.law.domain.Keyword" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" >
	  <c:url value="kwd${keyword.id}-${profile.registerType.id}.html" />
	</c:when> 
	<c:otherwise>
      <c:url value="/law/keyword.htm">
        <c:param name="id" value="${keyword.id}" />
        <c:param name="legRegister" value="${profile.registerType.id}" />
        <c:param name="profileId" value="${profile.id}" />
      </c:url>
	</c:otherwise>
</c:choose>
