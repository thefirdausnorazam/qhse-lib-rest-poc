<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident" %>
<%@ taglib prefix="client" tagdir="/WEB-INF/tags/client" %>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>


<!DOCTYPE html>
<html>
<head>
<style type="text/css" media="all">
@import "<c:url value='/css/incident.css'/>";
</style>
<style type="text/css">
	td.searchLabel {
		padding-left: 0px !important;
		padding-right: 5%!important;
	}
	.list-group-item {
		padding-bottom: 30px;
	}
</style>
	<script type="text/javascript">
		function toggle(source) {
		  checkboxes = document.getElementsByName('activeInSites');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }

		}
   	</script>
<title></title>
</head>
<body>
<div class="header">
<h3><fmt:message key="configureQuestionSites"/> : <fmt:message key="${incidentType.key}"/></h3>
</div>
<c:set var="count" value="0" scope="page" />

<div class="content">
	<div class="table-responsive">
		<div class="panel panel-body">
			<div><h4><fmt:message key="incident.fields" />:</h4></div>
      		<div id="incidentQuestionGroups"  class="incidentQuestionGroups" style="height:100%;width:100%">
      			<c:if test="${!empty incidentType.incidentQuestionGroups}">
	      			<c:forEach var="group" items="${incidentType.incidentQuestionGroups}" varStatus="s">
						<div class="questionGroup">					
							<c:out value="${group.name}"/>	
							<ul>		
								<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
									<client:displayClientTemplateQuestionSettings templateQuestion="${templateQuestion}" typeId="${incidentType.id}"/>
							 	</c:forEach>
						    </ul>
						</div>
			         </c:forEach>
		         </c:if>
      		</div>
	      	<c:if test="${!empty incidentType.investigationQuestionGroups}">
	      		<div><fmt:message key="investigation" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" <c:if test="${incidentType.investigationConfigured == 'true'}">checked="checked"</c:if> disabled/></div>
	      		<div><h4><fmt:message key="investigation.fields" />:</h4></div>
	      		<div id="investigationQuestionGroups"  class="investigationQuestionGroups"  style="height:100%;width:100%">
      				<c:if test="${!empty incidentType.investigationQuestionGroups}">
		      			<c:forEach var="group" items="${incidentType.investigationQuestionGroups}" varStatus="s">
							<div class="questionGroup">		
								<c:out value="${group.name}"/>	
								<ul>						
									<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
										<client:displayClientTemplateQuestionSettings templateQuestion="${templateQuestion}" typeId="${incidentType.id}"/>
								 	</c:forEach>
							    </ul>
							</div>
				         </c:forEach>
			         </c:if>
	      		</div>
      		</c:if>
		</div>
	</div>
</div>
</body>
</html>
