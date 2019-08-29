<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="${page}.searchResultsLegId" /></title>
 
</head>
<body>
 <script type="text/javascript"> 

 </script>
<c:set var="found" value="${!empty legObjs}" />
<div class="header">
<h3><fmt:message key="${page}.searchResultsLegId" /></h3>
</div>
<div class="content">  
<div class="table-responsive">
<div class="panel" >

<c:catch var="exception">${legObj.targetCompletionDate}</c:catch>
<table class="table table-bordered table-responsive">
  <thead>    
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="${page}.name" /></th>
      <c:if test="${not empty exception}">
      		<th><fmt:message key="${page}.targetCompletionDate" /></th>
      </c:if>
      <th><fmt:message key="${page}.status" /></th>
	  <th><fmt:message key="legacyId"></fmt:message></th>
    </tr>
    </c:if>
  </thead>

  <tbody>
      		<c:forEach items="${legObjs}" var="legObj" varStatus="s">
					      <c:choose>
					        <c:when test="${s.index mod 2 == 0}">
					          <c:set var="style" value="even" />
					        </c:when>
					        <c:otherwise>
					          <c:set var="style" value="odd" />
					        </c:otherwise>
					      </c:choose>
					      <tr class="<c:out value="${style}" />">
							  <td><a href="<c:url value="/risk/${page}View.htm"><c:param name="id" value="${legObj.id}"/></c:url>" ><c:out value="${legObj.displayId}" /></a></td>
							  <td><scannell:text value="${legObj.name}" /></td>
							  <c:if test="${not empty exception}">
							  <td><fmt:formatDate value="${legObj.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
							  </c:if>
							  <td><fmt:message key="assessment${legObj.status}" /></td>
							  <td><c:out value="${legObj.legacyId}" /></td>
						</tr>
	      		</c:forEach>
	  </tbody>
</table>
<c:if test="${not found}">
<table class="viewForm">
  <col class="label" />
  <thead>
    <tr><td><fmt:message key="entityNotFound.title" /></td></tr>
  </thead>

  <tbody>
    <tr><td><fmt:message key="search.empty" /></td></tr>
  </tbody>

  <tfoot>
    <tr><td><a href="javascript:window.history.go(-1);" >Go Back</a></td></tr>
  </tfoot>
</table>
</c:if>
</div>
<c:if test="${!not found}">
		<div class="spacer2 text-center">
			<button type="button" class="g-btn g-btn--primary" onclick="history.back()">
				<fmt:message key="back" />
			</button>
		</div>
		</c:if>
</div>
</div>
</body>
</html>
