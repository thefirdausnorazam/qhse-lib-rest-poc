
//ENV-7835: Select2 looks funny on scrolling page
function hideSearchDivSelect2WhenScrolling() {
	jQuery(document)
			.scroll(
					function() {
						if (jQuery(".select2-with-searchbox").is(":visible") == true) {
							jQuery(".select2-with-searchbox").hide();
							if (jQuery(".select2-dropdown-open").is(":visible") == true) {
								jQuery(".select2-container-active")
										.removeClass(
												"select2-container-active select2-drop-above select2-dropdown-open");
								jQuery('.select2-drop-mask').hide();
							}
						}
					});
}

function setFooterColSpan() {
	var colspan = jQuery("table.dataTableRA > tbody").find("> tr:first > td").length;
	jQuery("table.dataTableRA > tfoot tr td").attr('colSpan', colspan);
}

function setFooterColSpanById(elementId) {
	var colspan = jQuery("#" + elementId + " > tbody").find("> tr:first > td").length;
	jQuery("#" + elementId + " > tfoot tr td").attr('colSpan', colspan);
}

// Use this when want your table to have columns sortable
function initSortTables() {
	initSortTablesForElement('.dataTable');
}


// Use this when want your table to have columns sortable
function initSortTablesForClass(node) {
	initSortTablesForElement('.' + node);
}

// Use this when want your table to have columns sortable
function initSortTablesForId(node) {
	initSortTablesForElement('#' + node);
}

///###### With call backs
function initSortTablesCallBack() {
	initSortTablesForElementCallBack('.dataTable');
}


// Use this when want your table to have columns sortable
function initSortTablesForClassCallBack(node) {
	initSortTablesForElementCallBack('.' + node);
}

// Use this when want your table to have columns sortable
function initSortTablesForIdCallBack(node) {
	initSortTablesForElementCallBack('#' + node);
}
////######
//Use this when want your table to have columns sortable
function initSortTablesForClass(node, anyNumber) {
	if(anyNumber == "YES"){
		anyNumber= "YES";
	}
	initSortTablesForElement('.' + node);
}
// custom order for mixed values (text and number)
var anyNumber = "false";
_anyNumberSort = function(a, b, high) {
    var reg = /[+-]?((\d+(\.\d*)?)|\.\d+)([eE][+-]?[0-9]+)?/;       
    a = a.replace(',','.').match(reg);
    a = a !== null ? parseFloat(a[0]) : high;
    b = b.replace(',','.').match(reg);
    b = b !== null ? parseFloat(b[0]) : high;
    return ((a < b) ? -1 : ((a > b) ? 1 : 0));   
}
 
jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "any-number-asc": function (a, b) {
        return _anyNumberSort(a, b, Number.POSITIVE_INFINITY);
    },
    "any-number-desc": function (a, b) {
        return _anyNumberSort(a, b, Number.NEGATIVE_INFINITY) * -1;
    }
});
// Use this when want your table to have columns sortable
function initSortTablesForElement(node) {
	$.fn.dataTable.moment('DD-MMM-YYYY'); // 11-Jul-2015
	$.fn.dataTable.moment('DD-MMM-YYYY HH:mm'); // 11-Jul-2015 12:30
	jQuery('.recordsPerPage > select').select2();
	var idSelector = ':contains("ID")';
	var targetSelector = ':contains("Target Achievement")';

	jQuery(node + ' th').each(function() {
		if (jQuery(this).is(idSelector)) {
			jQuery(this).attr('aria-sort', 'descending');
			jQuery(this).attr('colspan', '1');
			jQuery(this).attr('rowspan', '1');
			jQuery(this).attr('aria-controls', 'datatable');
			jQuery(this).attr('tabindex', '0');
			jQuery(this).attr('role', 'columnheader');
			jQuery(this).addClass('class', 'sorting_desc natural-sort');
			jQuery(this).attr('sType', 'natural-nohtml');
		} else if (jQuery(this).is(targetSelector)) {
			jQuery(this).attr('class', 'datatable-nosort');
		} else if (jQuery(this).contents().length == 0) {
			jQuery(this).attr('class', 'datatable-nosort');
		} else {
			jQuery(this).attr('aria-sort', '');
			jQuery(this).attr('colspan', '1');
			jQuery(this).attr('rowspan', '1');
			jQuery(this).attr('aria-controls', 'datatable');
			jQuery(this).attr('tabindex', '0');
			jQuery(this).attr('role', 'columnheader');
			jQuery(this).addClass('class', 'sorting');
			jQuery(this).attr('sType', 'natural-nohtml');
		}
	});
	var sTypeConfig = "natural-nohtml-id";
	var targetsConfig = "sortByNumber";
	if(anyNumber){
		sTypeConfig = "any-number";
		targetsConfig = 0;
	}
	var table = jQuery(node).DataTable(
			{
				"bPaginate" : false,
				"bInfo" : false,
				"order" : [],
				"aaSorting" : [],
				"fnRowCallback" : function(nRow, aData, iDisplayIndex,
						iDisplayIndexFull) {
					// var gcse = $('td:eq(2)', nRow), // cache lookup
					// grade = $('td:eq(3)', nRow); // cache lookup
					// alert(aData[0].replace('MPT', '').replace('SubT', ''))
					// gcse.html(gcse.text());
					// grade.html(grade.text());
				},
				"oLanguage" : {
					"sSearch" : SCANNELL_TRANSLATIONS.searchOnPage,
					"sEmptyTable" : SCANNELL_TRANSLATIONS.noResultsFound
				// ,
				// "sZeroRecords":"No results found for this search"
				},
				// this property allow us to include arrays of column feature
				// targets
				"aoColumnDefs" : [ {
					sType : sTypeConfig,
					targets : targetsConfig
				}, {
					targets : "datatable-nosort",
					orderable : false,
					bsort : false
				} ]

			});

	var count = 0;
	jQuery('.paging').each(
			function() {
				if (!(count & 1)) // Only use even paging elements
				{
					jQuery(this).prependTo(
							jQuery(this).closest('div').find(
									'.dataTables_filter'));
				}
				count++;
			});
	jQuery('.dataTables_filter input').addClass('form-control').attr(
			'placeholder', 'Search');
	jQuery('.dataTables_length select').addClass('form-control');
}

