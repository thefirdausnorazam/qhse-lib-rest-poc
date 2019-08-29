<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<c:url var="url" value="/doclink/linkView.htm">
	<c:param name="name" value="RiskTemplate[${command.template.id}]" />
</c:url>
<!DOCTYPE html>
<html>
<head>
<%-- <title><fmt:message key="assessmentStep1.title" /> </title> --%>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
<c:choose>
	<c:when test="${command.template.id == 4002}">
		<script type="text/javascript" src="<c:url value="/js/addRemoveBiologicalAgents.js" />"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
	</c:otherwise>
</c:choose>
<style>
/* The container */
.container {
    display: block;
    position: relative;
    padding-left: 35px;
    margin-bottom: 12px;
    cursor: pointer;
    font-size: 16px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* Hide the browser's default checkbox */
.container input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
}

/* Create a custom checkbox */
.checkmark {
    position: absolute;
    top: 0;
    left: 0;
    height: 25px;
    width: 25px;
    background-color: #eee;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
    background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
    background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
    content: "";
    position: absolute;
    display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
    display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
    left: 9px;
    top: 5px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 3px 3px 0;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
}
</style>

<style type="text/css">
textarea{  
  display: block;
  box-sizing: padding-box;
  overflow: hidden;
  font-size: 14px;
  border: 1;
  height:100% !important;
}

/*textarea:focus{
	border-color: #13ab94 !important;
	
}*/
.sp{
padding-left:0% !important;
}
td.searchLabel {
	padding-right: 4% !important;
}

.form-group1 {
	margin: 0; padding: 20px 0; border-bottom: 1px dashed #efefef; height: 20px !important;
}

td.searchLabel {
	padding-left: 0px !important; background-color: white !important; border-width: 0px !important;
	font-family: 'Open Sans', sans-serif !important; font-weight: 600; text-align: right; padding-top: 1% !important;
	margin-top: 0; margin-bottom: 0; font-size: 100%;
}

td.search {
	background-color: white !important; border-width: 0px !important; padding-top: 1% !important; width: 30% !important;
}
td{
	min-width: 90px;
}
table.tabClass td span.col-sm-10 {
      padding: 0px !important;
      padding-left: 3px !important;
      padding-right: 2px !important;
      padding-top: 5px !important;
      width: 100% !important;
      
    }
 textarea {
	width: 90% !important;
}

.tabClass input[type="textarea"] {
	width: 90% !important;
}

.tabClass input[type=text] {
	width: 90% !important;
} 

/*.select2-choices:focus {
	border-color: #13ab94 !important;
}*/
</style>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/risk.css'/>";

@import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";

