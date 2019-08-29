<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="editIncidentSubType" />
<c:if test="${command['new']}"><c:set var="title" value="addIncidentSubType" /></c:if>
<title><fmt:message key="${title}" /></title>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
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
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
    <col/>
<tbody>
<spring:nestedPath path="command">
  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="name" /></td>
    <td class="search">
      <spring:bind path="name">
        <input type="text" class="form-control" style="float:left;width:80%" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}" />" maxlength="250" />
	    <span class="requiredHinted">*</span>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
      <spring:bind path="id">
        <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
      <spring:bind path="version">
        <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="active" /></td>
    <td class="search">
      <spring:bind path="active">
      <input type="hidden" name="<c:out value="_${status.expression}"/>" />
      <input type="checkbox" name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
  </tr>
</spring:nestedPath>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
    
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</form>

</body>
</html>
