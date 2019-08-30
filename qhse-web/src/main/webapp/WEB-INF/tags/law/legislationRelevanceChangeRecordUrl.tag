<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="legislation" required="true" type="java.lang.Object" %>
<%@ attribute name="registerType" required="true" type="com.scannellsolutions.modules.law.domain.RegisterType" %>
<%@ attribute name="contentVersion" required="true" type="java.lang.Object" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" >
	  <c:url value="rel${legislation.id}-${registerType.id}.html" />
	</c:when> 
	<c:otherwise>
      <c:url value="/law/relevance.htm">
        <c:param name="legId" value="${legislation.id}" />
        <c:param name="legRegister" value="${registerType.id}" />
        <c:param name="contentVersion" value="${contentVersion}" />
        <c:param name="profileId" value="${profile.id}" />
      </c:url>
	</c:otherwise>
</c:choose>
