/**
 *MAnjush
 */
var RiskBC;

RiskBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, contextUrl, urlParamId, urlParamObjectiveId, urlParamShowId;
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamShowId = getURLParam('showId');
    urlParamObjectiveId = getURLParam('objectiveId');
    urlParamParentRiskId = getURLParam('parentRiskId');
    if (urlParamId) {
      localStorage.setItem('id', urlParamId);
    } else if (urlParamShowId) {
      localStorage.setItem('id', urlParamShowId);
    } else if (urlParamObjectiveId) {
      localStorage.setItem('id', urlParamObjectiveId);
    }
    if (urlParamParentRiskId) {
      localStorage.setItem('parentId', urlParamParentRiskId);
    }
    arrLink = new Array;

    /* for adding css based on module */
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/risk.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Risk');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#riskDropdown').css('background-color', '#13AB94');
    jQuery('#riskDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#riskDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#riskDropdown .caret').css('border-top-color', '#FFFFFF');

    /* BreadCrumbs for Risk */
    jQuery('#link1').attr('href', contextUrl + '/risk/workspaceQueryForm.htm');
    jQuery('#link1').text('Risk');
    if (arr[5] !== null) {
      arrLink = arr[5].split('?');
    }
    if (arr[5] === 'home.htm') {
      jQuery('#link2').text('Home');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'assessmentQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').addClass('disabled');
    }

    /* start with showId and id for risk parameters ScoreBoard */
    if (arrLink[0] === 'assessmentView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'expressAssessmentView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment Scorecard');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentStep1.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Activity/Impact');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'expressAssessmentStep1.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Add/Edit Risk Assessment');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentStep2.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Score & Justification');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentStep3.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Review & Save');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentTrash.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Trash Risk Assessment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentConfidential.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Risk Assessment - Confidential');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentAccessLevel.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Access Control');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentTemplateList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Risk Assessment Template');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentRevisionQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Revision History');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'assessmentArchive.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Archive Risk Assessment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'addRiskAttachment.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Risk Assessment Scoreboard');
      jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
      jQuery('#link3').text('Risk Assessment View');
      jQuery('#link3').attr('href', contextUrl + '/risk/assessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Attachment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'addRiskJobAttachment.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Risk Assessment Scoreboard');
        jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
        jQuery('#link3').text('Risk Assessment View');
        jQuery('#link3').attr('href', contextUrl + '/risk/expressAssessmentView.htm?showId=' + localStorage.getItem('parentId'));
        jQuery('#link4').text('Add Attachment');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'assessmentJobHazardEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Risk Assessment Scoreboard');
        jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
        jQuery('#link3').text('Risk Assessment View');
        jQuery('#link3').attr('href', contextUrl + '/risk/expressAssessmentView.htm?showId=' + localStorage.getItem('parentId'));
        jQuery('#link4').text('Edit Job Hazard/Aspect');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'jobAddImageForm.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Risk Assessment Scoreboard');
        jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
        jQuery('#link3').text('Risk Assessment View');
        jQuery('#link3').attr('href', contextUrl + '/risk/expressAssessmentView.htm?showId=' + localStorage.getItem('parentId'));
        jQuery('#link4').text('Add Image');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'editRiskJobAttachments.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Risk Assessment Scoreboard');
        jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
        jQuery('#link3').text('Risk Assessment View');
        jQuery('#link3').attr('href', contextUrl + '/risk/expressAssessmentView.htm?showId=' + localStorage.getItem('parentId'));
        jQuery('#link4').text('Edit Risk Job Attachments');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'assessmentJobHazardTaskAdd.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Risk Assessment Scoreboard');
        jQuery('#link2').attr('href', contextUrl + '/risk/assessmentQueryForm.htm');
        jQuery('#link3').text('Risk Assessment View');
        jQuery('#link3').attr('href', contextUrl + '/risk/expressAssessmentView.htm?showId=' + localStorage.getItem('parentId'));
        jQuery('#link4').text('Add/Edit Task');
        jQuery('#link4').addClass('disabled');
      }
    
    
