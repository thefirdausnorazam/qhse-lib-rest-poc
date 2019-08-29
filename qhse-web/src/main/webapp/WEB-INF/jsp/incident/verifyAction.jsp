<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body>
<div class="header">
<h2><fmt:message key="verifyAction" /></h2>
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
<table class="table table-responsive table-bordered">
    <col  />
<tbody>
  <tr>
    <td ><fmt:message key="successful" /></td>
    <td><spring:bind path="successful">
      <select name="<c:out value="${status.expression}"/>" >
        <option value=""></option>
        <option value="true"><fmt:message key="yes" /></option>
        <option value="false"><fmt:message key="no" /></option>
      </select>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
  </tr>
  <tr>
    <td ><fmt:message key="comment" /></td>
    <td><spring:bind path="comment">
      <textarea name="<c:out value="${status.expression}"/>" cols="50" rows="3"><c:out
        value="${status.value}" /></textarea>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
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
</spring:nestedPath>

</form>

</body>
</html>
