<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="headInclude.jsp" />

<title></title>

<style type="text/css">
.checkLeftSpace{
/* padding-left:31px;  */
overflow: hidden;
}
p{
overflow: hidden;
word-wrap: break-word;
}
.noLink{    
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;    
    color: #666666;
    vertical-align: top;
    cursor:default;
}
.version-title-id {
  font-size: 14px;
  font-weight: bold;
  text-align: left;
  padding: 0px;
  border-bottom: solid #d8e0f0 2px;  
  position: relative;
  margin-top: 20px;
  right: 0;
  font-family: arial,sans-serif;
}

.version-publication-date {
  font-size: 12px;
  font-weight: bold;
  font-family: arial,sans-serif;
  padding: 5px 0;
}

.version-subtitle {
  font-family: arial,sans-serif;
  font-size: 12px;
  color: gray;
  padding-bottom: 5px;
}

.version-subtitle-label {
	font-weight: bold;
}

.profile-title {
  font-size: 16px;
  color: #666699;
  font-weight: bold;
  text-align: center;
  margin-bottom: 10px;
}

.profile-title-version {
  font-size: 12px;
  text-align: center;
}

.change-item-title {
  background-color: #d8e0f0;
  font-weight: bold;
  font-size: 12px;
  line-height: 2em;
  border-top: 5px;
  margin-bottom: 2px;
}

.version-toggle, .version-toggleall {
  position: absolute;
  right: 15px;
  top: 1px;
}
.version-toggle a, .version-toggleall a {
  font-size: 10px;
  font-weight: normal;
}
.links {
  margin-top: 5px;
}
.panel-default > .panel-heading .badge {
    color: #f5f5f5;
    background-color: #00b1ac!important;
}
</style>


<style type="text/css">
  .checklist-legislation table { width: 100% }
</style>


<c:set var="isContentGeneratorGeneration" value="${param['cgen'] == 'true'}" />
<c:if test="${isContentGenerator && !isContentGeneratorGeneration}">
<script type="text/javascript">
  jQuery(document).ready(function() {
	
	var changeCommentBeingEdited;
	
	jQuery(document.body).append('<div id="alert-dialog"></div>');
	

	jQuery(document.body).append('' 
      + '<div id="custom-change-comment-dialog" title="Edit Custom Change Comment">'
      + '  <form id="custom-change-comment-form">'
      + '    <input type="hidden" name="profileId" value="${profile.id}">'
      + '    <input type="hidden" name="id">'
      + '    <input type="hidden" name="version">'
      + '    <input type="hidden" name="type">'
      + '    <textarea name="comment" rows="7" cols="90" class="text ui-widget-content ui-corner-all"> </textarea>'
      + '  </form>'
      + '</div>')

	
	jQuery("#alert-dialog").dialog({
      title: "Error",
	  autoOpen: false,
      resizable: true,
      height:400,
      width:800,
	  modal: true,
	  buttons: {
		Close: function() {
		  jQuery(this).dialog( "close" );
		}
	  }
	});
	  
	jQuery("#custom-change-comment-dialog").dialog({
		autoOpen: false,
		height: 250,
		width: 600,
		modal: true,
		buttons: {
		  Save: function() {
		    jQuery.ajax({
		      type: 'POST',
			  url: contextPath + "/law/customChangeCommentSave",
			  data: jQuery("#custom-change-comment-form").serialize(),
			  success: function(){
				changeCommentBeingEdited.html(jQuery("#custom-change-comment-form").find("[name=comment]").val());
				jQuery("#custom-change-comment-dialog").dialog("close");
			  },
			  error: function(jqXHR, textStatus, errorThrown) {
			    jQuery("#alert-dialog").html(jqXHR.responseText);
				jQuery("#alert-dialog").dialog("open");
			  }
			});
		  },
		  Cancel: function() {
			jQuery(this).dialog("close");
		  }
		}
	});

	jQuery("a.custom-comment").click(function() {
      var a = jQuery(this);
	  var form = jQuery("#custom-change-comment-form");
	  form.find("[name=id]").val(a.attr("ss-id"));
	  form.find("[name=version]").val(a.attr("ss-ver"));
	  form.find("[name=type]").val(a.attr("ss-type"));
	  changeCommentBeingEdited = a.closest("tr").find(".custom-change-comment");
	  form.find("[name=comment]").val(jQuery.trim(changeCommentBeingEdited.html()));
	  jQuery("#custom-change-comment-dialog").dialog("open");
	  return false;
	});

  });
  
