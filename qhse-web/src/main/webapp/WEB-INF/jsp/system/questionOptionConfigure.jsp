<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags" %>


<html>
<head>
  <title></title>

</head>
<body>
<div class="header">
<h2><fmt:message key="questionOptionConfigure"/></h2>
</div>
<scannell:form>
  <scannell:hidden path="id"/>
  <scannell:hidden path="version"/>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
   
    <tbody>

    <tr>
      <td><fmt:message key="question"/>:</td>
      <td><c:out value="${command.option.question.name}"/></td>
    </tr>

    <tr>
      <td><fmt:message key="name"/>:</td>
      <td><c:out value="${command.option.name}"/></td>
    </tr>

    <tr>
      <td><fmt:message key="site"/>:</td>
      <td>
        <spring:bind path="command.activeSitesIds">
          <c:forEach items="${sites}" var="site">
            <c:set var="selected" value="${false}"/>
            <c:forEach items="${command.activeSitesIds}" var="selectedSiteId">
              <c:if test="${site.id == selectedSiteId}"><c:set var="selected" value="${true}"/></c:if>
            </c:forEach>
            <input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />"
                   <c:if test="${selected}">checked="checked"</c:if> />
            <span><c:out value="${site.name}"/></span><br/>
          </c:forEach>
          <scannell:errors path="activeSitesIds"/>
        </spring:bind>
      </td>
    </tr>
    </tbody>
    <tfoot>
    <tr>
      <td colspan="3" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
    </tr>
    </tfoot>
  </table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
