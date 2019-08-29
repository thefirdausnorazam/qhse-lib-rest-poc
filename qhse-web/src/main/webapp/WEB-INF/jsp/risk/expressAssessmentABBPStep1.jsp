<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<c:url var="url" value="/doclink/linkView.htm"><c:param name="name" value="RiskTemplate[${command.template.id}]" /></c:url>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="expressAssessmentStep1.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script>

	<link type="text/css" href="<c:url value="/js/select2-3.2/select2.css" />" rel="stylesheet" />
  <script type="text/javascript" src="<c:url value="/js/select2-3.2/select2.js" />" ></script>

  <script type="text/javascript">
  var jobScoringQuestions=null;
  var jobScoringTotal=null;
  var rrQuestion=null;
  var rrQuestionCon=0;
  var rrQuestionMag=0;
  var probability=0;
  var controlFactor;
  var correctedMagnitude;
  var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
  jQuery(document).ready(function() {
	  jobScoringQuestions='<%=request.getAttribute("jobScoringQuestions")%>';
	  jobScoringTotal='<%=request.getAttribute("jobScoringTotal")%>';
	  rrQuestion='<%=request.getAttribute("rrQuestion")%>';
	  rrQuestionCon='<%=request.getAttribute("rrQuestionCon")%>';
	  rrQuestionMag='<%=request.getAttribute("rrQuestionMag")%>';
	  probability='<%=request.getAttribute("probabilityQuestion")%>';
	  controlFactor='<%=request.getAttribute("controlFactorQuestion")%>';
	  correctedMagnitude='<%=request.getAttribute("correctedMagnitude")%>';
	  initScore();
	  setScoreCM();
	  var multiselect = jQuery('select[multiple="multiple"]');
	    multiselect.removeClass("scrollList");
	    multiselect.select2({
	      width: '400px'
	    });
  });
  
  function hideHint(){
	  
	  var myE = document.getElementById("assessmentNameText");
	  
	  if (myE.value  == "Risk Assessment Title"){
		  myE.style.color ="#000";
		  myE.value = "";
	  }
  }
  
  function showHelp(event,questionHelp, aImg) {
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
	    
	    var top = document.body.scrollTop
          || window.pageYOffset 
          || (document.body.parentElement
              ? document.body.parentElement.scrollTop
              : 0
              );
	    
	    return cursor;
	}  

  function showLink() {
    var url = '<c:out value="${url}" />';
    openPopup(url, 700, 400);
    linkDislayed=true;
  }
  
   function showTemplateLink(theIndex)
  {
     var url = '<c:url value="/doclink/linkView.htm?name=RiskTemplate[${command.template.id}]&index='+ theIndex+'"/>';
     //var url = '<c:url value="${url1}"/>';
      openPopup(url, 700,400);
  }
  

  function openPopup(url, w, h) {
    var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
    var win = window.open(url, "links", att);
    win.focus();
  }

  function checkHiddenFields() {
    var fields = ['answers[58]', 'answers[59]'];
    for (var i=0; i<fields.length; i++) {
      var field = $(fields[i]); 
      if (field) {
        var emptySelect = field.options && field.options.length <= 1;
        var emptyCheckboxList = !field.innerHTML; 
        if (emptySelect || emptyCheckboxList) {
          field.parentNode.parentNode.style.display="none";
        } else {
          try {
            field.parentNode.parentNode.style.display="table-row";
          } catch(e) {
            field.parentNode.parentNode.style.display="block";
          }
        }
      }
    }
  }
  postPopulateQuestionOptionsCallbackHandler = checkHiddenFields;

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
      	var numberOfRows = table.tBodies[0].rows.length;	
      	
        for(var i = 0; i < numberOfRows; i++) {
      	  var subTableGroup = getSubTablesForRow(subTables, i);
            for(var k = 0; k < subTableGroup.length; k++) {
               var div = subTableGroup[k];            
               if(div.firstChild.readOnly==true && div.firstChild.value=="")
               {
                   var defaultValue = div.firstChild.attributes["defaultValue"].value                 
                   if(defaultValue != null){
                  	 div.firstChild.value = defaultValue;
                   }
               }
            	//show div
            	var trparent = getParent("tr", table);
            	var tbodyparent = getParent("tbody", table);
            	if(i==0){
            		var newTableRow = tbodyparent.insertRow(trparent.rowIndex +1 );
            	}else{
            		var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1 +(i * subTableGroup.length));
            	}
            	newTableRow.insertCell(0);
            	var cell = newTableRow.insertCell(1); 
            	div.style.display="block";    
            	cell.insertBefore(div,null);               
    		}	  
        }
    }  	       	          
  }
    
  function init() {
    initDependsOn("theForm");
    checkHiddenFields();
    checkForSubTables();
    showHint();
    
    <fmt:message key="assessmentStep1.saveDataMsg" />
  }

  Event.observe(window, 'load', init, false);

  function onFormSubmit(){
    var fields = new Array('answers[39]');
    this;
  } 
    
  function optionName(lst, val)
  {
	response = '';
	for (var i=0; i < lst.options.length; i++){
		if (lst.options[i].value==val){
			response = lst.options[i].text;
			break;
		}
	}
	return response;
  }    
  function updateApprovalUser(responsibleUserSelect){  	    
    var option = optionName(responsibleUserSelect, responsibleUserSelect.value);  
  	dwr.util.setValue("assessmentApprovalByUserSelect", option);  	
  }
  
  function append(value, id){
	  var toAppend = value.value;	
	  var index;  
	  if(value.id.indexOf("-") > 0){		  
		  id = id + value.id.substring(value.id.indexOf("-") ,value.id.indexOf("]"))
	  }
	  var elem = getElementBySubName("answers["+id+"]");
	  dwr.util.setValue(elem.firstChild, elem.firstChild.attributes["defaultValue"].value + " " + toAppend);	  
  }
  function setScore(elem){
	  var selectedQuestion = elem.getAttribute("questionid"); 
	  var selectedOption= elem.getAttribute("id");
	  var scoreChanged=false;
	  var scoringIds=jobScoringQuestions.split(",");
	 if(selectedQuestion != null)
			 {
				 for(var i=0; i<scoringIds.length; i++){
					 if(selectedQuestion.indexOf(scoringIds[i])){
						 scoreChanged=true;
			
					 }
				  }
			  }
		 if(scoreChanged == true )
		 {
	 		 document.getElementById('answers['+rrQuestionCon+']').value='';
			 document.getElementById('answers['+rrQuestionMag+']').value='';
			 var score=1;
			 for(var i=0; i<scoringIds.length; i++)
			 {
				 if(probability != scoringIds[i])
				 {
						 var selectedOptionPart = selectedOption.split("-");
						 var selOption = document.getElementById('answers['+scoringIds[i]+']');
						 var selectedValue = selOption[selOption.selectedIndex].text;
					 if(isNumber(selectedValue))
					 {
						 var consequence = document.getElementById('answers['+rrQuestionCon+']').value; 
						 if(isNumber(consequence))
						 {
							 selectedValue= parseInt(consequence)+parseInt(selectedValue);
						 }
						 document.getElementById('answers['+rrQuestionCon+']').value=selectedValue;
					 
					 }
				}
				 var probabilityEle = document.getElementById('answers['+probability+']');
				 var conqValue = document.getElementById('answers['+rrQuestionCon+']').value;
				 var probabilityValue = probabilityEle.options[probabilityEle.selectedIndex].text;
				 if(isNumber(probabilityValue) && isNumber(conqValue))
				 {
					 document.getElementById('answers['+rrQuestionMag+']').value=(parseInt(conqValue) * parseInt(probabilityValue));
					 setScoreCM();
				 }
			 }
	  }
}
  
  function setScoreCM(){
	 controlFactor= controlFactor.replace('[', '');
	 controlFactor= controlFactor.replace(']', '');
	 var controlF = controlFactor.split(",");
	 var reduceValue=1;
		for(var i=0; i<controlF.length; i++){
	 
		controlF[i] = controlF[i].replace(" ","")
		var selOption = document.getElementById('answers['+controlF[i]+']');
		 if(selOption != null){
		 var selValue = selOption.options[selOption.selectedIndex].text;
		 if(selValue.indexOf("100") != -1){
			 reduceValue = 0;
		 }else if(selValue.indexOf("70") != -1 && reduceValue>.7){
			 reduceValue = reduceValue - .7;
		 }else if((selValue.indexOf("50") != -1) && reduceValue>.7){
			 reduceValue = reduceValue - .5;
		 }else if((selValue.indexOf("30") != -1) && reduceValue>.3 && reduceValue != .5 ){
			 reduceValue = reduceValue - .3;
		 }else if((selValue.indexOf("15") != -1) && reduceValue>.15 && reduceValue != .5){
			 reduceValue = reduceValue - .15;
		 }
	 }
  }
	var cmag = document.getElementById('answers['+rrQuestionMag+']').value;
	if(cmag){
		cmag = cmag - (Math.round((cmag - (cmag * reduceValue))*100)/100);
		cmag = cmag.toFixed(2);
	 document.getElementById('answers['+correctedMagnitude+']').value = cmag;
	}
 } 
  
  
  function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}
  
  function initScore(){
	  var score=1;
	  var scoringIds=jobScoringQuestions.split(",");
	  for(var i=0; i<scoringIds.length; i++){
		  var selOption = document.getElementById('answers['+scoringIds[i]+']');
		  var selectedValue = selOption[selOption.selectedIndex].text;
		 //alert('selectedValue: '+selectedValue);
		 if(selectedValue != null){
		 	var scoring=selectedValue.split("-");
		 	if(scoring[0] != null){
		 		if(isNumber(scoring[0]))
		 		{
		 			score=score*scoring[0];
		 		}
		 		else
		 		{
		 			score = '';
		 		}
		 	}
		 }
	  }
	  document.getElementById('answers['+rrQuestion+']').value=score;
  }
  </script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
   </style>
