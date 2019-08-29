<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<!DOCTYPE html>
<html>
<head>
  <title>
   
  </title>   
  <style type="text/css">
  td.search {
padding-left: 5%!important;
}
  </style>
   <script type="text/javascript">
  jQuery(document).ready(function() {	 
	  jQuery("#achieved").select2({width:'40%'});	  
	  jQuery(".medium").select2({width:'40%'});
	  jQuery('#cal .requiredHinted').remove();
	  jQuery('span:contains(required, required)').filter(function() {
		    return jQuery(this).children().length === 0;  // exclude divs with children
		}).text(function(index, text) {			
		    return text.replace('required, required', 'required');
		});
	  
	  var maxOriginalScore = false;
		jQuery(".targetScore > option").each(function (){
			if('${command.originalScore}' == jQuery(this).text()){
				maxOriginalScore = true;
				return;
			}
			if(maxOriginalScore){
				jQuery(this).remove();
			}
		});
		jQuery(".targetScore").parent().removeClass();
		jQuery(".targetScore").select2({width:'40%'});
  });  
 
  </script>
</head>
<body>
<div class="header">
<h2>
 <c:choose>
      <c:when test="${command.task['class'].name == 'com.scannellsolutions.modules.risk.domain.HazardSubTask'}"><fmt:message key="subTaskCompleteForm.title" /></c:when>
      <c:otherwise><fmt:message key="taskCompleteForm.title" /></c:otherwise>
    </c:choose>

</h2>
</div>
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
<tbody>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${command.task.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="task.status" />:</td>
    <td class="search"><fmt:message key="task.${command.task.status}" /></td>
  </tr>

  <c:if test="${command.task['class'].name == 'com.scannellsolutions.modules.risk.domain.HazardSubTask'}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.parentTask" />:</td>
    <td class="search" colspan="3">
      <c:url var="url" value="/risk/taskView.htm"><c:param name="id" value="${command.task.parentTask.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${command.task.parentTask.displayId}" /></a> -
      <scannell:text value="${command.task.parentTask.name}" />
    </td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.name" />:</td>
    <td class="search" colspan="3"><scannell:text value="${command.task.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3" class="search"><scannell:text value="${command.task.additionalInformation}" /></td>
  </tr>
  
  <c:if test="${command.task.priority != null}">      
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="priority" /></td>
    <td class="search" colspan="3"><fmt:message key="${command.task.priority}" /></td>
  </tr>  
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.creationDate" />:</td>
    <td class="search"><fmt:formatDate value="${command.task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="searchLabel"><fmt:message key="task.targetCompletionDate" />:</td>
    <td class="search"><fmt:formatDate value="${command.task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.responsibleUser" />:</td>
    <td class="search" colspan="3"><c:out value="${command.task.responsibleUser.displayName}" /></td>
  </tr>

  <tr class="form-group">
    <c:if test="${command.task['class'].name != 'com.scannellsolutions.modules.risk.domain.HazardSubTask'}">
    <td class="searchLabel"><fmt:message key="task.managementProgramme" />:</td>
    <td class="search" colspan="3">
      <c:if test="${command.task.managementProgramme != null}">
        <c:url var="url" value="/risk/managementProgrammeView.htm"><c:param name="id" value="${command.task.managementProgramme.id}" /></c:url>
        <a href="<c:out value="${url}" />"><c:out value="${command.task.managementProgramme.displayId}" /></a> -
        <c:out value="${command.task.managementProgramme.name}" />
      </c:if>
    </td>
    </c:if>
  </tr>

	<c:if test="${selectedScoringQuestion != null}">
	 	<tr class="form-group">
	 		<td class="searchLabel"><fmt:message key="task.originalScore" />:</td>
	   		<td class="search" colspan="3"><input name="originalScore" class="form-control" cssStyle="width:40%" id="originalScore" readonly="true" /></td>
	   </tr>
		<tr class="form-group">
			<td class="searchLabel"><fmt:message key="task.targetScore" />:</td>
	    	<td class="search" colspan="3"><input name="targetScore" class="form-control" cssStyle="width:40%"  id="targetScore" readonly="true" /></td>
		</tr>
		<tr class="form-group" >
			<td class="searchLabel" ><fmt:message key="task.actualScore" />:</td>
	   		<td class="search" colspan="3"><enviromanager:question path="answers" class="targetScore" question="${selectedScoringQuestion}" emptyOptionLabel="Choose" multiselectCheckboxes="false" /></td>
	   </tr>
  	</c:if>
 
  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="task.achieved" />:</td>
    <td colspan="3" class="search">
      <select name="achieved" id="achieved" renderEmptyOption="false">
        <scannell:option value="true" label="Yes" />
        <scannell:option value="false" label="No" />
      </scannell:select>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="task.completionDate" />:</td>
    <td class="search" colspan="3">     
      <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                  <scannell:input class="form-control" path="completionDate" id="completionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                    
                  </div>			
                  
                </div>
             <span class="requiredHinted">* </span>
                 
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="task.completionComment" />:</td>
    <td class="search" colspan="3"><scannell:textarea path="completionComment" cols="75" rows="3" /><span class="requiredHinted"> *</span></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search" ${command.task.lastUpdatedByUser != null ? "":"colspan='3'"}>
    	<scannell:text value="${command.task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>

    <c:if test="${command.task.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><scannell:text value="${command.task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/hazardTaskView.htm"><c:param name="id" value="${command.task.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
