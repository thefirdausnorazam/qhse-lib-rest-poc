<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"%>
<%@ attribute name="editable" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="site" required="true" rtexprvalue="true" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:choose>
	<c:when test="${editable}">
		<jsp:doBody />
	</c:when>
	<c:otherwise>
		<fmt:message key="${name}" />&nbsp;
		<fmt:message key="notCurrentSelectedSiteMsg">
			<fmt:param value="${site}" />
		</fmt:message>
	</c:otherwise>
</c:choose>