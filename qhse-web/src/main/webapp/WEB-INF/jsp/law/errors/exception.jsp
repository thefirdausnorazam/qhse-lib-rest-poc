<%@ page language="java"  errorPage="true" %>
<%response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);%>
<html>
  <head>
    <title>Internal Error</title>
  </head>
  <body>
    <p>
      <% Exception ex = (Exception) request.getAttribute("exception"); %>
      <h2>System Error: <%= ex.getMessage() %></h2>
      <pre><%ex.printStackTrace(new java.io.PrintWriter(out));%></pre>
    </p>
  </body>
</html>
