<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ attribute name="showActiveOnly" required="true" rtexprvalue="true" type="java.lang.Boolean" %>


	<div class="content">
		<c:if test="${!showActiveOnly}">
			<h2 style="color: red; font-weight: bold"><span class="nowrap"><fmt:message key="doccontrol.hierarchy.showInactiveGroups" /></span></h2>
		</c:if>
		<c:if test="${showActiveOnly}">
			<div class="row">
				<label style="padding-left:1em;"><fmt:message key="doccontrol.showDocuments" /></label>
				<input class="switch bootSwitch" data-size="small" type="checkbox" <c:if test="${showDocuments}">checked</c:if>>
			</div>
		</c:if>	
	</div>