/*    function allStorage() {

        var archive = [],
            keys = Object.keys(localStorage),
            i = 0, key;

        for (; key = keys[i]; i++) {
            archive.push( key + '=' + localStorage.getItem(key));
        }

        return archive;
    }*/

    /* End for Risk Scoreboard */

    /* Start of Risk Objectives */
    if (arr[5] === 'objectiveQueryForm.htm' || arr[5] === 'objectiveQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Objective');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'objectiveView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Objectives');
      jQuery('#link2').attr('href', contextUrl + '/risk/objectiveQueryForm.htm');
      jQuery('#link3').text('Objective View');
      jQuery('#link3').attr('href', contextUrl + '/risk/objectiveView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'objectiveEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Objectives');
      jQuery('#link2').attr('href', contextUrl + '/risk/objectiveQueryForm.htm');
      jQuery('#link3').text('Objective View');
      jQuery('#link3').attr('href', contextUrl + '/risk/objectiveView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add/Edit Objective');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'targetEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Objectives');
      jQuery('#link2').attr('href', contextUrl + '/risk/objectiveQueryForm.htm');
      jQuery('#link3').text('Objective View');
      jQuery('#link3').attr('href', contextUrl + '/risk/objectiveView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add/Edit Objective');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'objectiveTrash.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Objectives');
      jQuery('#link2').attr('href', contextUrl + '/risk/objectiveQueryForm.htm');
      jQuery('#link3').text('Objective View');
      jQuery('#link3').attr('href', contextUrl + '/risk/objectiveView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Trash Objective');
      jQuery('#link4').addClass('disabled');
    }

    /* if(arrLink[0] == 'managementProgrammeEdit.htm'){            			 
     jQuery("#link2").text("Objective");
     jQuery("#link2").attr("href", '<c:url value="/risk/objectiveQueryForm.htm" />');
        	  jQuery("#link3").text("Objective View"); 
        	  jQuery("#link3").attr("href", '<c:url value="/risk/objectiveView.htm" ><c:param name="id" value="${id}" /></c:url>');   
        	  jQuery("#link4").text("Add/Edit Management Programme"); 
        	  jQuery("#link4").addClass('disabled');                	  
    	 }
     */

    /* Start of Objective Targets */
    if (arr[5] === 'targetQueryForm.htm' || arr[5] === 'targetQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Targets');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'targetView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Targets');
      jQuery('#link2').attr('href', contextUrl + '/risk/targetQueryForm.htm');
      jQuery('#link3').text('View Objective Target');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'targetComplete.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Targets');
      jQuery('#link2').attr('href', contextUrl + '/risk/targetQueryForm.htm');
      jQuery('#link3').text('Target View');
      jQuery('#link3').attr('href', '/risk/targetView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Complete Objective Target');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'targetTrash.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Targets');
      jQuery('#link2').attr('href', contextUrl + '/risk/targetQueryForm.htm');
      jQuery('#link3').text('Target View');
      jQuery('#link3').attr('href', '/risk/targetView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Trash Objective Target');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'targetComment.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Targets');
      jQuery('#link2').attr('href', contextUrl + '/risk/targetQueryForm.htm');
      jQuery('#link3').text('Target View');
      jQuery('#link3').attr('href', contextUrl + '/risk/targetView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Progress Comment');
      jQuery('#link4').addClass('disabled');
    }

    /* Start of Management Programme */
    if (arr[5] === 'managementProgrammeQueryForm.htm' || arr[5] === 'managementProgrammeQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Management Programme');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'managementProgrammeView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Management Programmes');
      jQuery('#link2').attr('href', contextUrl + '/risk/managementProgrammeQueryForm.htm');
      jQuery('#link3').text('View Management Programme');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'managementProgrammeArchive.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Management Programmes');
      jQuery('#link2').attr('href', contextUrl + '/risk/managementProgrammeQueryForm.htm');
      jQuery('#link3').text('View Management Programme');
      jQuery('#link3').attr('href', contextUrl + '/risk/managementProgrammeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Archive Management Programme');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'managementProgrammeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Management Programmes');
      jQuery('#link2').attr('href', contextUrl + '/risk/managementProgrammeQueryForm.htm');
      jQuery('#link3').text('View Management Programme');
      jQuery('#link3').attr('href', contextUrl + '/risk/managementProgrammeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add/Edit Management Programme');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'managementProgrammeTrash.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Management Programmes');
      jQuery('#link2').attr('href', contextUrl + '/risk/managementProgrammeQueryForm.htm');
      jQuery('#link3').text('View Management Programme');
      jQuery('#link3').attr('href', contextUrl + '/risk/managementProgrammeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Trash Management Programme');
      jQuery('#link4').addClass('disabled');
    }

    /* Start of Task */
    if (arr[5] === 'taskQueryForm.htm' || arr[5] === 'taskQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'taskView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/risk/taskQueryForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'taskEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/risk/taskQueryForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').attr('href', contextUrl + '/risk/taskView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add/Edit Task');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'taskComplete.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/risk/taskQueryForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').attr('href', contextUrl + '/risk/taskView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Complete Sub Task');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'taskTrash.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Tasks');
      jQuery('#link2').attr('href', contextUrl + '/risk/taskQueryForm.htm');
      jQuery('#link3').text('View Task');
      jQuery('#link3').attr('href', contextUrl + '/risk/taskView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Trash Sub Task');
      jQuery('#link4').addClass('disabled');
    }

    /* Overdue */
    if (arr[5] === 'overdueQueryForm.htm' || arr[5] === 'overdueQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Overdue Alerts');
      jQuery('#link2').addClass('disabled');
    }

    /* Workspace */
    if (arr[5] === 'workspaceQueryForm.htm' || arr[5] === 'workspaceQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('My Workspace');
      jQuery('#link2').addClass('disabled');
    }

    /* Workspace */
    if (arr[5] === 'workspaceQueryForm.htm' || arr[5] === 'workspaceQueryForm.htm#') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('My Workspace');
      jQuery('#link2').addClass('disabled');
    }

    /* Reports */
    if (arr[5] === 'reportList.htm?tag=risk') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'reportView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').attr('href', contextUrl + '/risk/reportList.htm?tag=risk');
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

