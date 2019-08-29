/**
 *Manjush
 */
var ChangeBC;

ChangeBC = (function() {
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
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/change.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Change');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#changeDropdown').css('background-color', '#13AB94');
    jQuery('#changeDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#changeDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#changeDropdown .caret').css('border-top-color', '#FFFFFF');
    
    
    jQuery('#link1').attr('href', contextUrl + '/change/workspace.htm');
    jQuery('#link1').text('Change');
    if (arr[5] !== null) {
      arrLink = arr[5].split('?');
    }
    if (arr[5] === 'workspace.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('My Workspace');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'planList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Plans');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'programmeQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Programmes');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'changeQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'changeRecurringQueryForm.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#link2').text('Recurring Change Schedules');
        jQuery('#link2').addClass('disabled');
      }
    if (arr[5] === 'reportList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'programmeTypeList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Programme Types');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'templateQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Change Templates');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'planEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Add Change Plan');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'reportList.htm?tag=change') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'reportView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').attr('href', contextUrl + '/change/reportList.htm?tag=change');
      jQuery('#link3').text('Run Report');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'planView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Change Plans');
      jQuery('#link2').attr('href', contextUrl + '/change/planList.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Plan');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Change Programmes');
      jQuery('#link2').attr('href', contextUrl + '/change/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Programme');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Change Programmes');
      jQuery('#link2').attr('href', contextUrl + '/change/programmeQueryForm.htm');
      jQuery('#link3').text('Add / Edit Change Programme');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeComplete.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Programmes');
      jQuery('#link2').attr('href', contextUrl + '/change/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Programme');
      jQuery('#link3').attr('href', contextUrl + '/change/programmeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Change Programme Complete');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeAssessmentView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment ');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'changeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment ');
      jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Update Change');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeBulkQuestionAnswer.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', '<c:url value="/change/changeQueryForm.htm" />');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment');
      jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Answer All');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeQuestionEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment');
      jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Change Assessment Question');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeNoteCreate.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment');
      jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Note');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'programmeNoteCreate.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Change Programmes');
        jQuery('#link2').attr('href', contextUrl + '/change/programmeQueryForm.htm');
        jQuery('#link2').addClass('enabled');
        jQuery('#link3').text('View Change Programme');
        jQuery('#link3').attr('href', contextUrl + '/change/programmeView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link4').text('Add Programme Note');
        jQuery('#link4').addClass('disabled');
      }

    if (arrLink[0] === 'changeAssessmentStep1.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Programmes');
      jQuery('#link2').attr('href', contextUrl + '/change/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Programme');
      jQuery('#link3').attr('href', contextUrl + '/change/programmeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Change Assessment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeAttachmentEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Assessments');
      jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Assessment');
      jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Attachment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'changeAssessmentTrash.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Change Assessments');
        jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
        jQuery('#link2').addClass('enabled');
        jQuery('#link3').text('View Change Assessment');
        jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link4').text('Trash Change Assessment');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'assessmentAssociateView.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Change Assessments');
        jQuery('#link2').attr('href', contextUrl + '/change/changeQueryForm.htm');
        jQuery('#link2').addClass('enabled');
        jQuery('#link3').text('View Change Assessment');
        jQuery('#link3').attr('href', contextUrl + '/change/changeAssessmentView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link4').text('Link RAs');
        jQuery('#link4').addClass('disabled');
      }
    if (arrLink[0] === 'programmeTypeView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Change Programme Types');
      jQuery('#link2').attr('href', contextUrl + '/change/programmeTypeList.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Change Programme Type');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeTypeEdit.htm') {
      if (arrLink[1]) {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Change Programme Types');
        jQuery('#link2').attr('href', contextUrl + '/change/programmeTypeList.htm');
        jQuery('#link3').text('View Change Programme Type ');
        jQuery('#link3').attr('href', contextUrl + '/change/programmeTypeView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link4').text('Edit Change Programme Type');
        jQuery('#link4').addClass('disabled');
      } else {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#liLink4').remove();
        jQuery('#link2').text('Change Programme Types');
        jQuery('#link2').attr('href', contextUrl + '/change/programmeTypeList.htm');
        jQuery('#link3').text('Edit Change Programme Type');
        jQuery('#link3').addClass('disabled');
      }
    }
    if (arrLink[0] === 'templateView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Change Templates');
      jQuery('#link2').attr('href', contextUrl + '/change/templateQueryForm.htm');
      jQuery('#link3').text('View Change Template ');
      jQuery('#link3').attr('disabled');
    }
    if (arrLink[0] === 'templateEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Change Templates');
      jQuery('#link2').attr('href', contextUrl + '/change/templateQueryForm.htm');
      jQuery('#link3').text('View Change Template ');
      jQuery('#link3').attr('href', contextUrl + '/change/templateView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Edit Change Template');
      jQuery('#link4').addClass('disabled');
    }
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

