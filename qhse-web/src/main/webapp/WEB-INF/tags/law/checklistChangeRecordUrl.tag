<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="checklist" required="true" type="java.lang.Object" %>
<%@ attribute name="registerType" required="true" type="com.scannellsolutions.modules.law.domain.RegisterType" %>
<%@ attribute name="contentVersion" required="true" type="java.lang.Object" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" >
	  <c:url value="chk${checklist.id}-${registerType.id}.html" />
	</c:when> 
	<c:otherwise>
      <c:url value="/law/checklists.htm">
        <c:param name="chklistId" value="${checklist.id}" />
        <c:param name="profileId" value="${profile.id}" />
        <c:param name="legRegister" value="${registerType.id}" />
        <c:param name="contentVersion" value="${contentVersion}" />
      </c:url>
	</c:otherwise>
</c:choose>
