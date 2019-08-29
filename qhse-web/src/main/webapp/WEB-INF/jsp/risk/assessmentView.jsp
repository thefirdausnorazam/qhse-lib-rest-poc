<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
.printImageSize {
	max-width: 550px; width:550px
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
  <script type='text/javascript' src="<c:url value="/js/showHelp.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function(){	
	  jQuery('.newAssTable').each(function (){ 
		  var assColspan = jQuery(this).find('> thead').find("> tr > th").length;
		  jQuery(this).find("> tfoot tr td").attr('colSpan', assColspan);
	  });
	  
	  
	  initSortTables();
	  var fgName=jQuery('#A42').text();	 
	  if(fgName){
		  document.getElementById("fg").textContent=fgName;	
		  jQuery('#fgTitle').show();
	  }else{
		  jQuery('#fgTitle').hide();
	  }
	    
	  jQuery('.anchorColor').css( "color","#CF3030" );
	  if(jQuery("#A44").length != 0) {
		  var title=jQuery('#A44').text();	  
		  document.getElementById("assessmentTitle").textContent=title;		  
		}else if(jQuery("#A51").length != 0){
			var titleItem=jQuery('#A51').text();			
			  document.getElementById("assessmentTitle").textContent=titleItem;	
		}	  
	  else{
		  var templateName='<c:out value="${assessment.template.name}" />';	
		  var desired=templateName.replace(/amp;/i, " ").replace(/amp;/i, " ");
		  //alert(desired);
		  document.getElementById("assessmentTitle").textContent=desired;
		}
		init();
		if(getURLParam('printable') == 'true') {
			jQuery('.matrixImageSize').css('width', '550px');
		}
		
		if(window.location.href.indexOf("printable=true") > -1) {
		    jQuery( ".panel-collapse" ).removeClass( "panel-collapse collapse out" )
		}
		
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
  
	  <c:url var="url" value="/risk/assessmentAccessLevel.htm">
	    <c:if test="${assessment.accessLevel != null}"><c:param name="showId" value="${assessment.accessLevel.id}" /></c:if>
	    <c:param name="ownerId" value="${assessment.id}" />
	  </c:url>

	  <c:url var="attachment" value="/risk/addRiskAttachment.htm">
		    <c:param name="showId" value="${assessment.id}"/>
	  </c:url>
	  
	<c:url var="rescore" value="/risk/assessmentStep2.htm">
		  <c:param name="showId" value="${assessment.id}"/>
	</c:url>
  function openAccessLevelWindow() {
    var url = '<c:out value="${url}" />';
    window.location = url;
    //openPopup(url, 700, 400);
  }

  function viewLegislation() {
    var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
    var params = '?raType=<c:out value="${assessment.template.businessArea.id}" />&icdKeys=<c:out value="${assessment.icdMasterKeys}" />&pageRisk=true';
    openPopup(url + params, 1000, 600);
  }
  //jira 4977: reincluding these 2 methods that were missing
  function openPopup(url, w, h) {
	    var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
	    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
	    var win = window.open(url, "links", att);
	    win.focus();
	  }

	  function onPopupClose(){
	    <c:url var="url" value="/risk/assessmentView.htm">
	      <c:param name="id" value="${param.id}" />
	    </c:url>
	    window.location.href = "<c:out value="${url}" />";
	  }
//////
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
  function init() {
	    checkForSubTables();
  }  
  </script>

  <style type="text/css" media="all">   
    @import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
    @import "<c:url value='/css/risk.css'/>";
  </style>
</head>
<body><div class="page">
<div class="header">
<c:if test="${latestAssessmentRevision != null}">
<h3>
 <fmt:message key="assessment" />
 </h3>
 </c:if>
<c:if test="${latestAssessmentRevision == null}">
<div class="row">
<div class="col-sm-2">
<div class="avatar">
<c:choose>
    <c:when test="${imageEncoded == null}"><img src="<c:url value="/images/risk/riskPhoto.png" />" class="profile-avatar"/> </c:when>
    <c:otherwise><div style="max-width: 200px;"><img  src="data:image/jpg;base64,${imageEncoded}" alt=""  style="max-width:100%;max-height:100%;"/></div></c:otherwise>
  </c:choose>      
</div>
</div>
<div class="col-sm-7" >
<div class="personal"><h4><i id="fgTitle"  class=" fa fa-folder-open"></i>
<span id="fg" style="padding-left:5px;"></span></h4> 
<h1 class="name" id="assessmentTitle"></h1>
<p class="description"><c:out value="${assessment.name}"/></p><p></p>
</div>
</div>
<div class="col-sm-3">
  <p><c:out value="${assessment.displayId}"/></p>
 <c:set var="threshold" value="${assessment.threshold}" /> 
 <c:if test="${assessment.template.scorable == true}">
		<c:choose>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
		     <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#FE5D47 !important;" class="progress-bar progress-bar-danger"></div></div>
		      <%-- <img src="<c:url value="/images/risk/score_redlight.giff" />" /> --%>
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
		     <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#FFB700 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:when test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
		     <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#FE5D47 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		    <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#0080CC !important;" class="progress-bar progress-bar-danger"></div></div>
		     <%--  <img src="<c:url value="/images/risk/score_yellowlight.giff" />" /> --%>
		    </c:when>
		    <c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		      <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#FFB700 !important;" class="progress-bar progress-bar-danger"></div></div>
		    </c:when>
		    <c:otherwise>
		    <div class="progress" style="width: 30%;"><div style="width: 100%;background-color:#00C030 !important;" class="progress-bar progress-bar-danger"></div></div>
		    <%-- <img src="<c:url value="/images/risk/score_greenlight.giff" />" /> --%>
		    </c:otherwise>
		</c:choose>  
		
		
<h3><c:if test="${assessment.template.prefix != 'PTW' && assessment.template.prefix != 'RAPtW'}">Risk Rating  :<c:out value="${assessment.score}" /> </c:if></h3>
</c:if>
<p>Status: <fmt:message key="assessment${assessment.status}" /><br>Last Updated:  <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy" />
<br>Target Review: <fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" /></p></div>
</div>
</c:if>
</div>



<div class="content"> 
<div class="table-responsive">
<c:if test="${latestAssessmentRevision != null}">
<div class="header nowrap">
<!-- <h3> -->
<%-- <fmt:message key="assessment" /> --%>
<!-- </h3> -->
</div>
<table class="table table-bordered table-responsive printFont" >
<col  />

<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
      <c:url var="assessmentViewUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${latestAssessmentRevision.id}" /></c:url>
      <a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${latestAssessmentRevision.displayId}" /></a>
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td><fmt:message key="assessment${latestAssessmentRevision.status}" /></td>
  </tr>  
  <c:if test="${showLegacyId}">
  <tr>
  <td class="scannellGeneralLabel"><fmt:message key="legacyId" /></td>
      <td>
      <c:url var="assessmentViewUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${latestAssessmentRevision.id}" /></c:url>
      <a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${latestAssessmentRevision.legacyId}" /></a>
    </td>
    </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td valign="top">
      <c:forEach var="ba" items="${latestAssessmentRevision.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
    <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
    <td class="scannellGeneralLabel"><fmt:message key="assessment.score" />:</td>
    <td valign="top">
      <jsp:include page="showLastestRiskScoreIcon.jsp" /> 
      <c:if test="${latestAssessmentRevision.nrag == null}">
      <c:out value="${latestAssessmentRevision.score}" />
      </c:if>
      
    </td>
    </c:if>
  </tr>

  <tr>
    <td class="scannellGeneralLabel" width="150px"><fmt:message key="assessment.name" />:</td>
    <td colspan="3"><scannell:text value="${latestAssessmentRevision.name}" /></td>
  </tr>
  
  

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${latestAssessmentRevision.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.otherParticipants" />:</td>
    <td><c:out value="${latestAssessmentRevision.otherParticipants}" /></td>
  </tr>
</tbody>
</table>

<%-- Only display the completed task when displaying an assessment revision (i.e. history) --%>
<c:if test="${assessment.completedTask != null}">
<table class="table table-bordered table-responsive printFont" style="margin-top:0px;">
<col class="label" />
<thead>
  <tr><td colspan="6"><fmt:message key="task.completed" /></td></tr>
</thead>
<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td>
      <c:url var="assessmentViewUrl" value="/risk/taskView.htm"><c:param name="id" value="${assessment.completedTask.id}" /></c:url>
      <a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${assessment.completedTask.displayId}" /></a>
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${assessment.completedTask.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="${assessment.completedTask.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.name" />:</td>
    <td colspan="5"><scannell:text value="${assessment.completedTask.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="task.completionComment" />:</td>
    <td colspan="5"><scannell:text value="${assessment.completedTask.completionComment}" /></td>
  </tr>
</tbody>
</table>
</c:if>
</c:if>

<a name="assessment"></a>
<div class="header nowrap" ${latestAssessmentRevision != null ? "" : "style='display:none'"}>
<h3>
<c:if test="${latestAssessmentRevision == null}"><fmt:message key="assessment" /></c:if>
<c:if test="${latestAssessmentRevision != null}"><fmt:message key="assessmentRevision" /></c:if>
</h3>
</div>
<c:if test="${latestAssessmentRevision == null}">
<div class="panel-group accordion accordion-semi" id="accordion41">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse"
                           data-parent="#accordion3" href="#41">
                           <i class="fa fa-angle-right"></i> 
                           <span  class="badge">
                              Approval & Other Details                            
                           </span>
                           
                        </a>
                     </h4>
                  </div>
                  <div id="41" class="panel-collapse collapse out"	>
                     <div class="panel-body">
                   <table class="table table-bordered table-responsive printFont">
  
 
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td id="assessmentId"><c:out value="${assessment.displayId}" />
    	<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
    </td>
    

    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>

  <c:if test="${showLegacyId}">
	  <tr>
		  <td class="scannellGeneralLabel"><fmt:message key="legacyId" /></td>
		  <td colspan="3">
		      <c:out value="${assessment.legacyId}" />
		  </td>
	  </tr>
  </c:if>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td valign="top" id="assessmentBusinessAreas" ${assessment.template.scorable and assessment.template.prefix !='SA' ? "":"colspan='3'"}>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
    <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
    <td class="scannellGeneralLabel" id="assessmentScore"><fmt:message key="assessment.score" />:</td>
    <td valign="top">
     <c:if test="${assessment.nrag == null}">
	      <jsp:include page="showRiskScoreIcon.jsp" /> 
	        	  <c:if test="${assessment.template.multiApproval == false}"><c:out value="${assessment.score}" /> </c:if>
	       <jsp:include page="showRiskScoreText.jsp" /> 
      </c:if>
      <c:if test="${assessment.nrag != null && assessment.nrag != 'nocolor'}">
      <img src="<c:url value="/images/risk/score_${assessment.nrag}light.giff" />" />
      </c:if>
	 <c:if test="${assessment.nrag == 'nocolor'}">
		&nbsp&nbsp(Next Step:  <a href="<c:out value="${attachment}"/>">Add Attachment</a>-Company Method Statement
		&amp;
        <a href="<c:out value="${rescore}"/>">Rescore.)</a>
	   </c:if>
	   	<c:if test="${assessment.nrag == 'red'}">
		&nbsp&nbsp<fmt:message key="assessment.PtWStatus.${assessment.nrag}.next"/>
	   </c:if>
	   <c:if test="${assessment.nrag == 'amber'}">
		&nbsp&nbsp(Next Step: <a href="<c:out value="${attachment}"/>">Add Attachment</a>-Job Risk Assessment to turn Green.)
	   </c:if>
    </td>
    </c:if>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.name" />:</td>
    <td colspan="3" id="assessmentName">
		<c:choose>
			<c:when test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
			<c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
		</c:choose>
    </td>
  </tr>

  <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
      <c:if test="${g.name != null && g.name != ''}">
      <tr><td colspan="4" class="scannellGeneralLabel"  style="background-color:#DDDDDD;font-weight:bold;"><c:out value="${g.name}"/></td></tr>
      </c:if>
      <c:forEach items="${g.questions}" var="q">
        <c:if test="${q.active and q.visible}">
         <c:if test="${q.id!=59 and q.id!=58}"> 
          <tr>
          <c:choose>
            <c:when test="${q.answerType.name == 'label'}">
              <td  colspan="4" class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
            </c:when>
            <c:otherwise>
              <td class="scannellGeneralLabel"><c:out value="${q.name}" />:</td>
              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
            </c:otherwise>
          </c:choose>
          </tr>
       </c:if> 
       <c:if test="${(q.id==59 or q.id==58) && enviromanager:getStringAnswer(q,assessment.answers) != null}">
         <tr>
          <c:choose>
            <c:when test="${q.answerType.name == 'label'}">
              <td  colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
            </c:when>
            <c:otherwise>
              <td class="scannellGeneralLabel "><c:out value="${q.name}" />:</td>
              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
            </c:otherwise>
          </c:choose>
          </tr>
       </c:if>
       
       </c:if>
      </c:forEach>
    </c:if>
  </c:forEach>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser"><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><c:out value="${assessment.otherParticipants}" /></td>
  </tr>
  
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvalByUser" />:</td>
    <td colspan="3" id="assessmentApprovalByUser"><c:out value="${assessment.approvalByUser.displayName}" /></td>
    
  </tr>

  <c:if test="${assessment.approved}" >
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvedBy" />:</td>
	    <td  colspan="3" id="assessmentApprovedBy"><c:out value="${assessment.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
	  </tr>
		<c:if test="${!printable || (printable && assessment.template.printableFieldApprovalComment)}">
			<tr>
			 	<td class="scannellGeneralLabel"><fmt:message key="assessment.approvalComment" />:</td>
				<td colspan="3" id="assessmentApprovalComment"><scannell:text value="${assessment.approvalComment}" /></td>
			</tr>				
		</c:if>
  </c:if>

  <c:if test="${assessment['class'].name != 'com.scannellsolutions.modules.risk.domain.impl.RiskAssessmentRevisionImpl'}">
	  <c:if test="${!printable || (printable && assessment.template.printableFieldLinkDocument)}">
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
		    <td colspan="3"><jsp:include page="../doclink/showLinkedDocs.jsp"/></td>
		  </tr>
		  <c:if test="${ not empty docLinkHolderTemplate}">
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="linkedDocumentsTemplate" />:</td>
		    <td colspan="3"><jsp:include page="../doclink/showLinkedDocsForTemplate.jsp" /></td>
		  </tr>
		  </c:if>
	  </c:if>
	  <c:if test="${!printable || (printable && assessment.template.printableFieldUploadedDocument)}">
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="uploadedDocuments" />:</td>
		    <td colspan="3">
		     <ul>
		      <c:forEach items="${assessment.attachments}" var="item">
			  <c:if test="${item.active}">
			  <c:choose>
				<c:when test="${item.type.name == 'attach'}">
				  <li><a target="attachment" href="<c:url value="viewAssessmentAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
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
	  </c:if>
  
	  <tr>
	  	<td class="scannellGeneralLabel"><fmt:message key="assessment.targetReviewDate" />:</td>
	    <td id="targetReviewDate"  colspan="3"><fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" /></td>
	  </tr>
	  <c:if test="${not empty assessment.reviews}" >
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="assessment.lastReviewedBy" />:</td>
		    <td colspan="3" id="assessmentLastReviewedBy"><c:out value="${assessment.reviews[0].createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.reviews[0].date}" pattern="dd-MMM-yyyy" /></td>
		  </tr>
  	  </c:if>

	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
	    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	
	    <c:if test="${assessment.lastUpdatedByUser != null}">
	    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
	    <td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	    </c:if>
	  </tr>
  </c:if>  
  </tbody>  
</table>
                     </div>
                     <!-- Panel Body -->
                  </div>
               </div>
         </div><!--  END -->
</c:if>  
<c:if test="${latestAssessmentRevision != null}">      
                   <table class="table table-bordered table-responsive printFont">
  
 
  <tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td id="assessmentId"><c:out value="${assessment.displayId}" />
    	<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
    </td>
    

    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td valign="top" id="assessmentBusinessAreas" ${assessment.template.scorable and assessment.template.prefix !='SA' ? "":"colspan='3'"}>
      <c:forEach var="ba" items="${latestAssessmentRevision.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
    <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
    <td class="scannellGeneralLabel" id="assessmentScore"><fmt:message key="assessment.score" />:</td>
    <td valign="top">
     <c:if test="${assessment.nrag == null}">
	      <jsp:include page="showRiskScoreIcon.jsp" /> 
	        	  <c:if test="${assessment.template.multiApproval == false && (assessment.template.prefix !='PTW' && assessment.template.prefix !='RAPtW')}"><c:out value="${assessment.score}" /> </c:if>
	       <jsp:include page="showRiskScoreText.jsp" /> 
      </c:if>
      <c:if test="${assessment.nrag != null && assessment.nrag != 'nocolor'}">
      <img src="<c:url value="/images/risk/score_${assessment.nrag}light.giff" />" />
      </c:if>
	 <c:if test="${assessment.nrag == 'nocolor'}">
		&nbsp&nbsp(Next Step:  <a href="<c:out value="${attachment}"/>">Add Attachment</a>-Company Method Statement
		&amp;
        <a href="<c:out value="${rescore}"/>">Rescore.)</a>
	   </c:if>
	   	<c:if test="${assessment.nrag == 'red'}">
		&nbsp&nbsp<fmt:message key="assessment.PtWStatus.${assessment.nrag}.next"/>
	   </c:if>
	   <c:if test="${assessment.nrag == 'amber'}">
		&nbsp&nbsp(Next Step: <a href="<c:out value="${attachment}"/>">Add Attachment</a>-Job Risk Assessment to turn Green.)
	   </c:if>
    </td>
    </c:if>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.name" />:</td>
    <td colspan="3" id="assessmentName">
		<c:choose>
			<c:when test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
			<c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
		</c:choose>
    </td>
  </tr>

  <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
      <c:if test="${g.name != null && g.name != ''}">
      <tr><td colspan="4" ><c:out value="${g.name}"/></td></tr>
      </c:if>
      <c:forEach items="${g.questions}" var="q">
        <c:if test="${q.active and q.visible}">
          <tr>
          <c:choose>
            <c:when test="${q.answerType.name == 'label'}">
              <td  colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
            </c:when>
            <c:otherwise>
              <td class="scannellGeneralLabel nowrap"><c:out value="${q.name}" />:</td>
              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
            </c:otherwise>
          </c:choose>
          </tr>
        </c:if>
      </c:forEach>
    </c:if>
  </c:forEach>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser"><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><c:out value="${assessment.otherParticipants}" /></td>
  </tr>
  
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvalByUser" />:</td>
    <td colspan="3" id="assessmentApprovalByUser"><c:out value="${assessment.approvalByUser.displayName}" /></td>
    
  </tr>

  <c:if test="${assessment.approved}" >
	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="assessment.approvedBy" />:</td>
	    <td  colspan="3" id="assessmentApprovedBy"><c:out value="${assessment.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.approvalDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
	  </tr>
		<c:if test="${!printable || (printable && assessment.template.printableFieldApprovalComment)}">
			<tr>
			 	<td class="scannellGeneralLabel"><fmt:message key="assessment.approvalComment" />:</td>
				<td colspan="3" id="assessmentApprovalComment"><scannell:text value="${assessment.approvalComment}" /></td>
			</tr>				
		</c:if>
  </c:if>

	  <c:if test="${!printable || (printable && assessment.template.printableFieldLinkDocument)}">
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="linkedDocuments" />:</td>
		    <td colspan="3">
			    <c:set var="showLatest" value="false" scope="request"/>
		    	<jsp:include page="../doclink/showLinkedDocs.jsp" />
		    </td>
		  </tr>
	  </c:if>
	  
  <c:if test="${assessment['class'].name != 'com.scannellsolutions.modules.risk.domain.impl.RiskAssessmentRevisionImpl'}">
	  <c:if test="${!printable || (printable && assessment.template.printableFieldUploadedDocument)}">
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="uploadedDocuments" />:</td>
		    <td colspan="3">
		     <ul>
		      <c:forEach items="${assessment.attachments}" var="item">
			  <c:if test="${item.active}">
			  <c:choose>
				<c:when test="${item.type.name == 'attach'}">
				  <li><a target="attachment" href="<c:url value="viewAssessmentAttachment.${item.fileExtension}"><c:param name="id" value="${item.id}" /></c:url>">
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
	  </c:if>
  
	  <tr>
	  	<td class="scannellGeneralLabel"><fmt:message key="assessment.targetReviewDate" />:</td>
	    <td id="targetReviewDate"  colspan="3"><fmt:formatDate value="${assessment.targetReviewDate}" pattern="dd-MMM-yyyy" /></td>
	  </tr>
	  <c:if test="${not empty assessment.reviews}" >
		  <tr>
		    <td class="scannellGeneralLabel"><fmt:message key="assessment.lastReviewedBy" />:</td>
		    <td colspan="3" id="assessmentLastReviewedBy"><c:out value="${assessment.reviews[0].createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.reviews[0].date}" pattern="dd-MMM-yyyy" /></td>
		  </tr>
  	  </c:if>

	  <tr>
	    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
	    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	
	    <c:if test="${assessment.lastUpdatedByUser != null}">
	    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
	    <td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
	    </c:if>
	  </tr>
  </c:if>
  
  </tbody>
  <tfoot>
    <c:if test="${!printable}">
				<tr>
					<td colspan="4"><c:choose>
							<c:when test="${urls != null}">
								<scannell:url urls="${urls}" />
							</c:when>
							<c:otherwise>
							<c:if test="${latestAssessmentRevision == null}">
								<fmt:message key="assessment" />
								<fmt:message key="notCurrentSelectedSiteMsg">
									<fmt:param value="${assessment.site.name}" />
								</fmt:message>
							</c:if>
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:if>
  </tfoot> 
</table>

</c:if> 
         
<div class="content" >
<c:if test="${!printable}">							
				
					<c:choose>
							<c:when test="${urls != null}">
								<scannell:url  urls="${urls}" />
							</c:when>
							<c:otherwise>
							<c:if test="${latestAssessmentRevision == null}">
								<fmt:message key="assessment" />
								<fmt:message key="notCurrentSelectedSiteMsg">
									<fmt:param value="${assessment.site.name}" />
								</fmt:message>
							</c:if>
							</c:otherwise>
						</c:choose>
						
				
			</c:if>
</div>         
<div class="content">
<div class="table-responsive">
<div class="panel">

</div>
<c:if test="${(!printable || (printable && assessment.template.printableFieldRiskRating)) && assessment.template.scorable && !assessment.template.attachmentDriven}">
      <jsp:include page="showRiskRating.jsp" /> 
</c:if> 
<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA' and (assessment.nrag == null or assessment.nrag != 'nocolor')}">
<a name="scores"></a>
<div class="header">
<h3> <fmt:message var="scoreComment" key="assessment.scoreComment" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
<table class="table table-responsive table-bordered printFont">
<col class="label" />
<tbody>
  <tr>
    <th valign="top"  class="scannellGeneralLabel">
      <spring:message code="assessment[${assessment.template.id}].scoreComment" text="${scoreComment}" />:
    </th>
    <td colspan="3"><scannell:text value="${assessment.scoreComment}" /></td>
  </tr>

<c:forEach items="${assessment.template.scoringCategories}" var="c">
  <tr><td colspan="5" ><c:out value="${c.name} "/>:</td></tr>
  <c:forEach items="${c.questions}" var="q">
      <c:remove var="score" />     
      <!-- Some history of score changes are not saved in table, so in such case the current sores will be displayed  -->
      <c:choose>
      <c:when test="${not empty assessment.scores}">
       <c:forEach items="${assessment.scores}" var="s">      
        <c:if test="${s.question.id == q.id}"><c:set var="score" value="${s}" /></c:if>
      </c:forEach>
      </c:when>      
      <c:otherwise>
        <c:forEach items="${latestAssessmentRevision.scores}" var="s">      
        <c:if test="${s.question.id == q.id}"><c:set var="score" value="${s}" /></c:if>
      </c:forEach>      
      </c:otherwise>
      </c:choose>   
  <tr>
    <c:if test="${q.active or score.selectedOption.score!=null}">
    <td valign="top" class="scannellGeneralLabel <c:if test='${fn:length(q.name)<=35}'>nowrap</c:if>"><c:out value="${q.name}" />:</td>
    <td valign="top"  colspan="3"><c:if test="${assessment.template.attachmentDriven}"><c:out value="${score.selectedOption.name}"/></c:if><c:if test="${assessment.template.attachmentDriven==false}"><c:out value="${score.selectedOption.name} - ${score.selectedOption.score}" /></c:if><br /><scannell:text value="${score.justification}" /></td>
    <c:if test="${empty latestAssessmentRevision.scores}">
    <td valign="top" colspan="3">
      <ul id="actions">
      <c:forEach items="${score.tasks}" var="task">      	
	      	<c:if test="${not task.trashed}">      	
	        	<c:url var="viewTaskUrl" value="/risk/taskView.htm"><c:param name="id" value="${task.id}"/></c:url>
	        	<li><a href="<c:out value="${viewTaskUrl}" />"><c:out value="${task.displayId}" /></a>(<fmt:message key="${task.status}" />)</li>
	      	</c:if>
	      </c:forEach>
	      <c:if test="${assessment.approved == false}">Cannot create task while awaiting approval</c:if>
	      <c:if test="${score.taskAddable}">
	        <c:url var="addTaskUrl" value="/risk/taskEdit.htm"><c:param name="score" value="${score.id}"/></c:url>
	        <c:if test="${!printable && urls != null}"><li><a href="<c:out value="${addTaskUrl}" />">Add Task</a></li></c:if>
	        <c:url var="assTaskUrl" value="/risk/taskAssociate.htm">
	          <c:param name="scoreId" value="${score.id}"/>
	        </c:url>
	        <c:if test="${!printable && urls != null}"><li><a href="<c:out value="${assTaskUrl}" />">Associate Task</a></li></c:if>
	      </c:if>
      </ul>
    </td>
    </c:if>
    </c:if>
  </tr>
  </c:forEach>
</c:forEach>
  
</tbody>
<tfoot>
<tr>
    <td colspan="5" class="center-label">
      <c:out value="${assessment.template.footer}" />
    </td>
  </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</c:if>

<c:if test="${!printable || (printable && assessment.template.printableFieldTaskList)}">
<c:if test="${not empty assessment.assessmentTasks}">
<a name="tasks"></a>
<div class="header">
<h3>
 <fmt:message key="assessment.tasks" />
</h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive printFont dataTable">
  <thead>
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="task.name" /></th>
      <th><fmt:message key="task.targetCompletionDate" /></th>
      <th><fmt:message key="task.status" /></th>
      <th><fmt:message key="task.responsibleUser" /></th>
    </tr>
  </thead>
  <tbody id="questionsTbody">
	  <c:forEach items="${assessment.assessmentTasks}" var="task" varStatus="s">
		  <c:if test="${task.completed}"><c:set var="hiddenTasks" value="${true}" /></c:if>
			  <c:if test="${(param.showCompletedTasks && task.completed) || (!param.showCompletedTasks && task.inProgress)}">
				    <tr>
				      <td><a href="<c:url value="/risk/taskView.htm"><c:param name="id" value="${task.id}" /></c:url>"><c:out value="${task.displayId}" /></a></td>
				      <td><c:out value="${task.name}" /></td>
				      <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
				      <td><fmt:message key="${task.status}" /></td>
				      <td><c:out value="${task.responsibleUser.displayName}" /></td>
				    </tr>
			  </c:if>
	  </c:forEach>
	<tfoot>
		<tr>
		    <td colspan="5" style="text-align:center;">
		    <c:choose>
		      <c:when test="${param.showCompletedTasks}">
		        <c:url var="url" value="/risk/assessmentView.htm">
		          <c:param name="id" value="${assessment.id}"/>
		        </c:url>
		        <a href="<c:out value="${url}"/>#tasks">Show In Progress</a>
		      </c:when>
		
		      <c:when test="${hiddenTasks}">
		        <c:url var="url" value="/risk/assessmentView.htm">
		          <c:param name="id" value="${assessment.id}"/>
		          <c:param name="showCompletedTasks" value="${true}"/>
		        </c:url>
		        <a href="<c:out value="${url}"/>#tasks">Show Completed</a>
		      </c:when>
		    </c:choose>
		    </td>
		</tr>
  	</tfoot>
  </tbody>
</table>
</div>
</div>
</div>
</c:if>
</c:if>

<c:if test="${!printable || (printable && assessment.template.printableFieldAssociatedRiskAssessment)}">

<!-- Problem Area Fixed For BootStrap - Manjush 14 Nov 2014    -->

<c:if test="${not empty sortedAssociatedAssessments}">
<a name="associatedAssessments"></a>
<c:set var="first" value="${false}" />
<c:set var="last" value="${null}" />

 
<!-- First For Each contains all names without repitition    -->
<c:forEach items="${sortAssessment}" var="sortAssessment" varStatus="so">
 
	<div class="header">
    	<h3><fmt:message key="assessment.associatedAssessments" /> - <c:out value="${sortAssessment}"/></h3>
	</div>   
  
	<div class="content">
	<div class="panel">
	<table id="assTable" class="table table-bordered table-responsive printFont dataTable newAssTable">
    
		<c:set var="temp1" value="${true}" />
		<c:forEach items="${sortedAssociatedAssessments}" var="assessment" varStatus="s">
			<c:if test="${ sortAssessment eq assessment.template.name}"> 

				<c:if test="${ temp1 eq true}"> 
   					<c:set var="temp1" value="${false}" />
					<thead>    
        				<tr>
          					<th><fmt:message key="id" /> / <fmt:message key="assessment.name" /></th>
          					<c:forEach items="${assessment.template.summaryQuestions}" var="sq" >
     							<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g" >
	           						<c:if test="${g.active}">
	        							<c:forEach items="${g.questions}" var="q">
	        								<c:if test="${sq.id == q.id and q.active and q.visible}">
	         									<th> <c:out value="${sq.name}" />    </th>
	          								</c:if>
	          								<c:if test="${!empty q.columns}">
	          									<c:forEach items="${q.columns}" var="childQ">
	         										<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
	              										<th> <c:out value="${sq.name}" />   </th>
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
      
  <tr >
    <td>
      <a href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>" ><c:out value="${assessment.displayId}" /></a><br>
		<c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
  		<c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
    </td>

    <c:forEach items="${assessment.template.summaryQuestions}" var="sq">
	    <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
	      <c:if test="${g.active}">
	        <c:forEach items="${g.questions}" var="q">
	          <c:if test="${sq.id == q.id and q.active and q.visible}">
	          <td> <enviromanager:answer question="${q}" answers="${assessment.answers}" /> </td>
	          </c:if>
	          <c:if test="${!empty q.columns}">
	          <c:forEach items="${q.columns}" var="childQ">
	            <c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
	              <td>  <enviromanager:answer question="${childQ}" answers="${assessment.answers}" />   </td>
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
    <td class="nowrap">
      <c:set var="threshold" value="${assessment.threshold}" /> 
		<c:choose>
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
		    <c:otherwise><img src="<c:url value="/images/risk/score_greenlight.giff" />" /></c:otherwise>
		</c:choose>
      <c:out value="${assessment.score}" />
    </td>
    </c:if>
  </tr>
  <c:set var="last" value="${assessment}" />
  <c:if test="${s.last}"> 
  	  <tfoot>
		  <tr>
		    <td class="center-label">
		      <br/><br/>
		      <c:out value="${assessment.template.footer}" />
		    </td>
		  </tr> 
	  </tfoot>
	  </tbody>
	  </table>
  </c:if>
  </c:if>
</c:forEach>
</table>
   </div>
   </div>

</c:forEach>

</c:if>
</c:if>
<c:if test="${!printable || (printable && assessment.template.printableFieldRiskMatrix)}">
   <jsp:include page="showMatrix.jsp" />    
</c:if>
<c:if test="${assessment.template.name eq 'Health & Safety - Pre & Post Natal'}">
<div class="form-group">
<div class="center-label">
				<c:out value="${assessment.template.footer}" />
</div>
</div> 
</c:if>
</div>
</body>
</html>