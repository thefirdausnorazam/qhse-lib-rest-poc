<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="assessmentStep3.title" /></title>
  <style type="text/css" media="all">
  	@import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
    @import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
    
    h2 {
		color:#CF3030 !important;
		font-size: 150% !important;;
	}
  </style>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type='text/javascript' src="<c:url value="/js/showHelp.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <script type="text/javascript">

  
  function onPageLoad() {
		var showReviewDateMesg = document.getElementById("showReviewDateMesg");
		if(showReviewDateMesg){
			showReviewDateMesg.style.display='none';	
		}
  }
  
  function saveOnly(){
	 jQuery('#saveOnly').val(true);
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
      if (subTables.length > 0) {
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
          		     var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1);
          		  }else{
          		      var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1 + (i * subTableGroup.length));
          	      }
          	  newTableRow.insertCell(0);
          	  var cell = newTableRow.insertCell(1);     
          	  cell.insertBefore(div,null);      
          	  div.style.display="block";           
  			   }	  
      	  }
      }
  }

  <%-- Open the two popup windows for Law and Data --%>
  function init() {
	checkForSubTables();
 
    showPopup();
    
  }

  function openPopup(url, windowName, w, h, x, y) {
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y;
    var win = window.open(url, windowName, att);
    win.focus();
  }
  
  jQuery(document).ready(function () {	 
	  jQuery("#theForm").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
		init();
		<c:if test="${assessment.template.attachmentDriven}">
			jQuery('#approveButton').attr("disabled", true);
		</c:if>
		  jQuery('#methodStatement').select2({width:'10%'});
		  
		  
		  setTimeout(loadPictogramList(), 1000); 
	});
var optionPictogramList = new Array();
function loadPictogramList(){
		var jsonData = new FormData();
		jQuery(".option-pictogram").each(function (){
			optionPictogramList.push(jQuery(this).attr("option_id"));
		});
		jsonData.append('optionIdList', optionPictogramList);
		var request = new XMLHttpRequest();
		request.open('POST', '<c:url value="/risk/loadPictogram.htm" />');
		request.send(jsonData);
		request.onreadystatechange = function() {
			
			if (request.readyState == XMLHttpRequest.DONE) {
				 if(request.status === 200){  //check if "OK" (200)
					if(request.responseText.indexOf("optionPictogram") > -1){
						var imageObjList = JSON.parse(request.responseText).optionPictogram;
						
						if(imageObjList.length > 0){
							for(var i = 0; i < imageObjList.length; i++){
								//alert(JSON.stringify(imageObjList[i]))
								jQuery(".option-pictogram-"+imageObjList[i].question).attr("src", "data:image/jpg;base64,"+imageObjList[i].imageInBase64);
							}
						}
						optionPictogramList=new Array();
					}
			     }
			}
	    }
	}

  function showPopup(){
	  
	  <%-- Open the two popup windows for Law and Data if the user has the correct licences --%>
	  <c:set var="assessment" value="${command.firstAssessment}" />
	  <c:if test="${!assessment.template.scorable}">
	  <c:forEach items="${licences}" var="item">
	    <c:choose>
	      <c:when test="${item=='law'}">
	        <c:set var="icdKeys" value="${command.icdMasterKeys}" />
	        <%if (pageContext.getAttribute("icdKeys") != null
										&& String
												.valueOf(
														pageContext
																.getAttribute("icdKeys"))
												.trim().length() > 0) {%>
	            var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
	            var params = '?raType=<c:out value="${assessment.template.businessArea.id}" />&icdKeys=<c:out value="${command.icdMasterKeys}" />&pageRisk=true';
	            openPopup(url + params, 'risk_legal', 800, 500, 0, 0);
	        <%}%>
	      </c:when>
	      <c:when test="${item=='data'}">
	        <c:choose>
	          <c:when test="${assessment.template.businessArea.id==1}">
	            openPopup('<c:url value="/survey/monitoringProgrammeViewCategories.htm?popup=true&type=env" />', 'risk_data', 500, 500, 0, 810);
	          </c:when>
	          <c:when test="${assessment.template.businessArea.id==2}">
	            openPopup('<c:url value="/survey/monitoringProgrammeViewCategories.htm?popup=true&type=hs" />', 'risk_data', 500, 500, 0, 810);
	          </c:when>
	        </c:choose>
	      </c:when>
	    </c:choose>
	  </c:forEach>
	  </c:if>
	     <fmt:message key="assessmentStep1.saveDataMsg" />
	  }
 
  function toggleApproveButton(){
	 if(jQuery('#methodStatement').val() == 'true'){
		 jQuery('#approveButton').attr("disabled", false);
		 jQuery('#commentLabel').text('<fmt:message key="assessment.approvalComment" />:'); 
		 jQuery('#textApprovalComment').show();
		 jQuery('#textRejectionComment').hide();
	 }else{
		 jQuery('#approveButton').attr("disabled", true);
		 jQuery('#commentLabel').text('<fmt:message key="assessment.rejectComment" />:'); 
		 jQuery('#textRejectionComment').show();
		 jQuery('#textApprovalComment').hide();
		 jQuery('#textRejectionComment').keyup(function () {
	           var maxLength = 249;
	           var text = jQuery(this).val();
	           var textLength = text.length;
	           if (textLength > maxLength) {
	        	   jQuery(this).val(text.substring(0, (maxLength)));   
	           }
	       });
	 }
  }
  
  </script>
