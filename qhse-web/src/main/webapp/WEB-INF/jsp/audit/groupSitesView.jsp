<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Sites Grouped</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

		<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
	</head>
	<body background="../appstart/images/scannelApp_BackgroundTile2.gif">
<div style="font-weight: bold; font-size: larger; text-align: center;">To configure sites goto START > Activities > Group Sites</div>

<spring:hasBindErrors name="command">
  <font color="red">Please fix all errors</font>
</spring:hasBindErrors>

<c:set var="defaultSite" value=""/>	
<table align="center">
<tr>
	<td align="center"><strong>Unselected</strong></td><td align="center"><strong>Selected</strong></td>
</tr>
<tr>
	<td>
		<textarea style="width:450px; height:500px;text-align: left;" readonly><c:forEach items="${sites}" var="item">${item.name}&#13;&#10;</c:forEach></textarea>
	</td>

	<td>
		<textarea style="width:450px; height:500px;text-align: left;" readonly><c:forEach items="${viewableSites}" var="item"><c:out value="${item.name}" />&#13;&#10;</c:forEach></textarea>
	</td>
</tr>
<tr>
	<td align="center" colspan="3">&nbsp;</td>
</tr>
<tr>

</tr>
</table>

</body>
</html>