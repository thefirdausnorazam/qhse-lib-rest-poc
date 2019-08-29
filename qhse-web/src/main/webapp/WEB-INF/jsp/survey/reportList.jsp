<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="reports" /></title>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="reports" /></h2> --%>
<!-- </div>  -->
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="name" /></h3> --%>
<!-- </div> -->
<div class="content"> 
					<div style="text-align: right;">

<%-- 						<c:if test="${true == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='reportMeasurementQueryForm.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="createReport" />
							</button>
						</c:if> --%>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</div>
		<div class="header">
				<h3>
					<fmt:message key="standardReports" />
				</h3>
		</div>
<div class="table-responsive">
<div class="panel" >
<table class="table table-bordered table-responsive">
  <col class="label" />
  <tbody>
  <c:forEach items="${reportDefinitions}" var="def" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><a target="<c:out value="run${def.name}" />" href="<c:url value="reportView.htm"><c:param name="name" value="${def.name}"/></c:url>" >
        <spring:message text="${def.name}" code="report.${def.name}"  />
      </a></td>
    </tr>
  </c:forEach>

<%--   <tr class="<c:out value="${style}" />">
      <td><a href="<c:url value="reportMeasurementQueryForm.htm"></c:url>" >
        <fmt:message key="createReport" />
      </a></td>
    </tr> --%>
   <tr class="<c:out value="${style}" />" style="display:none">
      <td><a href="<c:url value="../enviro/savedReportsQueryForm.htm"></c:url>" >
        Saved Reports
      </a></td>
    </tr>
  <c:forEach var="link" items="${docLinkHolder.links}" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><a href="<c:out value="${link.url}" />" target="linkedDoc"><c:out value="${link.name}" /></a> - <c:out value="${link.description}" /></td>
    </tr>
  </c:forEach>
  
  </tbody>
</table>
</div>
</div>
<c:if test="${allowCreateReport == true }">
		<div style="float:left;width: 100%" class="header">
				<h3 style="text-align:left;float:left;">
					<fmt:message key="felxibleReports" />
				</h3>
				<button type="button" class="g-btn g-btn--primary" onclick="location.href='reportMeasurementQueryForm.htm'" style="text-align:right;float:right;">
					<i class="fa fa-edit" style="color: white"></i>
					<fmt:message key="createReport" />
				</button>
		</div>
 </c:if>		

<div style="clear: both;"></div>
  <div class="table-responsive">
<div class="panel" >

    <table class="table table-bordered table-responsive">
  <col class="label" />
  <tbody>
  
   <c:forEach items="${flexibleReports}" var="def" varStatus="s">
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td><a href="<c:url value="measurementViewReport.htm"><c:param name="id" value="${def.id}"/></c:url>" >
        <c:out value="${def.title}"></c:out>
      </a></td>
    </tr>
  </c:forEach>
  </tbody>
  </table>
  </div>
  </div>

</body>
</html>
