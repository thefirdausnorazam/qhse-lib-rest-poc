<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<!DOCTYPE html>
<html>
<head>
  <%-- <title><fmt:message key="assessmentStep2.title" /></title> --%>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
 
  <style type="text/css">
  th.searchLabelEdit {
padding-right: 50px !important;
background-color: white !important;
border-width: 0px !important;
text-align: center;
padding-top: 22px !important;
margin-top: 0;
margin-bottom: 0;
}
.checkLength{
max-width: 90%;
}
  </style>
  <script type="text/javascript">
 
  jQuery(document).ready(function() {
	  jQuery("#theForm").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});	
	  jQuery('select').select2({
	    width: 'resolve'
	  });
	  // Added to check the dynamically added select options text is less than 100 chars
/*  	  jQuery('.checkLength option').each(function() {
 	    var trim;
 	    if (jQuery(this).text().length >= 100) {
	      trim = jQuery.trim(jQuery(this).text()).substring(0, 100) + '...';
 	      jQuery(this).text(trim);
 	    }
 	  }); */
	  <c:if test="${command.firstAssessment.template.multiApproval}">
	  	jQuery('#btSubmit').hide();
	  </c:if>
	  <c:if test="${command.firstAssessment.template.multiApproval == false && command.firstAssessment.template.attachmentDriven == true}">
	  	jQuery('select option').each(function (){
	  		if(jQuery(this).text() == '200.0 - Yes'){
	  			jQuery(this).text('Yes');
	  		} else if (jQuery(this).text() == '300.0 - No'){
	  			jQuery(this).text('No');
	  			jQuery(this).parent().parent().find('.select2-container').find('a').find('.select2-chosen').text(jQuery(this).parent().parent().find('.select2-container').find('a').find('.select2-chosen').text().replace('200.0 - Yes', 'Yes').replace('300.0 - No', 'No'))
	  		}
	  	});
	  </c:if>
	  
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
    function showHelp(event,questionHelp) {
  	// aImg.style.cursor='help';

  	var myDiv = document.getElementById("help");
  	//clear previous help element

  	if(myDiv.hasChildNodes()){
  		toRemove = myDiv.childNodes[0];
  		myDiv.removeChild(toRemove);
  	}

	var i = document.createTextNode(questionHelp);

	var el = this.parent;

	var cursor = getPosition(event);

	myDiv.style.left = cursor.x + "px";
	myDiv.style.top = cursor.y + "px";

	myDiv.appendChild( i );
	Effect.Appear('help');
   }

  	function hideHelp() {
  		Effect.Fade('help');
  	}

	function getPosition(e) {
	    e = e || window.event;
	    var cursor = {x:0, y:0};
	    if (e.layerX || e.layerY) {
        	cursor.x = e.layerX;
        	cursor.y = e.layerY;
    	}
    	else {
	        var de = document.documentElement;
        	var b = document.body;
        	cursor.x = e.clientX +
	            (de.scrollLeft || b.scrollLeft) - (de.clientLeft || 0);
        	cursor.y = e.clientY +
	            (de.scrollTop || b.scrollTop) - (de.clientTop || 0);
	    }
	    return cursor;
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
	          		var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1);
	          	}else{
	          		var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1 +(i * subTableGroup.length));
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
   

<%-- Open the two popup windows for Law and Data if the user has the correct licences --%>
<c:set var="assessment" value="${command.firstAssessment}" />
<c:forEach items="${licences}" var="item">
  <c:choose>
    <c:when test="${item=='law'}">
      <c:set var="icdKeys" value="${command.icdMasterKeys}" />
      <% if (pageContext.getAttribute("icdKeys")!= null && String.valueOf(pageContext.getAttribute("icdKeys")).trim().length()>0) { %>
          var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
          var params = '?raType=<c:out value="${assessment.template.businessArea.id}" />&icdKeys=<c:out value="${command.icdMasterKeys}" />&pageRisk=true';
          openPopup(url + params, 'risk_legal', 800, 500, 0, 0);
      <% } %>
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

    <fmt:message key="assessmentStep1.saveDataMsg" />
  }

  function openPopup(url, windowName, w, h, x, y) {
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y;
    var win = window.open(url, windowName, att);
    win.focus();
  }

  //Event.observe(window, 'load', init, false);
   jQuery(document).ready(function () {	 
		init();
		
	});
  
  // -->
  function toggleNextButton(obj){
	  if(obj.value == 'true') {
		  jQuery('#btSubmit').show();
		  //if(${fn:length(command.firstAssessment.attachments) == command.firstAssessment.numberPreviousAttachments}) {
			  //alert(1)
		  //} else {
			  //alert(2)
		  //}
	  } else {
		  jQuery('#btSubmit').hide(); 
	  } 
	  
}
  
  </script>

  <style type="text/css" media="all">
    /* @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>"; */
    @import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
  </style>
