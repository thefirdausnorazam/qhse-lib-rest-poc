<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
  <col class="label" />
  <thead>
    <tr><td><fmt:message key="accessDenied.title" /></td></tr>
  </thead>

  <tbody>
    <tr><td><fmt:message key="accessDenied.body" /></td></tr>
  </tbody>

  <tfoot>
    <tr><td><a href="javascript:window.history.go(-1);" >Go Back</a></td></tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
