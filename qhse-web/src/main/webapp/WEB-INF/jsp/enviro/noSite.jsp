<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<br>
<br>
<div class="content">
<div class="table-responsive">
<div class="panel" align="center">
<div align="center"><font face="VERDANA, ARIAL, HELVETICA, SANS-SERIF" size="2" color="#000000">
<br/>
<br/>
<fmt:message key="noSite.title" /><br /><br />

    		<c:out value="${user.displayName}"/>  <fmt:message key="noSite.body1"/><br/>
    		<c:choose>
	    		<c:when test="${user.passwordEditable}">
		    		<fmt:message key="noSite.body2">
						<fmt:param value="${user.userName}" />
					</fmt:message> 
				</c:when>
				<c:otherwise>
		    		<fmt:message key="noSite.body3">
						<fmt:param value="${user.userName}" />
					</fmt:message> 
				</c:otherwise>
			</c:choose>
</font>
<br/><br/>
</div>
</div>
</div>
</div>
</body>
</html>
