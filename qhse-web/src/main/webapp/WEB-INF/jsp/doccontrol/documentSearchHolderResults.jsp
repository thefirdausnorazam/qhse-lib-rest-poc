<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="<c:url value="/js/jsj/jquery.multiselect/css/multi-select.css" />" media="screen" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<c:url value="/js/jsj/bootstrap.multiselect/css/bootstrap-multiselect.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/docs.css" />" />
<script src="<c:url value="/js/utils.js" />"></script>
<script src="<c:url value="/js/docs.js" />"></script>
<script src="<c:url value="/js/jsj/jquery.multiselect/js/jquery.multi-select.js" />" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function () {
	jQuery('#docs').multiSelect();
	jQuery(".popup-content+button").hide();
	try {
		opener.updateRequirements();
	} catch (err) {
	}

});
</script>
</head>
<body>
<c:forEach items="${docs}" var="item">
<li class="ms-elem-selectable" id="${item.id}-selectable"><span>${item.name}</span></li>
</c:forEach>
</body>
</html>
