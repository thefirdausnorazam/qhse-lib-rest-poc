<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="completeInvestigation" /></title>

</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="completeInvestigation" /></h2> --%>
<!-- </div> -->
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
<div class="panel panel-danger"> 
<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <tr>
    <td class="searchLabel"><fmt:message key="findings" /></td>
    <td class="search"><spring:bind path="findings">
      <textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3"><c:out
        value="${status.value}" /></textarea>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input class="g-btn g-btn--primary" type="submit" value="<fmt:message key="submit" />"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
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