</head>
<body>
 	<system:gdprBanner/>

<scannell:form id="theForm">

<c:set var="assessment" value="${command.firstAssessment}" />

<ul class="raMenu">
<c:choose>
  <c:when test="${assessment.id != null}">
    <li><a href="<c:url value="/risk/assessmentStep1.htm"><c:param name="showId" value="${param.showId}" /></c:url>" onclick="<fmt:message key="warning.changeAssessmentTab" />">Activity</a></li>
    <li class="selected">Score &amp; Justification <i class="fa fa-chevron-circle-right fa-1g"></i></li>
    <li><a href="<c:url value="/risk/assessmentStep3.htm"><c:param name="showId" value="${param.showId}" /></c:url>" onclick="<fmt:message key="warning.changeAssessmentTab" />">Review &amp; Save</a></li>
  </c:when>
  <c:otherwise>
    <li>Activity</li>
    <li class="selected">Score &amp; Justification</li>
    <li>Review &amp; Save</li>
  </c:otherwise>
</c:choose>
</ul>

<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-responsive table-bordered table-hover table-condensed" style="margin-top:0px;">
<col class="label"  />
<tbody>
  <c:if test="${assessment.id != null}">
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
    <td id="assessmentId">
      <scannell:hidden path="id" writeRequiredHint="false" />
      <scannell:hidden path="version" writeRequiredHint="false" />
      <a href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${param.showId}" /></c:url>" >
	  <c:out value="${assessment.displayId}"/></a>
    </td>

    <td class="scannellGeneralLabel"><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3" id="assessmentBusinessAreas">
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.name" />:</td>
    <td colspan="3" id="assessmentName">
      <c:choose>
			<c:when test="${assessment == null || assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
			<c:otherwise><fmt:message key="assessment.confidential"/><input name="name" type="hidden" value="<c:out value="${command.name}"/>" /></c:otherwise>
		</c:choose>
    </td>
  </tr>

  <c:forEach items="${command.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
      <c:if test="${g.name != null && g.name != ''}">
      <tr><td colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}"/></td></tr>
      </c:if>
      <c:forEach items="${g.questions}" var="q">
       <c:if test="${q.active and q.visible}">
		       	<c:if test="${q.id!=59 and q.id!=58}"> 
		          <tr>
		          <c:choose>
		            <c:when test="${q.answerType.name == 'label'}">
		              <td colspan="4" class="riskLabel" ><c:out value="${q.name}" /></td>
		            </c:when>
		            <c:otherwise>
		              <td class="scannellGeneralLabel " style="width:40%"><c:out value="${q.name}" />:</td>
		              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
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
		              <td class="scannellGeneralLabel nowrap"><c:out value="${q.name}" />:</td>
		              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
		            </c:otherwise>
		          </c:choose>
		          </tr>
		       	 </c:if>
	        </c:if>
        
      </c:forEach>
    </c:if>
  </c:forEach>
  <c:if test="${assessment.template.attachmentDriven || command.firstAssessment.template.multiApproval}">
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
					<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /> - [From Rev-${item.revisionNumber} At <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />]</li>
			    </c:when>
				<c:otherwise>
					<li><a target="attachment"	href="<c:out value="${item.externalUrl}" />">
						<c:out value="${item.name}" /></a> - <c:out value="${item.description}" /> - [From Rev-${item.revisionNumber} At <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />]</li>
				</c:otherwise>
			  </c:choose> 
			  </c:if>
			  </c:forEach>
			  </ul>
			  <c:if test="${command.firstAssessment.template.multiApproval}"><a href="<c:url value="/risk/addRiskAttachment.htm"><c:param name="showId" value="${param.showId}" /><c:param name="fromPageStep2" value="true" /></c:url>">Add Attach</a>
			  	<span id="attachmentMessage" style="margin-left: 30px" class="errorMessage">*
					<c:if test="${command.firstAssessment.template.multiApproval}">
						<c:if test="${fn:length(command.firstAssessment.attachments) == command.firstAssessment.numberPreviousAttachments}"><fmt:message key="warning.missingAttachment" /></c:if>
					</c:if> 
				</span>
			  </c:if>
		    </td>
		  </tr>
	  </c:if>
	  </c:if>
	<c:if test="${command.firstAssessment.template.multiApproval}">
		<tr>
			<td class="scannellGeneralLabel">
				<c:choose>
					<c:when test="${command.firstAssessment.template.prefix == 'PTW'}"><fmt:message key="assessment.methodStatementAttachQuestionPTW" /></c:when> 
					<c:when test="${command.firstAssessment.template.prefix == 'HS-PPE'}"><fmt:message key="assessment.healthAndSafetyPPEAttach" /></c:when>
					<c:otherwise><fmt:message key="assessment.methodStatementAttachQuestionPTW" /></c:otherwise>
				</c:choose>
			</td>
			<td colspan="3">
				<select id="methodStatement" style="width: 200px" name="methodStatement" onchange="toggleNextButton(this)">
					<option value="true"><fmt:message key="yes" /></option>
					<option value="false" selected="selected"><fmt:message key="no" /></option>
				</select>
				<span class="requiredHinted">*</span>
			</td>
		</tr>						
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
    			<ul><c:forEach items="${assessment.approvalUserList}" var="approvalByUser">
		    		<li><c:out value="${approvalByUser.displayName}" /></li>
		    	</c:forEach></ul>
    		</c:when>
    		<c:otherwise>
    			<c:out value="${assessment.approvalByUser.displayName}" />
    		</c:otherwise>
    	</c:choose>
    </td>
  </tr>    

  <tr>
  <c:choose>
  <c:when test="${assessment.createdByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${assessment.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>
