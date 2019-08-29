<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="recurringAuditEdit" />
	<c:if test="${!command.exam.update}"> 
		<c:set var="title" value="recurringAuditCreate" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/js/userSiteOptions.js" />"></script>
	
	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

	<script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var auditorCount = ${fn:length(auditors)};
		var auditeeCount = ${fn:length(userAuditees)};
		var userCount = ${fn:length(allUsers)};
		var maxListSize = 500;
		
	jQuery(document).ready(function() {
		//jQuery('#leadAuditor').select2({width:'60%'});
		jQuery('#auditeeType').select2({width:'40%'});
		jQuery('#u_auditees').select2({width:'50%'});	
		//jQuery('#user').select2({width:'50%'});
		jQuery('#department').select2({width:'60%'});
		jQuery('#workarea').select2({width:'60%'});
		jQuery('#location').select2({width:'60%'});
		jQuery('#template').select2({width:'40%'});
		jQuery('#t_auditees').select2({width:'40%'});
		jQuery('#durationUnit').select2({width:'20%'});
		jQuery('#startDateTimehour').select2({width:'10%'});
		jQuery('#startDateTimeminute').select2({width:'10%'});
		jQuery('#freq').select2({width:'15%'});
//		jQuery('#observers').select2({width:'60%'});
		//jQuery('#secondaryAuditors').select2({width:'60%'});
		
		setNewAuditeeVisibility();
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
		   var leadAuditor = '<c:out value="${command.exam.leadAuditor.id}"/>';
			if(leadAuditor != null){
				jQuery('#leadAuditor').val(leadAuditor);
			}
		   
			if(auditorCount < maxListSize)
			{
				jQuery('#leadAuditor').select2({width:'40%'});
			}
			else 
			{
				jQuery('#leadAuditor').select2({				  
				  width:'40%',
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
				var d = "<c:out value="${command.exam.secondaryAuditors}"/>";
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
						 var d = "<c:out value="${command.exam.secondaryAuditors}"/>";
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

			if(userCount < maxListSize)
			{
				jQuery('#observers').select2({width:'60%'});
			}
			else 
			{
				   var d = "<c:out value="${command.exam.observers}"/>";
					var data = [];
					<c:forEach items="${command.exam.observers}" var="o">
				    	jQuery('#observers').append("<option value='${o.id}' >${o.displayNameWithDepartment}</option>") 
				    	jQuery('#observers').val('<c:out value="${o.id}"/>');
				    	jQuery('#observers option[value="${o.id}"]').attr("selected","selected");
				    	data.push('${o.id}');
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
						<c:forEach items="${command.exam.observers}" var="o">
					    	data.push({id: "<c:out value="${o.id}"/>", text: "<c:out value="${o.displayNameWithDepartment}"/>"});

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
				      cache: true
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

<c:set var="progBa" value="${command.exam.programme.businessAreas}"/>
<body onload="setNewAuditeeVisibility()">
<scannell:form onsubmit="document.getElementById('submit').disabled = 1;">
<input type="hidden" id="userDefaultSite"/>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<fmt:message var="blankChoose" key="blankChoose" />
<tbody>
	<tr class="form-group">
		<td class="searchLabel nowrap" style="width:30%"><fmt:message key="auditProgramme" />:</td>
		<td  class="search"><c:out value="${command.exam.programme.description}" /></td>
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
		<td  class="search"><input name="exam.name" class="form-control" cssStyle="float:left;width:40%" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="leadAuditor" />:</td> 
		<td  class="search">
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
		<td  class="search">
			<scannell:select id="auditeeType" path="auditeeType" onchange="onAuditeeTypeChange();" renderEmptyOption="false">
				<scannell:option value="u" labelkey="auditeeType[u]"	/>
				<scannell:option value="t" labelkey="auditeeType[t]" />
			</scannell:select>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="auditee" />:</td>
		<td  class="search">
		<div id="userAuditeeForm" <c:if test="${command.auditeeType != 'u'}"> style="display: none;"</c:if> >
			<table class="table table-responsive table-bordered" id="userAuditeeFormTable" >
			<tbody>
				<tr>
					<th style="width:50%"><fmt:message key="employee" />:</th>
					<td>				
					 	<c:choose>
							<c:when test="${fn:length(userAuditees) lt 500}">
								<scannell:select id="user" path="auditeeUser" items="${userAuditees}" itemValue="id" itemLabel="sortableName" class="wide" /> <scannell:errors path="userAuditee.user" />
							</c:when>
							<c:otherwise>
					    		<input type="hidden" id="user" name="auditeeUser" /> <scannell:errors path="userAuditee.user" />		
							</c:otherwise>
						</c:choose>	
					</td>
					</tr>
					<tr>
						<th><fmt:message key="department" />:</th>
						<td><scannell:select id="department" path="auditeeDepartment" items="${departments}" itemValue="id" itemLabel="name" class="wide" /><scannell:errors path="userAuditee.department" /></td>
					</tr>
					<tr>
						<th><fmt:message key="workArea" />:</th>
						<td><scannell:select id="workarea" path="auditeeWorkArea" items="${workareas}" itemValue="id" itemLabel="name" class="wide" /><scannell:errors path="userAuditee.workArea" /></td>
					</tr>
					<tr>
						<th><fmt:message key="deptLocation" />:</th>
						<td><scannell:select id="location" path="auditeeLocation" items="${locations}" itemValue="id" itemLabel="name" class="wide" /><scannell:errors path="userAuditee.location" /></td>
					</tr>
			</tbody>
			</table>
      </div>
			<c:if test="${command.canCreateThirdParty}">
				<c:set var="emptyOptionLabel" value="thirdPartyCreate" />
				<c:set var="onChangeAction" value="setNewAuditeeVisibility()" />
			</c:if>
			<scannell:select id="t_auditees" path="thirdPartyAuditee.id" items="${thirdPartyAuditees}" itemValue="id" itemLabel="description" visible="${command.auditeeType == 't'}" onchange="${onChangeAction}" emptyOptionValue="0" emptyOptionLabel="${emptyOptionLabel}" class="wide" />
			<scannell:errors path="thirdPartyAuditee" class="errorMessage" />
			<scannell:errors path="exam.auditee" class="errorMessage" writeRequiredHint="false" />
			<scannell:errors path="userAuditee" class="errorMessage" />

			<table class="table table-bordered table-responsive" id="newAuditeeForm" style="display: none;margin-top: 10px;"">
			<c:if test="${command.canCreateThirdParty}">
			<tbody>
				<tr>
					<th><fmt:message key="name" />:</th>
					<td><input name="thirdPartyAuditee.name"  class="higher" /></td>
				</tr>
				<tr>
					<th><fmt:message key="company" />:</th>
					<td><input name="thirdPartyAuditee.company" class="higher" /></td>
				</tr>
				<tr>
					<th><fmt:message key="address" />:</th>
					<td><input name="thirdPartyAuditee.address" class="higher" /></td>
				</tr>
				<tr>
					<th><fmt:message key="phoneNumber" />:</th>
					<td><input name="thirdPartyAuditee.phoneNumber" class="higher"  /></td>
				</tr>
				<tr>
					<th><fmt:message key="emailAddress" />:</th>
					<td><input name="thirdPartyAuditee.emailAddress" class="higher" /></td>
				</tr>
			</tbody>
			</c:if>
			</table>
		</td>
	</tr>
	<!-- START: Person Observed -->
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="audit.personObserved"/>:</td>
		<td class="search" colspan="3">
          	<c:choose>
				<c:when test="${fn:length(allUsers) lt 500}">
					<scannell:select id="observers" path="exam.observers" items="${allUsers}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
						cssStyle="width:50%" renderEmptyOption="false" />
				</c:when>
				<c:otherwise>
					<input type="hidden" id="observers" style="width:100%;" multiple="multiple" name="exam.observers" />
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<!-- END: Person Observed -->
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="exam.additionalInfo" cols="75" rows="3" /></td>
	</tr>
	
<c:choose>

<c:when test="${recurringAuditType eq 'RecurringScheduledAudit'}">

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="template" />:</td>
		<td  class="search"><select name="exam.template" id="template" items="${templates}" itemValue="id" itemLabel="name" class="wide" emptyOptionLabel="${blankChoose}"/> </td>
	</tr>

</c:when>

<c:when test="${recurringAuditType eq 'RecurringExpressAudit'}">
<fmt:message key="incident.enableAdditionalFields" var="enableAdditionalFields" />
<c:if test="${!enableAdditionalFields}">

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="department" />:</td>
		<td colspan="3"  class="search"><select name="exam.department" items="${auditdepartments}" itemValue="id" itemLabel="name" class="wide" /></td>
	</tr>

</c:if>
	
<c:if test="${enableAdditionalFields}">

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="location" />:</td>
		<td colspan="3"  class="search"><select name="exam.location" items="${locations}" itemValue="id" itemLabel="name" class="wide"  emptyOptionLabel="${blankChoose}"/></td>
	</tr>

</c:if>						
</c:when>

<c:otherwise></c:otherwise>

</c:choose>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="duration" />:</td>
		<td  class="search">
			<input name="durationAmount" class="form-control" cssStyle="float:left;width:5%" />
			<select name="durationUnit" id="durationUnit" items="${durationUnits}" itemValue="name" lookupItemLabel="true" emptyOptionLabel="${blankChoose}" />
			<scannell:errors path="exam.duration"/>
		</td>
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
		<td  class="search"><scannell:textarea path="exam.otherParticipants" cols="75" rows="3" /></td>
	</tr>
	
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="frequency" />:</td>
		<td  class="search">
			<select name="exam.frequency" id="freq" writeErrorsAfterEndTag="false" emptyOptionLabel="${blankChoose}"  >
			  <c:forEach items="${frequencies}" var="frequency">
				<fmt:message var="label" key="RecurringAuditFrequency.${frequency}" />
				<scannell:option value="${frequency}" label="${label}" />
			  </c:forEach>
			</scannell:select>
			<scannell:errors path="exam.frequency" class="errorMessage" />
		</td>              	
	</tr>
	
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="initialDate" />:</td>
		<td  class="search">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="startDateTime.date" id="startDate" readonly="true"  />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
			<select name="startDateTime.hour" id="startDateTimehour" items="${hours}" class="narrow" numberFormat="00" />
			<select name="startDateTime.minute" id="startDateTimeminute" items="${minutes}" class="narrow" numberFormat="00" />
			<scannell:errors path="exam.startTime" class="errorMessage" />
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="notificationLeadDays" />:</td>
		<td  class="search"><input name="exam.leadDays" class="form-control" cssStyle="float:left;width:40%"/></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="exam.active" class="narrow"/></td>
	</tr>
	
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center">
			<%-- <c:choose>
				<c:when test="${command.exam.id gt 0}"><c:url var="cancelURL" value="/audit/recurringAuditView.htm"><c:param name="id" value="${command.exam.id}"/></c:url></c:when>
				<c:otherwise><c:url var="cancelURL" value="/audit/programmeView.htm"><c:param name="id" value="${command.exam.programme.id}"/></c:url></c:otherwise>
			</c:choose> --%>
			<input id="submit" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)">Cancel</button>
			<%-- <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:out value="${cancelURL}" />'"> --%>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
