<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<style type="text/css">
#fontColorChanged a {
	color: #13AB94;
}
</style>
</head>
<body>
<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
						<%-- <c:if test="${urls.length > 0}"> --%>
						<c:forEach items="${urls}" var="url">
						
									<button type="button" class="g-btn g-btn--primary" onclick="location.href='${url.url}?<c:forEach items="${url.parameters}" var="params"><c:out value="${params.key}=${params.value}" /></c:forEach>'">
										<i class="fa fa-edit" style="color: white"></i><fmt:message key="${url.name}" />
									</button>
						</c:forEach>
						<%-- </c:if> --%>
								
							<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print printcolor" style="color:white"></i><span class="printcolor"></span></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content" id="fontColorChanged">
	<div class="header">
		<h3>
			<fmt:message key="${authorisedType}List" />
		</h3>
	</div>
		
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">
					<thead>

						<tr>
							<th><fmt:message key="name" /></th>
							<th><fmt:message key="address" /></th>
							<th><fmt:message key="phoneNumber" />:</th>
							<th><fmt:message key="emailAddress" />:</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${authoriseds}" var="authorised" varStatus="s">
							<c:choose>
								<c:when test="${s.index mod 2 == 0}">
									<c:set var="style" value="even" />
								</c:when>
								<c:otherwise>
									<c:set var="style" value="odd" />
								</c:otherwise>
							</c:choose>
							<tr class="<c:out value="${style}" />">
								<td><a href="<c:url value="authorisedView.htm"><c:param name="id" value="${authorised.id}"/></c:url>">
										<c:out value="${authorised.name}" />
									</a></td>
								<td><c:out value="${authorised.address}" /></td>
								<td><c:out value="${authorised.phoneNumber}" /></td>
								<td><c:out value="${authorised.emailAddress}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
