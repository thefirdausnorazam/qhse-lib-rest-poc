<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE htm>
<html>

<head>
<script type="text/javascript" src="<c:url value="/dwr/interface/SurveyDWRService.js" />"></script>
<script type="text/javascript" src="<c:url value="/dwr/engine.js" />"></script>
<script type="text/javascript" src="<c:url value="/dwr/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/css.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#quantityCategoryId').select2({
			width : '300px'
		});
		init();
		isCalendarDateDisabledHandler = disableFutureDates;
	});

	function isError(id) {
		SurveyDWRService.getReading(id, function(data) {
			showWarning(data);
		});
	}
	
	function showWarning(data) {
		var msg = document.getElementById('errorMessage[' + data.id + ']');
		var warning = '';
		var colour = '#8a6d3b';
		if (data.warning) {
			warning = 'Warning. ';
		}
 		if (data.breach) {
 			warning = warning + 'Not Compliant';
 			colour = '#a94442';
 		}
		if(data.mesurementStatusColour == 0) {
			jQuery(msg).text(' ');
		}
		if(data.mesurementStatusColour == 1) {
			jQuery(msg).text(warning);
			jQuery(msg).attr('style', 'float:left;color:'+colour+';font-weight:bold;');
		}
		if(data.mesurementStatusColour == 2) {
			jQuery(msg).text(warning);
			jQuery(msg).attr('style', 'float:left;color:#a94442;font-weight:bold;');
		}
	}

	function disableFutureDates(cal, date) {
		var today = new Date();
		var disabled = (date.getTime() / DAY) > (today.getTime() / DAY);
		return (disabled);
	}

	function updateDate() {
		jQuery('timePeriod').val(jQuery('#displayDate').val());
	}

	function edit(id, link) {
		var object = document.getElementById('readingComment[' + id + ']');
		visible(object, true);
		visible(link,false);
		SurveyDWRService.getReading(id, function(data) {
			onEditCallback(data);
		});
		return false;
	}

	function onEditCallback(data) {
		if (data.id) {
			displayEdit(data.id, data.amount, data.symbol, data.status, data.notes, data.updateReason);
		}
	}

	function displayEdit(id, amount, symbol, status, notes, updateReason) {
		amount = parseFloat(amount); // truncate trailing zeroes
		hideBlock('readingDisplay[' + id + ']');
		showBlock('readingEdit[' + id + ']');

		var ele = jQuery('#readingAmount[' + id + ']');
		if (ele.type == 'select-one') {
			for (var i = 0; i < ele.options.length; i++) {
				if (parseInt(ele.options[i].value) == parseInt(amount)) {
					ele.selectedIndex = i;
				}
			}
		} else {
			ele.value = amount == null ? "" : amount;
		}
		ele.focus();
		if (status == 'MeasurementReadingStatus[E]') {
			hideBlock('readingCommentLink[' + id + ']');
			showBlock('readingComment[' + id + ']');
			if (updateReason != null) {
				jQuery('#readingComment[' + id + ']').val(updateReason);
			} else {
				if (notes != null)
					jQuery('#readingComment[' + id + ']').val(notes);
				else
					jQuery('readingComment[' + id + ']').val('');
			}
		}
	}

	function save(id) {
		var error = document.getElementById('errorMessage[' + id + ']');
		var linkEdit = document.getElementById('readingCommentLink[' + id + ']');
		var readingComment = document.getElementById('readingComment[' + id + ']');

		visible(linkEdit,false);
		jQuery(error).empty();
		visible(error,false);

		var amount = jQuery('input[id="readingAmount[' + id + ']"]').val();
		var inputType = document.getElementById('readingAmount[' + id + ']').nodeName.toLowerCase();

		// The date in UTC milli seconds.
		var dt = jQuery('#timePeriod').val();
		var readingTime = Date.parseDate(dt, '%d-%b-%Y').valueOf();
		var comment = jQuery(readingComment).find('textarea').val().trim();
		if (inputType == 'input') {
			if (amount != null && amount.search(/^(-)?\d+(\.\d+)?$/) == -1) { // Not a valid number
				// updateStyle(document.getElementById('readingCell[' + id + ']'), "error");
				visible(error,true);
				jQuery(error).attr('style', 'float:left;color:#a94442;font-weight:bold;');
				jQuery(error).append('Invalid character');
				return false;
			} else if (parseFloat(amount) == 0 && comment == "") {
				// If the value is zero, a comment is required for text inputs.
				/* if (jQuery('#readingCommentLink[' + id + ']')) {
					hideBlock('readingCommentLink[' + id + ']');
				} */
				showBlock(readingComment);
				jQuery(readingComment).effect("shake");
				jQuery(readingComment).focus();
				visible(linkEdit,true);
				return;

			} else {
				// updateStyle(document.getElementById('readingCell[' + id + ']'), "edit");
				// 'Please wait...';
				SurveyDWRService.saveReading(id, amount, readingTime, comment, function(data) {
					onSaveCallback(data);
				});
			}
		} else {
			var amount = jQuery('select[id="readingAmount[' + id + ']"]').val();
			if (amount != null && amount !='') {
				SurveyDWRService.saveReading(id, amount, readingTime, comment, function(data) {
					onSaveCallback(data);
				});
			}
		}
		visible(linkEdit,true);
		return false;
	}

	function visible(object,visible) {
		if (!visible) {
			jQuery(object).hide();
			jQuery(object).css('visibility', 'invisible');
		} else {
			jQuery(object).show();
			jQuery(object).css('visibility', 'visible');
		}
	}

	function onSaveCallback(data) {
		if (data.id && data.status == 'MeasurementReadingStatus[E]') {
			displayRead(data);
		}
	}

	function trash(id) {
		if (confirm("Are you sure you want to trash this measurement reading?")) {
			SurveyDWRService.trashReading(id, function(data) {
				onTrashCallback(data);
			});
		}
	}

	function onTrashCallback(data) {
		if (data.id && data.status == 'MeasurementReadingStatus[T]') {
			displayRead(data);
		}
	}

	function displayRead(data) {
		var element = document.getElementById('readingDisplay[' + data.id + ']');
		if (data.status == 'MeasurementReadingStatus[E]') {
			element.innerHTML = data.customUnitValueOfUnitSelected;
		} else if (data.status == 'MeasurementReadingStatus[T]') {
			jQuery('#queryForm').submit();
			return;
		}

		hideBlock('readingEdit[' + data.id + ']');
		showBlock('readingDisplay[' + data.id + ']');

		showWarning(data);
	}

	function editIcon(id, displayIcon) {
		//var cell = jQuery('#readingCell[' + id + ']'); for some reason jquery is not working when use element id with special character like [ ... ]
		var cell = document.getElementById('readingCell[' + id + ']');
		if (isBlockShown(jQuery('readingDisplay[' + id + ']'))) {
			css.addClassToElement(cell, "editable");
		}
	}

	function updateStyle(element, newStyle) {
		jQuery(element).removeClass("edit modified error warning breach").addClass(newStyle);

	}

	function init() {
		jQuery('#queryForm').submit();
	}
