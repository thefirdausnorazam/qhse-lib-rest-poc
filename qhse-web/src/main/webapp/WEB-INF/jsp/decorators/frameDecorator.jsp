<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html class="no-js g-html k-webkit k-webkit72" lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="cache-control" content="no-store">
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="copyright" content="&copy; 2019 Ideagen PLC.">
    <meta http-equiv="robots" content="noindex, nofollow, noarchive">

    <link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/static/images/apple-touch-icon.png" />">
    <link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/static/images/favicon-32x32.png" />">
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/static/images/favicon-16x16.png" />">
    <link rel="mask-icon" href="<c:url value="/static/images/safari-pinned-tab.svg" />" color="#5bbad5">
    <link rel="shortcut icon" href="<c:url value="/static/images/favicon.ico" />">
    <meta name="theme-color" content="#ffffff">

    <title>Q-Pulse</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="<c:url value="/static/lib/bootstrap-v4.3.1/css/bootstrap.css" />">
    <link rel="stylesheet" href="<c:url value="/static/lib/font-awesome-v4.7.0/css/font-awesome.min.css" />">

    <!-- Custom styles for this template -->
    <link rel="stylesheet" type="text/css" href="<c:url value="/static/css2/style.css" />">
    <link class="theme-css" rel="stylesheet" href="<c:url value="/static/lib/groove/css/groove-qpulse.min.css" />" />

    <!-- Bootstrap, jquery and thirdparty javascripts-->
    <script type="text/javascript" src="<c:url value="/static/lib/jquery-v3.4.1/jquery-3.4.1.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/lib/bootstrap-v4.3.1/js/bootstrap.bundle.js" />"></script>

    <script type="module" src="/static/js/qpulse.js"></script>

    <sitemesh:write property='head'/>
</head>
<body id="zoo" class="zoo g-body">
<%@include file="modules/header/header.jspf"%>
<div class="cl-wrapper">
    <div class="cl-sidebar 	d-none d-md-block d-lg-block"><%@include file="modules/sidebar/sidebar.jspf"%></div>
    <div class="cl-content"><sitemesh:write property='body'/></div>
</div>

</body>
</html>