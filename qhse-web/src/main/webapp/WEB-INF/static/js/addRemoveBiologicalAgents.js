function getNextId(prefix, rowIndex) {
	var itemId = rowIndex;
	var item = null;
	while (true) {
		item = document.getElementById('answers[' + prefix + itemId + ']');
		if (item == null) {
			break;
		}
		itemId = itemId + 1;
	}
	return itemId;
}

function addRow(targetRow) {
	var table = getParent("table", targetRow);
	var rowTemplate = table.tBodies[0].rows[0];
	var row = table.tBodies[0].insertRow(-1);
	var rowIndex = row.rowIndex;
	for (var i = 0; i < rowTemplate.cells.length; i++) {
		// if cell is empty ignore it
		if (rowTemplate.cells[i].childNodes.length > 0) {
			// var cell = row.insertCell(row.childNodes.length);
			// cell.innerHTML = rowTemplate.cells[i].innerHTML;
			var cell = rowTemplate.cells[i].cloneNode(true);
			if(cell.getElementsByTagName('input').length > 0 && cell.getElementsByTagName('select').length == 0) {
				cell.getElementsByTagName('input')[0].value = "";
			}
			if(cell.getElementsByTagName('textarea').length > 0) {
				cell.getElementsByTagName('textarea')[0].value = "";
			}
			if(cell.getElementsByTagName('select').length > 0) {
				var options = jQuery(cell).find('option').clone();
				var id = cell.getElementsByTagName('select')[0].id;
				var name = cell.getElementsByTagName('select')[0].id;
				var theClass = cell.getElementsByTagName('select')[0].className;
				var theStyle = cell.getElementsByTagName('select')[0].style.cssText;
				//cell.getElementsByTagName('select')[0].selected = false;
				//cell.getElementsByTagName('select')[0].value = "";
				jQuery(cell).html('<select id="test"></select>');
				options.appendTo(cell.getElementsByTagName('select')[0]);
				cell.getElementsByTagName('select')[0].id = id;
				cell.getElementsByTagName('select')[0].name = name;
				cell.getElementsByTagName('select')[0].className = theClass;
				cell.getElementsByTagName('select')[0].style.cssText = theStyle;
			}
			row.appendChild(cell);
			
			cell.style.display = rowTemplate.cells[i].style.display;
			var id = cell.firstChild.id;
			if(id == '' && cell.getElementsByTagName('span').length > 0) {
				id = cell.firstChild.firstChild.id;
			}
			var idNum = id.substring(id.indexOf('[') + 1, id.indexOf(']'));
			if (rowIndex > 1) {
				id = id.replace(idNum, idNum + "-" + (getNextId(idNum + "-", rowIndex - 1)));
				//cell.firstChild.id = id;
				cell.firstChild.name = id;
				cell.firstChild.defaultValue = "";
				cell.firstChild.value = "";
				cell.firstChild.style.height = "";
				if(cell.getElementsByTagName('span').length > 0) {
					cell.firstChild.firstChild.id = id;
					
					jQuery(cell.firstChild.getElementsByTagName('select')[0]).attr('id', id.replace('s2id_', ''));
					jQuery(cell.firstChild.getElementsByTagName('select')[0]).attr('name', id.replace('s2id_', ''));
					cell.firstChild.firstChild.name = id;
					cell.firstChild.firstChild.defaultValue = "";
					cell.firstChild.firstChild.value = "";
					cell.firstChild.firstChild.style.height = "";
					
				}
				if(cell.getElementsByTagName('select').length > 0) {
					jQuery(cell.getElementsByTagName('select')[0]).select2();
				}
				// if(cell.firstChild.className.indexOf("tableScrollList") !=
				// -1){
				// ENV-3891 and ENV-3925
				/*
				 * if(cell.firstChild.className == "tableScrollList"){ for(var
				 * k=0; k < cell.firstChild.childNodes.length; k++){
				 * cell.firstChild.childNodes[k].firstChild.name = id;
				 * cell.firstChild.childNodes[k].firstChild.checked = false;
				 * cell.firstChild.childNodes[k].firstChild.defaultChecked =
				 * false; } }
				 */
			}
			if (rowTemplate.cells[i].firstChild.value == 'Add') {
				cell.firstChild.value = 'Add';
			}
			if (rowTemplate.cells[i].firstChild.value == 'Del') {
				cell.innerHTML = "<input type='button' class='delete btn btn-primary' onclick='deleteRow(getParent(\"tr\",this));' value='Del'/>";
			}
		}
	}
	// if the row has a sub table then add it below the table
	var tableId = table.id.substring(table.id.indexOf('[') + 1, table.id.indexOf(']'));
	var subTables = getOriginalSubTableElementsByPartialName(tableId);
	var allSubTables = getElementsByPartialName(tableId);
	for (var i = 0; i < subTables.length; i++) {
		var newDiv = document.createElement("div");
		newDiv.innerHTML = subTables[i].innerHTML;
		newDiv.className = subTables[i].className;
		var divId = subTables[i].id;
		var divTableId = divId.substring(divId.indexOf('[') + 1, divId.indexOf(']'));
		if (rowIndex > 1) {
			newDiv.id = divId.replace(divTableId, divTableId + "-" + (getNextId(idNum + "-", rowIndex - 1)));
		}
		// reset values in sub tables
		if (newDiv.firstChild.childNodes.length > 0) {
			var newRow = newDiv.firstChild.tBodies[0].firstChild
			for (var j = 0; j < newRow.cells.length; j++) {
				var cell = newRow.cells[j];
				var id = cell.firstChild.id;
				var idNum = id.substring(id.indexOf('[') + 1, id.indexOf(']'));

				if (rowIndex > 1) {
					id = id.replace(idNum, idNum + "-" + (getNextId(idNum + "-", rowIndex - 1)));
					cell.firstChild.id = id;
					cell.firstChild.name = id;
					cell.firstChild.value = "";
					// no longer using checkboxes
					// if(cell.firstChild.className.indexOf("tableScrollList")
					// != -1){
					/*
					 * if(cell.firstChild.className == "tableScrollList"){
					 * //reset checkboxes for(var k=0; k <
					 * cell.firstChild.childNodes.length; k++){
					 * cell.firstChild.childNodes[k].firstChild.name = id;
					 * cell.firstChild.childNodes[k].firstChild.checked = false;
					 * cell.firstChild.childNodes[k].firstChild.defaultChecked =
					 * false; } }
					 */
				}
				// end reset values
			}
		} else {
			var id = newDiv.firstChild.id;
			var idNum = id.substring(id.indexOf('[') + 1, id.indexOf(']'));
			if (rowIndex > 1) {
				id = id.replace(idNum, idNum + "-" + (getNextId(idNum + "-", rowIndex - 1)));
				newDiv.firstChild.id = id;
				newDiv.firstChild.name = id;
				if (newDiv.firstChild.getAttribute("defaultValue") != null) {
					newDiv.firstChild.value = newDiv.firstChild.attributes["defaultValue"].value;
				} else {
					newDiv.firstChild.value = "";
				}
			}
		}

		// rename id numbers to index+1 ...
		// insertDiv in table
		var tbody = getParent("tbody", allSubTables.last());
		var trparent = getParent("tr", allSubTables.last());

		var newTableRow = tbody.insertRow(trparent.rowIndex + 1 + i);
		newTableRow.insertCell(0);
		var cell = newTableRow.insertCell(1);
		// insert label
		cell.insertBefore(newDiv, null);
	}
}

