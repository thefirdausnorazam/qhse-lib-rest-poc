<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="docLink.openLinkFileTitle" /></h2>
</div>
<table class="table table-bordered table-responsive">
  
  <tbody>
    <tr><td><fmt:message key="docLink.openLinkFileMessage" /></td></tr>
    <tr><td>${link }</td></tr>
  </tbody>

</table>

</body>
</html>
