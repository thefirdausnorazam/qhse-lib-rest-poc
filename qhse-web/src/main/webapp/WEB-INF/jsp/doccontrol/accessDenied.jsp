<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="accessDenied.title" /></h2>
</div>
<table class="table table-bordered table-responsive">
  
  

  <tbody>
       <%
    Exception ex = (Exception) request.getAttribute("exception");
    %>
    <tr><td><H2><fmt:message key="<%=ex.getMessage() %>"/> </H2> </td></tr>
  </tbody>

  <tfoot>
    <tr><td><a href="javascript:window.history.go(-1);" ><fmt:message key="general.goBack" /></a></td></tr>
  </tfoot>
</table>

</body>
</html>