function initSortTablesForElementCallBack(node) {
	$.fn.dataTable.moment('DD-MMM-YYYY'); // 11-Jul-2015
	$.fn.dataTable.moment('DD-MMM-YYYY HH:mm'); // 11-Jul-2015 12:30
	jQuery('.recordsPerPage > select').select2();
	var idSelector = ':contains("ID")';
	var targetSelector = ':contains("Target Achievement")';

	jQuery(node + ' th').each(function() {
		if (jQuery(this).is(idSelector)) {
			jQuery(this).attr('aria-sort', 'descending');
			jQuery(this).attr('colspan', '1');
			jQuery(this).attr('rowspan', '1');
			jQuery(this).attr('aria-controls', 'datatable');
			jQuery(this).attr('tabindex', '0');
			jQuery(this).attr('role', 'columnheader');
			jQuery(this).addClass('class', 'sorting_desc natural-sort');
			jQuery(this).attr('sType', 'natural-nohtml');
		} else if (jQuery(this).is(targetSelector)) {
			jQuery(this).attr('class', 'datatable-nosort');
		} else if (jQuery(this).contents().length == 0) {
			jQuery(this).attr('class', 'datatable-nosort');
		} else {
			jQuery(this).attr('aria-sort', '');
			jQuery(this).attr('colspan', '1');
			jQuery(this).attr('rowspan', '1');
			jQuery(this).attr('aria-controls', 'datatable');
			jQuery(this).attr('tabindex', '0');
			jQuery(this).attr('role', 'columnheader');
			jQuery(this).addClass('class', 'sorting');
			jQuery(this).attr('sType', 'natural-nohtml');
		}
	});
	var sTypeConfig = "natural-nohtml-id";
	var targetsConfig = "sortByNumber";
	if(anyNumber){
		sTypeConfig = "any-number";
		targetsConfig = 0;
	}
	var table = jQuery(node).DataTable(
			{
				"bPaginate" : false,
				"bInfo" : false,
				"order" : [],
				"aaSorting" : [],
				"fnRowCallback" : function(nRow, aData, iDisplayIndex,
						iDisplayIndexFull) {
					// var gcse = $('td:eq(2)', nRow), // cache lookup
					// grade = $('td:eq(3)', nRow); // cache lookup
					// alert(aData[0].replace('MPT', '').replace('SubT', ''))
					// gcse.html(gcse.text());
					// grade.html(grade.text());
				},
				"drawCallback": function( settings ) {
					afterProcess();
				    },
				"oLanguage" : {
					"sSearch" : SCANNELL_TRANSLATIONS.searchOnPage,
					"sEmptyTable" : SCANNELL_TRANSLATIONS.noResultsFound
				// ,
				// "sZeroRecords":"No results found for this search"
				},
				// this property allow us to include arrays of column feature
				// targets
				"aoColumnDefs" : [ {
					sType : sTypeConfig,
					targets : targetsConfig
				}, {
					targets : "datatable-nosort",
					orderable : false,
					bsort : false
				} ]

			});

	var count = 0;
	jQuery('.paging').each(
			function() {
				if (!(count & 1)) // Only use even paging elements
				{
					jQuery(this).prependTo(
							jQuery(this).closest('div').find(
									'.dataTables_filter'));
				}
				count++;
			});
	jQuery('.dataTables_filter input').addClass('form-control').attr(
			'placeholder', 'Search');
	jQuery('.dataTables_length select').addClass('form-control');
}

