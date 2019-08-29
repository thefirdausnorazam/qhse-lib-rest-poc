<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="reviews" required="true" type="com.scannellsolutions.modules.doccontrol.domain.DocGroup"%>
<%@ attribute name="foundReviews" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>

<c:if test="${foundReviews}">
	<br/>
	<br/>
		<a name="reviews"></a>
		<div class="header nowrap">
			<h3><fmt:message key="docControl.documentReviews" /></h3>
		</div>
		<div class="content">
		<div class="table-responsive">
		<div class="panel">
				<table class="table table-bordered table-responsive">
			<col class="label" />
			<thead>
				<tr>
					<td colspan="4" align="right">
						<div class="navLinks">
							<a href="#document"><fmt:message key="docControl.overview" /></a>
							<c:if test="${foundRevisions}">| <a href="#revisions"><fmt:message key="docControl.documentRevisions" /></a></c:if>
						</div>
					</td>
				</tr>
				<tr>		
					<th><fmt:message key="comment" /></th>
					<th><fmt:message key="createdBy" /></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${reviews}" var="review" varStatus="s">
					<tr>			
						<td width="60%"><scannell:text value="${review.comment}" /></td>        				
						<td><c:out value="${review.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						<td>
							<a href="<c:url value="documentAddReview.htm"><c:param name="showId" value="${review.id}" /><c:param name="parentId" value="${docRevision.id}" /></c:url>"><i class="fa fa-edit"></i></a>
						</td>
						<td>
							<c:if test="${review.lastUpdatedByUser != null}">
								<a href="javascript:openHistory('${review.id }','com.scannellsolutions.modules.doccontrol.domain.DocReview')"><i class="fa fa-history"  aria-hidden="true"></i></a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
	</c:if>
	</div>
	</div>