<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ page import="com.scannellsolutions.modules.risk.domain.RiskType" %>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<style type="text/css" media="all">    
    @import "<c:url value='/css/calendar.css'/>";
  </style>
	<script type='text/javascript' src="<c:url value="/dwr/interface/RiskDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		 jQuery("#template").select2();
		 init();
	});
	
	
	
	function myFunction(){				
		var idValue = document.getElementById('idVal').value;			
		var isnum = /^\d+$/.test(idValue);
		if(isnum){
		document.getElementById("id").value = idValue.toString();
		}else if(!isnum && idValue!=''){			
		document.getElementById("id").value = '0000';
		}else{
		document.getElementById("id").value ='';
		}
		var desValue = document.getElementById('desVal').value;
		document.getElementById("hazardousVal").value = desValue.toString();
		
		var e = document.getElementById("template");
		var strUser = e.options[e.selectedIndex].value;		
		document.getElementById("templateI").value = strUser.toString();		
		
	}
	 function clearForm(){
		 jQuery('#idVal').val("");
		 jQuery('#desVal').val("");
		 jQuery("#template").select2('val', '');
	  }
   </script>
	<script type="text/javascript">
	
	function linkDisable(){		
		jQuery("#resultsDiv a").hide();		 	
		jQuery("#sub").hide();		
	}
	
	function linkEnable(){		
		jQuery("#resultsDiv a").show();
		jQuery("#sub").show();
	}
	
	function associate(assessmentId2) {	
		if(assessmentId2){		
		linkDisable();			
		var assessmentId1 = document.getElementById('assessmentId').value; 
		if(assessmentId1){
		RiskDWRService.associateAssessments(assessmentId1, assessmentId2, function(wasAssociated) {			
			associateCallback(assessmentId2, wasAssociated); 				
			linkEnable();
			});		
		}
		}
	}

	function unassociate(assessmentId2) {	
		if(assessmentId2){
		linkDisable();		
		var assessmentId1 = document.getElementById('assessmentId').value; 
		if(assessmentId1){
		RiskDWRService.unassociateAssessments(assessmentId1, assessmentId2, function(wasAssociated) { 
			associateCallback(assessmentId2, wasAssociated); 			
			linkEnable();			
		});
		}
		}
	}
	
	function associateCallback(assessmentId2, wasAssociated) {
		if (wasAssociated) {
			
			var ht = '<a href="#" id="link" disabled="enabled" onclick="unassociate(' + assessmentId2 + ');">UnAssociate</a>'
			 jQuery('#assessment[' + assessmentId2 + '].link').append(ht);
			//location.reload(true);
			search(jQuery('#queryForm'), 'resultsDiv');
			
		} else {
			var htt = '<a href="#" id="link" disabled="enabled" onclick="associate(' + assessmentId2 + ');">Associate</a>'
			 jQuery('#assessment[' + assessmentId2 + '].link').append(htt);
			//location.reload(true);
			search(jQuery('#queryForm'), 'resultsDiv');
		}
	}
	
	function init(){
		search(jQuery('#queryForm'), 'resultsDiv');
	}
	
	
	
	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/risk/riskTemplate-${assessment.template.id}.css'/>";
	</style>
</head>
<body>
<div class="header">
<h2><fmt:message key="assessment" /><!--<fmt:message key="assessmentAssociateForm.title" />--></h2>
</div>
<div class="content">  

<!-- <div class="header"> -->
<%-- <h3><fmt:message key="assessment" /></h3> --%>
<!-- </div> -->
<div class="content">  
<div class="table-responsive">
<div class="panel">

<table id="tbload" class="table table-bordered table-responsive table-hover" >
<c:set var="riskType" value="<%=RiskType.EXPRESS%>" />
<col/>
<tbody>
	<tr>
		<td><fmt:message key="id" />:</td>
		<td>
			<c:url var="assessmentViewUrl" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}" /></c:url>
			<a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${assessment.displayId}" /></a>
		</td>

		<td><fmt:message key="assessment.status" />:</td>
		<td><fmt:message key="assessment${assessment.status}" /></td>
	</tr>

	<tr >
		<td><fmt:message key="businessAreas" />:</td>
		<td valign="top">
			<c:forEach var="ba" items="${assessment.businessAreas}">
				<c:out value="${ba.name}" />
			</c:forEach>
		</td>
		<td>
		<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
		<fmt:message key="assessment.score" />:
		</c:if>
		</td>
		<td valign="top">
			<c:if test="${assessment.template.scorable and assessment.template.prefix !='SA'}">
				<jsp:include page="showRiskScoreIcon.jsp" /> 
				<c:out value="${assessment.score}" />
			</c:if>
		</td>
	</tr>

	<tr>
		<td width="150px">
		
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
	      <c:choose>
			  <c:when test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:when>
		      <c:otherwise><fmt:message key="assessment.confidential"/></c:otherwise>
		  </c:choose>
		</td>
	</tr>

	<tr>
		<td><fmt:message key="assessment.responsibleUser" />:</td>
		<td><c:out value="${assessment.responsibleUser.displayName}" /></td>

		<td><fmt:message key="assessment.otherParticipants" />:</td>
		<td><c:out value="${assessment.otherParticipants}" /></td>
	</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
<div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel">

<table id="queryTable" class="table table-bordered table-responsive table-hover noprint" >
<tbody id="searchCriteria">
<tr class="form-group">
    <td id="templateIdLabel" class="searchLabel"><fmt:message key="assessment.template" />:</td>
    <td colspan="3" class="search">    
    <select id="template" name="templateId" style="width: 305px;">
			<option value="">Choose</option>
            <c:forEach var="templateList" items="${templateList}">
                <option value="${templateList.id}">${templateList.name}</option>
            </c:forEach>
     </select>
      
    </td>
  </tr>
  <tr class="form-group">
    <td id="nameLabel" class="searchLabel"><fmt:message key="id" />:</td>
    <td colspan="3" class="search">
     <input type="text" name="idVal" id="idVal" size="40"  />
    </td>
  </tr>
  <tr class="form-group">
    <td id="nameLabel" class="searchLabel"><fmt:message key="description" />:</td>
    <td colspan="3" class="search">
     <input type="text" name="desVal" id="desVal" size="40"  />
    </td>
  </tr>  
  </tbody>
  <tfoot>
	<tr>
     <td colspan="4" align="center">
     <button type="submit" class="g-btn g-btn--primary" id="sub" onclick="myFunction();search(jQuery('#queryForm'), 'resultsDiv');"><fmt:message key="search" /></button>      
     <button type="button" class="g-btn g-btn--secondary" onClick="clearForm()"><fmt:message key="reset" /></button>
     <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>'">
    </td>
 </tr>
</tfoot>
  </table>
</div>
</div>
</div>
<div id="message"></div>


<form id="queryForm" action="<c:url value="/risk/assessmentAssociateQueryResult.ajax" />" onSubmit="return search(this, 'resultsDiv');">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber"		value="1" />
	<input type="hidden" id="pageSize" name="pageSize"/>
	<input type="hidden" name="id" id="id"		 />
    <input type="hidden" name="name" id="hazardousVal"		 />  
    <input type="hidden" name="templateId" id="templateI"		 />  

	<input type="hidden" name="businessAreaId"	value="<c:out value="${assessment.template.businessArea.id}" />" />
	<!-- The id of the first assessment that is to be associate -->
	<input type="hidden" name="assessmentId" id="assessmentId"	value="<c:out value="${assessment.id}" />" />
	<input type="hidden" name="status"			value="COMPLETE" />

	<div id="resultsDiv"></div>
</form>

</body>
</html>
