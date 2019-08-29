<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>

<html>
<head>

<link rel="shortcut icon" href="<c:url value="/images/imagesj/favicon.ico" />">

<style type="text/css">

.ss-report-group-toggle {
	width: 10px;
	height: 10px;
	margin-right: 5px;
	cursor: pointer;
}

tr.ss-hide {
  display: none;
}
tr.ss-hide td {
  display: none;
}

</style>

<script type="text/javascript" src="<c:url value="/jquery/jquery-1.7.min.js" />"></script>
<script type="text/javascript">
	var $jq = jQuery.noConflict();
	var imageDir = '<c:url value="/images" />';
	var groupManager = {
	        plusGif : imageDir + "/plus.gif",
			minusGif : imageDir + "/minus.gif",
			custom : {RiskManageTargetReport:{
				customAddToggleImage: function(toggleHtml){
                    jQuery("[ss-group-level='1'] + [ss-group-level='2']").prev().find("td:first-child > div").prepend(toggleHtml);
				},
				addToggleEvents: function(globalToggleEvents){
					globalToggleEvents("[ss-group-level='1']", ["[ss-group-level='2']","[ss-group-level='3']"]);
				}
			}},
			manageGroups: function(reportName){
				var toggleImage=groupManager.plusGif;
                jQuery("[ss-group-level='2']").addClass("ss-hide");
                jQuery("[ss-group-level='3']").addClass("ss-hide");
                jQuery("[ss-group-level='4']").addClass("ss-hide");
                jQuery("[ss-group-level='2']").children().addClass("ss-hide");
                jQuery("[ss-group-level='3']").children().addClass("ss-hide");
                jQuery("[ss-group-level='4']").children().addClass("ss-hide"); 
                
                var toggleHtml = '<img class="ss-report-group-toggle" src="' + toggleImage + '" width="10" height="10"/>';
                if(groupManager.custom[reportName]){
                	groupManager.custom[reportName].customAddToggleImage(toggleHtml);
                }else{
                    jQuery("[ss-group-level='1'] + [ss-group-level='2']").prev().find("td:first-child > div").prepend(toggleHtml);
                    jQuery("[ss-group-level='2'] + [ss-group-level='3']").prev().find("td:first-child > div").prepend(toggleHtml);
                    jQuery("[ss-group-level='3'] + [ss-group-level='4']").prev().find("td:first-child > div").prepend(toggleHtml);
                }
			}
	}
	
	$jq(document).ready(function() {
		var reportName = getUrlVars()['name'];
		groupManager.manageGroups(reportName);
	    
	    function addToggleEvents(selector, secondarySelectorArray) {
	      jQuery(selector + " .ss-report-group-toggle").click(function() {
	        var img = $jq(this);
	        var tr = img.closest("tr")
	        if(tr.next().is(":visible")) {
		        img.attr("src", groupManager.plusGif);
	        	jQuery(secondarySelectorArray).each(function(index,item){
		          tr.nextUntil(selector, item).addClass("ss-hide");
		          tr.nextUntil(selector, item).children().addClass("ss-hide");
		          tr.nextUntil(selector, item).children().children().addClass("ss-hide");
		          tr.nextUntil(selector, item).find(".ss-report-group-toggle").attr("src", groupManager.plusGif);
	        	});
	        } else {
	          img.attr("src", groupManager.minusGif);
	          jQuery(secondarySelectorArray).each(function(index,item){
		          tr.nextUntil(selector, item).removeClass("ss-hide");
		          tr.nextUntil(selector, item).children().removeClass("ss-hide");
	        	  
	          })
	        }
	      });
	    } 
	    if(groupManager.custom[reportName]){
			groupManager.custom[reportName].addToggleEvents(addToggleEvents);
		} else {
	    	addToggleEvents("[ss-group-level='1']", ["[ss-group-level='2']"]);
	    	addToggleEvents("[ss-group-level='2']", ["[ss-group-level='3']"]);
	    	addToggleEvents("[ss-group-level='3']", ["[ss-group-level='4']"]);
		}
	  });
	function getUrlVars()
	{
	    var vars = [], hash;
	    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++)
	    {
	        hash = hashes[i].split('=');
	        vars.push(hash[0]);
	        vars[hash[0]] = hash[1];
	    }
	    return vars;
	}  

</script>

<decorator:head />
</head>

<body>

	<decorator:body />

</body>
</html>