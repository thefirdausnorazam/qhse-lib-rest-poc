<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>

<c:set var="change" value="${command.change}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />"></script>
<script type="text/javascript">   
jQuery(document).ready(function() {		
	jQuery('select').select2({width:'300px'});
	jQuery('#reviewers').select2({width:'60%'});
	
	jQuery(".date").find(".requiredHinted").remove();
	var spanMsg = jQuery('#targetTechnicalCloseoutDateDiv').find('.error');
	jQuery('#targetTechnicalCloseoutDateDiv').find('.error').remove();
	jQuery('#targetTechnicalCloseoutDateColumn .errorMessage').append(spanMsg);
	
	
});

   
	function toggleSave(){
	 	var checkboxes = jQuery("*[id\^='review']");
		var save = document.getElementById("save");
	 	var saveAndReview = document.getElementById("saveandreview");	
		var anyCheckBoxSelected=false;
		for(var i=0;i<checkboxes.length;i++){
		if(checkboxes[i].checked){
		  	anyCheckBoxSelected=true;
			}
		}
	
 	 if(anyCheckBoxSelected){
			  saveAndReview.style.display='inline';
		 	 save.style.display='none';
	  }else{
			saveAndReview.style.display='none';
		  	save.style.display='inline';
	  }
		
	}
	
	function disableSubmitButton(){
		jQuery("#save").attr("disabled", true);;
		jQuery("#saveandreview").attr("disabled", true);;
	}

  </script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
    	@import "<c:url value='/css/change.css'/>";		
	</style>
</head>
<body>

<div class="content">
<ul class="caMenu">
			<c:choose>
				<c:when test="${command.change.id != null}">
					<li><a
						href="<c:url value="/change/changeAssessmentStep1.htm"><c:param name="showId" value="${param.showId}" /></c:url>" onclick="<fmt:message key="warning.changeAssessmentTab" />">Change Assessment</a></li>
					<c:if test="${!empty command.change.template.checklistQuestionGroups}">
						<li class="selected">Checklist <i class="fa fa-chevron-circle-right fa-1g"></i></li>
					</c:if>
				</c:when>
			</c:choose>
		</ul>
	<scannell:form id="theForm" onsubmit="disableSubmitButton()">
<div class="content">
			<div class="table-responsive">
				<div class="panel">
		<c:set var="totalAnswers" value="getNumberOfAnswers()" />
		
		<table class="viewForm" style="margin-top: 0px;">
			<col />
			<tbody>
				<c:if test="${command.change.change != null}">
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
						<td id="changeId"><scannell:hidden path="change.id"
								writeRequiredHint="false" /> <scannell:hidden
								path="change.version" writeRequiredHint="false" /> <c:out
								value="${change.id}" /></td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
						<td colspan="3">
					      	<ul>
						      	<c:forEach var="ba" items="${change.businessAreas}">
						        	<li><c:out value="${ba.name}" /></li>
						      	</c:forEach>
					      	</ul>
					    </td>
					</tr>
	
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.status" />:</td>
						<td id="changeAssessmentStatus"><fmt:message
								key="changeAssessment${change.status}" /></td>
					</tr>
				</c:if>
				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
					<td colspan="3"><scannell:text value="${change.name}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="description" />:</td>
					<td colspan="3"><scannell:text value="${change.description}" /></td>
				</tr>

				<tr>
					<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.reviewers" />:</td>
					<td>
						<scannell:select id="reviewers" path="change.reviewers" items="${reviewers}" itemValue="id" multiple="true" itemLabel="displayNameWithDepartment" size="20"
							cssStyle="width:100%" renderEmptyOption="false" />
							<span class="requiredHinted">*</span>
					</td>
				</tr>

			</tbody>
		</table>
		</div>
		</div>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
				
		<table class="viewForm" style="margin-top: 0px;">

				<c:forEach items="${command.change.template.checklistQuestionGroups}" var="g">
					<c:if test="${!empty g.questions}">
					    <c:if test="${g.active}">
					      <c:if test="${g.name != null && g.name != ''}">
					      <tr><td colspan="4"  class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;"><c:out value="${g.name}"/></td></tr>
					      </c:if>
					      <c:forEach items="${g.questions}" var="cq">
					      	<c:set var="q" value="${cq.question}" />
					        <c:if test="${cq.active && q.active}">
					          <tr>
					          <c:choose>
					            <c:when test="${q.answerType.name == 'label'}">
					              <td colspan="4" class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
					            </c:when>
					            <c:otherwise>
					              <td class="scannellGeneralLabel"><c:out value="${q.name}" />:</td>
					              <td><enviromanager:question path="change.answers" question="${q}" emptyOptionLabel="Choose" required="${cq.mandatory}" /></td>
					            </c:otherwise>
					          </c:choose>
					          </tr>
					        </c:if>
					      </c:forEach>
					    </c:if>
					    </c:if>
					</c:forEach>
						</tbody>
					<tfoot>
						<tr>
							<td colspan="4" align="center"><c:url var="cancelURL"
									value="/change/programmeView.htm">
									<c:param name="id" value="${command.change.programme.id}" />
								</c:url> 
								<input id="save" class="g-btn g-btn--primary" type="submit" value="<fmt:message key="submit" />"> 
								<input	id="saveandreview" class="g-btn g-btn--primary" style="display: none" type="submit"	onclick="request();" value="<fmt:message key="savereview" />">
								<input type="button" class="g-btn g-btn--secondary"  value="<fmt:message key="cancel" />"onclick="window.location='<c:out value="${cancelURL}" />'">
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
