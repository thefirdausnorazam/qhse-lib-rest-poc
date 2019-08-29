<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<body>
<div class="header">
<h2><fmt:message key="accessDenied.title"/></h2>
</div>
<table class="table table-bordered table-responsive">
  
 

  <tbody>
    <tr><td>
    <% Exception ex = (Exception) request.getAttribute("exception"); %>
      <%= ex.getMessage() %>
    </td></tr>
  </tbody>

  <tfoot>
    <tr><td><a href="javascript:window.history.go(-1);" >Go Back</a></td></tr>
  </tfoot>
</table>

</body>
</html>