</style>
<c:set value="500" var="maxListSize"/>
<script type="text/javascript">
//Applied globally on all textareas with the "autoExpand" class
var baseScrollHeight = 36;

	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
	var userCount = ${fn:length(responsibleUserList)};
	var maxListSize = '${maxListSize}';
	jQuery(function(){
		jQuery(".autoExpand").keyup(function(){
			var minRows = 2, rows;
	        this.rows = minRows;
	    	if(jQuery.isNumeric(this.baseScrollHeight)){
	    		baseScrollHeight = this.baseScrollHeight;
	    	}
	        rows = Math.ceil((this.scrollHeight - baseScrollHeight) / 16);
	        this.rows = minRows + rows;
		});
		setTimeout(function (){jQuery(".autoExpand").each( function(){
			var minRows = 2, rows;
	        this.rows = minRows;
	        rows = Math.ceil((this.scrollHeight - baseScrollHeight/*this.baseScrollHeight*/) / 16);
	        this.rows = minRows + rows;
	    });}, 20);
// 	      //Keep track of last scroll
 	      var lastScroll 	= 0;
 	      var count 		= 0;
 	     jQuery(window).scroll(function(event){
	          //Sets the current scroll position
	          var st = $(this).scrollTop();
	          //Determines up-or-down scrolling
	          //if (st > lastScroll && count != 0){
	        	  //jQuery('select.changeName').select2();
	        	  jQuery('.select2-no-results').each(function (index) {//select2-display-none select2-results select2-no-results
	        		  
	        		  jQuery(this).parent().parent().css("display","none");
	        		  //jQuery(this).remove();
	        	  });
	        	  jQuery('.select2-results').parent().css("display","none");
	        	  count = 0;
	          //}
	          //Updates scroll position
	          lastScroll = st;
	          count++;
 	      });
 	    });
	

  jQuery(document).ready(function() { 
	  jQuery("#theForm").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});	
 	  jQuery('select').not('#siteLocation').not('select[id^="answer"]').not('.tabClass').not('#answers\\[207\\]').not('#answers\\[209\\]').not('#answers\\[210\\]').not('[id^=answers\\[100103]').select2({width: '10%'});
	  jQuery('select[id^="answer"]').not("[id*='100112']").not("[id*='100113']").not("[id*='100286']").not('.tabClass').not("select.noLoadSelect2").not('#answers\\[207\\]').not('#answers\\[209\\]').not('#answers\\[210\\]').not('#answers\\[103416\\]').not('#answers\\[103420\\]').not('[id^=answers\\[100103]').select2({width: '40%'});
	  jQuery('.tabClass select[id^="answer"]').not("[id*='100112']").not("[id*='100113']").not("[id*='100286']").not("select.noLoadSelect2").not('#answers\\[207\\]').not('#answers\\[209\\]').not('#answers\\[210\\]').not('#answers\\[103416\\]').not('#answers\\[103420\\]').not('[id^=answers\\[100103]').select2({width: '100%'});	  
//	  jQuery('#responsibleUser').select2({width: '30%'});
	  jQuery('#assessmentApprovalByUserSelect').select2({width: '82%'});
	/*   jQuery("[id*='300347']").prop("disabled", true); */
	  <%-- Few question that are in a table causing problem with a select2. so for time being we are not converting those select into new select untill some resolution is acheived --%>
 
	  
