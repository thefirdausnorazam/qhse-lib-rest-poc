<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"  %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String" description="field name, also used as label code" %>
<%@ attribute name="when" required="false" rtexprvalue="true" type="java.lang.Boolean" description="only display if this evaluates to true (or null)" %>
<%@ attribute name="confidential" required="false" rtexprvalue="true" type="java.lang.Boolean" description="'Confidential' to replace text" %>
<%@ attribute name="whenNotNull" required="false" rtexprvalue="true" type="java.lang.Boolean" description="only display if this is true and the value is not null" %>
<%@ attribute name="noHtml" required="false" rtexprvalue="true" type="java.lang.Boolean" description="don't render any tr/label/td around the value"  %>
<%@ attribute name="labelOverride" required="false" rtexprvalue="true" type="java.lang.String" description="use if field name is not the correct label code" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="notConfigured" value="${incidentAvailableActiveFieldsByName[name] == null}" />
<c:set var="fieldValue" value="${incident[name]}" />
<!-- always show existing fields if they have a value -->

<c:set var="displayed" value="${notConfigured && (fieldValue != null && fieldValue != '') && not empty fieldValue}" />

<c:set var="label" value="${name}" />
<c:if test="${labelOverride != null}">
  <c:set var="label" value="${labelOverride}" />
</c:if>

<c:choose>
<c:when test="${displayed and when != false and (whenNotNull != true or fieldValue != null)}">
  <c:set var="fieldValue" scope="request" value="${fieldValue}" />

	<c:choose>
	<c:when test="${noHtml == true}">
	  <jsp:doBody />
	</c:when>
	<c:otherwise>
	<tr>
	  <td class=""><fmt:message key="${label}" /></td>
	  <td><jsp:doBody /> </td>
	</tr>
	</c:otherwise>
	</c:choose>
</c:when>
<c:when test="${confidential and displayed and (fieldValue != null and not empty fieldValue)}">
	<tr>
	  <td class=""><fmt:message key="${label}" /></td>
	  <td><font color="red"><c:out value="CONFIDENTIAL"/></font></td>
	</tr>
</c:when>
</c:choose>