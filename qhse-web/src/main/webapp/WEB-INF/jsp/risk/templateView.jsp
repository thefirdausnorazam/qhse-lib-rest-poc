<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ page import="com.scannellsolutions.site.SiteUtils"%>
<%@ page language="java" import = "com.scannellsolutions.site.Site" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>
  <style type="text/css" media="all">   
    @import "<c:url value='/css/risk.css'/>";
  </style>
  <style type="text/css" media="print">
.printImageSize {
	max-width: 500px; width:550px
}

</style>
<style type="text/css">
.matrixImageSize{
	width:800px;
}
@media screen and (min-width: 800px) {
    .matrixImageSize {width:800px;}
}
@media screen and (min-width: 1440px) {
    .matrixImageSize {width:900px;}
}
@media screen and (min-width: 1600px) {
    .matrixImageSize {width:1024px;}
}
@media screen and (min-width: 1920px) {
    .matrixImageSize {min-width:1600px;}
}
</style>
<script type="text/javascript">
jQuery(document).ready(function(){			 
	if(getURLParam('printable') == 'true') {
		jQuery('.matrixImageSize').css('width', '550px');
	}
 });
</script>
</head>
<body>

    <%
      Site site = SiteUtils.currentSite();
    %>
    
<div class="header">
<h2><fmt:message key="templateView.title" /></h2>
</div>
<div class="content"> 
<a name="template"></a>
<div class="header">
<h3> <fmt:message key="template" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger" id="queryTablePanel">  
<table class="table table-bordered table-responsive">  
  <tbody>
  <tr>
    <td><fmt:message key="id" />:</td>
    <td colspan="3"><c:out value="${template.id}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="businessArea" />:</td>
    <td colspan="3"><c:out value="${template.businessArea.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.name" />:</td>
    <td colspan="3"><scannell:text value="${template.name}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.prefix" />:</td>
    <td colspan="3"><scannell:text value="${template.prefix}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="template.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${template.additionalInformation}" /></td>
  </tr>
  
  <tr>
    <td><fmt:message key="template.scoreCalc" />:</td>
    <td colspan="3"><scannell:text value="${template.scoreCalc}" /></td>
  </tr>
  
   <tr>
    <td ><fmt:message key="template.footer" />:</td>
    <td colspan="3"><scannell:text value="${template.footer}" /></td>
  </tr>
  
  <tr>
    <td><fmt:message key="template.printableFields" />:</td>
    <td colspan="3">
		<c:if test="${empty template.printableFieldsList}"><fmt:message key="none" /></c:if>
	     <ul style="">
	      <c:forEach var="field" varStatus="status" items="${template.printableFieldsList}">
	        <li><span style="white-space: nowrap;"><fmt:message key="${field}" /><c:if test="${not status.last}"><br></c:if></span></li>
	      </c:forEach>
	     </ul>
	</td>
  </tr>
<c:if test="${template.multiApproval == false}">
  <tr>
    <td colspan="4">&nbsp;</td>
  </tr>

 <c:choose>
	  <c:when test="${template.critical}">
		    <tr>
			    <td><fmt:message key="threshold.criticalLimit" />:</td>
			    <td colspan="3"><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${template.threshold.criticalLimit}" /></td>
			 </tr>
			<tr>
			    <td><fmt:message key="threshold.upperLimit" />:</td>
			    <td colspan="3"><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${template.threshold.upperLimit}" /></td>
			  </tr>
		  <tr>
		    <td><fmt:message key="threshold.lowerLimit" />:</td>
		    <td colspan="3"><img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${template.threshold.lowerLimit}" /></td>
		  </tr>
	  </c:when>
	  <c:otherwise>
		  	<tr>
			    <td><fmt:message key="threshold.upperLimit" />:</td>
			    <td colspan="3"><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${template.threshold.upperLimit}" /></td>
			  </tr>
		
		  <tr>
		    <td><fmt:message key="threshold.lowerLimit" />:</td>
		    <td colspan="3"><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${template.threshold.lowerLimit}" /></td>
		  </tr>
		  <c:if test="${template.prefix == 'HSIRR'}">
		  	<tr>
			    <td><fmt:message key="threshold.hazardUpperLimit" />:</td>
			    <td colspan="3"><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${template.threshold.hazardUpperLimit}" /></td>
			  </tr>
		
			  <tr>
			    <td><fmt:message key="threshold.hazardLowerLimit" />:</td>
			    <td colspan="3"><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${template.threshold.hazardLowerLimit}" /></td>
			  </tr>
		  </c:if>
	  </c:otherwise>
  </c:choose>

  <tr>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr>
  <td><fmt:message key="template.riskReviewFrequencyDetail" />:</td><td colspan="3">&nbsp;</td>
  </tr>
  <c:choose>
	  <c:when test="${template.critical}">
  		<tr>
		  <td>
			  	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewCritical" />:</td>
			    <td colspan="3"><c:out value="${template.reviewPeriodCritical.name}"/></td>
			  </tr>
			  <tr>
			    <td>
			    <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewRed" />:</td>
			     <td colspan="3"><c:out value="${template.reviewPeriodRed.name}"/></td>
			  </tr>
			  <tr>
			    <td>
			    <img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewAmber" />:</td>
			     <td colspan="3"><c:out value="${template.reviewPeriodAmber.name}"/></td>
			  </tr>
			  <tr>
			    <td>
			    <img src="<c:url value="/images/risk/score_greenlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewGreen" />:</td>
			     <td colspan="3"><c:out value="${template.reviewPeriodGreen.name}"/></td>
			  </tr>
	  </c:when>
	  <c:otherwise>
		  	<tr>
		  <td>
			  	<img src="<c:url value="/images/risk/score_redlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewRed" />:</td>
			    <td colspan="3"><c:out value="${template.reviewPeriodRed.name}"/></td>
			  </tr>
			  <tr>
			    <td>
			    <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewAmber" />:</td>
			     <td colspan="3"><c:out value="${template.reviewPeriodAmber.name}"/></td>
			  </tr>
			  <tr>
			    <td>
			    <img src="<c:url value="/images/risk/score_greenlight.giff" />" />
			    <fmt:message key="template.frequencyOfReviewGreen" />:</td>
			     <td colspan="3"><c:out value="${template.reviewPeriodGreen.name}"/></td>
			  </tr>
	  </c:otherwise>
  </c:choose>
 </c:if> 
  <tr>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td ><fmt:message key="template.advanceDaysToNotify" />:</td>
    <td colspan="3"><c:out value="${template.notifyReviewDaysBefore}"/></td>
  </tr>
  <tr style="${template.multiApproval ? '' : 'display:none'}">
    <td ><fmt:message key="template.riskApprovalTargetDays" />:</td>
    <td colspan="3"><c:out value="${template.riskApprovalTargetDays}"/></td>
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
    <td ><fmt:message key="template.documents" />:</td>
    <td colspan="3"><jsp:include page="../doclink/showLinkedDocs.jsp" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="template.scorable" />:</td>
    <td colspan="3"><fmt:message key="${template.scorable}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="template.scoringModel" />:</td>
    <td colspan="3"><c:out value="${template.scoringModel}"></c:out></td>
  </tr>
  <tr>
    <td ><fmt:message key="template.activeInSite" />:</td>
    <td colspan="3"><fmt:message key="${template.active}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="createdBy" />:</td>
    <td ${template.lastUpdatedByUser != null ? "":"colspan='3'"}><c:out value="${template.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${template.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${template.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${template.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>

  <tfoot>
    <tr>
		<td colspan="4">
			<c:choose>
				<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
				<c:otherwise><fmt:message key="template.title" /> <fmt:message key="notCurrentSelectedSiteMsg" ><fmt:param value="${template.site.name}" /></fmt:message>
				</c:otherwise>
			</c:choose>
		</td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
