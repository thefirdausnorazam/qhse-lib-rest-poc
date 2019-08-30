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
    <meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
    <meta http-equiv="robots" content="noindex, nofollow, noarchive">

    <link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/login/images/apple-touch-icon.png" />">
    <link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/login/images/favicon-32x32.png" />">
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/login/images/favicon-16x16.png" />">
    <link rel="mask-icon" href="<c:url value="/login/images/safari-pinned-tab.svg" />" color="#5bbad5">
    <link rel="shortcut icon" href="<c:url value="/login/images/favicon.ico" />">
    <meta name="theme-color" content="#ffffff">

    <title>Q-Pulse</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="<c:url value="/login/js/bootstrap/dist/css/bootstrap.css" />">
    <link rel="stylesheet" href="<c:url value="/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />">
    <style>
        body {
            opacity: 1;
        }
        #error-page{
            margin: auto;
            width: 100%;
            text-align: center;
        }

        #error-page .logo{
            margin-bottom: 50px;
        }

    </style>
</head>

<body>
<div id="error-page">
    <div class="logo"><img src="<c:url value="/public/images/logo/Q-Pulse7_Med.png"/>" alt="Error"></div>
    <h1 class="error-page">${error_message}</h1>
</div>

</body>
</html>