<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import = "com.scannellsolutions.users.User"
import = "com.scannellsolutions.modules.incident.domain.IncidentRoles"
import = "com.scannellsolutions.modules.action.domain.ActionRoles"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title></title>  
  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>  
  
</head>
<style type="text/css" media="all">
  @import "<c:url value='/css/calendar.css'/>";
  @import "<c:url value='/css/docs.css'/>";
</style>
<body onLoad="dateLoad();">
<div class="header">
<h2><fmt:message key="docsHome" /></h2>
</div>
<div class="content">

</div>
</body>
</html>
