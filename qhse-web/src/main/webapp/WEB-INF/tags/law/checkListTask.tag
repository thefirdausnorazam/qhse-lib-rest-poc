<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="checklist" required="true" type="com.scannellsolutions.modules.law.domain.Checklist" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<%@ tag import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@ tag import="com.scannellsolutions.modules.law.web.ProfileChecklistHelper"%>
<c:set var="tasks" value="<%=ProfileChecklistHelper.getChecklistTasks(checklist.getId(),profile)%>" />       
		<c:if test="${not empty tasks}">		 
		  <c:forEach items="${tasks}" var="task">
              <!--  <div><a href="<c:url value="/law/taskView.htm"><c:param name="id" value="${task.id}"/><c:param name="profileId" value="${profile.id}"/><c:param name="checklistId" value="${checklist.id}"/></c:url>"><c:out value="${task.displayId}"/> </a> <c:out value="${task.name} "/>(<fmt:message key="${task.status}" />)</div>-->
		   <div><a href="javascript:viewTask(${task.id})"><c:out value="${task.displayId}"/></a><c:out value=" ${task.name} "/> (<fmt:message key="${task.status}" />)</div>
		  </c:forEach>		
		</c:if>  
		<c:if test="${empty tasks}">
		<i class="fa fa-times"></i> &nbsp; <fmt:message key='none'/>
		</c:if>  
		 
