/**
 *Manjush
 */
var AuditBC;

AuditBC = (function() {
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
      href: contextUrl + '/css/audit.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Audit');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#auditDropdown').css('background-color', '#13AB94');
    jQuery('#auditDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#auditDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#auditDropdown .caret').css('border-top-color', '#FFFFFF');
    
    
    jQuery('#link1').attr('href', contextUrl + '/audit/workspace.htm');
    jQuery('#link1').text('Audit');
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
    }
    if (arr[5] === 'planQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audit Plans');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'programmeQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audit Programmes');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'auditQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'auditRecurringQueryForm.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#link2').text('Recurring Audit Schedules');
        jQuery('#link2').addClass('disabled');
      }
    if (arr[5] === 'reportList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'programmeTypeList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audit Programme Types');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'templateQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Audit Templates');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'thirdPartyQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Search Third Party Auditee');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'planEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Add Audit Plan');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'reportList.htm?tag=audit') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'reportView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').attr('href', contextUrl + '/audit/reportList.htm?tag=audit');
      jQuery('#link3').text('Run Report');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'recurringAuditView.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#link2').text('View Recurring Audit');
        jQuery('#link2').addClass('disabled');
      }
    if (arrLink[0] === 'planView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Audit Plans');
      jQuery('#link2').attr('href', contextUrl + '/audit/planQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit Plan');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Audit Programmes');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit Programme');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Audit Programmes');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeQueryForm.htm');
      jQuery('#link3').text('Add / Edit Audit Programme');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeComplete.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audit Programmes');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit Programme');
      jQuery('#link3').attr('href', contextUrl + '/audit/programmeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Audit Programme Complete');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'recurringScheduledAuditEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audit Programmes');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit Programme');
      jQuery('#link3').attr('href', contextUrl + '/audit/programmeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Recurring Audit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'auditView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', contextUrl + '/audit/auditQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'auditEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', contextUrl + '/audit/auditQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').attr('href', contextUrl + '/audit/auditView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Update Audit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'auditBulkQuestionAnswer.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', '<c:url value="/audit/auditQueryForm.htm" />');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').attr('href', contextUrl + '/audit/auditView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Answer All');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'auditQuestionEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', contextUrl + '/audit/auditQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').attr('href', contextUrl + '/audit/auditView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Audit Question');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'auditNoteCreate.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', contextUrl + '/audit/auditQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').attr('href', contextUrl + '/audit/auditView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Note');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'auditAttachmentEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audits');
      jQuery('#link2').attr('href', contextUrl + '/audit/auditQueryForm.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit ');
      jQuery('#link3').attr('href', contextUrl + '/audit/auditView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Attachment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'programmeTypeView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Audit Programme Types');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeTypeList.htm');
      jQuery('#link2').addClass('enabled');
      jQuery('#link3').text('View Audit Programme Type');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'programmeTypeEdit.htm') {
      if (arrLink[1]) {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
        jQuery('#link2').text('Audit Programme Types');
        jQuery('#link2').attr('href', contextUrl + '/audit/programmeTypeList.htm');
        jQuery('#link3').text('View Audit Programme Type ');
        jQuery('#link3').attr('href', contextUrl + '/audit/programmeTypeView.htm?id=' + localStorage.getItem('id'));
        jQuery('#link4').text('Edit Audit Programme Type');
        jQuery('#link4').addClass('disabled');
      } else {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        jQuery('#liLink4').remove();
        jQuery('#link2').text('Audit Programme Types');
        jQuery('#link2').attr('href', contextUrl + '/audit/programmeTypeList.htm');
        jQuery('#link3').text('Edit Audit Programme Type');
        jQuery('#link3').addClass('disabled');
      }
    }
    if (arrLink[0] === 'recurringExpressAuditEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audit Programme Types');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeTypeList.htm');
      jQuery('#link3').text('View Audit Programme Type ');
      jQuery('#link3').attr('href', contextUrl + '/audit/programmeTypeView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Add Recurring Audit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'templateView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Audit Templates');
      jQuery('#link2').attr('href', contextUrl + '/audit/templateQueryForm.htm');
      jQuery('#link3').text('View Audit Template ');
      jQuery('#link3').attr('disabled');
    }
    if (arrLink[0] === 'templateEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Audit Programme Types');
      jQuery('#link2').attr('href', contextUrl + '/audit/programmeTypeList.htm');
      jQuery('#link3').text('View Audit Template ');
      jQuery('#link3').attr('href', contextUrl + '/audit/templateView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Edit Audit Template');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'thirdPartyView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#liLink4').remove();
      jQuery('#link2').text('Search Third Party Auditee');
      jQuery('#link2').attr('href', contextUrl + '/audit/thirdPartyQueryForm.htm');
      jQuery('#link3').text('View Third Party Auditee ');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'thirdPartyEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Search Third Party Auditee');
      jQuery('#link2').attr('href', contextUrl + '/audit/thirdPartyQueryForm.htm');
      jQuery('#link3').text('View Third Party Auditee ');
      jQuery('#link3').attr('href', contextUrl + '/audit/thirdPartyView.htm?id=' + localStorage.getItem('id'));
      jQuery('#link4').text('Edit Third Party Auditee');
      jQuery('#link4').addClass('disabled');
    }
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

