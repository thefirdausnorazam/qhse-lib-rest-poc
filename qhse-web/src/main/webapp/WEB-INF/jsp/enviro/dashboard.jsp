<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="expires" content="0">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="copyright" content="&copy; Scannell Solutions">
  <meta http-equiv="robots" content="noindex, nofollow, noarchive">

  <title>SCANNELL Dashboard</title>

  <link type="text/css" href="<c:url value="/ext-4.2.0.663/resources/css/ext-all-gray.css" />" rel="stylesheet"/>

  <script type="text/javascript">
    <c:set var="atg.taglib.json.prettyPrint" value="true" />

    var sites = <json:array>
        <c:forEach items="${user.sites}" var="site">
        <json:object> <json:property name="id" value="${site.id}"/> <json:property name="name" value="${site.name}"/></json:object>
        </c:forEach>
        </json:array>;

    <c:forEach var="entry" items="${columns}" >
      <c:set var="columnName" value="${entry.key}" />
      <c:set var="items" value="${entry.value}" />

      var ${columnName}DashboardColumnItems = <json:array>
        <c:forEach var="item" items="${items}" >
          <json:object >
            <json:property name="name" value="${item.name}"/>
            <json:property name="title" value="${item.title}"/>
            <json:property name="theme" value="${item.theme}"/>
            <json:property name="constrainedByYear" value="${item.constrainedByYear}"/>
            <json:property name="chartType" value="${item.chartType}"/>
            <json:property name="categoryField" value="${item.categoryColumn}"/>
            <json:property name="categoryDescriptionField" value="${item.categoryColumn}Description"/>
            <json:array name="valueFields" items="${item.valueItems}" var="valueItem" >
              <json:object>
                <json:property name="name" value="${valueItem.name}"/>
                <json:property name="label" value="${valueItem.label}"/>
              </json:object>
            </json:array>
            <json:property name="legend" value="${item.legend}"/>
            <json:property name="categoryAxisTitle" value="${item.categoryAxisTitle}"/>
            <json:property name="hideCategoryAxisLabels" value="${item.hideCategoryAxisLabels}"/>
            <json:property name="valueAxisTitle" value="${item.valueAxisTitle}"/>
            <json:property name="columnRenderer" value="${item.columnRenderer}"/>
          </json:object>
        </c:forEach>
        </json:array>;
    </c:forEach>

  </script>

  <style type="text/css">
    h2 {
      font-size: 18px;
      font-weight: bold;
      padding: 0;
      margin: 0;
    }
  </style>

      <script type="text/javascript" src="<c:url value="/ext-4.2.0.663/ext-all-debug-w-comments.js" />"></script>  
           
      <script type="text/javascript" src="<c:url value="/js/dashboard.js" />"></script>

  <script type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';

    Ext.onReady(function () {
      var onResize = function (portal) {
        var div = Ext.get("bodyCentre");
       
        portal.setWidth(div.getWidth());
        portal.setHeight(div.getHeight() - 70);
        portal.doLayout();
      };

      var portal = Ext.create('Ext.app.Portal', {
        listeners: {
          render: onResize
        }
      });

      Ext.EventManager.onWindowResize(function () {
        onResize(portal)
      });


    });

  </script>

</head>

<body >

<div class="content" align="center" id="bodyCentre" style="width:100%">
</div>

</body>
</html>