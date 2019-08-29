<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>

<title> </title>

<style type="text/css">
  table.alignTop tbody tr td { vertical-align: top;}
.thlabel {
width: 30%;
height: 100px;
border: 1px dashed #efefef!important;
padding-top: 40px!important;
text-align: center;
background-color: white!important;
}
td{
border: 1px dashed #efefef!important;
background-color: white!important;
}
</style>
	
<script type="text/javascript">
var generateIncident='<fmt:message key="AuditFindingType.generateIncident"/>';
var generateCorrectiveAction='<fmt:message key="AuditFindingType.generateCorrectiveAction"/>';
var generatePreventativeAction='<fmt:message key="AuditFindingType.generatePreventativeAction"/>';
var generateIncidentNotAssign='<fmt:message key="AuditFindingType.generateIncidentNotAssign"/>';
var generateAssignedIncident = '<fmt:message key="AuditFindingType.generateAssignedIncident"/>';

function nonConformance(allow, assignIncident,answerIndex) {
	 var closed = jQuery("#completed-"+answerIndex).is(':checked');
	 var value = jQuery("#findingType-"+answerIndex+" :selected").val();
	 //jQuery("[name='answers["+answerIndex+"].score']").select2("destroy");
	 //jQuery("[name='answers["+answerIndex+"].score']").show();
	 if(value != "b") {
		//jQuery("[name='answers["+answerIndex+"].score']").select2({width:'100%'});
		jQuery("[name='answers["+answerIndex+"].score']").attr('disabled',false);
	 }
	 if(closed) 
	 {
		 if(value == 'j')
		 {
			 var msg = generateIncident;
			 if(assignIncident)
			 {
				 msg += '\n\n';
				 msg += allow ? generateAssignedIncident : generateIncidentNotAssign;
			 }
			 alert(msg);
		 }
		 else if(value === "n") {
			 	alert(generateIncident);
		 }
		 else if(value === "m") {
			 	alert(generateCorrectiveAction);
		 }
		 else if(value === "o") {
			 	alert(generatePreventativeAction);
		 }else if(value === "s") {
			 	alert(generateCorrectiveAction);
		 }
	 }
	 
	 if(value === "b") {
		 jQuery("[name='answers["+answerIndex+"].score']").select2('val', '');
		 jQuery("[name='answers["+answerIndex+"].score']").attr('disabled',true);
		 calculateScoreTotals();
	 }
//	 else if(value === "b") {
	/* if(!jQuery("#completed-"+answerIndex).is(":focus")){
		 jQuery("[name='answers["+answerIndex+"].score']").val("").trigger('change');
		 jQuery("[name='answers["+answerIndex+"].score']").hide();
		 } */
	// }
}

function calculateScoreTotals() {
	  jQuery("span.groupTotal").each(function () {
	    var span = jQuery(this);
	    var groupId = span.attr("ss-grp");
    var totalScore = 0;
    var maxScore = 0;
    var pct = 0
	    jQuery(".score-" + groupId).each(function() {
	      var input = jQuery(this);
	      var score = parseInt(input.val());
	      if(!isNaN(score)) {
        totalScore += score;
	      maxScore += parseInt(input.attr("title")); // hijacking title for max-score as no custom attrs on select tag
	      }
	    });
	    span.html("");
    pct = maxScore > 0 ? Math.round(100 * totalScore / maxScore) : 0;
    span.html(totalScore + "/" + maxScore + "<br/>" + pct + "%");

	  });	  	  
	}

jQuery(document).ready(function() {
	
	setDefaultFindingType();
	
	jQuery("select.score-all").change(calculateScoreTotals);

  
  function toggleCompleteComment() {
    var completedChecked = jQuery("#completedCheckbox").is(':checked');
    var auditCompletedCommentField = jQuery("#completionComment");
    
    if(completedChecked) {
      auditCompletedCommentField.removeAttr("disabled");  
    } else {
      auditCompletedCommentField.attr("disabled", "disabled")
    }
  }
  jQuery("#completedCheckbox").click(toggleCompleteComment);
  

  
  function toggleCompleteCheckbox() {
    var allAnswersCompletedChecked = !(jQuery(".answerCompleted").is(":not(':checked')"));
    var auditCompletedCheckbox = jQuery("#completedCheckbox");
    
    if(allAnswersCompletedChecked) {
      auditCompletedCheckbox.removeAttr("disabled");  
    } else {
      auditCompletedCheckbox.attr("disabled", "disabled")
      auditCompletedCheckbox.removeAttr('checked');
    }
    toggleCompleteComment();
  }

	jQuery(".answerCompleted").click(toggleCompleteCheckbox);

	toggleCompleteCheckbox();
	jQuery(".scores").select2({width:'100%'});
	jQuery(".ss-findingTypeSelect").select2({width:'40%'});

	setDefaultFindingType(); // Some strange reason I have to call it twice

});


function setDefaultFindingType(){
	jQuery('[id^=findingType]').each(function (){
		if(jQuery(this).val() == ''){
			jQuery(this).select2().select2('val', '${audit.template.defaultFindingType.name}').select2({width:'40%'});
		}
		if(jQuery(this).val() == 'b'){
		jQuery(this).trigger('change'); //When page reload: if finding type is not applicable hide score options.
		}
	});
}

