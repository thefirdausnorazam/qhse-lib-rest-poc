<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="userQueryResult" /></title>
</head>
<body>
<script type="text/javascript"> 
	jQuery(document).ready(function() {
		initSortTablesBySelector('dataTable', 'Department');
	} );
 </script>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="searchResults" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table class="table table-responsive table-bordered dataTable" >
<thead>	
	<c:if test="${found}">
	<tr>
		<th><fmt:message key="lastName" /></th>
		<th><fmt:message key="firstName" /></th>
		<th><fmt:message key="userName" /></th>
		<c:if test="${showDomain}">
		  <th><fmt:message key="userDomain" /></th>
		</c:if>
		<th><fmt:message key="active" /></th>
		<th><fmt:message key="title" /></th>
		<th><fmt:message key="department" /></th>
		<th><fmt:message key="division" /></th>
		<th><fmt:message key="online" /></th>
		<th><fmt:message key="loggedIn" /></th>
	</tr>
	</c:if>
</thead>
<tbody>
<c:forEach items="${result.results}" var="user" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><c:out value="${user.lastNameDisplay}" /></td>
		<td><c:out value="${user.firstNameDisplay}" /></td>
		<td><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}"/></c:url>" ><c:out value="${user.userName}" /></a></td>
		<c:if test="${showDomain}">
		  <td><c:out value="${user.domain.name}" /></td>
		</c:if>
		<td><fmt:message key="${user.active}"/></td>
		<td><c:out value="${user.title}" /></td>
		<td><c:out value="${user.department.name}" /></td>
		<td><c:out value="${user.division}" /></td>
		<c:choose>
			<c:when test="${user.status == null}">
				<td>No</td>
				<td></td>
			</c:when>
			<c:otherwise>
				<td><fmt:message key="${user.status.online}"/></td>
				<td><c:choose>
					<c:when test="${user.status.online == true}">
						<c:out value="${user.status.loggedInTs}"/>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose></td>
			</c:otherwise>
		</c:choose>
	</tr>
</c:forEach>
<tfoot>
	<c:if test="${found}">
		<tr>
			<td colspan="9"><scannell:paging result="${result}" /></td>
		</tr>
	</c:if>
</tfoot>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
