<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<c:set var="title" value="changeProgramme.edit" />
	<c:if test="${command.newProgramme}"><c:set var="title" value="changeProgramme.create" /></c:if>
	<title><fmt:message key="${title}" /></title>
	<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
	<script type="text/javascript">
 jQuery(document).ready(function() {		
		jQuery('select').select2({width:'300px'});
		jQuery(".date").find(".requiredHinted").remove();
		var spanMsg = jQuery('#reviewDateDiv').find('.error');
		jQuery('#reviewDateDiv').find('.error').remove();
		jQuery('.errorMessage').append(spanMsg);
		
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
<c:set var="planBa" value="${command.plan.businessAreas}"/>
	<scannell:form>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive" >
				
				<tbody>
					
					<tr class="form-group">
						<td class="searchLabel"><fmt:message key="changePlan" />:</td>
						<c:choose>
							<c:when test="${command.newProgramme}">
								<td class="search"><select name="plan" items="${plans}" itemValue="id" itemLabel="displayName" class="wide" onchange="onChangePlan(this)"/></td>
							</c:when>
							<c:otherwise>
								<td class="search"><c:out value="${command.plan.displayName}" /></td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr class="form-group">
				    	<td class="searchLabel"><fmt:message key="businessAreas" />:</td>
				    	<td class="search" >
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
					                <c:if test="${(not empty planBa) && (not enviromanager:contains(planBa,ba))}">disabled="disabled"</c:if>
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
							<td class="searchLabel"><fmt:message key="owner" />:</td>
							<td class="search"><select name="owner" items="${owners}" itemValue="id" itemLabel="sortableName" class="wide" /></td>
						</tr>
					
						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="type" />:</td>
							<td class="search"><select name="type" items="${types}" itemValue="id" itemLabel="name" class="wide" /></td>
						</tr>
					
						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
							<td class="search"><scannell:textarea path="additionalInfo" cols="75" rows="3" /></td>
						</tr>
					
						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="reviewDate" />:</td>
							<td class="search">
								<div id="reviewDateDiv" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 250px;float:left;">
									<scannell:input id="reviewDate" path="reviewDate" class="form-control" cssStyle="float:left;" readonly="true" />
												<!--   <input type="text" id="idPlaceHolderEndDate" name="incident.investigation.recouperationPeriods.periodEndDate" class="form-control" readonly="readonly">	 -->
										<span class="input-group-addon btn btn-primary">
											<span class="glyphicon glyphicon-th"></span>
										</span>
								</div>
								<span class="requiredHinted">*</span>
								<span class="errorMessage">
									<c:out value="${status.errorMessage}" />
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
