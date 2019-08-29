<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>

<body>
<div class="header nowrap">
<h2><fmt:message key="doccontrol.editDocumentRecords" /></h2>
</div>
<div class="content">  
<scannell:form enctype="multipart/form-data">
<input type="hidden" name="sourcePage" id="sourcePage">
<div class="header">
<h3> <fmt:message key="doccontrol.records" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">


<table class="table table-bordered table-responsive">
<thead>  
  <tr>
	<th><fmt:message key="name" /></th>
	<th><fmt:message key="addedBy" /></th>
	<th><fmt:message key="createdDate" /></th>
	<th><fmt:message key="updatedDate" /></th>
	<th><fmt:message key="description" /></th>
	<th><fmt:message key="active" /></th>	
  </tr>  
</thead>
<tbody>
	
  <c:forEach items="${document.records}" var="item">
  
  <tr>
    <td>
      <a href="<c:url value="documentRecordEdit.htm"><c:param name="itemId" value="${item.id}" /><c:param name="showId" value="${document.id}" /></c:url>"><c:out value="${item.name}" /></a>
                
      <br /> </td>
      <td>
      	<c:out value="${item.createdByUser.displayName}" /><br /> </td>
      <td>
       	<fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /> </td>
      <td>
       	<fmt:formatDate value="${item.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /> </td>
      <td>
      	<scannell:text value="${item.description}" htmlEscape="false" /></td>   
      <td><fmt:message key="${item.active}" /></td>    
	      
  </tr>
  
  </c:forEach>
</tbody>
  <tfoot>
  <tr>
    <td colspan="6">
     <c:if test="${document.editable}">
        <a href="<c:url value="documentRecordEdit.htm"><c:param name="showId" value="${document.id}"/></c:url>">
          <fmt:message key="doccontrol.addRecord" /></a>
       </c:if>
     </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</div>
</body>
</html>
