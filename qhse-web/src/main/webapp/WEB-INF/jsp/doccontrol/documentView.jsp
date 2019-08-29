<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="printable" content="true">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title></title>
		<script type='text/javascript' src="<c:url value="/js/doccontrol/showAckDialog.js" />"></script>
		<style type="text/css" media="all">
			@import "<c:url value='/css/progressBar.css'/>";
			@import "<c:url value='/css/doccontrol.css'/>";
			.content a.deactivated {
			    color: grey;
			}
			.big-icon {
			    font-size: 32px;
			}
		</style>
		<script>
			var title = '<fmt:message key="doccontrol.trainee.acknowledgement"/>';
				
			jQuery(document).ready(function() {
				  showDialog("${showAcknowledgement}", '<c:url value="/doccontrol/documentView.htm"><c:param name="id" value="${document.id}"/></c:url>', '<c:url value="/doccontrol/addAcknowledgement.htm"><c:param name="parentId" value="${docRevision.id}"/></c:url>');
			});
			function openDialog() {
				openAckDialog('<c:url value="/doccontrol/addAcknowledgement.htm"><c:param name="showId" value="${docTrainingRecord.id}"/><c:param name="parentId" value="${docRevision.id}"/></c:url>');
			}
		</script>
	</head>
	<body>
		<a name="document"></a>
		
		<c:set var="docTrainingRecordId" value="${docTrainingRecord.id}" />
		<c:set var="foundReviews" value="${!empty docRevision.reviews}" />
		<c:set var="foundRevisions" value="${!empty revisions && fn:length(revisions) gt 1}" />
		<c:set var="isDownloadable" value="${document.downloadable}" />
		<c:set var="viewAll" value="${document.viewAll}" />
		<c:set var="foundDistribution" value="${document.distributionList != null}" />
		<c:set var="downloadMessage">
			<c:choose>
				<c:when test="${docRevision.fileDeleted}"><fmt:message key="docControl.document.deleted" /></c:when>
				<c:when test="${isDownloadable}"><fmt:message key="docControl.download"/></c:when>
				<c:otherwise><fmt:message key="docControl.downloadNotAvailable"/></c:otherwise>
			</c:choose>
		</c:set>
	
		<doccontrol:progressBar docStatus="${document.status}" foundReviews="${foundReviews}"/>
		
		<div class="header">
			<h2><span class="nowrap"><fmt:message key="docControl.overview" /></span></h2>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">	
					<col />
					<thead>
						<tr>
							<td colspan="4" align="right">
								<div class="navLinks">
									<c:if test="${isTrainee || document.revisionDownloadable}">
										<c:if test="${foundRevisions}"><a href="#revisions"><fmt:message key="docControl.documentRevisions" /></a></c:if>	
									</c:if>
									<c:if test="${viewAll}">
										<c:if test="${foundRevisions && foundReviews}"> | </c:if>	
										<c:if test="${foundReviews}"><a href="#reviews"><fmt:message key="docControl.documentReviews" /></a></c:if>		
										<c:if test="${(foundDistribution && foundRevisions) || (foundDistribution && foundReviews)}"> | </c:if>	
									</c:if>
									<c:if test="${foundDistribution}"><a href="#distribution"><fmt:message key="doccontrol.distributionList" /></a></c:if>
								</div>
							</td>
						</tr>
					</thead>		
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
							    	<a href="<c:url value="/doccontrol/docGroupView.htm" ><c:param name="id" value="${docGroup.id}" /></c:url>"><c:out value="${docGroup.displayName}" /></a>
							    	<c:if test="${docGroup.activeStatus}">
								    	<a href="<c:url value="/doccontrol/docGroupsView.htm" ><c:param name="navTo" value="${docGroup.id}" /><c:param name="source" value="${document.id}" /></c:url>">
											<i class="fa fa-sitemap"></i>
										</a>
									</c:if>
						    	</c:when>
						    	<c:otherwise>
						    		<c:out value="${docGroup.name}" /> (<c:out value="${docGroup.prefix}" />)
					    		</c:otherwise>
					    	</c:choose>
						</td>
						<td class="scannellGeneralLabel"><fmt:message key="doccontrol.reviewFrequency" />:</td>
					    <td><c:out value="${docGroup.frequency}" /></td>
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
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.trainee.dept" />:</td>      				
							<td>
								<ul>
							      	<c:forEach items="${document.trainees.audDepts}" var="dept" varStatus="s">
							        	<li><c:out value="${dept.realName}" /></li>
							      	</c:forEach>
							     </ul>
							</td> 
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.trainee.group" />:</td>      				
							<td>
								<ul>
							      	<c:forEach items="${document.trainees.audGroups}" var="group" varStatus="s">
							        	<li><c:out value="${group.name}" /></li>
							      	</c:forEach>
							     </ul>
							</td> 
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
		    				<td class="scannellGeneralLabel"><fmt:message key="uploadedDocuments" />:</td>
		    				<td colspan="3">
		     					<ul>
						      		<c:forEach items="${document.records}" var="item">
							  			<c:if test="${item.active}">
							  				<c:choose>
												<c:when test="${item.type.name == 'attach'}">
								  					<li>
								 					<a target="attachment" href="<c:url value="viewDocumentRecord.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
													<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /></li>
							    				</c:when>
												<c:otherwise>
													<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
													<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /></li>
												</c:otherwise>
							  				</c:choose> 
							  			</c:if>
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
				<tfoot>
					<tr>
						<td colspan="4">
							<c:if test="${urls != null}"><scannell:url urls="${urls}" />
								<c:if test="${document.viewAll && (document.lastUpdatedByUser != null || document.trainees.lastUpdatedByUser != null)}">
									<c:if test="${!empty urls}" >
										| <a href="javascript:openParentChildHistory(<c:out value="${document.id},'${document['class'].name}','${document.trainees.id}','DocAudience'" />)"><fmt:message key="viewHistory" /></a>
									</c:if>
		        				</c:if>
		        			</c:if>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<div class="content" style="margin-right: auto; margin-left: auto; width: 800px;">
		<div class="col-sm-3" title="${downloadMessage}">
			<c:choose>
				<c:when test="${isDownloadable && !docRevision.fileDeleted}">
					<a id="downloadDoc" target="attachment" download="<c:out value="${document.downloadFileName}"/> <c:out value="${docRevision.downloadDocRevision}"/>" href="<c:url value="downloadDocument.htm">
							<c:param name="docRevisionId" value="${docRevision.id}" />
						</c:url>">
						<i class="fa fa-download big-icon"></i>
					</a>
				</c:when>
				<c:otherwise>
					<a class="deactivated">
						<i class="fa fa-download big-icon"></i>
					</a>
				</c:otherwise>
			</c:choose>
		</div>
		<c:choose>
			<c:when test="${document.allowedDistribute}">
				<div class="col-sm-3" title="<fmt:message key="docControl.distribute"/>">
					<a href="<c:url value="distribute.htm"><c:param name="ownerId" value="${document.id}"/><c:param name="showId" value="${document.distributionList.id}"/></c:url>" >
						<i class="fa fa-arrows big-icon"></i>
					</a>
				</div>
			</c:when>
			<c:when test="${document.distributeAccess}">	
				<div class="col-sm-3" title="<fmt:message key="docControl.distribute"/>">
					<a href="#" class="deactivated">
						<i class="fa fa-arrows big-icon"></i>
					</a>
				</div>
			</c:when>
		</c:choose>
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
		<c:if test="${document.allowedSeeDownloads}">			
			<div class="col-sm-3" title="<fmt:message key="docControl.showViews"/>">	
				<a href="<c:url value="docTrainingRecordQueryForm.htm"><c:param name="id" value="${document.id}" />></c:url>">
					<i class="fa fa-eye big-icon"></i>
				</a>
			</div>
		</c:if>
	</div>
	
	
	<c:if test="${isTrainee || document.revisionDownloadable}">
		<br/>
		<br/>
		<br/>	
		<c:if test="${foundRevisions}">
			<a name="revisions"></a>
			<div class="header nowrap">
				<h3><fmt:message key="docControl.revisionTable" /></h3>
			</div>
			<div class="content">
			<div class="table-responsive">
			<table class="table table-bordered table-responsive">
			<thead>
				<tr>
					<td colspan="6" align="right">
						<div class="navLinks">
							<a href="#document"><fmt:message key="docControl.overview" /></a>
							<c:if test="${foundReviews}"> | <a href="#reviews"><fmt:message key="docControl.documentReviews" /></a></c:if>	
							<c:if test="${foundDistribution}"> | <a href="#distribution"><fmt:message key="doccontrol.distributionList" /></a></c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th><fmt:message key="docControl.revisionNumber" /></th>
					<th><fmt:message key="date" /></th>
					<th><fmt:message key="docControl.reason" /></th>
					<th><fmt:message key="docControl.respPerson" /></th>
					<th><fmt:message key="status" /></th>
					<th><fmt:message key="docControl.download.heading" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${revisions}" var="revision" varStatus="s">
					<c:if test="${revision.docItem != null}">
						<tr>
							<td><a href="<c:url value="documentRevisionView.htm"><c:param name="id" value="${revision.id}" /><c:param name="parentId" value="${revision.document.id}" /></c:url>"><c:out value="${revision.displayVersion}" /></a></td>
							<td><fmt:formatDate value="${revision.createdTs}" pattern="dd-MMM-yyyy" /></td>
							<td><c:out value="${revision.reason}" /></td>
							<td><c:out value="${revision.docItem.approvedByUser.displayName}" /></td>
							<td><fmt:message key="${revision.docItem.status}" /></td>
							<td>
							<c:set var="revDownloadMessage">
								<c:choose>
									<c:when test="${revision.fileDeleted}"><fmt:message key="docControl.document.deleted"/></c:when>
									<c:when test="${document.revisionDownloadable}"><fmt:message key="docControl.download"/></c:when>
									<c:otherwise><fmt:message key="docControl.downloadNotAvailable"/></c:otherwise>
								</c:choose>
							</c:set>
								<c:choose>
									<c:when test="${document.revisionDownloadable && !revision.fileDeleted}">
										<a target="attachment" title="${revDownloadMessage}" download="<c:out value="${document.downloadFileName}"/> <c:out value="${revision.downloadDocRevision}"/>" href="<c:url value="downloadDocument.htm">
												<c:param name="docRevisionId" value="${revision.id}" />
											</c:url>">
											<i class="fa fa-download"></i>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#" title="${revDownloadMessage}" class="deactivated">
											<i class="fa fa-download"></i>
										</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
			</table>
			</div>
		</c:if>
	</c:if>
	
	<c:if test="${viewAll}">
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
								<c:if test="${foundDistribution}"> | <a href="#distribution"><fmt:message key="doccontrol.distributionList" /></a></c:if>
							</div>
						</td>
					</tr>
					<c:if test="${document.editable}">
						<tr>		
							<th><fmt:message key="comment" /></th>
							<th><fmt:message key="createdBy" /></th>
							<c:if test="${document.editable}">
								<th><fmt:message key="edit" /></th>
								<th><fmt:message key="viewHistory.heading" /></th>
							</c:if>
						</tr>
					</c:if>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${document.editable}">
							<c:forEach items="${docRevision.reviews}" var="review" varStatus="s">
								<tr>			
									<td width="60%"><scannell:text value="${review.comment}" /></td>        				
									<td><c:out value="${review.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
									<c:if test="${document.editable}">
										<td>
											<a href="<c:url value="documentAddReview.htm"><c:param name="showId" value="${review.id}" /><c:param name="parentId" value="${docRevision.id}" /></c:url>"><i class="fa fa-edit"></i></a>
										</td>
										<td>
											<c:if test="${review.lastUpdatedByUser != null}">
												<a href="javascript:openHistory('${review.id }','com.scannellsolutions.modules.doccontrol.domain.DocReview')"><i class="fa fa-history"  aria-hidden="true"></i></a>
											</c:if>
										</td>	
									</c:if>
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
	</c:if>
	
	<c:if test="${foundDistribution}">
	<br/>
	<br/>
		<a name="distribution"></a>
		<div class="header nowrap">
			<h3><fmt:message key="doccontrol.distributionList.heading" /></h3>
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
							<c:if test="${viewAll}">
								<c:if test="${foundRevisions}"> | <a href="#revisions"><fmt:message key="docControl.documentRevisions" /></a></c:if>	
								<c:if test="${foundReviews}"> | <a href="#reviews"><fmt:message key="docControl.documentReviews" /></a></c:if>
							</c:if>		
						</div>
					</td>
				</tr>
				<tr>		
					<th><fmt:message key="enviro.users" /></th>
					<th><fmt:message key="enviro.depts" /></th>
					<th><fmt:message key="enviro.groups" /></th>
					<th><fmt:message key="sites" /></th>
				</tr>
			</thead>
			<tbody>
				<tr>			
					<td>
						<ul>
					      	<c:forEach items="${document.distributionList.audUsers}" var="user" varStatus="s">
					        	<li><c:out value="${user.displayName}" /></li>
					      	</c:forEach>
					     </ul>
					</td>    	
					<td>
						<ul>
					      	<c:forEach items="${document.distributionList.audDepts}" var="dept" varStatus="s">
					        	<li><c:out value="${dept.realName}" /></li>
					      	</c:forEach>
					     </ul>
					</td>     				
					<td>
						<ul>
					      	<c:forEach items="${document.distributionList.audGroups}" var="group" varStatus="s">
					        	<li><c:out value="${group.name}" /></li>
					      	</c:forEach>
					     </ul>
					</td> 
					<td>
						<ul>
					      	<c:forEach items="${document.distributionList.audSites}" var="site" varStatus="s">
					        	<li><c:out value="${site.name}" /></li>
					      	</c:forEach>
					     </ul>
					</td> 
				</tr>
			</tbody>
			</table>
		</div>
	</c:if>
	
	
	</div>
	</div>
	</body>
</html>
