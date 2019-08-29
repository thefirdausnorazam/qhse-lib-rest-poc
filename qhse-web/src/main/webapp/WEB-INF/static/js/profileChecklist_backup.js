
jQuery(document).ready(function() {
  
  jQuery.ajaxSetup({
    cache: false
  });
  
  scansol = {}; // namespace
  
  function collapseChecklists() {
      var checklistExpand = "Show Detail";
      var checklistCollapse = "Hide Detail";

      if($jq('tbody[checklistid]').length < 1) {
    	  return;
      }

      $jq('tbody[checklistid]').hide();

      $jq("div.law").append('<div class="checklist-toggleall"><a target="_self" href="#" ss-action="+">Show All</a> | <a target="_self" href="#" ss-action="-">Hide All</a></div>');
      $jq("div.checklist-toggleall a").click(function() {
        var expand = $jq(this).attr("ss-action") === "+";
        $jq('tbody[checklistid]').toggle(expand);
        var toggleLinks = $jq('.checklist-toggle a');
        toggleLinks.html(expand ? checklistCollapse : checklistExpand);
        return false;
      });


      $jq(".checklist-title").append('<div class="checklist-toggle"><a target="_self" href="#" >' + checklistExpand + '</a></div>');
      $jq(".checklist-toggle a").click(function() {
        var expand = $jq(this).html().indexOf(checklistExpand) >= 0;
        var link = $jq(this);
        link.html(expand ? checklistCollapse : checklistExpand);
        var checklistid = link.closest("thead").attr('checklistid');
        $jq('tbody[checklistid="' + checklistid + '"]').toggle(expand);
        return false;
      });
  }
  
  collapseChecklists();

  if(!relevancyEditable) {
    return;
  }

  jQuery(document.body).append('<div id="dialogDiv"></div>');
  
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
      var params = data.profileChecklistId > 0 ? "showId=" + data.profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
      jQuery("#dialogFrame").attr("src", contextPath + '/law/profileChecklistEdit.htm?' + params);
      jQuery("#dialogDiv").dialog("open");
    },
//    addtask: function(data) {
//      var params = data.profileChecklistId > 0 ? "showId=" + data.profileChecklistId :  "profile=" + data.profileId + "&checklistId=" + data.checklistId;
//      jQuery("#dialogFrame").attr("src", contextPath + '/risk/taskEdit.htm?managementProgrammeId=7&printable=true' );
//      jQuery("#dialogDiv").dialog("open");
//    },
    hist: function(data) {
      var id = data.profileChecklistId;
      if (id) {
        openHistory(id)
      }
    },
    docs: function(data) {
      var url = contextPath + '/doclink/holderEdit.htm?holderName=checklist' + data.checklistId + '-' + data.profileId;
      openWindow(url, 1000, 550); 
    },
    upload: function(data) {
        jQuery("#dialogFrame").attr("src", contextPath + '/law/addLawAttachment.htm?showId=' + data.profileChecklistId);
        jQuery("#dialogDiv").dialog("open");
       // var url = contextPath + '/law/addLawAttachment.htm?showId=' + data.profileChecklistId;
        //openWindow(url, 900, 500); 
      }
  }
  
  jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="600" height="420" marginWidth="0" marginHeight="0" frameBorder="0" src="about:blank" />');
  
  jQuery("#dialogDiv").dialog({
    title: SCANNELL_TRANSLATIONS.editChecklistRelevance,
    height: 'auto',
    width: 640,
    modal: true,
    resizable: false,
    draggable: false,
    autoOpen: false
  });
  
  var toolbarHtml = [
     '<div class="ss-law-actionbar">',
      '<a target="_self" ss-action="edit" href="#">Edit</a> | ',
      '<a target="_self" ss-action="hist" href="#">View History</a> | ', 
      '<a target="_self" ss-action="upload" href="#">Documents</a> | ', 
      '<a target="_self" ss-action="link" href="#">Link Docs</a> ',
    '</div>' 
  ].join("");
  
  function profileChecklistActionHandler(){
    var actionBarDiv = jQuery(this).closest(".profileChecklistToolbar");
    var data = {
      profileId: actionBarDiv.attr('ss-pid'),
      checklistId: actionBarDiv.attr('ss-cid'),
      profileChecklistId: actionBarDiv.attr('ss-pcid')
    }
    scansol.checklistData = data;
    var action = actions[jQuery(this).attr('ss-action')];
    action(data);
    return false;
  }
  
  jQuery(".profileChecklistToolbar").html(toolbarHtml);
  jQuery("[ss-action]").click(profileChecklistActionHandler);
 
  scansol.checklistEditDialogClose = function() {
    jQuery("#dialogDiv").dialog("close");
    var checklistData = scansol.checklistData;
    var relevanceDiv = jQuery('tbody[checklistid="' + checklistData.checklistId + '"] div.relevance-detail');
    var checklistRelevanceDetailUrl = contextPath + '/law/checklistRelevanceDetail.htmf?profileId=' + checklistData.profileId + "&checklistId=" + checklistData.checklistId;
    relevanceDiv.mask("Waiting...");
    relevanceDiv.load(checklistRelevanceDetailUrl, function() {
      relevanceDiv.unmask();
      relevanceDiv.find(".profileChecklistToolbar").html(toolbarHtml);
      relevanceDiv.find("[ss-action]").click(profileChecklistActionHandler);
    });
  };

});

function onPopupClose() {
  scansol.checklistEditDialogClose();
}

