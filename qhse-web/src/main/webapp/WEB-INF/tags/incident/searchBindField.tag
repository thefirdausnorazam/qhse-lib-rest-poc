<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"  %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="labelOverride" required="false" rtexprvalue="true" type="java.lang.String"  %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String"  %>
<%@ attribute name="displayType" required="false" rtexprvalue="true" type="java.lang.Integer"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="configured" value="${incidentAvailableFieldsByName[name] != null}" />
<!-- always show existing fields if they have a value -->


<c:set var="label" value="${name}" />
<c:if test="${labelOverride != null}">
  <c:set var="label" value="${labelOverride}" />
</c:if>

<c:if test="${configured}">
    <td class="searchLabel"><fmt:message key="${label}" /></td>
    <td class="search">
      <c:choose>
      	<c:when test="${displayType == 0}">
      	    <td class="searchLabel"><label for="${name}"><fmt:message key="${name}" /></label></td>
    		<td class="search"><input type="text" id="${name}" name="${name}" /></td>
      	</c:when>
      	<c:when test="${displayType == 1}">
      		<select id="${name}" name="incidentSource" class="autoWidth">
		        <option></option>
		        <c:forEach items="${name}List" var="item">
		        <c:if test="${item.active}">
		          <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
		        </c:if>
		        </c:forEach>
		    </select>
      	</c:when>
      	<c:when test="${displayType == 2}">
      	      <input type="text" id="${name}" name="${name}" size="15" readonly="readonly">
      		  <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, '${name}', true);">
      	</c:when>
      </c:choose>
     </td>
</c:if>