</script>
</c:if>
<script type="text/javascript">
  jQuery(document).ready(function() { 
  jQuery('#close').hide();
  jQuery("#open").click(function() {
	  jQuery('.panel-collapse:not(".in")').collapse('show');	  
	  jQuery('#open').hide(); 
	  jQuery('#close').show();
	});  
  jQuery("#close").click(function() {
	  jQuery('.panel-collapse.in').collapse('hide');
	  jQuery('#close').hide();
	  jQuery('#open').show();
	  
	}); 
	 
    function collapseVersions() {
      var versionExpand = "Show Detail";
      var versionCollapse = "Hide Detail";
      var versionBodies = jQuery('div.version-body');
      if(versionBodies.length < 1) {
    	  return;
      }
      versionBodies.hide();

      jQuery("div.law").append('<div class="version-toggleall"><a href="#" ss-action="+">Show All</a> | <a href="#" ss-action="-">Hide All</a></div>');
      jQuery("div.version-toggleall a").click(function() {
        var expand = jQuery(this).attr("ss-action") === "+";
        jQuery('div.version-body').toggle(expand);
        var toggleLinks = jQuery('.version-toggle a');
        toggleLinks.html(expand ? versionCollapse : versionExpand);
        return false;
      });


      jQuery("div.version-title-id").append('<div class="version-toggle"><a href="#" >' + versionExpand + '</a></div>');
      jQuery(".version-toggle a").click(function() {
        var expand = jQuery(this).html().indexOf(versionExpand) >= 0;
        var link = jQuery(this);
        link.html(expand ? versionCollapse : versionExpand);
        link.closest("div.version-title").next().toggle(expand);
        return false;
      });
    }
  
    collapseVersions();
  });
  