</head>
<body>
 	<system:gdprBanner/>
 	
	<scannell:form id="theForm">
	<scannell:hidden path="saveOnly" id="saveOnly" />
		<div class="container-fluid">
			<div class="row">
				<ul class="raMenu">
					<c:choose>
						<c:when test="${assessment.id != null and assessment.editable}">
							<li><a
								href="<c:url value="/risk/assessmentStep1.htm"><c:param name="showId" value="${param.showId}" /></c:url>">&nbsp;Activity&nbsp;</a></li>
							<c:if test="${assessment.template.scorable}">
								<li><a
									href="<c:url value="/risk/assessmentStep2.htm"><c:param name="showId" value="${param.showId}" /></c:url>">&nbsp;Score
										&amp; Justification&nbsp;</a></li>
							</c:if>
							<li class="selected">Review &amp; Save &nbsp;<i class="fa fa-floppy-o 1g">&nbsp;</i></li>
						</c:when>
						<c:otherwise>
							<li>Activity</li>
							<c:if test="${assessment.template.scorable}">
								<li>Score &amp; Justification</li>
							</c:if>
							<li class="selected">Review &amp; Save</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel panel-danger">
					<table class="table  table-condensed table-bordered table-responsive table-hover ">
						<col />
						<tbody>
							<c:if test="${assessment.id != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
									<td id="assessmentId"><scannell:hidden path="id" writeRequiredHint="false" /> <scannell:hidden
											path="version" writeRequiredHint="false" /> <c:out value="${assessment.displayId}" /></td>

									<td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
									<td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
								</tr>
							</c:if>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
								<td valign="top" id="assessmentBusinessAreas" ${assessment.template.scorable ? "" : "colspan='3'"}><c:forEach
										var="ba" items="${assessment.businessAreas}">
										<c:out value="${ba.name}" />
									</c:forEach></td>
								<c:if test="${assessment.template.scorable}">
									<td class="scannellGeneralLabel" id="assessmentScore"><fmt:message key="assessment.score" />:</td>
									<td valign="top">
									     <c:if test="${assessment.nrag == null}"><c:set var="assessment" value="${assessment}" scope="request"/> 
										      <jsp:include page="showRiskScoreIcon.jsp" />
										        	  <c:out value="${assessment.score}" />
										       <jsp:include page="showRiskScoreText.jsp" /> 
									      </c:if>
									      <c:if test="${assessment.nrag != null && assessment.nrag != 'nocolor'}">
									      <img src="<c:url value="/images/risk/score_${assessment.nrag}light.giff" />" />
									      </c:if>
										</td>
								</c:if>
							</tr>

							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="assessment.name" />:</td>
								<td colspan="3" id="assessmentName"><c:choose>
										<c:when test="${assessment.sensitiveDataViewable}">
											<scannell:text value="${assessment.name}" />
										</c:when>
										<c:otherwise>
											<fmt:message key="assessment.confidential" />
											<input name="name" type="hidden" value="<c:out value="${assessment.name}"/>" />
										</c:otherwise>
									</c:choose></td>
							</tr>

							<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
								<c:if test="${g.active}">
									<c:if test="${g.name != null && g.name != ''}">
										<tr>
											<td colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}" /></td>
										</tr>
									</c:if>
									<c:forEach items="${g.questions}" var="q">
										<c:if test="${q.active and q.visible}">
											<c:if test="${q.id!=59 and q.id!=58}"> 
												<tr>
													<c:choose>
														<c:when test="${q.answerType.name == 'label'}">
															<td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
														</c:when>
														<c:otherwise>
															<td class="scannellGeneralLabel "><c:out value="${q.name}" />:</td>
															<td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}"
																	answers="${assessment.answers}" /></td>
														</c:otherwise>
													</c:choose>
												</tr>
												</c:if>
												
											<c:if test="${(q.id==59 or q.id==58) && enviromanager:getStringAnswer(q,assessment.answers) != null}"> 
												<tr>
													<c:choose>
														<c:when test="${q.answerType.name == 'label'}">
															<td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
														</c:when>
														<c:otherwise>
															<td class="scannellGeneralLabel "><c:out value="${q.name}" />:</td>
															<td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}"
																	answers="${assessment.answers}" /></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="assessment.targetReviewDate" /> 
									<c:if test="${assessment.approvable}">
										<img id="showReviewDateMesg" src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="<fmt:message key="risk.reviewDate.help"/>" /> 
									</c:if>
									</td>
								<td colspan="3">
								<c:choose>
										 <c:when test="${assessment.approvable and userInRole}">
											<div id="cal" style="width: 250px;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 200px;">
													<scannell:input class="form-control" path="targetReviewDate" id="targetReviewDate" readonly="true" />
													<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
												</div>

											</div>
											<div class="help" id="help" style="display: none; position: absolute;"></div>
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" />
										</c:otherwise>
									</c:choose>
									</td>
							</tr>
						<c:if test="${assessment.template.attachmentDriven}">
				  	  <c:if test="${!printable || (printable && assessment.template.printableFieldUploadedDocument)}">
						  <tr>
						    <td class="scannellGeneralLabel"><fmt:message key="attachedDocuments" />:</td>
						    <td colspan="3">
						     <ul>
						      <c:forEach items="${assessment.attachments}" var="item">
							  <c:if test="${item.active}">
							  <c:choose>
								<c:when test="${item.type.name == 'attach'}">
								  <li><a target="attachment" href="<c:url value="viewAssessmentAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
									<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /><c:if test="${assessment.template.multiApproval }"> -[From Rev-<c:out value="${item.revisionNumber}"></c:out> At <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />]</c:if> </li>
							    </c:when>
								<c:otherwise>
									<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
										<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /><c:if test="${assessment.template.multiApproval }"> -[From Rev-<c:out value="${item.revisionNumber}"></c:out> At <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />]</c:if></li>
								</c:otherwise>
							  </c:choose> 
							  </c:if>
							  </c:forEach>
							  </ul>
						    </td>
						  </tr>
					  </c:if>
					  </c:if>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
								<td id="assessmentResponsibleUser"><c:out value="${assessment.responsibleUser.displayName}" /></td>

								<td class="scannellGeneralLabel nowrap"><fmt:message key="assessment.otherParticipants" />:</td>
								<td id="assessmentOtherParticipants"><c:out value="${assessment.otherParticipants}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="assessment.approvalByUser" />:</td>
								<td colspan="3" id="assessmentApprovalByUser">
									<c:choose>
										<c:when test="${assessment.template.multiApproval}">
											<ul>
												<c:forEach items="${assessment.approvalUserList}" var="user">
													<li><c:out value="${user.displayName}" /></li>
												</c:forEach>
											</ul>
										</c:when>
										<c:otherwise><c:out value="${assessment.approvalByUser.displayName}" /></c:otherwise>
									</c:choose>
								</td>
							</tr>

							<tr>
								<c:choose>
									<c:when test="${assessment.createdByUser != null}">
										<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
										<td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message
												key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
									</c:when>
									<c:otherwise>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${assessment.lastUpdatedByUser != null}">
										<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
										<td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message
												key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
									</c:when>
									<c:otherwise>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</c:otherwise>
								</c:choose>
							</tr>
							<c:if test="${assessment.approvable || assessment.template.multiApproval}">
							<c:if test="${assessment.template.attachmentDriven || assessment.template.multiApproval}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="assessment.methodStatementReviewedPTW" />:</td>
									<td colspan="3">
									<select id="methodStatement" style="width:200px !important" name="methodStatement" onchange="toggleApproveButton()">
									<option value=""><fmt:message key="choose" /></option>
									<option value="true"><fmt:message key="yes" /></option>
									<option value="false"><fmt:message key="no" /></option>
									</select>
									<span class="requiredHinted">*</span>
									</td>
								</tr>
							</c:if>
								<tr>
									<td class="scannellGeneralLabel"><div id="commentLabel"><fmt:message key="assessment.approvalComment" />:</div></td>
									<td colspan="3" id="assessmentApprovalComment"><scannell:textarea id="textApprovalComment" path="approvalComment" cols="75" rows="3" cssStyle="float:left;width:50%"  class="form-control"/><scannell:textarea id="textRejectionComment" path="rejectionComment" cols="75" rows="3" cssStyle="display:none;float:left;width:50%"  class="form-control"/></td>
								</tr>
							</c:if>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="4" align="center"><c:if test="${assessment.approvable || assessment.template.multiApproval}">
								<input type="hidden" id="nrag" name="nrag" value="amber" />
										<input type="submit" id="approveButton" class="g-btn g-btn--primary" value="<fmt:message key="save&approve" />">
									</c:if> 
									<c:choose>
										<c:when test="${!assessment.trashed and !assessment.archived}">
											<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />" onclick="jQuery('#saveOnly').val(true);">
										</c:when>
										<c:otherwise>
											<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
										</c:otherwise>
									</c:choose>
   								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</scannell:form>

	<c:if test="${assessment.template.scorable}">
		<a name="scores"></a>
		<div class="content">
			<div class="form-group" style="margin-top: 10px">
				<div class="col-sm-3 scannellGeneralLabel">
					<fmt:message var="scoreComment" key="assessment.scoreComment" />
					<spring:message code="assessment[${assessment.template.id}].scoreComment" text="${scoreComment}" />
				</div>
				<div class="col-sm-6 scannellGeneralLabel">
					<scannell:text value="${assessment.scoreComment}" />
				</div>
			</div>
			<c:forEach items="${command.assessmentList}" var="assessment">
				<c:forEach items="${assessment.template.scoringCategories}" var="c">
				<div style="clear: both;"></div>
					<div class="form-group" style="margin-top: 10px">
						<div class="col-sm-12 scannellGeneralLabel scoringCategoryTitle">
							<c:out value="${c.name} " />
						</div>

					</div>

					<c:forEach items="${c.questions}" var="q">
						<c:remove var="score" />
						<c:forEach items="${assessment.scores}" var="s">
							<c:if test="${s.question.id == q.id}">
								<c:set var="score" value="${s}" />
							</c:if>
						</c:forEach>
