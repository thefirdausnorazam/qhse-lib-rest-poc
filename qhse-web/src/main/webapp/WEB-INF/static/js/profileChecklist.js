//Added By Manjush On January 15, 2015
var dialogName = "";
var legRegisterOut = 0;
jQuery(document).ready(function() {
  
  jQuery.ajaxSetup({
    cache: false
  });
  
  scansol = {}; // namespace
  
  //Added By Manjush On January 15, 2015
  
  jQuery( "#collapse" ).click(function() {
	  jQuery('.panel-collapse').collapse('hide');
	});
  jQuery( "#expand" ).click(function() {
	  jQuery('.panel-collapse').collapse('show');
	});
 
  jQuery('.accordion').on('shown.bs.collapse', function (e) {		  
	  var pr = jQuery(e.target).attr("profile") ;// activated tab		  
	  var ch = jQuery(e.target).attr("checklist") ;		  	  
	  var url = contextPath+"/law/showChecklistDetail.htmf?checklistId="+ch+"&profileId="+pr;
  	  var checklistDiv = jQuery('#lawLegislation-'+ch);	      
      checklistDiv.load(url, function() {
    	 
      });
      var changesDiv = jQuery('#changes-'+ch);	      
      changesDiv.load(url, function() {
    	 
      });
      var relatedDiv = jQuery('#related-'+ch);	      
      relatedDiv.load(url, function() {
    	 
      });
	})
	  jQuery('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  var target = jQuery(e.target).attr("href") ;// activated tab	
	  var chh = jQuery(e.target).attr("checklist") ;	
	  var actTab = target.substr(0, 6);	
	 
	  switch (actTab) {		  
	  case '#tab35':
		    jQuery('.changes-'+chh).hide();
	        jQuery('.legislation-'+chh).show();
	        jQuery('.relatedCheck-'+chh).hide();
	        break;
	  case '#tab36':			  
	        jQuery('.legislation-'+chh).hide();
	        jQuery('.changes-'+chh).show();
	        jQuery('.relatedCheck-'+chh).hide();
	        break; 
	  case '#tab37':
		    jQuery('.changes-'+chh).hide();
	        jQuery('.legislation-'+chh).hide();		        
	        jQuery('.relatedCheck-'+chh).show();
	        break;
	  
	  }		
	}); 

 
  /*jQuery('.nav-tabs > li ').hover( function(){
        if(jQuery(this).hasClass('hoverblock'))
            return;
        else
        	jQuery(this).find('a').tab('show');
   });*/
  
   /* jQuery('.nav-tabs > li').find('a').click( function(){
    	jQuery(this).parent()
        .siblings().addClass('hoverblock');
   });*/
    // Manjush Ends

	function getURLParameter(name) {
	  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
	}
	legRegister=getURLParameter('legRegister');
	legRegisterOut = getURLParameter('legRegister');
  viewType = getURLParameter('viewType');
  if(viewType == 'notRelevant'){
	  scansol.toggleLabel='Mark Relevant';
  }else{
	  scansol.toggleLabel='Mark Not Relevant';
  }


  function collapseChecklists() {
	  var showAll = getURLParameter('showAll') == 'true' ? true : false;
      var checklistExpand = "Show Detail";
      var checklistCollapse = "Hide Detail";
      var checklistShowRelevant = "Show Relevant";
      var checklistShowNotRelevant = "Show Not Relevant";
	  var expandOnOpening = showAll ? checklistCollapse : checklistExpand;
	  var icdPage = getURLParameter('raType');
	  if(!showAll)
	  {
		  jQuery('tbody[checklistid]').hide();
	  }
	  
	  if(icdPage == null)
	  {
		  jQuery("div.lawIcons").append('<div class="checklist-toggleall"><a target="_self" href="#" ss-action="*" ><img src="'+contextPath+'/legal/images/relevant.png" width="18" height="16" border="0" title="Show Relevant Checklists" /></a>  <a target="_self" href="#" ss-action="!"><img src="'+contextPath+'/legal/images/not-relevant.png" width="18" height="16" border="0" title="Show Non Relevant Checklists" /></a>  <a target="_self" href="#" ss-action="+"><img src="'+contextPath+'/legal/images/expand-all.png" width="18" height="16" border="0" title="Expand All" /></a>  <a target="_self" href="#" ss-action="-"><img src="'+contextPath+'/legal/images/hide-all.png" width="18" height="16" border="0" title="Hide All" /></a></div>');
	  }
      jQuery("div.checklist-toggleall a").click(function() {
	        var expand = jQuery(this).attr("ss-action");
	        jQuery('tbody[checklistid]').toggle(expand=='+'?true:false);
	        var toggleLinks = jQuery('.checklist-toggle a');
	        var relevantLabel = jQuery(this).html();
	        if(expand == '+'){
	        	var profileid = jQuery('thead[profileId]').attr("profileId");
        		var checklistId = getURLParameter('chklistId');
	        	if(checklistId != null)
	        	{
	        		showChecklist(profileid, getURLParameter('chklistId'));
	        		toggleLinks.html(checklistCollapse);
	        	}
	        	else if(location.href.indexOf("showAll") == -1 && profileid != null)
	        	{
	        		window.location.href=window.location+'&profileId='+profileid+'&showAll=true';
	        	}
	        	else {
	        		toggleLinks.html(checklistCollapse);
	        	}
	        }else if(expand == '-'){
	        	toggleLinks.html(checklistExpand);

	        }else if(expand == '*'){
	        	if(legRegister != null)
	        	{
	        		window.location.href=contextPath+'/law/checklists.htm?viewAll=true&viewType=relevant&legRegister='+legRegister;
	        	}
	        }else{
	        	if(legRegister != null)
	        	{
	        		window.location.href=contextPath+'/law/checklists.htm?viewAll=true&viewType=notRelevant&legRegister='+legRegister;
	        	}
	        }
	        return false;
     });
     jQuery(".checklist-title").append('<div class="checklist-toggle"><a target="_self" href="#" >' + expandOnOpening + '</a></div>');
     jQuery(".checklist-toggle a").click(function() {
       var expand = jQuery(this).html().indexOf(checklistExpand) >= 0;
       var link = jQuery(this);
       link.html(expand ? checklistCollapse : checklistExpand);
       var checklistid = link.closest("thead").attr('checklistid');
       if(expand)
       {
	          var profileid = link.closest("thead").attr('profileId');
	          showChecklist(profileid, checklistid);
       }
       jQuery('tbody[checklistid="' + checklistid + '"]').toggle(expand);
      
       return false;
     });
  }
  
  collapseChecklists();

  if(!relevancyEditable) {
    return;
  }

  jQuery(document.body).append('<div id="dialogDiv"></div>');
  jQuery(document.body).append('<div id="dialogDivTest"></div>');
  
  function showChecklist(profileid, checklistid)
  {
	  var url = contextPath+"/law/showChecklistDetail.htmf?checklistId="+checklistid+"&profileId="+profileid;
  	  var checklistDiv = jQuery('tbody[checklistid="' + checklistid + '"] div.showChecklistDetail');
  	
      checklistDiv.load(url, function() {
    	   checklistDiv.find(".profileChecklistToolbar").html(toolbarHtml);
    	   checklistDiv.find("[ss-action]").click(profileChecklistActionHandler);
      });
  }
  
  function openHistory(id) {
    if (id > 0) {
      openWindow(contextPath + "/law/profileChecklistHistory.htm?id=" + id, 800, 600, null, "history", true);
    } else {
      alert("No history available for this record");
    }
  }

  function openWindow(url, w, h, noscrollbars, windowName, resizable) {
    var x = (screen.height-h)/2;
    var y = (screen.width-w)/2;
    var att="toolbar=no,directories=no,location=no,status=no,menubar=no,width="+w+",height="+h+",top="+x+",left="+y;

    if ( (resizable==null) || (!resizable) ) {
      att=att+", resizable=no";
    } else {
      att=att+", resizable=yes";
    }
    if ( (noscrollbars==null) || (!noscrollbars) ) {
      att=att+", scrollbars=yes";
    } else {
      att=att+", scrollbars=no";
    }

    var win = window.open(url, windowName, att);
    win.focus();    
  }

  
  var actions = {
    edit: function(data) {    	
      var profileChecklistId = data.profileChecklistId;      
      if(profileChecklistId < 1) {
    	  profileChecklistId = jQuery("#divProfileChecklistId").attr('ss-pcid');
      }      
      var params = profileChecklistId > 0 ? "showId=" + profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
      jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistEdit.htm?' + params+'&checklist='+data.checklistId+"&locStatus=" + data.loc);
      jQuery("#dialogDiv").dialog("open");
      dialogName = "edit";
    },
    hist: function(data) {
      var id = data.profileChecklistId;
      if(id < 1) {
    	  id = jQuery("#divProfileChecklistId").attr('ss-pcid');
      }
      if (id) {
        //openHistory(id);
        var params = data.profileChecklistId > 0 ? "showId=" + data.profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
        jQuery("#dialogFrame").attr("src", contextPath + "/law/profileChecklistHistory.htm?id=" + id);
        jQuery("#dialogDiv").dialog("open");
        jQuery("#dialogDiv").dialog('option', 'title', SCANNELL_TRANSLATIONS.viewHistory);
        dialogName = "history";
      }
    },
    notRelevant:function(data) {
    	var profileChecklistId = data.profileChecklistId;
        if(profileChecklistId < 1) {
      	  profileChecklistId = jQuery("#divProfileChecklistId").attr('ss-pcid');
        }
    	var params = profileChecklistId > 0 ? "showId=" + profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
    	params=params+"&markRelevant="+(viewType=='notRelevant' ? 'true' : 'false');
        jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistMarkNotRelevant.htm?' + params);
        jQuery("#dialogDiv").dialog("open");
        jQuery("#dialogDiv").dialog('option', 'title', (viewType=='notRelevant' ? SCANNELL_TRANSLATIONS.markRelevant : SCANNELL_TRANSLATIONS.markNotRelevant));
        dialogName = "notRelevant";
      },
    link: function(data) {
    	
      var url = contextPath + '/doclink/holderEdit.htm?holderName=checklist' + data.checklistId + '-' + data.profileId + '&reloadPage=false';      
     // openWindow(url, 1000, 550);  
      jQuery('#dialogDivTest').html('<iframe class="test" id="dialogFrameTest"  width="900" height="650" scrolling="no" marginWidth="0" marginHeight="0" frameBorder="0" close="yes" src="about:blank" />');
      jQuery("#dialogFrameTest").attr("src", url);
      //jQuery("#dialogDivTest").dialog('option', 'title', 'Link Doc');
      jQuery("#dialogDivTest").dialog({autoOpen:false,width:950, title: SCANNELL_TRANSLATIONS.linkDocs}).dialog("open");dialogName = "link";
      
    },
    upload: function(data) {
        jQuery("#dialogFrame").attr("src", contextPath + '/law/addLawAttachment.htm?showId=' + data.checklistId+'0000'+data.profileId);
        jQuery("#dialogDiv").dialog("open");
        jQuery("#dialogDiv").dialog('option', 'title', SCANNELL_TRANSLATIONS.uploadDocs);
      },
    editDoc:function(data) {
        jQuery("#dialogFrame").attr("src", contextPath + '/law/editLawAttachments.htm?showId=' + data.checklistId+'0000'+data.profileId);
        jQuery("#dialogDiv").dialog("open");
        jQuery("#dialogDiv").dialog('option', 'title', SCANNELL_TRANSLATIONS.editDocs);
      },
      addTask:function(data) {    	  
        	var params = "profileId=" + data.profileId + "&checklistId=" + data.checklistId;
        	jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistAddTask.htm?' + params);
        	jQuery("#dialogDiv").dialog('option', 'title', SCANNELL_TRANSLATIONS.addTask);
        	jQuery("#dialogDiv").dialog("open");
        	dialogName = "addTask";
        	jQuery('.ui-dialog-buttonset').hide();
        },
    relevant:function(data) {
    	var params = data.profileChecklistId > 0 ? "showId=" + data.profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
    	params=params+"&markRelevant=true"
        jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistMarkNotRelevant.htm?' + params);
        jQuery("#dialogDiv").dialog("open");
    	jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistMarkNotRelevant.htm?actionType=relevant&checklistId='+data.checklistId+'&checklistVersion='+data.checklistVersion+'&profileId='+data.profileId+'&profileVersion='+data.profileVersion);
        jQuery("#dialogDiv").dialog("open");
        jQuery("#dialogDiv").dialog('option', 'title', 'Relevant');
      }
  }
  /*Title of the page is required to changed back when dialog is closed.*/ 
 jQuery('div#dialogDiv').bind('dialogclose', function(event) {
		jQuery("#dialogDiv").dialog('option', 'title', 'Edit Checklist Relevance and Evaluation of Compliance');
		jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="800" height="550" marginWidth="0" close="yes" marginHeight="0" frameBorder="0" src="about:blank" />');
		jQuery('.ui-dialog-buttonset').show();
	 });
  
  jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="800" height="550" marginWidth="0" close="yes" marginHeight="0" frameBorder="0" src="about:blank" />');
  
  jQuery("#dialogDivTest").html('<iframe id="dialogFrameTest" width="900" height="500" marginWidth="0" close="yes" marginHeight="0" frameBorder="0" src="about:blank" />');
  
  
  jQuery("#dialogDiv").dialog({
    title: SCANNELL_TRANSLATIONS.editChecklistRelevance,
    title: SCANNELL_TRANSLATIONS.editChecklistRelevance,
    height: 'auto',
    width: 840,
    modal: true,
    resizable: false,
    draggable: false,
    autoOpen: false,
    
    //
    buttons:[
             {
                 text: SCANNELL_TRANSLATIONS.close,
                 class: 'g-btn g-btn--primary',
                 icons: { primary: "ui-icon-closethick" },
                 id: "closebtn",
                 click: function() { 
                	 var $this = jQuery(this); 
                	 $this.dialog("close"); 
                 
                 }
             }
         ],
    open: function() {
		    	jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close').addClass('btn btn-primary').html('<span class=\'fa fa-times fa-lg\'></span>');
		    }
  });
  
  
  jQuery("#dialogDivTest").dialog({
	    title: "",
	    height: 'auto',
	    width: 900,
	    modal: true,
	    resizable: false,
	    draggable: false,
	    autoOpen: false,
	    buttons:[
	             {
	                 text: SCANNELL_TRANSLATIONS.close,
	                 class: 'g-btn g-btn--primary',
	                 icons: { primary: "ui-icon-closethick" },
	                 id: "closebtn",
	                 click: function() { 
	                	 var $this = jQuery(this); 
	                	 $this.dialog("close"); 
	                 
	                 }
	             }
	         ],
	    open: function() {
			    	jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close').addClass('btn btn-primary').html('<span class=\'fa fa-times fa-lg\'></span>');
			    }
	  });
  
  
 
  
  var toolbarHtml = [
     '<div id="checklistToolbarDiv" class="ss-law-actionbar">',
     
     '<a id="edi" class="btn btn-primary ed" data-placement="top" target="_self" ss-action="edit" href="#"><i class="fa fa-edit"></i>'+SCANNELL_TRANSLATIONS.editCompliance+'</a>',
	 '<a id="notRe" class="btn btn-primary not bt-notRe" data-placement="top" target="_self" ss-action="notRelevant" href="#"><i class="fa fa-unlink"></i>'+SCANNELL_TRANSLATIONS.markNotRelevant+'</a>',
	 '<a id="relev" class="btn btn-primary not bt-relev" data-placement="top" target="_self" ss-action="notRelevant" href="#"><i class="fa fa-link"></i>'+SCANNELL_TRANSLATIONS.markRelevant+'</a> ',
	 '<a id="addTas" class="btn btn-primary at" data-placement="top" target="_self" ss-action="addTask" href="#"><i class="fa fa-check-square"></i>'+SCANNELL_TRANSLATIONS.addTask+'</a>',
     '<a id="linkk" class="btn btn-primary ldoc" data-placement="top" target="_self" ss-action="link" href="#"><i class="fa fa-copy"></i>'+SCANNELL_TRANSLATIONS.linkDocs+'</a>',
     '<a id="uploa" class="btn btn-primary up" data-placement="top" target="_self" ss-action="upload" href="#"><i class="fa fa-cloud-upload"></i>'+SCANNELL_TRANSLATIONS.uploadDocs+'</a>',
     '<a id="editDo" class="btn btn-primary edoc" data-placement="top" target="_self" ss-action="editDoc" href="#"><i class="fa fa-file-text-o"></i>'+SCANNELL_TRANSLATIONS.editDocs+'</a>',
	 '<a id="his" class="btn btn-primary vh" data-placement="top" target="_self" ss-action="hist" href="#"><i class="fa fa-list"></i>'+SCANNELL_TRANSLATIONS.viewHistory+'</a>',
	 
     '</div>'
  ].join("");
  
 
  
  

  function profileChecklistActionHandler(){	  
	  var actionPane = jQuery('.nav-tabs');
      var actionBarDiv = jQuery("[ss-action]").closest("#toolBar");     
     
      var data = {
        profileId: actionBarDiv.attr('ss-pid'),        
        profileVersion: actionBarDiv.attr('ss-pversion'),
        checklistId: actionBarDiv.attr('ss-cid'),
        checklistVersion: actionBarDiv.attr('ss-cversion'),
        profileChecklistId: actionBarDiv.attr('ss-pcid'),
        loc:actionBarDiv.attr('ss-loc')
      }

      scansol.checklistData = data;
      scansol.actionKey=jQuery(this).attr('ss-action');
      var action = actions[scansol.actionKey];
      if (typeof action !== "undefined" && action !== null)
      {    	
    	  action(data);
      }    
      return false;
    }  

  var refine = getURLParameter('refine');
  if(refine != undefined) {
	  jQuery(".profileChecklistToolbar").html(toolbarHtml);
  }
  
  jQuery("[ss-action]").click(profileChecklistActionHandler);
 
  scansol.checklistEditDialogClose = function() {  
    jQuery("#dialogDiv").dialog("close");
    //for some reason the Dialog of Doclink nedds this follow lines to close itself
    jQuery("#dialogDivTest").dialog({autoOpen:false,width:950, title:'Link Doc'}).dialog("close");
    jQuery("#dialogDivTest").dialog("close");    
    var checklistData = scansol.checklistData;
    if (typeof checklistData !== "undefined" && checklistData !== null)
    {     	
    //var relevanceDiv = jQuery('tbody[checklistid="' + checklistData.checklistId + '"] div.relevance-detail');
    var relevanceDiv = jQuery('#divChklRelevance');
    var checklistRelevanceDetailUrl = contextPath + '/law/checklistRelevanceDetail.htmf?profileId=' + checklistData.profileId + "&checklistId=" + checklistData.checklistId;
    //relevanceDiv.mask("Waiting..."); this line is not supported in ie9
      relevanceDiv.load(checklistRelevanceDetailUrl, function(event) {    	 
    	 // alert();dataDetails
 //     relevanceDiv.unmask();
//      relevanceDiv.find(".profileChecklistToolbar").html(toolbarHtml);
//      relevanceDiv.find("[ss-action]").click(profileChecklistActionHandler);
//      if(scansol.actionKey == 'notRelevant'){ //refresh checklist list to remove this checklist from display
//  		window.location.reload();
//      }
    });
      var relevanceDiv2 = jQuery('#divChklTask');
      var checklistRelevanceDetailUrl2 = contextPath + '/law/checklistTaskDetail.htmf?profileId=' + checklistData.profileId + "&checklistId=" + checklistData.checklistId;
      relevanceDiv2.load(checklistRelevanceDetailUrl2, function() {
    	  
        });
      
      var relevanceDiv3 = jQuery('#tab33-'+checklistData.checklistId);
      var checklistRelevanceDetailUrl3 = contextPath + '/law/checklistDocDetail.htmf?profileId=' + checklistData.profileId + "&checklistId=" + checklistData.checklistId;
      relevanceDiv3.load(checklistRelevanceDetailUrl3, function() {
        });
	}
  };
  profileChecklistActionHandler();

});


function editChecklist(checklist,profileChecklistId,profileId,loc){	
    var params = profileChecklistId > 0 ? "showId=" + profileChecklistId :  "profile=" + profileId + "&checklistId=" + checklist ;
    jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistEdit.htm?' + params+'&checklist='+checklist+ "&locStatus=" + loc);
    jQuery("#dialogDiv").dialog("open");
    dialogName = "edit";
}

function onPopupClose() {	
  scansol.checklistEditDialogClose();
  if(dialogName == "notRelevant") {
	  if(jQuery('#lawTabs').val() != ''){
		  legRegister = jQuery('#lawTabs').val();
	  }
	  var viewType = getUrlParameter('viewType') == "relevant" ? "viewType=notRelevant" : "";
	  window.location.href=contextPath+'/law/checklists.htm?refine=false&viewAll=true&legRegister=' + legRegister + '&' + viewType;
  } else {
	  if(document.getElementById('divChklRelevance') == null) {
		  window.location.reload(); 
	  } 
  }

}



function getUrlParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
}