<div class="header" style="${template.multiApproval ? 'display:none' : 'display:block'}">
<h3> <fmt:message key="template.thresholds" /></h3>
</div>
<div class="content" style="${template.multiApproval ? 'display:none' : 'display:block'}"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
 
<table class="table table-bordered table-responsive">
  <thead>   
    <tr>
      <th><fmt:message key="threshold.createTs" /></th>
      <c:if test="${template.critical}">
      	<th><fmt:message key="threshold.criticalLimit" /></th>
      </c:if>
      <th><fmt:message key="threshold.upperLimit" /></th>
      <th><fmt:message key="threshold.lowerLimit" /></th>
      <c:if test="${template.prefix == 'HSIRR'}">
      	<th><fmt:message key="threshold.hazardUpperLimit" /></th>
      	<th><fmt:message key="threshold.hazardLowerLimit" /></th>
      </c:if>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${template.thresholds}" var="t">
    <tr>
      <td><fmt:formatDate value="${t.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      <c:choose>
	      <c:when test="${template.critical}">
		      <td><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${t.criticalLimit}" /></td>
		      <td><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${t.upperLimit}" /></td>
		      <td><img src="<c:url value="/images/risk/score_yellowlight.giff" />" /><c:out value="${t.lowerLimit}" /></td>
	      </c:when>
	      <c:otherwise>
		      <td><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${t.upperLimit}" /></td>
		      <td><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${t.lowerLimit}" /></td>
	      </c:otherwise>
      </c:choose>
      <c:if test="${template.prefix == 'HSIRR'}">
      	<td><c:if test="${t.hazardUpperLimit != null}"><img src="<c:url value="/images/risk/score_redlight.giff" />" /><c:out value="${t.hazardUpperLimit}" /></c:if></td>
		<td><c:if test="${t.hazardLowerLimit != null}"><img src="<c:url value="/images/risk/score_amberlight.giff" />" /><c:out value="${t.hazardLowerLimit}" /></c:if></td>
      </c:if>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>

<c:forEach items="${template.scoringCategories}" var="c">
<div class="header">
<h3> <c:out value="${c.name}" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
 
<table class="table table-bordered table-responsive">
  <thead>    
    <tr>
      <th><fmt:message key="name" /></th>
      <th><fmt:message key="weight" /></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${c.questions}" var="q">
  	<c:if test="${q.active}">
	    <tr>
	      <td><!--<c:out value="[ID:${q.id}]" />--><c:out value="${q.name}" /></td>
	      <td><c:out value="${q.weight}" /></td>
	    </tr>
	 </c:if>
  </c:forEach>
  </tbody>
  <!-- <tfoot>
    <tr><td colspan="2">Edit Category | Add Question</td>
  </tfoot> -->
</table>
</div>
</div>
</div>
</c:forEach>
</div>

   <jsp:include page="showMatrix.jsp" /> 
</body>
</html>
