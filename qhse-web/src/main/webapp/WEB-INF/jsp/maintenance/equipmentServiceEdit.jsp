<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>

<title><fmt:message key="maintenance.equipmentServiceAdd.table.title" /></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>
<script type="text/javascript">
jQuery(document).ready(function() {
	
	var obj = jQuery(".datetime .requiredHinted");
	var obj2 = jQuery(".datetime .error");
	obj.css("float", "left");
	obj2.css("float", "left");
	jQuery(".datetime .requiredHinted").remove();
	jQuery(".datetime .error").remove();
	//obj.append(obj2.text());
	jQuery('#divDate').append(obj);
	jQuery('#divDate').append(obj2);
	
// 	jQuery('#divDate').append("<div id='newDiv' style='float:left'></div>")
// 	jQuery('#newDiv').append(obj);
// 	jQuery('#newDiv').append(obj2);
});
</script>
</head>
<body>
	
	<div class="content">
<!-- 		<div class="header"> -->
<!-- 			<h3> -->
<%-- 				<fmt:message key="maintenance.equipmentServiceAdd.table.title" /> --%>
<!-- 			</h3> -->
<!-- 		</div> -->
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<scannell:form>
						<spring:nestedPath path="command">
							<table class="table table-bordered table-responsive">
								<col />
								<tbody>


									<tr>
										<td class="searchLabel"><fmt:message key="maintenance.equipmentServiceAdd.actualDate" />:</td>
										<td class="search" style="width: 70%;">
											<div id="divDate" style="min-width: 200px;width: 30%;">
												<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 70%; float:left">
													<scannell:input id="actualDate" path="actualDate" readonly="${true}" class="form-control" cssStyle="width:100%" />
													<span class="input-group-addon btn btn-primary">
														<span class="glyphicon glyphicon-th"></span>
													</span>
												</div>
											</div>

										</td>
									</tr>

									<tr>
										<td class="searchLabel"><fmt:message key="maintenance.equipmentServiceAdd.carriedOutBy" />:</td>
										<td class="search"><input name="carriedOutBy" class="wide" /></td>

									</tr>

									<tr>
										<td class="searchLabel"><fmt:message key="maintenance.equipmentServiceAdd.comment" />:</td>
										<td class="search"><scannell:textarea id="comment" path="comment" cssStyle="width:50%" /></td>
									</tr>

								</tbody>
								<tfoot>
									<tr>
										<td colspan="2" align="center">
											<button type="submit" class="g-btn g-btn--primary">
												<fmt:message key="submit" />
											</button>
											<button type="button" class="g-btn g-btn--secondary" onclick="javascript:location.href='<c:url value="equipmentRecordView.htm"><c:param name="id" value="${command.maintenanceRecordID}"/></c:url>'">
												<fmt:message key="cancel" />
											</button>
										</td>
									</tr>
								</tfoot>
							</table>

						</spring:nestedPath>


					</scannell:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
