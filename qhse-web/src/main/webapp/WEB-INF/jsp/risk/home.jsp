<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>RISK <c:if test="${businessArea!=null}"> - <c:out value="${businessArea.name}" /></c:if></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <style type="text/css">
  .enviro {
    color: #999999;
    font-size: 2em;
    font-weight: bold;
  }
  .risk {
    color: #CC3333;
    font-size: 2em;
    font-weight: bold;
  }
  </style>
</head>
<script type="text/javascript">
location.href= "<c:url value="/risk/workspaceQueryForm.htm" />";
</script>
<body><div style="display:none">
  <br />
  <h3 align="center">Welcome to</h3>
  <div align="center"><img src="<c:url value="/images/risk/enviroRISK_Logo_COVER.giff" />" width="454" height="284"></div>

  <br />
  <br />
  <div align="center">
    Please use the navigation on your left to review the <span class="risk">RISK</span> data.
  </div>
</div>
</body>
</html>
