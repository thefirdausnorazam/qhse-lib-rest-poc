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
	color: #13AB94 !important;
}
</style>
</head>
<body>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >7</c:when> 
	  <c:otherwise>6</c:otherwise> 
	</c:choose> 
</c:set>

	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
						<c:if test="${addButtonEnabled}">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='wasteTypeEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="wasteTypeCreate" />
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
				<fmt:message key="wasteTypeList" />
			</h3>
		</div>

		<div class="content">
			<div class="table-responsive">
				<div class="panel" id="queryTablePanel">
					<table class="table table-bordered table-responsive">
						<thead>

							<tr>
								<th><fmt:message key="category" /></th>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="code" /></th>
								<th><fmt:message key="hazardous" />:</th>
								<th><fmt:message key="physicalCharacteristic" /></th>
								<th><fmt:message key="active" /></th>
								<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${wasteTypes}" var="wasteType" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><a href="<c:url value="wasteTypeCategoryView.htm"><c:param name="id" value="${wasteType.category.id}"/></c:url>">
											<c:out value="${wasteType.category.name}" />
										</a></td>
									<td><a href="<c:url value="wasteTypeView.htm"><c:param name="id" value="${wasteType.id}"/></c:url>">
											<c:out value="${wasteType.name}" />
										</a></td>
									<td><c:out value="${wasteType.code.code}" /></td>
									<td><fmt:message key="${wasteType.hazardous}" /></td>
									<td><fmt:message key="${wasteType.physicalCharacteristic}" /></td>
									<td><fmt:message key="${wasteType.active}" /></td>
        							<c:if test="${showSiteColumn}"><td><c:out value="${wasteType.site}" /></td></c:if>
								</tr>
							</c:forEach>
						</tbody>

						<tfoot>
							<!--<tr>
								<td colspan="${colspan}">
									<scannell:url urls="${urls}" />
								</td>
							</tr>-->
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