</script>

<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
@import "<c:url value='/css/survey.css'/>";

* th.header {
	padding-top: 10px; white-space: nowrap;
}

td.editable {
	background: url(< c : url value = "/images/open.gif"/ >) no-repeat scroll right top; background-color: #FCEFAA;
}

table tr td.edit {
	background-color: #EACE88;
}

table tr td.modified {
	background-color: #AAFF66;
}

.error {
	border: #a94442 solid 1px;
}

.warning {
	border: #8a6d3b solid 1px;
}

.breach {
	border: #a94442 solid 1px;
}
</style>
<title><fmt:message key="surveyDataEntry" /></title>
</head>
<body>

	<form id="queryForm" action="<c:url value="/survey/readingQuery.ajax" />"
		onsubmit="jQuery('#timePeriod').val(jQuery('#displayDate').val());;return search(this, 'resultsDiv');">
		<input type="hidden" name="calculateTotals" value="true" />
		<input type="hidden" name="pageNumber" value="1" />
		<input type="hidden" id="pageSize" name="pageSize" />

		<input type="hidden" name="viewName" value="dataEntryQueryResult" />
		<input type="hidden" name="displayTrash" value="true" />
		<input type="hidden" name="authorisedUserId" value="<c:out value="${currentUser.id}" />" />
		<input type="hidden" name="active" value="true" />
		<input type="hidden" name="timePeriodDate" id="timePeriod" />
		<input type="hidden" name="sortName" value="frequency" />

<!-- 		<div class="header"> -->
<!-- 			<h2> -->
<%-- 				<fmt:message key="surveyDataEntry" /> --%>
<!-- 			</h2> -->
<!-- 		</div> -->
		<div class="content">
			<div class="table-responsive">
				<table id="queryTable" class="table table-bordered table-responsive">


					<tbody>
						<tr class="form-group">
							<td class="searchLabel"><fmt:message key="date" />:</td>
							<td class="search">
								<div class="col-sm-6" style="width: 250px;">
									<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy">
										<input class="form-control" id="displayDate" style="min-width: 150px;" size="11" value="<fmt:formatDate value="${currentDate}" pattern="dd-MMM-yyyy" />" type="text" value="" readonly>
										<span class="input-group-addon btn btn-primary" >
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div> <%-- <input type="text" id="displayDate" size="11" name="displayName" value="<fmt:formatDate value="${currentDate}" pattern="dd-MMM-yyyy" />" readonly="readonly">
			<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'displayDate', false);"> --%>
							</td>

							<td class="searchLabel"><fmt:message key="quantityCategory" />:</td>
							<td class="search"><select name="quantityCategoryId" id="quantityCategoryId">
									<option value="">Choose</option>
									<c:forEach items="${quantityCategoryList}" var="x">
										<option value="<c:out value="${x.id}" />"><c:out value="${x.name}" /></option>
									</c:forEach>
								</select></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" style="text-align: center">
								<%-- Use a button rather than Submit so that pressing the Enter key within the page will not submit the form --%>
								<button type="button" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value=1;this.form.onsubmit();">
									<fmt:message key="search" />
								</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
		<div id="resultsDiv"></div>

	</form>

	<div id="test"></div>
</body>
</html>