//Use this table to process table after dataTable function called
function afterProcess(){
	//hide unwanted rows
	jQuery(".deleteRow").hide();
}
// Use this when want your table to have columns sortable
function initSortTablesBySelector(tableNode, selector) {
	// jQuery.fn.dataTable.moment( 'DD-MMM-YYYY' ); //11-Jul-2015
	jQuery('.recordsPerPage > select').select2();
	var selector = ':contains("' + selector + '")';

	jQuery('.' + tableNode + ' th').each(function() {
		if (jQuery(this).is(selector)) {
			jQuery(this).attr('aria-sort', '');
			jQuery(this).attr('colspan', '1');
			jQuery(this).attr('rowspan', '1');
			jQuery(this).attr('aria-controls', 'datatable');
			jQuery(this).attr('tabindex', '0');
			jQuery(this).attr('role', 'columnheader');
			jQuery(this).addClass('class', 'sorting');
			jQuery(this).attr('sType', 'natural-nohtml');
		} else {
			jQuery(this).attr('class', 'datatable-nosort');
		}
	});
	var table = jQuery('.' + tableNode).DataTable(
			{
				"bPaginate" : false,
				"bInfo" : false,
				"order" : [],
				"aaSorting" : [],
				"fnRowCallback" : function(nRow, aData, iDisplayIndex,
						iDisplayIndexFull) {
					// var gcse = $('td:eq(2)', nRow), // cache lookup
					// grade = $('td:eq(3)', nRow); // cache lookup
					// alert(aData[0].replace('MPT', '').replace('SubT', ''))
					// gcse.html(gcse.text());
					// grade.html(grade.text());
				},
				"oLanguage" : {
					"sSearch" : SCANNELL_TRANSLATIONS.searchOnPage,
					"sEmptyTable" : SCANNELL_TRANSLATIONS.noResultsFound
				// ,
				// "sZeroRecords":"No results found for this search"
				},
				// this property allow us to include arrays of column feature
				// targets
				"aoColumnDefs" : [ {
					sType : "natural-nohtml-id",
					targets : "sortByNumber"
				}, {
					targets : "datatable-nosort",
					orderable : false,
					bsort : false
				} ]

			});

	var count = 0;
	jQuery('.paging').each(
			function() {
				if (!(count & 1)) // Only use even paging elements
				{
					jQuery(this).prependTo(
							jQuery(this).closest('div').find(
									'.dataTables_filter'));
				}
				count++;
			});
	jQuery('.dataTables_filter input').addClass('form-control').attr(
			'placeholder', 'Search');
	jQuery('.dataTables_length select').addClass('form-control');
}

function innerText(node) {
	if (node.nodeType == 3 || node.nodeType == 4) {
		return node.data;
	}
	var returnValue = [];
	for (var i = 0; i < node.childNodes.length; i++) {
		returnValue.push(innerText(node.childNodes[i]));
	}
	return returnValue.join('');
}

function innerTextStatus(node) {
	var text = innerText(node);
	var semiColon = text.indexOf(":");
	return semiColon > 0 ? text.substring(0, semiColon) : text;
}

function filterTable(filterRowId, rowsOwnerId) {
	var filterRow = jQuery('#' + filterRowId);
	var rows = jQuery('#' + rowsOwnerId)[0].rows;

	var filters = new Array();
	for (var i = 0; i < filterRow[0].cells.length; i++) {
		var cell = filterRow[0].cells[i];
		var selects = cell.getElementsByTagName("SELECT");
		if (selects.length != 0) {
			var selected = jQuery("#" + selects[0].id + " option:selected");
			filters.push(selected.val() == "" ? "" : selected.text());
		} else {
			filters.push("");
		}
	}
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		var visible = true;
		for (var j = 0; j < filters.length; j++) {
			if (row.cells[j] != undefined) {
				if (filters[j].length > 0
						&& innerTextStatus(row.cells[j]).indexOf(filters[j]) < 0) {
					visible = false;
				}
			}
		}
		row.style.display = visible ? "" : "none";
	}
}

function getURLParam(paramName) {
	var href = window.location.href;
	paramName = paramName + "=";
	if (href.indexOf("?") >= 0 && href.indexOf(paramName) >= 0) {
		var str = href.substr(href.indexOf(paramName) + paramName.length);
		if (str.indexOf("&") >= 0) {
			str = str.substr(0, str.indexOf("&"));
		}
		return str;
	}
	return null;
}

function doJumpto() {
	var jumpto = getURLParam("jumpto");
	if (jumpto != null) {
		document.location = "#" + jumpto;
	}
}

function resize() {
	var bodyDiv = document.getElementById("bodyCentreDiv");
	if (bodyDiv) {
		var menuDiv = document.getElementById("bodyLeftDiv");
		var rightDiv = document.getElementById("bodyRightDiv");
		var h = get_windowHeight() - 158;
		var w = get_windowWidth() - 275;
		if (w > 0 && h > 0) {
			bodyDiv.style.width = w;
			bodyDiv.style.height = h;
			menuDiv.style.height = h;
			rightDiv.style.height = h;
		}
	}
}

var scrollToResultDiv = false;

var onCompleteFn = function() {
	(scrollToResultDiv == true) ? searchPosition : Prototype.emptyFunction;
	return;
};

function search(form, targetElementId, scrollToResults) {
	if (scrollToResults) {
		scrollToResultDiv = true;
	}

	jQuery('#' + targetElementId)
			.html(
					'<table class="table table-bordered table-responsive"><thead><tr><th>'+SCANNELL_TRANSLATIONS.loadingData+'</th></tr></thead></table>');
	jQuery.ajax({
		url : jQuery(form).attr('action'),
		type : "post",
		dataType : "html",
		data : jQuery(form).serialize(form),
		success : function(returnData) {
			jQuery('#' + targetElementId).html(returnData);
		},
		cache : false,
		error : function(e) {
			alert('Error : ' + e);
		}
	});
	scrollToResultDiv = true;
	return false;
}

