<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <%-- <title><fmt:message key="reviewQueryForm.title" /></title>   --%>  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
  </style>
  <script type="text/javascript">
  jQuery(document).ready(function(){
	  jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
	  jQuery(window).bind('load', init);
	  displayQueryDiv(false);
  });
  
  function init() {
	  jQuery("#queryForm").submit();
	  copyFormValuesIfPopup('queryForm');		  
	  jQuery("select").select2();	  
  }
  </script>
</head>
<body>
<div class="content">  
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<div class="header">
<h2><fmt:message key="reviewQueryForm.title" /></h2>
</div>
 <div class="content">
 <div class="header">
 <h3><fmt:message key="assessment" /></h3>
 </div>
 </div>
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive" style="margin-top:0px;">
<col  />
<tbody>
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td>
    <c:choose>
        	<c:when test="${assessment.type eq riskType}">
        		<c:url var="assessmentURL" value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${assessment.id}"/></c:url>
        	</c:when>
        	<c:otherwise>
        		<c:url var="assessmentURL" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
        	</c:otherwise>
     </c:choose>
     <a href="<c:out value="${assessmentURL}" />"><c:out value="${assessment.displayId}" /></a>
    </td>
    <td ><fmt:message key="assessment.status" />:</td>
    <td><fmt:message key="assessment${assessment.status}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="businessAreas" />:</td>
    <td valign="top">
      <ul>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
    <c:choose>
    <c:when  test="${assessment.template.scorable}">	
    <td ><fmt:message key="assessment.score" />:</td>
    <td valign="top">

      <jsp:include page="showRiskScoreIcon.jsp" /> 
      <c:out value="${assessment.score}" />
    </td>
   </c:when>
   <c:otherwise>
        		<td colspan=2></td>
        	</c:otherwise>
     </c:choose>
  </tr>

  <tr>
    <td  width="150px">
     <c:choose>
        	<c:when test="${assessment.type eq riskType}">
        		<fmt:message key="assessment.scope" />:
        	</c:when>
        	<c:otherwise>
        		<fmt:message key="assessment.name" />:
        	</c:otherwise>
     </c:choose>
    
    </td>
    <td colspan="3">
      <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  <c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
    </td>
  </tr>

  <tr>
    <td ><fmt:message key="assessment.responsibleUser" />:</td>
    <td><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td ><fmt:message key="assessment.otherParticipants" />:</td>
    <td><c:out value="${assessment.otherParticipants}" /></td>
  </tr>
</tbody>
</table>
</div>
</div>
</div>

 <div style="text-align:left;">
  <a href="#" id="queryTableToggleLink" class="g-btn g-btn--primary" onclick="toggleQueryDiv();">Display Search Criteria</a> 
<c:if test="${addButtonEnabled == true }">
	<button type="button" class="g-btn g-btn--primary" onclick="location.href='reviewAdd.htm?assessmentId=${assessment.id}'">
		<i class="fa fa-edit" style="color: white"></i>&nbsp;Add Review 
	</button>
</c:if>
  </div>

<div class="content">
<scannell:form id="queryForm" action="/risk/reviewQueryResult.htmf" onsubmit="return search(this, 'resultsDiv');">
<div id="queryDiv">
<div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
	<scannell:hidden path="calculateTotals" />
  <scannell:hidden path="pageNumber" />
  <scannell:hidden path="pageSize" />
  <scannell:hidden path="assessmentId" />


                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="review.comment" /></label>
									<div class="col-sm-6">
									<scannell:textarea path="comment" id="comment" cssStyle="width:100%;" />
									</div>
								</div>							
								 
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                       <scannell:input class="form-control" id="startDateFrom"  cssStyle="size:16;" path="startDateFrom"  readonly="true"/>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
                                         <scannell:input class="form-control" cssStyle="size:16;" path="startDateTo" id="startDateTo" readonly="true" />
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">
										 <select name="sortName" id="sortName" items="${sortList}" lookupItemLabel="true" renderEmptyOption="true" cssStyle="width:100%;" />
									</div>
								</div>
								
								

                              <div class="spacer2 text-center">
			                     <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;"><fmt:message key="search" /></button>
                                 <button type="reset" class="g-btn g-btn--secondary"><fmt:message key="reset" /></button>
			                  </div>
     


</div>

<div id="resultsDiv"></div>

</scannell:form>
</div>


</div>
</body>
</html>
