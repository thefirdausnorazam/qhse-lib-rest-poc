<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<script type='text/javascript' src="<c:url value="/js/common.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/css.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/standardista-table-sorting.js"/>"></script>
</head>

<body>
<div class="header">
<h2><fmt:message key="moduleList" /></h2>
</div>
<a name="user"></a>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
<col width="30%" />
<c:choose>
	<c:when test="${showGroups}">
		<col width="35%" />
		<col width="35%" />
	</c:when>
	<c:otherwise>
		<col width="70%" />
	</c:otherwise>
</c:choose>

<thead>
	<tr>
		<th><fmt:message key="licencedModule.module" /> - <fmt:message key="licencedAccessLevel.accessLevel" /></th>
		<th><fmt:message key="licencedAccessLevel.users" /></th>
		<c:if test="${showGroups}">
    		<th><fmt:message key="licencedAccessLevel.groups" /></th>
		</c:if>
	</tr>
</thead>

<tbody>
	<c:forEach items="${moduleAccessLevels}" var="moduleAccessLevelsEntry">
		<c:set var="module" value="${moduleAccessLevelsEntry.key}" />
		<c:set var="accessLevels" value="${moduleAccessLevelsEntry.value}" />
		<c:forEach items="${accessLevels}" var="accessLevel">
			<tr style="vertical-align: top;">
				<td style="font-weight: bold;"><fmt:message key="${module.name}" /> - <fmt:message key="AccessLevel.${accessLevel}" /></td>
				<td>
				  <c:forEach items="${usersByAccessLevelByModule[module][accessLevel]}" var="user">
					<div class="moduleUser"><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}"/></c:url>" ><c:out value="${user.displayName}" /></a></div>
			      </c:forEach>
			    </td>  
				<c:if test="${showGroups}">
  				<td>
				  <c:forEach items="${groupsByAccessLevelByModule[module][accessLevel]}" var="group">
					<div class="moduleUser"><a href="<c:url value="groupView.htm"><c:param name="id" value="${group.id}"/></c:url>" ><c:out value="${group.name}" /></a></div>
			      </c:forEach>
			    </td>  
				</c:if>
			</tr>
		</c:forEach>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