function ajaxGet(url, parms, callback) {
	var myAjax = jQuery.ajax({
		url : url + '?' + parms,
		cache : false,
		complete : callback
	});
}

function ajaxPost(url, parms, callback) {
	var myAjax = new Ajax.Request(url,
			{
				method : 'post',
				parameters : parms,
				onComplete : callback,
				requestHeaders : [ 'If-Modified-Since',
						'Tue, 01 Jan 1980 12:00:00 GMT' ]
			});
}

function searchPosition() {
	document.location = "#fragmentTop";
}

function showChart(url) {
	var width = "600";
	var height = "480";
	var w = parseInt(width, 10) + 50;
	var h = parseInt(height, 10) + 50;
	openWindow(url + "&chartWidth=640&chartHeight=480", w, h, false, "summary",
			true);
}
function summarise(form, url) {
	var width = "600";
	var height = "480";

	summariseChart(form, url, width, height);
}
function summariseChart(form, url, width, height) {
	url = buildFormUrl(url, form);
	for (var i = 0; i < form.elements.length; i++) {
		if ("chartWidth" == form.elements[i].name) {
			width = form.elements[i].value;
		} else if ("chartHeight" == form.elements[i].name) {
			height = form.elements[i].value;
		}
	}
	var w = parseInt(width, 10) + 50;
	var h = parseInt(height, 10) + 50;
	url = url + "&desc=" + getFilterDescription(form);
	jQuery(document.body).append('<div id="dialogDivChart"></div>');

	jQuery("#dialogDivChart")
			.html(
					'<iframe id="dialogFrameChart" width="900" height="500" marginWidth="0" marginHeight="0" frameBorder="0" close="no" src="about:blank" />');

	jQuery("#dialogDivChart").dialog(
			{
				title : "View Chart",
				height : 'auto',
				width : 950,
				modal : true,
				resizable : false,
				draggable : false,
				autoOpen : false,
				buttons : [ {
					text : "Close",
					class: 'g-btn g-btn--primary',
					icons : {
						primary : "ui-icon-closethick"
					},
					id : "closebtn",
					click : function() {
						var $this = jQuery(this);
						$this.dialog("close");

					}
				} ],
				open : function() {

					jQuery(this).closest(".ui-dialog").find(
							".ui-dialog-titlebar-close").removeClass(
							"ui-dialog-titlebar-close").html(
							"<span class='fa fa-times fa-lg'></span>");

				}
			});

	jQuery("#dialogFrameChart").attr("src", encodeURI(url));
	jQuery("#dialogDivChart").dialog("open");

	// openWindow(url, w, h, false, "summary", true);
	// return false;
}

/*
 * Converts a form that uses captions for labels into a scring of the form
 * label1="value1", label2="value2" for all imputs with a value set.
 */
function getFilterDescription(frm) {
	var desc = "";
	var labels = frm.getElementsByTagName("label");
	for (var i = 0; i < labels.length; i++) {
		var label = labels[i];
		var input = document.getElementById(label.htmlFor);
		var value = null;
		// if (input == null) {
		// alert("no input found with id: " + label.htmlFor);
		// }
		if (input != null) {
			if (input.tagName == "INPUT") {
				if (input.type == "checkbox") {
					if (input.checked) {
						value = "Yes"
					}
				} else if (input.type == "radio") {
					if (input.checked && input.value.length > 0) {
						value = input.alt;
					}
				} else if (input.value != "") {
					value = input.value;
				}
			} else if (input.tagName == "SELECT") {
				var selectedOpt = input.options[input.selectedIndex];
				if (selectedOpt.value != "") {
					value = selectedOpt.text;
				}
			}
			if (value != null) {
				var labelName = label.innerHTML.trim();
				desc = desc + " " + labelName + "=\"" + value + "\"";
			}
		}
	}
	return desc;
}

