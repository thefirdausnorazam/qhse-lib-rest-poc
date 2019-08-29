<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" %>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title>SCANNELL - Document Links</title>

  <script language="javascript" type="text/javascript"><!--
    // The context path is needed in /js/site.js
    var contextPath = '<%=request.getContextPath()%>';
  //--></script>

  <meta http-equiv="copyright" content="&copy; <%=java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%> Scannell Solutions">
  <meta http-equiv="robots"    content="noindex, nofollow, noarchive">

  <style type="text/css" media="all">
    @import "<c:url value='/css/default.css'/>";
  </style>

  <script type="text/javascript" src="<c:url value="/js/prototype.js" />" ></script>
  <script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>

  <decorator:head />
</head>

<body <decorator:getProperty property="body.onload" writeEntireProperty="true" /> >
<div id="docLinkBody">
  <div id="docLinkHeader">
      <div id="docLinkHeaderTitle"><decorator:title default="" /></div>
  </div>

  <div id="docLinkContent">
    <decorator:body />
  </div>
</div>

</body>
</html>