<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<script type='text/javascript' src="<c:url value="/dwr/interface/ChangeDWRService.js" />"></script>
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
		ChangeDWRService.associateAssessments(assessmentId1, assessmentId2, function(wasAssociated) {			
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
		ChangeDWRService.unassociateAssessments(assessmentId1, assessmentId2, function(wasAssociated) { 
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
</head>
<body>

<div class="header">
<h2><fmt:message key="changeAssessments" /><!--<fmt:message key="assessmentAssociateForm.title" />--></h2>
</div>
<div class="content">  

<!-- <div class="header"> -->
<%-- <h3><fmt:message key="assessment" /></h3> --%>
<!-- </div> -->
<div class="content">  
<div class="table-responsive">
<div class="panel">

<table id="tbload" class="table table-bordered table-responsive table-hover" >
		<col/>
		<tbody>
			<tr>
				<td><fmt:message key="id" />:</td>
				<td><c:url var="assessmentViewUrl"
						value="/change/changeAssessmentView.htm">
						<c:param name="id" value="${programme.id}" />
					</c:url> <a href="<c:out value="${assessmentViewUrl}" />"><c:out value="${programme.id}" /></a></td>
				<td><fmt:message key="changeProgramme" />:</td>
				<td><c:url var="programmeViewUrl" value="/change/programmeView.htm">
						<c:param name="id" value="${programme.programme.id}" />
					</c:url> <a href="<c:out value="${programmeViewUrl}" />"><c:out value="${programme.programme.name}" /></a></td>
			</tr>
			<tr>
				<td width="150px"><fmt:message
						key="changeAssessment.title" />:</td>
				<td>
				<c:url var="programmeViewUrl" value="/change/changeAssessmentView.htm">
						<c:param name="id" value="${programme.id}" />
					</c:url> <a href="<c:out value="${programmeViewUrl}" />"><c:out value="${programme.name}" />
				</td>
				<td width="150px"><fmt:message
						key="responsibleDepartment" />:</td>
				<td ><c:out value="${programme.department.name}" />
				</td>
			</tr>
						<tr>
				<td  width="150px"><fmt:message
						key="assessment.name" />:</td>
				<td><c:out value="${programme.description}" /></td>
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
     <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/change/changeAssessmentView.htm"><c:param name="id" value="${programme.id}"/></c:url>'">
    </td>
 </tr>
</tfoot>
  </table>
  </div>
  </div>
  </div>
  
<input type="hidden" name="assessmentId" id="assessmentId"	value="<c:out value="${programme.id}" />" />
<div id="message"></div>


<form id="queryForm" action="<c:url value="/risk/assessmentAssociateQueryResult.ajax" />" onSubmit="return search(this, 'resultsDiv');">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber"		value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />
	<input type="hidden" name="id" id="id"		 />
    <input type="hidden" name="name" id="hazardousVal"		 />  
        <input type="hidden" name="templateId" id="templateI"		 /> 
	<!-- The id of the first assessment that is to be associate -->
	<input type="hidden" name="status"			value="COMPLETE" />
 
	<input type="hidden" name="departmentId" id="dptId"		 />  
	<input type="hidden" name="assessmentId" id="assessmentId"	value="<c:out value="${programme.id}" />" />
    <input type="hidden" name="module" id="module"	value="change"/>
	<div id="resultsDiv"></div>
</form>

</body>
</html>
