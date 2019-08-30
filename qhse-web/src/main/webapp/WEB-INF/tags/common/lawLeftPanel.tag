<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>
<%@ attribute name="currentYear" required="false" type="java.lang.String" %>
<%@ attribute name="yearList" required="false" type="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>
<%-- <script type="text/javascript" src="<law:url value="/js/leftpanelLaw.js" modifiedTime="true" />"></script> --%>
<style>
.col-centered{
    float: none;
    margin: 0 auto;
}
.accordion.accordion-semi .panel-collapse .panel-body {
    padding: 15px 2px 4px 2px;
}
.form-group {
    margin: 0;
    padding: 0px 0;
    border-bottom: 0px dashed #efefef;
    min-height: 70px;
    height: 70px;
}
</style>
<script language="javascript" type="text/javascript">
		// The context path is needed in /js/site.js	
var  selectProfile;
selectProfile = void 0;

jQuery(document).ready(function() {
	if(!jQuery('#profileSelect').val()){
		 var profSize='<c:out value="${profileSize}"  />';
		 if(profSize < 1){
			jQuery("#closeBtn").show();
			jQuery("#closeBtnx").show();
		 }else{
			 jQuery("#closeBtn").hide();
				jQuery("#closeBtnx").hide();
		 }
		
		
	     jQuery("#second").click();
	    }
  var cook =1, leg, url,urlch;
  leg = '<c:out value="${legReg}"></c:out>';
  
  if (leg == 3) {	 
	  var legUrl=  getURLParam('legRegister');
	if(legUrl == 1 || legUrl == 2){					
		cook =legUrl;
	}else{
    cook = $.cookie('lawTabs');		
	}
	
    if (cook != null) {				    	
      jQuery('#lawTabs').select2('val', cook);
    }			    
  } 
  else {
    jQuery('#lawTabs').select2('val', leg);
  }
  
  jQuery('#legAccord').on('show.bs.collapse', function () {
	  var bod = jQuery('#resultsDivchk');	
	  $(bod).block({ 
	         message:  '<h2>Loading...</h2>', 
	         css: { width: '100%' } 
	         //css: { position: 'block' }
	     });
	  urlch = '<c:url value="/law/checklists.htmf?refine=false&viewAll=true&panel=true&legRegister="/>' + jQuery('#lawTabs').val();

		jQuery.ajax({
		  url: urlch,
		  type: 'post',
		  dataType: 'html',
		  success: function(returnData) {
		    jQuery('#resultsDivchk').html(returnData);
		  },
		  error: function(e) {			  
		    if(!jQuery('#profileSelect').val()){
		     jQuery("#second").click();
		    }
		  }
		});
  });
  
  jQuery('#checkAccord').on('show.bs.collapse', function () {
	  var bod = jQuery('#resultsDiv2');	
	  $(bod).block({ 
		     message:  '<h2>Loading...</h2>', 
	         css: { width: '100%' } 
	  });
	  url = '<c:url value="/law/legislations.htmf?legRegister="/>' + jQuery('#lawTabs').val();
	  jQuery.ajax({
	    url: url,
	    type: 'post',
	    dataType: 'html',
	    success: function(returnData) {
	      jQuery('#resultsDiv2').html(returnData);
	    },
	    error: function(e) {	    	
	    	if(!jQuery('#profileSelect').val()){
			     jQuery("#second").click();
			    }
	    }
	  });
  });
  
  selectProfile = function() {
    window.location = '<c:url value="/law/lawDashboard.htm"/>' + '?selectProfile=' + document.getElementById('profileSelect').value;
  };
  jQuery('#lawTabs').select2({
    width: '100%'
  });
  jQuery('#profileSelect').select2({
    width: '100%'
  });
  jQuery('#lawTabs').on('change', function() {
    var lwval, url;
    lwval = void 0;
    url = void 0;
    lwval = jQuery('#lawTabs').val();
    $.cookie('lawTabs', lwval, {
      expires: 7,
      path: '/'
    });
    url = '<c:url value="/law/lawDashboard.htm"/>';
    window.location.href = url;
  });
  
  
  
  
  jQuery('.check').change(function() {
	  if (jQuery(this).is(':checked')) {
	    jQuery('#profileSelect').select2('val', jQuery(this).val());
	    selectProfile();
	    jQuery('#myModal').modal('toggle');
	  }
	});

});
function getURLParam(paramName) {
	  var href = window.location.href;
	  paramName = paramName + "=";
	  if (href.indexOf("?") >= 0 &&  href.indexOf(paramName) >= 0){
	    var str = href.substr(href.indexOf(paramName) + paramName.length);
	    if (str.indexOf("&") >= 0) {
	    	str = str.substr(0, str.indexOf("&"));
	    }
	    return str;
	  }
	  return null;
	}
	


	</script> 

   <div class="page-aside app filters">
      <div id="mainContent">
        <div class="content">
         <button type="button" style="display:none;" id="second" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal"> </button>
          <button class="navbar-toggle" data-target=".app-nav" data-toggle="collapse" type="button">
            <span class="fa fa-chevron-down"></span>
          </button>
          <h2 class="page-title-g"><fmt:message key="complianceRegister"/></h2> 
         <!--  <label class="control-label"></label> -->
        </div>
        <div class="app-nav collapse">
          <div class="content">
          <fmt:message key="selectAProfile" var="selectProf"/>
          <div class="form-group" title="${selectProf}">
              <label class="control-label" ><fmt:message key="profile"/></label>
              <select id="profileSelect" class="select2" onchange="selectProfile();" >
						<c:if test="${profileSelected == false}">
							<option value="" selected="selected" title=""><fmt:message key="choose" /></option>
						</c:if>
						<c:forEach items="${viewableProfiles}" var="item">
							<option value="<c:out value="${item.id}" />" <c:if test="${item.selected}">selected="selected"</c:if> />
								<c:out value="${item.name}" />
							</option>
						</c:forEach>
					</select>
            </div>
            <fmt:message key="switchBetween" var="switchB"/>
            <div class="form-group" title = "${switchB}">
              <label class="control-label"><fmt:message key="legislationRegister" /></label>
              <select id="lawTabs" class="select2">               
	              <c:choose>           
		              <c:when test="${legReg == 1}" >
		                   <option value="1" selected="selected"><fmt:message key="Environment"/></option>
		              </c:when>
		               <c:when test="${legReg == 2}" >
		                   <option value="2" selected="selected"><fmt:message key="hSOption"/></option>
		               </c:when>
		               <c:when test="${legReg == 3}" >
			               <option value="1" ><fmt:message key="Environment"/></option>
			               <option value="2" ><fmt:message key="hSOption"/></option>
		               </c:when>
		               <c:otherwise>
		               		<option value="" selected="selected" title=""><fmt:message key="choose" /></option>
		               </c:otherwise>
	               </c:choose>
              </select>
            </div>            
            <label class="control-label" style="padding-top:5px;padding-bottom:5px;"><fmt:message key="selectACategory"/></label>
            
