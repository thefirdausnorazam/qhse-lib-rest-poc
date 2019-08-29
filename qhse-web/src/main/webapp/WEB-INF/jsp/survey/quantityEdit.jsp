<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="users"  value="${users}" scope="session" />
  <c:set var="title" value="quantityEdit" />
  <c:if test="${command['new']}"><c:set var="title" value="quantityCreate" /></c:if>
  <title><fmt:message key="${title}" /></title>
  <script type="text/javascript">
 jQuery(document).ready(function() {		
		jQuery('select').not('#siteLocation').select2({width:'300px'});
});
 </script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<div class="content">
<scannell:form id="theForm">
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<tbody>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="name" />:</td>
    <td class="search"><input name="name" cssStyle="width:300px" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="active" />:</td>
    <td class="search"><scannell:checkbox path="active" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="responsibleUser" />:</td>
    <td colspan="3" class="search">    
    <select name="responsibleUser" items="${users}" itemLabel="sortableName" itemValue="id" class="wide" />
    
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="description" />:</td>
    <td class="search"><scannell:textarea path="description" cols="75" rows="3" /></td>
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
</div>
</body>
</html>
