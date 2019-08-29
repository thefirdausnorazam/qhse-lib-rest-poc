<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<c:url var="url" value="/doclink/linkView.htm"><c:param name="name" value="RiskTemplate[${command.template.id}]" /></c:url>
<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="expressAssessmentStep1.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  

	
<style>textarea.form-control{width:100% !important; display: inline-block;}
 table {table-layout: inherit; }
 table.tabClass td:first-child { width: 200px !important}
/*  table th, table td{ overflow: hidden; } */
 table td select {
      width: 90%;color:#333;
    }
 table td textarea {
      width: 90%;color:#333;
    }
 table td input[type="text"] {
      width: 90%;color:#333;
    } 
    div {
    font-size: 100%
    }
table.tabClass td {
      padding: 0px !important;
      padding-left: 3px !important;
      padding-right: 2px !important;
      padding-top: 8px !important;
      
    }
table.tabClass td span.col-sm-10 {
      padding: 0px !important;
      padding-left: 3px !important;
      padding-right: 2px !important;
      padding-top: 5px !important;
      width: 85% !important;
      
    }
   span.col-sm-10 {
      padding: 0px !important;
      padding-left: 3px !important;
      padding-right: 2px !important;
      padding-top: 5px !important;
      width: 100% !important;
      
    }
    span.col-sm-10 input[type="text"] {
    width: 100% !important;
    }
    span.col-sm-10 textarea {
    width: 100% !important;
    }
