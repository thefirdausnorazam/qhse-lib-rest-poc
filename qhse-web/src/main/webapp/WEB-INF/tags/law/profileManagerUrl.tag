<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ attribute name="editProfile" required="false" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
final String params = editProfile == null ? "" : "?edit=" + editProfile.getId();
%>
javascript:var win = window.open('<c:url value="/law/profileManager.htm" /><%=params%>', 'profileManager', 'toolbar=no,directories=no,location=no,status=no,menubar=no,resizable=yes,scrollbars=no,width='+(screen.width-100)+',height='+(screen.height-200)+',top=30,left=80'); win.focus();