function get_windowHeight() {
	var myWidth = 0, myHeight = 0;
	if (typeof (window.innerWidth) == 'number') { // Non-IE
		myHeight = window.innerHeight;
	} else {
		if (document.documentElement
				&& (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
			// IE 6+ in 'standards compliant mode'
			myHeight = document.documentElement.clientHeight;
		} else {
			if (document.body
					&& (document.body.clientWidth || document.body.clientHeight)) {
				// IE 4 compatible
				myHeight = document.body.clientHeight;
			}
		}
	}
	return myHeight;
}

function get_windowWidth() {
	var myWidth = 0;
	if (typeof (window.innerWidth) == 'number') {
		// Non-IE
		myWidth = window.innerWidth;
	} else {
		if (document.documentElement
				&& (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
			// IE 6+ in 'standards compliant mode'
			myWidth = document.documentElement.clientWidth;
		} else {
			if (document.body
					&& (document.body.clientWidth || document.body.clientHeight)) {
				// IE 4 compatible
				myWidth = document.body.clientWidth;
			}
		}
	}
	return myWidth;
}

function getElement(name) {
	if (document.getElementById(name)) {
		return document.getElementById(name);
	} else if (document.layers && document.layers[name]) {
		return document.layers[name];
	} else if (document.all && document.all[name]) {
		return document.all[name];
	} else if (document[name]) {
		return document[name];
	} else {
		return 0;
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

// Create a new HTML element of type
function createElement(elementType, parent, inputType) {
	var el = null;
	if (document.createElementNS) {
		// use the XHTML namespace; IE won't normally get here unless
		// _they_ "fix" the DOM2 implementation.
		el = document.createElementNS("http://www.w3.org/1999/xhtml",
				elementType);
	} else {
		el = document.createElement(elementType);
	}

	if (/* elementType == "input" && */inputType) {
		el.type = inputType;
	}

	if (typeof parent != "undefined") {
		parent.appendChild(el);
	}
	return el;
} // End of createElement()

// ******************************************************************************
function copyHtml(sourceId, targetId) {
	var source = getElement(sourceId);
	var target = getElement(targetId);
	if (source && target) {
		target.innerHTML = source.innerHTML;
	}
}

function setHTML(targetId, htmlStr) {
	var target = getElement(targetId);
	if (target) {
		target.innerHTML = htmlStr;
	}
}

// ******************************************************************************
function showBlock(id) {
	var target = getElement(id);
	if (target) {
		target.style.display = "block";
		target.style.visibility = "visible";
	}
}

function hideBlock(id) {
	var target = getElement(id);
	if (target) {
		target.style.display = "none";
		target.style.visibility = "hidden";
	}
}

function isBlockShown(id) {
	return !isBlockHidden(id);
}

function isBlockHidden(id) {
	var target = getElement(id);
	if (target) {
		if (target.style.display == "none") {
			return (true);
		} else {
			return (false);
		}
	}
}

function toggleBlock(id) {
	if (getElement(id)) {
		if (isBlockHidden(id)) {
			showBlock(id);
		} else {
			hideBlock(id);
		}
	}
}

function deleteRow(targetRow) {
	if (targetRow != null) {
		var table = getParent("table", targetRow);
		table.deleteRow(targetRow.rowIndex);
	}
}

/**
 * relativeUrl: The url. frm: A string ID of the from object or the form object
 * itself. ignoreElements: An array contain the names of inputs to be ignored
 * when creating the url. submitMultipleSelectRegardless: If all items in a
 * multiple select are to be submitted regardless of been checked.
 */
function buildFormUrl(relativeUrl, frm, ignoreElements,
		submitMultipleSelectRegardless) {
	var url = contextPath + relativeUrl;
	if (frm) {
		if (typeof frm == "string") {
			frm = getElement(frm);
		}
		if (frm) {
			url += "?";

			startOfLoop: for (var i = 0; i < frm.elements.length; i++) {
				if (isInArray(frm.elements[i].name, ignoreElements)) {
					debug("Ignoring parameter '" + frm.elements[i].name
							+ "' while building relativeURL '" + relativeUrl
							+ "'.");
					continue startOfLoop;
				}
				var parameter = "";

				// Possible input types are as follows: button, checkbox, file,
				// hidden, image,
				// password, radio, reset, select-multiple, select-one, submit,
				// text and textarea
				switch (frm.elements[i].type.toUpperCase()) {

				case "BUTTON":
				case "IMAGE":
				case "RESET":
				case "SUBMIT":
					// Don't care about button, image, reset or submit.
					break;

				case "CHECKBOX":
					if (frm.elements[i].checked) {
						parameter = frm.elements[i].name + "="
								+ escape(frm.elements[i].value);
					}

					// The below will submit either true or false (which is not
					// the default behaviour for checkboxes!)
					// parameter = frm.elements[i].name + "=" +
					// frm.elements[i].checked;
					break;

				case "FILE":
					alert("Input type 'file' is not supported!");
					break;

				case "RADIO":
					if (frm.elements[i].checked) {
						parameter = frm.elements[i].name + "="
								+ escape(frm.elements[i].value);
					}
					break;

				case "SELECT-MULTIPLE":
					// Other SELECT types are "SELECT-ONE"
					var foundOne = false;
					for (var j = 0; j < frm.elements[i].options.length; j++) {
						if (submitMultipleSelectRegardless
								|| frm.elements[i].options[j].selected) {
							if (foundOne) {
								parameter += "&";
							}
							parameter += frm.elements[i].name + "="
									+ escape(frm.elements[i].options[j].value);
							foundOne = true
						}
					}
					// parameter += frm.elements[i].name + "Size=" + count;
					break;

				case "HIDDEN":
				case "PASSWORD":
				case "SELECT-ONE":
				case "TEXT":
				case "TEXTAREA":
				default:
					parameter = frm.elements[i].name + "="
							+ escape(frm.elements[i].value);
				}
				if (parameter != "") {
					url += parameter + "&";
				}
			}
		}
	}
	return url;
}

/**
 * Return true is 'value' is contains with the array 'inArray', otherwise false.
 */
function isInArray(value, inArray) {
	if (inArray) {
		for (var i = 0; i < inArray.length; i++) {
			if (value == inArray[i]) {
				return true;
			}
		}
	}
	return false;
}

/**
 * NodeList (HTMLCollection) are returned by document.getElementsByTagName() and
 * are not the same as an array. This function allows you to concat any given
 * number of arrays/NodeLists together.
 */
function concatNodeLists() {
	if (!arguments.length) {
		return null;
	}

	var newList = arguments[0];
	for (var i = 1; i < arguments.length; i++) {
		var list = arguments[i];
		for (var j = 0; j < list.length; j++) {
			// Don't use push() for IE 5 compatibility
			// newList.push(list[j]);
			newList[newList.length] = list[j];
		}
	}
	return newList;
}

/**
 * Output debug information the Firefox's console. Remember to set perference
 * 'browser.dom.window.dump.enabled' to true in 'about:config'
 */
function debug(text) {
	if (window.dump) {
		dump(text + "\n");
	} else {
		// alert(text);
	}
}

function getXMLDoc(url, targetId, event) {
	loadXMLDoc(url, targetId, event, "GET");
}

function postXMLDoc(url, targetId, event) {
	loadXMLDoc(url, targetId, event, "POST");
}

function loadXMLDoc(url, targetId, event, method) {
	alert("loadXMLDoc no longer supported");
	return false;
}

/** Scroll Control Paging */
var onPageHandler = false
function page(theForm, pageNumber) {
	if (theForm) {
		if (typeof theForm == "string") {
			theForm = getElement(theForm);
		}

		if (onPageHandler == false) {
			theForm.pageNumber.value = pageNumber;
			if (theForm.onsubmit) { // If there is an onSubmit function, call it
				theForm.onsubmit();
			} else { // otherwise just submit the form.
				theForm.submit();
			}
		} else {
			onPageHandler(theForm, pageNumber);
		}
	}
}

var onPageAllHandler = false
function pageAll(theForm) { // Display all results on a page
	if (theForm) {
		if (typeof theForm == "string") {
			theForm = getElement(theForm);
		}

		if (onPageAllHandler == false) {
			theForm.pageNumber.value = 0;
			var pageSize = theForm.pageSize.value;
			theForm.pageSize.value = 0;
			if (theForm.onsubmit) { // If there is an onSubmit function, call it
				theForm.onsubmit();
			} else { // otherwise just submit the form.
				theForm.submit();
			}
			theForm.pageSize.value = pageSize;
		} else {
			onPageAllHandler(theForm);
		}
	}
}

function addTableHandlers(tableID) {
	var table = getElement(tableID);
	debug("addTableHandlers:" + tableID);
	if (table) {
		var tbody = table.getElementsByTagName("tbody")[0];
		var rows = tbody.getElementsByTagName("tr");
		// add event handlers so rows light up and are clickable
		for (i = 0; i < rows.length; i++) {
			rows[i].className = (i % 2 == 0) ? "even" : "odd";
			rows[i].onmouseover = function() {
				if (!this.previousClass)
					this.previousClass = this.className;
				this.className = ' over';
			};
			rows[i].onmouseout = function() {
				this.className = this.previousClass
			};
		}
	}
}

// START OF Popups

function openWindow(url, w, h, noscrollbars, windowName, resizable) {

	jQuery(document.body).append('<div id="dialogDivWindow"></div>');

	jQuery("#dialogDivWindow")
			.html(
					'<iframe  id="dialogFrameWindow" width="900" height="500" marginWidth="0" marginHeight="0" frameBorder="0" src="about:blank" />');

	jQuery("#dialogDivWindow").dialog(
			{
				height : 'auto',
				width : 950,
				modal : true,
				resizable : false,
				draggable : false,
				autoOpen : false,
				showCloseButton : false,
				buttons : [ {
					text : "Close",
					class: 'g-btn g-btn--primary',
					icons : {
						primary : "ui-icon-closethick"
					},
					id : "closebtn",
					click : function() {
						var $this = jQuery(this);
						$this.dialog("close");

					}
				} ],
				open : function() {
					jQuery(this).closest('.test').find(':button').hide();
					jQuery(this).closest(".ui-dialog").find(
							".ui-dialog-titlebar-close").removeClass(
							"ui-dialog-titlebar-close").html(
							"<span class='fa fa-times fa-lg'></span>");

				}
			});
	jQuery("#dialogFrameWindow").attr("src", url);
	jQuery("#dialogDivWindow").dialog("open");

	return false;
}
// END OF Popups

/** ************* Javascript for the tabs ********************* */
var selectedTab;
function selectTab(selectedTabNumber) {
	selectedTab = selectedTabNumber;
	var numberOfTabs = 5;
	for (i = 1; i < numberOfTabs; i++) {
		if (i == selectedTab) {
			showBlock("content" + i);
			if (getElement("tab" + i)) {
				getElement("tab" + i).className = "tab tabHover tabActive";
			}
		} else {
			hideBlock("content" + i);
			if (getElement("tab" + i)) {
				getElement("tab" + i).className = "tab";
			}
		}
	}
}

function getCookieVal(offset) {
	var endstr = document.cookie.indexOf(";", offset);
	if (endstr == -1) {
		endstr = document.cookie.length;
	}
	return unescape(document.cookie.substring(offset, endstr));
}

function getCookie(name) {
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) {
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg) {
			return getCookieVal(j);
		}
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0)
			break;
	}
	return "";
}

function setCookie(name, value) {
	document.cookie = name + "=" + escape(value) + "; path=/";
}

/**
 * Just as the function name suggests.
 */
function copyFormValuesIfPopup(formId) {
	try {
		if (window.opener && window.opener.document.getElementById(formId)
				&& window.document.getElementById(formId)) {
			copyFormValues(window.opener.document.getElementById(formId),
					window.document.getElementById(formId));
		}
	} catch (err) {
	}
}

/**
 * Copy the values from one form into the the inputs of a second form. Useful to
 * copy the form values from a parent to a popup.
 */
function copyFormValues(fromForm, toForm) {
	new Form.getElements(fromForm)
			.each(function(element) {
				var elements = Form.getElements(toForm);
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].name == element.name) {
						if ([ 'input', 'textarea' ].include(element.tagName
								.toLowerCase())) {
							switch (element.type.toLowerCase()) {
							case 'checkbox':
							case 'radio':
								if (elements[i].value == element.value) {
									elements[i].checked = element.checked;
								}
								break;
							default: // 'hidden', 'password', 'submit',
										// 'text'
								elements[i].value = element.value;
								break;
							}
						} else if ([ 'select' ].include(element.tagName
								.toLowerCase())) {
							elements[i].selectedIndex = element.selectedIndex;
						}
					}
				}
			});
}

