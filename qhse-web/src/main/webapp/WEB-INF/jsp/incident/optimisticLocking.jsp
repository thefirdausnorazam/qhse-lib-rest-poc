<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>Concurrency error</title>
  </head>
  
  <body>

    <H2>Another user has updated this data. You will need to try again</H2>
    <%
    Exception ex = (Exception) request.getAttribute("exception");
    %>
    <!-- 
    <h2>System Error: <%= ex.getMessage() %></h2>
    <pre><%ex.printStackTrace(new java.io.PrintWriter(out));%></pre>
     -->

  </body>
</html>
