<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><fmt:message key="linkSearch" /></title>
</head>
<body>

<select id="unselected" name="unselected" class="wide" multiple="multiple" size="10" onDblClick="moveSelectedOptions(this.form['unselected'],this.form['links'])" >
	<c:forEach items="${result.results}" var="item">
		<option id="<c:out value="link${item.id}" />" value="<c:out value="${item.id}" />"><c:out value="${item.name}" />(<c:out value="${item.url}" />)</option>
	</c:forEach>
</select>

</body>
</html>
