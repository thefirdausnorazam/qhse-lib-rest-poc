/**
 *Mamjush
 */
var WasteBC;

WasteBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, contextUrl, urlParamId, urlParamOwnerId,urlMeasurementId;
    arrLink = new Array;
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamOwnerId = getURLParam('ownerId');
    urlMeasurementId = getURLParam('measurementId');
    if(urlMeasurementId){
    	localStorage.setItem('measurementId', urlMeasurementId);
    }
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
      href: contextUrl + '/css/data.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('Data');
    jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
    jQuery('#dataDropdown').css('background-color', '#13AB94');
    jQuery('#dataDropdown a.dropdown-toggle').css('color', '#FFFFFF');
    jQuery('#dataDropdown .caret').css('border-bottom-color', '#FFFFFF');
    jQuery('#dataDropdown .caret').css('border-top-color', '#FFFFFF');

    /* BreadCrumbs for Data */
    jQuery('#link1').attr('href', contextUrl + '/survey/home.htm');
    jQuery('#link1').text('Data');
    if (arr[5] !== null) {
      arrLink = arr[5].split('?');
    }
    if (arr[5] === 'home.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('My Workspace');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'dataEntryQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Data Entry');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'monitoringProgrammeViewCategories.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Monitoring Programme');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'measurementQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'readingQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Readings');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'limitPeriodQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Compliance Status');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'ppeQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('PPE Records');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'trainingQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Training Records');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'equipmentQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Equipment Records');
      jQuery('#link2').addClass('disabled');
    }
   /* if (arr[5] === 'equipmentQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Equipment Records');
      jQuery('#link2').addClass('disabled');
    }*/
    if (arrLink[0] === 'measurementView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').attr('href', contextUrl + '/survey/measurementQueryForm.htm');
      jQuery('#link3').text('View Measurement');
      jQuery('#link3').attr('href', contextUrl+'/survey/measurementView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arr[5] === 'measurementEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').attr('href', contextUrl +'/survey/measurementList.htm');
      jQuery('#link3').text('Add Measurement');
      jQuery('#link3').addClass('disabled');
    } else if (arrLink[0] === 'measurementEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').attr('href', contextUrl + '/survey/measurementQueryForm.htm');
      jQuery('#link3').text('View Measurement');
      jQuery('#link3').attr('href', contextUrl + '/survey/measurementView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Measurement Edit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'limitEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').attr('href', contextUrl + '/survey/measurementQueryForm.htm');
      jQuery('#link3').text('View Measurement');
      jQuery('#link3').attr('href', contextUrl +'/survey/measurementView.htm?id='+localStorage.getItem('measurementId'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Create/Edit Limit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'editMeasurementAttachment.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').attr('href', contextUrl + '/survey/measurementQueryForm.htm');
      jQuery('#link3').text('View Measurement');
      jQuery('#link3').attr('href', contextUrl + '/survey/measurementView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Add Attachment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'readingView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Readings');
      jQuery('#link2').attr('href', contextUrl + '/survey/readingQueryForm.htm');
      jQuery('#link3').text('View Reading');
      jQuery('#link3').attr('href', contextUrl + '/survey/readingView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'limitPeriodView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Compliance Status');
      jQuery('#link2').attr('href', contextUrl + '/survey/limitPeriodQueryForm.htm');
      jQuery('#link3').text('View Compliance Status');
      jQuery('#link3').attr('href', contextUrl + '/survey/limitPeriodView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'limitView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Compliance Status');
      jQuery('#link2').attr('href', contextUrl + '/survey/limitPeriodQueryForm.htm');
      jQuery('#link3').text('View Compliance Status');
      jQuery('#link3').attr('href', contextUrl +'/survey/limitPeriodView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('View Limit');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'ppeRecordView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('PPE Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/ppeQueryForm.htm');
      jQuery('#link3').text('View PPE Schedule');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'ppeRecordView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('PPE Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/ppeQueryForm.htm');
      jQuery('#link3').text('View PPE Schedule');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'ppeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('PPE Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/ppeQueryForm.htm');
      jQuery('#link3').text('View PPE Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/ppeRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Update/Edit PPE Schedule');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'ppeServiceEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('PPE Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/ppeQueryForm.htm');
      jQuery('#link3').text('View PPE Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/ppeRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Record PPE Details');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'trainingRecordView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Training Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/trainingQueryForm.htm');
      jQuery('#link3').text('View Training Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/trainingRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'trainingEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Training Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/trainingQueryForm.htm');
      jQuery('#link3').text('View Training Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/trainingRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Update Training Schedule');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'trainingHistoryEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Training Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/trainingQueryForm.htm');
      jQuery('#link3').text('View Training Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/trainingRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Record Training');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'equipmentRecordView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Equipment Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/equipmentQueryForm.htm');
      jQuery('#link3').text('View Equipment Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/equipmentRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'equipmentEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Equipment Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/equipmentQueryForm.htm');
      jQuery('#link3').text('View Equipment Schedule');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/equipmentRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Update Equipment Schedule');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'equipmentServiceEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Equipment Records');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/equipmentQueryForm.htm');
      jQuery('#link3').text('View Equipment Schedule');
      jQuery('#link3').attr('href', contextUrl +'/maintenance/equipmentRecordView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Service Details');
      jQuery('#link4').addClass('disabled');
    }

    /* Reports */
    if (arr[5] === 'reportList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'reportView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Reports');
      jQuery('#link2').attr('href', contextUrl + '/survey/reportList.htm');
      jQuery('#link3').text('Run Report');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'quantityCategoryList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'quantityCategoryEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').attr('href', contextUrl + '/survey/quantityCategoryList.htm');
      jQuery('#link3').text('Add Category');
      jQuery('#link3').addClass('disabled');
    } else if (arrLink[0] === 'quantityCategoryEdit.htm' && show !== null) {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').attr('href', contextUrl + '/survey/quantityCategoryList.htm');
      jQuery('#link3').text('View Category');
      jQuery('#link3').attr('href', contextUrl + '/survey/quantityCategoryView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Update Category');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'quantityCategoryView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').attr('href', contextUrl + '/survey/quantityCategoryList.htm');
      jQuery('#link3').text('View Category');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'quantityView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').attr('href', contextUrl + '/survey/quantityCategoryList.htm');
      jQuery('#link3').text('View Parameter');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'quantityEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Parameter Categories');
      jQuery('#link2').attr('href', contextUrl + '/survey/quantityCategoryList.htm');
      jQuery('#link3').text('View Category');
      jQuery('#link3').attr('href', contextUrl + '/survey/quantityCategoryView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Add Parameter');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'readingPointList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Monitoring Points');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'readingPointEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Monitoring Points');
      jQuery('#link2').attr('href', contextUrl + '/survey/readingPointList.htm');
      jQuery('#link3').text('Add Monitoring Point');
      jQuery('#link3').addClass('disabled');
    } else if (arrLink[0] === 'readingPointEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Monitoring Points');
      jQuery('#link2').attr('href', contextUrl + '/survey/readingPointList.htm');
      jQuery('#link3').text('View Monitoring Point');
      jQuery('#link3').attr('href', contextUrl + '/survey/readingPointView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Update Monitoring Point');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'readingPointView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Monitoring Points');
      jQuery('#link2').attr('href', contextUrl + '/survey/readingPointList.htm');
      jQuery('#link3').text('View Monitoring Point');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'measurementList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Measurements');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'categoryList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('PPE , Equipment & Training');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'categoryView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('PPE , Equipment & Training');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/categoryList.htm');
      jQuery('#link3').text('View PPE Types / Equipment / Training');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'categoryEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('PPE , Equipment & Training');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/categoryList.htm');
      jQuery('#link3').text('Category View');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/categoryView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Update PPE Type / Equipment / Training');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'thirdPartyQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Third Party Members');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'thirdPartyView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Third Party Members');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/thirdPartyQueryForm.htm');
      jQuery('#link3').text('View Third Party Members');
      jQuery('#link3').addClass('disabled');
    }
    if (arr[5] === 'thirdPartyEdit.htm') {
      jQuery('#link2').text('Third Party Members');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/thirdPartyQueryForm.htm');
      jQuery('#link3').text('New Third Party Members');
      jQuery('#link3').addClass('disabled');
    } else if (arrLink[0] === 'thirdPartyEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Third Party Members');
      jQuery('#link2').attr('href', contextUrl + '/maintenance/thirdPartyQueryForm.htm');
      jQuery('#link3').text('View Third Party Members');
      jQuery('#link3').attr('href', contextUrl + '/maintenance/thirdPartyView.htm?id='+localStorage.getItem('id'));
      jQuery('#link3').addClass('enabled');
      jQuery('#link4').text('Edit Third Party Member');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentQueryForm.htm');
      jQuery('#link3').text('View Waste Consignment');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentReconcile.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentView.htm');
      jQuery('#link3').text('View Waste Consignment');
      jQuery('#link3').attr('href', contextUrl + '/waste/wasteConsignmentView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Reconcile Waste Consignment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'wasteShipmentDocumentEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentView.htm');
      jQuery('#link3').text('View Waste Consignment');
      jQuery('#link3').attr('href', contextUrl + '/waste/wasteConsignmentView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('New Shipment Record');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'wasteTreatmentDocumentEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentView.htm');
      jQuery('#link3').text('View Waste Consignment');
      jQuery('#link3').attr('href', contextUrl + '/waste/wasteConsignmentView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Update Disposal/Recovery Record');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'wasteDocumentAttachmentCreate.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Waste Shipment');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentView.htm');
      jQuery('#link3').text('View Waste Consignment');
      jQuery('#link3').attr('href', contextUrl + '/waste/wasteConsignmentView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Add Attachment');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentItemQueryForm.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Consignment Items');
      jQuery('#link2').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentItemView.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Consignment Items');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentItemQueryForm.htm');
      jQuery('#link3').text('View Waste Consignment Item');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'wasteConsignmentItemEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink4"><a id="link4"></a></li>');
      jQuery('#link2').text('Consignment Items');
      jQuery('#link2').attr('href', contextUrl + '/waste/wasteConsignmentItemQueryForm.htm');
      jQuery('#link3').text('View Waste Consignment Item');
      jQuery('#link3').attr('href', contextUrl + '/waste/wasteConsignmentItemView.htm?id='+localStorage.getItem('id'));
      jQuery('#link4').text('Edit Waste Consignment Item');
      jQuery('#link4').addClass('disabled');
    }
    if (arrLink[0] === 'carrierList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Carriers');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'carrierEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Carriers');
      jQuery('#link2').attr('href', contextUrl + '/waste/carrierList.htm');
      jQuery('#link3').text('New Carrier');
      jQuery('#link3').addClass('disabled');
    }
    if (arrLink[0] === 'consigneeList.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Consignees');
      jQuery('#link2').addClass('disabled');
    }
    if (arr[5] === 'consigneeEdit.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
      jQuery('#link2').text('Consignees ');
      jQuery('#link2').attr('href', contextUrl + '/waste/consigneeList.htm');
      jQuery('#link3').text('New Consignees ');
      jQuery('#link3').addClass('disabled');
    }
    if (arr[5] === 'bulkLimitPeriodBreachWarningReview.htm') {
      jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
      jQuery('#link2').text('Review Warnings');
      jQuery('#link2').addClass('disabled');
    }
    
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

