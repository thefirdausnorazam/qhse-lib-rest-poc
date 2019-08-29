<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<!--   <meta name="printable" content="true"> -->
  <title><fmt:message key="viewReportees" /></title>
  <script language="javascript" type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
</head>
<body>
<div align="right"><button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button></div>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="viewReportees" /></h2> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
  
  <tr>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="external" /></th>
    <th><fmt:message key="active" /></th>
    <th><fmt:message key="activeInSites" /></th>
    <th>&nbsp;</th>
  </tr>
</thead>

<tbody>
  <c:forEach items="${reportees}" var="reportee" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
      <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><c:out value="${reportee.name}" /></td>
      <td><fmt:message key="${reportee.external}" /></td>
      <td><fmt:message key="${reportee.active}" /></td>
      <td>
      	<ul style="">
      		<c:forEach items="${reportee.activeInSites}" var="selectedSite">
      			<li><span style="white-space: nowrap;"><c:out value="${selectedSite.name}" /></span></li>
			</c:forEach>
      	</ul>
      </td>
      <td><a href="<c:url value="editReportee.htm"><c:param name="showId" value="${reportee.id}"/></c:url>" ><fmt:message key="edit" /></a>&nbsp;
        <c:if test="${reportee.lastUpdatedTs != null}">
          <a href="javascript:openHistory(<c:out value="${reportee.id},'${reportee['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
        </c:if>
      </td>
    </tr>
  </c:forEach>
</tbody>
<tfoot>
  <tr>
    <td colspan="5"><a href="<c:url value="editReportee.htm" />" ><fmt:message key="addReportee" /></a></td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
