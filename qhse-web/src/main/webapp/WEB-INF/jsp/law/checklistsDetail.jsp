<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<%@page import="com.scannellsolutions.modules.law.web.ProfileChecklistHelper"%>


<html>
<head>
<jsp:include page="headInclude.jsp" />
<style type="text/css">
.block .header, .widget-block .header, .block-flat .headerCheck {
    padding: 10px;
    background-color: #FEFEFE;
    border-bottom: 0px solid #dadada; 
}
.block .header, .widget-block .header, .block-flat .headerCheck {
 border-bottom: 0px solid #13ab94;
}
</style>
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<c:set var="importProfileJS" value="${riskRelatedChecklists}" />
<c:if test="${not importProfileJS}">
	<script type="text/javascript" src="<law:url value="/js/profileChecklist.js" modifiedTime="true" />"></script>
</c:if>

<c:set var="showChecklistLinks" value="${param['hideLinks'] != 'true'}" />
<link class="theme-css" rel="stylesheet" href="<c:url value="/groove/css/groove-qpulse.min.css" />" />
<script type="text/javascript">
jQuery(document).ready(function(){
	
   if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	   jQuery( ".ed" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".not" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".at" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".ldoc" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".up" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".edoc" ).get(0).lastChild.nodeValue = "";
	   jQuery( ".vh" ).get(0).lastChild.nodeValue = "";			
	}
	jQuery('#legistatioTab').click(function () {
		jQuery('.changes-'+ch).hide();
        jQuery('.relatedCheck-'+ch).hide();
        jQuery('.legislation-'+ch).show();
	});
	
	jQuery('#changeTab').click(function () {
		jQuery('.changes-'+ch).show();
    	jQuery('.legislation-'+ch).hide();
    	jQuery('.relatedCheck-'+ch).hide();
	});
	
	jQuery('#relatedTab').click(function () {
		jQuery('.legislation-'+ch).hide();
        jQuery('.relatedCheck-'+ch).show();
        jQuery('.changes-'+ch).hide();
	});
	
	//jQuery('.htmlEscapeFalse1').html(jQuery('.htmlEscapeFalse1').text());
	//jQuery('.htmlEscapeFalse2').html(jQuery('.htmlEscapeFalse1').text());
	
	var pr = jQuery('.dataDetails').attr("profile") ;// activated tab	
	var ch = jQuery('.dataDetails').attr("checklist") ;	
	var url = contextPath+"/law/showChecklistDetail.htmf?checklistId="+ch+"&profileId="+pr;
 	var checklistDiv = jQuery('.lawLegislation');
 	checklistDiv.each(function (){
 		jQuery(this).load(url, function() {
 	    	/*  if (jQuery('a[href="#tab35-'+ch+'"]').is(':hover')) {
// 	 	        jQuery('.legislation-'+ch).show();
// 	 	        jQuery('.changes-'+ch).hide();
// 	 	        jQuery('.relatedCheck-'+ch).hide();
 		     } */
 	     });
 	 })
     
    var changesDiv = jQuery('.changes');	
 	changesDiv.each(function() {
 		jQuery(this).load(url, function() {
 	    	/*  if (jQuery('a[href="#tab36-'+ch+'"]').is(':hover')) {
// 	 	        	jQuery('.changes-'+ch).show();
// 	 	        	jQuery('.legislation-'+ch).hide();
// 	 	        	jQuery('.relatedCheck-'+ch).hide();
 		      } */
 	     });
 	})
     
    var relatedDiv = jQuery('.related');
 	relatedDiv.each(function() {
 		jQuery(this).load(url, function() {
// 	     	 jQuery('.changes-'+ch).hide();
// 	 	        jQuery('.legislation-'+ch).hide();
// 	 	        jQuery('.relatedCheck-'+ch).hide();
// 	 	        if (jQuery('a[href="#tab37-'+ch+'"]').is(':hover')) {
// 	 	        	jQuery('.relatedCheck-'+ch).show();
// 	 	        }
 	     });
 	})
     
     
     checkRelevantOrNot();
	 
     if(getUrlParameter('pageRisk') == "true" || getUrlParameter('pageRisk') == true) {
    	 jQuery('#riskMsgError').show();
     }
     if(getURLParam('comeFromRisk') == 'true'){
  	   	 var button= jQuery('<input/>').attr({ type: 'button', name:'btPreviewPage', value:'Return'});
    	 button.addClass('g-btn g-btn--primary');
    	 button.click(function (){window.history.back();});
    	 jQuery('.block-flat').prepend(button);
    	 var hiddenProfile= jQuery('<input type="hidden" id="profileSelect" name ="profileSelect" value="'+jQuery('.dataDetails').attr("profile")+'"/>');
    	 jQuery('.block-flat').prepend(hiddenProfile);
    	 jQuery(".tab-pane :a").attr("disabled", true);

     }
});
function checkRelevantOrNot(){
	if('${viewType}' == 'relevant') {
   	 	jQuery('#relev').hide();
   		jQuery('.bt-relev').hide();
    } else {
   	 	jQuery('#notRe').hide();
   	 	jQuery('.bt-notRe').hide();
    }
}
function checkDivIsLoaded(divId){
	if(jQuery("#"+divId).is(':visible')){
		checkRelevantOrNot();
	} else {
		setTimeout(function (){checkDivIsLoaded(divId);}, 500);
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

function openLinkFile(link) {
	
	window.open("<c:url value='/doclink/openLinkFile.htm?link="+link+"'/>");
	
	
}

</script>


<c:if test="${showChecklistLinks}">
	<script type="text/javascript">
	
	
jQuery(window).ready(function()  {
	var viewAll = true;
    jQuery('#checklistMenuSelect').change(function(e) {
      var checklistId = jQuery(this).val();     
      if(viewAll) { 
    	  var divID = '#accordion' + checklistId;    	  
    	  jQuery('html, body').animate({
    	        scrollTop: jQuery(divID).position().top //offset() moves to t
    	    }, 2000);

    	  //location.hash= '#' + checklistId;
      } else {
    	  <c:choose>
     	  <c:when test="${param['cgen'] == 'true'}" >
            location.href = "chk"+ checklistId + "-${profile.registerType.id}.html";
    	  </c:when> 
    	  <c:otherwise>
            location.href = '<c:url value="/law/checklists.htm"><c:param name="profileId" value="${profile.id}" /><c:param name="legRegister" value="${profile.registerType.id}" /></c:url>&chklistId=' + checklistId;
    	  </c:otherwise>
    	</c:choose>
    	  
    	
      }
    });
	  // Handler for .load() called.
	});

    function viewTask(id){	  
	  jQuery("#dialogFrame").attr("src", contextPath + '/law/taskView.htm?id='+id+'&viewType=${viewType}');
	  jQuery("#dialogDiv").dialog('option', 'title', 'View Task');
	  jQuery("#dialogDiv").dialog( "option", "width", 850 );
      jQuery("#dialogDiv").dialog("open");
  }
</script>
</c:if>

<title></title>


</head>
<body>
	<c:set var="menuChecklists" value="${checklists}" />
	<div class="row">
		<div class="col-sm-12 col-md-12 col-lg-12">
			<div class="block-flat">			
			<div class="tab-container" align="left">
			<ul class="nav nav-tabs" id="myTab">
				<li class="active"><a href="#home" data-toggle="tab"><fmt:message key='tab.english'/></a></li>				
				<c:forEach items="${lang}" var="item">				           
				           <c:set var="language" value="${item.key}" />					           
					       <li>	<a href="#language-${language.id}" onclick="checkDivIsLoaded('language-${language.id}')" data-toggle="tab">${language.nativeName}</a></li>						 
			    </c:forEach>				
			</ul>	
			<div class="tab-content">
				<div class="tab-pane cont active" id="home">
								
				<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">					
					<div class="content"  align="left">
						<c:forEach items="${item.value}" var="checklist" varStatus="sm">
						
							<div align="right">
					       <c:if test="${param['cgen'] != 'true'}">
						   <div id="toolBar" class="profileChecklistToolbar" ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
							ss-pcid="<c:out value="${checklist.profileChecklistId}" />" ss-cversion="<c:out value="${checklist.version}" />" ss-loc="<c:out value="${profile.loc}" />" ss-pversion="<c:out value="${profile.version}" />"></div>
					        </c:if>
				          </div>
				          <div class="header headerCheck">
						  <div align="right"><span align="right" class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>	
						  <h3>
							 <c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if><c:out value="${checklist.name}" />  
						</h3>					           
					   </div>
							<div class="tab-container" style="padding-top: 20px;">
								<ul class="nav nav-tabs" id="<c:out value="${checklist.id}" />">
									<li class="active"><a href="#tab31-<c:out value="${checklist.id}" />" data-toggle="tab"> <fmt:message key='requirements'/> </a></li>
									<li><a class="dataDetails" checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab32-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="checklist.compliance" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab33-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="docs" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab34-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="task" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="legistatioTab" profile="<c:out value="${profile.id}" />" href="#tab35-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="checklist.legislation"/></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="changeTab" profile="<c:out value="${profile.id}" />" href="#tab36-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="checklist.changes" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="relatedTab" profile="<c:out value="${profile.id}" />" href="#tab37-<c:out value="${checklist.id}" />" data-toggle="tab"><fmt:message key="checklist.Related" /></a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active cont" id="tab31-<c:out value="${checklist.id}" />">
										<div class="checklist-description">
										<div class="header">
											<h3><fmt:message key='requirements2'/></h3>
										</div>
										<div class="content">										
											<scannell:text value="${checklist.description}" htmlEscape="false" newlineEscape="true" />
										</div>
										</div>

									</div>
									<div class="tab-pane cont" id="tab32-<c:out value="${checklist.id}" />">
										<div class="header">
											<h3><fmt:message key='thingsToConsider'/></h3>
										</div>
										<div class="content">
											<div id="toConsider${checklist.id}"><scannell:text value="${checklist.thingsToConsider}" htmlEscape="false" newlineEscape="true" /></div>
										</div>
										<c:if test="${profile != null}">
											<div class="header">
												<h3><fmt:message key='relevance'/></h3>
											</div>
											<div class="content" id="divChklRelevance">
												<law:checklistRelevance checklist="${checklist}" profile="${profile}" />
											</div>
										</c:if>

									</div>
									<div class="tab-pane" id="tab33-<c:out value="${checklist.id}" />">
										<law:checklistDoc checklist="${checklist}" profile="${profile}" />
									</div>
									<div class="tab-pane" id="tab34-<c:out value="${checklist.id}" />">
										<div class="header">
											<h3><fmt:message key='complianceTasks'/></h3>
										</div>
										<div class="content" id="divChklTask">
											<law:checkListTask checklist="${checklist}" profile="${profile}" />
										</div>
										
									</div>
									<div class="tab-pane" id="tab35-<c:out value="${checklist.id}" />">
										<div class="header">
											<h3><fmt:message key='legislation'/></h3>
										</div>
										<div id="lawLegislation-<c:out value="${checklist.id}" />" class="lawLegislation"></div>
									</div>
									<div class="tab-pane" id="tab36-<c:out value="${checklist.id}" />">
										<div class="header">
											<h3><fmt:message key='changes'/></h3>
										</div>
										<div class="content">
											<div id="changes-<c:out value="${checklist.id}" />" class="changes"></div>
										</div>
									</div>
									<div class="tab-pane" id="tab37-<c:out value="${checklist.id}" />">
										<div class="header">
											<h3><fmt:message key='relatedChecklist'/></h3>
										</div>
										<div class="content">
											<div id="related-<c:out value="${checklist.id}" />" class="related"></div>
										</div>
									</div>
								</div>
							</div>
							
						</c:forEach>
					</div>
				</c:forEach>
				<c:if test="${fn:length(checklistsByCategory) < 1}">
					<div id="riskMsgError" style="display:none;">
						<div style="text-align: center;" >
							<h2><strong><fmt:message key='profileIs'/> ${profile.name }</strong></h2>
							<h3><fmt:message key='noChecklistsAssociated'/></h3>
						</div>
						<hr style="border: 1px solid #0066CC">
						<div style="margin-top: 20px">
							<p><fmt:message key='pleaseNote'/></p>
							<p>Q-Pulse LAW © <a href="http://www.scannellsolutions.com"><font style="color: #0066CC;">Ideagen PLC</font></a></p>
						</div>
					</div>
				</c:if>
				</div>			
				
				<c:forEach items="${lang}" var="item">	  
					<c:set var="language" value="${item.key}" />		  
					 <div class="tab-pane cont" id="language-${language.id}">					 
					<c:forEach items="${checklistsByCategory}" var="item" varStatus="outer">					
					<div class="content"  align="left">
						<c:forEach items="${item.value}" var="checklist" varStatus="sm">
						
							<div align="right">
					        <c:if test="${param['cgen'] != 'true'}">
						    <div id="toolBar" class="profileChecklistToolbar" ss-cid="<c:out value="${checklist.id}" />" ss-pid="<c:out value="${profile.id}" />"
							ss-pcid="<c:out value="${checklist.profileChecklistId}" />" ss-cversion="<c:out value="${checklist.version}" />" ss-pversion="<c:out value="${profile.version}" />"></div>
					     </c:if>
				         </div>
				         <div class="headerCheck">
				         <div align="right"><span align="right" class="label label-default"><i class="fa fa-bookmark"></i> <fmt:message key="id" /> <c:out value="${checklist.id}" /></span></div>
						<h3>
							<c:if test="${viewType == \"notRelevant\" }"><i class="fa fa-chain-broken"></i> </c:if>
							 <c:forEach items="${checklist.alternateLanguageNames}" var="altName">
													
													<c:if test="${altName.key.id == language.id}"> <c:out value="${altName.value}" /></c:if>
													
							 </c:forEach>							
						</h3>						          
					    </div>
							<div class="tab-container" style="padding-top: 20px;">
								<ul class="nav nav-tabs" id="<c:out value="${checklist.id}" />-${language.id}">
									<li class="active"><a href="#tab31-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"> <fmt:message key="requirements" /> </a></li>
									<li><a class="dataDetails" checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab32-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="checklist.compliance" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab33-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="docs" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" profile="<c:out value="${profile.id}" />" href="#tab34-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="task" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="legistatioTab" profile="<c:out value="${profile.id}" />" href="#tab35-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="checklist.legislation"/></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="changeTab" profile="<c:out value="${profile.id}" />" href="#tab36-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="checklist.changes" /></a></li>
									<li><a checklist="<c:out value="${checklist.id}" />" id="relatedTab" profile="<c:out value="${profile.id}" />" href="#tab37-<c:out value="${checklist.id}" />-${language.id}" data-toggle="tab"><fmt:message key="checklist.Related" /></a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active cont" id="tab31-<c:out value="${checklist.id}" />-${language.id}">
										<div class="checklist-description">
											<div class="header">
												<h3><fmt:message key='requirements2'/></h3>
											</div>
										<div content>
											<scannell:text value="${checklist.description}" htmlEscape="false" newlineEscape="true" />
										</div>
									</div>

								</div>
									<div class="tab-pane cont" id="tab32-<c:out value="${checklist.id}" />-${language.id}">
										<div class="header">
											<h3><fmt:message key='thingsToConsider'/></h3>
										</div>
										<div class="content">
											<div id="toConsider${checklist.id}"><scannell:text value="${checklist.thingsToConsider}" htmlEscape="false" newlineEscape="true" /></div>
										</div>
										<c:if test="${profile != null}">
											<div class="header">
												<h3><fmt:message key='relevance'/></h3>
											</div>
											<div class="content" id="divChklRelevance">
												<law:checklistRelevance checklist="${checklist}" profile="${profile}" />
											</div>
										</c:if>

									</div>
									<div class="tab-pane" id="tab33-<c:out value="${checklist.id}" />-${language.id}">
										<law:checklistDoc checklist="${checklist}" profile="${profile}" />
									</div>
									<div class="tab-pane" id="tab34-<c:out value="${checklist.id}" />-${language.id}">
										<div class="header">
											<h3><fmt:message key='complianceTasks'/></h3>
										</div>
										<div class="content" id="divChklTask">
											<law:checkListTask checklist="${checklist}" profile="${profile}" />
										</div>
										
									</div>
									<div class="tab-pane" id="tab35-<c:out value="${checklist.id}" />-${language.id}">
										<div class="header">
											<h3><fmt:message key='legislation'/></h3>
										</div>
										<div id="lawLegislation-<c:out value="${checklist.id}" />" class="lawLegislation"></div>
									</div>
									<div class="tab-pane" id="tab36-<c:out value="${checklist.id}" />-${language.id}">
										<div class="header">
											<h3><fmt:message key='changes'/></h3>
										</div>
										<div class="content">
											<div id="changes-<c:out value="${checklist.id}" />" class="changes"></div>
										</div>
									</div>
									<div class="tab-pane" id="tab37-<c:out value="${checklist.id}" />-${language.id}">
										<div class="header">
											<h3><fmt:message key='relatedChecklist'/></h3>
										</div>
										<div class="content">
											<div id="related-<c:out value="${checklist.id}" />" class="related"></div>
										</div>
									</div>
								</div>
							</div>
							
						</c:forEach>
					</div>
				</c:forEach>
				<c:if test="${fn:length(checklistsByCategory) < 1}">
					<div id="riskMsgError" style="display:none;">
						<div style="text-align: center;" >
							<h2><strong><fmt:message key='profileIs'/> ${profile.name }</strong></h2>
							<h3><fmt:message key='noChecklistsAssociated'/></h3>
						</div>
						<hr style="border: 1px solid #0066CC">
						<div style="margin-top: 20px">
							<p><fmt:message key='pleaseNote'/></p>
							<p>Q-Pulse LAW © <a href="http://www.scannellsolutions.com"><font style="color: #0066CC;">Ideagen PLC</font></a></p>
						</div>
					</div>
				</c:if>
				
				</div>							
				</c:forEach>
				
				</div><!--Tabs  -->
				
			</div>
			<!-- block -->
		</div>
		<!-- col-sm-12 -->
	</div>
	<!--End of row  -->


	<a name="top"></a>


	<%-- <jsp:include page="footerInclude.jsp" /> --%>



</body>
</html>