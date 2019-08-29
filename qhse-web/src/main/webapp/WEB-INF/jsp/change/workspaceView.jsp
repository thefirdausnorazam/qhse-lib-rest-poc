<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
  <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
<title></title>
</head>
<common:moveSite recordType="changeAssessment"/>
<c:set var="progLabel"><fmt:message key="changeProgramme"/></c:set>
<body>
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
									<th><fmt:message key="id" /></th>
									<th><fmt:message key="changePlan" /></th>
									<th><fmt:message key="type" /></th>
									<th><fmt:message key="percentCompleted" /></th>
									<th><fmt:message key="reviewDate" /></th>
								</tr>
						</thead>
						
					</table>
					</c:when>
				<c:otherwise>
				    <c:if test="${found}">
				          <scannell:paging result="${result}" />
				    </c:if>
						<c:forEach items="${programmesSites}" var="site" varStatus="p">
							<table class="table table-bordered table-responsive dataTable">
								<caption><c:out value="${site}" /></caption>
								<thead>
									<c:if test="${found}">
										<tr>
											<th><fmt:message key="id" /></th>
											<th><fmt:message key="changePlan" /></th>
											<th><fmt:message key="type" /></th>
											<th><fmt:message key="percentCompleted" /></th>
											<th><fmt:message key="reviewDate" /></th>
										</tr>
									</c:if>
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
												<td><a href="#" onclick='changeSiteOfType("<c:url value="programmeView.htm"><c:param name="id" value="${programme.id}"/></c:url>", ${programme.site.id}, "${programme.site}", ${currentSite}, "${progLabel}")' >
														<c:out value="${programme.id}" />
													</a></td>
												<td><c:out value="${programme.plan.year}" /></td>
												<td><c:out value="${programme.type.name}" /></td>
												<td><c:out value="${programme.percentCompleted}%" /></td>
												<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
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

		<a name="changeAssessments"></a>
		<c:set var="found" value="${!empty changeAssessments}" />
		<div class="header">
			<h3>
				<fmt:message key="changeAssessments" />
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
										<th><fmt:message key="id" /></th>
										<th><fmt:message key="name" /></th>
										<th><fmt:message key="changeAssessment.initiator" /></th>
										<th><fmt:message key="changeAssessment.owner" /></th>
										<th><fmt:message key="percentCompleted" /></th>
									</tr>
							</thead>
							</table>
						</c:when>
					<c:otherwise>
						<c:forEach items="${changeAssessmentsSites}" var="site" varStatus="p">
								<table class="table table-bordered table-responsive dataTable">
									<caption><c:out value="${site}" /></caption>
									<thead>
										<c:if test="${found}">
											<tr>
												<th><fmt:message key="id" /></th>
												<th><fmt:message key="name" /></th>
												<th><fmt:message key="changeAssessment.initiator" /></th>
												<th><fmt:message key="changeAssessment.owner" /></th>
												<th><fmt:message key="percentCompleted" /></th>
											</tr>
										</c:if>
									</thead>
									<tbody>
									<c:forEach items="${changeAssessments}" var="change" varStatus="s">
										<c:if test="${change.site.id == site.id}">
											<c:choose>
												<c:when test="${s.index mod 2 == 0}">
													<c:set var="style" value="even" />
												</c:when>
												<c:otherwise>
													<c:set var="style" value="odd" />
												</c:otherwise>
											</c:choose>
											<tr class="<c:out value="${style}" />">
												<td><a href="#" onclick='changeSite("<c:url value="changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url>", ${change.site.id}, "${change.site}", ${currentSite})'>
														<c:out value="${change.id}" />
													</a></td>
												<td><c:out value="${change.name}" /></td>
												<td><c:out value="${change.initiator.displayName}" /></td>
												<td><c:out value="${change.owner.displayName}" /></td>
												<td><c:out value="${change.percentCompleted}%" /></td>
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

		<a name="changeAssessmentsForReview"></a>
		<c:set var="found" value="${!empty changeAssessmentsForReview}" />
		<c:if test="${found}">
			<div class="header">
				<h3>
					<fmt:message key="changeAssessmentsForReview" />
				</h3>
			</div>
			<div class="content">
				<div class="table table-bordered table-responsive">
					<div class="panel">
						<c:forEach items="${changeAssessmentsForReviewSites}" var="site" varStatus="p">		
							<table class="table table-bordered table-responsive dataTable">
								<caption><c:out value="${site}" /></caption>
								<thead>
									<tr>
										<th><fmt:message key="id" /></th>
										<th><fmt:message key="name" /></th>
										<th><fmt:message key="changeAssessment.initiator" /></th>
										<th><fmt:message key="changeAssessment.owner" /></th>			
										<th><fmt:message key="percentCompleted" /></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${changeAssessmentsForReview}" var="change" varStatus="s">
										<c:if test="${change.site.id == site.id}">
											<c:choose>
												<c:when test="${s.index mod 2 == 0}">
													<c:set var="style" value="even" />
												</c:when>
												<c:otherwise>
													<c:set var="style" value="odd" />
												</c:otherwise>
											</c:choose>
											<tr class="<c:out value="${style}" />">
												<td><a href="#" onclick='changeSite("<c:url value="changeAssessmentView.htm"><c:param name="id" value="${change.id}"/></c:url>", ${change.site.id}, "${change.site}", ${currentSite})'>
														<c:out value="${change.id}" />
													</a></td>
												<td><c:out value="${change.name}" /></td>
												<td><c:out value="${change.initiator.displayName}" /></td>		
												<td><c:out value="${change.owner.displayName}" /></td>		
												<td><c:out value="${change.percentCompleted}%" /></td>
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
