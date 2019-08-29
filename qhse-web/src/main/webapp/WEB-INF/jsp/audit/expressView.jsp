<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
<style type="text/css">
/* Style the Image Used to Trigger the Modal */
#myImg {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
}

/* Modal Content (Image) */
.modal-content {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
}

/* Caption of Modal Image (Image Text) - Same Width as the Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation - Zoom in the Modal */
.modal-content, #caption { 
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)} 
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}

.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
    }
}
</style>
	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>

<script type="text/javascript">
<!--
	function openPopup(url, w, h) {
		var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
		var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width=" + w + ",height=" + h + ",top=" + x + ",left=" + y + "";
		var win = window.open(url, "links", att);
		win.focus();
	}

	function onPopupClose() {
		<c:url var="url" value="/audit/expressView.htm">
		<c:param name="id" value="${param.id}" />
		</c:url>
		window.location.href = "<c:out value="${url}" />";
	}
// -->
function showImageModalDialog(objId){
		// Get the modal
		var modal = document.getElementById('myModal');
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() { 
		  modal.style.display = "none";
		}
		// Get the image and insert it inside the modal - use its "alt" text as a caption
		var img = document.getElementById(objId);
		try{
		//img.onclick = function(){
		    modal.style.display = "block";
		    modalImg.src = img.src;
		    modalImg.alt = img.alt;
		    captionText.innerHTML = img.alt;
		//}
		}catch(e){alert(e)}
		
		//jQuery.modal("<img src='"+jQuery('#'+objId).attr('src')+"' style='''/>");
	}
</script>

