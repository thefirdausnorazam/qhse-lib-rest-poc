<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<title></title>
	<script type='text/javascript' src="<c:url value="/js/common.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/css.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/standardista-table-sorting.js"/>"></script>
</head>

<body>
<div class="col-md-12">
	<div id="block" class="">
		<div>
			<div class="col-md-6">
			</div>
			<div class="col-md-12 col-sm-12">
				<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='userEdit.htm'">
							<i class="fa fa-edit" style="color: white"></i>
							<fmt:message key="userCreate" />
						</button>
					</c:if>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
				</div>				
			</div>
		</div>
   	</div>
</div>
<div class="header">
<h2><fmt:message key="userList" /></h2>
</div>
<a name="user"></a>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
<thead>
	<%-- <tr><td colspan="10"><scannell:url urls="${urls}" /></td></tr> --%>
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
	</tr>
</thead>

<tbody>
	<c:forEach items="${users}" var="user" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}">
				<c:set var="style" value="even" />
			</c:when>
			<c:otherwise>
				<c:set var="style" value="odd" />
			</c:otherwise>
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
		</tr>
	</c:forEach>
</tbody>

<tfoot>
	<tr><td colspan="10"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
