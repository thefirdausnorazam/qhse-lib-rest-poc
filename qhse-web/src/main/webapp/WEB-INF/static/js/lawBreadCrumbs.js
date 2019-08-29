/**
 *Manjush
 */

var LawBC;


LawBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, arrLinkLegal, contextUrl, urlParamId, urlParamOwnerId, urlParamLegRegister;
    arrLink = new Array;
    arrLinkLegal = new Array;
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamOwnerId = getURLParam('ownerId');
    urlParamLegRegister = getURLParam('legRegister');
    urlParamProfileId = getURLParam('profileId');
    urlParamLegId = getURLParam('legId');
    urlParamContentVersion = getURLParam('contentVersion'); 
    
    if (urlParamId) {
      localStorage.setItem('id', urlParamId);
    } else if (urlParamOwnerId) {
      localStorage.setItem('id', urlParamOwnerId);
    }
    if(urlParamLegRegister) {
    	localStorage.setItem('idRegister', urlParamLegRegister);
    }
    if(urlParamProfileId) {
    	localStorage.setItem('profileId', urlParamProfileId);
    }
    if(urlParamLegId) {
    	localStorage.setItem('legId', urlParamLegId);
    }
    
    /* for adding css based on module */
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/law.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Law');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#lawDropdown').css('background-color', '#13AB94');
    jQuery('#lawDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#lawDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#lawDropdown .caret').css('border-top-color', '#FFFFFF');
    
    
    
    var previewPage = '';
    /* BreadCrumbs for Law */
    jQuery('#link1').attr('href', contextUrl + '/law/lawDashboard.htm');
    jQuery('#link1').text(SCANNELL_TRANSLATIONS.lawBC);
    if (arr[5] !== null) {
      arrLink = arr[5].split('?');
    }
    
    if (arr[5] === 'lawDashboard.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#link2').text(SCANNELL_TRANSLATIONS.lawDashboardBC);
        jQuery('#link2').addClass('disabled');
    } 
    if (arrLink[0] === 'legislationsView.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.indexLegislationBC);
    	jQuery('#link3').removeAttr('href');
    	jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'legislation.htm' && urlParamContentVersion == null) {
    	
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.indexLegislationBC);
    	jQuery('#link3').attr('href', contextUrl + '/law/legislationsView.htm?legRegister='+localStorage.getItem('idRegister'));
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(jQuery('#titlePage').text());
    	//jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    if (arrLink[0] === 'relevance.htm') {
    	
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.indexLegislationBC);
    	jQuery('#link3').attr('href', contextUrl + '/law/legislationsView.htm?legRegister='+localStorage.getItem('idRegister'));
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.relevanceBC);
    	//jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    if (arrLink[0] === 'checklistsForKeyword.htm') {	
		jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.searchBC);
    	jQuery('#link3').attr('href', contextUrl + '/law/contentSearchForm.htm?legRegister='+localStorage.getItem('idRegister'));
    	
		jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.checklistDetailBC); 
    	jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');
    }
    else if (arrLink[0] === 'checklists.htm') {	
    	if(arrLink[1].indexOf('checkDetail=true') == -1) {
	    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	    	var rel = getURLParam('viewType');
	    	if('notRelevant' == rel){
	    		jQuery('#link3').text(SCANNELL_TRANSLATIONS.nonRelevantComplChecklBC);	
	    	}else{
	    		jQuery('#link3').text(SCANNELL_TRANSLATIONS.relevantComplChecklBC);
	    	}
	    	jQuery('#link3').removeAttr('href');
	    	jQuery('#link3').addClass('disabled');
    	} else {
    		jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        	jQuery('#link3').text(SCANNELL_TRANSLATIONS.checklistsBC);
        	//jQuery('#link3').attr('href', window.history.back());
        	jQuery('#link3').click(function (){window.history.back()});
        	
    		jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
	    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.checklistDetailBC);
	    	jQuery('#link4').removeAttr('href');
	    	jQuery('#link4').addClass('disabled');
    	}
    }
    if (arrLink[0] === 'keyword.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.indexOfKeywordsBC);
    	jQuery('#link3').attr('href', contextUrl + '/legal/front/checklists/KeywordIndex.jsp?registerType='+localStorage.getItem('idRegister'));
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.relevanciesForKeywordBC);
    	jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    if (arrLink[0] === 'legislation.htm' && urlParamContentVersion != null) {
    	
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.changeRecordsBC);
    	jQuery('#link3').attr('href', contextUrl + '/legal/front/legislation/Log.jsp?legRegister='+localStorage.getItem('idRegister'));
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(jQuery('#titlePage').text());
    	//jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    if (arrLink[0] === 'changedLegislations.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.newLegislationBC);
    	
    	jQuery('#link3').removeAttr('href');
    	jQuery('#link3').addClass('disabled');  	   
    }
    if (arrLink[0] === 'taskQueryForm.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.lawTasksBC);
    	
    	jQuery('#link3').removeAttr('href');
    	jQuery('#link3').addClass('disabled');  	   
    }
    if (arrLink[0] === 'contentSearchForm.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.searchBC);
    	
    	jQuery('#link3').removeAttr('href');
    	jQuery('#link3').addClass('disabled');  	   
    }
    if (arrLink[0] === 'changeRecord.htm') {
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.changeRecordBC);
    	jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    if (arrLink[0] === 'taskViewSearch.htm' || arrLink[0] === 'profileChecklistEditTaskSearch.htm' || arrLink[0] === 'taskCompleteSearch.htm' || arrLink[0] === 'taskTrashSearch.htm') {
    	
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.lawTasksBC);
    	jQuery('#link3').attr('href', contextUrl + '/law/taskQueryForm.htm?legRegister='+localStorage.getItem('idRegister'));
    	
    	jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
    	jQuery('#link4').text(SCANNELL_TRANSLATIONS.taskBC);
    	//jQuery('#link4').removeAttr('href');
    	jQuery('#link4').addClass('disabled');  	   
    }
    
    if(arrLink.length == 1 && arr.length > 7 ) {
    	if(arr[7] !== null) {
    		arrLinkLegal = arr[7].split('?');
    	}
    }
    if (arrLinkLegal[0] === 'KeywordIndex.jsp') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.indexOfKeywordsBC);
    	jQuery('#link3').removeAttr('href');
    	
    	jQuery('#link3').addClass('disabled');  	   
    }
    if (arrLinkLegal[0] === 'Log.jsp') {
    	jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
    	jQuery('#link3').text(SCANNELL_TRANSLATIONS.changeRecordsBC);
    	jQuery('#link3').removeAttr('href');
    	
    	jQuery('#link3').addClass('disabled');  	   
    }
    
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

