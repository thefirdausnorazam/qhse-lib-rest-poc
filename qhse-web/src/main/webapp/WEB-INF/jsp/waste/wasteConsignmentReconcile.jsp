<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript">
 jQuery(document).ready(function() {
		
		jQuery('select').not('#siteLocation').select2({width:'400px'});
});
 </script>
</head>
<body>
<div class="header">
<h3><fmt:message key="wasteConsignmentReconcile" /></h3>
</div>
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
  <table class="table table-bordered table-responsive">
    <col  />
    <tbody>

      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="reconcilliationComment" />:</td>
        <td class="search"><scannell:textarea path="reconcilliationComment" cols="75" rows="3" /></td>
      </tr>

      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="reconcilliationCompleted" />:</td>
        <td class="search">
          <select name="reconcilliationSuccessful" class="wide" renderEmptyOption="false" >
            <option value=""><fmt:message key="false" /></option>
            <option value="true"><fmt:message key="true" /> - <fmt:message key="reconcilliationSuccessful" /></option>
            <option value="false"><fmt:message key="true" /> - <fmt:message key="reconcilliationUnsuccessful" /></option>
          </scannell:select>
        </td>
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
