<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="closeIncident" /></title>

<script type="text/javascript">
jQuery(document).ready(function() {

	jQuery('#cancelButton').click(function() {
    location.href = '<c:url value="viewIncident.htm"><c:param name="id" value="${incident.id}"/></c:url>';
    return false;
  });
});
  
</script>

</head>
<body>

<scannell:form>
<spring:nestedPath path="command">
<scannell:hidden path="id" />
<scannell:hidden path="version" />

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
  <tr>
    <td colspan="2" ><fmt:message key="closeIncidentConfirm" /></td>
  </tr>
</thead>
<tbody>
  <tr>
    <td><fmt:message key="id" /></td>
    <td><c:out value="${incident.id}"/> <c:if test="${incident.confidential}"> <font color="red"><c:out value="CONFIDENTIAL"/></font></c:if></td>
  </tr>

  <tr>
    <td><fmt:message key="type" /></td>
    <td><fmt:message key="${incident.type.type.key}" />  <c:out value="${incident.type.name}" /></td>
  </tr>

  <tr>
    <td><fmt:message key="description" /></td>
    <td><c:out value="${incident.description}" /></td>
  </tr>
    <tr>
    <td><fmt:message key="closingComment" /></td>
    <td><spring:bind path="closingComment">
      <textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3"><c:out
        value="${status.value}" /></textarea>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
  </tr>

</tbody>

<tfoot>
  <tr>
    <td colspan="2" align="center">
      <input type="submit" value="<fmt:message key="closeIncident" />" class="g-btn g-btn--primary">
      <input id="cancelButton" type="submit" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" >
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</spring:nestedPath>
</scannell:form>

</body>
</html>
