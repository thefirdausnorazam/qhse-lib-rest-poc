<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="docStatus" required="true" type="com.scannellsolutions.modules.doccontrol.domain.DocumentStatus"%>
<%@ attribute name="foundReviews" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>

<c:choose>
			<c:when test="${docStatus == 'DocumentStatus[DRAFT]'}">	
				<c:set var="draftProgress" value="done"/>
				<c:choose>
					<c:when test="${foundReviews}">
						<c:set var="reviewBar" value=""/>
						<c:set var="reviewProgress" value=""/>
					</c:when>
					<c:otherwise>
						<c:set var="reviewBar" value="half"/>
						<c:set var="reviewProgress" value="active"/>
					</c:otherwise>
				</c:choose>
				<c:set var="approvedBar" value=""/>
				<c:set var="approvedProgress" value=""/>
				<c:set var="distributedBar" value=""/>
				<c:set var="distributedProgress" value=""/>
			</c:when>
			<c:when test="${docStatus == 'DocumentStatus[REVIEW]'}">	
				<c:set var="draftProgress" value="done"/>
				<c:set var="reviewBar" value="done"/>
				<c:set var="reviewProgress" value="done"/>
				<c:set var="approvedBar" value="half"/>
				<c:set var="approvedProgress" value="active"/>
				<c:set var="distributedBar" value=""/>
				<c:set var="distributedProgress" value=""/>
			</c:when>
			<c:when test="${docStatus == 'DocumentStatus[APPROVED]'}">	
				<c:set var="draftProgress" value="done"/>
				<c:set var="reviewBar" value="done"/>
				<c:set var="reviewProgress" value="done"/>
				<c:set var="approvedBar" value="done"/>
				<c:set var="approvedProgress" value="done"/>
				<c:set var="distributedBar" value="half"/>
				<c:set var="distributedProgress" value="active"/>
			</c:when>
			<c:when test="${docStatus == 'DocumentStatus[DISTRIBUTED]'}">	
				<c:set var="draftProgress" value="done"/>
				<c:set var="reviewBar" value="done"/>
				<c:set var="reviewProgress" value="done"/>
				<c:set var="approvedProgress" value="done"/>
				<c:set var="approvedBar" value="done"/>
				<c:set var="distributedBar" value="done"/>
				<c:set var="distributedProgress" value="done"/>
			</c:when>
		</c:choose>
		
			<div class="progress" style="min-height:80px;">
				  <div class="circle ${draftProgress}">
				    <span class="label"></span>
				    <span class="title"><fmt:message key="doccontrol.progress.draft"/></span>
				  </div>
				  <span class="bar ${reviewBar}"></span>
				  <div class="circle  ${reviewProgress}">
				    <span class="label"></span>
				    <span class="title" style="margin-left:-25px"><fmt:message key="doccontrol.progress.reviewed"/></span>
				  </div>
				  <span class="bar ${approvedBar}"></span>
				  <div class="circle ${approvedProgress}">
				    <span class="label"></span>
				    <span class="title" style="margin-left:-25px"><fmt:message key="doccontrol.progress.approved"/></span>
				  </div>
				  <span class="bar ${distributedBar}"></span>
				  <div class="circle ${distributedProgress}">
				    <span class="label"></span>
				    <span class="title" style="margin-left:-30px"><fmt:message key="doccontrol.progress.distributed"/></span>
				  </div>
			 </div>
			 
