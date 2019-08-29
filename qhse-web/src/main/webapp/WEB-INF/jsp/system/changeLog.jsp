<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@ page import="java.io.FileInputStream" %>

<html>
<HEAD>
 <!-- <TITLE>Scannell enviroMANAGER Change Log</TITLE>  -->

</HEAD>
<body>
<div class="header">
<h2>Q-Pulse Change Log</h2>
</div>
	<!-- <h1>enviroMANAGER Change Log</h1> -->
	
	<div class="container">
	<pre><%
   String file = application.getRealPath("/") + "/WEB-INF/changeList.txt";
   BufferedReader reader = new BufferedReader(new FileReader(file));
   //BufferedReader br = new InputStreamReader(new FileInputStream(txtFilePath));
   StringBuilder sb = new StringBuilder();
   String line;

   while((line = reader.readLine())!= null){
       sb.append(line+"\n");
   }
   out.println(sb.toString());
           
        %></pre>
</div>

</body>
</html>