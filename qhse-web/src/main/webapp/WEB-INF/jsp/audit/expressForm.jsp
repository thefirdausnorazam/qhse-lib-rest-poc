<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>

<head>	
   <style type="text/css">
   .state-icon {
    left: -5px;
}
.list-group-item-primary {
    color: rgb(255, 255, 255);
    background-color: rgb(66, 139, 202);
}

/* DEMO ONLY - REMOVES UNWANTED MARGIN */
.well .list-group {
    margin-bottom: 0px;
}
   
/*lines below were added to satisfy jira 5056*/   
 .col-sm-9 li {width:100% !important} 
 .col-sm-9 .requiredHinted{float:left}
/*span.error{float:left}*/
ul.checked-list-box{float:left}
div.myClass textarea{float:left}   
   </style>

	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
	<%-- <script type='text/javascript' src="<c:url value="/js/expressFormJS.js" />"></script> --%>
	
	<script type="text/javascript">	
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var auditorCount = ${fn:length(auditors)};
		var auditeeCount = ${fn:length(userAuditees)};
		var userCount = ${fn:length(allUsers)};
		var maxListSize = 500;
		jQuery.postJSON = function(url, data, callback) {  
			return jQuery.ajax({
		       url: url,
		       type: "POST",
		       data: data,
		       processData: false,
		       contentType: false,
		       success: callback
		    });
		};
		function loadResearch(methodTargetName){
			
			var objectIdArray = new Array(); 
			jQuery(".object-id").each(function (){
				var objectIdObj = {objectId: jQuery(this).val()}
				objectIdArray.push(objectIdObj);
			});
			var jsonData = new FormData();
			jsonData.append("objectIdArray", JSON.stringify(objectIdArray));
			jQuery.postJSON(methodTargetName, jsonData, function(responseFromController){
				var imageList = responseFromController.imageList;
				for(var i = 0; i < imageList.length; i++){
					jQuery("#img-"+imageList[i].question).attr("src", "data:image/jpg;base64,"+imageList[i].imageInBase64);
					jQuery("#img-"+imageList[i].question).css("height", "40px");
					jQuery("#img-"+imageList[i].question).show();
				}
				//jQuery(".not-image").remove();
				
			}).error(function(jqXHR, error, errorThrown) {
				jQuery(".not-image").remove();
				if (jqXHR.status && jqXHR.status == 400) {
					alert('<fmt:message key="noImageFoundPageNotFound" />')
				} else if (jqXHR.status && jqXHR.status == 500) {
					alert('<fmt:message key="noImageFoundInternalError" />')
				} else {
					alert('<fmt:message key="noImageFound" />')
				}
			});
		}
	jQuery(document).ready(function () {	
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			hideHint();// Remove default placeholder text.
			// submit once return true
			return true;
		});
		
		jQuery('[emptyoptionlabel="Choose"]').select2({width:'40%'});	
	jQuery('#theForm').addClass('form-horizontal group-border-dashed');	
	var leadAuditor = '<c:out value="${command.exam.leadAuditor.id}"/>';
	if(leadAuditor != null){
		jQuery('#leadAuditor').val(leadAuditor);
	}	
	if(auditorCount < maxListSize)
	{
		jQuery('#leadAuditor').select2({width:'80%'});
	}
	else 
	{
		jQuery('#leadAuditor').select2({				  
		  width:'80%',
		  minimumInputLength : 3,
		  placeholder :  enterChars,
		  escapeMarkup: function(m) {
		        // Do not escape HTML in the select options text
		        return m;
		     },
		  ajax: {
		        url: "auditorList.json",
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
		    	var data = {id: "<c:out value="${command.exam.leadAuditor.id}"/>", text: "<c:out value="${command.exam.leadAuditor.sortableName}"/>"};
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
	var auditeeUser= '<c:out value="${command.auditeeUser.id}"/>';
	if(auditeeUser != null){
		jQuery('#user').val(auditeeUser);
	}

	// For demonstration purposes we first make
	// a huge array of demo data (20 000 items)
	// HEADS UP; for the _.map function i use underscore (actually lo-dash) here
		init();
		showHint();
		
		   var multiselect = jQuery('select[multiple="multiple"]');
		    multiselect.removeClass("scrollList");
		    multiselect.select2({
		      width: '100%'
		    });  
			//jQuery('select').not('#siteLocation').select2({width:'100%'});
			//jQuery('#user').select2({width:'100%'});
			//jQuery('#leadAuditor').select2({width:'60%'});
			jQuery('#workarea').select2({width:'100%'});
			jQuery('#auditeeType').select2({width:'80%'});
			
			jQuery('#department').select2({width:'100%'});
			jQuery('#department2').select2({width:'100%'});
			jQuery('#location').select2({width:'100%'});
			jQuery('#hour').select2({width:'50%'});
			jQuery('#min').select2({width:'50%'});
			jQuery('#t_auditees').select2({width:'40%'});
		    
			  var usersToDepartment = {
				<c:forEach var="user" items="${userAuditees}" varStatus="s">"${user.id}": "${user.department.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
			};
			var usersToDepartmentName = {
				<c:forEach var="user" items="${userAuditees}" varStatus="s">"${user.id}": "${user.department.name}"<c:if test="${!s.last}">,</c:if></c:forEach>
			};  
			updatePageOptions(usersToDepartment, usersToDepartmentName); 
			 jQuery('#user').change(function() {
				updateUserOptions(usersToDepartment, usersToDepartmentName);
			}); 
			jQuery('#department').change(function() {
				updateWorkAreaOptions();
			});
			jQuery('#workarea').change(function() {
				updateLocationOptions();
			});			
			
			
			if(userCount < maxListSize)
			{
				var data = [];
				<c:forEach items="${command.exam.observers}" var="a">
			    	jQuery('#observers').append("<option value='${a.id}' >${a.displayNameWithDepartment}</option>") 
			    	jQuery('#observers').val('<c:out value="${a.id}"/>');
			    	jQuery('#observers option[value="${a.id}"]').attr("selected","selected");
			    	data.push('${a.id}');
				</c:forEach>
				jQuery('#observers').select2('val', data);
				jQuery('#observers').select2({width:'100%'});
			}
			else 
			{
				var d = "<c:out value="${command.exam.observers}"/>";
				var data = [];
				<c:forEach items="${command.exam.observers}" var="a">
			    	/* data.push({id: "<c:out value="${a.id}"/>", text: "<c:out value="${a.sortableName}"/>"});*/
			    	jQuery('#observers').append("<option value='${a.id}' >${a.displayNameWithDepartment}</option>") 
			    	jQuery('#observers').val('<c:out value="${a.id}"/>');
			    	jQuery('#observers option[value="${a.id}"]').attr("selected","selected");
			    	data.push('${a.id}');
				</c:forEach>
				jQuery('#observers').select2('val', data);
				
				jQuery('#observers').select2({
				  width:'100%',
				  dropdownAutoWidth : true,
				  minimumInputLength : 3,
				  placeholder :  enterChars,
				  escapeMarkup: function(m) {
				        // Do not escape HTML in the select options text
				        return m;
				     },
				  ajax: {
				        url: "activeList.json",
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
						 var d = "<c:out value="${command.exam.observers}"/>";
						var data = [];
						<c:forEach items="${command.exam.observers}" var="a">
					    	data.push({id: "<c:out value="${a.id}"/>", text: "<c:out value="${a.displayNameWithDepartment}"/>"});
					    	jQuery('#observers').append("<option value=${a.id}>${a.displayNameWithDepartment}</option>")
					    	jQuery('#observers option[value=${a.id}]').attr("selected","selected");
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
				      // query with pagination					
				});  
			}

			if(auditeeCount < maxListSize)
			{
				jQuery('#user').select2({width:'100%'});
			}
			else 
			{
			   jQuery('#user').select2({				  
				  width:'100%',
				  minimumInputLength : 3,
				  placeholder :  enterChars,
				  escapeMarkup: function(m) {
				        // Do not escape HTML in the select options text
				        return m;
				     },
				  ajax: {
				        url: "auditeeList.json",
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
					       var data = {id: "<c:out value="${command.exam.leadAuditor.id}"/>", text: "<c:out value="${command.auditeeUser.sortableName}"/>"};
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
			setTimeout(function() {
				loadResearch("auditQuestionImagesLazyLoad.htm");
			}, 1500);
			setNewAuditeeVisibility();
			
			jQuery(".ckbBA").each(function (){
				var businessAreaAnswer = '${examBusinessAreasAnswers}';
				if(businessAreaAnswer != null && businessAreaAnswer != "" && businessAreaAnswer != "null"){
					businessAreaAnswer = businessAreaAnswer.replace("[", "").replace("]", "").replace(" ", "");
					var baValues = businessAreaAnswer.trim().split(",");
					for(var c = 0; c < baValues.length; c++){
						if(baValues[c] == jQuery(this).val()){
								jQuery(this).attr("checked", true);
							}
					}
				}
			});
	});

	 function hideHint(){		  
		  var myE = document.getElementById("auditNameText");
		  if (myE.value  == "Fill in the name of the Location/Area in this box"){
		  	myE.style.color ="000";
		  	myE.value = "";
		  }		  
	  }
	
	 function showHint(){		  
		  var myE = document.getElementById("auditNameText");		  
		  if (myE.value  == ""){
			  myE.style.color ="#888";
			  myE.value = "Fill in the name of the Location/Area in this box";
		  }
	  }
	 
	 
	function init() {
	}

	function request()
	{
		document.forms[0].Review.value = "true";
	}
	function onAuditeeTypeChange() {
		if (jQuery('#auditeeType').val() == 'u') {
			showBlock('userAuditeeForm');
			jQuery('#t_auditees').select2("container").hide();
		
		} else {
			hideBlock('userAuditeeForm');
			jQuery('#t_auditees').select2("container").show();
		}
		setNewAuditeeVisibility();
	}

	function setNewAuditeeVisibility() {
		if (jQuery('#auditeeType').val() == 't' && jQuery('#t_auditees').val() == '0') {
			jQuery('#newAuditeeForm').show();
		} else {
			jQuery('#newAuditeeForm').hide();
		}
	}
	
function changeToSelect(){
		
		var optionsObj = new Array;
		var obs = jQuery('#observers').val();
		if(obs){
	 		for(i = 0; i < obs.split(",").length; i++) {
	 			optionsObj.push($('<option selected=selected>').val(jQuery('#observers').val().split(",")[i]));
	
	 		}
	 		jQuery('#observers').replaceWith(function(){
	    		return jQuery("<select id='observers' name='exam.observers' multiple=multiple/>").append(optionsObj);
			});
		}
		
	}
	
	</script>
	
</head>
<body>
<div class="header nowrap">
<h2><fmt:message key="auditExpress.title" /></h2>
</div>
<c:set var="audit" value="${command.exam.audit}" />


<c:set var="progBa" value="${command.exam.programme.businessAreas}"/>
<scannell:form id="theForm" onsubmit="changeToSelect();">
<input type="hidden" id="userDefaultSite"/>
<scannell:hidden path="exam.id" />
<scannell:hidden path="exam.version" />

<div class="content">


	<c:if test="${audit.id != null}">
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="id" /></label>
									<div class="col-sm-6">
										<c:out value="${audit.id}"/>
									</div>
								</div>
								
	</c:if>
	<div class="form-group" style="min-height:100px;">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</label>
		<div class="col-sm-6">
      		<fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
	        <spring:bind path="command.exam.businessAreas">
	          <label>
	          <c:forEach var="ba" items="${businessAreaList}">
	            <c:set var="selected" value="${false}" />
	            <c:forEach items="${command.businessAreas}" var="selectedBA">
	              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
	            </c:forEach>
	
	            <input class="ckbBA" type="checkbox" id="businessAreas"
	                name="<c:out value="${status.expression}"/>"
	                value="<c:out value="${ba.id}" />"
	                <c:if test="${not enviromanager:contains(progBa,ba)}">disabled="disabled"</c:if>
	                <c:if test="${selected}">checked="checked"</c:if> />
	            <c:out value="${ba.name}" /><br>
	
	            <c:remove var="selected" />
	          </c:forEach>
	          </label>
	          <span class="requiredHinted">*</span>
	          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
	        </spring:bind>
		</div>
	</div>
	<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditProgramme" /></label>
			<div class="col-sm-6">
				<c:out value="${command.exam.programme.description}" />
			</div>
	</div>
	<div style="clear: both;"></div>
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="audit" /> <fmt:message key="name" /></label>
									<div class="col-sm-6">
										<scannell:textarea path="exam.name" id="auditNameText"  onclick="hideHint();" cssStyle="width:80%"  />
									</div>
	</div>
	<div style="clear: both;"></div>
	
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="leadAuditor" /></label>
									<div class="col-sm-6">
										<c:choose>
											<c:when test="${fn:length(auditors) lt 500}">
												<scannell:select id="leadAuditor" path="exam.leadAuditor" items="${auditors}" itemValue="id" itemLabel="sortableName" class="wide" emptyOptionLabel="${blankChoose}" />
											</c:when>
											<c:otherwise>
												<input type="hidden" id="leadAuditor" class="wide"  name="exam.leadAuditor" />
												<scannell:errors path="exam.leadAuditor"/> 
											</c:otherwise>
										</c:choose>	
									</div>
	</div>

	

	
	
	<c:if test="${command.exam.programme.type.saveAndReview}">
	
	    <div class="form-group">
	    	<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditeeType" />:</label>
	    <div class="col-sm-6">
							<scannell:select id="auditeeType" path="auditeeType" onchange="onAuditeeTypeChange();" renderEmptyOption="false">
									<scannell:option value="u" labelkey="auditeeType[u]" />
									<scannell:option value="t" labelkey="auditeeType[t]" />
								</scannell:select>
						</div>
						</div>

	<div>
	    <div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditee" /></label>
		
			 <div class="col-sm-9" style="float: right;">
				<div id="userAuditeeForm" <c:if test="${command.auditeeType != 'u'}"> style="display: none;"</c:if>>
										<table class="table table-responsive table-bordered" id="userAuditeeFormTable">
											<tbody>
												<tr>
													<th style="width:50%"><fmt:message key="employee" /></th>
													<td>
														<c:choose>
															<c:when test="${fn:length(userAuditees) lt 500}">
																<scannell:select id="user" path="auditeeUser" items="${userAuditees}" itemValue="id" itemLabel="sortableName" class="wide" /> <scannell:errors path="userAuditee.user" />
															</c:when>
															<c:otherwise>
																<input type="hidden" id="user" class="wide"  name="auditeeUser"/>
																<scannell:errors path="userAuditee.user"/>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
												<tr>
													<th><fmt:message key="department" /></th>
													<td><scannell:select id="department" path="auditeeDepartment" items="${departments}" itemValue="id" itemLabel="name" class="wide" /> <scannell:errors path="userAuditee.department" /></td>
												</tr>
												<tr>
													<th><fmt:message key="workArea" /></th>
													<td><scannell:select id="workarea" path="auditeeWorkArea" items="${workareas}" itemValue="id" itemLabel="name" class="wide" /> <scannell:errors path="userAuditee.workArea" /></td>
												</tr>
												<tr>
													<th><fmt:message key="deptLocation" /></th>
													<td><scannell:select id="location" path="auditeeLocation" items="${locations}" itemValue="id" itemLabel="name" class="wide" /> <scannell:errors path="userAuditee.location" /></td>
												</tr>
											</tbody>
										</table>
			 	 </div> 
			 	 <c:if test="${command.canCreateThirdParty}">
									<c:set var="emptyOptionLabel" value="thirdPartyCreate" />
									<c:set var="onChangeAction" value="setNewAuditeeVisibility()" />
								</c:if> 
								<scannell:select id="t_auditees" path="thirdPartyAuditee.id" items="${thirdPartyAuditees}" itemValue="id" itemLabel="description" visible="${command.auditeeType == 't'}"
									onchange="${onChangeAction}" emptyOptionValue="0" emptyOptionLabel="${emptyOptionLabel}" class="wide" /> <scannell:errors path="thirdPartyAuditee" class="errorMessage" /> <scannell:errors
									path="exam.auditee" class="errorMessage" writeRequiredHint="false" /> <scannell:errors path="userAuditee" class="errorMessage" />

								<div id="newAuditeeForm"  style="display: none; margin-top: 10px;">
									<table id="newAuditeeForm" class="table table-bordered table-responsive" >
										<c:if test="${command.canCreateThirdParty}">
											<tbody>
												<tr>
													<th><fmt:message key="name" /></th>
													<td><input name="thirdPartyAuditee.name" cssStyle="float:left;width:90%" class="higher form-control" /></td>
												</tr>
												<tr>
													<th><fmt:message key="company" /></th>
													<td><input name="thirdPartyAuditee.company" cssStyle="float:left;width:90%" class="higher form-control" /></td>
												</tr>
												<tr>
													<th><fmt:message key="address" /></th>
													<td><input name="thirdPartyAuditee.address" cssStyle="float:left;width:90%" class="higher form-control" /></td>
												</tr>
												<tr>
													<th><fmt:message key="phoneNumber" /></th>
													<td><input name="thirdPartyAuditee.phoneNumber" cssStyle="float:left;width:90%"  class="higher form-control" /></td>
												</tr>
												<tr>
													<th><fmt:message key="emailAddress" /></th>
													<td><input name="thirdPartyAuditee.emailAddress" cssStyle="float:left;width:90%" class="higher form-control" /></td>
												</tr>
											</tbody>
										</c:if>
									</table>
								</div>
		   </div>
		 </div>
	</div>

</c:if>

	<div style="clear: both;"></div>
		<!-- START: Person Observed -->
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="audit.personObserved"/></label>
			<div class="col-sm-6">
				<c:choose>
				
					<c:when test="${fn:length(allUsers) lt 500}">
						<scannell:select id="observers" path="exam.observers" items="${allUsers}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
							cssStyle="width:50%" renderEmptyOption="false" />
					</c:when>
					<c:otherwise>
						<input type="hidden" id="observers" style="width:100% !important;"  multiple="multiple" name="exam.observers" />
					</c:otherwise>
				</c:choose>
			</div>
	   </div>
	<div style="clear: both;"></div>
	<!-- END: Person Observed -->
	
	<fmt:message key="incident.enableAdditionalFields" var="enable" />
	<c:if test="${!enable}">
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditDepartment" /></label>
									<div class="col-sm-6">
										<scannell:select id="department2" path="exam.department" items="${auditdepartments}" itemValue="id" itemLabel="name" cssStyle="width:100%"  />
									</div>
	</div>	
	</c:if>
	
	<c:if test="${enable}">
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="deptLocation" /></label>
									<div class="col-sm-6">
										<scannell:select id="location2" path="exam.location" items="${auditlocations}" itemValue="id" itemLabel="name" cssStyle="width:100%"   />
									</div>
	</div>	
	</c:if>						
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="otherParticipants" /></label>
									<div class="col-sm-6" id="otherParticipants">
									<input name="exam.otherParticipants" cssStyle="width:100%"  class="form-control" />
									</div>
	</div>
	<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startTime" /></label>
									
									<div class="col-sm-6">
									<div class="form-inline">
									    <div class="col-sm-5">
										<div class="input-group date datetime col-md-12 col-xs-12 col-sm-12" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										<scannell:input class="form-control" path="startDateTime.date" id="startDate" readonly="true"  />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
                                        </div>
                                        <div class="col-sm-5">
                                        <scannell:select id="hour" path="startDateTime.hour" items="${hours}" cssStyle="float:left" numberFormat="00" />
			                            <scannell:select id="min" path="startDateTime.minute" items="${minutes}" cssStyle="float:left" numberFormat="00" />
			                            </div>
                                       </div>
									</div>															
							</div>	
	 <div style="clear: both;"></div>

	
    <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" /></label>
									<div class="col-sm-6" id="additionalInfo">
									<scannell:textarea path="exam.additionalInfo" id="additionalInfo" cssStyle="width:100%" class="form-control" />
									</div>
	</div>
	<div style="clear: both;"></div>	
    <div class="form-group">
            <c:choose>
			<c:when test="${audit.createdByUser != null}">	
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="auditCreatedBy" /></label>
				<div class="col-sm-6" id="additionalInfo">
				<c:out value="${audit.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />									
				</div>
			</c:when>
	     <c:otherwise>
		<!-- <td>&nbsp;</td>
		<td>&nbsp;</td> -->
	</c:otherwise>
	</c:choose>		
	</div>
	<div class="form-group">
            <c:choose>
			<c:when test="${audit.lastUpdatedByUser != null}">	
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" /></label>
				<div class="col-sm-6" id="auditLastUpdatedBy">
				<c:out value="${audit.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${audit.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />									
				</div>
			</c:when>
	     <c:otherwise>		
	</c:otherwise>
	</c:choose>		
	</div>
</div>

 <div style="clear: both;"></div>
<div class="header nowrap">
<h2 ${showQuestionsExpress == null ? "":"style=\"display:none\""}><fmt:message key="questions.title" /></h2>
</div>    
	<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive"  >

<c:if test="${showQuestionsExpress == null || empty showQuestionsExpress}">
<tbody>
	
			<c:set var="group" value="${command.exam.programme.type.expressQuestionGroup}" />
			<c:if test="${group.active}">
				<c:if test="${group.name != null && group.name!= ''}">
				<tr><td colspan="2" class="scoringCategoryTitle" ><c:out value="${group.name}"/><c:if test="${group.name == 'Express Audit Type – Behavioural Based Safety'}">(GB = good behaviour, IB = improve behaviour)</c:if> </td></tr>
				</c:if>
				<c:set var="newIndex" value="0" />
				<c:set var="closeRowForLabel" value="0" />
				<c:forEach items="${group.questions}" var="q" varStatus="s">
					<c:set var="closeRow" value="false" />
					<c:if test="${s.first || (closeRowForLabel mod 2 == 0) && q.answerType.name != 'label'}"><tr></c:if>
					<c:if test="${q.active and q.visible}">
						<c:choose>
							<c:when test="${q.answerType.name == 'label'}">
							<c:if test="${closeRowForLabel % 2 == 1}"><td style="vertical-align: top; width:50%"></td></tr></c:if><c:set var="closeRowForLabel" value="0" />
								<tr>
								<td colspan="2" class="scoringCategoryTitle" style="text-align:left;font-weight: bold;font-size:16pt;">
									<c:out value="${q.name}" />
								</td></tr>
							</c:when>
							<c:otherwise>
								<c:set var="closeRowForLabel" value="${closeRowForLabel + 1 }" />
								<td style="vertical-align: top; width:50%"><input class="object-id" value="${q.id}" type="hidden">
									<c:if test="${q.name != ''}"><div style="min-height:30px;"><b><c:out value="${q.name}" />:</b></div></c:if>
									<enviromanager:question path="exam.answers" question="${q}" emptyOptionLabel="Choose" multiselectCheckboxes="false" />
									<img alt="<c:out value="${q.name}" />" id="img-${q.id}" src="#" style="display:none">
								</td>
								<c:set var="closeRow" value="${true}" />
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${(s.last) || (closeRowForLabel mod 2 == 0) && q.answerType.name != 'label'}"></tr></c:if>
					<c:set var="newIndex" value="${closeRow ? (newIndex + 1) : newIndex }" />
				</c:forEach>
			</c:if>
		
	
</tbody>

<tbody>
	<c:if test="${command.exam.programme.type.saveAndReview}">
		<tr>
			<td colspan="2" align="center" class="longLabel"><fmt:message key="reviewMessage" /></td>
		</tr>
	</c:if>
</tbody>
</c:if>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<c:choose>
				<c:when test="${managementProgramme.id gt 0}"><c:url var="cancelURL" value="/audit/expressView.htm"><c:param name="id" value="${audit.id}"/></c:url></c:when>
				<c:otherwise><c:url var="cancelURL" value="/audit/programmeView.htm"><c:param name="id" value="${command.exam.programme.id}"/></c:url></c:otherwise>
			</c:choose>		
			<input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'">
				
			<INPUT TYPE="HIDDEN" NAME="showQuestionsExpress" VALUE="${showQuestionsExpress }">	
			<INPUT TYPE="HIDDEN" NAME="Review" VALUE="false">
			
			<c:if test="${command.exam.programme.type.saveAndReview && showQuestionsExpress == null}">
				<input type="submit" class="g-btn g-btn--primary" onclick="request();" value="<fmt:message key="savereview" />">
			</c:if>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>

</scannell:form>

</body>
</html>