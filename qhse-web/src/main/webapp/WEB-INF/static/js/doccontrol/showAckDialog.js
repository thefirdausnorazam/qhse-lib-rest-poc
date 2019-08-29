function showDialog(show, closeUrl, url) {
	if(show == 'true') {
		doccontrol = {}; // namespace
	    
	    jQuery(document.body).append('<div id="dialogDiv"></div>');
	    jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="450" height="200" marginWidth="0" marginHeight="0" frameBorder="0" src="about:blank" />');
	    
	    jQuery("#dialogDiv").dialog({
		      title: title,
		      height: 'auto',
		      width: 500,
		      modal: true,
		      resizable: false,
		      draggable: true,
		      autoOpen: false,
		      position:['middle',120]
		      //position: { my: " top", at: " top", of: window }
	    });
		 jQuery("#dialogFrame").attr("src", url);
         
		 jQuery("#dialogDiv").dialog("open");	
		 
		 doccontrol.addDocDialogClose = function() {
			 jQuery("#dialogDiv").dialog("close");
			 window.location=closeUrl;
		 };	
    }
}
function openAckDialog(url) {
	jQuery("#dialogFrame").attr("src", url);
	jQuery("#dialogDiv").dialog("open");
}

function onPopupClose() {
  doccontrol.addDocDialogClose();
}