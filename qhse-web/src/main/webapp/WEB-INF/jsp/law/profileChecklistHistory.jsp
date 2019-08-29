<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="profileChecklistHistory.shortTitle" ></fmt:message></title>

<style type="text/css">
    h2 {color: navy;}
    table.viewForm {border-color: navy;}
    table.viewForm thead tr td {border-bottom-color: navy; color: navy; }
    table.viewForm tfoot tr td {color: navy;}
    table.viewForm a{color: navy;}
    div.menuContainer {color: navy;}
    div.menuTitle {background-color: navy;}
    a {color: navy;}
    a:visited {color: navy;}
</style>

</head>
<body>
<c:choose >
<c:when test="${profileChecklist != null}">
<br>
<h3><fmt:message key="profileChecklistHistory.longTitle" ><fmt:param value="${profileChecklist.checklistId}"/><fmt:param value="${profile.name}"/></fmt:message></h3>

<h3><fmt:message key="profileChecklistHistory.originallyEntered" ><fmt:param value="${profileChecklist.createdByUser.displayName}"/><fmt:param value="${profileChecklist.createdTs}"/></fmt:message></h3>

<c:forEach items="${changeHistory}" var="item">
  <table class="table table-bordered table-responsive">
    <thead>
      <tr class="form-group">
        <td colspan="4" class="scannellGeneralLabel"><fmt:message key="updatedBy" /> <c:out value="${item.changedBy.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.changedTimestamp}" pattern="dd-MMM-yyyy HH:mm" /></td>
      </tr>
      <tr class="form-group">
        <th><fmt:message key="changedValue" /></th>
        <th><fmt:message key="changedFrom" /></th>
        <th><fmt:message key="changedTo" /></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${item.changedValues}" var="val">
        <spring:message var="from" text="${val.from}" code="${val.from}"  />
        <spring:message var="to" text="${val.to}" code="${val.to}"  />
        <tr class="form-group">
          <td width="100px"><fmt:message key="${val.name}" /></td>
          <c:if test="${!val.sensitiveDataViewable}">
            <td width="350px">Confidential</td>
            <td width="350px">Confidential</td>
        </c:if>
          <c:if test="${val.sensitiveDataViewable}">
            <td width="350px"><scannell:text value="${from}" /></td>
            <td width="350px"><scannell:text value="${to}" /></td>
        </c:if>       
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:forEach>
</c:when>
<c:otherwise>
	<br>
<h2></h2>

<h3></h3>
	<table class="table table-bordered table-responsive">
    <thead>
      <tr class="form-group">
        <th><fmt:message key="changedValue" /></th>
        <th><fmt:message key="changedFrom" /></th>
        <th><fmt:message key="changedTo" /></th>
      </tr>
    </thead>
  </table>
</c:otherwise>
</c:choose>

</body>
</html>
