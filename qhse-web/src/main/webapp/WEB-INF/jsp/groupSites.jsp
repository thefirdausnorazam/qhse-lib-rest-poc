<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- <title>Group Sites</title> -->
<link rel="stylesheet" href="<c:url value="/css/groupSites.css" />">
<script type="text/javascript" src="<c:url value="/js/selectBox.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/groupSites.js" />"></script>

<script type="text/javascript">
	function onPermissionLoad() {
		var option = '<c:out value="${viewableSites}"/>';
		<c:forEach items="${viewableSites}" var="item">
			var idLoad = "<c:out value="${item.id}"/>";
			jQuery('#sourceFields #' + idLoad).addClass('fc-selected');
		</c:forEach>
		<c:forEach items="${viewableReportingSites}" var="item">
			var idLoad = "<c:out value="${item.id}"/>";
			jQuery('#sourceFields #rg' + idLoad).addClass('fc-selected');
		</c:forEach>
		moveSelectedRight();
	}

	function sorDivs(id, obj) {

		var sortedDivs = jQuery(id).children('div');
		if (sortedDivs.length > 0) {
			included = false;
			jQuery.each(sortedDivs, function(index, value) {
				if (obj.text() < value.textContent && included == false) {
					jQuery(id).append(obj);
					included = true;
				}
				jQuery(id).append(value); //adding them to the body
				if (included == false) {
					jQuery(id).append(obj);
				}
			});
		} else {
			jQuery("#sourceFields").append(jQuery(".fc-selected"));
		}
	}
	function moveSelected(obj) {

		if (jQuery("#" + obj.id).parent().get(0).id == "sourceFields") {
			moveSelectedRight();
		} else if (jQuery("#" + obj.id).parent().get(0).id == "destinationFields") {
			//moveSelectedLeft();
			sorDivs("#sourceFields", jQuery("#destinationFields .fc-selected"));
		}
	}
	function unselect() {
		var array = jQuery('div.fc-selected');
		for (var i = 0; i < array.length; i++) {
			jQuery(array[i]).removeClass('fc-selected');
		}
	}
</script>

</head>
<body background="../appstart/images/scannelApp_BackgroundTile2.gif">
	<div class="header">
		<h2><fmt:message key="groupsSites" /></h2>
	</div>
	<div style="font-weight: bold; font-size: larger; text-align: center;"><fmt:message key="groupSitesMsg1" /></div>
	<div style="color: red; text-align: center; font-weight: bold"><fmt:message key="groupSitesMsg2" /></div>

	<spring:hasBindErrors name="command">
		<font color="red"><fmt:message key="groupSitesErrMsg" /></font>
	</spring:hasBindErrors>

	<c:set var="defaultSite" value="" />
	<form method="post" name="viewableSitesForm" onsubmit="onFormSubmit();">
		<input type="hidden" name="currentSiteName" id="currentSiteName" value="${currentSite.name}" />
		<input type="hidden" name="currentSiteId" id="currentSiteId" value="${currentSite.id}" />
		<div class="content">
			<div class="table-responsive">
				<div class="panel hidden-print panel-danger" id="accordion1">
					<div class="panel-heading" style="text-align: center">
						<fmt:message key="groupsSites" />
						<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse1"></a>

					</div>
					<div id="collapse1" class="panel-collapse collapse in">
						<div id="fieldChooser" tabIndex="1" class="fieldChooser">
							<div id="sourceFields">
								<c:forEach items="${allReportingGroups}" var="item">
									<div id="rg<c:out value="${item.id}" />" ondblclick="moveSelected(this)" tabindex="1">
										<c:out value="${item.name}" /> : <fmt:message key="enviro.reportingGroup" />
									</div>
								</c:forEach>
								<c:forEach items="${allSite}" var="item">
									<div id="<c:out value="${item.id}" />" ondblclick="moveSelected(this)" tabindex="1">
										<c:out value="${item.name}" />
									</div>
								</c:forEach>
							</div>
							<div class="middle">
								<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="&gt;&gt;"
									onclick="moveSelectedRight();" id="userRightButton" />
								<input type="button" class="g-btn g-btn--primary btn-block" name="right" value="all &gt;&gt;"
									onclick="moveAllRight();" />
								<input type="button" class="g-btn g-btn--primary btn-block" name="left" value="&lt;&lt;"
									onclick="moveSelectedLeft();" />
								<input type="button" class="g-btn g-btn--primary btn-block" name="left" value="all &lt;&lt;" onclick="moveAllLeft();" />
							</div>
							<div id="destinationFields"></div>

						</div>
						<div class="panel-footer clearfix">
							<div style="text-align: center">
								<button class="g-btn g-btn--primary" type="submit">&nbsp;Ok&nbsp;</button>
								&nbsp;&nbsp;

								<c:choose>
									<c:when test="${param.printable == true}">
										<button class="g-btn g-btn--secondary" type="button" onclick="window.close()">
											<fmt:message key="cancel" />
										</button>
									</c:when>
									<c:otherwise>
										<button class="g-btn g-btn--secondary" type="button" onclick="window.history.go(-1)">
											<fmt:message key="cancel" />
										</button>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<select style="display: none;" id="viewableSites" name="viewableSites" multiple="multiple" size="10"
							ondblclick="moveSelectedOptions(this.form['viewableSites'],this.form['unselected'])">

						</select>
					</div>

				</div>




			</div>
		</div>
	</form>

</body>
</html>