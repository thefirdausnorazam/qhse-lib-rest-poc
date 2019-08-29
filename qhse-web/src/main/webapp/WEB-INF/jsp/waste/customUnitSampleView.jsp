<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="customUnitSampleView" />
		</h2>
	</div>
	<div class="content">

		<div class="errorMessage">
			<c:out value="${message}" />
		</div>
		<c:if test="${sampleDescription != null}">
			<div class="displayMessage">
				<c:out value="${sampleDescription} ${symbol}" />
			</div>
		</c:if>
		<div class="header">
			<h3>
				<c:out value="${expression}" />
			</h3>
		</div>
		<div class="content">
			<div>
				<table class="viewForm bordered">
					<thead>

						<tr>
							<th><fmt:message key="unit" /></th>
							<th><fmt:message key="symbol" /> ${symbol}</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${samples}" var="sample" varStatus="s">
							<c:choose>
								<c:when test="${s.index mod 2 == 0}">
									<c:set var="style" value="even" />
								</c:when>
								<c:otherwise>
									<c:set var="style" value="odd" />
								</c:otherwise>
							</c:choose>
							<tr class="<c:out value="${style}" />">
								<td><c:out value="${sample.key}" /></td>
								<td><c:out value="${sample.value}" /></td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
		</div>
	</div>
</body>
</html>
