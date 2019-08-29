<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<title>	
		<c:choose>
			<c:when test="${empty command.name}"><fmt:message key="docControl.addDocument" /></c:when>
			<c:otherwise><fmt:message key="docControl.editDocument" /></c:otherwise>
		</c:choose>
	</title>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/doccontrol/documentEdit.js" />"></script>
	
	<script type="text/javascript">
		var docGroupCount = ${fn:length(docGroups)};
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var warningDistribute = '<fmt:message key="doccontrol.edit.distributeWarning"/>'
		var showWarning = false;
		var distributed = ('${command.status}' == 'DocumentStatus[DISTRIBUTED]');
		
		jQuery(document).ready(function() {
			urlFile();
			jQuery('#createDocGroup').appendTo("body");	
        	jQuery('#createDocGroup').modal('hide');
        	//User must choose Doc group to populate user lists
        	jQuery("#docGroup").change(function() {
        		 showHideDocGroupWarning();
     			  setUpApprovers();
    			  setUpReviewers();
    			  setUpTraineeUsers();
	       	 });
        	showHideDocGroupWarning();
        	
        	//If no doc groups exists inform the user to create one
        	if(docGroupCount == 0) {
            	jQuery('#createDocGroup').modal('show');
        	}
        	
        	//Prevent forms submitting more than once
			jQuery("form").submit(function() {
				// submit more than once return false
				jQuery(this).submit(function() {
					return false;
				});
				// submit once return true
				return true;
			});
        	
        	//Generate list of 1-100 for version numbers
			var select = '';
			for (i=1;i<=100;i++){
			    select += '<option val=' + i + '>' + i + '</option>';
			}
			
			//If document is approved already request future info
			hideBlock('approvedUser');
			hideBlock('approvedComment');
			hideBlock('approvedDate');
			onStatusChange();
			
			//Create a popluate users lists
			setUpListElements();
			
			//Monitor ack User changes if document has already been distributed
			jQuery(".ack").change(function(){
				if(distributed) {
					showWarning = true;
				}
			});
			jQuery("#editDoc").submit(function(){
				if(showWarning) {
					  alert(warningDistribute);
				}
			});
		});
		
		function checkVersion() {
			if (jQuery('#approvedVer').val() == '0' && 
					jQuery('#draftVer').val() == '0') {
				alert("<fmt:message key='doccontrol.invalidVersion'/>");
				return false;
			}
			else if ((jQuery('#status').val() == 'DRAFT' || jQuery('#status').val() == 'REVIEW')
					&& jQuery('#draftVer').val() == '0') {
				alert("<fmt:message key='doccontrol.invalidDraftVersion'/>");
				return false;
			}
			return true;
		}
		
		function setUpListElements() {
			<c:if test="${command.id == 0}">
				jQuery('#docGroup').select2({width:'90%'});
			</c:if>
			jQuery('#departments').select2({width:'90%'});
			jQuery('#status').select2({width:'90%'});
			jQuery('#trainneeGroup').select2({width:'90%'});
			jQuery('#trainneeSite').select2({width:'90%'});
			jQuery('#trainneeDepartment').select2({width:'90%'});
			jQuery('#approvedVer').select2({width:'90%'});
			jQuery('#draftVer').select2({width:'90%'});
			
			
			setUpApprovers();
			setUpReviewers();
			setUpTraineeUsers();
		}
			
		function setUpApprovers() {
			if ("${command.approvedByUser}") {
				var approvedByUser = '<c:out value="${command.approvedByUser.id}"/>';
				if(approvedByUser != null){
					jQuery('#approvedByUser').val(approvedByUser);
				}
			}
			
			if("${!empty approvers}" == "true")
			{
				jQuery('#approvedByUser').select2({width:'90%'});
			}
			else 
			{
				jQuery('#approvedByUser').select2({				  
					  width:'90%',
					  minimumInputLength : 3,
					  placeholder :  enterChars,
					  escapeMarkup: function(m) {
					        // Do not escape HTML in the select options text
					        return m;
					     },
					  ajax: {
					        url: "approverList.json",
					        dataType: 'json',
					        type: "GET",
					        quietMillis: 100,
					        data: function (term) {
					            return {
					            	term: term, docGroup : jQuery('#docGroup').val()
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
					    	if ("${command.approvedByUser}") {
					    		var data = {id: '<c:out value="${command.approvedByUser.id}"/>', text: '<c:out value="${command.approvedByUser.sortableName}"/>'};
					    		callback(data);
					    	}
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
			}
		
		function setUpReviewers() {			
			if("${!empty reviewers}" == "true")
			{
				jQuery('#reviewers').select2({width:'90%'});
			}
			else 
			{
				var data = [];
				if("${command.reviewers}" != "") {
					<c:forEach items="${command.reviewers}" var="sa">
						jQuery('#reviewers').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
				    	jQuery('#reviewers').val('<c:out value="${sa.id}"/>');
				    	jQuery('#reviewers option[value="${sa.id}"]').attr("selected","selected");
				    	data.push('${sa.id}');
					</c:forEach>
				}
				
				jQuery('#reviewers').select2('val', data);
				jQuery('#reviewers').select2({				  
				  width:'90%',
				  minimumInputLength : 3,
				  placeholder :  enterChars,
				  escapeMarkup: function(m) {
				        // Do not escape HTML in the select options text
				        return m;
				     },
				  ajax: {
				        url: "reviewerList.json",
				        dataType: 'json',
				        type: "GET",
				        quietMillis: 100,
				        data: function (term) {
				            return {
				                term: term, docGroup : jQuery('#docGroup').val()
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
						<c:forEach items="${command.reviewers}" var="sa">
							data.push({id: '<c:out value="${sa.id}"/>', text: '<c:out value="${sa.sortableName}"/>'});
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
		}
		
		function setUpTraineeUsers() {
			if("${!empty users}" == "true")
			{
				jQuery('#trainneeUser').select2({width:'90%'});
			}
			else 
			{
				var data = [];
				if("${command.trainees.audUsers}" != "[]") {
					<c:forEach items="${command.trainees.audUsers}" var="sa">
						jQuery('#trainneeUser').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
				    	jQuery('#trainneeUser').val('<c:out value="${sa.id}"/>');
				    	jQuery('#trainneeUser option[value="${sa.id}"]').attr("selected","selected");
				    	data.push('${sa.id}');
					</c:forEach>
				}
				
				jQuery('#trainneeUser').select2('val', data);
				
				jQuery('#trainneeUser').select2({				  
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
				                term: term, docGroup : jQuery('#docGroup').val()
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
						<c:forEach items="${command.trainees.audUsers}" var="sa">
					    	data.push({id: '<c:out value="${sa.id}"/>', text: '<c:out value="${sa.sortableName}"/>'});
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
		}
		
		function changeFile() {
			var content = jQuery('#content').val();
			var name= getName(content);
			jQuery('#filename').val(name);
			jQuery("#file-info").html(name);
			checkFileSize();

		}
		
		function checkFileSize(){
			var configuredSize = '${maxAttchmentSizeMb}';
			var configuredSizeNum = parseFloat(configuredSize);
		    if(window.ActiveXObject){
		        var fso = new ActiveXObject("Scripting.FileSystemObject");
		        var filepath = document.getElementById('content').value;
		        var thefile = fso.getFile(filepath);
		        var sizeinbytes = thefile.size;
		    }else{
		        var sizeinbytes = document.getElementById('content').files[0].size;
		    }
		    var sizeinMb = sizeinbytes/(1024*1024);
			 if(sizeinMb>=configuredSizeNum){
			 jQuery("#warningSizeDiv").show();
			 jQuery("#content").val('');
			 jQuery("#filename").val('');
			 jQuery("#file-info").html('');
			 }else{
				 jQuery("#warningSizeDiv").hide();
			 }
		    
		}
		
	</script>
	

	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
		.mandatory-file {
			display: inline;
		}
		.float-right{
			text-align:right;
			margin-right:20px;
		}
		
		.btn-file {
		    position: relative;
		    overflow: hidden;
		}
		.btn-file input[type=file] {
		    position: absolute;
		    top: 0;
		    right: 0;
		    min-width: 100%;
		    min-height: 100%;
		    font-size: 100px;
		    text-align: right;
		    filter: alpha(opacity=0);
		    opacity: 0;
		    outline: none;
		    background: white;
		    cursor: inherit;
		    display: block;
		}
		input.higher {
			line-height: 26px;
			width: 80%;
		}
		.selectDocGroup {
			color:red; 
			display:block;
			margin-left: auto;
			margin-right: auto;
			text-align:  center;
		}
	</style>
</head>
<body>
	<scannell:form id="editDoc" enctype="multipart/form-data">
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<input type="hidden" id="docGroupChange" name="docGroupChange" value="" />
		
		<input type="hidden" id="userDefaultSite"/>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="doccontrol.docGroup.label" />:
			</label>
			<div class="col-sm-6">
				<c:choose>
					<c:when test="${command.id != 0 && command.docGroup != null}">
						<label class="col-sm-6 control-label scannellGeneralLabel nowrapl"  style="text-align: left;">
							<c:out value="${command.docGroup.name}" />	
						</label>
						<input type="hidden" id="docGroup" name="docGroup" value="${command.docGroup.id}" />
					</c:when>
					<c:when test="${command.id == 0 && command.docGroup != null}">
						<select name="docGroup" id="docGroup" renderEmptyOption="false" cssStyle="width:90%" items="${docGroups}" itemLabel="displayName" itemValue="id" />
					</c:when>
					<c:otherwise>
						<select name="docGroup" id="docGroup" renderEmptyOption="true" cssStyle="width:90%" items="${docGroups}" itemLabel="displayName" itemValue="id" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="businessAreas" />:
			</label>
			<div class="col-sm-6" >
		      		<fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
			        <spring:bind path="command.businessAreas">
			          <label  style="text-align: left;">
			          <c:forEach var="ba" items="${businessAreaList}">
			            <c:set var="selected" value="${false}" />
			            <c:forEach items="${command.businessAreas}" var="selectedBA">
			              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
			            </c:forEach>
			
			            <input class="ckbBA" type="checkbox" id="businessAreas"
			                name="<c:out value="${status.expression}"/>"
			                value="<c:out value="${ba.id}" />"
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
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="name" />:
			</label>
			<div class="col-sm-6">
				<input name="name" cssStyle="float:left;width:90%" class="form-control" />
			</div>
		</div>
			
		<div style="clear: both;"></div>		
		<div class="form-group" style="min-height:110px;">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="description" />:
			</label>
			<div class="col-sm-6">
				<scannell:textarea path="description" cols="75" rows="3" class="form-control wide textarea" cssStyle="float:left;width:90%"/>
			</div>
		</div>
		<div style="clear: both;"></div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="department" />:
			</label>
			<div class="col-sm-6" style="display:inline">
				<select name="departments" id="departments" renderEmptyOption="true" multiple="true" cssStyle="width:100%" items="${departments}" itemLabel="name" itemValue="id" />
			</div>
		</div>
		
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="doccontrol.reviewer.label" />:
			</label>
			<div class="col-sm-6">
				<c:choose>
					<c:when test="${!empty reviewers}">
						<scannell:select id="reviewers" path="reviewers" items="${reviewers}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
							cssStyle="width:50%" renderEmptyOption="false" />
					</c:when>
					<c:otherwise>
						<input type="hidden" id="reviewers" style="width:100%;" multiple="multiple" name="reviewers"/>
						<scannell:errors path="reviewers"/>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-sm-9 selectDocGroup">
				<fmt:message key="doccontrol.chooseDocGroup"/>	
			</div>
		</div>

		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="doccontrol.approver.label" />:
			</label>
			<div class="col-sm-6">
				<c:choose>
					<c:when test="${!empty approvers}">
						<scannell:select id="approvedByUser" path="approvedByUser" items="${approvers}" itemValue="id" multiple="false" itemLabel="displayNameWithDepartment" size="20"
							cssStyle="width:50%" renderEmptyOption="false" />
					</c:when>
					<c:otherwise>
						<input type="hidden" id="approvedByUser" class="wide"  name="approvedByUser" />
						<scannell:errors path="approvedByUser"/>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-sm-9 selectDocGroup">
				<fmt:message key="doccontrol.chooseDocGroup"/>	
			</div>
		</div>	
			<%-- <div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="docControl.document.retention" />:
				</label>
				<div class="col-sm-6">
					<select name="retentionPeriod" id="retentionPeriod" lookupItemLabel="true" renderEmptyOption="true" items="${retentions}" itemLabel="label" itemValue="name" />
				</div>
			</div> --%>
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="doccontrol.trainee.user" />:
				</label>
				<div class="col-sm-6">
					<c:choose>
						<c:when test="${!empty users}">
							<scannell:select id="trainneeUser" class="ack" path="trainees.audUsers" items="${users}" itemValue="id" multiple="true" itemLabel="displayName" size="20"
								cssStyle="width:90%" renderEmptyOption="false" />
						</c:when>
						<c:otherwise>
							<input type="hidden" id="trainneeUser" class="ack" style="width:100%;" multiple="multiple" name="trainees.audUsers"/>
							<scannell:errors path="trainees.audUsers"/>
						</c:otherwise>
					</c:choose>					
				</div>
				<div class="col-sm-9 selectDocGroup">
					<fmt:message key="doccontrol.chooseDocGroup"/>	
				</div>	
			</div>	
			<div style="clear: both;"></div>	
			<c:if test="${!empty departments}">	
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
						<fmt:message key="doccontrol.trainee.dept" />:
					</label>
					<div class="col-sm-6">
						<scannell:select id="trainneeDepartment" class="ack" path="trainees.audDepts" items="${departments}" itemValue="id" multiple="true" itemLabel="name" size="20"
									cssStyle="width:90%" renderEmptyOption="false" />
					</div>
				</div>	
			</c:if>
			<c:if test="${!empty groups}">	
				<div style="clear: both;"></div>	
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
						<fmt:message key="doccontrol.trainee.group" />:
					</label>
					<div class="col-sm-6">
						<scannell:select id="trainneeGroup" path="trainees.audGroups" items="${groups}" itemValue="id" multiple="true" itemLabel="name" size="20"
							cssStyle="width:50%" class="ack"  renderEmptyOption="false" />
					</div>
				</div>
			</c:if>		
			<div style="clear: both;"></div>	
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="doccontrol.trainee.site" />:
				</label>
				<div class="col-sm-6">
					<scannell:select id="trainneeSite" path="trainees.audSites" items="${sites}" itemValue="id" multiple="true" itemLabel="name" size="20"
						cssStyle="width:50%" class="ack" renderEmptyOption="false" />
				</div>
			</div>

		<c:if test="${command.id == 0}">
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="status" />:
				</label>
				<div class="col-sm-6">
					<select name="status" id="status" lookupItemLabel="true" renderEmptyOption="true" onchange="onStatusChange();" cssStyle="width:90%" items="${statusList}" itemValue="name" />
				</div>
			</div>
			<div class="form-group" id="approvedComment" style="min-height:110px;">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="changeAssessment.approvedComment" />:
				</label>
				<div class="col-sm-6">
					<scannell:textarea path="approvalComment" cols="75" rows="3" />
				</div>
			</div>
			<div style="clear: both;"></div>
			<div class="form-group" id="approvedDate">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="approvedDate" />:
				</label>
				<div class="col-sm-6">
					<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
						<scannell:input class="form-control" path="approvedDate" id="approvedDate" readonly="true" cssStyle="size:16;" />
						<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="doccontrol.approveVersion.label" />:
				</label>
				<div class="col-sm-3">
					<select name="approvedVer" id="approvedVer" renderEmptyOption="false" cssStyle="width:80%" items="${versions}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
					<fmt:message key="doccontrol.draftVersion.label" />:
				</label>
				<div class="col-sm-3">
					<select name="draftVer" id="draftVer" renderEmptyOption="false" cssStyle="width:80%"  items="${versions}"/>
				</div>
			</div>
	
			<div class="form-group " id="contentRow" style="min-height:110px;">
				<label class="col-sm-3 control-label scannellGeneralLabel rightAlign"><fmt:message key="content" /></label>
				<div class="col-sm-6">
					<span class="g-btn g-btn--primary btn-file"><fmt:message key="browseButton" />
					<input type="file" id="content" name="content" onchange='changeFile()'/></span>
					<span class='label label-info' id="file-info"></span>
					<scannell:hidden id="filename" path="filename" />
					<div class="mandatory-file" id="mandatoryFile">
						<span class="requiredHinted">*</span>
					</div>
				</div>
			</div>
		</c:if>
		
		<div style="clear: both;"></div>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />" onclick="return checkVersion()"/>
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>
		
		<div class="spacer2 alert alert-danger" id="warningSizeDiv" style="display:none">
			<strong><fmt:message key="warning" /></strong>&nbsp;<fmt:message key="attachment.max.size.configured"/>&nbsp;${requestScope.maxAttchmentSizeMb}&nbsp;Mb
	 	</div>
	 	
	</scannell:form>
	<!-- Modal -->
	<div id="createDocGroup" class="modal fade" role="dialog"
		data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header" style="border-bottom: 2px solid #0084b4;">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
					<h5 class="modal-title"><fmt:message key="doccontrol.noDocGroup"/></h5>
				</div>
				<div class="modal-body">
					<div class="col-lg-12">
						<fmt:message key="doccontrol.noDocGroup.message"/>
					</div>
					<div class="row">
						<div class="col-lg-3 col-centered"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="openProfile" class="g-btn g-btn--primary"
						data-dismiss="modal" onclick="window.location='<c:url value="/doccontrol/docGroupEdit.htm"/>'">
						<fmt:message key="doccontrol.noDocGroup.action"/>
					</button>
				</div>
			</div>
	
		</div>
	</div>

</body>
</html>
