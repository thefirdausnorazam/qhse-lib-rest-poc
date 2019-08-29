<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="targetCommentForm.title" /></title>
   <script type="text/javascript">
  		jQuery(document).ready(function(){
  		 	  //jQuery('select').select2({width: '40%'});
  		}) 
   </script>
   <style type="text/css">
   .GREEN {
background-color: green;
}
.AMBER {
background-color: orange;
}
.RED {
background-color: red;
}   
   </style>
</head>
<body>
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive">
<tbody>
   <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="action" />:</td>
    <td><a href="<c:url value="viewAction.htm"><c:param name="id" value="${command.parentId}"/></c:url>" ><c:out value="${command.parentId}" /></a></td>
    </td>
  </tr>
   <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="progressComment" />:</td>
    <td colspan="3"><scannell:textarea path="comment" cols="75" rows="3"/>
    <span class="requiredHinted">*</span>
    <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </td>
  </tr>
  
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/incident/viewAction.htm"><c:param name="id" value="${command.parentId}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>

</scannell:form>