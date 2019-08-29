<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>

<html>
<head>
  <title>SCANNELL</title>

  <script language="javascript" type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';
  </script>

  <meta http-equiv="expires"   content="0">
  <meta http-equiv="pragma"    content="no-cache">
  <meta http-equiv="copyright" content="&copy; <%=java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%> ScannellSolutions">
  <meta http-equiv="robots"    content="noindex, nofollow, noarchive">

  <style type="text/css" media="all">
    h2 {color: #cc3333;}
    table.viewForm {border-color: #cc3333;}
    table.viewForm thead tr td {border-bottom-color: #cc3333; color: #cc3333; }
    table.viewForm tfoot tr td {color: #cc3333;}
    table.viewForm a{color: #cc3333;}
    div.menuContainer {color: #cc3333;}
    div.menuTitle {background-color: #cc3333;}
    div.menuContainer a {color: #cc3333;}
    div.menuContainer a:visited {color: #cc3333;}
  </style>

  <decorator:head />

  <script type="text/javascript">
    function onBodyLoad() {
      window.focus();
      <decorator:getProperty property="body.onload"  /> ;
    }
  </script>
</head>

<body onload="onBodyLoad();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow: hidden"  >
  <h2 style="padding-bottom: 5px;" align="center"><decorator:title default="" /></h2>
  <decorator:body />
</body>
</html>