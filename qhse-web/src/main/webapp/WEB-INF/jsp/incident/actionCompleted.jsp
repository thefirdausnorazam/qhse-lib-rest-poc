<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title></title>
  </head>
  
  <body>
   <%
    Exception ex = (Exception) request.getAttribute("exception");
    %>
    <H2>Action already completed by <%=ex.getMessage() %> </H2>    
    <!-- 
    <h2>System Error: <%= ex.getMessage() %></h2>
    <pre><%ex.printStackTrace(new java.io.PrintWriter(out));%></pre>
     -->

  </body>
</html>
