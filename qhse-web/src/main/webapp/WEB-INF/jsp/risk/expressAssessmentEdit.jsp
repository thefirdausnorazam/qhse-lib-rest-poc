<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<c:url var="url" value="/doclink/linkView.htm"><c:param name="name" value="RiskTemplate[${command.template.id}]" /></c:url>
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <%-- <script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script> --%>

	<%-- <link type="text/css" href="<c:url value="/js/select2-3.2/select2.css" />" rel="stylesheet" />
  <script type="text/javascript" src="<c:url value="/js/select2-3.2/select2.js" />" ></script> --%>

<c:set value="500" var="maxListSize"/>
  <script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
	var userCount = ${fn:length(responsibleUserList)};
	var maxListSize = '${maxListSize}';
	
  jQuery(document).ready(function() {
	 //  alert('Scoring Questions: '+jobScoringQuestions);
	//  alert('Number of scoring question: '+jobScoringTotal);
	//  alert('RA Rating qid : '+rrQuestion);
//     var multiselect = $jq("#answers\\[58\\]");
    jQuery('select').select2({width:'200px'});
    var multiselect = jQuery('select[multiple="multiple"]');
    multiselect.removeClass("scrollList");
    multiselect.select2({
      width: '400px'
    });
    
    init();
    
    var responsibleUser= '<c:out value="${assessment.responsibleUser.id}"/>';
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
			       var data = {id: "<c:out value="${assessment.responsibleUser.id}"/>", text: "<c:out value="${assessment.responsibleUser.sortableName}"/>"};
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
	}
  });
  
  function hideHint(){
	  
	  var myE = document.getElementById("assessmentNameText");
	  
	  if (myE.value  == "Risk Assessment Title"){
		  myE.style.color ="000";
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
        if(field.parentNode != null)
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
    //var option = optionName(responsibleUserSelect, responsibleUserSelect.value);  
  	dwr.util.setValue("assessmentApprovalByUserSelect", responsibleUserSelect.value);  	
  	jQuery("#assessmentApprovalByUserSelect").select2({width: '90%'});
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
	 //alert(selectedQuestion)
	 var selectedOption=elem.getAttribute("id"); 
	// alert(selectedOption)
	// var selectedValue=null
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
	// alert('scoreChanged: '+scoreChanged);
	 if(scoreChanged == true){
		 var score=1;
		 for(var i=0; i<scoringIds.length; i++){
			 var selectedOptionPart = selectedOption.split("-");
			 var selOption=null;
			 if(selectedOptionPart.length == 2){
			 	var selOption = document.getElementById('answers['+scoringIds[i]+'-'+selectedOptionPart[1]);
			 }else{
				 var selOption = document.getElementById('answers['+scoringIds[i]+']');
			 }
			 var selectedValue = selOption[selOption.selectedIndex].text;
			 //alert('selectedValue: '+selectedValue);
			 if(selectedValue != null){
			 	var scoring=selectedValue.split("-");
			 	if(scoring[0] != null){
			 		score=score*scoring[0];
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
		 }
	 }
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
		 		score=score*scoring[0];
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
<div class="header">
<h2><fmt:message key="expressAssessmentStep1.title" /></h2>
</div>
<div class="content">
<scannell:form id="theForm" onsubmit="onFormSubmit()">
<div class="content"> 
<div class="table-responsive">
<div class="panel">

<table class="table table-responsive table-bordered" style="margin-top:0px;">
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
    <td id="assessmentStatus" colspan="3"><fmt:message key="assessment${assessment.status}" /></td>
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
              			<td>
		            		<c:choose>
		            			<c:when test="${q.name == 'Name'}">
		            				<fmt:message key="assessment.title" />:
		            			</c:when>
		            			<c:when test="${q.name == 'Description'}">
		            				<fmt:message key="assessment.scope" />:
		            			</c:when>
		            			<c:otherwise>
		            				<c:out value="${q.name}" />:
		            			</c:otherwise>
		            		</c:choose>
              			<c:if test="${q.help.helpText != null}" >
               				<img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="${q.help.helpText}"/>
      		  			</c:if>
      		  			</td>
      		  				<td>
      		  				<c:choose>
      		  					<c:when test="${q.name == 'Description' and assessment.confidential == 'true'}">
	      		  					<c:choose>
		      		  					<c:when test="${assessment.sensitiveDataViewable}">
			  								<c:if test="${assessment.sensitiveDataViewable}"><enviromanager:question path="answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false"/></c:if>
				            			</c:when>
				            			<c:otherwise>
				            					<fmt:message key="assessment.confidential"/>
			      		  						<scannell:hidden path="answers[${q.id}]"/>
		      		  					</c:otherwise>
		      		  				</c:choose>
		            			</c:when>
		            			<c:otherwise>
      		  						<enviromanager:question path="answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false"/>
      		  					</c:otherwise>
      		  				</c:choose>
      		  			</td>
            		</c:otherwise>
          		</c:choose>
          		<c:choose>
					<c:when test="${s.index mod 3 == 2}">
						</tr>
					</c:when>
					<c:otherwise>
						<c:if test="${s.last}">
						<td colspan="6"></td>
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
			<c:when test="${fn:length(responsibleUserList) lt 500}">
				<scannell:select id="responsibleUser" path="responsibleUser" items="${responsibleUserList}" itemLabel="sortableName" itemValue="id" class="mediumWide" onchange="updateApprovalUser(this);"/>
			</c:when>
			<c:otherwise>
				    <input type="hidden" id="responsibleUser" style="width:90% !important;"  name="responsibleUser" onchange="updateApprovalUser(this);" />
					<scannell:errors path="responsibleUser"/>
			</c:otherwise>
		</c:choose>
	</td>
    <td ><fmt:message key="assessment.approvalByUser" />:</td>
    <td id="assessmentApprovalByUser">
    	<select name="approvalByUser" id="assessmentApprovalByUserSelect" items="${approvalUserList}" cssStyle="width:90%!important" itemLabel="sortableName" itemValue="id" class="mediumWide"/>
    </td> 
    <td ><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><input name="otherParticipants"  maxlength="40"/></td>
  </tr>
  <tr>
    
  </tr>
  
  <tr>
    
  </tr>
  <tr>
  <c:choose>
  <c:when test="${assessment.createdByUser != null}">
    <td ><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
  <td class="scannellGeneralLabel"><fmt:message key="assessment.targetReviewDate" /> 
									<c:if test="${assessment.approvable}">
										<img id="showReviewDateMesg" src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip" data-original-title="<fmt:message key="risk.reviewDate.help"/>" /> 
									</c:if>
									</td>
								<td colspan="3">
								<c:choose>
										 <c:when test="${userInRole}">
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
  </tbody>
  <tfoot>
	  <tr>
	    <td colspan="8" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
	    <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>'">
	    </td>
	  </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</div>
</body>
</html>