</script>

</head>
<body>
<div class="header">
<h2><c:out value="${audit.name}" /> - <fmt:message key="auditBulkQuestionAnswer" /></h2>
</div>
<h3 style="margin-top: 30px;" align="center"><c:out value="${audit.programme.description}" /></h3>
<div class="content">
<scannell:form id="auditBulkQuestionAnswerForm">

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table  table-responsive <c:if test="${layout eq 'horizontal'}">bordered alignTop</c:if>">
<fmt:message var="blankChoose" key="blankChoose" />
 
<c:forEach items="${questionsByGroup}" var="questionsByGroupEntry">
	<c:set var="group" value="${questionsByGroupEntry.key}" />
	<c:set var="questions" value="${questionsByGroupEntry.value}" />
  <c:set var="groupId" value="${group.id}" />
  <c:if test="${group eq null}"><c:set var="groupId" value="${0}" /></c:if>
	
	<thead>
		<tr>
			<td colspan="4">
				<h3><c:out value="${group.name}" /></h3>
			</td>
		</tr>
	</thead>
	
  <c:choose>
  <c:when test="${layout eq 'horizontal'}">

  <thead>
	  <tr>
	    <th style="min-width: 250px; width: 30%"><h3><fmt:message key="question" /></h3></th>
	    <th style="width:30%"><h3><fmt:message key="findingComment" /></h3></th>
	    <c:if test="${audit.template.scorable}" >
	      <th><h3><fmt:message key="score" /></h3></th>
	    </c:if>
	    <th style="width:10%"><h3><fmt:message key="completed" /></h3></th>
	  </tr>
  </thead>
  
  <tbody>
  <c:forEach items="${questions}" var="question" varStatus="s">
    <c:set var="answerIndex" value="${questionsToIndex[question]}" />
    <c:set var="answer" value="${command.answers[answerIndex]}" />
  <tr style="border-top: 2px solid #ddd">
    <td style="width: 15%">
      <scannell:text value="${question.name}" />
      <c:if test="${question.active}">
        <br /><br />
        <scannell:text value="${question.additionalInfo}" />
      </c:if>
    </td>
    <td>
      <c:choose>
        <c:when test="${question.completed}">
          	<scannell:text value="${question.findingComment}" />
		     <br /><br />
		     <c:if test="${question.findingType != null}">
          		<fmt:message key="${question.findingType}" />
          	</c:if>
        </c:when>
        <c:otherwise>
        	<scannell:textarea path="answers[${answerIndex}].findingComment"  cols="50" rows="2" defaultValue="None" class="form-control" cssStyle="width:85%" />
          
          <br />
          <scannell:select class="ss-findingTypeSelect wide" cssStyle="width:80% !important" id="findingType-${answerIndex}"  path="answers[${answerIndex}].findingType" items="${findingTypes}" itemValue="name" lookupItemLabel="true" emptyOptionLabel="${blankChoose}"
          onchange="nonConformance(${allowIncidentBeAssigned},${assigneIncidentToAuditee},${answerIndex});"></scannell:select>
        </c:otherwise>      
      </c:choose>
    </td>
    <c:if test="${audit.template.scorable}" >
      <td style="width: 20%">
        <c:if test="${question.scorable}">
		      <c:choose>
		        <c:when test="${question.completed}">
		            <c:if test="${question.score ne null}" >
		              <input type="hidden" class="score-all score-${groupId}" value="${question.score}" title="${question.scoreConfig.scoreMax}" />
		              <c:out value="${question.score}/${question.scoreConfig.scoreMax}" />
		            </c:if>&nbsp;
		        </c:when>
		        <c:otherwise>
		          <select name="answers[${answerIndex}].score"  id="score-${groupId}"  items="${question.scoreConfig.permittedScores}" class="scores score-all score-${groupId}"  title="${question.scoreConfig.scoreMax}"  emptyOptionLabel="${blankChoose}" ></scannell:select>
		        </c:otherwise>      
		      </c:choose>
        </c:if>
        &nbsp;
      </td>
    </c:if> 
    <td>
      <c:choose>
        <c:when test="${question.completed}">
          <fmt:message key="${question.completed}" />
		      <c:set var="result" value="${question.result}" />
		      <c:if test="${result != null}">
		        <br /><br />
		        <fmt:message key="result" />: <scannell:entityUrl entity="${result}" messageCodePrefix="auditResult." />
		        (<fmt:message key="status" />: <fmt:message key="${result.statusCode}" />)
		      </c:if>
        </c:when>
        <c:otherwise>
          <scannell:checkbox id="completed-${answerIndex}" path="answers[${answerIndex}].completed" class="answerCompleted" onchange="nonConformance(${allowIncidentBeAssigned},${assigneIncidentToAuditee},${answerIndex});"/>
        </c:otherwise>      
      </c:choose>
    </td>
  </tr>
  </c:forEach>
  </tbody>
  </c:when>
  
  <c:otherwise> <!-- vertical layout -->
  
  <col class="label" />
	
	<c:forEach var="question" items="${questions}" >
	<thead>
		<tr>
			<th colspan="2" style="padding-top: 5px; padding-bottom: 5px"><h3><scannell:text value="${question.name}" /></h3></th>
			
		</tr>
	</thead>
	<tbody class="table table-bordered table-responsive">
	
		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" />:</td>
			<td><scannell:text value="${question.additionalInfo}" /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="completed" />:</td>
			<td><fmt:message key="${question.completed}" /></td>
		</tr>
	
	<c:choose>
	
	<c:when test="${question.completed}">
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="findingType" />:</td>
			<td><c:if test="${question.findingType != null}"><fmt:message key="${question.findingType}" /></c:if></td>
		</tr>
		<c:if test="${question.scorable}">
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="score" />:</td>
			<td>
			  <c:if test="${question.score ne null}">
			    <input type="hidden" class="score-all score-${groupId}" value="${question.score}" title="${question.scoreConfig.scoreMax}" />
			    <c:out value="${question.score}/${question.scoreConfig.scoreMax}" />
			  </c:if>
			</td>
		</tr>
		</c:if>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="findingComment" />:</td>
			<td><scannell:text value="${question.findingComment}"  /></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="completedBy" />:</td>
			<td><c:out value="${question.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${question.completedTime}" pattern="dd-MMM-yyyy" /></td>
		</tr>
		<c:set var="result" value="${question.result}" />
		<c:if test="${result != null}">
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="result" />:</td>
			<td><scannell:entityUrl entity="${result}" messageCodePrefix="auditResult." /> (<fmt:message key="status" />: <fmt:message key="${result.statusCode}" />)</td>
		</tr>
		</c:if>
	</c:when>
	
	<c:otherwise>
		<c:set var="answerIndex" value="${questionsToIndex[question]}" />
		<c:set var="answer" value="${command.answers[answerIndex]}" />
		<tr>
			<td class="scannellGeneralLabel nowrap"><fmt:message key="findingComment" />:</td>
			<td><scannell:textarea path="answers[${answerIndex}].findingComment" cols="75" rows="9" defaultValue="None"  class="form-control" cssStyle="width:40%"/></td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="findingType" />:</td>
			<td><scannell:select class="ss-findingTypeSelect wide" id="findingType-${answerIndex}" path="answers[${answerIndex}].findingType" items="${findingTypes}" itemValue="name" lookupItemLabel="true"
			onchange="nonConformance(${allowIncidentBeAssigned},${assigneIncidentToAuditee},${answerIndex});"></scannell:select></td>
		</tr>
		<c:if test="${question.scorable}">
			<tr>
				<td class="scannellGeneralLabel"><fmt:message key="score" />:</td>
				<td><select name="answers[${answerIndex}].score" id="score-${groupId}"   items="${question.scoreConfig.permittedScores}" class="scores score-all score-${groupId}" title="${question.scoreConfig.scoreMax}" emptyOptionLabel="${blankChoose}"></scannell:select></td>
			</tr>
		</c:if>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="completed" />:</td>
			<td><scannell:checkbox id="completed-${answerIndex}" path="answers[${answerIndex}].completed" class="answerCompleted" onchange="nonConformance(${allowIncidentBeAssigned},${assigneIncidentToAuditee},${answerIndex});"/></td>
		</tr>
	</c:otherwise>
	
	</c:choose>
	</tbody>
	</c:forEach>
	 
	</c:otherwise>
  </c:choose>

  <c:if test="${audit.template.scorable}">
    <c:set var="summary" value="${groupScores[group]}" />
    <c:if test="${group eq null}"><c:set var="summary" value="${nullGroupScore}" /></c:if>
    <tr class="auditQuestionGroupFooter">
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th><span class="groupTotal" ss-grp="${groupId}" ><c:out value="${summary.asFraction}" /><br /><c:out value="${summary.asPercent}" />%</span></th>
      <th>&nbsp;</th>
    </tr>
  </c:if>

</c:forEach>

<c:if test="${audit.template.scorable}">
<thead>
  <c:set var="summary" value="${audit.scoreSummary}" />
  <tr class="auditQuestionScoreFooter">
    <td colspan="2" style="text-align: right;"><h3><fmt:message key="audit.overallScore" /></h3></td>
    <td ><span class="groupTotal" ss-grp="all"><c:out value="${summary.asFraction}" /><br /><c:out value="${summary.asPercent}" />%</span></td>
    <td>&nbsp;</td>
  </tr>
</thead>
</c:if>

<c:if test="${audit.currentUserIsAuditor}">

<tbody>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="auditComplete" />:</td>
    <td colspan="3">
    <div class="checkbox">  
    <label>
      <scannell:checkbox id="completedCheckbox" path="completed" />
      </label>  
      </div>
    </td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="comment" />:</td>
    <td colspan="3">
      <scannell:textarea id="completionComment" path="completionComment" cols="75" rows="9" defaultValue="None" class="form-control" cssStyle="width:40%" />
    </td>
  </tr>
</tbody>
</c:if>

<tfoot>
	<tr>
		<td colspan="4" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
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
