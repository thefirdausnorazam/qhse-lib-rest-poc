/**
 *
 */
var EnviroBC;

EnviroBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, contextUrl, urlParamId, urlParamOwnerId, urlParamQuestionId, urlParamShowId;
    arrLink = new Array;
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamOwnerId = getURLParam('ownerId');
    urlParamQuestionId = getURLParam('questionId');
    urlParamShowId = getURLParam('showId');
    if (urlParamQuestionId) {
        localStorage.setItem('questionId', urlParamQuestionId);
    }
    if (urlParamId) {
      localStorage.setItem('id', urlParamId);
    } else if (urlParamOwnerId) {
      localStorage.setItem('id', urlParamOwnerId);
    }
    else if (urlParamShowId) {
        localStorage.setItem('id', urlParamShowId);
      }

    /* for adding css based on module */
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/enviro.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Home');
    

	jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
	jQuery('#enviroDropdown').css('background-color', '#13AB94');
	jQuery('#enviroDropdown a.dropdown-toggle').css('color', '#FFFFFF');
	jQuery('#enviroDropdown .caret').css('border-bottom-color', '#FFFFFF');
	jQuery('#enviroDropdown .caret').css('border-top-color', '#FFFFFF');
    
    
    jQuery('.dashDiv').hide();
    if (arr[5] !== null) {
        arrLink = arr[5].split('?');
     }
    if (arrLink[0] === 'dashboard.htm' && (document.referrer.indexOf('/login.') <= 0) ) {
      jQuery('.dashDiv').show();
    }
    if (arr[5] === 'questionList.htm') {
    	  jQuery('#link1').attr('href', contextUrl + '/system/questionList.htm');
    	  jQuery('#link1').text('SCANNELL Questions');
    	  jQuery('#link1').addClass('disabled');
    }
    else if (arrLink[0] === 'questionView.htm') {
  	  	  jQuery('#link1').attr('href', contextUrl + '/system/questionList.htm');
  	  	  jQuery('#link1').text('SCANNELL Questions');
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#link2').text('View SCANNELL Question ');
          jQuery('#link2').addClass('disabled');
    }
    else if (arrLink[0] === 'questionOptionView.htm') {
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
          jQuery('#link2').text('View SCANNELL Question');
          jQuery('#link2').addClass('enabled');
          jQuery('#link2').attr('href', contextUrl + '/system/questionView.htm?id=' + localStorage.getItem('questionId'));
          jQuery('#link3').text('SCANNELL Question Option');
          jQuery('#link3').addClass('disabled');
    }
    else if (arrLink[0] === 'userDomainList.htm') {
  	  jQuery('#link1').attr('href', contextUrl + '/system/userDomainList.htm');
	  jQuery('#link1').text('User Domains');
	  jQuery('#link1').addClass('disabled');
    }
    else if (arrLink[0] === 'userDomainView.htm') {
  	  	  jQuery('#link1').attr('href', contextUrl + '/system/userDomainList.htm');
  	  	  jQuery('#link1').text('User Domains');
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#link2').text('View User Domain');
          jQuery('#link2').addClass('disabled');
    }
    else if (arrLink[0] === 'syncLdapDomain.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	  	jQuery('#link1').text('User Domains');
	  	jQuery('#link1').attr('href', contextUrl + '/system/userDomainList.htm');
        jQuery('#link2').text('View User Domain');
        jQuery('#link2').addClass('enabled');
        jQuery('#link2').attr('href', contextUrl + '/system/userDomainView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link3').text('Synchronise');
        jQuery('#link3').addClass('disabled');
    }
    else if (arrLink[0] === 'viewSyncLdapDomain.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	  	jQuery('#link1').text('User Domains');
	  	jQuery('#link1').attr('href', contextUrl + '/system/userDomainList.htm');
        jQuery('#link2').text('View User Domain');
        jQuery('#link2').addClass('enabled');
        jQuery('#link2').attr('href', contextUrl + '/system/userDomainView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link3').text('User Domain Manual Synchronise History');
        jQuery('#link3').addClass('disabled');
    }
    else if (arrLink[0] === 'licenceList.htm') {
    	  jQuery('#link1').attr('href', contextUrl + '/system/licenceList.htm');
    	  jQuery('#link1').text('List All Licences');
    	  jQuery('#link1').addClass('disabled');
     }
     else if (arrLink[0] === 'licenceView.htm') {
 	  	 jQuery('#link1').attr('href', contextUrl + '/system/licenceList.htm');
 	  	 jQuery('#link1').text('List All Licences');
         jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
         jQuery('#link2').text('View Licence');
         jQuery('#link2').addClass('disabled');
     }
     else if (arrLink[0] === 'licenceImport.htm') {
		 jQuery('#link1').attr('href', contextUrl + '/system/licenceList.htm');
		 jQuery('#link1').text('List All Licences');
	     jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	     jQuery('#link2').text('Import Licence');
	     jQuery('#link2').addClass('disabled');
     }
     else if (arrLink[0] === 'moduleList.htm') {
	  	  jQuery('#link1').attr('href', contextUrl + '/system/moduleList.htm');
	  	  jQuery('#link1').text('Modules');
	  	  jQuery('#link1').addClass('disabled');
     }
     else if (arrLink[0] === 'changeLog.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/changeLog.htm');
	   	  jQuery('#link1').text('Q-Pulse Change Log');
	   	  jQuery('#link1').addClass('disabled');
    }
     else if (arrLink[0] === 'home.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/enviro/generalHome.htm');
	   	  jQuery('#link1').text('Quick Links/Views');
	   	  jQuery('#link1').addClass('disabled');
   }
     else if (arrLink[0] === 'homeEdit.htm') {
         jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	  jQuery('#link1').attr('href', contextUrl + '/enviro/generalHome.htm');
	   	  jQuery('#link1').text('Quick Links/Views');
	   	  jQuery('#link2').attr('href', contextUrl + '/enviro/homeEdit.htm');
	   	  jQuery('#link2').text('Edit Quick Links/Views');
	   	  jQuery('#link2').addClass('disabled');
  }
     else if (arrLink[0] === 'generalHome.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/enviro/generalHome.htm');
	   	  jQuery('#link1').text('Quick Links/Views');
	   	  jQuery('#link1').addClass('disabled');
  }
    else if (arrLink[0] === 'groupList.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/groupList.htm');
	   	  jQuery('#link1').text('List All Groups');
	   	  jQuery('#link1').addClass('disabled');
    }
    else if (arrLink[0] === 'reportingGroupList.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/reportingGroupList.htm');
	   	  jQuery('#link1').text('List All Regional Groups');
	   	  jQuery('#link1').addClass('disabled');
  }
    else if (arrLink[0] === 'quickLinkEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	   	  jQuery('#link1').attr('href', contextUrl + '/enviro/generalHome.htm');
	   	  jQuery('#link1').text('Quick Links/Views');
	   	  jQuery('#link2').attr('href', contextUrl + '/enviro/homeEdit.htm');
	   	  jQuery('#link2').text('Edit Quick Links/Views');
	   	  jQuery('#link3').attr('href', contextUrl + '/enviro/quickLinkEdit.htm');
	   	  jQuery('#link3').text('Edit Quick Link');
	   	  jQuery('#link3').addClass('disabled');
  }
    else if (arrLink[0] === 'quickViewEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	   	  jQuery('#link1').attr('href', contextUrl + '/enviro/generalHome.htm');
	   	  jQuery('#link1').text('Quick Links/Views');
	   	  jQuery('#link2').attr('href', contextUrl + '/enviro/homeEdit.htm');
	   	  jQuery('#link2').text('Edit Quick Links/Views');
	   	  jQuery('#link3').attr('href', contextUrl + '/enviro/quickViewEdit.htm');
	   	  jQuery('#link3').text('Edit Quick View');
	   	  jQuery('#link3').addClass('disabled');
  }
    else if (arrLink[0] === 'userQueryForm.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/userQueryForm.htm');
	   	  jQuery('#link1').text('Search Users');
	   	  jQuery('#link1').addClass('disabled');
    }
    else if (arrLink[0] === 'userList.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/userList.htm');
	   	  jQuery('#link1').text('List Users');
	   	  jQuery('#link1').addClass('disabled');
    }
    else if (arrLink[0] === 'userEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/userQueryForm.htm');
        jQuery('#link1').text('Search Users');
        if (arrLink[1]) {
            jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	        jQuery('#link2').attr('href', contextUrl + '/system/userView.htm?id=' + localStorage.getItem('id'));
	        jQuery('#link2').text('View User');
	        jQuery('#link3').attr('href', contextUrl + '/system/userEdit.htm');
	        jQuery('#link3').text('Update User');
	        jQuery('#link3').addClass('disabled');
        }
        else {
	        jQuery('#link2').attr('href', contextUrl + '/system/userEdit.htm');
	        jQuery('#link2').text('Add User');
	        jQuery('#link2').addClass('disabled');
        }
    }
    else if (arrLink[0] === 'userView.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/userQueryForm.htm');
        jQuery('#link1').text('Search Users');
        jQuery('#link2').attr('href', contextUrl + '/system/userView.htm');
        jQuery('#link2').text('View User');
        jQuery('#link2').addClass('disabled');
    }
    else if (arrLink[0] === 'groupEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/groupList.htm');
        jQuery('#link1').text('List Groups');
        if (arrLink[1]) {
            jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	        jQuery('#link2').attr('href', contextUrl + '/system/groupView.htm?id=' + localStorage.getItem('id'));
	        jQuery('#link2').text('View Group');
	        jQuery('#link3').attr('href', contextUrl + '/system/groupEdit.htm');
	        jQuery('#link3').text('Update Group');
	        jQuery('#link3').addClass('disabled');
        }
        else {
	        jQuery('#link2').attr('href', contextUrl + '/system/groupEdit.htm');
	        jQuery('#link2').text('Add Group');
	        jQuery('#link2').addClass('disabled');
        }
    }
    else if (arrLink[0] === 'reportingGroupEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/reportingGroupList.htm');
        jQuery('#link1').text('List Regional Groups');
        if (arrLink[1]) {
            jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	        jQuery('#link2').attr('href', contextUrl + '/system/reportingGroupView.htm?id=' + localStorage.getItem('id'));
	        jQuery('#link2').text('View Regional Group');
	        jQuery('#link3').attr('href', contextUrl + '/system/reportingGroupEdit.htm');
	        jQuery('#link3').text('Update Regional Group');
	        jQuery('#link3').addClass('disabled');
        }
        else {
	        jQuery('#link2').attr('href', contextUrl + '/system/reportingGroupEdit.htm');
	        jQuery('#link2').text('Add Regional Group');
	        jQuery('#link2').addClass('disabled');
        }
    }
    else if (arrLink[0] === 'groupView.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/groupList.htm');
        jQuery('#link1').text('List Groups');
        jQuery('#link2').attr('href', contextUrl + '/system/groupView.htm');
        jQuery('#link2').text('View Group');
        jQuery('#link2').addClass('disabled');
    }
    else if (arrLink[0] === 'reportingGroupView.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	   	jQuery('#link1').attr('href', contextUrl + '/system/reportingGroupList.htm');
        jQuery('#link1').text('List Regional Groups');
        jQuery('#link2').attr('href', contextUrl + '/system/reportingGroupView.htm');
        jQuery('#link2').text('View Regional Group');
        jQuery('#link2').addClass('disabled');
    }
    else if (arrLink[0] === 'transferUserRecords.htm') {
	   	  jQuery('#link1').attr('href', contextUrl + '/system/transferUserRecords.htm');
	   	  jQuery('#link1').text('Transfer User Records');
	   	  jQuery('#link1').addClass('disabled');
  }
  
    
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

