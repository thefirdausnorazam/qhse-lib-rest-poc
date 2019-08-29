<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java"%>
<html>
<head>
<!-- excludes are not working when parameters are in the url so using this decorator instead -->
<sitemesh:write property='head'/>
</head>
<body>
<sitemesh:write property='body'/>
</body>
</html>