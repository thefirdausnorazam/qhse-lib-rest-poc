<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
  

    jQuery.ajaxSetup({
        cache: false
      });
      var legRegister='<c:out value="${profile.registerType.id}"/>';
      var profileId='<c:out value="${profile.id}"/>';
      var keywordId='<c:out value="${keywordId}"/>';
      scansol = {}; // namespace
      function collapseChecklists() {
          var checklistExpand = "Show Detail";
          var checklistCollapse = "Hide Detail";
          var checklistShowRelevant = "Show Relevant";
          var checklistShowNotRelevant = "Show Not Relevant";

          $jq('tbody[checklistid]').hide();
          $jq("div.law").append('<div style="margin-right:25px" class="checklist-toggleall"><a target="_self" href="javascript:void();" ss-action="*" ><img src="<law:url value="/legal/images/relevant.png" />" width="18" height="16" border="0" alt="Show Relevant Checklists" /></a>  <a target="_self" href="javascript:void();" ss-action="!"><img src="<law:url value="/legal/images/not-relevant.png" />" width="18" height="16" border="0" alt="Show Non Relevant Checklists" /></a>  <a target="_self" href="#" ss-action="+"><img src="<law:url value="/legal/images/expand-all.png" />" width="18" height="16" border="0" alt="Expand All" /></a>  <a target="_self" href="#" ss-action="-"><img src="<law:url value="/legal/images/hide-all.png" />" width="18" height="16" border="0" alt="Hide All" /></a></div>');
          $jq("div.checklist-toggleall a").click(function() {
    	        var expand = $jq(this).attr("ss-action");
    	        $jq('tbody[checklistid]').toggle(expand=='+'?true:false);
    	        var toggleLinks = $jq('.checklist-toggle a');
    	        var relevantLabel = $jq(this).html();
    	        if(expand == '+'){
    	        	toggleLinks.html(checklistCollapse);
    	        }else if(expand == '-'){
    	        	toggleLinks.html(checklistExpand);
    	    
    	        }else if(expand == '*'){
    	        	window.location.href=contextPath+'/law/keyword.htm?id='+keywordId+'&viewAll=true&viewType=relevant&legRegister='+legRegister+'&profileId='+profileId;
    	        }else{
    	        	window.location.href=contextPath+'/law/keyword.htm?id='+keywordId+'&viewAll=true&viewType=notRelevant&legRegister='+legRegister;
    	        }
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
        hist: function(data) {
          var id = data.profileChecklistId;
          if (id) {
            openHistory(id)
          }
        },
        link: function(data) {
          var url = contextPath + '/doclink/holderEdit.htm?holderName=checklist' + data.checklistId + '-' + data.profileId;
          openWindow(url, 1000, 550); 
        },
        upload: function(data) {
            jQuery("#dialogFrame").attr("src", contextPath + '/law/addLawAttachment.htm?showId=' + data.checklistId+'0000'+data.profileId);
            jQuery("#dialogDiv").dialog("open");
          },
        editDoc:function(data) {
            jQuery("#dialogFrame").attr("src", contextPath + '/law/editLawAttachments.htm?showId=' + data.checklistId+'0000'+data.profileId);
            jQuery("#dialogDiv").dialog("open");
          }
      }
      jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="640" height="480" marginWidth="0" marginHeight="0" frameBorder="0" src="about:blank" />');
      
      jQuery("#dialogDiv").dialog({
        title: "Edit Checklist",
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
          '<a target="_self" ss-action="link" href="#">Link Docs</a> | ',
          '<a target="_self" ss-action="upload" href="#">Upload Docs</a> | ', 
          '<a target="_self" ss-action="editDoc" href="#">Edit Docs</a> ',
         '</div>' 
      ].join("");
      
      function profileChecklistActionHandler(){
        var actionBarDiv = jQuery(this).closest(".profileChecklistToolbar");
        var data = {
          profileId: actionBarDiv.attr('ss-pid'),
          profileVersion: actionBarDiv.attr('ss-pversion'),
          checklistId: actionBarDiv.attr('ss-cid'),
          checklistVersion: actionBarDiv.attr('ss-cversion'),
          profileChecklistId: actionBarDiv.attr('ss-pcid')
        }
        scansol.checklistData = data;
        scansol.actionKey=jQuery(this).attr('ss-action');
        var action = actions[scansol.actionKey];
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


