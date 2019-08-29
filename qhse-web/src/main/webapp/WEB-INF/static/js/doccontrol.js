function getSearchParams(k){
 	var p={};
 	location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(s,k,v){p[k]=v})
 	return k?p[k]:p;
}

function closeme() {
	if (window.parent && window.parent.onPopupClose) {
	  	window.parent.onPopupClose();
	  } else if (window.onPopupClose) {
	    window.onPopupClose();
	  } 
	  else {
		  if (window.opener) {
		    if(window.opener.onPopupClose) {
		      window.opener.onPopupClose();
		    }
		    window.opener.focus();
		  }
		  window.close();
	  }
}

function animateJumpTo(elemId) {
	var elem = jQuery("#"+elemId);
	jQuery('html, body').animate({ scrollTop: getScrollTop(elem), scrollLeft: getScrollLeft(elem)}, 200);
}


function getScrollLeft(elem) {
	var left = elem.parent().offset().left;
    if (navigator.userAgent.indexOf("Chrome") != -1) {
        left = elem.parent().parent().offset().left;
    }
    
    return left-200;
}

function getScrollTop(elem) {
    return elem.parent().parent().parent().parent().offset().top-200;
}
	
function highlightDocGroup(highlightDocGroup, showActiveOnly, status, docGroupId) {
	var highlightColour = 'background: #edd083 !important';
	//Scroll to the navTo doc group if not the root doc group
	if(highlightDocGroup) {
		animateJumpTo(highlightDocGroup);
	}
	else {
		highlightDocGroup = docGroupId;
	}
	//If doc group is trashed then highlight in red tone, otherwise borwn tone
	if(showActiveOnly == "false" || status != 'DocGroupStatus[ACTIVE]') {
		highlightColour = 'background: #ffb9b9 !important';
	}
	//Always make sure Doc Group you came from is highlighted
	jQuery("a#"+highlightDocGroup).attr('style', highlightColour);
}

