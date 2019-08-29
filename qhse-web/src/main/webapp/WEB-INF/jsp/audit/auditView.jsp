<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="audit" tagdir="/WEB-INF/tags/audit" %>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
<style type="text/css" media="all">
@import "<c:url value='/css/audit.css'/>";
</style>
<style type="text/css">
/* Style the Image Used to Trigger the Modal */
#myImg {
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

#myImg:hover {opacity: 0.7;}

/* The Modal (background) */
.modalImage {
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
.modalImage-content {
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
.modalImage-content, #caption { 
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
    .modalImage-content {
        width: 100%;
    }
}
</style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		var answerAll = '<fmt:message key="bulkAnswer"/>';
		jQuery("a:contains("+answerAll+")").click(function(event) {
			if('${updateAllowed}' == 'true') {
				jQuery("#cl-wrapper").append(jQuery("#updateQuestions"));
				jQuery("#updateQuestions").modal("show"); 
				var url = jQuery("a:contains("+answerAll+")").attr('href');
				jQuery("#update").attr("onclick","location.href='reset"+url+"'");
				jQuery("#noUpdate").attr("onclick","location.href='"+url+"'");
				event.preventDefault();
			}
		});
		jQuery('#findingType').select2({
			width : '100%'
		});
		jQuery('#completed').select2({
			width : '100%;'
		});
		jQuery('#active').select2({
			width : '100%;'
		});
		filterQuestionsTable();
		loadQuestionImages();
	});
	jQuery.postJSON = function(url, data, callback) {  
		return jQuery.ajax({
	       url: url,
	       type: "POST",
	       data: data,
	       processData: false,
	       contentType: false,
	       success: callback
	    });
	};
	 function loadQuestionImages(){
		 	jQuery('#not-image').hide();
		 	var objectIdArray = new Array(); 
			jQuery(".image-id-class").each(function (){
				var objectIdObj = {objectId: jQuery(this).val()}
				objectIdArray.push(objectIdObj);
			});
			var jsonData = new FormData();
			jsonData.append("objectIdArray", JSON.stringify(objectIdArray));
			jQuery.postJSON("showMobileQuestionsImages.htm", jsonData, function(responseFromController){
				var imageList = responseFromController.imageList;
				for(var i = 0; i < imageList.length; i++){
					jQuery("#img-"+imageList[i].question).attr("src", "data:image/jpg;base64,"+imageList[i].imageInBase64)
					jQuery("#img-"+imageList[i].question).removeClass("not-image");
					jQuery("#img-"+imageList[i].question).show();
				}
				jQuery(".not-image").remove();
				
			}).error(function(jqXHR, error, errorThrown) {
				jQuery(".not-image").remove();
				if (jqXHR.status && jqXHR.status == 400) {
					alert('<fmt:message key="noImageFoundPageNotFound" />')
				} else if (jqXHR.status && jqXHR.status == 500) {
					alert('<fmt:message key="noImageFoundInternalError" />')
				} else {
					alert('<fmt:message key="noImageFound" />')
				}
			});
	 }
	function filterQuestionsTable() {
		filterTable('questionsFilterRow', 'questionsTbody');
	}
	
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

