<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<c:set var="assessment" value="${command.firstAssessment}" />
<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="assessmentStep3.title" /></title>
  <style type="text/css" media="all">
  	@import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
    /* @import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>"; */
  </style>
  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
  <script type="text/javascript">
  <!--
  function checkForSubTables(){
	  var elems = document.getElementsByTagName("div");	  
	  var subTables = new Array();
      for(var i = 0; i < elems.length; i++) {
          var nameProp = elems[i].getAttribute('id');          
          if(!(nameProp == null) && (nameProp.substr(nameProp.length -3, nameProp.length) == 'div')){
        	  subTables.push(elems[i]);
          }
      }
      if (subTables.length > 0) {
    	  var tableId = subTables[0].id.substr(0,subTables[0].id.indexOf('-'));	          
      	  var table = document.getElementById("answers["+tableId+"]");
      	  var numberOfRows = table.firstChild.firstChild.tBodies[0].rows.length;
      	       	          
      	  for(var i = 0; i < numberOfRows; i++) {
    	      var subTableGroup = getSubTablesForRow(subTables, i);
              for(var k = 0; k < subTableGroup.length; k++) {
                  var div = subTableGroup[k];            
          	      //show div
          	      var trparent = getParent("tr", table);
          	      var tbodyparent = getParent("tbody", table);
          	      if(i==0){
          		     var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1);
          		  }else{
          		      var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1 + (i * subTableGroup.length));
          	      }
          	  newTableRow.insertCell(0);
          	  var cell = newTableRow.insertCell(1);     
          	  cell.insertBefore(div,null);      
          	  div.style.display="block";           
  			   }	  
      	  }
      }
  }

 
  <%-- Open the two popup windows for Law and Data --%>
  function init() {
	checkForSubTables();

<%-- Open the two popup windows for Law and Data if the user has the correct licences --%>
<c:set var="assessment" value="${command.firstAssessment}" />
<c:if test="${!assessment.template.scorable}">
<c:forEach items="${licences}" var="item">
  <c:choose>
    <c:when test="${item=='law'}">
      <c:set var="icdKeys" value="${command.icdMasterKeys}" />
      <% if (pageContext.getAttribute("icdKeys")!= null && String.valueOf(pageContext.getAttribute("icdKeys")).trim().length()>0) { %>
          var url ='<c:url value="/legal/front/checklists/RiskRelatedChecklists.jsp" />';
          var params = '?raType=<c:out value="${assessment.template.businessArea.id}" />&icdKeys=<c:out value="${command.icdMasterKeys}" />&pageRisk=true';
          openPopup(url + params, 'risk_legal', 800, 500, 0, 0);
      <% } %>
    </c:when>
    <c:when test="${item=='data'}">
      <c:choose>
        <c:when test="${assessment.template.businessArea.id==1}">
          openPopup('<c:url value="/survey/monitoringProgrammeViewCategories.htm?popup=true&type=env" />', 'risk_data', 500, 500, 0, 810);
        </c:when>
        <c:when test="${assessment.template.businessArea.id==2}">
          openPopup('<c:url value="/survey/monitoringProgrammeViewCategories.htm?popup=true&type=hs" />', 'risk_data', 500, 500, 0, 810);
        </c:when>
      </c:choose>
    </c:when>
  </c:choose>
</c:forEach>
</c:if>
    <fmt:message key="assessmentStep1.saveDataMsg" />
  }

  function openPopup(url, windowName, w, h, x, y) {
    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y;
    var win = window.open(url, windowName, att);
    win.focus();
  }
  
	jQuery(document).ready(function(){
		init();
		
		jQuery("form").submit(function() {
			var submit = jQuery("form input[type=submit]");
			
			submit.prop("disabled", true);
		});
	});
  // -->
  </script>
</head>
<body>
<div class="header">
<h3><fmt:message key="assessmentStep3.title" /></h3>
</div>
<scannell:form>

