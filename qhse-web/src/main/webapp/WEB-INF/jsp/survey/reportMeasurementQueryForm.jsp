<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta name="printable" content="true"> -->
<title></title>

<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('select').not('#siteLocation').select2({
				placeholder: "Choose",
				allowClear: true,
				width:'50%'	
		});
		
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
	});

</script>
<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

@import "<c:url value='/css/survey.css'/>";

input[type='checkbox'] {
	width: 20px;
	height: 20px;
}

.asterisc {
  color: red;
  
}
.select2-search-choice-close {
        right: 30px !important;
}

.marginLeft {
        margin-left:20px !important;

}

.marginRight {
        margin-right:10px !important;
}
</style>

</head>
<body>
	<scannell:form id="form">
		<div id="queryTable">
			<div class="header">
				<h3>
					<fmt:message key="createReportStep1" />
				</h3>
			</div>
			<div class="content">
				<div class="table-responsive">
					<div class="panel">
						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="title" />:
							</label>
							<div class="col-sm-6">
								<input type="text" id="title" name="title" value="${command.title}" Class="form-control" required style="width: 80%">
								<span class="asterisc">*</span>
							</div>
						</div>
						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="addLicenseReference" />
							</label>
							<div class="col-sm-6">
								<input type="text" id="licenseReference" name="licenseReference" value="${command.licenseReference}" Class="form-control" style="width: 80%">
							</div>
						</div>
						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="period" />
							</label>
							<div class="col-sm-6">
								<select id="period" name="period" style="width: 200px;"	onchange="showMonthsNames(this)" required>
									<option></option>
									<option value="Weekly"	${command.period == 'Weekly' ? 'selected' : ''}><fmt:message key="weekly" /></option>
									<option value="Monthly"	${command.period == 'Monthly' ? 'selected' : ''}><fmt:message key="monthly" /></option>
									<option value="Yearly"	${command.period == 'Yearly' ? 'selected' : ''}><fmt:message key="janToDec" /></option>
								</select>
								<span class="asterisc">*</span>
							</div>
						</div>
						<div class="form-group">
							<label
								class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="addMonitoringPoint" />
							</label>
							<div class="col-sm-6">
								<select id="measurementPoint" name="measurementPoint" class="wide" required>
								<option></option>
									<c:forEach items="${readingPoints}" var="readinPoint">
										<option value="${readinPoint.id }">${readinPoint.description }</option>
									</c:forEach>
								</select>
								<span class="asterisc">*</span>
							</div>
						</div>
						
						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="showCalculation" />
							</label>
							<div class="col-sm-6">
								<label ><input type="checkbox" name="sumColumn" id="sumColumn" class="marginRight" ><fmt:message key="sumColumns" /></label>
								<label ><input type="checkbox" name="avgColumn" id="avgColumn" class="marginLeft marginRight" ><fmt:message key="avgColumns" /></label>
								<label ><input type="checkbox" name="ytdColumn" id="ytdColumn" class="marginLeft marginRight" ><fmt:message key="ytdColumns" /></label>
							</div>
						</div>

						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="addLimits" />
							</label>
							<div class="col-sm-6">
								<input id="externalLimit" name="externalLimit" type="checkbox" class="marginRight">
								<label ><fmt:message key="external" /></label>
								<input id="internalLimit" name="internalLimit"	type="checkbox" class="marginLeft marginRight">
								<label ><fmt:message key="internal" /></label>
							</div>
						</div>
						<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="addComment" />
							</label>
							<div class="col-sm-6">
								<input type="checkbox" id="addComment" name="addComment" class="switch" data-size="small">
							</div>
						</div>
					<div class="form-group">
							<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
								<fmt:message key="readingAvg" />
							</label>
							<div class="col-sm-6">
								<input id="readingAvg" name="readingAvg" type="checkbox" class="switch" data-size="small">
								<font color="red"><fmt:message key="readingAvgMsg" /></font>
							</div>
						</div>
						<div style="clear: both;"></div>
						<div class="spacer2 text-center">
							<input type="submit" value="<fmt:message key="next" />"	class="g-btn g-btn--primary">
							<a href="<c:url value="reportList.htm"></c:url>" class="g-btn g-btn--primary" >
								<fmt:message key="cancel" />
							</a>
						</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</scannell:form>
</body>
</html>
