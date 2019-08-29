<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title></title>
  </head>
  
  <body>
   <%
    Exception ex = (Exception) request.getAttribute("exception");
    %>
   <br/>
   <H2><%=ex.getMessage() %></H2>
   <br/>

  </body>
</html>
