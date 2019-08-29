/* openHistory Pop Up  */


  
  var onDataMenuSelect, onDecoratorLoad, onWasteMenuSelect, toggleDataMenu, openContacts, openDocLink, openProfileManager, selectProfile,getURLParam, openDocLinkPageFromLaw;

  jQuery(document).ready(function() {	  
	      // Wait for the HTML to finish loading.	  
	  jQuery.ajaxSetup({ cache: false });
	  var openHistory;
	  openHistory = void 0;
	  if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			jQuery( "#frameMcont" ).removeClass( "cl-mcont" )
			}
	  jQuery(document.body).append('<div  id="dialogDivTest"></div>');
	  jQuery('#dialogDivTest').html('<iframe class="test" id="dialogFrameTest"  width="900" height="500" marginWidth="0" marginHeight="0" frameBorder="0" close="no" src="about:blank" />');
	  jQuery('#dialogDivTest').dialog({
	    title: SCANNELL_TRANSLATIONS.viewHistoryTitle,
	    height: 'auto',
	    width: 950,
	    modal: true,
	    resizable: false,
	    draggable: false,
	    autoOpen: false,
	    buttons: [
	      {
	        text: SCANNELL_TRANSLATIONS.close,
	        class: 'g-btn g-btn--primary',
	        icons: {
	          primary: 'ui-icon-closethick'
	        },
	        id: 'closebtn',
	        click: function() {	        	
	          var $this;
	          $this = jQuery(this);
	          $this.dialog('close');
	        }
	      }
	    ],
	    open: function() {
	      jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-dialog-titlebar-close').html('<span class=\'fa fa-times fa-lg\'></span>');
	    }
	  });
	
	  jQuery(document.body).append('<div  id="dialogLinkDocs"></div>');
	  jQuery('#dialogLinkDocs').html('<iframe class="test" id="dialogFrameDocs"  width="900" height="550" marginWidth="0" marginHeight="0" frameBorder="0" close="no" src="about:blank" scrolling="no"/>');
	  jQuery('#dialogLinkDocs').dialog({
		    title: SCANNELL_TRANSLATIONS.linkDocs,
		    height: 'auto',
		    width: 950,
		    modal: true,
		    resizable: false,
		    draggable: false,
		    autoOpen: false,
		    buttons: [
		      {
		        text: SCANNELL_TRANSLATIONS.close,
		        class: 'g-btn g-btn--primary',
		        id: 'closebtn',
		        click: function() {
		          var $this;
		          $this = jQuery(this);
		          $this.dialog('close');
		        }
		      }
		    ],
		    open: function() {
		      jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close').addClass('btn btn-primary').html('<span class=\'fa fa-times fa-lg\'></span>');
		      blockUIUntilDialogBoxLoad(SCANNELL_TRANSLATIONS.loadingManage);
		    }
		  });
	  
	  // Group Sites Ajax 
	     /*url = contextPath + '/enviro/groupSitesAjax.json';
	    jQuery.getJSON(url, function(json) {
	    	 jQuery('#groupSiteBubble').text(json.grupSiteNameList.length);	     
	    });*/
	  
	    jQuery("#sidebar-collapse").click();
	    
	    
		  jQuery(document.body).append('<div  id="dialogDivProfileManager"></div>');
		  jQuery('#dialogDivProfileManager').html('<iframe class="test" id="dialogProfileManager"  width="100%" height="100%" marginWidth="0" marginHeight="0" frameBorder="0" close="no" src="about:blank" />');
		  jQuery('#dialogDivProfileManager').dialog({
		    title: SCANNELL_TRANSLATIONS.manageProfileTitle,
		    height: '700',
		    width: 1150,
		    modal: true,
		    resizable: true,
		    draggable: true,
		    autoOpen: false,
		    
		    buttons: [
		      {
		        text: SCANNELL_TRANSLATIONS.close,
		        class: 'g-btn g-btn--primary',
		        icons: {
		          primary: 'ui-icon-closethick'
		        },
		        id: 'closebtn',
		        click: function() {	        	
		          var $this;
		          $this = jQuery(this);
		          $this.dialog('close');
		        }
		      }
		    ],
		    open: function() {
		    	jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close').addClass('btn btn-primary').html('<span class=\'fa fa-times fa-lg\'></span>');
		    	blockUIUntilDialogBoxLoad(SCANNELL_TRANSLATIONS.loadingProfileManager);
		    	
		    }
		  });
	
	});
  
	openProfileManager = function() {
	    var url;
	    url = contextPath + '/law/profileManager.htm';
	    jQuery('#dialogProfileManager').attr('src', url);
	    jQuery('#dialogDivProfileManager').dialog('open');
  
	  
	};
	  
	  openDocLinkPageFromLaw = function(id) {
		  if(id > 0)
		  {
			  openAttachDocumentWindow(id);
		  }
		  else
		  {
			  window.location.href = contextPath + '/law/profileNotFound.htm';
		  }
		 };

    openHistory = function(id, type) {
	    var url;
	    url = contextPath + '/enviro/viewHistory.htm?id=' + id + '&type=' + type;
		url = encodeURI(url);
	    jQuery('#dialogFrameTest').attr('src', url);
	    jQuery('#dialogDivTest').dialog('open');
	  };
	  
    openParentChildHistory = function(id, type, childIds, childType) {
		    var url;
		    url = contextPath + '/enviro/viewHistory.htm?id=' + id + '&type=' + type + '&childIds=' + childIds + '&childType=' + childType;
			url = encodeURI(url);
		    jQuery('#dialogFrameTest').attr('src', url);
		    jQuery('#dialogDivTest').dialog('open');
		  };
		 
	openMultiObjectHistory = function(id, type, child1Ids, child1Type, child2Ids, child2Type) {
			    var url;
			    url = contextPath + '/enviro/viewHistory.htm?id=' + id + '&type=' + type + '&childIds=' + child1Ids + '&childType=' + child1Type + '&child2Ids=' + child2Ids + '&child2Type=' + child2Type;
				url = encodeURI(url);
			    jQuery('#dialogFrameTest').attr('src', url);
			    jQuery('#dialogDivTest').dialog('open');
			  };
		  
	  
	openAttachDocumentWindow = function(id) {
		var url = contextPath + "/doclink/holderEdit.htm?holderName=" + id;
		url = encodeURI(url);
		jQuery('#dialogFrameDocs').attr('src', url);
		jQuery('#dialogLinkDocs').dialog('open');
	};

	  
  getURLParam = function(paramName) {
	  var href, str;
	  href = window.location.href;
	  paramName = paramName + '=';
	  if (href.indexOf('?') >= 0 && href.indexOf(paramName) >= 0) {
	    str = href.substr(href.indexOf(paramName) + paramName.length);
	    if (str.indexOf('&') >= 0) {
	      str = str.substr(0, str.indexOf('&'));
	    }
	    return str;
	  }
	  return null;
	};

  onWasteMenuSelect = function() {
    toggleDataMenu('false');
  };

  onDataMenuSelect = function() {
    toggleDataMenu('true');
  };

  toggleDataMenu = function(onn) {
    var hide, show;
    show = 'data';
    hide = 'waste';
    if (onn === 'false') {
      show = 'waste';
      hide = 'data';
    }
    showBlock(show + 'ViewMenu');
    showBlock(show + 'ActionMenu');
    hideBlock(hide + 'ViewMenu');
    hideBlock(hide + 'ActionMenu');
  };

  onDecoratorLoad = function() {
    var dataOn, radioToSelectId;
    if (!$('dataMenu')) {
      return;
    }
    dataOn = 'true';
    if (window.location.href.indexOf('/waste/') > 0) {
      dataOn = 'false';
    }
    radioToSelectId = 'dataMenu';
    if (dataOn === 'false') {
      radioToSelectId = 'wasteMenu';
    }
    $(radioToSelectId).click();
  };

  window.onresize = function() {
    resize();
  };

  // ---
  
  openContacts = function() {
	  var url;
	  url = contextPath + '/appstart/aboutInfo/html/enviroApplication_CONTACTS.html';
	  openWindow(url, 500, 500);
	};

	openDocLink = function() {
	  var url;
	  url = contextPath + '/doclink/holderEdit.htm?holderName=profile' + ' - ' + document.getElementById('profileSelect').value;
	  openWindow(url, 1000, 550);
	};
		
	blockUIUntilDialogBoxLoad = function(msg){
	    // Hack to disable close buttons until all ajax calls are finished.
	    // jQuery.getScript("/js/jquery.blockUI.js");
     	  var bod = jQuery('.ui-dialog');	
     	 jQuery(bod).block({ 
		         message: '<span>'+msg+'....</span>', 
		         css: { top: '0px' } ,
		         css: { position: 'block' },
		         onOverlayClick: jQuery(jQuery('.ui-dialog')).unblock()
		     });
  //This sometime takes forever to fire, setting timer for 1 second.  	
		/*  jQuery(document).ajaxStop(function() {
			  jQuery(jQuery('.ui-dialog')).unblock();
			}); */
     	 
     	setTimeout(function(){
     		jQuery(jQuery('.ui-dialog')).unblock();
     		}, 2500);
	};

