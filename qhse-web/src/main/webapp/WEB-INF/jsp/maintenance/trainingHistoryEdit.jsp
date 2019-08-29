<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.errorValidation{
display: none;
margin-left: 10px;
}
.error_show{
padding: 0;
list-style: none;
color: #cc0000;
}
input.invalid, textarea.invalid{
border-color: #c00 !important;
}
		
input.valid, textarea.valid{
border-color: #2598f9;
box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
}
.addon {
background-color:transparent;
border: transparent; 
}
</style>
<title><fmt:message key="maintenance.trainingHistoryAdd.title" /></title>
<script type="text/javascript" src="<scannell:resource value="/js/scannellDateCompare.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/maintenance/scannellFormValidation.js" />"></script>
 
  

<script type="text/javascript">

</script>


</head>
<body >
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="maintenance.trainingHistoryAdd.title" /></h2> --%>
<!-- </div> -->
<div class="content">
<scannell:form id="form" >
<spring:nestedPath path="command">
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="maintenance.trainingHistoryAdd.table.title" /></h3> --%>
<!-- </div> -->

<div class="alert alert-danger hide" id="alrt">
    <a href="#" class="close" data-dismiss="alert">&times;</a>
    <strong>Warning!</strong> Please fix all required fields.
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
    <col  />
<tbody>


  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.trainingHistoryAdd.actualDate" />:</td>
    <td class="search" width="70%">
    <%-- <scannell:input id="actualDate" path="actualDate" readonly="${true}" />
    <img id="serviceDateCalendar" src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
    onclick="return showCalendar(event, 'actualDate', true);">      --%>   
    <div style="width:50%;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:85%;float:left">
                  <scannell:input id="form_actualDate" class="form-control"  path="actualDate" readonly="${true}" cssStyle="width:100%"/>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                    </div>		
                </div> <span class="requiredHinted" style="float:left">* </span>             
                <span id="spanActualDate" class="errorValidation"><fmt:message key="requiredErrorMessage" /></span>
                
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.trainingHistoryAdd.carriedOutBy" />:</td>
     <td class="search"><input name="carriedOutBy" class="form-control" id="form_carriedOutBy" cssStyle="width:50%;float:left"  /> <span class="requiredHinted" style="float:left">* </span>
     <span id="spanCarriedOutBy" class="errorValidation"><fmt:message key="requiredErrorMessage" /></span>
     </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.trainingHistoryAdd.comment" />:</td>
    <td class="search">
     <scannell:textarea id="comment" path="comment" cssStyle="width:50%;" />
    </td>
  </tr>
 
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center">
    	<button type="submit" id="form_submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
    	<button type="button" class="g-btn g-btn--secondary" onclick="javascript:location.href='<c:url value="trainingRecordView.htm"><c:param name="id" value="${command.maintenanceRecordID}"/></c:url>'"><fmt:message key="cancel" /></button>
    	</td>
  </tr>
</tfoot>
</table>
</div>
</div>

</spring:nestedPath>


</scannell:form>
 </div>
</body>
</html>
