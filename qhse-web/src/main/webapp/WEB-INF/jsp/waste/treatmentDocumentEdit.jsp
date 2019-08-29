<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="wasteTreatmentDocumentEdit" />
<c:if test="${TreatmentDocument.id == 0}">
  <c:set var="title" value="wasteTreatmentDocumentCreate" />
</c:if>
<title></title>
<script type="text/javascript">
 jQuery(document).ready(function() {		
		jQuery('select').not('#siteLocation').not('#weightUnit').select2({width:'400px'});
		jQuery('#weightUnit').select2({width:'250px'});
		
		
		if('${command.disposalLocation}' != '') {
			if('${command.receivedDate}' == '') {
				jQuery('#requiredReceivedDate').text('* required');
			}
			if('${command.actionDate}' == '') {
				jQuery('#requiredActionDate').text('* required');
			}
		}
});
 </script>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>

<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form >
  <scannell:hidden path="id" />
  <scannell:hidden path="version" />
  <input type="hidden" id="itemsSize" name="itemsSize" value="" />
<div class="content"> 
<div class="table-responsive">
<div class="panel">
  <table class="table table-bordered table-responsive">
    <col  />
    <tbody>

      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="shipmentDocument" /></td>
        <td class="search"><select name="shipmentDocument" items="${shipmentDocuments}" itemLabel="description" itemValue="id" emptyOptionValue="0" class="wide" /></td>
      </tr>

      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="disposalLocation" />:</td>
        <td class="search"><input name="disposalLocation" cssStyle="width:400px;" /></td>
      </tr>
      
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="treatmentType" />:</td>
        <td class="search"><scannell:select items="${treatmentTypes}" id="treatmentType" path="treatmentType" itemValue="id" class="wide" /></td>
      </tr>
   
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="wasteTreatmentDocument.receivedDate" />:</td>
        <td class="search">
          <%-- <scannell:input id="receivedDate" path="receivedDate" readonly="${true}" /> 
          <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'receivedDate', true);" />  --%>
          <div style="width:300px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px; float:left">
                    <input class="form-control" id="receivedDate" name="receivedDate" size="6" type="text" value="<fmt:formatDate type="date" value="${command.receivedDate}" pattern="dd-MMM-yyyy" />" readonly pattern="dd-MM-yyyy" >
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                   
                  </div>	<span id="requiredReceivedDate" class="requiredHinted" style="float:left">*</span>				
                </div>
        </td>
      </tr>
   
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="disposalDate" />:</td>
        <td class="search">
          <%-- <scannell:input id="actionDate" path="actionDate" readonly="${true}" /> 
          <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'actionDate', true);">  --%>
          <div style="width:300px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px; float:left">
                    <input class="form-control" id="actionDate" name="actionDate" size="6" type="text" value="<fmt:formatDate type="date" value="${command.actionDate}" pattern="dd-MMM-yyyy" />" readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                  <span id="requiredActionDate" class="requiredHinted" style="float:left">*</span>					
                </div>
        </td>
      </tr>
      
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="weight" />:</td>
        <td class="search"><input name="weightAmount" class="narrow"/> <scannell:select items="${units}" id="weightUnit" path="weightUnit" itemValue="id" itemLabel="name" class="medium" /> <scannell:errors path="weight"/></td>
      </tr>

      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="comment" /></td>
        <td class="search"><scannell:textarea path="comment" cols="75" rows="3" /></td>
      </tr>
    </tbody>

    <tfoot>
      <tr>
        <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
      </tr>
    </tfoot>

  </table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
