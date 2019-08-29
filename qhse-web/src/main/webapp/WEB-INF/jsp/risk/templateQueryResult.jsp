<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@page import="com.scannellsolutions.site.SiteUtils"%>
<%@ page language="java" import = "com.scannellsolutions.site.Site" %>

<!DOCTYPE html>
<html>
<head>
  <title></title>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
</head>
<body>
    <%
      Site site = SiteUtils.currentSite();
    %>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="templateQueryResult.title" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel  panel-danger" > 
    <c:if test="${found}">
         <div class="div-for-pagination"><scannell:paging result="${result}" /></div> 
    </c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="template.name" /></th>
      <th><fmt:message key="template.prefix" /></th>
      <th><fmt:message key="template.active" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${result.results}" var="template" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><a href="<c:url value="/risk/templateView.htm"><c:param name="id" value="${template.id}"/></c:url>" ><c:out value="${template.id}" /></a></td>
      <td><c:out value="${template.name}" /></td>
      <td><c:out value="${template.prefix}" /></td>
      <td><fmt:message key="${template.active}" /></td>
    </tr>
    </c:forEach>
   </tbody>
   <tfoot>
    <c:if test="${found}">
    <tr>
      <td colspan="4"><scannell:paging result="${result}" /></td>
    </tr>
    </c:if>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
