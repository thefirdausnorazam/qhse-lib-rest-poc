/**
 * Manjush
 */
var IncidentBC;

IncidentBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, contextUrl, urlParamId, urlParamOwnerId;
    arrLink = new Array;
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamOwnerId = getURLParam('ownerId');
    if (urlParamId) {
      localStorage.setItem('id', urlParamId);
    } else if (urlParamOwnerId) {
      localStorage.setItem('id', urlParamOwnerId);
    }

    /* for adding css based on module */
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/incident.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Incident');
    jQuery('#h2Mod').text('Law');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#incidentDropdown').css('background-color', '#13AB94');
    jQuery('#incidentDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#incidentDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#incidentDropdown .caret').css('border-top-color', '#FFFFFF');

    /* BreadCrumbs for Incident */
    jQuery('#link1').attr('href', contextUrl + '/incident/home.htm');
    jQuery('#link1').text('Incident');
    if (arr[5] !== null) {
      arrLink = arr[5].split('?');
    }
    if (arr[5] === 'home.htm') {
    	jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#link2').text('My Workspace');
        jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'searchIncidentsForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Incidents');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'viewIncident.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Incidents');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchIncidentsForm.htm');
      jQuery('#link3').text('View Incident');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'editIncident.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Incidents');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchIncidentsForm.htm');
      jQuery('#link3').text('Create New Incident / Update Incident');
      jQuery('#link3').addClass('disabled');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'editInvestigation.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Incidents');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchIncidentsForm.htm');
      jQuery('#link3').text('Create New Investigation / Update Investigation');
      jQuery('#link3').addClass('disabled');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'incidentAccessLevel.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Incidents');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchIncidentsForm.htm');
      jQuery('#link3').text('View Incident');
      jQuery('#link3').attr('href', contextUrl + '/incident/viewIncident.htm?id=' + localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Access Control');
      jQuery('#link4').addClass('disabled');
    }
    if (arr[5] === 'searchActionsForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Actions');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'viewAction.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Actions');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchActionsForm.htm');
      jQuery('#link3').text('View Action');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'editAction.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Actions');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchActionsForm.htm');
      jQuery('#link3').text('View Action');
      jQuery('#link3').attr('href', contextUrl + '/incident/viewAction.htm?id=' + localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Edit Action');
      jQuery('#link4').addClass('disabled');
    }
    
    if (arrLink[0] === 'addActionNote.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Actions');
        jQuery('#link2').attr('href', contextUrl + '/incident/searchActionsForm.htm');
        jQuery('#link3').text('View Action');
        jQuery('#link3').attr('href', contextUrl + '/incident/viewAction.htm?id=' + localStorage.getItem('id'));
        jQuery('#link3').addClass('enabled');
        jQuery('#link4').text('Add Evaluation Review Note');
        jQuery('#link4').addClass('disabled');
      }
    
    if (arr[5] === 'searchTasksForm.htm') {
      jQuery('#link2').text('Tasks');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'viewTask.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchTasksForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'editTask.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchTasksForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').attr('href', contextUrl + '/incident/viewTask.htm?id=' + localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Edit Task');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'completeTask.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/incident/searchTasksForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').attr('href', contextUrl + '/incident/viewTask.htm?id=' + localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Complete Task');
      jQuery('#link4').addClass('disabled');
    }
    if (arr[5] === 'viewOverdueActions.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Overdue Actions & Tasks');
      jQuery('#link2').addClass('disabled');
    }

    /*if(arr[5] == 'editIncident.htm'){  
     jQuery("#breadcrumb").append(' <li id="liLink2"><a id="link2"></a></li>');
      	  jQuery("#link2").text("Create New Incident");       	  
      	  jQuery("#link2").addClass('disabled');                	  
      }
     */
    if (arr[5] === 'editIncidentTrend.htm?') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Select Trend Of Incidents');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'viewIncidentTypes.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Specify Incident Types');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'editIncidentType.htm') {
	    jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	    jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	    jQuery('#link2').text('Specify Incident Types');
	    jQuery('#link2').attr('href', contextUrl + '/incident/viewIncidentTypes.htm');
	    jQuery('#link3').text('Specify Incident Type');
	    jQuery('#link3').addClass('disabled');
     }
     if (arrLink[0] === 'configureTemplateSites.htm') {
		 jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		 jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		 jQuery('#link2').text('Specify Incident Types');
		 jQuery('#link2').attr('href', contextUrl + '/incident/viewIncidentTypes.htm');
		 jQuery('#link3').text('Configure Template Sites');
		 jQuery('#link3').addClass('disabled');
     }
     if (arrLink[0] === 'configureQuestionSite.htm') {
		jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
		jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
		jQuery('#link2').text('Specify Incident Types');
		jQuery('#link2').attr('href', contextUrl + '/incident/viewIncidentTypes.htm');
		jQuery('#link3').text('Configure Question Sites');
		jQuery('#link3').addClass('disabled');
     }
     if (arrLink[0] === 'viewSiteTemplate.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#link2').text('Specify Incident Types');
        jQuery('#link2').attr('href', contextUrl + '/incident/viewIncidentTypes.htm');
        jQuery('#link3').text('View Site Template');
        jQuery('#link3').addClass('disabled');
     }
     if (arrLink[0] === 'editIncidentSubType.htm') {
	     jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
	     jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
	     jQuery('#link2').text('Specify Incident Types');
	     jQuery('#link2').attr('href', contextUrl + '/incident/viewIncidentTypes.htm');
	     jQuery('#link3').text('Add/Update Incident Sub Type');
	     jQuery('#link3').addClass('disabled');
     }
     if (arrLink[0] === 'configureTemplateQuestionSites.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#link2').text('Configure Question Sites');
        jQuery('#link2').attr('href', contextUrl + '/incident/configureQuestionSite.htm?id=' + localStorage.getItem('id'));
        jQuery('#link3').text('Configure Template Question');
        jQuery('#link3').addClass('disabled');
    }
    if (arr[5] === 'viewReportees.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Specify Reportees');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'viewCauseTypes.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Specify Cause Type');
      jQuery('#link2').addClass('disabled');
    }

    /* Reports */
    if (arr[5] === 'reportList.htm?tag=incident') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'reportView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').attr('href', contextUrl + '/incident/reportList.htm?tag=incident');
      jQuery('#link3').text('Run Report');
      jQuery('#link3').addClass('disabled');
    }
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

