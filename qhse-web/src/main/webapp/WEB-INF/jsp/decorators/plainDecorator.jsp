<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" %>

<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<html>
<head>
  <%@include file="headNew.jspf" %>
  <sitemesh:write property='head'/>
</head>
 
<body>
 
  <h2 align="center"><decorator:title default="" /></h2>
  <div class="printable"><fmt:message key="confidential" /></div>
  <sitemesh:write property='body'/>
  <%-- <div class="printable"><fmt:message key="confidential" /></div>   --%>
  <div style="height: 30px;">&nbsp;</div>

</body>
</html>