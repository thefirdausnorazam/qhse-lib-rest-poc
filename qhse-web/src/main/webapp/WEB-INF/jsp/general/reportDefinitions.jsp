<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="reports" /></h2> --%>
<!-- </div>  -->
<div class="content"> 
<c:if test="${definitions != null}">
  <c:choose>
    <c:when test="${empty definitions}">
      <fmt:message key="search.empty" />
    </c:when>
    <c:otherwise>
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="name" /></h3> --%>
<!-- </div>     -->
<div class="content"> 
<div class="table-responsive">
<div class="panel" >

      <table class="table table-bordered table-responsive">
   
        

        <tbody>
          <c:forEach items="${definitions}" var="def" varStatus="s">
            <tr>
              <td><a target="<c:out value="run${def.name}" />" href="<c:url value="reportView.htm"><c:param name="name" value="${def.name}"/></c:url>" >
                <spring:message text="${def.name}" code="report.${def.name}"  />
              </a></td>
            </tr>
          </c:forEach>
          
          <c:if test="${showFlashReport}">
	          <tr>
	            <td><a href="<c:url value="reportView.htm?name=flashReport" />"/>Audit Trend Report</a></td>
	          </tr>
          </c:if>
        </tbody>
      </table>
</div>
</div>
</div>
    </c:otherwise>
  </c:choose>
</c:if>
</div>
</body>
</html>
