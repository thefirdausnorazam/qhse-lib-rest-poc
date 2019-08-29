<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<title></title>
<style type="text/css" media="all">
/* @import "<c:url value='/css/survey.css'/>"; */
</style>
</head>
<body>
	<div class="content">
		<div class="col-md-12">
			<div id="block" class="">
				<div>
					<div style="padding-left: 0px;" class="col-md-6"></div>
					<div class="col-md-12 col-sm-12">
						<div style="text-align: right;">
							<c:if test="${canConfigure}">
								<button data-placement="top" data-toggle="tooltip" onclick="window.location.href='<c:url value="readingPointEdit.htm" />';" data-original-title="Add Monitoring Point" type="button"
									class="g-btn g-btn--primary">
									<i class="fa fa-chevron-circle-up"></i>
									<fmt:message key="readingPointCreate" />
								</button>
							</c:if>
							<button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary">
								<i class="fa fa-print" style="color: white"></i>
								<span></span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content">
			<div class="header">
				<h3>
					<fmt:message key="readingPointList" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<div class="panel">
						<table class="table table-bordered table-responsive">
							<thead>

								<tr>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="location" /></th>
									<th><fmt:message key="active" /></th>
									<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${readingPoints}" var="readingPoint" varStatus="s">
									<c:choose>
										<c:when test="${s.index mod 2 == 0}">
											<c:set var="style" value="even" />
										</c:when>
										<c:otherwise>
											<c:set var="style" value="odd" />
										</c:otherwise>
									</c:choose>
									<tr class="<c:out value="${style}" />">
										<td><a href="<c:url value="readingPointView.htm"><c:param name="id" value="${readingPoint.id}"/></c:url>">
												<c:out value="${readingPoint.name}" />
											</a></td>
										<td><c:out value="${readingPoint.location}" /></td>
										<td><fmt:message key="${readingPoint.active}" /></td>
        								<c:if test="${showSiteColumn}"><td><c:out value="${readingPoint.site}" /></td></c:if>
									</tr>
								</c:forEach>
							</tbody>


						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