<audit:templateQuestionsChanged/>
<a name="audit"> </a>
		<div class="header">
			<h3>
				<fmt:message key="audit.title" />
				<c:out value="${audit.name}" />
			</h3>
		</div>
	<c:set var="foundNotes" value="${!empty audit.notes}" />
	<c:set var="foundAttachments" value="${!empty audit.attachments}" />
	<div class="content">
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col class="label" />
						<thead>
							<tr>
								<td colspan="2" align="right">
									<div class="navLinks">
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
									</div>

								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
								<td><c:out value="${audit.id}" /></td>
							</tr>
							<c:if test="${showLegacyId}">
							<tr>
								<td class="scannellGeneralLabel">Legacy <fmt:message key="id" />:</td>
								<td><c:out value="${audit.legacyId}" /></td>
							</tr>
							</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
								<td colspan="3">
								     <ul>
								      <c:forEach var="ba" items="${audit.businessAreas}">
								        	<li><c:out value="${ba.name}" /></li>
								      </c:forEach>
								      </ul>
								</td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="audit" /> <fmt:message key="name" />:</td>
								<td><c:out value="${audit.name}" /></td>
							</tr>
							<c:if test="${audit.recurringAudit != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="recurringAudit" />:</td>
									<td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${audit.recurringAudit.id}"/></c:url>" ><c:out value="${audit.recurringAudit.name}" /></a></td>
								</tr>
							</c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditProgramme" />:</td>
								<td><c:out value="${audit.programme.description}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="leadAuditor" />:</td>
								<td><c:out value="${audit.leadAuditor.displayName}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditee" />:</td>
								<td><c:out value="${audit.auditee.name}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="audit.personObserved" />:</td>
								<td><c:forEach items="${audit.observers}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="secondaryAuditors" />:</td>
								<td><c:forEach items="${audit.secondaryAuditors}" var="auditor" varStatus="s">
										<c:if test="${!s.first}">, </c:if>
										<c:out value="${auditor.displayName}" />
									</c:forEach></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="otherParticipants" />:</td>
								<td><scannell:text value="${audit.otherParticipants}" /></td>
							</tr>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="additionalInfo" />:</td>
								<td><scannell:text value="${audit.additionalInfo}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="template" />:</td>
								<td><c:out value="${audit.templateName}" /></td>
							</tr>

							<c:if test="${audit['class'].name == 'com.scannellsolutions.modules.audit.domain.AuditScheduled'}">
								<tr>
									<td class="scannellGeneralLabel">
										<c:if test="${audit.auditee['class'].simpleName == 'ThirdPartyAuditee'}"><fmt:message key="address" />:</c:if>
										<c:if test="${audit.auditee['class'].simpleName != 'ThirdPartyAuditee'}"><fmt:message key="department" />:</c:if> </td>
									<c:if test="${audit.deptLocation != null}">
										<td><c:out value="${audit.deptLocation}" /></td>
									</c:if>
								</tr>
							</c:if>

							<c:if test="${audit.recurringAudit != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="recurringAudit" />:</td>
									<td><a href="<c:url value="recurringAuditView.htm"><c:param name="id" value="${audit.recurringAudit.id}" /></c:url>">
											<c:out value="${audit.recurringAudit.name}" />
										</a></td>
								</tr>
							</c:if>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="startTime" />:</td>
								<td><fmt:formatDate value="${audit.startTime}" pattern="dd-MMM-yyyy HH:mm" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="duration" />:</td>
								<td><c:out value="${audit.duration.description}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="percentCompleted" />:</td>
								<td><c:out value="${audit.percentCompleted}%" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel nowrap"><fmt:message key="status" />:</td>
								<td>
								<fmt:message key="${audit.status}" />
								</td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="resultSummary" />:</td>
								<td><c:out value="${audit.resultSummary}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="auditQuestionResultsCompletedRatio" />:</td>
								<td><c:out value="${audit.questionsWithCompletedResultCount}/${audit.questionsWithResultCount}" /></td>
							</tr>
							<c:if test="${audit.completed}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="completedBy" />:</td>
									<td><c:out value="${audit.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.completionTime}" pattern="dd-MMM-yyyy" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="completionComment" />:</td>
									<td><scannell:text value="${audit.completionComment}" /></td>
								</tr>
							</c:if>
							<tr>
								    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
								    <td >
								    	<c:set var="showLatest" value="${audit.status != 'COMPLETE'}" scope="request"/>
								    	<jsp:include page="../doclink/showLinkedDocs.jsp" />
								    </td>
						 	</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
								<td><c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
							<c:if test="${audit.lastUpdatedByUser != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
									<td><c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
								<td colspan="2"><c:choose>
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

		<a name="questions"> </a><br><br>
		<div class="header">
			<h3>
				<fmt:message key="questions.title" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<thead>
							<tr>
								<td colspan="6" align="right">
									<div class="navLinks">
										<a href="#audit">
											<fmt:message key="audit.title" />
										</a>
										<c:if test="${foundNotes}">| <a href="#notes">
												<fmt:message key="notes" />
											</a>
										</c:if>
										<c:if test="${foundAttachments}">| <a href="#attachments">
												<fmt:message key="attachments" />
											</a>
										</c:if>
									</div>

								</td>
							</tr>
							<tr id="questionsFilterRow">
								<th><fmt:message key="question" /></th>
								<th><fmt:message key="findingComment" /><br /> <select name="findingType" id="findingType" onchange="filterQuestionsTable()">
										<option value="">Choose</option>
										<c:forEach items="${findingTypes}" var="item">
											<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
										</c:forEach>
									</select></th>
								<th><fmt:message key="completed" /> <br /> <select name="completed" id="completed" class="narrow" onchange="filterQuestionsTable()">
										<option value="">Choose</option>
										<option value="_true_"><fmt:message key="true" /></option>
										<option value="_false_"><fmt:message key="false" /></option>
									</select></th>
								<c:if test="${audit.template.scorable}">
									<th><fmt:message key="score" /></th>
								</c:if>
								<th><fmt:message key="active" /> <br /> <select name="active" id="active" class="narrow" onchange="filterQuestionsTable()">
										<option></option>
										<option value="_true_" selected="selected"><fmt:message key="true" /></option>
										<option value="_false_"><fmt:message key="false" /></option>
									</select>
								</th>
							</tr>
						</thead>
						<tbody id="questionsTbody">

							<c:set var="showGroups" value="${fn:length(groups) gt 1}" />

							<c:forEach items="${groups}" var="groupQuestionEntry">
								<c:set var="group" value="${groupQuestionEntry.key}" />
								<c:set var="questions" value="${groupQuestionEntry.value}" />

								<c:if test="${showGroups}">
									<tr class="auditQuestionGroupHeader">
										<th colspan="5"><c:if test="${group eq null}">
												<fmt:message key="auditTemplate.nullGroup" />
											</c:if> <c:out value="${group.name}" /></th>
									</tr>
								</c:if>

								<c:forEach items="${questions}" var="question" varStatus="s">
									<tr>
										<td><a href="<c:url value="auditQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>">
												<c:out value="${question.name}" />
											</a> <c:if test="${question.active}">
												<br />
												<br />
												<scannell:text value="${question.additionalInfo}" />
											</c:if></td>
										<td><span class="filterData"></span>
										 <scannell:text value="${question.findingComment}" maxChars="100" />  <br /> <br /><c:if test="${question.findingType != null}">
												<fmt:message key="${question.findingType}" />
											</c:if></td>
										<td><span class="filterData"></span> <fmt:message key="${question.completed}" /> <c:set var="result" value="${question.result}" /> <c:if test="${result != null}">
												<br />
												<br />
												<fmt:message key="result" />: <scannell:entityUrl entity="${result}" messageCodePrefix="auditResult." />
													(<fmt:message key="status" />: <fmt:message key="${result.statusCode}" />)
												</c:if></td>
										<c:if test="${audit.template.scorable}">
											<td><c:if test="${question.scorable and question.score ne null}">
													<c:out value="${question.score}/${question.scoreConfig.scoreMax}" />
												</c:if>&nbsp;</td>
										</c:if>
										<td><span class="filterData"></span> <fmt:message key="${question.active}" />
												<br><a onclick="showImageModalDialog('img-${question.id}')"><img border="1px solid red" class="not-image" id="img-${question.id}" width="50px" src="" ></a>
												
												<input type="hidden" class="image-id-class" value="${question.id}">
										</td>
									</tr>
								</c:forEach>

								<c:if test="${showGroups and audit.template.scorable}">
									<c:set var="summary" value="${groupScores[group]}" />
									<c:if test="${group eq null}">
										<c:set var="summary" value="${nullGroupScore}" />
									</c:if>
									<tr class="auditQuestionGroupFooter">
										<th>&nbsp;</th>
										<th>&nbsp;</th>
										<th>&nbsp;</th>
										<th><c:out value="${summary.asFraction}" /><br /> <c:out value="${summary.asPercent}" />%</th>
										<th>&nbsp;</th>
									</tr>
								</c:if>

							</c:forEach>
							<c:if test="${audit.template.scorable}">
								<c:set var="summary" value="${audit.scoreSummary}" />
								<tr class="auditQuestionScoreFooter">
									<th colspan="3" style="text-align: right;"><fmt:message key="audit.overallScore" /></th>
									<th><c:out value="${summary.asFraction}" /><br /> <c:out value="${summary.asPercent}" />%</th>
									<th>&nbsp;</th>
								</tr>
							</c:if>

							<c:forEach items="${inactiveQuestions}" var="question">
								<tr>
									<td><a href="<c:url value="auditQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>">
											<c:out value="${question.name}" />
										</a></td>
									<td><span class="filterData">
											
										</span> <c:if test="${question.findingType != null}">
											<fmt:message key="${question.findingType}" />
										</c:if> <br /> <br /> <scannell:text value="${question.findingComment}" maxChars="100" /></td>
									<td><span class="filterData">
											
										</span> <fmt:message key="${question.completed}" /> <c:set var="result" value="${question.result}" /> <c:if test="${result != null}">
											<br />
											<br />
											<fmt:message key="result" />: <scannell:entityUrl entity="${result}" messageCodePrefix="auditResult." />
			(<fmt:message key="status" />: <fmt:message key="${result.statusCode}" />)
		</c:if></td>
									<td><span class="filterData">
											
										</span> <fmt:message key="${question.active}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<c:if test="${foundNotes}">
			<a name="notes"> </a>
			<br>
			<br>
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
									<td colspan="3" align="right">
										<div class="navLinks">
											<a href="#audit">
												<fmt:message key="audit.title" />
											</a>
											|
											<a href="#questions">
												<fmt:message key="questions.title" />
											</a>
											<c:if test="${foundAttachments}">| <a href="#attachments">
													<fmt:message key="attachments" />
												</a>
											</c:if>
										</div>

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
										<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${foundAttachments}">
			<a name="attachments"> </a>
			<br>
			<br>
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
									<td colspan="2" align="right">
										<div class="navLinks">
											<a href="#audit">
												<fmt:message key="audit.title" />
											</a>
											|
											<a href="#questions">
												<fmt:message key="questions.title" />
											</a>
											<c:if test="${foundNotes}">| <a href="#notes">
													<fmt:message key="notes" />
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
														<a target="attachment" href="<c:url value="auditAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>">
															<c:out value="${item.name}" />
														</a>
													</c:when>
													<c:otherwise>
														<a target="attachment" href="<c:out value="${item.externalUrl}" />">
															<c:out value="${item.name}" />
														</a>
													</c:otherwise>
												</c:choose> <br /> <fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.createdTs}"
													pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
	</div>
	<!-- The Modal -->
<div id="myModal" class="modal modalImage" onclick="document.getElementById('myModal').style.display='none'">

  <!-- The Close Button -->
  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

  <!-- Modal Content (The Image) -->
  <img class="modal-content modalImage-content" id="img01">

  <!-- Modal Caption (Image Text) -->
  <div id="caption"></div>
</div>
</body>
</html>