function getOriginalSubTableElementsByPartialName(partialName) {
	var retVal = new Array();
	var elems = document.getElementsByTagName("div");
	var offset = partialName.length;

	for (var i = 0; i < elems.length; i++) {
		var nameProp = elems[i].getAttribute('id');
		if (!(nameProp == null)) {
			var idNum = nameProp.substring(nameProp.indexOf('[') + 1, nameProp.indexOf(']'));
			if ((nameProp.substr(0, offset) == partialName)) {
				if (nameProp.substring(nameProp.indexOf(idNum) + offset, nameProp.indexOf(idNum) + offset + 1) != "-") {
					retVal.push(elems[i]);
				}
			}
		}
	}
	return retVal;
}

function getElementsByPartialName(partialName) {
	var retVal = new Array();
	var elems = document.getElementsByTagName("div");
	var offset = partialName.length;

	for (var i = 0; i < elems.length; i++) {
		var nameProp = elems[i].getAttribute('id');

		if (!(nameProp == null) && (nameProp.substr(0, offset) == partialName))
			retVal.push(elems[i]);
	}

	return retVal;
}

function getElementBySubName(partialName) {
	var retVal;
	var elems = document.getElementsByTagName("div");
	var offset = partialName.length;

	for (var i = 0; i < elems.length; i++) {
		var nameProp = elems[i].getAttribute('id');

		if (!(nameProp == null) && (nameProp.indexOf(partialName) > 0)) {
			retVal = elems[i];
			break;
		}
	}

	return retVal;
}

