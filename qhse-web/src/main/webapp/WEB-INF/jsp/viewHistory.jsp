<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<fmt:message key="${type}" var="typeDesc" />
<title><fmt:message key="historyTitle" ><fmt:param value="${id}"/><fmt:param value="${typeDesc}"/></fmt:message></title>

<style type="text/css">
.panel-danger > .panel-heading {
color: #FFFFFF !important;
background-color: #00b1ac!important;
border-color: #00b1ac!important;
}
 body {
    padding-top: 10px;
  }
  body > .panel {
    padding-top: 25px!important;
    padding-right: 50px!important;
    padding-bottom: 25px!important;
    padding-left: 50px!important;
  }
    h2 {color: navy;}
    table.viewForm {border-color: navy;}
    table.viewForm thead tr td {border-bottom-color: navy; color: navy; }
    table.viewForm tfoot tr td {color: navy;}
    table.viewForm a{color: navy;}
    div.menuContainer {color: navy;}
    div.menuTitle {background-color: navy;}
    a {color: navy;}
    a:visited {color: navy;}
</style>
<script type="text/javascript">

jQuery(document).ready(function () {
	jQuery(".popup-content+button").hide();
	
});
</script>
</head>
<body>

<div class="content"> 
<div class="table-responsive">
 
 
 
  <h2> <fmt:message key="historyTitle" ><fmt:param value="${id}"/><fmt:param value="${typeDesc}"/></fmt:message></h2>
 


<c:forEach items="${history}" var="item">
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
 
 <div class="panel-heading" style="text-align:center">
   <fmt:message key="updatedBy" /> <c:out value="${item.changedBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.changedTimestamp}" pattern="dd-MMM-yyyy HH:mm" />
 </div>

  <table class="table table-bordered table-responsive">
    <thead>      
      <tr>
        <th><fmt:message key="changedValue" /></th>
        <th><fmt:message key="changedFrom" /></th>
        <th><fmt:message key="changedTo" /></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${item.changedValues}" var="val">
        <spring:message var="from" text="${val.from}" code="${val.from}"  />
        <spring:message var="to" text="${val.to}" code="${val.to}"  />
        <tr >
          	<td width="100px">
          		<c:set var="changeName"><fmt:message key="${val.name}" /></c:set>
	        	<c:choose>
		        	<c:when test="${fn:contains(changeName, '???')}">
			          	<c:out value="${val.name}" />
		    	  	</c:when>
		    	  	<c:otherwise>
		    	  		<c:out value="${changeName}" />
		    	  	</c:otherwise>
	        	</c:choose>
          	</td>
          	<c:if test="${!val.sensitiveDataViewable}">
	          	<td width="350px"><font color="red"><fmt:message key="incident.confidential"/></font></td>
    	      	<td width="350px"><font color="red"><fmt:message key="incident.confidential"/></font></td>
    	  	</c:if>
          	<c:if test="${val.sensitiveDataViewable}">
	          	<td width="350px"><scannell:text value="${from}" /></td>
    	      	<td width="350px"><scannell:text value="${to}" /></td>
    	  	</c:if>    	  
        </tr>
      </c:forEach>
    </tbody>
  </table>
 </div>
 </div>
 </div>
</c:forEach>

</div>
</div>

</body>
</html>
