
function queryReadings(form, targetElementId) {
	try {
		var url = buildFormUrl("/survey/readingQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}

function queryMeasurements(form, targetElementId) {
	try {
		var url = buildFormUrl("/survey/measurementQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}

function queryLimitPeriod(form, targetElementId) {
	try {
		var url = buildFormUrl("/survey/limitPeriodQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}

function summariseLimitPeriods(form) {
  	var url = buildFormUrl("/survey/limitPeriodSummarise.jpeg", form);
  	return summarise(form, url);;
}

function summariseReadings(form) {
  	var url = buildFormUrl("/survey/readingSummarise.jpeg", form);
  	return summarise(form, url);;
}

function queryPPE(form, targetElementId) {
	try {
		var url = buildFormUrl("/maintenance/ppeQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}

function queryTraining(form, targetElementId) {
	try {
		var url = buildFormUrl("/maintenance/trainingQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}

function queryEquipment(form, targetElementId) {
	try {
		var url = buildFormUrl("/maintenance/equipmentQuery.htmf", form);
		getXMLDoc(url, targetElementId);
	} catch (e) {
		//alert(e);
	}
	return false;
}
