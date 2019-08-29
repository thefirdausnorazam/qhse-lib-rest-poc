<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<style type="text/css" media="all">
 	@import "<c:url value='/css/survey.css'/>";
</style>
</head>
<body>
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12">
					<div style="text-align: right;">
						<c:if test="${canConfigure}">
							<button data-placement="top" data-toggle="tooltip" onclick="window.location.href='<c:url value="measurementEdit.htm" />';" data-original-title="Add Measurement" type="button"
								class="g-btn g-btn--primary">
								<i class="fa fa-chevron-circle-up"></i>
								<fmt:message key="measurementCreate" />
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
				<fmt:message key="measurementList" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
							<c:set var="last" value="${null}" />
							<c:forEach items="${measurements}" var="measurement" varStatus="s">
								<c:if test="${measurement.quantity.category != last.quantity.category}">
									<c:if test="${last != null}">
										</tbody>
										</table>
									</c:if>
									<table class="table table-bordered table-responsive dataTable">
										<caption><c:out value="${measurement.quantity.category.name}" /></caption>
										<thead>
											<tr>
												<th><fmt:message key="id" /></th>
												<th><fmt:message key="quantity" /></th>
												<th><fmt:message key="measure" /></th>
												<th><fmt:message key="readingPoint" /></th>
												<th><fmt:message key="frequency" /></th>
												<th><fmt:message key="active" /></th>
											</tr>
										</thead>
				
										<tbody>
									</c:if>

								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>
								<tr class="<c:out value="${style}" />">
									<td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>">
											<c:out value="${measurement.id}" />
										</a></td>
									<td><c:out value="${measurement.quantity.name}" /></td>
									<td><c:out value="${measurement.measure.measureName}" /></td>
									<td><c:out value="${measurement.readingPoint.name}" /></td>
									<td><c:out value="${measurement.frequencyDisplay}" /></td>
									<td><fmt:message key="${measurement.active}" /></td>
								</tr>
								<c:set var="last" value="${measurement}" />
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
