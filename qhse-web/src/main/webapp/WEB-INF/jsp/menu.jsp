<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="menubarcontainer">

<ul id="menubar">
  <li><a href="#"><fmt:message key="incident" /></a>
  <ul>

    <li><a href="<c:url value="/incident/home.htm" />"><fmt:message key="home" /></a></li>
    <li><a href="<c:url value="/incident/searchIncidentsForm.htm" />"><fmt:message key="searchIncidents" /></a></li>
    <li><a href="<c:url value="/incident/editIncident.htm" />"><fmt:message key="createIncident" /></a></li>
    <li><a href="<c:url value="/incident/editAction.htm" />"><fmt:message key="createAction" /></a></li>

  </ul>
  </li>

  <li><a href="<c:url value="/legal/html/EnviroManagerMain.html" />"><fmt:message key="law" /></a></li>
</ul>
<div style="clear: both;"></div>
</div>
