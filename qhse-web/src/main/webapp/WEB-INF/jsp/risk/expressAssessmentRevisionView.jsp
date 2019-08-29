<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskStatus"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>

<style type="text/css" media="print">

.page     {
	font-size: .8em; 
	zoom: 1;
	overflow:hidden !important;size: landscape;
     }
.nowrap{}
div { width: 100%;     border: 0;   overflow: hidden; size: auto;} 
.printFont{
	font-size:70%;
	/* width: 80% !important; */
}
body{width: 100%;}
</style>
<style type="text/css">
.matrixImageSize{
	width:800px;
}
@media screen and (min-width: 800px) {
    .matrixImageSize {width:800px;}
}
@media screen and (min-width: 1440px) {
    .matrixImageSize {width:900px;}
}
@media screen and (min-width: 1600px) {
    .matrixImageSize {width:1024px;}
}
@media screen and (min-width: 1920px) {
    .matrixImageSize {min-width:1600px;}
}
</style>
<style>
.panel>.table-bordered>thead>tr:first-child>td,.panel>.table-responsive>.table-bordered>thead>tr:first-child>td,.panel>.table-bordered>tbody>tr:first-child>td,.panel>.table-responsive>.table-bordered>tbody>tr:first-child>td,.panel>.table-bordered>thead>tr:first-child>th,.panel>.table-responsive>.table-bordered>thead>tr:first-child>th,.panel>.table-bordered>tbody>tr:first-child>th,.panel>.table-responsive>.table-bordered>tbody>tr:first-child>th
	{
	border-bottom: 0 !important; border: 1px solid #ddd !important;
}

.panel>.table-bordered>thead>tr>th:last-child,.panel>.table-responsive>.table-bordered>thead>tr>th:last-child,.panel>.table-bordered>tbody>tr>th:last-child,.panel>.table-responsive>.table-bordered>tbody>tr>th:last-child,.panel>.table-bordered>tfoot>tr>th:last-child,.panel>.table-responsive>.table-bordered>tfoot>tr>th:last-child,.panel>.table-bordered>thead>tr>td:last-child,.panel>.table-responsive>.table-bordered>thead>tr>td:last-child,.panel>.table-bordered>tbody>tr>td:last-child,.panel>.table-responsive>.table-bordered>tbody>tr>td:last-child,.panel>.table-bordered>tfoot>tr>td:last-child,.panel>.table-responsive>.table-bordered>tfoot>tr>td:last-child
	{
	border-right: 0 !important;; border: 1px solid #ddd !important;
}

/*  .table-striped>tbody>tr:nth-child(4n+1)>td,
.table-striped>tbody>tr:nth-child(4n+2)>td
{    background-color: #ff10ff !important;
}
.table-striped>tbody>tr:nth-child(4n+3)>td,
.table-striped>tbody>tr:nth-child(4n+4)>td
{    background-color: #00ffff !important;
} */

/*  table th, table td{ overflow: hidden; } */
table td textarea {
	width: 94%;
}

table td input[type="text"] {
	width: 94%;
}
</style>
<style>
.black_overlay {
	display: none; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: black; z-index: 1001; -moz-opacity: 0.8; opacity: .80; filter: alpha(opacity = 80);
}

