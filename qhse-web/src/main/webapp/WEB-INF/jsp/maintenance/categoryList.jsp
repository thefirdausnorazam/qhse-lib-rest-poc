<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
								<c:set  var="capitalizedText" value="${fn:toUpperCase(fn:substring(type.name, 0, 1))}${fn:toLowerCase(fn:substring(type.name, 1,fn:length(type.name)))}"/>
								<button data-placement="top" data-toggle="tooltip"
											onclick="window.location.href='<c:url value="categoryEdit.htm" ><c:param name="type" value="${type.name}" /></c:url>';"
											data-original-title="Add ${fn:replace(capitalizedText, 'Ppe', 'PPE')}" type="button" class="g-btn g-btn--primary">
											<i class="fa fa-chevron-circle-up"></i>
											<fmt:message key="add" /> <fmt:message key="${type}"/>
								</button>
								<c:forEach items="${types}" var="type">
									<button onclick="window.location.href='<c:url value="categoryList.htm"><c:param name="type" value="${type.name}"></c:param></c:url>';"
										 type="button" class="g-btn g-btn--primary">
										<i class="fa fa-chevron-circle-up"></i>
										<fmt:message key="${type}" />
									</button>
								</c:forEach>
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
					<fmt:message key="maintenanceCategoryList.${type.name}" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<div class="panel">
						<table class="table table-bordered table-responsive">
							<thead>
								<tr>
									<td colspan="2"><fmt:message key="${type}" /></td>
								</tr>
								<tr>
									<th><fmt:message key="name" /></th>
									<th><fmt:message key="active" /></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${categories}" var="category" varStatus="s">
									<c:choose>
										<c:when test="${s.index mod 2 == 0}">
											<c:set var="style" value="even" />
										</c:when>
										<c:otherwise>
											<c:set var="style" value="odd" />
										</c:otherwise>
									</c:choose>
									<tr class="<c:out value="${style}" />">
										<td><a href="<c:url value="categoryView.htm"><c:param name="id" value="${category.id}"/></c:url>">
												<c:out value="${category.name}" />
											</a></td>
										<td><fmt:message key="${category.active}" /></td>
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