function toggleSearch() {
	if (jQuery("#searchToggleLink").text() == SCANNELL_TRANSLATIONS.hideSearchCriteria) {
		jQuery('#searchToggleLink').text(
				SCANNELL_TRANSLATIONS.displaySearchCriteria);
		jQuery('#standardSearchCriteriaTable').hide();
		jQuery('#standardSearchCriteriaTablePanel').hide();
	} else {
		jQuery('#standardSearchCriteriaTable').show();
		jQuery('#standardSearchCriteriaTablePanel').show();
		jQuery('#searchToggleLink').text(
				SCANNELL_TRANSLATIONS.hideSearchCriteria);
	}
}

function toggleQueryTable() {
	displayQueryTable(jQuery('#queryTable').show());
}

function displayQueryTable(display) {
	if (display == true) {
		jQuery("#queryTableToggleLink").html(
				'<i class="fa fa-compress" style="color:white"> </i>&nbsp; '
						+ SCANNELL_TRANSLATIONS.hideSearch + '');
		jQuery('#queryTableTitle').show();
		jQuery('#queryTable').show();
		jQuery('#queryTablePanel').show();

	} else if (jQuery("#queryTableToggleLink").text().trim() == SCANNELL_TRANSLATIONS.hideSearch
			|| jQuery("#queryTableToggleLink").text().trim() == SCANNELL_TRANSLATIONS.hideSearchCriteria) {
		jQuery('#queryTableToggleLink').html(
				'<i class="fa fa-compress" style="color:white"> </i>&nbsp; '
						+ SCANNELL_TRANSLATIONS.displaySearch + '');
		jQuery('#queryTableTitle').hide();
		jQuery('#queryTable').hide();
		jQuery('#queryTablePanel').hide();
	} else if (jQuery("#queryTableToggleLink").text().trim() == SCANNELL_TRANSLATIONS.displaySearch) {
		jQuery("#queryTableToggleLink").html(
				'<i class="fa fa-compress" style="color:white"> </i>&nbsp; '
						+ SCANNELL_TRANSLATIONS.hideSearch + '');
		jQuery('#queryTableTitle').show();
		jQuery('#queryTable').show();
		jQuery('#queryTablePanel').show();
	}
}
// methd created because we could not create a new div with the name queryTable
// to show or hide the title of the form
function displayQueryDiv(display) {
	if (display == true) {
		jQuery('#queryDiv').show();
		jQuery("#queryTableToggleLink").html(
				'<i class="fa fa-compress" style="color:white"> </i> &nbsp;'
						+ SCANNELL_TRANSLATIONS.hideSearch + '');
		jQuery('#queryTableTitle').show();
		jQuery('#queryTable').show();
		jQuery('#queryTablePanel').show();
	} else {
		jQuery('#queryDiv').hide();
		jQuery('#queryTableToggleLink').html(
				'<i class="fa fa-compress" style="color:white"> </i> &nbsp;'
						+ SCANNELL_TRANSLATIONS.displaySearch + '');
		jQuery('#queryTableTitle').hide();
		jQuery('#queryTable').hide();
		jQuery('#queryTablePanel').hide();
	}
}
function toggleQueryDiv() {
	if ("&nbsp;" + jQuery("#queryTableToggleLink").text().trim() == "&nbsp;"+SCANNELL_TRANSLATIONS.displaySearch
			.trim()) {
		displayQueryDiv(true);
	} else {
		displayQueryDiv(false);
	}
}

