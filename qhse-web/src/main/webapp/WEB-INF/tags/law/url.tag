<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ attribute name="modifiedTime" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:choose>
	<c:when test="${param['cgen'] == 'true'}" ><scannell:resource value="resources${value}" modifiedTimeParameter="${modifiedTime == 'true'}" /></c:when> 
	<c:otherwise><scannell:resource value="${value}" modifiedTimeParameter="${modifiedTime == 'true'}" /></c:otherwise>
</c:choose>
