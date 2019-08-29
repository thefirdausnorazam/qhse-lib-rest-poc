<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script> 
</head>
<body> 
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<common:moveSite recordType="audit"/>
<c:set var="progLabel"><fmt:message key="auditProgramme"/></c:set>

	<div class="content">
		<c:set var="found" value="${!empty programmes}" />
		<a name="programmes"></a>
		<div class="header">
			<h3>
				<fmt:message key="programmes" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
				<c:choose>
			        <c:when test="${!found}">
			        	<table class="table table-bordered  table-responsive dataTable">
			        	<thead>	
								<tr>
									<th style="width: 30px"><fmt:message key="id" /></th>
									<th><fmt:message key="auditPlan" /></th>
									<th><fmt:message key="type" /></th>
									<th><fmt:message key="percentCompleted" /></th>
									<th><fmt:message key="reviewDate" /></th>
								</tr>
						</thead>
			        	</table>
			        </c:when>
		        <c:otherwise>
					<c:forEach items="${programmeSites}" var="site" varStatus="p">
						<table class="table table-bordered table-responsive dataTable">
						<c:if test="${found}">
	  						<caption><c:out value="${site}" /></caption>
	  						<thead>	
									<tr>
										<th style="width: 30px"><fmt:message key="id" /></th>
										<th><fmt:message key="auditPlan" /></th>
										<th><fmt:message key="type" /></th>
										<th><fmt:message key="percentCompleted" /></th>
										<th><fmt:message key="reviewDate" /></th>
									</tr>
							</thead>
		
							<tbody>
		
							<c:forEach items="${programmes}" var="programme" varStatus="s">
								<c:if test="${programme.plan.site.id == site.id}">
									<c:choose>
										<c:when test="${s.index mod 2 == 0}">
											<c:set var="style" value="even" />
										</c:when>
										<c:otherwise>
											<c:set var="style" value="odd" />
										</c:otherwise>
									</c:choose>
									<tr class="<c:out value="${style}" />">
										<td><a href="#"
												onclick='changeSite("<c:url value="programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>", ${programme.site.id}, "${programme.site}", ${currentSite}, "${progLabel}")' >
												<c:out value="${programme.id}" />
											</a></td>
										<td><c:out value="${programme.plan.displayName}" /></td>
										<td><c:out value="${programme.type.name}" /></td>
										<td><c:out value="${programme.percentCompleted}%" /></td>
										<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
						</c:if>
						</table>
					</c:forEach>
				
				</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>

		<a name="audits"></a>
		<c:set var="found" value="${!empty audits}" />
		<div class="header">
			<h3>
				<fmt:message key="audits" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
				<c:choose>
			        <c:when test="${!found}">
			        	<table class="table table-bordered  table-responsive dataTable">
			        	<thead>
								<tr>
									<th style="width: 30px"><fmt:message key="id" /></th>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="leadAuditor" /></th>
									<th><fmt:message key="auditee" /></th>
									<th><fmt:message key="location" /></th>
									<th><fmt:message key="startTime" /></th>
									<th><fmt:message key="percentCompleted" /></th>
								</tr>
						</thead>
			        	</table>
			        </c:when>
		        <c:otherwise>
						<c:forEach items="${auditSites}" var="site" varStatus="p">
							<table class="table table-bordered table-responsive dataTable">
								<c:if test="${found}">
									<caption><c:out value="${site}" /></caption>
									<thead>
										<tr>
											<th style="width: 30px"><fmt:message key="id" /></th>
											<th><fmt:message key="name" /></th>
											<th><fmt:message key="leadAuditor" /></th>
											<th><fmt:message key="auditee" /></th>
											<th><fmt:message key="location" /></th>
											<th><fmt:message key="startTime" /></th>
											<th><fmt:message key="percentCompleted" /></th>
										</tr>
									</thead>
								</c:if>
								<tbody>
		
									<c:forEach items="${audits}" var="audit" varStatus="s">
										<c:if test="${audit.programme.plan.site.id == site.id}">
											<c:choose>
												<c:when test="${s.index mod 2 == 0}">
													<c:set var="style" value="even" />
												</c:when>
												<c:otherwise>
													<c:set var="style" value="odd" />
												</c:otherwise>
											</c:choose>
											<tr class="<c:out value="${style}" />">
												<td><a href="#"
														onclick='changeSite("<c:url value="auditView.htm"><c:param name="id" value="${audit.id}"/></c:url>", ${audit.site.id}, "${audit.site}", ${currentSite})'>
														<c:out value="${audit.id}" />
													</a></td>
												<td><c:out value="${audit.name}" /></td>
												<td><c:out value="${audit.leadAuditor.displayName}" /></td>
												<td><c:out value="${audit.auditee.name}" /></td>
												<td><c:choose>
														<c:when test="${audit['class'].name == 'com.scannellsolutions.modules.audit.domain.AuditScheduled'}">
															<c:if test="${audit.deptLocation != null}">
																<c:out value="${audit.deptLocation}" />
															</c:if>
														</c:when>
														<c:otherwise>
															<c:choose>
															<c:when test="${audit.location != null}">
																<c:out value="${audit.location.name}" />
															</c:when>
															<c:when test="${audit.department != null}">
																<c:out value="${audit.department.name}" />
															</c:when>
															</c:choose>
														</c:otherwise>
													</c:choose></td>
												<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
												<td><c:out value="${audit.percentCompleted}%" /></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>

		<a name="auditsForReview"></a>
		<c:set var="found" value="${!empty auditsForReview}" />
		<c:if test="${found}">
			<div class="header">
				<h3>
					<fmt:message key="auditsForReview" />
				</h3>
			</div>
			<div class="content">
				<div class="table table-bordered table-responsive">
					<div class="panel">
						<c:forEach items="${auditsForReviewSites}" var="site" varStatus="p">
								<table class="table table-bordered table-responsive dataTable">
									<caption><c:out value="${site}" /></caption>
									<thead>
									<tr>
										<tr>
											<th style="width: 30px"><fmt:message key="id" /></th>
											<th><fmt:message key="name" /></th>
											<th><fmt:message key="leadAuditor" /></th>
											<th><fmt:message key="auditee" /></th>
											<th><fmt:message key="location" /></th>
											<th><fmt:message key="startTime" /></th>
											<th><fmt:message key="percentCompleted" /></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${auditsForReview}" var="audit" varStatus="s">
										<c:if test="${audit.programme.plan.site.id == site.id}">
											<c:choose>
												<c:when test="${s.index mod 2 == 0}">
													<c:set var="style" value="even" />
												</c:when>
												<c:otherwise>
													<c:set var="style" value="odd" />
												</c:otherwise>
											</c:choose>
											<tr class="<c:out value="${style}" />">
												<td><a href="#"
														onclick='changeSite("<c:url value="auditView.htm"><c:param name="id" value="${audit.id}"/></c:url>", ${audit.site.id}, "${audit.site}", ${currentSite})'>
														<c:out value="${audit.id}" />
													</a></td>
												<td><c:out value="${audit.name}" /></td>
												<td><c:out value="${audit.leadAuditor.displayName}" /></td>
												<td><c:out value="${audit.auditee.name}" /></td>
												<td><c:choose>
														<c:when test="${audit['class'].name == 'com.scannellsolutions.modules.audit.domain.AuditScheduled'}">
															<c:if test="${audit.deptLocation != null}">
																<c:out value="${audit.deptLocation}" />
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${audit.location != null}">
																<c:out value="${audit.location.name}" />
															</c:if>
														</c:otherwise>
													</c:choose></td>
												<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
												<td><c:out value="${audit.percentCompleted}%" /></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</c:forEach>						
					</div>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>
