var yes = true;
var no = false;
var timeout = 30;

  function changeSiteOfType(url, site, siteName, currentSite, recordType){
	  jQuery("#recordT").text(recordType);
	  changeSite(url, site, siteName, currentSite);
  }
  
  function changeSite(url, site, siteName, currentSite){
	  if(site != currentSite) {
		  	var showDialog = showMoveSiteDialog();
			var yesLink = url+'&switchToSite='+site;
		  	if(showDialog) {
				jQuery("#cl-wrapper").append(jQuery("#moveSiteModal"));
				jQuery("#moveSiteModal").modal("show");  
				
				jQuery("#moveSiteYes").attr("onclick","remAnswer(true);location.href='"+yesLink+"'");
				jQuery("#moveSiteNo").attr("onclick","remAnswer(false);location.href='"+url+"'");
				jQuery(".changeSiteSite").text(siteName);
		  	}
		  	else {
		  		location.href = moveSite() ? yesLink : url;
		  	}
	  }
	  else {
		  location.href = url;
	  }
  }
  
  var showMoveSiteDialog = function () {
	  // get timestamp
	  var startTime = get('startTimeMoveSite');
	  if(startTime != null && startTime != undefined) {
		  var startDate = new Date(startTime);
		  var now = new Date();
		  var minutes = now.getMinutes() - startDate.getMinutes();
		  if(minutes < timeout) {
			  return false;
		  }
		  else {
			  window.localStorage.removeItem('moveSite');
			  window.localStorage.removeItem('startTimeMoveSite');
		  }
		  
	  }
	  return true;
	}
  
  var get = function (key) {
	  return window.localStorage ? window.localStorage[key] : null;
	}
  
  var moveSite = function () {
	  return window.localStorage ? window.localStorage['moveSite'] : false;
	}

	var put = function (key, value) {
	  if (window.localStorage) {
	    window.localStorage[key] = value;
	  }
	}
	
	function remAnswer(rememebr) {
		if(rememebr) {
		  window.localStorage.setItem('moveSite', true);
		}
		else {
			window.localStorage.removeItem('moveSite');
		}
	}
	
	function resetMoveSite() {
	  var checked = jQuery("#moveSiteRememeberMe").is(':checked');
	  if(checked) {
		  var startTime = new Date();
		  window.localStorage.setItem('startTimeMoveSite', startTime);
		  window.localStorage.setItem('moveSite', jQuery("#moveSiteRememeberMe").is(':checked') ? yes : no);
	  }
	  else {
		  window.localStorage.removeItem('moveSite');
		  window.localStorage.removeItem('startTimeMoveSite');
	  }
	}