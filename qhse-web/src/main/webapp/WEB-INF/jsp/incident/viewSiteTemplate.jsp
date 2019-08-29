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
<title></title>
</head>
<body>
<div class="header">
<h3><fmt:message key="viewTemplateSites"/> : <fmt:message key="${incidentType.key}"/></h3>
</div>
<c:set var="count" value="0" scope="page" />

<div class="content">
	<c:forEach items="${sites}" var="site" >
		<div class="panel-group accordion  accordion-semi" id="accordion${count}">
			<div class="acc-panel-heading">
				<h4 class="panel-title ui-state-active">
                     <a class="collapsed acc panelHover" data-toggle="collapse"
                        data-parent="#accordion${count}" href="#${count}">
                        <i class="fa fa-angle-right"></i> 
                           <c:out value="${site}"/>
                     </a>
                  </h4>
				<div  id="${count}" class="content panel-collapse collapse out">
					<div class="table-responsive">
						<div class="panel panel-body"><c:set var="siteActiveList" value="${siteList[site.name]}"/>
							<div><h4><fmt:message key="incident.fields" />:</h4></div>
				      		<div id="incidentQuestionGroups"  class="incidentQuestionGroups" style="height:100%;width:100%">
				      			<c:if test="${!empty incidentType.incidentQuestionGroups}">
					      			<c:forEach var="group" items="${incidentType.incidentQuestionGroups}" varStatus="s">
										<div class="questionGroup">					
											<c:out value="${group.name}"/>	
											<ul>		
												<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
													<client:displayClientTemplateQuestion templateQuestion="${templateQuestion}" active="${enviromanager:contains(siteActiveList,templateQuestion.id)}"/>
											 	</c:forEach>
										    </ul>
										</div>
							         </c:forEach>
						         </c:if>
				      		</div>
					      	<c:if test="${!empty incidentType.investigationQuestionGroups}">
					      		<div><fmt:message key="investigation" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" <c:if test="${incidentType.investigationConfigured == 'true'}">checked="checked"</c:if> disabled/></div>
					      		<div><h4><fmt:message key="investigation.fields" />:</h4></div>
					      		<div id="investigationQuestionGroups"  class="investigationQuestionGroups" style="height:100%;width:100%">
					      			<c:forEach var="group" items="${incidentType.investigationQuestionGroups}" varStatus="s">
										<div class="questionGroup">		
											<c:out value="${group.name}"/>	
											<ul>						
												<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
													<client:displayClientTemplateQuestion templateQuestion="${templateQuestion}" active="${enviromanager:contains(siteActiveList,templateQuestion.id)}"/>
											 	</c:forEach>
										    </ul>
										</div>
							         </c:forEach>
					      		</div>
				      		</c:if>
      					</div>
      				</div>
				</div>
			</div>
		</div>
		<c:set var="count" value="${count + 1}" scope="page"/>
	</c:forEach>
</div>
</body>
</html>
