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
			@import "<c:url value='/css/progressBar.css'/>";
			.progress {
			  width: 100%;
			  margin: 20px auto;
			  text-align: center;
			  background-color: white;
			  border: none !important;
			  border-style: none !important;
			}
			.content a.deactivated {
			    color: grey;
			}
			.big-icon {
			    font-size: 32px;
			}
		</style>
		<script src="<c:url value="/js/progressBar.js" />"></script>
		<script type='text/javascript' src="<c:url value="/js/doccontrol/showAckDialog.js" />"></script>
		<script>
			var title = '<fmt:message key="doccontrol.trainee.acknowledgement"/>';
				
			jQuery(document).ready(function() {
				  showDialog("${showAcknowledgement}", '<c:url value="/doccontrol/documentRevisionView.htm"><c:param name="id" value="${docRevision.id}"/><c:param name="parentId" value="${docRevision.document.id}"/></c:url>', 
						  '<c:url value="/doccontrol/addAcknowledgement.htm"><c:param name="parentId" value="${docRevision.id}"/></c:url>');
			});
			function openDialog() {
				openAckDialog('<c:url value="/doccontrol/addAcknowledgement.htm"><c:param name="showId" value="${docTrainingRecord.id}"/><c:param name="parentId" value="${docRevision.id}"/></c:url>');
			}
		</script>
	</head>
	<body>
		<a name="document"></a>
		<c:set var="foundReviews" value="${!empty docRevision.reviews}" />
	
	
		<doccontrol:progressBar docStatus="${docRevision.docItem.status}" foundReviews="${foundReviews}"/>
		
		<div class="header">
			<h2><span class="nowrap"><fmt:message key="docControl.revisionOverview" /></span></h2>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">	
					<col />
					<c:if test="${foundReviews}">
						<thead>
							<tr>
								<td colspan="4" align="right">
									<div class="navLinks">
										<a href="#reviews"><fmt:message key="docControl.documentReviews" /></a>
									</div>
								</td>
							</tr>
						</thead>
					</c:if>		
					<tbody>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="docControl.document.id" />:</td>
					    <td><a href="<c:url value="documentView.htm"><c:param name="id" value="${docRevision.document.id}"/></c:url>" ><c:out value="${docRevision.document.id}" /></a></td>
						<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
					    <td><fmt:message key="${docRevision.docItem.status}" /></td>
					</tr>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
					    <td colspan="3"><a href="<c:url value="documentView.htm"><c:param name="id" value="${docRevision.document.id}"/></c:url>" ><c:out value="${docRevision.document.name}" /></a></td>
					  </tr>
					 <tr>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.version.label" />:</td>
					    <td><c:out value="${docRevision.displayVersion}" /></td>
						<td class="scannellGeneralLabel"><fmt:message key="percentCompleted" />:</td>
					    <td><c:out value="${docRevision.docItem.percentCompleted}" />%</td>
					  </tr>
					  <c:if test="${docRevision.docItem.percentCompleted == 100}">			 
						 <tr>
							<td class="scannellGeneralLabel"><fmt:message key="assessment.approvalComment" />:</td>
						    <td><c:out value="${docRevision.docItem.approvalComment}" /></td>
							<td class="scannellGeneralLabel"><fmt:message key="approvedDate" />:</td>
						    <td> <fmt:formatDate value="${docRevision.docItem.approvedDate}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						  </tr>
				      </c:if>
					  <tr>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.reviewer.label" />:</td>
					    <td>
					      	<ul>
						      <c:forEach var="reviewer" items="${docRevision.docItem.reviewers}">
						        	<li><c:out value="${reviewer.displayName}" /></li>
						      </c:forEach>
					      	</ul>
					    </td>
					    <td class="scannellGeneralLabel"><fmt:message key="doccontrol.approver.label" />:</td>
					    <td>
					      	<c:out value="${docRevision.docItem.approvedByUser.displayName}" />
					    </td>
					    
					  </tr>
				</tbody>
			</table>
			<div class="content" style="margin-right: auto; margin-left: auto; width: 800px;">
				<c:if test="${docRevision.document.revisionDownloadable && !docRevision.fileDeleted}">
					<div class="col-sm-3" title="<fmt:message key="docControl.download"/>">
						<a id="downloadDoc" target="attachment" download="<c:out value="${docRevision.document.downloadFileName}"/> <c:out value="${docRevision.downloadDocRevision}"/>" href="<c:url value="downloadDocument.htm">
								<c:param name="docRevisionId" value="${docRevision.id}" />
							</c:url>">
							<i class="fa fa-download big-icon"></i>
						</a>
					</div>
				</c:if>
				<c:if test="${isTrainee}">
					<c:choose>
						<c:when test="${docTrainingRecord.accepted}">
							<div class="col-sm-3" title="<fmt:message key="doccontrol.trainee.accept"/>">
								<a href="#" onclick="openDialog()">
									<i class="fa fa-check big-icon" style="color:green"></i></i>
								</a>
							</div>
						</c:when>
						<c:when test="${docTrainingRecord.id > 0 && !docTrainingRecord.accepted}">
							<div class="col-sm-3" title="<fmt:message key="doccontrol.trainee.decline"/>">
								<a href="#" onclick="openDialog()">
									<i class="fa fa-times big-icon"  style="color:red"></i></i>
								</a>
							</div>
						</c:when>
						<c:when test="${document.status.name == 'DISTRIBUTED' && hasDistAccess}">
							<div class="col-sm-3" title="<fmt:message key="doccontrol.trainee.accept"/>">
								<a href="#" onclick="openDialog()">
									<i class="fa fa-warning big-icon"></i></i>
								</a>
							</div>
						</c:when>
					</c:choose>
				</c:if>
			</div>
		</div>
	</div>
	
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
						</div>
					</td>
				</tr>
				<c:if test="${docRevision.document.editable}">
					<tr>		
						<th><fmt:message key="comment" /></th>
						<th><fmt:message key="createdBy" /></th>
						<th><fmt:message key="viewHistory.heading" /></th>
					</tr>
				</c:if>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${docRevision.document.editable}">
						<c:forEach items="${docRevision.reviews}" var="review" varStatus="s">
							<tr>			
								<td width="60%"><scannell:text value="${review.comment}" /></td>        				
								<td><c:out value="${review.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								<td>
									<c:if test="${review.lastUpdatedByUser != null}">
										<a href="javascript:openHistory('${review.id }','com.scannellsolutions.modules.doccontrol.domain.DocReview')"><i class="fa fa-history"  aria-hidden="true"></i></a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>			
							<td colspan="4"><fmt:message key="doccontrol.notAccess.review" /></td> 
						</tr>    
					</c:otherwise>
				</c:choose>
			</tbody>
			</table>
		</div>
	</c:if>
	</div>
	</div>

	</body>
</html>
