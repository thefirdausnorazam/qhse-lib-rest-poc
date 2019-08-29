function searchIncidents(form, targetElementId) {
  var url = buildFormUrl("/incident/searchIncidents.htmf", form);
  getXMLDoc(url, targetElementId);
  return false;
}

function searchActions(form, targetElementId) {
  var url = buildFormUrl("/incident/searchActions.htmf", form);
  getXMLDoc(url, targetElementId);
  return false;
}

function searchTasks(form, targetElementId) {
  var url = buildFormUrl("/incident/searchTasks.htmf", form);
  getXMLDoc(url, targetElementId);
  return false;
}

function summariseIncidents(form) {
  	var url = buildFormUrl("/incident/summariseIncidents.jpeg", form);
  	return summariseChart(form, url, "1000", "800");
}