table.tabClass {
    width: 100% !important;
} 
    div {
    font-size: 100%
}
</style>
<c:set value="500" var="maxListSize"/>
  <script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
	var userCount = ${fn:length(responsibleUserList)};
	var maxListSize = '${maxListSize}';
	
  var jobScoringQuestions=null;
  var jobScoringTotal=null;
  var rrQuestion=null;
  var rrQuestion2=null;
  var rrQuestionIdSeverity2=null;
  var rrQuestionIdLinkehood2=null;
  jQuery(document).ready(function(){
	  jQuery("form").submit(function() {
		  var va=false;
		  jQuery('.requiredHinted').each(function() {
			   var sp =jQuery(this).prev('span');
			   var tt=sp.children('[id^=answer]');	
			   if(jQuery(tt).prop('type') == "select-multiple"){
				   if(jQuery(tt).val() == null){
					   jQuery(this).text('* required');
						  tt.css('border-color', 'red');
						  tt.css('font', 'bold');
						   va=true; 
				   }
			   }		 
			});
		  if(va){
			  $(jQuery('#loadMask')).unblock();
			  return false;
		  }	
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
	  jQuery(".tabClass>tbody>tr>td>span").removeClass("col-sm-10");
	  jQuery('.delete').addClass('g-btn g-btn--primary');
	  jQuery('#answers\\[48\\]').select2({width: '90%'}); 
	  jQuery('#answers\\[56\\]').select2({width: '90%'}); 
	  jQuery('#answers\\[42\\]').select2({width: '90%'}); 
	  jQuery('#answers\\[11001\\]').select2({width: '90%'}); 
	  jQuery('#answers\\[64\\]').select2({width: '90%'}); 
	  jQuery('#assessmentApprovalByUserSelect').select2({width: '90%'}); 
	  //jQuery('#responsibleUser').select2({width: '90%'}); 
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
	  
	  jobScoringQuestions='<%=request.getAttribute("jobScoringQuestions")%>';
	  jobScoringTotal='<%=request.getAttribute("jobScoringTotal")%>';
	  rrQuestion='<%=request.getAttribute("rrQuestion")%>';
	  rrQuestion2='<%=request.getAttribute("rrQuestion2")%>';
	  initScore();
	var multiselect = jQuery('select[multiple="multiple"]');
    multiselect.removeClass("scrollList");
    multiselect.select2({
      width: '180px'
    });
    
    init();
    
    jQuery('.table th').replaceWith(function(){
        return $("<td />", {html: $(this).html()});
    });
    try{
    var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
	if(responsibleUser != null){
		jQuery('#responsibleUser').val(responsibleUser);
	}
    if(userCount < maxListSize)
	{
		jQuery('#responsibleUser').select2({width:'90%'});
	}
	else 
	{
   		jQuery('#responsibleUser').select2({				  
		  width:'90%',
		  minimumInputLength : 3,
		  placeholder :  enterChars,
		  escapeMarkup: function(m) {
		        // Do not escape HTML in the select options text
		        return m;
		     },
		  ajax: {
		        url: "userList.json",
		        dataType: 'json',
		        type: "GET",
		        quietMillis: 100,
		        data: function (term) {
		            return {
		                term: term
		            };
		        },
		        results: function (data) {
		            return {
		                results: $.map(data, function (item) {
		                    return {
		                        text: item.userName,	
		                        slug: item.slug,
		                        id: item.id
		                    }
		                })
		            };
		        }
		    },
		    initSelection: function (element, callback) {				    	
		    	var data = {id: "<c:out value="${command.responsibleUser.id}"/>", text: "<c:out value="${command.responsibleUser.sortableName}"/>"};
			      callback(data);
			},

		      // NOT NEEDED: These are just css for the demo data
		      dropdownCssClass : 'capitalize',
		      containerCssClass: 'capitalize',

		      // configure as multiple select
		      multiple         : false,

		      // NOT NEEDED: text for loading more results
		      formatLoadMore   : 'Loading more...',				      
		      // query with pagination			  
		      cache: true
		}); 
	}}catch(e){alert(e)}
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
	      var field = document.getElementById(fields[i]);
	      if (field) {
	        var emptySelect = field.options && field.options.length <= 1;       
	        var emptyCheckboxList = !field.innerHTML; 
	        if(field.parentNode != null && field.parentNode != 'undefined')
	        {
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

  //Event.observe(window, 'load', init, false);

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
    //var option = optionName(responsibleUserSelect, responsibleUserSelect.value);  after select changing this line is not necessary
  	dwr.util.setValue("assessmentApprovalByUserSelect", responsibleUserSelect.value);//option);  
  	jQuery("#assessmentApprovalByUserSelect").select2({width: '90%'});
    /*jQuery('#assessmentApprovalByUserSelect').parent().find('span.select2-chosen').text(jQuery('#'+responsibleUserSelect.id).text());*/
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
	 var scoringIds=jobScoringQuestions.split(",");
	 if(selectedQuestion == '${rrQuestionIdSeverity2}' || selectedQuestion == '${rrQuestionIdLinkehood2}'){
		 rrQuestion = rrQuestion2;
		 scoringIds = ['${rrQuestionIdSeverity2}', '${rrQuestionIdLinkehood2}'];
	 } else {
		 rrQuestion = '<%=request.getAttribute("rrQuestion")%>';
		 var index1 = scoringIds.indexOf('${rrQuestionIdSeverity2}');
		 var index2 = scoringIds.indexOf('${rrQuestionIdLinkehood2}');
		 if(index1 > -1 && index2 > -1){
			 scoringIds.splice(index1, 1);
			 scoringIds.splice(index2, 1);
		 }
	 }
	 //alert(selectedQuestion)
	 var selectedOption= elem.getAttribute("id");
	// alert(selectedOption)
	// var selectedValue=null
	 var scoreChanged=false;
	 
	 if(selectedQuestion != null)
	 {
		 for(var i=0; i<scoringIds.length; i++){
			 if(selectedQuestion.indexOf(scoringIds[i])){
				 scoreChanged=true;
	
			 }
		  }
	  }
	// alert('scoreChanged: '+scoreChanged);
	 if(scoreChanged == true){
		 var score=1;
		 for(var i=0; i<scoringIds.length; i++){
			 var selectedOptionPart = selectedOption.split("-");
			 var selOption=null;
			 if(selectedOptionPart.length == 2){
				 var selOption = document.getElementById('answers['+scoringIds[i]+'-'+selectedOptionPart[1]);
 				 if(selOption.tagName.toLowerCase() == 'span') {
 					selOption = selOption.firstChild;
 				 }
			 }else{
				 var selOption = document.getElementById('answers['+scoringIds[i]+']');
			 }
			 var selectedValue = selOption[selOption.selectedIndex].text;
			 //alert('selectedValue: '+selectedValue);
			 if(selectedValue != null){
			 	var scoring=selectedValue.split("-");
			 	if(scoring[0] != null){
			 		if(isNumber(scoring[0]))
			 		{
			 			score=score*scoring[0];
			 		}
			 	}
			 }
		 }
		// alert('score: '+score);
		 var selectedOptionPart = selectedOption.split("-");
		 if(selectedOptionPart.length == 1){
		 	document.getElementById('answers['+rrQuestion+']').value=score;
		 }else{
			//alert('answers['+rrQuestion+'-'+selectedOptionPart[1]);
			document.getElementById('answers['+rrQuestion+'-'+selectedOptionPart[1]).value=score;
			if(document.getElementById('answers['+rrQuestion+'-'+selectedOptionPart[1]).tagName.toLowerCase() == 'span') {
				document.getElementById('answers['+rrQuestion+'-'+selectedOptionPart[1]).firstChild.value=score;
			}
		 }
	 }
  }
  
  function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}
  
  function initScore(){
	  
	  var score=1;
	  var scoringIds=jobScoringQuestions.split(",");
	  rrQuestion = '<%=request.getAttribute("rrQuestion")%>';
			 var index1 = scoringIds.indexOf('${rrQuestionIdSeverity2}');
			 var index2 = scoringIds.indexOf('${rrQuestionIdLinkehood2}');
			 if(index1 > -1 && index2 > -1){
				 scoringIds.splice(index1, 1);
				 scoringIds.splice(index2, 1);
			 }
		 
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
 
</head>
<body >
 	<system:gdprBanner/>
 	
<div class="content" > 
<div class="table-responsive" >
<scannell:form id="theForm" onsubmit="onFormSubmit()">
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <c:if test="${assessment.id != null}">
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td id="assessmentId">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${assessment.displayId}"/>
    </td>

    <td ><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="businessAreas" />:</td>
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
              			<!-- ENV-3781: Rework needed for this template -->
            			<c:choose>
	            			<c:when test="${q.name == 'Name'}">
	            				<td><fmt:message key="assessment.title" />:
	            			</c:when>
	            			<c:when test="${q.name == 'Description'}">
	            				<td><fmt:message key="assessment.scope" />:
	            			</c:when>
	            			<c:otherwise>
	              				<td><c:out value="${q.name}" />:
	            			</c:otherwise>
      		  			</c:choose>
              			<c:if test="${q.help.helpText != null}" >
               				<img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="${q.help.helpText}"/>
      		  			</c:if>
      		  			</td>
      		  			<td ${s.last && s.index % 3 == 0 ? "colspan='5'" : (s.last && s.index % 3 == 1) ? "colspan='3'":""}><enviromanager:question path="answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false"/></td>
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
    <td ><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser">
    	<c:choose>
			<c:when test="${fn:length(responsibleUserList) lt maxListSize}">
				<scannell:select id="responsibleUser" path="responsibleUser" items="${responsibleUserList}" itemLabel="sortableName" itemValue="id" cssStyle="width:90% !important;" class="mediumWide" onchange="updateApprovalUser(this);"/>
			</c:when>
			<c:otherwise>
				    <input type="hidden" id="responsibleUser" style="width:90% !important;float:left"  name="responsibleUser" onchange="updateApprovalUser(this);" />
					<scannell:errors path="responsibleUser" cssStyle="float:left"/>
			</c:otherwise>
		</c:choose>
    </td>
    <td ><fmt:message key="assessment.approvalByUser" />:</td> 
    <td id="assessmentApprovalByUser">
    	<select name="approvalByUser" id="assessmentApprovalByUserSelect" items="${approvalUserList}" itemLabel="sortableName" itemValue="id" class="mediumWide" cssStyle="width:80%;float:left !important;" />
    </td> 
    <td ><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><input name="otherParticipants"  maxlength="40" cssStyle="float:left" class="form-control"/></td>
  </tr>
 
  <tr>
  <c:choose>
  <c:when test="${assessment.createdByUser != null}">
    <td ><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td colspan="3">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  <c:choose>
  <c:when test="${assessment.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
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

<div class="header">
<h3><fmt:message key="jobDetail" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">

<table id="theJobTable" class="table table-bordered table-responsive" > 
<col  />

<tbody>

 	<c:choose>
 		<c:when test="${outSideTableJobQuestion == null}">
 			<tr>
	 			<td style="width:30%;font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;font-size: 100%;"><fmt:message key="assessment.job.description" />:</td>
 			</tr>
 			<tr>
 				<td id="jobName" ><scannell:textarea path="jobName" cols="60" rows="2" cssStyle="display:inherit !important;width:30%;font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;font-size: 100%;color:#333;" /></td>
 			</tr>
 		</c:when>
 		<c:otherwise>
 			<tr>
	 			<td style="width:30%;font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;font-size: 100%;">${outSideTableJobQuestion.name}:</td>
 			</tr>
 			<tr>
 				<td id="jobName" >
 					<enviromanager:question path="answers" question="${outSideTableJobQuestion}" emptyOptionLabel="Choose" class="checkLength" cssStyle="float:left;width:20%" />
 				</td>
 			</tr>
 		</c:otherwise>
 	</c:choose>

 	</tr>
 	<tr> 	   
 		 <td><enviromanager:question writeRequiredHint="true" path="answers" question="${jobQuestion}"  emptyOptionLabel="Choose"  multiselectCheckboxes="false" onchange="setScore(this)"  cssStyle="min-width:80px;width:100%;font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;font-size: 100%;"/></td> 		
 	</tr>
  <tr>
    <td  style="text-align: center;">
      <c:out value="${command.template.footer}" />
    </td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</div>
</div>
</body>
</html>
