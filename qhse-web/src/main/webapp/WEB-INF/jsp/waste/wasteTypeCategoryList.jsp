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
	color: #13ab94;
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
						<c:if test="${addButtonEnabled}">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='wasteTypeCategoryEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="wasteTypeCategoryCreate" />
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
	<div class="content" id="fontColorChanged">
		<div class="header">
			<h3>
				<fmt:message key="wasteTypeCategoryList" />
			</h3>
		</div>
		<scannell:url urls="${urls}" />
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">
					<thead>
						<tr>
							<td colspan="5"><fmt:message key="wasteTypeCategoryList" /></td>
						</tr>
						<tr>
							<th><fmt:message key="name" /></th>
							<th><fmt:message key="categoryClass" /></th>
							<th><fmt:message key="additionalInfo" />:</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${wasteTypeCategories}" var="wasteTypeCategory" varStatus="s">
							<c:choose>
								<c:when test="${s.index mod 2 == 0}">
									<c:set var="style" value="even" />
								</c:when>
								<c:otherwise>
									<c:set var="style" value="odd" />
								</c:otherwise>
							</c:choose>
							<tr class="<c:out value="${style}" />">
								<td><a href="<c:url value="wasteTypeCategoryView.htm"><c:param name="id" value="${wasteTypeCategory.id}"/></c:url>">
										<c:out value="${wasteTypeCategory.name}" />
									</a></td>
								<td><scannell:text value="${wasteTypeCategory.categoryClass.name}" /></td>
								<td><scannell:text value="${wasteTypeCategory.additionalInfo}" /></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="5">
								<!--<scannell:url urls="${urls}" />-->
							</td>
						</tr>
					</tfoot>

				</table>
			</div>
		</div>
	</div>
</body>
</html>
