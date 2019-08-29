<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>

<title><fmt:message key="maintenance.ppeServiceAdd.title" /></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
   @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body >
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="maintenance.ppeServiceAdd.title" /></h2> --%>
<!-- </div> -->
<div class="content">
<scannell:form>
<spring:nestedPath path="command">
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="maintenance.ppeServiceAdd.table.title" /></h3> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
    <col  />
<tbody>
 

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.ppeServiceAdd.actualDate" />:</td>
    <%-- <td>
    <scannell:input id="actualDate" path="actualDate" readonly="${true}" />
    <img id="serviceDateCalendar" src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
    onclick="return showCalendar(event, 'actualDate', true);">        
    </td> --%>
    <td class="search">
		
		<div style="width:350px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                   <input class="form-control" id="actualDate" name="actualDate" size="6" type="text"  readonly>
                   <%--  <scannell:input class="form-control" id="actualDate"  cssStyle="width:200px;" path="actualDate"  readonly="true"/> --%>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
                
               </td>
       
  </tr>
	<tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.ppeServiceAdd.carriedOutBy" />:</td>
     <td class="search"><input name="carriedOutBy" class="wide" /></td>
  </tr>
  
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.ppeServiceAdd.receivedAndUnderstood" />:</td>    
      <td class="search">
      <spring:bind path="receivedAndUnderstood">
        <input type="hidden" name="<c:out value="_${status.expression}"/>" />
        <input type="checkbox" name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="maintenance.ppeServiceAdd.comment" />:</td>
    <td class="search">
     <scannell:textarea id="comment" path="comment" cssStyle="width:50%" />
    </td>
  </tr>
 
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center">
    	<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
    	<button type="button" class="g-btn g-btn--secondary" onclick="javascript:location.href='<c:url value="ppeRecordView.htm"><c:param name="id" value="${command.maintenanceRecordID}"/></c:url>'"><fmt:message key="cancel" /></button>
    	</td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</spring:nestedPath>


</scannell:form>
 </div>
</body>
</html>