.white_content {
	display: none; position: absolute; top: 25%; left: 25%; width: 50%; height: 45%; padding: 16px; border: 8px solid #CF3030; background-color: white; z-index: 1002; overflow: auto;
	/*  overflow-x: hidden; */
}
</style>
<script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
<script type="text/javascript">

  <c:url var="url" value="/doclink/holderEdit.htm"><c:param name="holderName" value="RiskAssessment[${assessment.id}]" /></c:url>


  <c:url var="url" value="/risk/assessmentAccessLevel.htm">
    <c:if test="${assessment.accessLevel != null}"><c:param name="showId" value="${assessment.accessLevel.id}" /></c:if>
    <c:param name="ownerId" value="${assessment.id}" />
  </c:url>
  function openAccessLevelWindow() {
    var url = '<c:out value="${url}" />';
    window.location = url;
    //openPopup(url, 700, 400);
  }

  function viewLegislation(hazardId) {
	var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
    var params = '?raType=<c:out value="${assessment.template.businessArea.id}" />&pageRisk=true&icdKeys='+hazardId;
    openPopup(url + params, 1000, 600);
  }

  function openPopup(url, w, h) {
    var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
    var win = window.open(url, "links", att);
    win.focus();
  }

  function onPopupClose(){
	  alert('Risk:onPopupClose');
    <c:url var="url" value="/risk/assessmentView.htm">
      <c:param name="id" value="${param.id}" />
    </c:url>
    window.location.href = "<c:out value="${url}" />";
  }
  
  function checkForSubTables(){
	  var elems = document.getElementsByTagName("div");	  
	  var subTables = new Array();
      for(var i = 0; i < elems.length; i++) {
          var nameProp = elems[i].getAttribute('id');          
          if(!(nameProp == null) && (nameProp.substr(nameProp.length -3, nameProp.length) == 'div')){
        	  subTables.push(elems[i]);
          }
      }
      if(subTables.length > 0){
			var tableId = subTables[0].id.substr(0,subTables[0].id.indexOf('-'));	          
	      	var table = document.getElementById("answers["+tableId+"]");
	      	var numberOfRows = table.firstChild.firstChild.tBodies[0].rows.length;
      	       	          
			for(var i = 0; i < numberOfRows; i++) {
	    	  var subTableGroup = getSubTablesForRow(subTables, i);
	          for(var k = 0; k < subTableGroup.length; k++) {
	             var div = subTableGroup[k];            
	          	//show div
	          	var trparent = getParent("tr", table);
	          	var tbodyparent = getParent("tbody", table);
	          	if(i==0){
	          		var newTableRow = tbodyparent.insertRow(trparent.rowIndex);
	          	}else{
	          		var newTableRow = tbodyparent.insertRow(trparent.rowIndex + (i * subTableGroup.length));
	          	}
	          	newTableRow.insertCell(0);
	          	var cell = newTableRow.insertCell(1);     
	          	cell.insertBefore(div,null);      
	          	div.style.display="block";           
	  		}	  
	      }
      }
  }

  jQuery(document).ready(function(){		 
		if(getURLParam('printable') == 'true') {
			jQuery('.matrixImageSize').css('width', '550px');
		}
	 });
 
  //jQuery(window).bind('load', init);
  //jQuery(window).bind('load', getScoringQuestion);

  
  </script>
<style>
.black_overlay {
	display: none; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: black; z-index: 1001; -moz-opacity: 0.8; opacity: .80; filter: alpha(opacity = 80);
}

.white_content {
	display: none; position: absolute; top: 25%; left: 25%; width: 50%; height: 45%; padding: 16px; border: 8px solid #CF3030; background-color: white; z-index: 1002; overflow: auto;
	/*  overflow-x: hidden; */
}
</style>


</head>
<body><div class="page">
<div class="header">
		<h2>
			<fmt:message key="assessmentView.title" />
		</h2>
	</div>

<div class="content">

<table class="table table-responsive table-bordered table-hover" >
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
	    <c:choose>
	        	<c:when test="${assessment.type eq riskType}">
	        		<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
	        	</c:when>
	        	<c:otherwise>
	        		<c:url var="assessmentURL" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
	        	</c:otherwise>
	     </c:choose>
         <a href="<c:out value="${assessmentURL}" />"><c:out value="${assessment.displayId}" /></a>
         <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
    </td>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td><fmt:message key="assessment${assessment.status}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.revisionReason" />:</td>
    <td>
      <fmt:message key="${assessment.revisionReason}" />
         
      		<c:choose>
      			<c:when test="${assessment.type eq riskType}">
      				<c:if test="${assessment.completedExpressTask != null}">
	        		<c:url var="viewTaskUrl" value="/risk/hazardTaskView.htm"><c:param name="id" value="${assessment.completedTask.id}"/></c:url>
	        		<a href="<c:out value="${viewTaskUrl}" />"><c:out value="${assessment.completedTask.displayId}" /></a>
	        	</c:if>
	        	</c:when>
	        	<c:otherwise>
	        		<c:if test="${assessment.completedTask != null}">
		        		<c:url var="viewTaskUrl" value="/risk/taskView.htm"><c:param name="id" value="${assessment.completedTask.id}"/></c:url>
		        		<a href="<c:out value="${viewTaskUrl}" />"><c:out value="${assessment.completedTask.displayId}" /></a>
	        		</c:if>
	        	</c:otherwise>
	     	</c:choose>
   
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td <c:if test="${!(assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven)}"> colspan="5" </c:if>>
      <c:forEach var="ba" items="${assessmentLatest.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
	<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA' and not assessment.template.attachmentDriven}">
    <td class="scannellGeneralLabel"><fmt:message key="assessment.score" />:</td>
    <td>
      <jsp:include page="showRiskScoreIcon.jsp" /> 
      <c:out value="${assessment.score}" />
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.threshold" />:</td>
    <td>
      <jsp:include page="showThreshold.jsp" /> 
    </td>
	</c:if>
  </tr>

  <tr>
  <td class="scannellGeneralLabel nowrap">Title:</td>
    <td><c:out value="${assessment.name}" /></td>
    <td class="scannellGeneralLabel" width="150px">
    <c:choose>
        	<c:when test="${assessment.type eq riskType}">
        		<fmt:message key="assessment.scope" />:
        	</c:when>
        	<c:otherwise>
        		<fmt:message key="assessment.name" />:
        	</c:otherwise>
     </c:choose>
    </td>
    <td>
  	  <c:choose>
		  <c:when test="${assessment.sensitiveDataViewable}"><c:out value="${assessment.description}"/></c:when>
	      <c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
	  </c:choose>
    </td>
    <td class="scannellGeneralLabel" width="150px">
	    <fmt:message key="reviewTargetDate" />:
    </td>
    <td>
		<fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" />
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.otherParticipants" />:</td>
    <td colspan="3"><c:out value="${assessment.otherParticipants}" /></td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="6" align="center">      
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>


