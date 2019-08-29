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
	
	<script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
		
		jQuery(document).ready(function() {
			jQuery("form").submit(function() {
				// submit more than once return false
				jQuery(this).submit(function() {
					return false;
				});
				// submit once return true
				return true;
			});
			jQuery('#file-info').html(jQuery('#filename').val());

			//Create a popluate users lists
			setUpApprovers();
			setUpReviewers();
		});

		

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
		
		function changeFile() {
			var content = jQuery('#content').val();
			var name= getName(content);
			jQuery('#filename').val(name);
			jQuery("#file-info").html(name);

		}
		function getName(s){
			var arr=s.split('\\');
			var name= arr[(arr.length-1)];
			return name;
		}
		
	</script>
	
	
	<title>	
		<fmt:message key="docControl.addRevision" />
	</title>
</head>
<body>
<div class="content">
	<scannell:form enctype="multipart/form-data">
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<input type="hidden" id="docGroup" name="docGroup" value="${command.document.docGroup.id}" />
		<input type="hidden" id="userDefaultSite"/>
		
					
		<div class="form-group" style="min-height:110px;">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="reason" />:
			</label>
			<div class="col-sm-6" style="min-height:110px;" >
				<scannell:textarea path="reason" cols="75" rows="3" class="form-control wide textarea" cssStyle="float:left;width:95%"/>
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
		</div>
		
		<div style="clear: both;"></div>	
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="doccontrol.previousVersion" />:
			</label>
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl"  style="text-align: left;">
				<c:out value="${command.approvedVer}" />.<c:out value="${command.draftVer-1}" />
			</label>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl rightAlign">
				<fmt:message key="doccontrol.updatedVersion" />:
			</label>
			<label class="col-sm-3 control-label scannellGeneralLabel nowrapl" style="text-align: left;">
				<c:out value="${command.approvedVer}" />.<c:out value="${command.draftVer}" />
			</label>
		</div>

		<div class="form-group " id="contentRow" style="min-height:110px;">
			<label class="col-sm-3 control-label scannellGeneralLabel rightAlign"><fmt:message key="content" /></label>
			<div class="col-sm-6">
				<span class="g-btn g-btn--primary btn-file"><fmt:message key="browseButton" />
				<input type="file" id="content" onchange='changeFile()' name="content"></span>
				<scannell:hidden id="filename" path="filename" />
				<span class='label label-info' id="file-info"></span>
				<div class="mandatory-file" id="mandatoryFile">
					<span class="requiredHinted">*</span>
					<c:out value="${content.required}" />
				</div>
			</div>
		</div>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>
	</scannell:form>
</div>
</body>
</html>
