/**
 * 
 */

var DocControlBC;

DocControlBC = (function () {
    var  breadCrumbs;
    breadCrumbs = function(arr){
		  var arrLink, contextUrl, urlParamId, urlParamOwnerId, urlShowId, urlParentId, source, generalSearch;
		  arrLink = new Array;
		  contextUrl = '/' + arr[3];
		  urlParamId = getURLParam('id');
		  urlParamOwnerId = getURLParam('ownerId');
		  urlShowId = getURLParam('showId');
		  urlParentId = getURLParam('parentId');
		  source = getURLParam('source');
		  generalSearch = getURLParam('generalSearch');
		  if (urlParamId) {
		    localStorage.setItem('id', urlParamId);
		  } else if (urlParamOwnerId) {
		    localStorage.setItem('id', urlParamOwnerId);
		  } else if (urlShowId) {
		    localStorage.setItem('id', urlShowId);
		  }
		
		 jQuery('<link/>').attr({
            rel:'stylesheet',
            type:'text/css',
            media:'all',
            href:contextUrl + '/css/doccontrol.css'}).appendTo('head'); 
            
   		  jQuery("#h2Mod").text(SCANNELL_TRANSLATIONS.docConBC);
   		  
   		  jQuery('.page-head').css('border-bottom',' 2px solid #13AB94');
   		  jQuery('#doccontrolDropdown').css('background-color','#13AB94');
	   	  jQuery('#doccontrolDropdown a.dropdown-toggle').css('color', '#FFFFFF');
	   	  jQuery('#doccontrolDropdownn .caret').css('border-bottom-color', '#FFFFFF');
	   	  jQuery('#doccontrolDropdown .caret').css('border-top-color', '#FFFFFF');
	   	  
		  jQuery("#link1").attr("href", contextUrl+'/doccontrol/workspace.htm');
		  jQuery("#link1").text(SCANNELL_TRANSLATIONS.docConBC);

		  if (arr[5] !== null) {
		      arrLink = arr[5].split('?');
		  }
		  if (arr[5] === 'workspace.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text('My Workspace');
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arr[5] === 'docGroupList.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arr[5] === 'listDocuments.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arr[5] === 'docGroupSearchForm.htm') {
		      jQuery('#liLink3').remove();
		      jQuery('#liLink4').remove();
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupSearchBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arr[5] === 'documentSearchForm.htm') {
		      jQuery('#liLink3').remove();
		      jQuery('#liLink4').remove();
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentSearchBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arr[5] === 'distributedDocuments.htm') {
		      jQuery('#liLink3').remove();
		      jQuery('#liLink4').remove();
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsMyBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentSearchForm.htm') {
			  //Came from Quick Links
		      jQuery('#liLink3').remove();
		      jQuery('#liLink4').remove();
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentSearchBC);
		      jQuery('#link2').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupView.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#liLink4').remove();
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
		      jQuery('#link3').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupsView.htm') {
			      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
			      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
			      jQuery('#liLink4').remove();
			      if(source == null) {
				      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
				      var id = urlParamId;
				      if(id == null){
				    	  id = getURLParam('navTo');
				      }
				      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupView.htm?id=' + id);
			      }
			      else if(source == "search" || source == "") {    	  
				      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
				      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
			      }
			      else {		
				      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentBC);
				      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + source);	
			      }
			      jQuery('#link2').addClass('enabled');
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupHierarchyBC);
			      jQuery('#link3').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupsSubView.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#liLink4').remove();
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupHierarchyBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupsView.htm?navTo='+urlParamId);
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupSubHierarchyBC);
		      jQuery('#link3').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupEdit.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      if(urlShowId != null || urlParentId != null) {
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/docGroupView.htm?id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      if(urlShowId == null) {
				      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupSubEditBC);
				      jQuery('#link4').addClass('disabled');
			      }
			      else {
				      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupEditBC);
				      jQuery('#link4').addClass('disabled');
			      }
		      }
		      else {
		    	  jQuery('#liLink4').remove();
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupEditBC);
			      jQuery('#link3').addClass('disabled');
		      }
		  }
		  else if (arrLink[0] === 'documentView.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#liLink4').remove();
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentViewBC);
		      jQuery('#link3').addClass('disabled');
		  }
		  else if (arrLink[0] === 'userViewQueryForm.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentTrainingRecordBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'distribute.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?redirect=false&id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupDistributeBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentEdit.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      if(urlShowId != null) {
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?redirect=false&id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentEditBC);
			      jQuery('#link4').addClass('disabled');
		      }
		      else if (urlParentId != null) {
			      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
			      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
			      jQuery('#link2').addClass('enabled');
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/docGroupView.htm?id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentEditBC);
			      jQuery('#link4').addClass('disabled');
		      }
	    	  else {
			      jQuery('#liLink4').remove();
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentEditBC);
			      jQuery('#link3').addClass('disabled');
		    	  
		      }
		  }
		  else if (arrLink[0] === 'documentRevisionView.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?redirect=false&id=' + urlParentId);
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentRevisionBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentRecordEdit.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + urlShowId);
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentAddRecordBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'editDocumentRecords.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + urlShowId);
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentEditRecordBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docTrainingRecordQueryForm.htm') {
			  if(generalSearch == null) {
			      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
			      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
			      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
			      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
			      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
			      jQuery('#link2').addClass('enabled');
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      jQuery('#link4').text(SCANNELL_TRANSLATIONS.documentTrainingRecordBC);
			      jQuery('#link4').addClass('disabled');
			  }
			  else {
				  //This request came from a general doc search page
			      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
			      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentTrainingRecordBC);
			      jQuery('#link2').addClass('disabled');
			  }
		  }
		  else if (arrLink[0] === 'documentAddRev.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docAddRevisionBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentAddReview.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docAddReviewBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentApprove.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docApproveBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentTrash.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docTrashBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'documentArchive.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docArchiveBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupTrash.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      if(urlShowId != null || urlParentId != null) {
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/docGroupView.htm?id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupTrashBC);
				  jQuery('#link4').addClass('disabled');
		      }
		  }
		  else if (arrLink[0] === 'docGroupArchive.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.documentsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/documentSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      jQuery('#link3').text(SCANNELL_TRANSLATIONS.documentBC);
		      jQuery('#link3').attr('href', contextUrl + '/doccontrol/documentView.htm?id=' + localStorage.getItem('id'));
		      jQuery('#link3').addClass('enabled');
		      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupArchiveBC);
		      jQuery('#link4').addClass('disabled');
		  }
		  else if (arrLink[0] === 'docGroupFilter.htm') {
		      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
		      jQuery('#link2').text(SCANNELL_TRANSLATIONS.docGroupsBC);
		      jQuery('#link2').attr('href', contextUrl + '/doccontrol/docGroupSearchForm.htm');
		      jQuery('#link2').addClass('enabled');
		      if(urlShowId != null || urlParentId != null) {
			      jQuery('#link3').text(SCANNELL_TRANSLATIONS.docGroupViewBC);
			      jQuery('#link3').attr('href', contextUrl + '/doccontrol/docGroupView.htm?id=' + localStorage.getItem('id'));
			      jQuery('#link3').addClass('enabled');
			      jQuery('#link4').text(SCANNELL_TRANSLATIONS.docGroupFilterBC);
				  jQuery('#link4').addClass('disabled');
		      }
		  }
	  };
	  return {
		    breadCrumbs: function(arr) {
		      breadCrumbs(arr);
		    }
	  };
})();