</div>







<div class="header ">
<h3><fmt:message key="assessmentRevisionQueryForm.title" /></h3>
</div>
	<c:if test="${assessment != null}">
		<div class="content">
			<!-- <div class="table-responsive"> -->
				<!-- <div class="panel"> -->
					<table class="table table-bordered table-responsive printFont">
						<col />
						<thead>

						</thead>
						<tbody>

							<tr>
								<td><fmt:message key="id" />:</td>
								<td colspan="2"><c:out value="${assessment.displayId}" /> <c:if test="${assessment.confidential}">
										<fmt:message key="assessment.confidential" />
									</c:if></td>
								<td><fmt:message key="assessment.title" />:</td>
								<td colspan="2"><c:out value="${assessment.name}" /></td>
								<c:if test="${assessment.template.prefix !='SA'}">
									<td><fmt:message key="assessment.score" />:</td>
									<td valign="top" colspan="2"><jsp:include page="showRiskScoreIcon.jsp" /> <c:out value="${assessment.score}" /> <jsp:include page="showRiskScoreText.jsp" /></td>
								</c:if>
							</tr>
							<tr>
								<td><fmt:message key="assessment.status" />:</td>
								<td colspan="2"><fmt:message key="assessment${assessment.status}" /></td>

								<td><fmt:message key="assessment.scope" /></td>
								<td colspan="2">								
								<c:choose>
										<c:when test="${assessment == null || assessment.sensitiveDataViewable}">
											<scannell:text value="${assessment.description}" />
										</c:when>
										<c:otherwise>
											<fmt:message key="assessment.confidential" />
											<input name="name" type="hidden" value="<c:out value="${command.description}"/>" />
										</c:otherwise>
									</c:choose></td>

								<td><fmt:message key="assessment.targetReviewDate" />:</td>
								<td colspan="2"><fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" /></td>
							</tr>
							<c:forEach items="${questions}" var="question" varStatus="s">
								<c:if test="${s.index mod 3 == 0}">
									<tr>
								</c:if>
								<c:choose>
									<c:when test="${question.answerType.name == 'option' and question.hasOptions == false}">
										<!-- Ignore when no active options available -->
									</c:when>
									<c:when test="${question.active and question.visible}">
										<td><c:out value="${question.name}" />:</td>
										<td id="answers[<c:out value="${question.id}"/>]" colspan="2"><enviromanager:answer question="${question}" answers="${assessment.answers}" /></td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${s.index mod 3 == 2}">
										</tr>
									</c:when>
									<c:otherwise>
										<c:if test="${s.last}">
											<c:choose>
												<c:when test="${s.index mod 3 == 0}">
													<td colspan="6"></td>
												</c:when>
												<c:otherwise>
													<td colspan="3"></td>
												</c:otherwise>
											</c:choose>
											</tr>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<tr>
								<td><fmt:message key="assessment.responsibleUser" />:</td>
								<td colspan="2"><c:out value="${assessment.responsibleUser.displayName}" /></td>

								<td><fmt:message key="assessment.approvalByUser" />:</td>
								<td colspan="2"><c:out value="${assessment.approvalByUser.displayName}" /></td>

								<td><fmt:message key="assessment.otherParticipants" />:</td>
								<td colspan="2"><c:out value="${assessment.otherParticipants}" /></td>
							</tr>
							<tr>
								<td><fmt:message key="assessment.createdBy" />:</td>
								<td colspan="2"><c:out value="${assessment.createdByUser.displayName}" /></td>
								<c:if test="${assessment.approved}">
									<td><fmt:message key="assessment.approvedBy" />:</td>
									<td colspan="2"><c:out value="${assessment.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
								</c:if>
								<td></td>
								<td></td>
								<%-- <td><fmt:message key="assessment.updatedBy" />:</td>
								<td colspan="3"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td> --%>
							</tr>
							<c:if test="${assessment.approved}" >
								<c:if test="${!printable || (printable && assessment.template.printableFieldApprovalComment)}">
									<tr>
									 	<td><fmt:message key="assessment.approvalComment" />:</td>
										<td colspan="8" ><scannell:text value="${assessment.approvalComment}" /></td>
									</tr>
								</c:if>
						  </c:if>
						  <c:if test="${!printable || (printable && assessment.template.printableFieldLinkDocument)}">
							  <tr>
							    <td><fmt:message key="linkedDocuments" />:</td>
							    <td colspan="8">
								    <c:set var="showLatest" value="false" scope="request"/>
							    	<jsp:include page="../doclink/showLinkedDocs.jsp" />
							    </td>
							  </tr>
						  </c:if>	
						</tbody>						
					</table>
				<!-- </div> -->
				<c:if test="${!printable || (printable && assessment.template.printableFieldRiskRating)}">
					<jsp:include page="showRiskRating.jsp" />
				</c:if>
			<!-- </div> -->
		</div>
		
		<a name="jobTable"></a>
		<div class="header">
			<h3>
				<fmt:message key="jobsActivities" />
			</h3>
		</div>
		<div class="content">
			<!-- <div class="table-responsive"> -->
				<!-- <div class="panel"> -->

					<table id="theJobTable" class="table table-bordered table-responsive printFont">
						<c:if test="${assessment.template.prefix !='SA'}">
							<tbody>
								<tr>
									<th><fmt:message key="assessment.job.description" /></th>
									<c:forEach items="${jobAnswers}" var="jobAnswer">
										<th><c:out value="${jobAnswer.question.name}" /></th>
									</c:forEach>
									<%-- <th><fmt:message key="assessment.job.hazard.tasks" /></th> --%>
									<%-- <th><fmt:message key="assessment.job.hazard.tasks.target.score" /></th> --%>
									<%-- <th><fmt:message key="assessment.job.activity" /></th> --%>
								</tr>								 
								<c:forEach items="${assessment.jobs}" var="job" varStatus="j">
									<c:set var="hTotal" value="${fn:length(job.hazards)}" />									
									<tr>
										<td rowspan="${hTotal+1}" style="word-wrap: break-word"><c:out value="${job.name}" />
										 <c:out value="${countVal}"></c:out> 
										<c:set var="jobID" value="${job.id}" />
											 <ul>
												<%-- <c:forEach items="${job.attachments}" var="item">
													<c:if test="${item.active}">
														<c:choose>
															<c:when test="${item.type.name == 'attach'}">
																<li><a target="attachment" href="<c:url value="viewAssessmentJobAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
																		<c:out value="${item.name}" />
																	</a></li>
															</c:when>
															<c:otherwise>
																<li><a target="attachment" href="<c:out value="${item.externalUrl}" />">
																		<c:out value="${item.name}" />
																	</a> - <c:out value="${item.description}" /></li>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:forEach> --%>
											</ul> 
											</td>
									</tr>
									<c:forEach items="${job.hazards}" var="hazard" varStatus="h">
									<c:if test="${hazard.job.id eq jobID}"   >
										<tr>
											<c:forEach items="${hazard.answers}" var="answer" varStatus="h">											
												<c:choose>
													<c:when test="${fn:contains(answer.question.codeName,'newrisk.job.rr.rating')}">
														<c:set var="threshold" value="${assessment.threshold}" />
														<c:set var="hazardScore" value="${answer.value}" />
														<td id="answers[<c:out value="${answer.question.id}"/>]" style="word-wrap: break-word"><c:choose>
																<c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == true && hazardScore ge threshold.upperLimit}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == false && hazardScore ge threshold.upperLimit}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == true && hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
																	<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
																</c:when>
																<c:when test="${hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:otherwise>
																	<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
																</c:otherwise>
															</c:choose> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" />
														</td>
													</c:when>
													<c:otherwise>
														<td id="answers[<c:out value="${answer.question.id}"/>]" class="expressAssessmentHazardColumn ${fn:replace(answer.question.codeName,'.','_')}">
															<div >
																<enviromanager:answer question="${answer.question}" answers="${hazard.answers}" />
															</div>
														</td>
													</c:otherwise>
												</c:choose>												
											</c:forEach>
											<%-- <td id="raTasks"><c:forEach items="${hazard.tasks}" var="task" varStatus="t">
													<c:set var="taskTrashStatus" value="<%=RiskStatus.TRASH%>" />
													<c:if test="${task.status != taskTrashStatus}">
														<a href="<c:url value="/risk/hazardTaskView.htm"><c:param name="id" value="${task.id}"/></c:url>">
															<c:out value="${task.displayId}" />
														</a>
														<br>(<fmt:message key="${task.status}" />)<br>
													</c:if>
												</c:forEach></td> --%>
											<%-- Removing as part of ENV-9255, see comments for possible changes that may need to be made in the future
											<td id="targetScore"><c:out value="${hazard.targetScore}" /></td> --%>
											<%-- <td id="activity"><risk:jobActivity revision="${assessment.revision}" hazard="${hazard}" editable="${urls != null}" /></td> --%>
										</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</tbody>
						</c:if>
						<c:if test="${assessment.template.prefix =='SA'}">
							<tbody>
								<tr>
									<c:forEach items="${jobAnswers}" var="jobAnswer">
										<c:if test="${not fn:containsIgnoreCase(jobAnswer.question.codeName, 'cf') and not fn:containsIgnoreCase(jobAnswer.question.codeName, 'CorrectedMagnitude')}">
											<td><c:out value="${jobAnswer.question.name}" /></td>
										</c:if>
									</c:forEach>
									<td><fmt:message key="assessment.job.control.factor" /></td>
									<td><fmt:message key="assessment.job.correctedMagnitude" /></td>
									<td><fmt:message key="assessment.job.activity" /></td>
								</tr>
								<c:set var="threshold" value="${assessment.threshold}" />
								<c:forEach items="${assessment.jobs}" var="job" varStatus="j">
									<tr>
										<c:forEach items="${job.hazards}" var="hazard" varStatus="h">
											<c:forEach items="${hazard.answers}" var="answer" varStatus="h">
												<c:if test="${not fn:containsIgnoreCase(answer.question.codeName, 'cf')}">
													<c:if test="${ not fn:containsIgnoreCase(answer.question.codeName, 'newrisk.job.rr.rating.consequence')}">
														<c:choose>
															<c:when test="${fn:contains(answer.question.codeName,'newrisk.job.rr.rating')}">
																<c:set var="threshold" value="${assessment.threshold}" />
																<c:set var="hazardScore" value="${answer.value}" />
																<td id="answers[<c:out value="${answer.question.id}"/>]" style="word-wrap: break-word"><c:choose>
																		<c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit}">
																			<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == true && hazardScore ge threshold.upperLimit}">
																			<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == false && hazardScore ge threshold.upperLimit}">
																			<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == true && hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
																			<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
																		</c:when>
																		<c:when test="${hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit}">
																			<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																		</c:when>
																		<c:otherwise>
																			<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
																		</c:otherwise>
																	</c:choose> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
															</c:when>
															<c:otherwise>
																<c:if test="${not fn:containsIgnoreCase(answer.question.codeName, 'CorrectedMagnitude')}">
																	<td id="answers[<c:out value="${answer.question.id}"/>]" class="expressAssessmentHazardColumn ${fn:replace(answer.question.codeName,'.','_')}">
																		<div style="width: 100%; word-wrap: break-word; overflow: hidden">
																			<enviromanager:answer question="${answer.question}" answers="${hazard.answers}" />
																		</div>
																	</td>
																</c:if>

															</c:otherwise>
														</c:choose>
													</c:if>
													<c:if test="${fn:containsIgnoreCase(answer.question.codeName, 'newrisk.job.rr.rating.consequence')}">
														<c:choose>
															<c:when test="${fn:contains(answer.question.codeName,'newrisk.job.rr.rating')}">
																<c:set var="threshold" value="${assessment.threshold}" />
																<c:set var="hazardScore" value="${answer.value}" />
																<td id="answers[<c:out value="${answer.question.id}"/>]" style="word-wrap: break-word"><c:choose>
																		<c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit/5}">
																			<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == true && hazardScore ge threshold.upperLimit/5}">
																			<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == false && hazardScore ge threshold.upperLimit/5}">
																			<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																		</c:when>
																		<c:when test="${assessment.template.critical == true && hazardScore lt threshold.upperLimit/5 and hazardScore ge threshold.lowerLimit/4}">
																			<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
																		</c:when>
																		<c:when test="${hazardScore lt threshold.upperLimit/5 and hazardScore ge threshold.lowerLimit/4}">
																			<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																		</c:when>
																		<c:otherwise>
																			<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
																		</c:otherwise>
																	</c:choose> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
															</c:when>
															<c:otherwise>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:if>
											</c:forEach>
										</c:forEach>

										<c:forEach items="${job.hazards}" var="hazard">
											<td><div style="word-wrap: break-word; overflow: hidden">
													<c:forEach items="${hazard.answers}" var="answer" varStatus="status">
														<c:if test="${fn:containsIgnoreCase(answer.question.codeName, 'cf')}">
															<a href="javascript:void(0)" onclick="document.getElementById('light${j.index}').style.display='block';document.getElementById('fade${j.index}').style.display='block'">
																<c:if test="${not fn:containsIgnoreCase(answer.question.codeName, 'Description')}">
																	<c:out value="${answer.question.name}" />
																</c:if>
															</a>| <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" />
															<br>

															<c:if test="${fn:containsIgnoreCase(answer.question.codeName, 'Description')}">
																<br>
															</c:if>

														</c:if>
													</c:forEach>
												</div></td>
											<td><c:forEach items="${hazard.answers}" var="answer" varStatus="status">
													<c:if test="${fn:containsIgnoreCase(answer.question.codeName, 'CorrectedMagnitude')}">
														<c:set var="threshold" value="${assessment.threshold}" />
														<c:set var="hazardScore" value="${answer.value}" />
														<td id="answers[<c:out value="${answer.question.id}"/>]"  word-wrap: break-word"><c:choose>
																<c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit/1}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == true && hazardScore ge threshold.upperLimit/1}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == false && hazardScore ge threshold.upperLimit/1}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${assessment.template.critical == true && hazardScore lt threshold.upperLimit/1 and hazardScore ge threshold.lowerLimit/1}">
																	<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
																</c:when>
																<c:when test="${hazardScore lt threshold.upperLimit/1 and hazardScore ge threshold.lowerLimit/1}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:otherwise>
																	<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
																</c:otherwise>
															</c:choose> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
													</c:if>
												</c:forEach></td>
											<td><a href="<c:url value="/risk/assessmentJobHazardEdit.htm"><c:param name="showId" value="${hazard.id}"/></c:url>">
													<fmt:message key="edit" />
												</a> <c:if test="${hazard.selectedHazardOptionId != 0}">
													<a href="<c:url value="javascript:viewLegislation(${hazard.selectedHazardOptionId})"></c:url>">
														<fmt:message key="hazard.viewLegislation" />
													</a>
												</c:if></td>
										</c:forEach>

									</tr>
								</c:forEach>
							</tbody>
						</c:if>
						<%-- <tfoot>
							<tr>
								<td colspan="20" class="center-label"><c:out value="${assessment.template.footer}" /></td>
							</tr>
						</tfoot> --%>
					</table>
				<!-- </div> -->
			<!-- </div> -->
		</div>

	</c:if>
	<%-- <c:if test="${!printable || (printable && assessment.template.printableFieldUploadedDocument)}">

		<div class="header">
			<h3>Attachments</h3>
		</div>
		<div class="content">
			<div class="table-responsive">

				<table class="table table-bordered table-responsive printFont">
					<col />

					<tbody>
						<c:forEach items="${assessment.attachments}" var="item">
							<tr>
								<c:if test="${item.active}">
									<td colspan="4"><c:choose>
											<c:when test="${item.type.name == 'attach'}">
												<a target="attachment" href="<c:url value="viewAssessmentAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
													<c:out value="${item.name}" />
												</a>
											</c:when>
											<c:otherwise>
												<a target="attachment" href="<c:out value="${item.externalUrl}" />">
													<c:out value="${item.name}" />
												</a>
											</c:otherwise>
										</c:choose></td>
									<td colspan="7"><c:out value="${item.description}" /></td>
								</c:if>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
	</c:if> --%>

	

</body>
</html>
