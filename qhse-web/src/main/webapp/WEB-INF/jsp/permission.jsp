<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Permissions</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

		<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
		<script type="text/javascript">
<!--

function onPermissionLoad() {
	var option;

	<c:forEach items="${command.authorisedUserIds}" var="item">
		option = document.getElementById('<c:out value="user${item}" />');
		if (option) option.selected = true;
	</c:forEach>
	document.getElementById("userRightButton").onclick();

	<c:forEach items="${command.authorisedGroupIds}" var="item">
		option = document.getElementById('<c:out value="group${item}" />');
		if (option) option.selected = true;
	</c:forEach>
	document.getElementById("groupRightButton").onclick();

	window.focus();
}

function onPermissionSubmit() {
	var authorisedUsers = document.getElementById("authorisedUsers");
	for (var i = 0; i < authorisedUsers.length; i++) {
		authorisedUsers.options[i].selected = true;
	}

	var authorisedGroups = document.getElementById("authorisedGroups");
	for (var i = 0; i < authorisedGroups.length; i++) {
		authorisedGroups.options[i].selected = true;
	}
}

// -->
		</script>
		<style type="text/css">
select {
	width: 200px;
}
		</style>
	</head>

	<body onload="onPermissionLoad()" background="../appstart/images/scannelApp_BackgroundTile2.gif">

<div style="font-weight: bold; font-size: larger; text-align: center;">Select Users and/or Groups who are allowed to view this page</div>
<div style="color: red; text-align: center; font-weight: bold">[If no Users or Groups are selected then all Users will have access]</div>

<spring:hasBindErrors name="command">
  <font color="red">Please fix all errors</font>
</spring:hasBindErrors>


<form method="post" name="permissionForm" onsubmit="onPermissionSubmit();">
	<input name="id" type="hidden" value="<c:out value="${command.id}"/>" />
	<input name="version" type="hidden" value="<c:out value="${command.version}"/>" />
<table>
<tr>
	<td align="center" colspan="3"><strong>Select Users</strong></td>
</tr>
<tr>
	<td>
		<select id="unauthorisedUsers" name="unauthorisedUsers" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedUsers'],this.form['authorisedUsers'])" >
			<c:forEach items="${users}" var="item">
				<option id="<c:out value="user${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.sortableName}" /></option>
			</c:forEach>
		</select>
	</td>
	<td align="center">
		<input type="button" name="right" value="&gt;&gt;"     onclick="moveSelectedOptions(this.form['unauthorisedUsers'],this.form['authorisedUsers'])" id="userRightButton" /><br /> <br />
		<input type="button" name="right" value="all &gt;&gt;" onclick="moveAllOptions(this.form['unauthorisedUsers'],this.form['authorisedUsers'])" /><br /><br />
		<input type="button" name="left"  value="&lt;&lt;"     onclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unauthorisedUsers'])" /><br /><br />
		<input type="button" name="left"  value="all &lt;&lt;" onclick="moveAllOptions(this.form['authorisedUsers'],this.form['unauthorisedUsers'])" />
	</td>

	<td>
		<select id="authorisedUsers" name="authorisedUsers" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unselected'])" >
		</select>
	</td>
</tr>

<tr>
	<td align="center" colspan="3"><strong>Select Groups</strong></td>
</tr>

<tr>
	<td>
		<select id="unauthorisedGroups" name="unauthorisedGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" >
			<c:forEach items="${groups}" var="item">
				<option id="<c:out value="group${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
			</c:forEach>
		</select>
	</td>
	<td align="center">
		<input type="button" name="right" value="&gt;&gt;"     onclick="moveSelectedOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" id="groupRightButton" /><br /><br />
		<input type="button" name="right" value="all &gt;&gt;" onclick="moveAllOptions(this.form['unauthorisedGroups'],this.form['authorisedGroups'])" /><br /><br />
		<input type="button" name="left"  value="&lt;&lt;"     onclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])" /><br /><br />
		<input type="button" name="left"  value="all &lt;&lt;" onclick="moveAllOptions(this.form['authorisedGroups'],this.form['unauthorisedGroups'])" />
	</td>
	<td>
		<select id="authorisedGroups" name="authorisedGroups" multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['authorisedGroups'],this.form['unselected'])" >
		</select>
	</td>
</tr>

<tr>
	<td align="center" colspan="3">
		<button type="submit" >&nbsp;Ok&nbsp;</button> &nbsp;&nbsp;
		<button type="button" onclick="window.close()"><fmt:message key="cancel" /></button>
	</td>
</tr>
</table>

</form>

</body>
</html>