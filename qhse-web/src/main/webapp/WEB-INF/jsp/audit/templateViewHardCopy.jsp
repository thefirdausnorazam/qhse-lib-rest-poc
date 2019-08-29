<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header nowrap">
<h2><fmt:message key="template.title" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">


<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><c:out value="${template.name}" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" />:</td>
		<td><scannell:text value="${template.additionalInfo}" /></td>
	</tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="header">
<h2>
<c:choose>
					<c:when test="${group ne null}"> <c:out value="${group.name}"/></c:when>
					<c:otherwise><fmt:message key="questions.title" /></c:otherwise>
				</c:choose>
</h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<c:forEach items="${activeGroups}" var="groupQuestionEntry">
	<c:set var="group" value="${groupQuestionEntry.key}" />
	<c:set var="questions" value="${groupQuestionEntry.value}" />

	
	<tbody>
	<c:forEach items="${questions}" var="question" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td style="border-top: thin black solid;">
				<c:out value="${question.name}" /><br /><br />
				<c:out value="${question.additionalInfo}" /><br /><br />
				<div style="height: 200px; width: 100%; background-color: white;"></div>
				<div style="padding-top: 5px; padding-bottom: 20px;">
				<c:if test="${template.scorable}">
					<fmt:message key="score" />:
					<c:forEach var="score" items="${question.scoreConfig.permittedScores}">
						&nbsp;&nbsp;&nbsp;&nbsp;${score}
					</c:forEach>
				</c:if>
				</div>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	
</c:forEach>

</table>
</div>
</div>
</div>
</body>
</html>