// Function that will create and display a string summary of the search criteria
// Items to be included in the search summary should have their label wrapped in
// a tag with an ID attribute ending in 'Label' and also have an form element
// with
// an ID attribute the same, but not ending with 'Label'.
// <tr><th id="exampleLabel">Example:</th><td><input type="text"
// id="example"></td></tr>
/*
 * function updateSearchCriteriaSummary() { var str = ''; for (i=0; i<jQuery('searchCriteria').rows.length;
 * i++) { var row = jQuery('searchCriteria').rows[i]; for (j=0; j<row.cells.length;
 * j++) { var id = row.cells[j].getAttribute("id"); if (id &&
 * id.lastIndexOf("Label") == (id.length-5)) { var label =
 * row.cells[j].innerHTML var field = id.substr(0, id.length-5);
 * 
 * str += getText(label, field, str.length > 0);
 *  } } }
 * 
 * jQuery('#searchCriteria.summary').innerHTML = (str.length <= 0) ? '' :
 * 'Search Criteria:- ' + str; }
 */

function updateSearchCriteriaSummary() {
	var s_data = jQuery('#queryForm').serializeArray();
	var searchCriteriaDiv = jQuery('#searchCriteriaDiv');
	var divText = "";
	searchCriteriaDiv.text(" ");
	for (var i = 0; i < s_data.length; i++) {
		var record = s_data[i];
		var name = jQuery('#' + record.name + 'Label').text(); // All id should
																// end with
																// 'Label'
																// string
		var value = jQuery('#' + record.name).val();
		// Few Element are dynamic and addedd through Javascript.
		if ((record.name) && (name == "")) {
			var elemName = document.getElementById(record.name + 'Label');
			var elemValue = document.getElementById(record.name);
			if (elemName) {
				name = document.getElementById(record.name + 'Label').innerText;
				value = "";
				var selectElem = document.getElementById(record.name);
				if (selectElem == null) {
					selectElem = document.getElementById(record.name.replace(
							"[", "_").replace("]", "_"));
				}
				var optionElem = selectElem.options;
				// When we serialize form s_data it contains multiple items for
				// multiple options selected to ignore them check if divText
				// already contains that select element.
				if ((divText.indexOf(name) <= 0)) {
					if (optionElem != null) {
						for (var j = 0, iLen = optionElem.length; j < iLen; j++) {
							if ((optionElem[j].selected == true)
									&& (optionElem[j].value != "")) {
								value += (optionElem[j].text + ", ");
							}
						}
						value = value.substring(0, value.length - 2);
					}
				}
			}
		}
		var tagName = jQuery('#' + record.name).prev().prop('tagName');
		if ((tagName == 'DIV') && jQuery('#' + record.name).val() != "") {
			var searchElement = jQuery('#' + record.name).select2('data');
			if (searchElement != undefined && searchElement != null) {
				divText += (name + " " + searchElement.text + ", ");
			}
		} else if (jQuery('#' + record.name).val() && name) {
			divText += (name + " " + jQuery('#' + record.name).val() + ", ");
		} else if ((value != "") && (name != "")) {
			divText += (name + " " + value + ", ");
		}

	}
	divText = divText.substring(0, divText.length - 2);
	searchCriteriaDiv.append("Search Criteria:- " + divText + ".");
}

