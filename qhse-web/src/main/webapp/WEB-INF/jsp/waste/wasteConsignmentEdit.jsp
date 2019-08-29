<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="wasteConsignmentEdit" />
<c:if test="${command.id == 0}">
	<c:set var="title" value="wasteConsignmentCreate" />
</c:if>
<title><fmt:message key="${title}" /></title>
<script type='text/javascript' src="<c:url value="/dwr/interface/WasteDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('select').select2({
			width : '300px'
		});
		populateWasteType();
		toggleMandatory();
		jQuery('#shippingCompleted').change(function() {
			toggleMandatory();
    });

	});
	
	function toggleMandatory(){
		var shippingCompleted = jQuery('#shippingCompleted');
        if(shippingCompleted.is(":checked")) {
            jQuery("#isMandatory").show();
        }else{
        	 jQuery("#isMandatory").hide();
        }
	}
	function onPageSubmit(aForm) {
		addIndicesToCollectionElements(aForm, "items", "itemsSize");
	}

	function addIndicesToCollectionElements(aForm, prefix, sizeElementId) {
		var first = null;
		var index = -1;
		var count = 0;
		var sizeElement = document.getElementById(sizeElementId);

		for (var i = 0; i < aForm.elements.length; i++) {
			var el = aForm.elements[i];
			if (el.name.indexOf(prefix) == 0 && el.name != sizeElement.name) {
				if (first == null) {
					first = el.name;
					index++;
				} else if (first == el.name) {
					index++;
				}
				el.name = prefix + "[" + index + "]" + el.name.substr(prefix.length);
			}
		}
		if (sizeElement == null) {
			alert("size element not found. id=" + sizeElementId);
			return false;
		}
		sizeElement.value = index + 1;
	}

	function addRow(tableId, rowTemplateId) {
		var table = document.getElementById(tableId);
		var row = table.tBodies[0].insertRow(-1);
		var rowTemplate = document.getElementById(rowTemplateId);
		for (var i = 0; i < rowTemplate.cells.length; i++) {
			var cell = row.insertCell(i);
			cell.innerHTML = rowTemplate.cells[i].innerHTML;
		}
		return row;
	}

	function deleteRow(targetRow) {
		if (targetRow != null) {
			var table = getParent("table", targetRow);
			table.deleteRow(targetRow.rowIndex);
		}
	}

	// get the parent of an object of a particular type
	function getParent(type, obj) {
		if (obj != null) {
			if (obj.nodeName.toUpperCase() == type.toUpperCase()) {
				return obj;
			} else {
				return getParent(type, obj.parentNode);
			}
		}
		return null;
	}

	function addItemRow() {
		var selectedTypeId = getSelectedWasteType();
		jQuery("#wasteType").prop('selectedIndex', 0);
		ajaxGet("wasteConsignmentEditLine.html", "id=" + selectedTypeId, addItemRowCallback);
	}

	function addItemRowCallback(response) {
		jQuery('#wasteTypeAdd').attr('disabled', 'disabled');
		var row = document.getElementById("itemsTableBody").insertRow(-1);
		var text = response.responseText;
		var startTag = '<tr id="itemRow">';
		var endTag = "</tr>";
		if (text == null)
			return;
		var idx = text.indexOf(startTag);
		text = text.slice(idx + startTag.length);
		jQuery(row).append(text.substring(0, text.indexOf(endTag)));
		
		jQuery(row).find('select').select2({
			width : '300px'
		});
	}

	function onChangeWasteType() {
		var selectedTypeId = getSelectedWasteType();
		var usedTypes = document.getElementsByName("items.type");
		var disabled = true;
		if (selectedTypeId != 0) {
			for (var i = 0; i < usedTypes.length; i++) {
				if (selectedTypeId == usedTypes[i].value) {
					disabled = false;
					break;
				}
			}
		}
		if (disabled) {
			jQuery('#wasteTypeAdd').removeAttr('disabled');
		} else {
			jQuery('#wasteTypeAdd').attr('disabled', 'disabled');
		}

	}

	function getSelectedWasteType() {
		return jQuery('#wasteType').val();
	}

	function getSelectedConsignmentTypeItem() {
	}
	function calculatedEstimatedWeight(tableRow) {
	}
	function populateWasteType() {

		var carrierID = jQuery('#carrier').val();
		if (carrierID != '0') {
			DWRUtil.removeAllOptions("wasteType");
			WasteDWRService.getWasteTypes(jQuery('#carrier').val(), populateWasteTypeCallBack);
		}
	}

	function populateWasteTypeCallBack(data) {
		DWRUtil.removeAllOptions("wasteType");
		DWRUtil.addOptions("wasteType", {
			" " : "Choose"
		});
		DWRUtil.addOptions("wasteType", data);
	}
