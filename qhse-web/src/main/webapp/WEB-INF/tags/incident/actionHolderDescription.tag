<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="holder" required="true" rtexprvalue="true" type="com.scannellsolutions.modules.action.domain.ActionHolder" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<c:choose>
	<c:when test="${fn:startsWith(holder.owner['class'].name, 'com.scannellsolutions.modules.audit.domain.AuditExpress')}" >
	  <scannell:text value="${holder.owner.programme.type.name}" />
	</c:when> 
	<c:otherwise>
		<c:choose>
	        <c:when test="${holder.owner['class'].name == 'com.scannellsolutions.modules.incident.domain.Incident' && holder.owner.confidential}">
	        	<c:choose>
	        		<c:when test="${holder.owner.type.type.confidentialDescription}">
	        			<font color="red"><c:out value="CONFIDENTIAL"/></font>
	        		</c:when>
	        		<c:otherwise>
	        			<scannell:text value="${holder.owner.description}" />
	        		</c:otherwise>
	        	</c:choose>
	        </c:when>
	        <c:otherwise>
	        	<scannell:text value="${holder.owner.description}" />
	        </c:otherwise>
	    </c:choose>
				
	</c:otherwise>
</c:choose>
