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
		<script type="text/javascript">
<!--
function onPermissionLoad() {
	var option;

	<c:forEach items="${command.viewableSites}" var="item">
		option = document.getElementById('<c:out value="user${item.id}" />');
		if (option) option.selected = true;
	</c:forEach>
	document.getElementById("userRightButton").onclick();

	window.focus();
}

function onFormSubmit() {
	var viewableSites = document.getElementById("viewableSites");

	if(viewableSites.length == 0)
	{
		var currentSiteName = document.getElementById("currentSiteName");
		var currentSiteId = document.getElementById("currentSiteId");
		var option = document.createElement("option");
		option.text = currentSiteName.value;
		option.value = currentSiteId.value;
		viewableSites.add(option);
		viewableSites.options[0].selected = true;
	}
	else
	{
		for (var i = 0; i < viewableSites.length; i++) {
			viewableSites.options[i].selected = true;
		}
	}
}

// -->
		</script>
		<style type="text/css">
select {
	width: 500px;
}
		</style>
	</head>
	<body onload="onPermissionLoad()" background="../appstart/images/scannelApp_BackgroundTile2.gif">
<div style="font-weight: bold; font-size: larger; text-align: center;">To configure sites goto START > Activities > Group Sites</div>

<spring:hasBindErrors name="command">
  <font color="red">Please fix all errors</font>
</spring:hasBindErrors>

<c:set var="defaultSite" value=""/>
<form method="post" name="viewableSitesForm" onsubmit="onFormSubmit();">

	<input type="hidden" name="currentSiteName" id="currentSiteName" value="${currentSite.name}"/>	
	<input type="hidden" name="currentSiteId" id="currentSiteId" value="${currentSite.id}"/>	
<table align="center">
<tr>
	<td align="center"><strong>Unselected</strong></td><td align="center"><strong>Selected</strong></td>
</tr>
<tr>
	<td>
		<select id="sites" name="sites" multiple="multiple" size="30" ondblclick="moveSelectedOptions(this.form['sites'],this.form['viewableSites'])" readonly>
			<c:forEach items="${sites}" var="item">
				<option id="<c:out value="user${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
			</c:forEach>
		</select>
	</td>

	<td>
		<select id="viewableSites" name="viewableSites" multiple="multiple" size="30" ondblclick="moveSelectedOptions(this.form['viewableSites'],this.form['unselected'])" readonly>
			<c:forEach items="${viewableSites}" var="item">
				<option id="<c:out value="user${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
			</c:forEach>
		</select>
	</td>
</tr>
<tr>
	<td align="center" colspan="3">&nbsp;</td>
</tr>
<tr>

</tr>
</table>

</form>

</body>
</html>