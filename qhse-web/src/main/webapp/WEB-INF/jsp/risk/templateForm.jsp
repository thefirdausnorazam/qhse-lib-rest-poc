<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
  <style type="text/css" media="all">    
    @import "<c:url value='/css/risk.css'/>";
  </style>
  <script type="text/javascript">  
  jQuery(document).ready(function() {	  
	  jQuery("#criticalFrequencyReview").select2();
	  jQuery("#redFrequencyReview").select2();
	  jQuery("#amberFrequencyReview").select2();
	  jQuery("#greenFrequencyReview").select2();
	  toggleCritical();
	  	 
	  if('${template.scorable}' == 'false'){  
		  jQuery("#criticalThresholdLimit").prop('disabled', true);
		  jQuery("#upperThresholdLimit").prop('disabled', true);
		  jQuery("#lowerThresholdLimit").prop('disabled', true);
	  }
  });
  function toggleCritical(){
		var critical = document.getElementById("critical").checked;
		var critcalTable = document.getElementById("critcalTable");
		var critcalFreqTable = document.getElementById("critcalTableFreq");
		var high = document.getElementById("high");
		var medium = document.getElementById("medium");
		
		if(critical==false)
		{
			critcalTable.style.display='none';
			critcalFreqTable.style.display='none';
			high.src = '<c:url value="/images/risk/score_redlight.giff" />';
			medium.src = '<c:url value="/images/risk/score_amberlight.giff" />';
		}
		else
		{
			critcalTable.style.display='table-row';	
			critcalFreqTable.style.display='table-row';
			high.src = '<c:url value="/images/risk/score_amberlight.giff" />';
			medium.src = '<c:url value="/images/risk/score_yellowlight.giff" />';
		}
		
	}
  </script>
</head>
<body>
<div class="header">
<h2><fmt:message key="templateForm.title" /></h2>
</div>
<scannell:form id="theForm">
<input type="hidden" name="actionType" value="submit" id="actionType" />
<div class="content"> 
<div class="table-responsive">
<div class="panel hidden-print">  
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <c:if test="${template.id != null}">
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${template.id}" />
    </td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="businessArea" />:</td>
    <td colspan="3">
    <c:out value="${template.businessArea.name}" />
<%--
      <scannell:hidden path="businessArea" writeRequiredHint="false"/>
      <ul>
        <li><c:out value="${command.businessArea.name}" /></li>
      </ul>
--%>
    </td>
  </tr>

  <tr>
    <td ><fmt:message key="template.name" />:</td>
    <td colspan="3"><c:out value="${template.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.prefix" />:</td>
    <td colspan="3"><c:out value="${template.prefix}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.additionalInformation" />:</td>
    <td colspan="3"><scannell:textarea path="additionalInformation" cols="75" rows="3" /></td>
  </tr>
   <tr>
    <td ><fmt:message key="template.footer" />:</td>
    <td colspan="3"><scannell:textarea path="footer" cols="75" rows="3" /></td>
  </tr>