</script>
</head>
<body>
   <law:profileVersionCheck profile="${profile}" />
   <div class="row">
      <div class="col-sm-12 col-md-12 col-lg-12">
         <div class="block-flat">
            <div align="right">		
               <button data-placement="top" data-trigger="hover" data-toggle="tooltip" id="open" data-original-title=<fmt:message key='btnShowAll'/> type="button" class="g-btn g-btn--primary btn-flat">
               <i class="fa fa-folder-open"></i>
               </button>
               <button data-placement="top" data-toggle="tooltip" id="close" data-original-title=<fmt:message key='btnHideAll'/> type="button" class="g-btn g-btn--primary btn-flat">
               <i class="fa fa-folder"></i>
               </button>					
            </div>
            <div class="header">
               <div class="content">
                  <h3 style="font-size: 150%;">
                     <fmt:message key="changeRecordTitle" ><fmt:param value="${titleDescription}" /></fmt:message>
                  </h3>
               </div>
               <div class="content">
                  <h3>
                     <fmt:message key='forProfile'/>
                     <c:out value="${profile.name}" />
                  </h3>
               </div>
               <div class="content">
                  <h4>
                     <fmt:message key='latestContentVersionIs'/> ${profile.latestContentVersion} <fmt:message key='publishedOn'/> 
                     <fmt:formatDate value="${changeRecord.currentPublicationDate}" pattern="dd MMMM yyyy"/>
                  </h4>
               </div>
            </div>
            <hr>
            <c:forEach items="${legislationRevisions}" var="entry"	varStatus="loopStatus">
               <c:set var="revisionId" value="${entry.key}" />
               <c:set var="contentVersion" value="${contentVersions[revisionId]}" />
               <c:set var="profileChange" value="${profileRevisions[revisionId]}" />
               <c:set var="categoriesToLegislations"
                  value="${legislationRevisions[revisionId]}" />
               <c:set var="checklists" value="${checklistRevisions[revisionId]}" />
               <div class="panel-group accordion accordion-semi" id="accordion
               <c:out value="${revisionId}" />
               ">
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse"
                           data-parent="#accordion3" href="#${revisionId}">
                           <i class="fa fa-angle-right"></i> 
                           <span  class="badge">
                              <fmt:message key='versionIs'/>
                              <c:out value="${revisionId}" />
                           </span>
                           <span style="float:right;">
                              <fmt:formatDate value="${contentVersion.publicationDate}" pattern="dd MMMM yyyy" />
                           </span>
                        </a>
                     </h4>
                  </div>
                  <div id="${revisionId}" class="panel-collapse collapse out"	>
                     <div class="panel-body" style="padding-left:3%;padding-right:2%">
                        <div align="right">
                           <c:if test="${contentVersion.comment != null}">
                              <span class="version-subtitle-label">Comment: </span>
                              <c:out value="${contentVersion.comment}" escapeXml="false" />
                              <br />
                           </c:if>
                           <c:if test="${contentVersion.importedBy != null}">
                              <span class="version-subtitle-label"><fmt:message key='contentImportedBy'/></span>
                              <c:out value="${contentVersion.importedBy.userName}"
                                 escapeXml="true" />
                              <fmt:message key='at'/> 
                              <fmt:formatDate
                                 value="${contentVersion.importedDatetime}"
                                 pattern="dd MMMM yyyy" />
                              <br />
                           </c:if>
                           <c:if test="${profileChange != null}">
                              <span class="version-subtitle-label">Updated and
                              Verified By: </span> ${profileChange.changedBy.userName} on 
                              <fmt:formatDate
                                 value="${profileChange.changedDate}" pattern="dd MMMM yyyy" />
                              <br />
                           </c:if>
                        </div>
                        <div class="content">
                           <div class="header">
                              <h3><fmt:message key='newOrChangedRegulations'/></h3>
                           </div>
                        </div>
                        <c:forEach items="${categoriesToLegislations}" var="categoriesToLegislationEntry" >
                           <c:set var="category" value="${categoriesToLegislationEntry.key}" />
                           <c:set var="legislations" value="${categoriesToLegislationEntry.value}" />
                           <div class="content" >
                              <h4 style="color: #DF4B33;">
                                 <c:out value="${category.name}" />
                              </h4>
                           </div>
                           <div class="content" >
                              <div>
                                 <c:forEach items="${legislations}" var="legislation" >
                                    <c:choose>
                                       <c:when test="${isContentGenerator && !isContentGeneratorGeneration}">
                                          <div class=row>
                                             <div class="col-sm-1">
                                                <img src="
                                                <law:url value="/legal/images/${legislation.economicRegion.id}.gif" />
                                                ">
                                             </div>
                                             <div class="col-sm-6">
                                                <a href="
                                                <law:legislationChangeRecordUrl legislation="${legislation}" registerType="${profile.registerType}" contentVersion="${revisionId}" />
                                                &lversion=${legislation.firstVersion == legislation.version ? 'New' : 'Amd'}">
                                                <c:out value="${legislation.name}" escapeXml="false" />
                                                </a>
                                             </div>
                                             <div class="col-sm-5">
                                                <c:choose>
                                                   <c:when test="${legislation.firstVersion == legislation.version}">New</c:when>
                                                   <c:otherwise>Amd</c:otherwise>
                                                </c:choose>
                                             </div>
                                          </div>
                                          <div class=row>
                                             <div class="col-sm-1">Default Change Comment</div>
                                             <div class="col-sm-6">
                                                <c:choose>
                                                   <c:when test="${empty legislation.changeComment}">No Comment</c:when>
                                                   <c:otherwise>
                                                      <c:out value="${legislation.changeComment}" escapeXml="false" />
                                                   </c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="col-sm-5">&nbsp;</div>
                                          </div>
                                          <div class=row>
                                             <div class="col-sm-1">Custom Change Comment</div>
                                             <div class="col-sm-6">
                                                <c:out value="${legislation.profileChangeComment}" escapeXml="false" />
                                             </div>
                                             <div class="col-sm-5">
                                                <a class="custom-comment" ss-type="l" ss-id="${legislation.id}" ss-ver="${legislation.version}" href="">Edit</a>
                                             </div>
                                          </div>
                                       </c:when>
                                       <c:otherwise>
                                          <!-- <div class=row> -->
                                             <!--  <div class=content> -->
                                             <div class="row">
                                                <div class="col-md-11 noLink checkLeftSpace "style="padding-top:2%">
                                                   <strong style="font-size: 120%;">
                                                      <c:out value="${legislation.name}" escapeXml="false" />
                                                   </strong>
                                                   <a name="leg:${legislation.id}:${legislation.version}"></a>&nbsp;
                                                   <img src="
                                                   <law:url value="/legal/images/${legislation.economicRegion.id}.gif" />
                                                   ">&nbsp;
                                                   <c:choose>
                                                      <c:when test="${legislation.firstVersion == legislation.version}"><fmt:message key='new'/></c:when>
                                                      <c:otherwise><fmt:message key='amd'/></c:otherwise>
                                                   </c:choose>
                                                </div>
                                                <div class="links checkLeftSpace col-sm-11" style="padding-top:1%">
                                                   <a title="Synopsis &amp; Secondary Legislation" style="font-size: 13px;" href="<law:legislationChangeRecordUrl legislation="${legislation}" registerType="${profile.registerType}" contentVersion="${revisionId}" />">
                                                   <fmt:message key='viewSynopsis'/> <i class="fa fa-external-link"></i> </a>
                                                   <a title="Checklists" style="font-size: 13px;" href="<law:legislationRelevanceChangeRecordUrl legislation="${legislation}" registerType="${profile.registerType}" contentVersion="${revisionId}" />&lversion=${legislation.firstVersion == legislation.version ? 'New':'Amd'}">                                                   
                                                   <fmt:message key='updateCompliance'/> <i class="fa fa-external-link"></i></a>
                                                </div>
                                                <div class="checkLeftSpace col-sm-11 col-xs-12" style="padding-top:1%;word-wrap: break-word;">
                                                   <c:choose>
                                                      <c:when test="${not empty legislation.profileChangeComment}">
                                                         <c:out value="${legislation.profileChangeComment}" escapeXml="false" />
                                                      </c:when>
                                                      <c:when test="${not empty legislation.changeComment}">
                                                         <c:out value="${legislation.changeComment}" escapeXml="false" />
                                                      </c:when>
                                                      <c:otherwise>No Comment <br></c:otherwise>
                                                   </c:choose>
                                                </div>
                                             <!-- </div> -->
                                             <!--  </div> -->
                                          </div>
                                       </c:otherwise>
                                    </c:choose>
                                 </c:forEach>
                              </div>
                              <!-- 2 part -->      
                           </div>
                        </c:forEach>
                        <div class="content" style="padding-bottom: 2%;">
                           <div class="header">
                              <h3> <fmt:message key="newOrChangedChkItems"/></h3>
                           </div>
                        </div>
                        <div class="content" >
                           <div>
                              <c:forEach items="${checklists}" var="checklist" >
                                 <c:choose>
                                    <c:when test="${isContentGenerator && !isContentGeneratorGeneration}">
                                       <div class=row>
                                          <div class="row">
                                             <div class="col-md-11 noLink checkLeftSpace">
                                                <a style="font-size: 100%;" href="
                                                <law:checklistChangeRecordUrl checklist="${checklist}" registerType="${profile.registerType}" contentVersion="${revisionId}" />
                                                ">
                                                <c:out value="${checklist.name}" escapeXml="false" />
                                                &nbsp;<i class="fa fa-external-link"></i></a>
                                                <c:choose>
                                                   <c:when test="${checklist.firstVersion == checklist.version}">New</c:when>
                                                   <c:otherwise>Amd</c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%">
                                                <c:choose>
                                                   <c:when test="${not empty checklist.profileChangeComment}">
                                                      <c:out value="${checklist.profileChangeComment}" escapeXml="false" />
                                                   </c:when>
                                                   <c:when test="${not empty checklist.changeComment}">
                                                      <c:out value="${checklist.changeComment}" escapeXml="false" />
                                                   </c:when>
                                                   <c:otherwise>No Comment <br></c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%">
                                                Default Change Comment
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%">
                                                <c:choose>
                                                   <c:when test="${empty checklist.changeComment}">No Comment</c:when>
                                                   <c:otherwise>
                                                      <c:out value="${checklist.changeComment}" escapeXml="false" />
                                                   </c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%">
                                                Custom Change Comment
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%">
                                                <c:out value="${checklist.profileChangeComment}" escapeXml="false" />
                                                &nbsp;<a class="custom-comment" ss-type="c" ss-id="${checklist.id}"  ss-ver="${checklist.version}" href="#">Edit</a>
                                             </div>
                                          </div>
                                       </div>
                                    </c:when>
                                    <c:otherwise>
                                       
                                          <div class="row">
                                             <div class="col-md-11 noLink checkLeftSpace">
                                                <a style="font-size: 100%;" href="
                                                <law:checklistChangeRecordUrl checklist="${checklist}" registerType="${profile.registerType}" contentVersion="${revisionId}" />
                                                ">
                                                <c:out value="${checklist.name}" escapeXml="false" />
                                                &nbsp;<i class="fa fa-external-link"></i></a>
                                                <c:choose>
                                                   <c:when test="${checklist.firstVersion == checklist.version}"><fmt:message key='new'/></c:when>
                                                   <c:otherwise><fmt:message key='amd'/></c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="checkLeftSpace col-sm-11" style="padding-top:1%;padding-bottom:2%">
                                                <c:choose>
                                                   <c:when test="${not empty checklist.profileChangeComment}">
                                                      <c:out value="${checklist.profileChangeComment}" escapeXml="false" />
                                                   </c:when>
                                                   <c:when test="${not empty checklist.changeComment}">
                                                      <c:out value="${checklist.changeComment}" escapeXml="false" />
                                                   </c:when>
                                                   <c:otherwise>No Comment <br></c:otherwise>
                                                </c:choose>
                                             </div>
                                          </div>                                      
                                    </c:otherwise>
                                 </c:choose>
                              </c:forEach>
                           </div>
                        </div>
                     </div>
                     <!-- Panel Body -->
                  </div>
               </div>
         </div>
         </c:forEach>
      </div>
   </div>
   </div>
   <!-- <div class="law"> -->
</body>
</html>
