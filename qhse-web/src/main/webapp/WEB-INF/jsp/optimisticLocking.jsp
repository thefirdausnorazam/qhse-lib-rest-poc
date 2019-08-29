<%@ page language="java" isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
  <head>
    <title>Concurrency Error</title>
  </head>

  <body>

    <br>
    <H3>Another user has updated this data, you will need to try again.</H3>
    Please refresh the previous screen and view the modification before trying to save your changes again.

    <% Exception ex = (Exception) request.getAttribute("exception"); %>
    <!-- 
    <h2>System Error: <%= ex.getMessage() %></h2>
    <pre><%ex.printStackTrace(new java.io.PrintWriter(out));%></pre>
     -->

  </body>
</html>
