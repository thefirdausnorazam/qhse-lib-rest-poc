<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
<style type="text/css">
.accordion {
	margin-bottom: 0px;
}

.panel-group {
	margin-bottom: 0px;
}
</style>

<script type="text/javascript">
<!--
	function toggleCategory(categoryId) {
		var target = $('table-' + categoryId);
		var image = $('image-' + categoryId);
		if (target.visible()) {
			Effect.Fade(target);
			image.src = '<c:url value="/images/plus.gif"/>';
		} else {
			Effect.Appear(target);
			image.src = '<c:url value="/images/minus.gif"/>';
		}
	}
// -->
</script>
<script type="text/javascript">
jQuery(document).ready(function() {
    if(window.location.href.indexOf("printable=true") > -1) {
       jQuery( ".panel-collapse" ).removeClass( "panel-collapse collapse out" )
    }
});
</script>
</head>
<body>
	<div class="header">
		<h2>
			<c:if test="${type != null}">
				<fmt:message key="${type}" />
			</c:if>
			<fmt:message key="survey.monitoringProgrammeViewCategories.title" />
		</h2>
	</div>
	<div class="content">
		<c:if test="${types != null}">
			<c:if test="${type != null}">
				<a style="color: #13AB94" href="<c:url value="monitoringProgrammeViewCategories.htm" ><c:param name="printable" value="${param.printable}" /></c:url>">
					<fmt:message key="view" />
					<fmt:message key="all" />
				</a> |
			</c:if>
			<c:forEach items="${types}" var="item">
				<c:if test="${item != type}">
					<a style="color: #13AB94" href="<c:url value="monitoringProgrammeViewCategories.htm"><c:param name="type" value="${item.name}" /><c:param name="printable" value="${param.printable}" /></c:url>">
						<fmt:message key="view" />
						<fmt:message key="${item}" />
					</a> |
				</c:if>
			</c:forEach>
		</c:if>
		
		<c:set var="first" value="${true}" />
		
		<c:forEach items="${sortMeasurement}" var="sortMeasurement" varStatus="sm">
		<c:set var="temp1" value="${true}" />
		<div class="panel-group accordion accordion-semi" id="accordion3">

			<div class="panel panel-default">

				<div class="panel-heading">
						<h4 class="panel-title">
							<a class="collapsed" data-toggle="collapse" data-parent="#accordion3" href="#${sm.index}">
								<i class="fa fa-angle-right"></i>
								<c:out value="${sortMeasurement}" />
							</a>
						</h4>
					</div> 
				<div id="${sm.index}" class="panel-collapse collapse out">


					<div class="panel-body">

						<table class="table table-bordered">
							<c:set var="last" value="" />
							<c:forEach items="${measurements}" var="measurement" varStatus="s">
								<c:if test="${measurement.quantity.active}">
									<c:if test="${first == true || measurement.quantity.category != last}">
										<c:if test="${ temp1 eq true}">
											<c:set var="temp1" value="${false}" />
											<thead>
												<tr>
													<th><fmt:message key="survey.monitoringProgrammeViewCategories.quantity" /></th>
													<th><fmt:message key="survey.monitoringProgrammeViewCategories.measure" /></th>
													<th><fmt:message key="survey.monitoringProgrammeViewCategories.readingPoint" /></th>
													<th><fmt:message key="survey.monitoringProgrammeViewCategories.frequency" /></th>
													<th><fmt:message key="survey.monitoringProgrammeViewCategories.responsibleUser" /></th>
													<c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
												</tr>
											</thead>
										</c:if>

									 <c:if test="${ measurement.quantity.category.name eq sortMeasurement}">
											<tbody>
												<tr>
													<td><a href="<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>">
															<c:out value="${measurement.quantity.name}" />
														</a></td>
													<td><a
															href="<c:url value="readingQueryForm.htm"><c:param name=".quantityId" value="${measurement.quantity.id}" /><c:param name=".measureId" value="${measurement.measure.id}" /><c:param name="hideControls" value="true" /></c:url>">
															<c:out value="${measurement.measure.measureName}" />
														</a></td>
													<td>
														<!-- <a href="javascript:showChart('measurementReadingsChart.jpeg?id=<c:out value="${measurement.id}" />')"> --> <a
															href="<c:url value="measurementReadingsChart.htm"><c:param name="id" value="${measurement.id}" /><c:param name="last" value="${null}" /></c:url>">
															<img src="<c:url value="/images/survey/chartLink.giff" />" alt="View Chart" width="14" height="14">
														</a> <a
															href="<c:url value="readingQueryForm.htm"><c:param name=".quantityId" value="${measurement.quantity.id}" /><c:param name=".measureId" value="${measurement.measure.id}" /><c:param name=".readingPointId" value="${measurement.readingPoint.id}" /><c:param name="hideControls" value="true" /></c:url>">
															<c:out value="${measurement.readingPoint.name}" />-<c:out value="${measurement.readingPoint.location}" />
														</a>
													</td>
													<td><c:out value="${measurement.frequencyDisplay}" /></td>
													<td><c:out value="${measurement.quantity.responsibleUser.displayName}" /></td>
        											<c:if test="${showSiteColumn}"><td><c:out value="${measurement.site}" /></td></c:if>
												</tr>
											</tbody>
										</c:if>
									</c:if>
								 </c:if>
							</c:forEach>
							<c:set var="last" value="${measurement.quantity.category}" /> 
							<c:set var="first" value="${false}" />
						</table>
					</div>
				</div>
			</div>
		</div>
	 </c:forEach> 
	</div>

</body>
</html>