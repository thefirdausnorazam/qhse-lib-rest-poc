<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
</head>
<body>
	<c:set var="colspan">
		<c:choose> 
		  <c:when test="${showSiteColumn}" >3</c:when> 
		  <c:otherwise>2</c:otherwise> 
		</c:choose> 
	</c:set>
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
						<c:if test="${canConfigure}">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='quantityCategoryEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="quantityCategoryCreate" />
							</button>
						</c:if>
						<button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary">
							<i class="fa fa-print printcolor" style="color: white"></i>
							<span class="printcolor"></span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="header">
			<h3>
				<fmt:message key="quantityCategoryList" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-responsive table-bordered">
						<thead>

							<tr>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="type" /></th>
	  							<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${quantityCategories}" var="category" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><a href="<c:url value="quantityCategoryView.htm"><c:param name="id" value="${category.id}"/></c:url>">
											<c:out value="${category.name}" />
										</a></td>
									<td><fmt:message key="${category.type}" /></td>
									<c:if test="${showSiteColumn}"><td><c:out value="${category.site}" /></td></c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