<div style="clear: both;"></div>
						<div class="form-group" style="margin-top: 10px">
							<div class="col-sm-3 scannellGeneralLabel ">
								<c:out value="${q.name}" />
							</div>
							<div class="col-sm-6 scannellGeneralLabel">
								<c:out value="${score.selectedOption.name} - ${score.selectedOption.score}" />
								<br />
								<scannell:text value="${score.justification}" />
							</div>
						</div>
<div style="clear: both;"></div>
						<div class="form-group" ${score.tasks != null && fn:length(score.tasks) > 0 ? "":"style='display:none'"}>
							<ul id="actions">
								<c:forEach items="${score.tasks}" var="task">
									<c:if test="${not task.trashed}">
										<c:url var="viewTaskUrl" value="/risk/taskView.htm">
											<c:param name="id" value="${task.id}" />
										</c:url>
										<li><a href="<c:out value="${viewTaskUrl}" />"><c:out value="${task.displayId}" /></a> (<fmt:message
												key="${task.status}" />)</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>

					</c:forEach>
				</c:forEach>
			</c:forEach>
			<div style="clear: both;"></div>
			<div class="form-group">
				<div class="center-label">
					<c:out value="${command.assessmentList[0].template.footer}" />
				</div>

			</div>


		</div>
	</c:if>
	<c:if test="${command.assessmentList[0].template.name eq 'Health & Safety - Pre & Post Natal'}">
    <div class="form-group">
	<div class="center-label">
				<c:out value="${command.assessmentList[0].template.footer}" />
	</div>
	</div>
	</c:if>
</body>
</html>