<tr>
    <td ><fmt:message key="template.printableFields" />:</td>
    <td colspan="3">
	    <spring:bind path="command.fields">
			<input type="hidden" name="<c:out value="_${status.expression}"/>" />
	        <div class="wide scrolllist" style="height: auto" >
	          <c:forEach items="${allFields}" var="field">
	            <c:set var="selected" value="${false}" />
	            <c:forEach items="${command.fields}" var="selectedField">
	              <c:if test="${field == selectedField}"><c:set var="selected" value="${true}" /></c:if>
	            </c:forEach>
	            <input type="checkbox" name="fields" value="<c:out value="${field}" />" <c:if test="${selected}">checked="checked"</c:if> />
	              <span><fmt:message key="${field}" /></span><br />
	          </c:forEach>
	        </div>
	        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
	      </spring:bind>
    </td>
    
  <tr>
    <td><fmt:message key="template.critical" />:</td>
    <td colspan="3"><scannell:checkbox id="critical" path="critical" onclick="toggleCritical();"/></td>
  </tr>
     <tr id="critcalTable">
	    <td><fmt:message key="threshold.criticalLimit" />:</td>
	    <td colspan="3" ><input name="criticalThresholdLimit" id="criticalThresholdLimit"/></td>
	 </tr>
	  <tr>
	    <td><fmt:message key="threshold.upperLimit" />:</td>
	    <td colspan="3"><input name="upperThresholdLimit" id="upperThresholdLimit"/></td>
	  </tr>
	  <tr>
	    <td ><fmt:message key="threshold.lowerLimit" />:</td>
	    <td colspan="3"><input name="lowerThresholdLimit" id="lowerThresholdLimit"/></td>
	  </tr>
	 <c:if test="${template.prefix == 'HSIRR'}">
	 	<tr>
		    <td><fmt:message key="threshold.hazardUpperLimit" />:</td>
		    <td colspan="3"><input name="hazardUpperThresholdLimit" id="hazardUpperThresholdLimit"/></td>
		  </tr>
		<tr>
		    <td ><fmt:message key="threshold.hazardLowerLimit" />:</td>
		    <td colspan="3"><input name="hazardLowerThresholdLimit" id="hazardLowerThresholdLimit"/></td>
		  </tr>
	 </c:if>
  <tr>
  	<td ><fmt:message key="template.riskReviewFrequencyDetail" />:</td>
  	<td colspan="3"></td>
  </tr>
   <tr id="critcalTableFreq">
	  <td>
	  	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
	    <fmt:message key="template.frequencyOfReviewCritical" />:</td>
	  <td colspan="3">
	    <select name="criticalFrequencyReview" items="${frequency4Review}" itemLabel="name" itemValue="id" />
	  </td>
   </tr>
   <tr>
	   	<td>
	    	<img id="high" src="<c:url value="/images/risk/score_amberlight.giff" />" />
	    	<fmt:message key="template.frequencyOfReviewRed" />:</td>
	    <td colspan="3">
	    	<select name="redFrequencyReview" items="${frequency4Review}" itemLabel="name" itemValue="id" />
	    </td>
  </tr>
  <tr>
    <td>
	    <img id="medium" src="<c:url value="/images/risk/score_yellowlight.giff" />" />
	    <fmt:message key="template.frequencyOfReviewAmber" />:</td>
    <td colspan="3">
    	<select name="amberFrequencyReview" items="${frequency4Review}" itemLabel="name" itemValue="id" />
    </td>
	</tr>
	<tr>
	  <td>
	    <img src="<c:url value="/images/risk/score_greenlight.giff" />" />
	    <fmt:message key="template.frequencyOfReviewGreen" />:</td>
	  <td colspan="3">
	    <select name="greenFrequencyReview" items="${frequency4Review}" itemLabel="name" itemValue="id" />
	  </td>
  </tr>
  <tr>
    <td ><fmt:message key="template.advanceDaysToNotify" />:</td>
    <td colspan="3"><input name="notifyReviewDaysBefore"  class="narrow"/></td>
  </tr>
  
  <tr>
    <td ><fmt:message key="template.scoringModel" />:</td>
    <td colspan="3"><input name="scoringModel" class="narrow" type="text" value="${template.scoringModel}" disabled="disabled"></td>
  </tr>
  
  <tr ${template.multiApproval ? '' : 'style=display:none'}>
    <td ><fmt:message key="template.riskApprovalTargetDays" />:</td>
    <td colspan="3"><input name="riskApprovalTargetDays"  class="narrow" onkeyup="this.value=this.value.replace(/[^\d]/,'')" maxlength="5"/></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.summaryQuestions" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="q" items="${template.summaryQuestions}">
        <li><c:out value="${q.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="template.scorable" />:</td>
    <td colspan="3"><fmt:message key="${template.scorable}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="template.active" />:</td>
    <c:set var="selected" value="${template.activeTemplate == 'true'}" />
    <td colspan="3">
    	<spring:bind path="template.active">
			<input type="hidden" name="<c:out value="_${status.expression}"/>" />
			<input type="checkbox" name="<c:out value="${status.expression}"/>"
				<c:if test="${selected}">checked="checked"</c:if> />
		</spring:bind>
	</td>
  </tr>
  <tr>
  <c:if test="${template.createdByUser != null}">
    <td ><fmt:message key="createdBy" />:</td>
    <td><c:out value="${template.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:if>

  <c:if test="${template.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${template.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <c:choose>
        <c:when test="${template.id gt 0}">
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/templateView.htm"><c:param name="id" value="${template.id}"/></c:url>'">
        </c:when>
        <c:otherwise>
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/templateQueryForm.htm" />'">
        </c:otherwise>
      </c:choose>
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
