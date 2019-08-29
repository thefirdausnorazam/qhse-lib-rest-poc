<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>

</head>
<body>
<div class="header">
<h2><fmt:message key="reopenInvestigation" /></h2>
</div>
<spring:hasBindErrors name="command">
  <div class="errorMessage"><fmt:message key="errors.global" /></div>
  <br />
  <spring:bind path="command">
    <div class="errorMessage"><c:out value="${status.errorMessage}" /></div>
    <br />
  </spring:bind>
</spring:hasBindErrors>

<form method="post">
<spring:nestedPath path="command">
<spring:bind path="id">
      <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>
<spring:bind path="version">
      <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <tr>
    <td colspan="2" align="center">
      <button type="submit" class="g-btn g-btn--primary"><fmt:message key="reopenInvestigation" /></button>
      <button type="button" class="g-btn g-btn--secondary" onclick="javascript:location.href='<c:url value="viewIncident.htm"><c:param name="id" value="${command.id}"/></c:url>'"><fmt:message key="cancel" /></button>
    </td>
  </tr>
</table>
</div>
</div>
</div>
</spring:nestedPath>
</form>

</body>
</html>
