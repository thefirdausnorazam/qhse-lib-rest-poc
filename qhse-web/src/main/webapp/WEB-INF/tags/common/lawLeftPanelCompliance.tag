<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>
<%@ attribute name="currentYear" required="false" type="java.lang.String" %>
<%@ attribute name="yearList" required="false" type="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.col-centered{
    float: none;
    margin: 0 auto;
}

</style>

<script language="javascript" type="text/javascript">
		// The context path is needed in /js/site.js
		var  selectProfile, profileChange;
		

		selectProfile = void 0;
		jQuery(document).ready(function() {			
			var cook =1, leg, url;
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
			  var url;
			  var url;
			  var lwval;
			  lwval = void 0;
			  url = void 0;
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

			url = '<c:url value="/law/checklists.htmf?refine=false&viewAll=true&panel=true&legRegister="/>' + jQuery('#lawTabs').val();

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
          <button type="button" style="display:none;" id="second" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal </button>
          <h2 class="page-title">Compliance Checklists</h2>
          
          <!-- <p class="description">Select Category</p> -->

        </div>
        <div class="app-nav collapse">
          <div class="content">
            <div class="form-group">
              <label class="control-label">Legislation Register:</label>
              <select id="lawTabs" class="select2">    
	              <c:choose>           
		              <c:when test="${legReg == 1}" >
		                   <option value="1" selected="selected">Environment</option>
		              </c:when>
		               <c:when test="${legReg == 2}" >
		                   <option value="2" selected="selected">Health &amp; Safety</option>
		               </c:when>
		               <c:when test="${legReg == 3}" >
			               <option value="1" >Environment</option>
			               <option value="2" >Health &amp; Safety</option>
		               </c:when>
		               <c:otherwise>
		               		<option value="" selected="selected" title=""><fmt:message key="choose" /></option>
		               </c:otherwise>
	               </c:choose>
              </select>
            </div>
            <div class="form-group">
              <label class="control-label">Profile:</label>
              <select id="profileSelect" class="select2" onchange="selectProfile();">
						<c:if test="${profileSelected == false}">
							<option value="" selected="selected" title=""><fmt:message key="choose" /></option>
						</c:if>
						<c:forEach items="${viewableProfiles}" var="item">
							<option value="<c:out value="${item.id}" />"
								<c:if test="${item.selected}">selected="selected"</c:if>
								title="<c:out value="${item.name}"  />">
								<c:out value="${item.name}" /></option>
						</c:forEach>
					</select>
            </div>
            
            <div id="resultsDiv2"></div> 
          
			
          </div>


        </div>
      </div>
		</div>
		
		<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Select Profile</h4>
      </div>
      <div class="modal-body">
      <div class="col-lg-12"><h5>To view legislation you first need to select a Profile. The following Profiles either belong to you or have been shared with you, please select one of them.</h5></div>
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
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>