</script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";

input.form-control {
	width: 50px; display: inline;
}

.form-control.wide {
	width: 150px;
}

table tr {
	border: 1px;
}
</style>

</head>


<body>
<!-- 	<div class="header"> -->
<!-- 		<h2> -->
<%-- 			<fmt:message key="${title}" /> --%>
<!-- 		</h2> -->
<!-- 	</div> -->
	<scannell:form onsubmit="onPageSubmit(this)">
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<input type="hidden" id="itemsSize" name="itemsSize" value="" />
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col />
						<tbody>
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="carrier" /></td>
								<td class="search"><scannell:select id="carrier" path="carrier" items="${carriers}" itemLabel="name"
										itemValue="id" emptyOptionValue="0" class="wide" onchange="populateWasteType()" /> <c:if
										test="${shippingCompleted == true}">
										<span class="requiredHinted">*</span>
									</c:if></td>
							</tr>

							<c:if test="${displayBrokers}">
								<tr class="form-group">
									<td class="searchLabel"><fmt:message key="broker" /></td>

									<td class="search"><select name="broker" items="${brokers}" itemLabel="name" itemValue="id"
											emptyOptionValue="0" class="wide" /></td>

								</tr>
							</c:if>
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="consignee" /></td>
								<td class="search"><select name="consignee" items="${consignees}" itemLabel="name" itemValue="id"
										emptyOptionValue="0" class="wide" /> <c:if test="${shippingCompleted == true}">
										<span class="requiredHinted">*</span>
									</c:if></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shipmentDocumentType" />:</td>
								<td class="search"><select name="shipmentDocumentType" items="${documentTypes}" itemValue="name"
										lookupItemLabel="true" /> <c:if test="${shippingCompleted == true}">
										<span class="requiredHinted">*</span>
									</c:if></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shipmentNo" /></td>
								<td class="search"><input name="shipmentNo" class="form-control wide" /> <c:if
										test="${shippingCompleted == true}">
										<span class="requiredHinted">*</span>
									</c:if></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="vehicleNo" /></td>
								<td class="search"><input name="vehicleNo" class="form-control wide" /></td>
							</tr>



							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="comment" /></td>
								<td class="search"><scannell:textarea path="comment" cols="75" rows="4" class="form-control" cssStyle="width:60%"/></td>
							</tr>

							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shippingCompleted" /></td>
								<td class="search"><scannell:checkbox path="shippingCompleted" id="shippingCompleted" /></td>
							</tr>
							
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="shippedDate" />:</td>
								<td class="search">
									<%--  <scannell:input id="shippedDate" path="shippedDate" readonly="${true}" /> --%>
									<div style="width: 250px;">
										<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
											<scannell:input class="form-control" id="shippedDate" path="shippedDate" readonly="true"/>
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th"></span>
											</span>
										</div>
									</div>
									<div id="isMandatory" style="display: none;"> 
										<span class="requiredHinted">*</span>
											<span class="errorMessage">
													<c:out value="${status.errorMessage}" />
											</span>
									</div>
									</td>
							</tr>
	
							<tr class="form-group">
								<td class="searchLabel"><fmt:message key="waste.wasteConsignmentEdit.active" /></td>
								<td class="search"><scannell:checkbox path="active" /></td>
							</tr>

							<tr class="form-group">
								<td colspan="2">
									<table id="itemsTable" class="table table-bordered table-responsive" style="float:left;width:99%">
										<thead>
											<tr class="form-group">
												<td colspan="5" class="searchLabel" style="text-align: left"><fmt:message key="wasteConsignmentItems" />

													<select name="wastetype" id="wasteType" onchange="onChangeWasteType()"
														style="margin-left: 10px; margin-right: 10px;"></select>
													<button id="wasteTypeAdd" type="button" class="g-btn g-btn--primary" onclick="addItemRow(); return false;"
														disabled="disabled">
														<fmt:message key="add" />
													</button></td>

											</tr>
											<tr>
												<th><fmt:message key="wasteType" /></th>
												<th><fmt:message key="estimatedWeight" /></th>
												<th><fmt:message key="waste.wasteConsignmentEdit.containers" /></th>
												<th><fmt:message key="waste.wasteConsignmentEdit.expression" /></th>
												<th><fmt:message key="delete" /></th>
											</tr>
										</thead>
										<tbody id="itemsTableBody">

											<c:forEach items="${command.items}" var="item" varStatus="s">
												<spring:nestedPath path="command.items[${s.index}]">

													<tr>
														<td class="searchLabel"><c:out value="${item.type.description}" /> <spring:bind path="type">
																<input type="hidden" name="items.type" value="<c:out value="${status.value}" />" />
																<span class="errorMessage">
																	<c:forEach items="${status.errorMessages}" var="msg">
																		<br />
																		<c:out value="${msg}" />
																	</c:forEach>
																</span>
															</spring:bind> <spring:bind path="id">
																<input type="hidden" name="items.id" value="<c:out value="${status.value}" />" />
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind> <spring:bind path="version">
																<input type="hidden" name="items.version" value="<c:out value="${status.value}" />" />
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind></td>
														<td class="search"><spring:bind path="estimatedWeightAmount">
																<input type="text" name="items.estimatedWeightAmount" value="<c:out value="${status.value}" />"
																	class="form-control" />
																<span class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</span>
															</spring:bind> 
															<spring:bind path="estimatedWeightUnit">
																<select name="items.estimatedWeightUnit">
																	<option value="">Choose</option>
																	<c:if test="${item.type.customUnit != null}">
																		<option value="<c:out value="${item.type.customUnit.id}" />"
																			<c:if test="${item.type.customUnit.id == status.value}">selected="selected"</c:if>><c:out
																				value="${item.type.customUnit.name}" /></option>
																	</c:if>
																	<c:forEach items="${units}" var="unit">
																		<option value="<c:out value="${unit.id}" />"
																			<c:if test="${unit.id == status.value}">selected="selected"</c:if>><c:out
																				value="${unit.name}" /></option>
																	</c:forEach>
																</select>
																<div class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</div>
															</spring:bind> 
															<spring:bind path="estimatedWeight">
																<div class="errorMessage">
																	<c:out value="${status.errorMessage}" />
																</div>
															</spring:bind></td>
														<td class="search" ><c:choose>
																<c:when test="${item.type.customUnit.convertToBaseDescription == null}">
																	<spring:bind path="containerCount">
																		<input type="text" name="items.containerCount" readonly value="<c:out value="${status.value}" />"
																			class="form-control" onchange="calculatedEstimatedWeight(getParent('tr',this))" />
																		<div class="errorMessage">
																			<c:out value="${status.errorMessage}" />
																		</div>
																	</spring:bind>
																</c:when>
																<c:otherwise>
																	<spring:bind path="containerCount">
																		<input type="text" name="items.containerCount" value="<c:out value="${status.value}" />"
																			class="form-control" onchange="calculatedEstimatedWeight(getParent('tr',this))" />
																		<div class="errorMessage">
																			<c:out value="${status.errorMessage}" />
																		</div>
																	</spring:bind>

																</c:otherwise>
															</c:choose></td>
														<td class="search"><c:out value="${item.type.customUnit.convertToBaseDescription}" /></td>
														<td onclick="deleteRow(this.row)">
															<button type="button" class="delete" class="g-btn g-btn--primary" onclick="deleteRow(getParent('tr',this));">
																<fmt:message key="deleteShort" />
															</button>
														</td>
													</tr>

												</spring:nestedPath>
											</c:forEach>
										</tbody>
									</table> <spring:bind path="command.items">
										<span class="errorMessage">
											<c:out value="${status.errorMessage}" />
										</span>
										<span class="requiredHinted">*</span>
									</spring:bind>
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
