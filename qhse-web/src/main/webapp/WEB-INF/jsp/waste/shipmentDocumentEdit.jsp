<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="wasteShipmentDocumentEdit" />
<c:if test="${command.newDocument}">
	<c:set var="title" value="wasteShipmentDocumentCreate" />
</c:if>
<title></title>
<script type="text/javascript">
	jQuery(document).ready(function() {

		jQuery('#type').select2({
			width : '400px'
		});
		jQuery('#weightUnit').select2({
			width : '200px'
		});
		

		if('${command.shipmentNo}' != '') {
			if('${command.receivedDate}' == '') {
				jQuery('#requiredReceivedDate').text('* required');
			}
			if('${command.actionDate}' == '') {
				jQuery('#requiredActionDate').text('* required');
			}
		}
	});
</script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>

</head>

<body>
	<div class="header">
		<h2>
			<fmt:message key="${title}" />
		</h2>
	</div>
	<scannell:form>
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col />
						<tbody>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="type" /></td>
								<td class="search"><select name="type" id="type" items="${types}" itemValue="name"
										lookupItemLabel="true" /></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shipmentNo" /></td>
								<td class="search"><input name="shipmentNo" cssStyle="width:400px;"  /></td>
							</tr>
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="wasteShipmentDocument.receivedDate" /></td>
								<td class="search">
								<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 250px;float:left;">
				                        	<input id="receivedDate" value="<fmt:formatDate type="date" value="${command.receivedDate}" pattern="dd-MMM-yyyy" />"   class="form-control dateToChange" size="6" id="fromDate" name="receivedDate" type="text"  readonly>
				                        	<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
				                         
				                        </div>
				                        <span id="requiredReceivedDate" class="requiredHinted" style="float:left">*</span>
				                       
										<%-- <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
											<input id="receivedDate"
												value="<fmt:formatDate type="date" value="${command.receivedDate}" pattern="dd-MMM-yyyy" />"
												class="form-control dateToChange" size="6" name="receivedDate" type="text" readonly>
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th"></span>
											</span>
										</div> --%>
										
									</td>
							</tr>
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shippedDate" /></td>
								<td class="search">
									<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"
													style="width: 250px;float:left;">
				                        	<input id="actionDate" value="<fmt:formatDate type="date" value="${command.actionDate}" pattern="dd-MMM-yyyy" />"  class="form-control dateToChange" size="6"  name="actionDate" type="text" readonly>
				                        	<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
				                        </div>
				                       <span id="requiredActionDate" class="requiredHinted" style="float:left">*</span>
										<%-- <div class="input-group date datetime" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
											<input id="actionDate" value="<fmt:formatDate type="date" value="${command.actionDate}" pattern="dd-MMM-yyyy" />"
												class="form-control dateToChange" size="6" name="actionDate" type="text" readonly>
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th"></span>
											</span>
										</div> --%>
									</td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="weight" /></td>
								<td class="search"><input name="weightAmount" class="form-control"
										cssStyle="width:200px;display:inline;" /> <scannell:select items="${units}" id="weightUnit" path="weightUnit"
										itemValue="id" itemLabel="name" class="medium" /> <scannell:errors path="weight" /></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="comment" /></td>
								<td class="search"><scannell:textarea path="comment" cols="75" rows="3" /></td>
							</tr>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary"
										value="<fmt:message key="submit" />"></td>
							</tr>
						</tfoot>

					</table>
				</div>
			</div>
		</div>
	</scannell:form>

</body>
</html>