function getText(label, element, comma) {
	return Form.Element.getText(element) == ''
			|| Form.Element.getText(element) == ' ' ? '' : (comma ? ', ' : '')
			+ label + Form.Element.getText(element)
}

var scrollToResultDiv = false;
function searchExcelCheck(form, targetElementId, scrollToResults) {
	var exc = jQuery("#excel").val();
	if (exc == 'YES') {
		targetElementId = null;
	}
	if (scrollToResults) {
		scrollToResultDiv = true;
	}

	jQuery('#' + targetElementId)
			.html(
					'<table class="table table-bordered table-responsive"><thead><tr><th>'+SCANNELL_TRANSLATIONS.loadingData+'</th></tr></thead></table>');
	if (exc == 'NO') {
		jQuery.ajax({
			url : jQuery(form).attr('action'),
			type : "get",
			dataType : "html",
			data : jQuery(form).serialize(form),
			success : function(returnData) {
				jQuery('#' + targetElementId).html(returnData);
			},
			cache : false,
			error : function(e) {
				alert('Error : ' + e);
			}
		});
	} else {
		jQuery('body')
				.append(
						'<div id="preparing-file-modal" title="Preparing report..." style="display: none;"> We are preparing your excel report, please wait... <img src="../images/loading.gif" /> </div>');
		jQuery('body')
				.append(
						'<div id="error-modal" title="Error" style="display: none;">There was a problem generating your report, please try again.</div>');
		var preparingFileModal = jQuery("#preparing-file-modal");
		preparingFileModal.dialog({
			modal : true
		});
		jQuery.fileDownload(jQuery(form).attr('action'), {
			successCallback : function(url) {
				preparingFileModal.dialog('close');
			},
			failCallback : function(responseHtml, url) {
				preparingFileModal.dialog('close');
				jQuery("#error-modal").dialog({
					modal : true
				});
			},
			httpMethod : "POST",
			data : jQuery(form).serialize(form)
		});
		resetExcelRequest();// ENV-7675
		return false; // this is critical to stop the click event which will
						// trigger a normal Excel file download!
	}
	scrollToResultDiv = true;
	return false;
}

function excelRequest() {
	jQuery("#excel").val('YES');
	resetSearchRequest();
	jQuery('#criteriaName').val('');
	jQuery('#saveCriteriaChk').prop('checked', false);
}
function resetExcelRequest() {
	jQuery("#excel").val('NO');
	resetSearchRequest();
}
function resetSearchRequest() {
	jQuery("#searhCriteriaId").val('0');
}
