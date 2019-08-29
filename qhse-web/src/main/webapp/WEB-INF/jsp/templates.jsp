<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<style type="text/css" media="all">
    @import "<c:url value='/stylesheets/report.css'/>";
</style>


<title>Report Templates</title>
</head>

<body>

<h1>Reports</h1>

<ul>
  <c:forEach items="${templates}" var="item">
    <li><c:url var="url" value="viewReport.do">
      <c:param name="template" value="${item.name}" />
    </c:url> <a href="<c:out value="${url}"/>"><c:out value="${item.name}" /></a></li>
  </c:forEach>
</ul>

</body>
</html>