//     var multiselect = jQuery("#answers\\[58\\]");
   var templateId = location.search.split('templateId=')[1];
	//ENV-3759: TEMP FIX: This Janssen templates contains multi select children and select2 is causing problems
	if(templateId != null && templateId != 2007 && templateId != 2008)
	{
		var multiselect = jQuery('select[multiple="multiple"]');
	    multiselect.removeClass("scrollList");
	    multiselect.select2({
	      width: '82%',placeholder: "Choose"
	    });
	}	
    init(); 

    var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
	if(responsibleUser != null){
		jQuery('#responsibleUser').val(responsibleUser);
	}
	if(userCount < maxListSize && userCount > 0)
	{
		jQuery('#responsibleUser').select2({width:'82%'});
	}
	else 
	{
   		jQuery('#responsibleUser').select2({				  
		  width:'82%',
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
	}
	<c:forEach items="${questionsWithPictograms}" var="question" varStatus="s">
	//setTimeout(function (){
	jQuery(document.getElementById("answers[${question.id}]")).select2({ 
		formatResult: format, 
		formatSelection: format, 
		placeholder: "Choose",
		width: '82%',
		escapeMarkup: function(m) { return m; } 
		}); 
		//}, 2000); 
	jQuery(document.getElementById("answers[${question.id}]")).on("select2-loaded", function(e) { loadPictogramList();})
	jQuery(document.getElementById("answers[${question.id}]")).on("select2-selecting", function(event) { 
		setTimeout(function (){jQuery(".option-pictogram-"+event.val).attr("src", mapPictogram["pic-"+event.val]);}, 500);
	});
	</c:forEach>
	loadPictogramList();
  });
  var mapPictogram = new Object();
  var optionPictogramList = new Array();
  function format(state) { 
		if (!state.id) return state.text; // optgroup 
		var idTemp = ID();
		var imgName = state.text.replace(/\ /g, '');
		//var pathImage = '<c:url value="/images/"/>/'+state.id+'.png';//alert(pathImage)
		var pathImage = '<c:url value="/images/"/>/no_pictogram.png';//alert(pathImage)
		var returnValue = '<img id="'+idTemp+'" option_id="'+state.id+'" class="option-pictogram-'+state.id+'" src="'+pathImage+'" width="40" height="40">&nbsp;&nbsp;'+ state.text;
		optionPictogramList.push(state.id);
		return returnValue;
		//return "<img class='flag' src='https://www.mobilemini.co.uk/wp-content/uploads/2015/06/Fotolia_27934100_S-e1440075486241.jpg' width='50' height='50'>&nbsp;&nbsp;"+ state.text;
		}
  var ID = function () {
	  // Math.random should be unique because of its seeding algorithm.
	  // Convert it to base 36 (numbers + letters), and grab the first 9 characters
	  // after the decimal.
	  return '_' + Math.random().toString(36).substr(2, 9);
	};
	function loadPictogramList(){
		var jsonData = new FormData();
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
								mapPictogram["pic-"+imageObjList[i].question] = "data:image/jpg;base64,"+imageObjList[i].imageInBase64
							}
						}
						optionPictogramList=new Array();
					}
			     }
			}
	    }
	}
  function hideHint(){
	  
	  var myE = document.getElementById("assessmentNameText");
	  
	  if (myE.value == "Risk Assessment Title"){
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
	   if(!isNaN(theIndex)){
     	var url = '<c:url value="/doclink/linkView.htm?name=RiskTemplate[${command.template.id}]&index='+ theIndex+'"/>';
	   }else{
		   // if index is undefined show default 0.
		   var url = '<c:url value="/doclink/linkView.htm?name=RiskTemplate[${command.template.id}]&index='+0+'"/>';
	   }
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
    var fields = ['answers[58]', 'answers[59]','answers[300347]'];
    for (var i=0; i<fields.length; i++) {
      if(fields[i] == 'answers[59]')	{
    	  var field = document.getElementById(fields[i]);      
          if (field) {
            var emptySelect = field.options && field.options.length <= 1;       
            var emptyCheckboxList = !field.innerHTML; 
            if(field.parentNode != null && field.parentNode != 'undefined')
            {
    	        if (emptySelect || emptyCheckboxList) {	
    	        	if(field.parentNode.parentNode.parentNode.parentNode.tagName == 'TR'){
    	        		field.parentNode.parentNode.parentNode.parentNode.style.display="none";
    	        	} else {
    	        		field.parentNode.parentNode.parentNode.style.display="none";
    	        	}
    	        } else {
    	          try {
    	        	  if(field.parentNode.parentNode.parentNode.parentNode.tagName == 'TR'){
    	        		  field.parentNode.parentNode.parentNode.parentNode.style.display="";
    	        	  }else {
    	        		  field.parentNode.parentNode.parentNode.style.display="";
    	        	  }
    	          } catch(e) {
    	        	  if(field.parentNode.parentNode.parentNode.parentNode.tagName == 'TR'){
    	        		  field.parentNode.parentNode.parentNode.parentNode.style.display="block";
    	        	  }else {
    	        		  field.parentNode.parentNode.parentNode.style.display="block";
    	        	  }
    	          }
    	        }
            }
          }
      }else{
      var field = document.getElementById(fields[i]);      
      if (field) {
        var emptySelect = field.options && field.options.length <= 1;       
        var emptyCheckboxList = !field.innerHTML; 
        if(field.parentNode != null && field.parentNode != 'undefined')
        {
	        if (emptySelect || emptyCheckboxList) {	        	
	          field.parentNode.parentNode.parentNode.style.display="none";
	        } else {
	          try {
	            field.parentNode.parentNode.parentNode.style.display="";
	          } catch(e) {
	            field.parentNode.parentNode.parentNode.style.display="block";
	          }
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
	    checkHiddenFields();
	    checkForSubTables();
	    showHint();
	    initDependsOn("theForm");
	    <fmt:message key="assessmentStep1.saveDataMsg" />
	  }

  function onFormSubmit(){	  
    var fields = new Array('answers[39]');
    this;
/*     jQuery("[id*='300347']").prop("disabled", false);
 	 jQuery("[id*='300347']").val('2110433'); */
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
		jQuery("#assessmentApprovalByUserSelect").select2('destroy');
	    //var option = optionName(responsibleUserSelect, responsibleUserSelect.value);
	  	dwr.util.setValue("assessmentApprovalByUserSelect", responsibleUserSelect.value);
	  	jQuery("#assessmentApprovalByUserSelect").select2({width: '82%'});
	  }
	function limitText(limitField, limitCount, limitNum) {
		  	if (limitField.value.length > limitNum) {
		  		limitField.value = limitField.value.substring(0, limitNum);
		  	} else {
		  		limitCount.value = limitNum - limitField.value.length;
		  	}
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

  </script>

</head>
<body>
 	<system:gdprBanner/>
	
	<div class="content"> <font style="color:red"> 
<c:forEach items="${wrongSiteMessages }" var="wrongSiteMessage"><c:out value="${wrongSiteMessage }"/><br></c:forEach></font>
		<scannell:form id="theForm" onsubmit="onFormSubmit()">


			<ul class="raMenu">
				<c:choose>
					<c:when test="${assessment.id != null}">
						<li class="selected">Activity <i class="fa fa-chevron-circle-right fa-1g"></i></li>
						<c:if test="${command.template.scorable}">
							<li><a
									href="<c:url value="/risk/assessmentStep2.htm"><c:param name="showId" value="${param.showId}" /></c:url>"
									data-modal="colored-danger" onclick="<fmt:message key="warning.changeAssessmentTab" />">Score &amp;
									Justification</a></li>
						</c:if>
						<li><a
								href="<c:url value="/risk/assessmentStep3.htm"><c:param name="showId" value="${param.showId}" /></c:url>"
								onclick="<fmt:message key="warning.changeAssessmentTab" />">Review &amp; Save</a></li>
					</c:when>
					<c:otherwise>
						<li class="selected">Activity/Impact</li>
						<c:if test="${command.template.scorable}">
							<li>Score &amp; Justification</li>
						</c:if>
						<li>Review &amp; Save</li>
					</c:otherwise>
				</c:choose>

			</ul>

			<div class="content">
				<div class="table-responsive">
					<div class="panel panel-danger">
						<table class="table table-bordered table-responsive " style="margin-top: 0px;">
							<col class="label" />
							<tbody>
								<c:if test="${assessment.id != null}">
									<tr class="form-group">
										<td class="searchLabel"><fmt:message key="id" />:</td>
										<td class="search" id="assessmentId"><scannell:hidden path="id" /> <scannell:hidden path="version" /> <c:out
												value="${assessment.displayId}" /> <c:if test="${assessment.confidential}">
												<fmt:message key="assessment.confidential" />
											</c:if></td>

										<td class="searchLabel"><fmt:message key="assessment.status" />:</td>
										<td class="search" id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
									</tr>
								</c:if>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="businessAreas" />:</td>
									<td colspan="3" class="search" id="assessmentBusinessAreas"><scannell:hidden path="businessAreas"
											writeRequiredHint="false" /> <c:forEach items="${command.businessAreas}" var="ba">
											<c:out value="${ba.name}" />
										</c:forEach></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="assessment.name" />:</td>
									<td class="search" colspan="3" id="assessmentName">
									<c:choose>
										<c:when test="${assessment == null || assessment.sensitiveDataViewable}">
											<scannell:textarea path="name" id="assessmentNameText"
											cols="75" rows="3" onclick="hideHint();" cssStyle="width:90%" class="form-control"/>
										</c:when>
										<c:otherwise>
											<fmt:message key="assessment.confidential" />
											<scannell:textarea path="name" id="assessmentNameText" visible="false"
											cols="75" rows="3" onclick="hideHint();" cssStyle="width:90%" class="form-control"/>
										</c:otherwise>
									</c:choose>
									</td>
								</tr>
								<c:forEach items="${command.template.detailsQuestionGroups}" var="g">
									<c:if test="${g.active}">
										<c:if test="${g.name != null && g.name != ''}">
											<tr class="form-group1">
												<td style="text-align: left" colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}" /></td>
											</tr>
										</c:if>
										<c:forEach items="${g.questions}" var="q">
											<c:if test="${q.active and q.visible}">
												<tr class="form-group">
													<c:choose>
														<c:when test="${q.answerType.name == 'label'}">
															<td class="searchLabel" colspan="4" style="text-align: center;"><c:out value="${q.name}" /></td>
														</c:when>
														<c:otherwise>
															<td class="searchLabel <c:if test='${fn:length(q.name) <= 35}'>nowrap</c:if>" <c:if test='${fn:length(q.name) > 200}'>style="white-space:pre-wrap"</c:if>><c:out
																	value="${q.name}" />: <c:if test="${q.help.helpText != null}">
																	<img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip"
																		data-original-title="${q.help.helpText}" />
																</c:if></td>
															<td colspan="3" class="search">
																<c:choose>
																	<c:when test="${q.answerType.name == 'table'}">
																		<enviromanager:question cssStyle="float:left;width:90% !important;"
																			path="answers" class="mediumWide changeName autoExpand noLoadSelect2" question="${q}" emptyOptionLabel="Choose"
																			multiselectCheckboxes="false" />
																	</c:when>
																	<c:otherwise>
																		<enviromanager:question cssStyle="width:100% !important;float:left"
																			path="answers" class="mediumWide changeName autoExpand" question="${q}" emptyOptionLabel="Choose"
																			multiselectCheckboxes="false" />
																	</c:otherwise>
																</c:choose>
															</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>

								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="assessment.responsibleUser" />:</td>
									<td colspan="3" class="search" id="assessmentResponsibleUser">
								    	<c:choose>
											<c:when test="${fn:length(responsibleUserList) lt maxListSize && fn:length(responsibleUserList) > 0}">
												<div style="width:100%"><select name="responsibleUser" id="responsibleUser" items="${responsibleUserList}" itemLabel="sortableName" itemValue="id"
													cssStyle="width:82%" renderEmptyOption="true" onchange="updateApprovalUser(this);" /></div>
											</c:when>
											<c:otherwise>
												    <div style="width:100%"><input type="hidden" id="responsibleUser" style="width:82% !important;"  name="responsibleUser" onchange="updateApprovalUser(this);" />
													<scannell:errors path="responsibleUser"/></div>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel nowrap"><fmt:message key="assessment.approvalByUser" />:</td>
									<td colspan="3" class="search" id="assessmentApprovalByUser"><div style="width:100%"><select name="approvalByUser"
											id="assessmentApprovalByUserSelect" items="${approvalUserList}" itemLabel="sortableName" itemValue="id"
											cssStyle="width:100%" renderEmptyOption="true" /></div></td>
								</tr>

								<tr class="form-group">
									<td class="searchLabel nowrap"><fmt:message key="assessment.otherParticipants" />:</td>
									<td class="search" colspan="3" id="assessmentOtherParticipants"><input name="otherParticipants"
											class="form-control" cssStyle="width:82%;" onkeydown="limitText(this.form.otherParticipants,this.form.countdown,250);" onkeyup="limitText(this.form.otherParticipants,this.form.countdown,250);"/>
									<br>
										<font size="1"><fmt:message key="assessmentStep1.youHave" />&nbsp<input readonly type="text" name="countdown" size="3" value="250" style="border: none"><fmt:message key="assessmentStep1.characterLeft" /></font>		
									</td>
								</tr>

								<tr class="form-group">
									<c:choose>
										<c:when test="${assessment.createdByUser != null}">
											<td class="searchLabel"><fmt:message key="createdBy" />:</td>
											<td class="search" id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message
													key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
										</c:when>
										<c:otherwise>
											<td class="searchLabel">&nbsp;</td>
											<td class="search">&nbsp;</td>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${assessment.lastUpdatedByUser != null}">
											<td class="searchLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
											<td class="search" id="assessmentLastUpdatedBy"><c:out
													value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
													value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
										</c:when>
										<c:otherwise>
											<td class="searchLabel">&nbsp;</td>
											<td class="search">&nbsp;</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<c:if test="${command.clone}">
								<tr>
									<td  class="searchLabel"><input type="button" class="g-btn g-btn--primary" onclick="showSiteList()" value="Choose Sites"></td>
									<td colspan="3" class="search"><div id="div-site-list">
  		<ul><c:forEach items="${selectedSiteList }" var="site">
	  	<li><c:out value="${site.name }"></c:out> <input type="hidden" value="${site.id }" class="site-ids-selected" name="sites-id" id="sites-id-${site.id }" ></li>
	  </c:forEach></ul></div></td>
								</tr>
								</c:if>
								<tr>
									<td colspan="5" class="center-label"><c:out value="${command.template.footer}" /></td>
								</tr>
								<div class="help" id="help" style="display: none; position: absolute;"></div>
							</tbody>

							<tfoot>
								<tr>
									<td colspan="4" align="center">
									<c:if test="${!command.template.attachmentDriven}">
										<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="next" />">
									</c:if>
									<c:if test="${command.template.attachmentDriven}">
										<input type="hidden" id="nrag" name="nrag" value="nocolor" />
										<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="save" />">
									</c:if>
									
									</td>
								</tr>
							</tfoot>
						</table>
						<div id="dialogSites" style="display:none" title="Site List"></div>
<script type="text/javascript">
function showSiteList (){
	jQuery("<div>", { id: "site-list-panel"}).appendTo(jQuery("#dialogSites"));
	jQuery("#site-list-panel").children().remove();
	jQuery("#siteLocation option").each(function (){
		jQuery("<label>", { class:"container label-sites", id: "site-"+this.value, text:this.text}).appendTo(jQuery("#site-list-panel"));
		jQuery("<input>", { type:"checkbox", class:"checkbox-sites", id: "site-checkbox"+this.value, value:this.value, sitename:this.text}).appendTo(jQuery("#site-"+this.value));
		jQuery("<span>", { class:"checkmark" }).appendTo(jQuery("#site-"+this.value));
	});
	jQuery(".site-ids-selected").each(function (){
		jQuery("#site-checkbox"+this.value).prop("checked", "checked");
	});
    jQuery("#dialogSites").dialog();
    
    jQuery("<div>", {style:"text-align:center", id:"button-close-site"}).appendTo(jQuery("#dialogSites"));
	jQuery("<input>", {type:"button", class:"g-btn g-btn--primary", onclick:"closeSiteDialog()", value:"Confirm"}).appendTo(jQuery("#button-close-site"));
}
function closeSiteDialog(){
	jQuery('#dialogSites').dialog('close');
}
jQuery( "#dialogSites" ).on( "dialogclose", function( event, ui ) {
	jQuery("#div-site-list").children().remove();
	jQuery("<ul>", { id:"selected-sites" }).appendTo(jQuery("#div-site-list"));
	jQuery(".checkbox-sites").each(function (){
		if(jQuery(this).is(":checked")){
			jQuery("<li>", {text:jQuery(this).attr("sitename"), id:"li-site-"+this.value }).appendTo(jQuery("#selected-sites"));
			jQuery("<input>", {type:"hidden", value:this.value, class:"site-ids-selected", name:"sites-id", id:"sites-id-"+this.value }).appendTo(jQuery("#li-site-"+this.value));
		}
	});
	jQuery("#button-close-site").remove();
} );

</script>
					</div>
				</div>
			</div>
		</scannell:form>
	</div>
</body>
</html>