</table>
</div>
</div>
</div>
		<div class="content" >
			
	                         <div class="form-group">
	                         <div class="col-sm-3 searchLabel">
									 <fmt:message var="scoreComment" key="assessment.scoreComment" />
                                     <spring:message code="assessment[${assessment.template.id}].scoreComment" text="${scoreComment}" />:
                                     </div>
									<div class="col-sm-6 searchLabel">
										<scannell:textarea path="scoreComment" cssStyle="float:left;width:90%" defaultValue="No Comment" class="form-control"/>
									</div>
								</div>
								<div style="clear: both;"></div>
	<c:forEach items="${command.assessmentList}" var="assessment">
   <c:forEach items="${command.template.scoringCategories}" var="c">
    <div class="form-group  ">
    <div class="col-sm-12 scoringCategoryTitle scannellGeneralLabel">
    <c:out value="${c.name} "/>	
    </div>                        
	</div>  
  <c:forEach items="${c.questions}" var="q" varStatus="s">
  <div style="clear: both;"></div>
  <c:if test="${q.active}">
                    <div class="form-group">
	                         <div class="col-sm-3 searchLabel">
									<c:out value="${q.name}" />
									<c:if test="${q.help != null}" >
        	                        <img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="${q.help.helpText}"/>
      	                            </c:if>
                                     </div>
									<div class="col-sm-6 searchLabel">
										<select name="selectedScoreOptionIds[${assessment.id}-${q.id}]" items="${q.options}" itemLabel="scoreName" itemValue="id" class="checkLength" cssStyle="float:left;width:90%" />
                                        <span class="requiredHinted">*</span>
									</div>
					</div>
					<div style="clear: both;"></div>
					 <div class="form-group" >
	                         <div class="col-sm-3 searchLabel" >
									<fmt:message var="justification" key="assessment.score.justification" />
                                    <spring:message code="assessment.score[${q.id}].justification" text="${justification}" />
                                     </div>
									<div class="col-sm-6">
										 <scannell:textarea path="justifications[${assessment.id}-${q.id}]" cssStyle="float:left;width:90%" defaultValue="No Comment" class="form-control" />
                                         <span class="requiredHinted">*</span>
									</div>
					</div>
  <div style="clear: both;"></div>
  
  
  </c:if>
  </c:forEach>
</c:forEach>
</c:forEach>
            <div class="form-group">
	                        <div class="center-label" >
                             <c:out value="${command.template.footer}" />
									</div>
					</div>
			
						<div class="help" id="help" style="display:none; position:absolute; "></div>					
								
								<div class="spacer2 text-center">
			                     	<c:if test="${!command.template.attachmentDriven}">
										<input id="btSubmit" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="next" />">
									</c:if>
									<c:if test="${command.template.attachmentDriven}">
										<input type="hidden" id="nrag" name="nrag" value="red" />
										<input id="btSubmit" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="save" />">
									</c:if>
									<input type="hidden" id="stepEdit" name="stepEdit" value="false" />
			                  </div>
								
               
			                  
			                  
		
		</div>

</scannell:form>

</body>
</html>
