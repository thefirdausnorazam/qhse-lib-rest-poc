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
	  var fgName=jQuery('#A42').text();
	  document.getElementById("fg").textContent=fgName;	  
	  jQuery('.anchorColor').css( "color","#CF3030" );
		if(getURLParam('printable') == 'true') {
			jQuery('.matrixImageSize').css('width', '550px');
		}
		if(window.location.href.indexOf("printable=true") > -1) {
		    jQuery( ".panel-collapse" ).removeClass( "panel-collapse collapse out" )
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
	
	<c:if test="${assessment != null}">
	<div class="header">
<div class="row">
                         <div class="col-sm-2">
                                               <div class="avatar">
                                               <c:choose>
                                               	<c:when test="${imageEncoded == null}"><img src="<c:url value="/images/risk/riskPhoto.png" />" class="profile-avatar"/> </c:when>
                                               	<c:otherwise><div style="max-width: 200px;"><img  src="data:image/jpg;base64,${imageEncoded}" alt=""  style="max-width:100%;max-height:100%;"/></div></c:otherwise>
                                               </c:choose>    
</div>
</div>
<div class="col-sm-7">
<div class="personal"><h4><i  class=" fa fa-folder-open"></i><span id="fg" style="padding-left:5px;"></span></h4>
 
<h1 class="name"><c:out value="${assessment.name}" /></h1>
<p class="description"><c:out value="${assessment.description}"/></p><p></p>
</div></div>
<div class="col-sm-3">
  <p><c:out value="${assessment.displayId}"/></p>
 <c:set var="threshold" value="${assessment.threshold}" /> 
		<c:choose>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
		     <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#FE5D47 !important;" class="progress-bar progress-bar-danger"></div></div>
		      <%-- <img src="<c:url value="/images/risk/score_redlight.giff" />" /> --%>
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
		     <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#FFB700 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:when test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
		     <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#FE5D47 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		    <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#0080CC !important;" class="progress-bar progress-bar-danger"></div></div>
		     <%--  <img src="<c:url value="/images/risk/score_yellowlight.giff" />" /> --%>
		    </c:when>
		    <c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		      <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#FFB700 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:otherwise>
		    <div class="progress" style="width: 29%;"><div style="width: 100%;background-color:#00C030 !important;" class="progress-bar progress-bar-danger"></div></div>
		    <%-- <img src="<c:url value="/images/risk/score_greenlight.giff" />" /> --%>
		    </c:otherwise>
		 </c:choose> 
<h3>Highest Risk Rating Score  : <c:out value="${assessment.score}" /> </h3>
<p>Status: <fmt:message key="assessment${assessment.status}" /><br>Last Updated: <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy" />
<br>Target Review: <fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" /></p></div>
</div>
</div>
		<div class="content">
		<div class="panel-group accordion accordion-semi" id="accordion41">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse"
                           data-parent="#accordion3" href="#41">
                           <i class="fa fa-angle-right"></i> 
                           <span  class="badge">
                              <fmt:message key="assessment.approvalDetails" />
                           </span>
                        </a>
                     </h4>
                  </div>
                  <div id="41" class="panel-collapse collapse out"	>
                     <div class="panel-body">
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

								<td><fmt:message key="assessment.scope" />:</td>
								<td colspan="2"><c:choose>
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
							<c:if test="${!printable || (printable && assessment.template.printableFieldLinkDocument)}">
							  	<tr>
							    	<td><fmt:message key="linkedDocuments" />:</td>
							    	<td colspan="3">
							    		<jsp:include page="../doclink/showLinkedDocs.jsp" />
							    	</td>
							  	</tr>
						  	</c:if>
							<tr>
								<td><fmt:message key="assessment.createdBy" />:</td>
								<td colspan="2"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								<c:if test="${assessment.approved}">
									<td><fmt:message key="assessment.approvedBy" />:</td>
									<td colspan="2"><c:out value="${assessment.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
								</c:if>
								<c:choose>
									<c:when test="${assessment.lastUpdatedByUser != null}">
										<td><fmt:message key="assessment.updatedBy" />:</td>
										<td colspan="3"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
									</c:when>
									<c:otherwise>
										<td></td>
										<td colspan="3"></td>
									</c:otherwise>
								</c:choose>
							</tr>
							<c:if test="${assessment.approved}" >
								<c:if test="${!printable || (printable && assessment.template.printableFieldApprovalComment)}">
									<tr>
									 	<td><fmt:message key="assessment.approvalComment" />:</td>
										<td colspan="8" ><scannell:text value="${assessment.approvalComment}" /></td>
									</tr>
								</c:if>
						  </c:if>
						</tbody>
						<%-- <tfoot>
							<c:if test="${!printable}">
								<tr>
									<td colspan="9"><c:choose>
											<c:when test="${urls != null}">
												<scannell:url urls="${urls}" />
											</c:when>
											<c:otherwise>
												<fmt:message key="assessment" />
												<fmt:message key="notCurrentSelectedSiteMsg">
													<fmt:param value="${assessment.site.name}" />
												</fmt:message>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:if>
						</tfoot> --%>
					</table>
                     </div>
                     <!-- Panel Body -->
                  </div>
               </div>
</div>	


				<div class="content" >
                  <c:if test="${!printable}">			
					<c:choose>
					<c:when test="${urls != null}">
					<scannell:url urls="${urls}" />
					</c:when>
					<c:otherwise>
					<fmt:message key="assessment" />
					<fmt:message key="notCurrentSelectedSiteMsg">
					<fmt:param value="${assessment.site.name}" />
					</fmt:message>
					</c:otherwise>
					</c:choose>				
			       </c:if>
</div> 				
				
				<c:if test="${!printable || (printable && assessment.template.printableFieldRiskRating)}">
				<div class="content" >
					<jsp:include page="showRiskRating.jsp" />
					</div>
				</c:if>
			
		</div>
		 
		
		<a name="jobTable"></a>
		<div class="header">
			<h3>
				<fmt:message key="jobsActivities" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">

					<table id="theJobTable" class="table table-bordered table-responsive printFont">
						<c:if test="${assessment.template.prefix !='SA'}">
							<tbody>
								<tr>
									<c:choose>
									<c:when test="${QMSA ==null }">
										<td class="wrapText"><fmt:message key="assessment.job.description" /></td>
									</c:when>
									<c:otherwise>
										<td class="wrapText"><fmt:message key="assessment.pestel" /></td>
									</c:otherwise>
									</c:choose>
									
									<c:forEach items="${jobAnswers}" var="jobAnswer">
										<td><c:out value="${jobAnswer.question.name}" /></td>
									</c:forEach>
									<td><fmt:message key="assessment.job.hazard.tasks" /></td>
									<td><fmt:message key="assessment.job.hazard.tasks.target.score" /></td>
									<td><fmt:message key="assessment.job.activity" /></td>
								</tr>
								<c:forEach items="${assessment.jobs}" var="job" varStatus="j">
									<c:set var="hTotal" value="${fn:length(job.hazards)}" />
									<tr>
										<td rowspan="${hTotal+1}" style="word-wrap: break-word; width:15%">
										<a href="<c:url value="/risk/editAssessmentJob.htm"><c:param name="showId" value="${assessment.id}"/><c:param name="jobId" value="${job.id}"/></c:url>">
													<div class="desc" style="white-space: pre;white-space: pre-line;"><c:out value="${job.name}"/></div>	
										</a>				
											<ul>
												<c:forEach items="${job.attachments}" var="item">
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
												</c:forEach>
											</ul>											
											<c:if test="${not empty job.stringPicture}">
				                           <div style="width:1px;"><img class="printImageSize" src="data:image/jpg;base64,${job.stringPicture}" alt="" border=3 height=100 width=100/></div>
				                           </c:if>
											
											</td>
									</tr>
									<c:forEach items="${job.hazards}" var="hazard" varStatus="h">
										<tr>
											<c:forEach items="${hazard.answers}" var="answer" varStatus="h">
												<c:choose>
													<c:when test="${fn:contains(answer.question.codeName,'newrisk.job.rr.rating') || fn:contains(answer.question.codeName,'newrisk.job.rr2.rating')}">
														<c:set var="threshold" value="${assessment.threshold}" />
														<c:set var="hazardScore" value="${answer.value}" />
														<td id="answers[<c:out value="${answer.question.id}"/>]" style="word-wrap: break-word"><c:choose>
																<c:when test="${assessment.template.critical == true && hazardScore ge threshold.criticalLimit}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${(assessment.template.critical == true && hazardScore ge threshold.upperLimit) || (assessment.template.prefix == 'HSIRR' && (assessment.template.critical == true && hazardScore ge threshold.hazardUpperLimit))}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:when test="${(assessment.template.critical == false && hazardScore ge threshold.upperLimit) || (assessment.template.prefix == 'HSIRR' && (assessment.template.critical == false && hazardScore ge threshold.hazardUpperLimit))}">
																	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
																</c:when>
																<c:when test="${(assessment.template.critical == true && hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit) || (assessment.template.prefix == 'HSIRR' && (assessment.template.critical == true && hazardScore lt threshold.hazardUpperLimit and hazardScore ge threshold.hazardLowerLimit))}">
																	<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
																</c:when>
																<c:when test="${(hazardScore lt threshold.upperLimit and hazardScore ge threshold.lowerLimit) ||  (assessment.template.prefix == 'HSIRR' && (hazardScore lt threshold.hazardUpperLimit and hazardScore ge threshold.hazardLowerLimit))}">
																	<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
																</c:when>
																<c:otherwise>
																	<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
																</c:otherwise>
															</c:choose> <enviromanager:answer question="${answer.question}" answers="${hazard.answers}" /></td>
													</c:when>
													<c:otherwise>
														<td id="answers[<c:out value="${answer.question.id}"/>]" class="expressAssessmentHazardColumn ${fn:replace(answer.question.codeName,'.','_')}">
															<div class="wrapText">
																<enviromanager:answer question="${answer.question}" answers="${hazard.answers}" />
															</div>
														</td>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<td id="raTasks"><c:forEach items="${hazard.tasks}" var="task" varStatus="t">
													<c:set var="taskTrashStatus" value="<%=RiskStatus.TRASH%>" />
													<c:if test="${task.status != taskTrashStatus}">
														<a href="<c:url value="/risk/hazardTaskView.htm"><c:param name="id" value="${task.id}"/></c:url>">
															<c:out value="${task.displayId}" />
														</a>
														<br>(<fmt:message key="${task.status}" />)<br>
													</c:if>
												</c:forEach></td>
											<td id="targetScore"><c:out value="${hazard.targetScore}" /></td>
											<td id="activity"><risk:jobActivity hazard="${hazard}" editable="${assessment.taskAddable}" />
											</td>
										</tr>
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
														<td id="answers[<c:out value="${answer.question.id}"/>]"  word-wrap: break-word><c:choose>
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
						<tfoot>
							<tr>
								<td colspan="20" class="center-label"><c:out value="${assessment.template.footer}" /></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>

	</c:if>
	<c:if test="${!printable || (printable && assessment.template.printableFieldLinkDocument)}">
		  <c:if test="${ not empty docLinkHolderTemplate}">
				<div class="header">
					<h3><fmt:message key="linkedDocumentsTemplate" /></h3>
				</div>
				<div class="content">
					<div class="table-responsive">
						<table class="table table-bordered table-responsive printFont">
							<col />
							<tbody>
								<tr>
									<td colspan="4"><jsp:include page="../doclink/showLinkedDocsForTemplate.jsp" /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
	</c:if>
	<c:if test="${!printable || (printable && assessment.template.printableFieldUploadedDocument)}">
		<div class="header">
			<h3><fmt:message key="attachments" /></h3>
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
	</c:if>

	<c:if test="${!printable || (printable && assessment.template.printableFieldAssociatedRiskAssessment)}">
		<c:if test="${not empty sortedAssociatedAssessments}">
			<a name="associatedAssessments"></a>
			<c:set var="first" value="${false}" />
			<c:set var="last" value="${null}" />
			<c:forEach items="${sortedAssociatedAssessments}" var="assessment" varStatus="s">
				<c:if test="${assessment.template != last.template}">
					<c:choose>
						<c:when test="${first == false}">
							<c:set var="first" value="${true}" />
						</c:when>
						<c:otherwise>
							</tbody>
							</table>
							</div>
							</div>
							</div>
						</c:otherwise>
					</c:choose>
					<div class="header">
						<h3>
							<fmt:message key="assessment.associatedAssessments" />
							-
							<c:out value="${assessment.template.name}" />
						</h3>
					</div>
					<div class="content">
						<div class="table-responsive">
							<div class="panel">
								<table class="table table-bordered table-responsive printFont">
									<thead>

										<tr>
											<th><fmt:message key="id" /> / <fmt:message key="assessment.name" /></th>
											<c:forEach items="${assessment.template.summaryQuestions}" var="sq">
												<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
													<c:if test="${g.active}">
														<c:forEach items="${g.questions}" var="q">
															<c:if test="${sq.id == q.id and q.active and q.visible}">
																<th><c:out value="${sq.name}" /></th>
															</c:if>
															<c:if test="${!empty q.columns}">
																<c:forEach items="${q.columns}" var="childQ">
																	<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
																		<th><c:out value="${sq.name}" /></th>
																	</c:if>
																</c:forEach>
															</c:if>
														</c:forEach>
													</c:if>
												</c:forEach>

											</c:forEach>
											<th><fmt:message key="assessment.status" /></th>
											<th><fmt:message key="assessment.responsibleUser" /></th>
											<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
												<th><fmt:message key="assessment.score" /></th>
											</c:if>
										</tr>
									</thead>
									<tbody id="questionsTbody">
										</c:if>
										<c:choose>
											<c:when test="${s.index mod 2 == 0}">
												<c:set var="style" value="even" />
											</c:when>
											<c:otherwise>
												<c:set var="style" value="odd" />
											</c:otherwise>
										</c:choose>
										<tr class="<c:out value="${style}" />">
											<td><a href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>">
													<c:out value="${assessment.displayId}" />
												</a><br> <c:if test="${assessment.confidential}">
													<fmt:message key="assessment.confidential" />
												</c:if>
												<c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
												</td>

											<c:forEach items="${assessment.template.summaryQuestions}" var="sq">
												<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
													<c:if test="${g.active}">
														<c:forEach items="${g.questions}" var="q">
															<c:if test="${sq.id == q.id and q.active and q.visible}">
																<td><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
															</c:if>
															<c:if test="${!empty q.columns}">
																<c:forEach items="${q.columns}" var="childQ">
																	<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
																		<td><enviromanager:answer question="${childQ}" answers="${assessment.answers}" /></td>
																	</c:if>
																</c:forEach>
															</c:if>
														</c:forEach>
													</c:if>
												</c:forEach>
											</c:forEach>

											<td><fmt:message key="assessment${assessment.status}" /></td>
											<td><c:out value="${assessment.responsibleUser.displayName}" /></td>
											<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
												<td class="nowrap"><c:set var="threshold" value="${assessment.threshold}" /> <c:choose>
														<c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
															<img src="<c:url value="/images/risk/score_redlight.giff" />" />
														</c:when>
														<c:when test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
															<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
														</c:when>
														<c:when test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
															<img src="<c:url value="/images/risk/score_redlight.giff" />" />
														</c:when>
														<c:when test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
															<img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
														</c:when>
														<c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
															<img src="<c:url value="/images/risk/score_amberlight.giff" />" />
														</c:when>
														<c:otherwise>
															<img src="<c:url value="/images/risk/score_greenlight.giff" />" />
														</c:otherwise>
													</c:choose> <c:out value="${assessment.score}" /></td>
											</c:if>
										</tr>

										<c:set var="last" value="${assessment}" />
										<c:if test="${s.last}">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
	</c:if>

	</tbody>
	</table>
	<c:if test="${assessment.template.prefix =='SA'}">
		<c:forEach items="${assessment.jobs}" var="job" varStatus="j">
			<div id="light${j.index}" class="white_content">
				<table id="ControlFactor" class="viewForm bordered printFont">
					<thead>
						<tr>
							<td colspan="3" align="left">Control Factor Values</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 100%">Control Factor</td>
							<td style="width: 100%">Value</td>
							<td style="width: 100%">Description</td>
						</tr>
						<c:forEach items="${assessment.jobs[j.index].hazards}" var="hazard2">
							<c:forEach items="${hazard2.answers}" var="answer2" varStatus="status">
								<c:if test="${fn:containsIgnoreCase(answer2.question.codeName, 'cf') and not fn:containsIgnoreCase(answer2.question.codeName, 'Description')}">
									<tr>
										<td style="width: 100%"><c:out value="${hazard2.answers[status.index].question.name}" /></td>
										<td style="width: 100%"><enviromanager:answer question="${hazard2.answers[status.index].question}" answers="${hazard2.answers}" /></td>
										<td style="width: 100%; word-wrap: break-word;"><enviromanager:answer question="${hazard2.answers[status.index+1].question}" answers="${hazard2.answers}" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>

				<a href="javascript:void(0)" onclick="document.getElementById('light${j.index}').style.display='none';document.getElementById('fade${j.index}').style.display='none'">Close</a>
			</div>
			<div id="fade${j.index}" class="black_overlay" onclick="document.getElementById('light${j.index}').style.display='none';document.getElementById('fade${j.index}').style.display='none'">
				<a href="#" class="fill-div"></a>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${!printable || (printable && assessment.template.printableFieldRiskMatrix)}">
		<jsp:include page="showMatrix.jsp" />
	</c:if>
</div>
</body>
</html>