</head>
<body>
 	<system:gdprBanner/>
 	
<scannell:form id="theForm" onsubmit="onFormSubmit()">
<table class="viewForm" style="margin-top:0px;">
<col class="label" />
<tbody>
  <c:if test="${assessment.id != null}">
  <tr>
    <td><fmt:message key="id" />:</td>
    <td id="assessmentId">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${assessment.displayId}"/>
    </td>

    <td><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>
  </c:if>

  <tr>
    <td><fmt:message key="businessAreas" />:</td>
    <td colspan="5" id="assessmentBusinessAreas">
      <scannell:hidden path="businessAreas" writeRequiredHint="false" />
      <c:forEach items="${command.businessAreas}" var="ba"><c:out value="${ba.name}" /></c:forEach>
    </td>
  </tr>

  <c:forEach items="${command.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
  		<c:if test="${g.name != null && g.name != ''}">
      		<tr><td colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}"/></td></tr>
      	</c:if>
      	<c:forEach items="${g.questions}" var="q" varStatus="s">
        	<c:if test="${q.active and q.visible}">
        		<c:if test="${s.index mod 3 == 0}">
        			<tr>
        		</c:if>
            	<c:choose>
            		<c:when test="${q.answerType.name == 'label'}">
              			<td class="riskLabel"><c:out value="${q.name}" /></td>
            		</c:when>
            		<c:otherwise>
              			<td><c:out value="${q.name}" />:
              			<c:if test="${q.help.helpText != null}" >
               				<img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="${q.help.helpText}"/>
      		  			</c:if>
      		  			</td>
      		  			<td><enviromanager:question path="answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false"/></td>
            		</c:otherwise>
          		</c:choose>
          		<c:choose>
					<c:when test="${s.index mod 3 == 2}">
						</tr>
					</c:when>
					<c:otherwise>
						<c:if test="${s.last}">
							</tr>
						</c:if>
					</c:otherwise>
				</c:choose>
        	</c:if>
      </c:forEach>
    </c:if>
  </c:forEach>
  <tr>
    <td><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser"><select name="responsibleUser" items="${responsibleUserList}" itemLabel="sortableName" itemValue="id" class="mediumWide" onchange="updateApprovalUser(this);"/></td>
    <td><fmt:message key="assessment.approvalByUser" />:</td>
    <td id="assessmentApprovalByUser">
    	<select name="approvalByUser" id="assessmentApprovalByUserSelect" items="${approvalUserList}" itemLabel="sortableName" itemValue="id" class="mediumWide"/>
    </td> 
    <td><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><input name="otherParticipants"  maxlength="40"/></td>
  </tr>
 
  <tr>
  <c:choose>
  <c:when test="${assessment.createdByUser != null}">
    <td><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td colspan="3">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  <c:choose>
  <c:when test="${assessment.lastUpdatedByUser != null}">
    <td><fmt:message key="lastUpdatedBy" />:</td>
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
<table id="theJobTable" class="viewForm" style="margin-top:0px;">
<col class="label" />
<thead>
<td colspan="8" align="left">Job Detail</td>
</thead>
<tbody>
				<tr>
					<td colspan="8">
					<table id="theJobTable" class="viewForm" style="margin-top:0px;">
							<thead>
								<tr>
								<scannell:hidden path="jobName"  />
								<c:forEach items="${jobQuestion.columns}" var="columns">
							    <c:if test="${not fn:containsIgnoreCase(columns.codeName, 'cf')}">
							    <th><c:out value="${columns.name}"></c:out></th>
  						    </c:if>
								</c:forEach>
								</tr>
							</thead>
							<tbody>
									<tr>
									<c:forEach items="${jobQuestion.columns}" var="columns2">
									
									<c:if test="${not fn:containsIgnoreCase(columns2.codeName, 'cf')}">
									<td>
										<enviromanager:question path="answers" question="${columns2}" emptyOptionLabel="Choose" multiselectCheckboxes="false" onchange="setScore(this)"/>
									</td>
									</c:if>
									
									</c:forEach>
							</tr>
								<tr>
									<td colspan="12" class="scoringCategoryTitle">Control Factors:</td>
								</tr>

								<tr>
								<c:forEach items="${jobQuestion.columns}" var="columns3">
								<c:if test="${fn:containsIgnoreCase(columns3.codeName, 'cf') and not fn:containsIgnoreCase(columns3.codeName, 'CorrectedMagnitude')}">
								<tr>
								    <th valign="top"><c:out value="${columns3.name}"></c:out>
								    	
								    </th>
								    <td colspan="3">
										<enviromanager:question path="answers" question="${columns3}" emptyOptionLabel="Choose" multiselectCheckboxes="false" onchange="setScoreCM()"/>
								    </td>
								  </tr>
								  </c:if>
								 </c:forEach>
								 </tr>
							</tbody>
						</table>
				</tr>
			</tbody>
<tfoot>
  <tr>
    <td colspan="8" align="center"><input type="submit" value="<fmt:message key="submit" />"></td>
  </tr>
</tfoot>
</table>
</scannell:form>
</body>
</html>
