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
<c:set var="title" value="auditEdit" />
<c:if test="${command.exam.audit == null}">
	<c:set var="title" value="auditCreate" />
</c:if>
<title><fmt:message key="${title}" /></title>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>

<script type="text/javascript">
	var enterChars = '<fmt:message key="select2.enterChars"/>';
	var auditorCount = ${fn:length(auditors)};
	var auditeeCount = ${fn:length(userAuditees)};
	var userCount = ${fn:length(allUsers)};
	var maxListSize = 500;
		
	function defaultEscapeMarkup(markup) {
        var replace_map = {
            '\\': '&#92;',
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#39;',
            "/": '&#47;'
        };

        return String(markup).replace(/[&<>"'\/\\]/g, function (match) {
            return replace_map[match];
        });
    }
	jQuery(document).ready(function() {
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
		//jQuery('#leadAuditor').select2({width:'60%'});
		jQuery('#auditeeType').select2({width:'40%'});
		jQuery('#department').select2({width:'60%'});
		jQuery('#workarea').select2({width:'60%'});
		jQuery('#location').select2({width:'60%'});
		jQuery('#template').select2({width:'40%'});
		jQuery('#startDateTime').select2({width:'10%'});
		jQuery('#startDateTimehour').select2({width:'10%'});
		jQuery('#durationAmount').select2({width:'20%'});
		jQuery('#t_auditees').select2({width:'40%'});

		if("${command.exam.audit == null || command.exam.audit.completedQuestionsCount == 0}" == "true") {
			var currentName = jQuery("#template :selected").text();
			var auditTemplateName = '${command.exam.audit.templateName}';
			var value = jQuery("#template :selected").val();
			jQuery('#template option:contains("'+currentName+'")').text(auditTemplateName);
	    	jQuery('#template').val(value);
		}
		//jQuery('#secondaryAuditors').select2({width:'60%'});
		
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
		
		var userSelectedDetails=[];
		userSelectedDetails.userId="${command.auditeeUser.id}";
		userSelectedDetails.department="${command.auditeeDepartment.id}";
		userSelectedDetails.workArea="${command.auditeeWorkArea.id}";
		userSelectedDetails.location="${command.auditeeLocation.id}";
		if('${command.auditeeUser.id}'.length>0){
			userSelectedDetails.newDepartment=usersToDepartment[parseInt('${command.auditeeUser.id}')];
			}
		setDepartmentforUser(userSelectedDetails);
			
		setNewAuditeeVisibility();
		
		
		var leadAuditor = '<c:out value="${command.exam.leadAuditor.id}"/>';
		if(leadAuditor != null){
			jQuery('#leadAuditor').val(leadAuditor);
		}
		if(auditorCount < maxListSize)
		{
			jQuery('#leadAuditor').select2({width:'60%'});
		}
		else 
		{
			jQuery('#leadAuditor').select2({				  
			  width:'60%',
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
		
		if(auditorCount < maxListSize)
		{
			jQuery('#secondaryAuditors').select2({width:'60%'});
		}
		else 
		{
			var data = [];
			<c:forEach items="${command.exam.secondaryAuditors}" var="sa">
		    	jQuery('#secondaryAuditors').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
		    	jQuery('#secondaryAuditors').val('<c:out value="${sa.id}"/>');
		    	jQuery('#secondaryAuditors option[value="${sa.id}"]').attr("selected","selected");
		    	data.push('${sa.id}');
			</c:forEach>
			
			jQuery('#secondaryAuditors').select2('val', data);
			
			jQuery('#secondaryAuditors').select2({				  
			  width:'60%',
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
					var data = [];
					<c:forEach items="${command.exam.secondaryAuditors}" var="sa">
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
	   var responsibleUser= '<c:out value="${command.auditeeUser.id}"/>';
		if(responsibleUser != null){
			jQuery('#user').val(responsibleUser);
		}
		if(auditeeCount < maxListSize)
		{
			jQuery('#user').select2({width:'60%'});
		}
		else 
		{
		   jQuery('#user').select2({				  
				  width:'60%',
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
				    	var data = {id: "<c:out value="${command.auditeeUser.id}"/>", text: "<c:out value="${command.auditeeUser.sortableName}"/>"};
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
	   
			if(userCount < maxListSize)
			{
				jQuery('#observers').select2({width:'60%'});
			}
			else 
			{
				var d = "<c:out value="${command.exam.observers}"/>";
				var data = [];
				<c:forEach items="${command.exam.observers}" var="a">
			    	jQuery('#observers').append("<option value='${a.id}' >${a.displayNameWithDepartment}</option>") 
			    	jQuery('#observers').val('<c:out value="${a.id}"/>');
			    	jQuery('#observers option[value="${a.id}"]').attr("selected","selected");
			    	data.push('${a.id}');
				</c:forEach>
				jQuery('#observers').select2('val', data);
				
				jQuery('#observers').select2({
				  width:'60%',
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
	});
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
	
	</script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

input.higher {
	line-height: 26px;
	width: 80%;
}
</style>
</head>
<body>
	<!-- <div class="header"> -->
	<%-- <h2><fmt:message key="${title}" /></h2> --%>
	<!-- </div> -->
	
<c:set var="progBa" value="${command.exam.programme.businessAreas}"/>
	<scannell:form >
		<input type="hidden" id="userDefaultSite"/>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">
					<tbody>
						<fmt:message var="blankChoose" key="blankChoose" />
						<tr class="form-group">
							<td class="searchLabel" style="width:30%"><fmt:message key="auditProgramme" />:</td>
							<td class="search"><c:out value="${command.exam.programme.description}" /></td>
						</tr>
						
						<tr class="form-group">
					    	<td class="searchLabel"><fmt:message key="businessAreas" />:</td>
					    	<td class="search">
					      		<fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
						        <spring:bind path="command.businessAreas">
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
					    	</td>
					  	</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="name" />:</td>
							<td class="search"><input name="exam.name" cssStyle="float:left;width:40%" class="form-control" /></td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="leadAuditor" />:</td>
							<td class="search">
								<c:choose>
									<c:when test="${fn:length(auditors) lt 500}">
										<scannell:select id="leadAuditor" path="exam.leadAuditor" items="${auditors}" itemValue="id" itemLabel="sortableName" class="wide" emptyOptionLabel="${blankChoose}" />
									</c:when>
									<c:otherwise>
										<input type="hidden" id="leadAuditor" class="wide"  name="exam.leadAuditor" />
									<scannell:errors path="exam.leadAuditor"/> 
									</c:otherwise>
								</c:choose>
							</td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="auditeeType" />:</td>
							<td class="search"><scannell:select id="auditeeType" path="auditeeType" onchange="onAuditeeTypeChange();" renderEmptyOption="false">
									<scannell:option value="u" labelkey="auditeeType[u]" />
									<scannell:option value="t" labelkey="auditeeType[t]" />
								</scannell:select></td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="auditee" />:</td>
							<td class="search">
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
							</td>
						</tr>

						<!-- START: Person Observed -->
						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="audit.personObserved" />:</td>
							<td class="search" colspan="3">
								<c:choose>
									<c:when test="${fn:length(allUsers) lt 500}">
										<scannell:select id="observers" path="exam.observers" items="${allUsers}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
											cssStyle="width:50%" renderEmptyOption="false" />
									</c:when>
									<c:otherwise>
										<input type="hidden" id="observers" style="width:100%;" multiple="multiple" name="exam.observers"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<!-- END: Person Observed -->

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
							<td class="search"><scannell:textarea path="exam.additionalInfo" class="form-control" cssStyle="float:left;width:50%" /></td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="template" />:</td>
							<td class="search"><c:choose>
									<c:when test="${command.exam.audit == null || command.exam.audit.completedQuestionsCount == 0}">
										<select name="exam.template" items="${templates}" id="template" itemValue="id" itemLabel="name" emptyOptionLabel="${blankChoose}" />
									</c:when>
									<c:otherwise>
										<c:out value="${command.exam.template.name}" />
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="startTime" />:</td>
							<td class="search">
								<div id="cal" style="width: 250px;">
									<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
										<scannell:input class="form-control" path="startDateTime.date" id="startDate" readonly="true" cssStyle="float:left;" />
										<span class="input-group-addon btn btn-primary">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>

								</div> <select name="startDateTime.hour" id="startDateTimehour" items="${hours}" class="narrow" numberFormat="00" emptyOptionLabel="${blankChoose}" /> <scannell:select
									path="startDateTime.minute" id="startDateTime" items="${minutes}" class="narrow" numberFormat="00" emptyOptionLabel="${blankChoose}" /> <scannell:errors path="exam.startTime"
									id="startDateTime" class="errorMessage" />
							</td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="duration" />:</td>
							<td class="search"><input name="durationAmount" class="form-control" cssStyle="float:left;width:5%" /> <select name="durationUnit" items="${durationUnits}"
									id="durationAmount" itemValue="name" lookupItemLabel="true" emptyOptionLabel="${blankChoose}" /> <scannell:errors path="exam.duration" /></td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="secondaryAuditors" />:</td>
							<td class="search" colspan="3">
								<c:choose>
									<c:when test="${fn:length(auditors) lt 500}">
										<scannell:select id="secondaryAuditors" path="exam.secondaryAuditors" items="${auditors}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
											cssStyle="width:50%" renderEmptyOption="false" />
									</c:when>
									<c:otherwise>
										<input type="hidden" id="secondaryAuditors" style="width:100%;" multiple="multiple" name="exam.secondaryAuditors"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>

						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="otherParticipants" />:</td>
							<td class="search"><scannell:textarea path="exam.otherParticipants" class="form-control" cssStyle="float:left;width:50%" /></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" align="center"><c:choose>
									<c:when test="${managementProgramme.id gt 0}">
										<c:url var="cancelURL" value="/audit/auditView.htm">
											<c:param name="id" value="${audit.id}" />
										</c:url>
									</c:when>
									<c:otherwise>
										<c:url var="cancelURL" value="/audit/programmeView.htm">
											<c:param name="id" value="${command.exam.programme.id}" />
										</c:url>
									</c:otherwise>
								</c:choose> <input type="submit" value="<fmt:message key="submit" />" class="g-btn g-btn--primary"> <input type="button" value="<fmt:message key="cancel" />" class="g-btn g-btn--secondary"
									onclick="window.location='<c:out value="${cancelURL}" />'"></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</scannell:form>

</body>
</html>
