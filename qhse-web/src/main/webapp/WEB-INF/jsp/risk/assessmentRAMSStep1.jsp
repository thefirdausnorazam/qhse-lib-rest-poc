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
<script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>


<style type="text/css">
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
</style>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/risk.css'/>";

@import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";

</style>
<c:set value="500" var="maxListSize"/>
<script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var userCount = ${fn:length(responsibleUserList)};
	var maxListSize = '${maxListSize}';
	var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
	jQuery(function(){
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

 	  jQuery('select').not('#siteLocation').not('select[id^="answer"]').not('.tabClass').select2({width: '10%'});
	  jQuery('select[id^="answer"]').not("[id*='100112']").not("[id*='100113']").not("[id*='100286']").not('.tabClass').select2({width: '40%'});
	  jQuery('.tabClass select[id^="answer"]').not("[id*='100112']").not("[id*='100113']").not("[id*='100286']").select2({width: '100%'});	  
//	  jQuery('#responsibleUser').select2({width: '30%'});
//	  jQuery('#assessmentApprovalByUserSelect').select2({width: '82%'});
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
	      width: '82%'
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
	
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var auditorCount2 = ${fn:length(approvalUserList)};
	var maxListSize2 = 500;
	if(auditorCount2 < maxListSize2)
	{
		jQuery('#approvalUserList').select2({width:'82%'});
	}
	else 
	{
		var data = [];
		<c:forEach items="${command.approvalUserList}" var="sa">
		    jQuery('#approvalUserList').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
		    jQuery('#approvalUserList').val('<c:out value="${sa.id}"/>');
		    jQuery('#approvalUserList option[value="${sa.id}"]').attr("selected","selected");
		    data.push('${sa.id}');
		</c:forEach>
 	    
		jQuery('#approvalUserList').select2('val', data);
		
		jQuery('#approvalUserList').select2({				  
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
				var data = [];
				<c:forEach items="${command.approvalUserList}" var="sa">
			    	data.push({id: "<c:out value="${sa.id}"/>", text: "<c:out value="${sa.sortableName}"/>"});
				</c:forEach>
			    callback(data); 
			},

		      // NOT NEEDED: These are just css for the demo data
		      dropdownCssClass : 'capitalize',
		      containerCssClass: 'capitalize',
		      // configure as multiple select
		      multiple         : true,
		      // NOT NEEDED: text for loading more results
		      formatLoadMore   : 'Loading more...',	
		      cache: true,
		});
	}
	
  });
  
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
    var fields = ['answers[58]', 'answers[59]','answers[300347]'];
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
//		jQuery("#assessmentApprovalByUserSelect").select2('destroy');
	    //var option = optionName(responsibleUserSelect, responsibleUserSelect.value);
//	  	dwr.util.setValue("assessmentApprovalByUserSelect", responsibleUserSelect.value);
//	  	jQuery("#assessmentApprovalByUserSelect").select2({width: '82%'});
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
 	
	<div class="content">
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
											cols="75" rows="3" onclick="hideHint();" cssStyle="float: left;"/>     
										</c:when>
										<c:otherwise>
											<fmt:message key="assessment.confidential" />
											<scannell:textarea path="name" id="assessmentNameText"
											cols="75" rows="3" onclick="hideHint();" cssStyle="float: left;" visible="false"/>
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
															<td class="searchLabel" colspan="4"><c:out value="${q.name}" />:</td>
														</c:when>
														<c:otherwise>
															<td class="searchLabel <c:if test='${fn:length(q.name) <= 35}'>nowrap</c:if>"><c:out
																	value="${q.name}" />: <c:if test="${q.help.helpText != null}">
																	<img src="<c:url value="/images/help_small.gif"/>" data-toggle="tooltip"
																		data-original-title="${q.help.helpText}" />
																</c:if></td>
															<td colspan="3" class="search">
																<c:choose>
																	<c:when test="${q.answerType.name == 'table'}">
																		<enviromanager:question cssStyle="float:left;width:90% !important;"
																			path="answers" class="mediumWide changeName" question="${q}" emptyOptionLabel="Choose"
																			multiselectCheckboxes="false" />
																	</c:when>
																	<c:otherwise>
																		<enviromanager:question cssStyle="width:100% !important;float:left"
																			path="answers" class="mediumWide changeName" question="${q}" emptyOptionLabel="Choose"
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
													cssStyle="width:100%" renderEmptyOption="true" onchange="updateApprovalUser(this);" /></div>
											</c:when>
											<c:otherwise>
												    <div style="width:83%"><input type="hidden" id="responsibleUser" style="width:82% !important;"  name="responsibleUser" onchange="updateApprovalUser(this);" />
													<scannell:errors path="responsibleUser"/></div>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>

								
								<tr class="form-group">
									<td class="searchLabel nowrap"><fmt:message key="assessment.ApprovalUsers" />:</td>
									<td colspan="3" class="search" >
										<c:choose>
											<c:when test="${fn:length(approvalUserList) lt 500}">
												<scannell:select id="approvalUserList" path="approvalUserList" items="${approvalUserList}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
													cssStyle="width:83%" renderEmptyOption="false" />
											</c:when>
											<c:otherwise>
												<input type="hidden" id="approvalUserList" style="width:100%;" multiple="multiple" name="approvalUserList"/>
											</c:otherwise>
										</c:choose>
									</td>
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
									<input type="hidden" id="stepEdit" name="stepEdit" value="true" />
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
