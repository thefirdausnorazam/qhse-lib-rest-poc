<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>

<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<title><sitemesh:write property='title'/></title>
		<%@include file="headNew.jspf" %>
		<sitemesh:write property='head'/>
	</head>

	<body  />
		<div align="center">
			<div class="popup-content">
				<sitemesh:write property='body'/>
			</div>
			<%-- <button onclick="window.close();" ><fmt:message key="close" /></button> --%>
		</div>
	</body>
</html>