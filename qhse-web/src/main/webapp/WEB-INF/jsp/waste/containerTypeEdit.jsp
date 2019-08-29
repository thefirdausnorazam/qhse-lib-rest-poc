<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="containerTypeEdit" />
<c:if test="${command.id == null}">
  <c:set var="title" value="containerTypeCreate" />
</c:if>
<title></title>
 <script type="text/javascript">
 jQuery(document).ready(function() {	  
	 setNewCategoryVisibility();
	});

 </script>

</head>
<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form>
<div class="content">
<div class="table-responsive">
  <table class="table table-bordered table-responsive">
    <col class="label" />
    <tbody>
    
      <tr class="form-group">
        <td  class="searchLabel"><fmt:message key="name" />:</td>
        <td  class="search"><input name="name" cssStyle="width:30%" /></td>
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
</scannell:form>

</body>
</html>
