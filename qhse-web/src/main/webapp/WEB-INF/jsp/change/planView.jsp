<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><span class="nowrap"><fmt:message key="changePlan" /> - <c:out value="${plan.year}" /></span></h2>
</div>
<div class="content">
	<div class="table-responsive">
		<table class="table table-bordered table-responsive">
			<tbody>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
					<td><c:out value="${plan.id}" /></td>
				</tr>
	  			<tr>
	    			<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
	    			<td colspan="3">
					      <ul>
						      <c:forEach var="ba" items="${plan.businessAreas}">
						        	<li><c:out value="${ba.name}" /></li>
						      </c:forEach>
					      </ul>
	    			</td>
	  			</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="year" />:</td>
					<td><c:out value="${plan.year}" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
					<td><c:out value="${plan.percentCompleted}%" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
					<td><fmt:message key="${plan.status}" /></td>
				</tr>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
					<td><c:out value="${plan.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${plan.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				<c:if test="${plan.lastUpdatedByUser != null}">
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
					<td><c:out value="${plan.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${plan.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
				</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<c:choose>
							<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
							<c:otherwise><fmt:message key="changePlan" /> <fmt:message key="notCurrentSelectedSiteMsg" >
											<fmt:param value="${plan.site.name}" />
										 </fmt:message>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tfoot>
			</table>
		</div>
	</div>

<div class="header nowrap">
<h3><fmt:message key="changeProgrammes" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
				<thead>
					<tr>
						<th><fmt:message key="type" /></th>
						<th><fmt:message key="owner" /></th>
						<th><fmt:message key="percentCompleted" /></th>
						<th><fmt:message key="status" /></th>
						<th><fmt:message key="reviewDate" /></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${plan.openProgrammes}" var="programme" varStatus="s">
						<c:choose>
							<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
							<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
						</c:choose>
						<tr class="<c:out value="${style}" />">
							<td><a href="<c:url value="programmeView.htm"><c:param name="id" value="${programme.id}" /></c:url>"><c:out value="${programme.type.name}" /></a></td>
							<td><c:out value="${programme.owner.displayName}" /></td>
							<td><c:out value="${programme.percentCompleted}%" /></td>
							<td><fmt:message key="${programme.status}" /></td>
							<td><fmt:formatDate value="${programme.reviewDate}" pattern="dd-MMM-yyyy" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>


</body>
</html>