<div class="panel-group accordion accordion-semi" id="accordionLeg">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title">

<fmt:message key="expandLinks" var="expandL"/>
<a class="collapsed" data-toggle="collapse" data-parent="#accordion3" href="#checkAccord" 
aria-expanded="true" style="border: 1px solid #CCCCCC;" title="${expandL}"
> <i class="fa fa-angle-right"></i> 
<!-- <span class="badge">Version :44</span> -->
<span><fmt:message key="legislation"/></span>												  
</a>
</h4>
</div>
<div id="checkAccord" class="panel-collapse collapse" aria-expanded="true">	
<div class="panel-body"> 
<div id="resultsDiv2">        
</div>
</div> <!-- Panel Body -->
</div> 
</div>				
</div>



<div class="panel-group accordion accordion-semi" id="accordionChk">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title">


<fmt:message key="expandLinks" var="expandL"/>
<a class="collapsed" data-toggle="collapse" data-parent="#accordion3" href="#legAccord" title="${expandL}"
aria-expanded="true" style="border: 1px solid #CCCCCC;"
> <i class="fa fa-angle-right"></i>
<span><fmt:message key="complianceChecklist"/></span>												  
</a>
</h4>
</div>
<div id="legAccord" class="panel-collapse collapse" aria-expanded="true">	
<div class="panel-body"> 	
<div id="resultsDivchk"> 

</div>
</div> <!-- Panel Body -->
</div> 
</div>				
</div>
</div>
</div>
</div>
</div>
		<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-lg">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" id="closeBtnx"  class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"><fmt:message key="selectProfile"/></h4>
      </div>
      <div class="modal-body">
      <div class="col-lg-12"><h5><fmt:message key="selectProfileMsg"/></h5></div>
      <div class="row">
       <div class="col-lg-3 col-centered">       
      <c:forEach items="${viewableProfiles}" var="item">
        <div class="checkbox">
        <label><input type="checkbox" class="check" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></label>
       </div>
      </c:forEach>
      </div>
      </div>
      </div>
      <div class="modal-footer" >
        <button type="button" id="closeBtn" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
<div class="complianceChecklistToolTips" style="display: none;">
<br>
<h2>A Few Tips on Navigating the Legal Register</h2>
<br>
This Dashboard shows information about the active Profile and from here, using the options in the panel on the left, you can:
<br><br>
<ul>
<li>Select either Environmental or Health &amp; Safety views of the Profile (if applicable)</li>
<li>View a list of legislation associated with the Profile by category</li>
<li>View a list of Compliance Checklists by category</li>
</ul>
<br>
<h2>Compliance Checklists</h2>
<br>
The system revolves around the COMPLIANCE CHECKLISTS (called Compliance Obligations in the ISO Standards) which outline the requirements against each "topic" that you may need to comply with and allow information about your company or site to be entered by users with the appropriate access level.
<br><br>
<ul>
<li>RELEVANCE - why it is applicable to your activities, and</li>
<li>EVALUATION OF COMPLIANCE - how you control compliance</li>
</ul>
<br>
Checklists link out to the legislation from which the requirements are derived (under the Legislation tab in the DETAIL view) The concept is that you can demonstrate to someone, for a particular topic, what the requirements are, which legislation they come from, why they are applicable and how you evaluate compliance.
<br><br>
<h2> Watch this video: Compliance Checklists (4 mins): </h2><a target="_blank" href="https://vimeo.com/213870492/c263cbd59e">https://vimeo.com/213870492/c263cbd59e</a>
</div>