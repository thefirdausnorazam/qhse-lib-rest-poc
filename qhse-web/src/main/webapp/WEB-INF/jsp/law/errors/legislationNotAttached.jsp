<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>

<table class="viewForm">
  <col class="label" />
  <thead>
    <tr><td><fmt:message key="legislationNotAttached.title" /></td></tr>
  </thead>

  <tbody>
    <tr><td><fmt:message key="legislationNotAttached.body" /></td></tr>
  </tbody>

  <tfoot>
    <tr><td><a href="javascript:window.history.go(-1);" >Go Back</a></td></tr>
  </tfoot>
</table>

</body>
</html>