function getSubTablesForRow(subTables, rowNumber) {
	var toReturn = new Array();
	var row;
	for (var i = 0; i < subTables.length; i++) {
		var tableId = subTables[i].id.substr(0, subTables[i].id.indexOf('-'));
		var subTable = subTables[i].id.substr(tableId.length + 1, subTables[i].id.indexOf(']'));
		if (subTable.indexOf('-') > 0) {
			var tableEntry = subTable.substring(subTable.indexOf('-') + 1, subTable.indexOf(']'));
			row = parseInt(tableEntry);
		} else if (rowNumber == 0) {
			toReturn.push(subTables[i]);
		}
		if (row == rowNumber) {
			toReturn.push(subTables[i]);
		}
	}
	return toReturn;
}

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

function deleteRow(targetRow) {
	if (targetRow != null) {
		var rowIndex = targetRow.rowIndex;
		if (rowIndex == null) {
			var tr = getParent("tr", targetRow);
			rowIndex = tr.rowIndex;
		}
		var table = getParent("table", targetRow);
		table.deleteRow(rowIndex);
		// delete any children of row
		var idNum = table.id.substring(table.id.indexOf('[') + 1, table.id.indexOf(']'));
		var childrenToDelete = getElementsByPartialName(idNum);
		var index = rowIndex - 1 + "]";
		for (var i = 0; i < childrenToDelete.length; i++) {
			if (childrenToDelete[i].id.indexOf("-" + index) > 0) {
				var tr = childrenToDelete[i].parentNode.parentNode;
				var table = getParent("table", tr);
				table.deleteRow(tr.rowIndex);
			}
		}
		// reset row indexes if not last
		if (rowIndex != table.rows.length) {
			var parentID = "answers[" + idNum + "]"
			jQuery("input[id^=answers][id*=-]").each(function(index, item) {
				if (item.parentNode.parentNode.parentNode.parentNode.id == parentID) {
					var childIndex = item.id.substring(item.id.indexOf('-') + 1, item.id.indexOf(']'));
					if (childIndex == rowIndex) {
						var id = item.id;
						id = id.replace("-" + childIndex + "]", "-" + (childIndex - 1) + "]");
						item.setAttribute("id", id);
						item.setAttribute("name", id);
					} else if (childIndex == (rowIndex + 1)) {
						rowIndex++;
						var id = item.id;
						id = id.replace("-" + childIndex + "]", "-" + (childIndex - 1) + "]");
						item.setAttribute("id", id);
						item.setAttribute("name", id);
					}
				}
			});
		}

	}
}
