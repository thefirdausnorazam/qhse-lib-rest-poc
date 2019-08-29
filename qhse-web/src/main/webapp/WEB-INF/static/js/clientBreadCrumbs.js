/**
 *
 */
var ClientBC;

ClientBC = (function() {
  var breadCrumbs;
  breadCrumbs = function(arr) {
    var arrLink, contextUrl, urlParamId, urlParamQuestionId, urlParamShowId;
    arrLink = new Array;
    jQuery('.dashDiv').hide();
    contextUrl = '/' + arr[3];
    urlParamId = getURLParam('id');
    urlParamShowId = getURLParam('showId');
    urlParamQuestionId = getURLParam('questionId');
    if (urlParamQuestionId) {
        localStorage.setItem('questionId', urlParamQuestionId);
    }
    else if (urlParamId) {
      localStorage.setItem('id', urlParamId);
    } 
    else if (urlParamShowId) {
      localStorage.setItem('id', urlParamShowId);
    }

    /* for adding css based on module */
    jQuery('<link/>').attr({
      rel: 'stylesheet',
      type: 'text/css',
      media: 'all',
      href: contextUrl + '/css/client.css'
    }).appendTo('head');
    jQuery('#h2Mod').text('User Defined Questions');
    jQuery('.page-head').css('border-bottom', ' 2px solid #00B483');
    jQuery('#clientDropdown').css('background-color', '#00B483');
    jQuery('#link1').attr('href', contextUrl + '/client/clientQuestionList.htm');
    jQuery('#link1').text('User Defined Questions');
    if (arr[5] !== null) {
        arrLink = arr[5].split('?');
      }
      if (arr[5] === 'clientQuestionList.htm') {
    	  jQuery('#link1').addClass('disabled');
      }
       if (arrLink[0] === 'questionEdit.htm') {
        jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
        jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
        if (arrLink[1]) {
            jQuery('#link2').text('View User Defined Question');
            jQuery('#link2').addClass('enabled');
            jQuery('#link2').attr('href', contextUrl + '/client/clientQuestionView.htm?id=' + localStorage.getItem('id'));
            jQuery('#link3').text('Update User Defined Question');
            jQuery('#link3').addClass('disabled');
        	
        }
        else {
	        jQuery('#link2').text('Add User Defined Question');
	        jQuery('#link2').addClass('disabled');
      	}
      }
       else if (arrLink[0] === 'questionOptionEdit.htm') {
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
          if (localStorage.getItem('id') != localStorage.getItem('questionId')) {
              jQuery('#link2').text('View User Defined Question');
              jQuery('#link2').addClass('enabled');
              jQuery('#link2').attr('href', contextUrl + '/client/clientQuestionView.htm?id=' + localStorage.getItem('questionId'));
              jQuery('#link3').text('Update User Defined Option');
              jQuery('#link3').addClass('disabled');
          	
          }
          else {
             jQuery('#link2').text('View User Defined Question');
             jQuery('#link2').addClass('enabled');
             jQuery('#link2').attr('href', contextUrl + '/client/clientQuestionView.htm?id=' + localStorage.getItem('questionId'));
  	         jQuery('#link3').text('Add User Defined Option');
  	         jQuery('#link3').addClass('disabled');
          }
        }
        else if (arrLink[0] === 'dependsOnOptionConfigure.htm') {
            jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
            jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
            jQuery('#link2').text('View User Defined Question');
            jQuery('#link2').addClass('enabled');
            jQuery('#link2').attr('href', contextUrl + '/client/clientQuestionView.htm?id=' + localStorage.getItem('questionId'));
            jQuery('#link3').text('Configure Depends On Option');
            jQuery('#link3').addClass('disabled');
          }
       else if (arrLink[0] === 'clientQuestionView.htm') {
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#link2').text('View User Defined Question ');
          jQuery('#link2').addClass('disabled');
      }
      else if (arrLink[0] === 'clientQuestionOptionView.htm') {
          jQuery('#breadcrumb').append(' <li id="liLink2"><a id="link2"></a></li>');
          jQuery('#breadcrumb').append(' <li id="liLink3"><a id="link3"></a></li>');
          jQuery('#link2').text('View User Defined Question');
          jQuery('#link2').addClass('enabled');
          jQuery('#link2').attr('href', contextUrl + '/client/clientQuestionView.htm?id=' + localStorage.getItem('questionId'));
          jQuery('#link3').text('User Defined Question Option');
          jQuery('#link3').addClass('disabled');
        }
      
  };
  return {
    breadCrumbs: function(arr) {
      breadCrumbs(arr);
    }
  };
})();