<ul class="raMenu">
<div class="panel">
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<col  />
<tbody>
  <c:if test="${assessment.id != null}">
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td id="assessmentId">
      <scannell:hidden path="id" writeRequiredHint="false" />
      <scannell:hidden path="version" writeRequiredHint="false" />
      <c:out value="${assessment.displayId}"/>
    </td>

    <td ><fmt:message key="assessment.status" />:</td>
    <td id="assessmentStatus"><fmt:message key="assessment${assessment.status}" /></td>
  </tr>
  </c:if>

  <tr>
    <td ><fmt:message key="businessAreas" />:</td>
    <td valign="top"  id="assessmentBusinessAreas" ${assessment.template.scorable and assessment.template.prefix !='SA' ? "":"colspan='3'"}>
      <c:forEach var="ba" items="${assessment.businessAreas}">
        <c:out value="${ba.name}" />
      </c:forEach>
    </td>
    <c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
    <td  id="assessmentScore"><fmt:message key="assessment.score" />:</td>
    <td valign="top">
      <jsp:include page="showRiskScoreIcon.jsp" /> 
      <c:out value="${assessment.score}" />
    </td>
    </c:if>
  </tr>

  <tr>
    <td ><fmt:message key="assessment.description" />:</td>
    <td colspan="3" id="assessmentName">
      <c:choose>
		  <c:when test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
	      <c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
	  </c:choose>
    </td>
  </tr>

  <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
    <c:if test="${g.active}">
      <c:if test="${g.name != null && g.name != ''}">
      <tr><td colspan="4" class="scoringCategoryTitle"><c:out value="${g.name}"/></td></tr>
      </c:if>
      <c:forEach items="${g.questions}" var="q">
        <c:if test="${q.active and q.visible and q.name !='Name'}">
          <tr>
          <c:choose>
            <c:when test="${q.answerType.name == 'label'}">
              <td colspan="4" class="riskLabel"><c:out value="${q.name}" /></td>
            </c:when>
            <c:otherwise>
              <td >
             <c:choose>
        		<c:when test="${assessment.type eq riskType and q.name == 'Description'}">
        			<fmt:message key="assessment.scope" />:
        		</c:when>
        			<c:otherwise>
        			<c:out value="${q.name}" />:
        		</c:otherwise>
    		 </c:choose>
            	
              	</td>
              <td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
            </c:otherwise>
          </c:choose>
          </tr>
        </c:if>
      </c:forEach>
    </c:if>
  </c:forEach>
  <tr>
    <td ><fmt:message key="assessment.targetReviewDate" /></td>
    <td colspan="3">
    <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="targetReviewDate" id="targetReviewDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
       	<%-- <scannell:input id="targetReviewDate" path="targetReviewDate" readonly="true"/>
     	<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'targetReviewDate', true);"> --%>
     </td>
  </tr> 
  <tr>
    <td ><fmt:message key="assessment.responsibleUser" />:</td>
    <td id="assessmentResponsibleUser"><c:out value="${assessment.responsibleUser.displayName}" /></td>

    <td ><fmt:message key="assessment.otherParticipants" />:</td>
    <td id="assessmentOtherParticipants"><c:out value="${assessment.otherParticipants}" /></td>
  </tr>
  <tr>
    <td colspan="3" ><fmt:message key="assessment.approvalByUser" />:</td>
    <td id="assessmentApprovalByUser"><c:out value="${assessment.approvalByUser.displayName}" /></td>
  </tr>  

  <tr>
  <c:choose>
  <c:when test="${assessment.createdByUser != null}">
    <td ><fmt:message key="createdBy" />:</td>
    <td id="assessmentCreatedBy"><c:out value="${assessment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${assessment.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td id="assessmentLastUpdatedBy"><c:out value="${assessment.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${assessment.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
  <tr>
    <td ><fmt:message key="assessment.approvalComment" />:</td>
    <td colspan="3" id="assessmentApprovalComment"><scannell:textarea path="approvalComment" cols="75" rows="3" /></td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="save&approve" />"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
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
