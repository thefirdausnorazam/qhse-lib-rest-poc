/**
 * 
 */

var DoclinkBC = function () {
	
	  var  breadCrumbs = function(arr){
		var arrLink;  
		var contextUrl="/"+arr[3];
		
		 
		jQuery('<link/>').attr({
            rel:'stylesheet',
            type:'text/css',
            media:'all',
            href:'<c:url value="/css/docs.css"/>'
        }).appendTo('head'); 
            
   		jQuery("#h2Mod").text("Docs");
   		  
		jQuery('.page-head').css('border-bottom', ' 2px solid #13AB94');
		jQuery('#doclinksDropdown').css('background-color', '#13AB94');
		jQuery('#doclinksDropdown a.dropdown-toggle').css('color', '#FFFFFF');
		jQuery('#doclinksDropdown .caret').css('border-bottom-color', '#FFFFFF');
		jQuery('#doclinksDropdown .caret').css('border-top-color', '#FFFFFF');
   		  
		/* BreadCrumbs for DocLinks */
		  
		jQuery("#link1").attr("href", contextUrl+'/doclink/linkSearchForm.htm');
		jQuery("#link1").text("Docs");
	  
	  };
	  return {
		  breadCrumbs: function (arr){
			  breadCrumbs(arr);
		    },
	  };
	  
}();