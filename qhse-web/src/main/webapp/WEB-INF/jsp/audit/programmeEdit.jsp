<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="programmeEdit" />
	<c:if test="${command.newProgramme}"><c:set var="title" value="programmeCreate" /></c:if>
	<title><fmt:message key="${title}" /></title>
	<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	
	<script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var ownerCount = ${fn:length(owners)};
		var maxListSize = 500;
	
	jQuery(document).ready(function() {	
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
		jQuery('#plan').select2({width:'40%'});
		jQuery('#type').select2({width:'40%'});		
		jQuery('#cal .requiredHinted').remove();	
		
		var responsibleUser= '<c:out value="${command.owner.id}"/>';
		if(responsibleUser != null){
			jQuery('#owner').val(responsibleUser);
		}
		
		if(ownerCount < maxListSize)
		{
			jQuery('#owner').select2({width:'40%'});
		}
		else 
		{
	    	jQuery('#owner').select2({				  
			  width:'40%',
			  minimumInputLength : 3,
			  placeholder :  enterChars,
			  escapeMarkup: function(m) {
			        // Do not escape HTML in the select options text
			        return m;
			     },
			  ajax: {
			        url: "programmeUserList.json",
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
				       var data = {id: "<c:out value="${command.owner.id}"/>", text: "<c:out value="${command.owner.sortableName}"/>"};
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
		var objError = document.getElementById('reviewDate.errors');
		if(objError != null) {
			jQuery('#msgError').append(  jQuery(objError).text() );
			$( objError ).remove();
		}
	});

	  function onChangePlan(plan) {
		  var plan = plan[plan.selectedIndex].text;
		  jQuery(".ckbBA").prop('disabled', false);
		  jQuery(".ckbBA").each(function() {
			  var label = jQuery('label[for=' + jQuery(this).attr('id') + ']').html();
			  var value = label.replace("amp;", ""); 
			  if(plan.indexOf(value) == -1) {
				  jQuery(this).prop('disabled', true);
				  jQuery(this).prop('checked', false);
			  }
			});
	  }
	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<c:set var="planBa" value="${command.plan.businessAreas}"/>
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="auditPlan" />:</td>
		<c:choose>
			<c:when test="${command.newProgramme}">
				<td class="search"><select name="plan" id="plan" items="${plans}" itemValue="id" itemLabel="displayName" class="wide" onchange="onChangePlan(this)"/></td>
			</c:when>
			<c:otherwise>
				<td class="search"><c:out value="${command.plan.displayName}" /></td>
			</c:otherwise>
		</c:choose>
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
	            <input class="ckbBA" type="checkbox" id="ba${ba.id}"
	                name="<c:out value="${status.expression}"/>"
	                value="<c:out value="${ba.id}" />"
	                <c:if test="${selected}">checked="checked"</c:if> 
	                <c:if test="${(not empty planBa) && (not enviromanager:contains(planBa,ba))}">disabled="disabled"</c:if>/>
	            <label for="ba${ba.id}"><c:out value="${ba.name}" /></label><br>
	
	            <c:remove var="selected" />
	          </c:forEach>
	          </label>
	          <span class="requiredHinted">*</span>
	          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
	        </spring:bind>
    	</td>
  	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="owner" />:</td>
		<td class="search">
			<c:choose>
				<c:when test="${fn:length(owners) lt 500}">
					<select name="owner" id="owner" items="${owners}" itemValue="id" itemLabel="sortableName" class="wide" />
				</c:when>
				<c:otherwise>
					<input type="hidden" id="owner" style="width:40% !important;" name="owner" onchange="updateApprovalUser(this);" />
					<scannell:errors path="owner"/>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="type" />:</td>
		<td class="search"><select name="type" id="type" items="${types}" itemValue="id" itemLabel="name" class="wide" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="additionalInfo" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="reviewDate" />:</td>
		<td class="search">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime  col-md-5 col-xs-7" data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left;">
                  <scannell:input class="form-control" path="reviewDate" id="reviewDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th" ></span></span>
                  </div>			
                  
                </div>
                <span id="msgError" class="requiredHinted">*</span>
				<span id="spanActualDate" class="errorValidation" >
				</span>
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
