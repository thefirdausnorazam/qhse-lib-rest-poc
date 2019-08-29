<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value="/js/boot.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>
 <%--  <link type="text/css" href="<c:url value="/js/select2-3.2/select2.css" />" rel="stylesheet" />	
  <script type="text/javascript" src="<c:url value="/js/select2-3.2/select2.js" />" ></script> --%>
 <style type="text/css">
 textarea{
	 width:100%;
 }
 select{
 width:100%;
 }
 input[type="text"] {
    width: 100%;
   /*  display: block; */
    
    
}
 .sp{  width: 100% !important}
 .col-sm-10{
 width: 100% !important;
 padding-right: 0px; 
  padding-left: 0px; 
 }
 #jobId{
    width: 100%;
    padding: 10px;
}
 </style>
 

  <script type="text/javascript">
  var jobScoringQuestions=null;
  var jobScoringTotal=null;
  var rrQuestion=null;
  var rrQuestionCon=0;
  var rrQuestionMag=0;
  var probability=0;
  var controlFactor;
  var correctedMagnitude;
  var checkForTheCondition;
  var deleteJob;
  var renderJob;
  var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
  jQuery( window ).unload(function() {
	  $(jQuery('#loadMask')).unblock();
	});
  jQuery(document).on('click', '.deleteJob', function() {	  
		var jId=jQuery(this).attr('job-id');	
		//alert(jQuery("#delJob").attr('h-task'));
		if(jQuery("#delJob").attr('h-task') == 'noDelete'){			
			 bootbox.alert("This Job cannot be deleted as there is associated task(s) ");
		}else{			
	     deleteJob(jId);
		}
		
  });
  
  jQuery(document).on('click', '.delete', function() {
	  if((jQuery('.delete').length) == jQuery('.newDel').length+1){	    		 
		  alert("A Job cannot exist without hazards");
	  }
	  else if (!jQuery(this).hasClass('newDel')) {	  
		  var hId=jQuery(this).attr('h-id');
		  var tsize=jQuery(this).attr('t-size');	   
		  bootbox.confirm("Are you sure want to delete?", function(result) {
			  
		      if(result){
		    	  if(tsize >0){
		    		  bootbox.alert("This hazard cannot be deleted as there is associated task(s) ");
		    	  }else if(jQuery('.delete').length == 1){	    		 
		    		  var jId=jQuery("#delJob").attr('job-id');
		    		  deleteJob(jId);
		    	  }
		    	  else{
		    		  var url=contextPath + '/risk/deleteHazard.json?hazId='+hId;
		    		  var bod = jQuery('#loadMask');	
		    		  $(bod).block({ 
		    		         message: '<span>Deleting Hazard....</span>', 
		    		         css: { top: '0px' } ,
		    		         css: { position: 'block' }
		    		     });
		    		  jQuery.getJSON(url, function(json) {	    			 
		    			  var redirectUrl=contextPath + '/risk/editAssessmentJob.htm?showId='+json.assessmentId+'&jobId='+json.jobId;
		    			  window.location = redirectUrl;
		    		  });
		    	  }
		    	 
		    	  
		      }
		    });
	  }
  });
  
  jQuery(document).ready(function() {
	  deleteJob = function(jId) {		 
		  bootbox.confirm("<span>Deleting Job will delete all associated hazards</span><br><br><span>Do you want to proceed ? </span>", function(result) {
		      if(result){		    	
		    		  var url=contextPath + '/risk/deleteJob.json?jobId='+jId;
		    		  var bod = jQuery('#loadMask');	
		    		  $(bod).block({ 
		    		         message: '<span>Deleting Job & Hazards....</span>', 
		    		         css: { top: '0px' } ,
		    		         css: { position: 'block' }
		    		     });
		    		  jQuery.getJSON(url, function(json) {		    			 
		    			  var redirectUrl=contextPath + '/risk/expressAssessmentView.htm?showId='+json.assessmentId;
		    			  window.location = redirectUrl;
		    		  });		    	  
		      }
		    });
		  }; 
		  var set=false;
	  setInterval(function() {
		  if(!set){
		  bootbox.alert("This page has been displayed for some time now, you may wish to save your changes to avoid any loss.");
		  set=true;
		  }
		}, 5 * 60 * 1000);
	  
	  checkForTheCondition = function() {
		  var bod = jQuery('#loadMask');	
		  $(bod).block({ 
		         message: '<span>Saving Job & Hazards....</span>', 
		         css: { top: '0px' } ,
		         css: { position: 'block' }
		     });
		  var va=false;
		  jQuery('.requiredHinted').each(function() {
			   var sp =jQuery(this).prev('span');
			   var tt=sp.children('[id^=answer]');	
			   if(jQuery(tt).prop('type') == "select-multiple"){
				   if(jQuery(tt).val() == null){
					   jQuery(this).text('* required');
						  tt.css('border-color', 'red');
						  jQuery('input[type="submit"]').prop('disabled', false);
						   va=true; 
				   }
			   }else if (tt.val()  === '') {				 
				  jQuery(this).text('* required');
				  tt.css('border-color', 'red');
				  jQuery('input[type="submit"]').prop('disabled', false);
				   va=true;           
             }			 
			});
		  if(va){
			  $(jQuery('#loadMask')).unblock();
			  return false;
		  }		  
	  };
	  
	  jQuery(document).keypress(function(e){		  
		  if (e.currentTarget.activeElement != undefined) {			   
			     jQuery('input[type="submit"]').prop('disabled', false);			     
			  }		   
		});
	  jQuery('select').on('change', function() {
		  jQuery('input[type="submit"]').prop('disabled', false);
		});
	
	  
	  
	
	  
	//Manjush Start 
	renderJob = function() {
    var url;
    url = contextPath + '/risk/fetchJobData.json?showId='+getURLParam('showId')+'&jobId='+getURLParam('jobId');
    var idVal=jQuery('#hazardIds').val('');
    jQuery.getJSON(url, function(json) {    	
    	var jsonLength=json.length;
    	var cl =jQuery('.add');
    	for (i = 1; i < jsonLength; i++) { 
    		cl.click();
    	}
    	jQuery.each(json, function(key,value){ 
    		var delJob=document.getElementById('delJob');
    		delJob.setAttribute("job-id", value.jobId);
    		var delObj=document.getElementById(key+1);
    		delObj.setAttribute("h-id", value.hazardId);
    		var taskSize=value.taskSize;
    		delObj.setAttribute("t-size", taskSize);
    		if(taskSize > 0){
    			jQuery("#delJob").attr('h-task','noDelete');
    		}
    		delObj.removeAttribute("onclick");
    		var idValgr=jQuery('#hazardIds').val();
    		if(key>=1 ){    			
    			idValgr=idValgr+','+value.hazardId;
    			jQuery('#hazardIds').val(idValgr);    			     		
        	}else{        		
        		jQuery('#hazardIds').val(value.hazardId);        		
        	}   		
    		jQuery('#jobId').val(value.jobName);  
    		var rows = value.jobName.split("\n");
       	 	jQuery('#jobId').prop('rows', rows.length);
       	 	jQuery('#jobId').attr('rows',rows.length);
       	 	if(rows.length > 0) {
       	 		if(document.getElementById("jobId") != undefined && document.getElementById("jobId") !=  null) {
       	 			document.getElementById("jobId").style.removeProperty('height');
       	 		}
       	 	}
    		
       	 jQuery('#jobId').focus();
    		jQuery.each(value.jhDataList, function(key1,value1){    		    
    			if(key==0){
    				//populateQuestionOptions("answers["+value1.questionId+"]");
                    document.getElementById("answers["+value1.questionId+"]").value= value1.value;                    
                   }else{
                	   if(document.getElementById("answers["+value1.questionId+"-"+key+"]") !=null){
                	   document.getElementById("answers["+value1.questionId+"-"+key+"]").value= value1.value;    
                	   jQuery('.delete').removeClass('newDel');
                	   }
                   }    		
    		});   		
    	});
		if('${outSideTableJobQuestion != null}' == 'true'){
			setValues(json);
  		
    		}
    	/*  */
    });
  }; 
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
// Manjush End
	  jobScoringQuestions='<%=request.getAttribute("jobScoringQuestions")%>';
	  jobScoringTotal='<%=request.getAttribute("jobScoringTotal")%>';
	  rrQuestion='<%=request.getAttribute("rrQuestion")%>';
	  rrQuestionCon='<%=request.getAttribute("rrQuestionCon")%>';
	  rrQuestionMag='<%=request.getAttribute("rrQuestionMag")%>';
	  probability='<%=request.getAttribute("probabilityQuestion")%>';
	  controlFactor='<%=request.getAttribute("controlFactorQuestion")%>';
	  correctedMagnitude='<%=request.getAttribute("correctedMagnitude")%>';
	  initScore();
	    var multiselect = jQuery('select[multiple="multiple"]');
	    multiselect.removeClass("scrollList");
	    multiselect.select2({
	      width: '200px'
	    });
	    
	    renderJob();

	 var rowCount = 0;
	<c:forEach items="${answersMultiChoice}" var="aHazard" varStatus="s">
		<c:if test="${aHazard.active}">
			<c:forEach items="${aHazard.answers}" var="hAnswer" >
				if('${hAnswer.question.answerType.name}' == 'option-multi-choice'){
					var multiChoiceValues = new Array();
					var rowIndex = "answers[${hAnswer.question.id}]";
					if(rowCount > 0){
						rowIndex = 'answers[${hAnswer.question.id}_'+rowCount+']';
					}
					rowCount++;
					<c:forEach items="${hAnswer.selectedOptions}" var="selecOption" >
						multiChoiceValues.push('${selecOption.id}');
					</c:forEach>
					loadMultiChoiceValues.push({id: rowIndex, value: multiChoiceValues});
				}
			</c:forEach>
		</c:if>
	</c:forEach>
	setTimeout(function (){
		for(var i = 0 ; i < loadMultiChoiceValues.length; i++){
			jQuery(document.getElementById(loadMultiChoiceValues[i].id)).val(loadMultiChoiceValues[i].value).trigger('change');
		}
  	}, 1000);
  });
  var loadMultiChoiceValues = new Array();
  function setValues(values){
	  if(${command.job.name != null}){
	    jQuery('.pestel option').filter(function() { 
	        return ($(this).text() == "${jobName}"); 
	    }).prop('selected', true).trigger('change');
		jQuery('.pestel').select2({width: '50%'});
		//jQuery('.pestel').attr('disabled', true);
		jQuery('.pestel option').not(':selected').remove();
	  }
	//  forcing to load option which are not loaded in IE
	  
		jQuery("#theForm select").each(
			    function(index){  
			        var input = jQuery(this);
			        var dependson = input.attr('dependson');
			        if (dependson) {
			        	var dependsOnInput = jQuery('select[id*="'+getQuestionId(input.attr('dependson'))+'"]');
			        	if(dependsOnInput != null && dependsOnInput != 'undefined')
			        	{
			        		populateQuestionOptions(input.attr('id'));
			        	}
			        }
			    }
			);
	
		setTimeout(function(){ 
    	jQuery.each(values, function(key,value){ 
    		jQuery.each(value.jhDataList, function(key1,value1){    		    
    			if(key==0){
                    document.getElementById("answers["+value1.questionId+"]").value= value1.value;                    
                   }else{
                	   if(document.getElementById("answers["+value1.questionId+"-"+key+"]") !=null){
                	   document.getElementById("answers["+value1.questionId+"-"+key+"]").value= value1.value;    
                	   }
                   }    		
    		});    
   		
    	}); }, 800);

  }
  
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
  
  function openPopup(url, w, h) {
    var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
    var win = window.open(url, "links", att);
    win.focus();
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
    checkForSubTables();
    showHint();
    initDependsOn("theForm");
    //<fmt:message key="assessmentStep1.saveDataMsg" />
  }
  jQuery(window).bind('load', init);
  

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
		 var scoringIds=jobScoringQuestions.split(",");
		 if(selectedQuestion == '${rrQuestionIdSeverity2}' || selectedQuestion == '${rrQuestionIdLinkehood2}'){
			 rrQuestion = '<%=request.getAttribute("rrQuestion2")%>';
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
		 var selectedOption=elem.getAttribute("id"); 
		// alert(selectedOption)
		// var selectedValue=null
		 var scoreChanged=false;
		 
		 if(selectedQuestion != null)
		 {
			 for(var i=0; i<scoringIds.length; i++){
				 if(selectedQuestion.indexOf(scoringIds[i])){
					 scoreChanged=true;
		//			 var selOption = document.getElementById(selectedOption);
		//		     selectedValue = selOption[selOption.selectedIndex].text;
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
		  for(var i=0; i<scoringIds.length; i++){
			  var selOption = document.getElementById('answers['+scoringIds[i]+']');
			  var selectedValue = selOption[selOption.selectedIndex].text;
			 //alert('selectedValue: '+selectedValue);
			 if(selectedValue != null){
			 	var scoring=selectedValue.split("-");
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
		  document.getElementById('answers['+rrQuestion+']').value=score;
	  }
	 
	 
	 function setScore2(elem){
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
				 }else if((selValue.indexOf("50") != -1) && reduceValue>.5){
					 reduceValue = reduceValue - .5;
				 }else if((selValue.indexOf("30") != -1) && reduceValue>.3){
					 reduceValue = reduceValue - .3;
				 }else if((selValue.indexOf("15") != -1) && reduceValue>.15){
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
	 
  </script>
  <style type="text/css" media="all">
   @import "<c:url value='/css/calendar.css'/>";
  
   </style>
</head>
<body >
<%-- <div class="header">
<h2><fmt:message key="expressAssessmentStep1.title" /></h2>
</div> --%>

<div class="content" id="loadMask"> 
<scannell:form id="theForm"  onsubmit="return checkForTheCondition();">

<div class="header">
<h3>Job Edit</h3>
</div>
 <div class="content"> 
<!-- <div class="table-responsive">
<div class="panel panel-danger"> --> 
<div class="col-sm-12 col-md-12 col-lg-12" style="padding-top:5px;padding-bottom:5px">
<label ><fmt:message key="assessment.job.description" /></label>
</div>
<div class="col-sm-12 col-md-12 col-lg-12" style="padding-top:5px;padding-bottom:20px;">						
<div class="row ">						
<div class="col-sm-7 col-md-7 col-lg-7">
		<c:choose>
				<c:when test="${outSideTableJobQuestion ==null }">
					<scannell:textarea path="name" id="jobId" cssStyle="width:100%"/>	
				</c:when>
				<c:otherwise>
					${outSideTableJobQuestion.name } 
					<enviromanager:question path="answers" question="${outSideTableJobQuestion}" emptyOptionLabel="Choose" class="pestel" cssStyle="float:left;width:20%" />
				</c:otherwise>
		</c:choose>
</div>
<div class="col-sm-5 col-md-5 col-lg-5" >
<div style="float:right">
<input  class="deleteJob g-btn g-btn--primary" job-id='' h-task='false' id="delJob"  value="Delete Job" type="button">
</div>	
</div>
</div>					
</div>
<c:if test="${command.assessment.template.prefix != 'SA'}">

<table id="theJobTable" class="table  table-responsive" style="padding-top:3%">
<col />

<tbody>
<input type="hidden" id="hazardIds" name="hazardIds" value="">
	<%-- <tr>
	 	<td ><fmt:message key="assessment.job.description" />:</td>
 	</tr>
 	<tr>
	 	<td id="jobName" colspan="8" align="left"><scannell:textarea path="name" id="jobId"   cols="70" cssStyle="width:50%"/></td> 
 	</tr> --%>
 	<tr style="width:70%">
 		<td><enviromanager:question path="answers" cssStyle="width: 100%" question="${jobQuestion}" emptyOptionLabel="Choose" multiselectCheckboxes="false" onchange="setScore(this)"/></td>
 	</tr>
</tbody>
</c:if>


<c:if test="${command.assessment.template.prefix == 'SA'}">
<table id="theJobTable" class="viewForm" style="margin-top:0px;">
<col class="label" />
<thead>
<td colspan="12" align="left">Job Detail</td>
</thead>
<tbody>
				<tr>
					<td colspan="12">
					<table id="theJobTable" class="viewForm" style="margin-top:0px;">
							<thead>
							<tr>
								<th> <scannell:hidden path="name"/>
								<c:forEach items="${jobQuestion.columns}" var="columns">
							    <c:if test="${not fn:containsIgnoreCase(columns.codeName, 'cf')}">
							   		 <th><c:out value="${columns.name}"></c:out></th>
  						   		 </c:if>
								</c:forEach>
								</th>
								</tr>
							</thead>
							<tbody>
									<tr>
									<c:forEach items="${jobQuestion.columns}" var="columns2">
									
									<c:if test="${not fn:containsIgnoreCase(columns2.codeName, 'cf')}">
									<td>
										<enviromanager:question path="answers" question="${columns2}" emptyOptionLabel="Choose" multiselectCheckboxes="false" onchange="setScore2(this)"/>
									</td>
									</c:if>
									
									</c:forEach>
							</tr>
								<tr>
									<td colspan="12" class="scoringCategoryTitle">Control Factors:</td>
								</tr>

								<tr>
								<c:forEach items="${jobQuestion.columns}" var="columns3">
								<c:if test="${fn:containsIgnoreCase(columns3.codeName, 'cf')}">
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
</c:if>


<tfoot>
   <tr>
  		<td align="center"><input type="submit" class="g-btn g-btn--primary" id="submit" value="<fmt:message key="submit" />">
   			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${command.assessment.id}"/></c:url>'">
   		</td>
  </tr>
</tfoot>
</table>
 </div>
<!--</div>
</div> -->
</scannell:form>
</div>
</body>
</html>
