<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <meta http-equiv="copyright" content="&copy; 2005 Ideagenplc">
    <meta http-equiv="robots" content="noindex, nofollow, noarchive">
    <meta name="theme-color" content="#ffffff">

    <title>Q-Pulse</title>

    <link rel="stylesheet"  href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet"  href="<c:url value="/js/jsj/bootstrap/dist/css/bootstrap.css" />">
    <link rel="stylesheet" href="<c:url value="/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/js/jsj/jquery.select2/select2.css" />">
    <link rel="stylesheet" type="text/css"   href="<c:url value="/css/cssj/style.css" />">
    <link class="theme-css" rel="stylesheet" href="<c:url value="/groove/css/groove-qpulse.min.css" />" />

    <style>
        body {
            opacity: 1;
        }
        #error-page{
            margin: auto;
            width: 100%;
            text-align: center;
            font-family: 'Open Sans', Verdana, sans-serif;
        }

        #error-page .logo{
            margin-bottom: 50px;
        }

    </style>
</head>

<body>
<div id="error-page">
    <div class="logo"><img src="<c:url value="/images/logo/Q-Pulse7_Med.png"/>" alt="Error"></div>
    <h1 class="error-page">${error_message}</h1>
</div>

</body>
</html>