</head>
<body><br><br>
<a name="audit"> </a>
	<div class="header">
		<h2>
			<fmt:message key="auditExpress.title" />
		</h2>
	</div>
	<c:set var="foundNotes" value="${!empty audit.notes}" />
	<c:set var="foundAttachments" value="${!empty audit.attachments}" />

	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<td colspan="7" align="right">
								<div class="navLinks">
									<a href="#questions">
										<fmt:message key="questions.title" />
									</a>
									<c:if test="${foundNotes}">| <a href="#notes">
											<fmt:message key="notes" />
										</a>
									</c:if>
									<c:if test="${audit.hasCurrentActions}">| <a href="#action">
											<fmt:message key="actions" />
										</a>
									</c:if>
									<c:if test="${foundAttachments}">| <a href="#attachments">
											<fmt:message key="attachments" />
										</a>
									</c:if>
								</div> <!--<fmt:message key="auditExpress.title" /> -->
							</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
							<td colspan="6"><c:out value="${audit.id}" /></td>
						</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
								<td colspan="6">
								     <ul>
								      <c:forEach var="ba" items="${audit.businessAreas}">
								        	<li><c:out value="${ba.name}" /></li>
								      </c:forEach>
								      </ul>
								</td>
							</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="audit" /> <fmt:message key="name" />:</td>
							<td colspan="6"><scannell:text value="${audit.name}" /></td>
						</tr>
						<c:if test="${audit.recurringAudit != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="recurringAudit" />:</td>
								<td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${audit.recurringAudit.id}"/></c:url>" ><c:out value="${audit.recurringAudit.name}" /></a></td>
							</tr>
						</c:if>
						<c:if test="${audit.programme.type.saveAndReview}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditee" /></td>
								<td colspan="6"><scannell:text value="${audit.auditee.name}" /></td>
							</tr>
						</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="audit.personObserved" />:</td>
								<td colspan="6"><c:forEach items="${audit.observers}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
						

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="auditProgramme" />:</td>
							<td colspan="6"><c:out value="${audit.programme.description}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
							<td colspan="2"><c:out value="${audit.leadAuditor.displayName}" /></td>

							<td class="scannellGeneralLabel"><fmt:message key="otherParticipants" />:</td>
							<td colspan="4"><c:out value="${audit.otherParticipants}" /></td>
						</tr>

						<tr>
							<fmt:message key="incident.enableAdditionalFields" var="enable" />
							<c:if test="${enable}">
								<c:if test="${audit.location != null}">
									<td class="scannellGeneralLabel label"><fmt:message key="location" /></td>
									<td><c:out value="${audit.location.name}" /></td>
								</c:if>
							</c:if>
							<c:if test="${!enable}">
								<td class="scannellGeneralLabel"><fmt:message key="auditDepartment" />:</td>
								<c:choose>
                                    <c:when test="${audit.deptLocation != null}">									
										<td colspan="2"><c:out value="${audit.deptLocation}" /></td>									
                                    </c:when>                                   
                                   <c:otherwise>
                                   <td colspan="2">&nbsp;</td>
                                   </c:otherwise>
                                   </c:choose>								
							</c:if>

							<td  class="scannellGeneralLabel"><fmt:message key="startTime" />:</td>
							<td colspan="4"><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
						</tr>

						<c:if test="${audit.review.text != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="review" />:</td>
								<td colspan="6"><scannell:text value="${audit.review.text}" /></td>
							</tr>
						</c:if>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
							<td colspan="6"><scannell:text value="${audit.additionalInfo}" /></td>
						</tr>
						<tr>
						
						<td class="scannellGeneralLabel nowrap"><fmt:message key="status" />:</td>
								<td colspan="6"><fmt:message key="${audit.status}" /></td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel nowrap"><fmt:message key="associatedDocuments" />:</td>
							<td colspan="6">
								<c:set var="showLatest" value="${audit.status != 'COMPLETE'}" scope="request"/>
								<jsp:include page="../doclink/showLinkedDocs.jsp" />
							</td>
						</tr>

						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
							<td colspan="6"><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
									value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>
						<c:if test="${audit.lastUpdatedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td colspan="6"><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
										value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>
						<c:if test="${audit.signature != null && audit.signature != ''}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="signature" />:</td>
									<td>
										<img src="data:image/svg+xml;base64,${audit.showSignatureBase64 }" >
									</td>
								</tr>
							</c:if>

					</tbody>

					<tfoot>
						<tr>
							<td colspan="6"><c:choose>
									<c:when test="${urls != null}">
										<scannell:url urls="${urls}" />
									</c:when>
									<c:otherwise>
										<fmt:message key="audit.title" />
										<fmt:message key="notCurrentSelectedSiteMsg">
											<fmt:param value="${audit.site.name}" />
										</fmt:message>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>


	<a name="questions"> </a>
	<br />
	<br />
	<div class="header">
		<h2>
			<fmt:message key="questions.title" />
		</h2>
	</div>

	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<td colspan="6"  align="right">
								<div class="navLinks">
									<a href="#audit">
										<fmt:message key="auditExpress.title" />
									</a>
									<c:if test="${foundNotes}">| <a href="#notes">
											<fmt:message key="notes" />
										</a>
									</c:if>
									<c:if test="${audit.hasCurrentActions}">| <a href="#action">
											<fmt:message key="actions" />
										</a>
									</c:if>
									<c:if test="${foundAttachments}">| <a href="#attachments">
											<fmt:message key="attachments" />
										</a>
									</c:if>
								</div> <!--<fmt:message key="questions.title" /> -->
							</td>
						</tr>
					</thead>

					<tbody>
					
							<c:set var="group" value="${audit.programme.type.expressQuestionGroup}" />
							<c:if test="${group.active}">
								<c:if test="${group.name != null && group.name != ''}">
									<tr>
										<td colspan="4" class="scannellGeneralLabel nowrap"><c:out value="${group.name}" /></td>
									</tr>
								</c:if>
								<c:forEach items="${group.questions}" var="q">
									<c:if test="${q.active and q.visible}">
										<tr>
											<c:choose>
												<c:when test="${q.answerType.name == 'label'}">
													<td colspan="4" class="riskLabel" style="text-align:left;font-weight: bold;font-size:16pt;"><c:out value="${q.name}" /></td>
												</c:when>
												<c:otherwise>
													<th class="scannellGeneralLabel" style="width:50%"><c:out value="${q.name}" /></th>
													<td id="answers[<c:out value="${q.id}"/>]" colspan="3">
													<enviromanager:answer question="${q}" answers="${audit.answers}" />
													<c:if test="${appImagesMap[q.id] != null &&  appImagesMap[q.id] != ''}"><br>
													<a onclick="showImageModalDialog('img-${q.id}')"><img id="img-${q.id}" width="50px" src="data:image/png;base64,${appImagesMap[q.id] }"></a></c:if></td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:if>
								</c:forEach>
								<c:if test="${! empty historicAuditAnswers}">
								  <c:forEach var="historicAnswer" items="${historicAuditAnswers}" varStatus="loop">
										<tr>
										  	<td class=""><c:out value="${historicAnswer.question.name}" /></td>
										  	<td id="answers[<c:out value="${historicAnswer.question.id}"/>]" colspan="3"><enviromanager:answer question="${historicAnswer.question}" answers="${historicAuditAnswers}" /></td>
										</tr>
								  </c:forEach>
							  </c:if>
							</c:if>
						
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4"><scannell:url urls="${urls1}" /></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	<c:if test="${foundNotes}">
		<a name="notes"> </a>
		<br />
		<br />
		<div class="header">
			<h3>
				<fmt:message key="notes" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<tr>
								<td colspan="4"  align="right">
									<div class="navLinks">
										<a href="#audit">
											<fmt:message key="auditExpress.title" />
										</a>
										|
										<a href="#questions">
											<fmt:message key="questions.title" />
										</a>
										<c:if test="${audit.hasCurrentActions}">| <a href="#action">
												<fmt:message key="actions" />
											</a>
										</c:if>
										<c:if test="${foundAttachments}">| <a href="#attachments">
												<fmt:message key="attachments" />
											</a>
										</c:if>
									</div> <!-- <fmt:message key="notes" /> -->
								</td>
							</tr>
							<tr>
								<th><fmt:message key="title" /></th>
								<th><fmt:message key="text" /></th>
								<th><fmt:message key="createdBy" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${audit.notes}" var="note" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><c:out value="${note.name}" /></td>
									<td><scannell:text value="${note.text}" /></td>
									<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
											value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</c:if>

	<a name="action"> </a>
	<br />
	<br />
	<div class="header">
		<h3>
			<fmt:message key="actions" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
			<span class = "paging"><div class="navLinks" style="align:right;">
					<a href="#audit">
						<fmt:message key="auditExpress.title" />
					</a>
					<a href="#questions">
						<fmt:message key="questions.title" />
					</a>
					<c:if test="${foundNotes}">| <a href="#notes">
							<fmt:message key="notes" />
						</a>
					</c:if>
					<c:if test="${foundAttachments}">| <a href="#attachments">
							<fmt:message key="attachments" />
						</a>
					</c:if>
				</div></span>
				<table class="table table-bordered table-responsive dataTable">
					<thead>
						<tr>
							<c:if test="${audit.hasCurrentActions}">
								<th><fmt:message key="id" /></th>
								<th><fmt:message key="type" /></th>
								<th><fmt:message key="description" /></th>
								<th><fmt:message key="completionTargetDate" /></th>
								<th><fmt:message key="responsibleUser" /></th>
								<th><fmt:message key="status" /></th>
								<th></th>
							</c:if>
						</tr>
					</thead>

					<c:forEach items="${audit.currentActions}" var="item">
						<c:choose>
							<c:when test="${item != null}">
								<tr class="<c:out value="${style}" />">
									<td><c:out value="${item.id}" /></td>
									<td><fmt:message key="ActionType[${item.type}]" /></td>
									<td><div>
											<c:out value="${item.description}" />
										</div></td>
									<td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
									<td><c:out value="${item.responsibleUser.displayName}" /></td>
									<td><fmt:message key="${item.statusCode}" /></td>
									<td><a href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>">
											<fmt:message key="view" />
										</a></td>
								</tr>
							</c:when>
						</c:choose>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>

	<c:if test="${foundAttachments}">
		<a name="attachments"> </a>
		<br />
		<br />
		<div class="header">
			<h3>
				<fmt:message key="attachments" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<tr>
								<td colspan="3"  align="right">
									<div class="navLinks">
										<a href="#audit">
											<fmt:message key="auditExpress.title" />
										</a>
										|
										<a href="#questions">
											<fmt:message key="questions.title" />
										</a>
										<c:if test="${foundNotes}">| <a href="#notes">
												<fmt:message key="notes" />
											</a>
										</c:if>
										<c:if test="${audit.hasCurrentActions}">| <a href="#action">
												<fmt:message key="actions" />
											</a>
										</c:if>
									</div>

								</td>
							</tr>
							<tr>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="description" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${audit.attachments}" var="item" varStatus="s">
								<c:if test="${item.active}">
									<c:choose>
										<c:when test="${s.index mod 2 == 0}">
											<c:set var="style" value="even" />
										</c:when>
										<c:otherwise>
											<c:set var="style" value="odd" />
										</c:otherwise>
									</c:choose>
									<tr class="<c:out value="${style}" />">
										<td><c:choose>
												<c:when test="${item.type.name == 'attach'}">
													<a target="attachment"
														href="<c:url value="auditAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>">
														<c:out value="${item.name}" />
													</a>
												</c:when>
												<c:otherwise>
													<a target="attachment" href="<c:out value="${item.externalUrl}" />">
														<c:out value="${item.name}" />
													</a>
												</c:otherwise>
											</c:choose> <br /> <fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message
												key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
										<td><scannell:text value="${item.description}" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2"><c:if test="${audit.editable}">
										<a href="<c:url value="auditAttachmentEdit.htm"><c:param name="showId" value="${audit.id}" /></c:url>">
											<fmt:message key="addAttachment" />
										</a>
									</c:if> <c:if test="${audit != null && audit.editable && !empty audit.attachments}">
											| <a href="<c:url value="auditAttachmentList.htm"><c:param name="id" value="${audit.id}" /></c:url>">
											<fmt:message key="editAttachments" />
										</a>
									</c:if></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</c:if>
<!-- The Modal -->
<div id="myModal" class="modal" onclick="document.getElementById('myModal').style.display='none'">

  <!-- The Close Button -->
  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

  <!-- Modal Content (The Image) -->
  <img class="modal-content" id="img01">

  <!-- Modal Caption (Image Text) -->
  <div id="caption"></div>
</div>
</body>
</html>
