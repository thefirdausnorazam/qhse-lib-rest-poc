<%@ page language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${query.getTitle()}</title>
    <link rel="stylesheet" href="<c:url value="/static/lib/bootstrap-datepicker-v1.9.0.16/dist/css/bootstrap-datepicker3.css" />">
    <link rel="stylesheet" href="<c:url value="/static/lib/datatables-v1.10.18/datatables.css" />">
    <link rel="stylesheet" href="<c:url value="/static/lib/select2-v4.0.9/css/select2.css" />">
    <script type="text/javascript" src="<c:url value="/static/lib/bootstrap-datepicker-v1.9.0.16/dist/js/bootstrap-datepicker.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/lib/datatables-v1.10.18/datatables.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/lib/select2-v4.0.9/js/select2.full.js" />"></script>
</head>
<body>
<div id="qhse_law_tasks" class="container-fluid">
    <span class="qhse_page_title">${page.title}</span>
    <div class="qhse_page_body">
        <div class="qhse_page_section"><%@include file="./widget/lawTaskSearch.jspf"%></div>
        <div id="qhse_law_tasks_${page.name}" class="qhse_page_section"><%@include file="../common/query.jspf"%></div>
    </div>

</div>
<script type="module">
    import LawTask from "/static/js/modules/law/LawTask.js";
    var lawTask = new LawTask("${page.name}");
    lawTask.load();
</script>
</body>
</html>