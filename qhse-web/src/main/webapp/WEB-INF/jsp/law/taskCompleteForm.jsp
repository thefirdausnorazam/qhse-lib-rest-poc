<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>
     <fmt:message key="taskCompleteForm.title" />
  </title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
    <script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('select').select2({width:'200px'});
		jQuery('#cal .requiredHinted').remove();
		 jQuery('.datetime').datepicker({autoclose: true,clearBtn:true});
	});
	
	function disableButtonAfterClick(){
		jQuery('#bt-complete').prop('disabled', true);
	}
	</script>
</head>
<body>

<scannell:form onsubmit="disableButtonAfterClick()">
<table class="table table-bordered table-responsive" style="width:100%;border-top:1px solid #DADADA;">
<tbody>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${task.displayId}" />
    </td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="${task.status}" /></td>
  </tr>
 
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
	 	<ul>
      		<c:forEach var="ba" items="${task.businessAreas}">
        		<li><c:out value="${ba.name}" /></li>
      		</c:forEach>
	    </ul>
	</td>
  </tr>
  
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>
  
  <c:if test="${task.priority != null}">      
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="priority" /></td>
    <td><fmt:message key="${task.priority}" /></td>
    <td></td>
    <td></td>
  </tr>  
  </c:if>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.achieved" />:</td>
    <td colspan="3">
      <select name="achieved" renderEmptyOption="false">
        <scannell:option value="true" label="Yes" />
        <scannell:option value="false" label="No" />
      </scannell:select>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completionDate" />:</td>
    <td colspan="3">
<%--       <input name="completionDate" id="completionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionDate', true);"> --%>
      
		<div id="cal" style="width:250px;">
           <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
           <scannell:input class="form-control" path="completionDate" id="completionDate" readonly="true"  />
             <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
           </div>			
         </div>
         <span class="requiredHinted">*</span>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:textarea path="completionComment" cols="75" rows="4" class="form-control" cssStyle="width:40%"/></td>
  </tr>
	
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="createdBy" />:</td>
    <td><scannell:text value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    <c:if test="${task.lastUpdatedByUser == null}">
    <td></td>
    <td></td>
    </c:if>
    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
    <td>
    <scannell:text value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" id="bt-complete" value="<fmt:message key="submit" />" class="g-btn g-btn--primary">
    </td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
