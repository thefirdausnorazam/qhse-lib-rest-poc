<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="printable" content="true">
		<title></title>
		<style type="text/css" media="all">
			@import "<c:url value='/css/doccontrol.css'/>";
		</style>
	</head>
	<body>
		<div class="header">
			<h2><span class="nowrap"><fmt:message key="${action}" /> <fmt:message key="documentBC" /></span></h2>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">	
					<col />		
					<tbody>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
					    <td><c:out value="${document.id}" /></td>
						<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
					    <td><fmt:message key="${document.status}" /></td>
					  </tr>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.version.label" />:</td>
					    <td><c:out value="${docRevision.displayVersion}" /></td>
						<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
					    <td><c:out value="${document.percentCompleted}" />%</td>
					  </tr>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
					    <td><c:out value="${document.name}" /></td>
						<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
					    <td>
					      <ul>
						      <c:forEach var="ba" items="${document.businessAreas}">
						        	<li><c:out value="${ba.name}" /></li>
						      </c:forEach>
					      </ul>
					    </td>
					   </tr>
					   <tr>
							<td class="scannellGeneralLabel"><fmt:message key="description" />:</td>
						    <td><scannell:text value="${document.description}" /></td>
							<td class="scannellGeneralLabel"><fmt:message key="department" />:</td>
						    <td>
							      <ul>
								      <c:forEach var="dept" items="${document.departments}">
								        	<li><c:out value="${dept.name}" /></li>
								      </c:forEach>
							      </ul>
							</td>
					   </tr>
					  <tr>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.docGroup.label" />:</td>
					    <td>
					    	<c:choose>
						    	<c:when test="${document.groupViewPermissions}">
							    	<a href="<c:url value="/doccontrol/docGroupView.htm" ><c:param name="id" value="${document.docGroup.id}" /></c:url>"><c:out value="${document.docGroup.name}" /> (<c:out value="${document.docGroup.prefix}" />)</a>
							    	<a href="<c:url value="/doccontrol/docGroupsView.htm" ><c:param name="navTo" value="${document.docGroup.id}" /></c:url>">
										<i class="fa fa-sitemap"></i>
									</a>
						    	</c:when>
						    	<c:otherwise>
						    		<c:out value="${document.docGroup.name}" /> (<c:out value="${document.docGroup.prefix}" />)
					    		</c:otherwise>
					    	</c:choose>
						</td>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.reviewFrequency" />:</td>
					    <td><c:out value="${document.docGroup.frequency}" /></td>
					  </tr>
						<c:if test="${document.approvedDate != null}">
							<tr>
								<td class="scannellGeneralLabel">				
									<c:choose> 
									  <c:when test="${document.approved}" ><fmt:message key="doccontrol.nextReview" /></c:when> 
									  <c:otherwise><fmt:message key="doccontrol.targetReview" /></c:otherwise> 
									</c:choose>:
								</td>
								<td colspan="3">
									<fmt:formatDate value="${document.targetReviewDate}" pattern="dd-MMM-yyyy" /> 							
									<c:choose> 
									  <c:when test="${document.reviewStatus == 'overdue'}" ><font color="red">(<fmt:message key="${document.reviewStatus}"/>)</font></c:when> 
									  <c:when test="${document.reviewStatus == 'due'}" ><font color="#ff9900">(<fmt:message key="${document.reviewStatus}"/>)</font></c:when> 
									</c:choose>
								</td>
							</tr>
				 		</c:if>
					  <tr>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.reviewer.label" />:</td>
					    <td>
					      	<ul>
						      <c:forEach var="reviewer" items="${document.reviewers}">
						        	<li><c:out value="${reviewer.displayName}" /></li>
						      </c:forEach>
					      	</ul>
					    </td>
					    <td class="scannellGeneralLabel"><fmt:message key="doccontrol.approver.label" />:</td>
					    <td>
					      	<c:out value="${document.approvedByUser.displayName}" />
					    </td>
					  </tr>
					  <c:if test="${document.percentCompleted == 100}">
						 <tr>
							<td class="scannellGeneralLabel"><fmt:message key="assessment.approvalComment" />:</td>
						    <td><c:out value="${document.approvalComment}" /></td>
							<td class="scannellGeneralLabel"><fmt:message key="approvedDate" />:</td>
						    <td> <fmt:formatDate value="${document.approvedDate}" pattern="dd-MMM-yyyy" /></td>
						  </tr>
					  </c:if>
						<tr>	
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.trainee.user" />:</td>		
							<td>
								<ul>
							      	<c:forEach items="${document.trainees.audUsers}" var="user" varStatus="s">
							        	<li><c:out value="${user.displayName}" /></li>
							      	</c:forEach>
							     </ul>
							</td>  
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.trainee.group" />:</td>      				
							<td>
								<ul>
							      	<c:forEach items="${document.trainees.audGroups}" var="group" varStatus="s">
							        	<li><c:out value="${group.name}" /></li>
							      	</c:forEach>
							     </ul>
							</td> 
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.trainee.site" />:</td>
							<td colspan="3">
								<ul>
							      	<c:forEach items="${document.trainees.audSites}" var="site" varStatus="s">
							        	<li><c:out value="${site.name}" /></li>
							      	</c:forEach>
							     </ul>
							</td> 
						</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
						<td><c:out value="${document.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${document.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						<c:choose>
							<c:when test="${document.lastUpdatedByUser != null}">
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${document.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${document.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</c:when>
							<c:otherwise><td></td><td></td></c:otherwise>
						</c:choose>
					</tr>
				</tbody>
			</table>
			
			<div style="clear: both;"></div>
			<scannell:form>
				<div class="spacer2 text-center">
					<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="${action}" />">
					<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
				</div>
			</scannell:form>
		</div>
	</div>

	</body>
</html>
