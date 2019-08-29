<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@page import="com.scannellsolutions.site.SiteUtils"%>
<%@ page language="java" import = "com.scannellsolutions.site.Site" %>

<!DOCTYPE html>
<html>
<head>
  
  <title></title>  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
  <style type="text/css" media="all">
    td.search {
    width:65%!important;
    }
  </style>
  <script type="text/javascript">
  jQuery(document).ready(function() {	 
	  jQuery("#businessAreaId").select2({width:'100%'});	  	 
	  jQuery("#active").select2().select2({width:'100%'});
	  jQuery("#activeInSiteId").select2({width:'100%'});
	  
	  jQuery("#inactiveInSiteId").select2({width:'100%'});
	  
	  jQuery('#businessAreaId').select2('val', '');
		jQuery('#active').select2('val', '');
		jQuery('#activeInSiteId').select2('val', '');
	  init();
	  
	  displayQueryDiv(false);
	  
  });
  
  function init() {
	  copyFormValuesIfPopup('queryForm');
	  jQuery("#queryForm").submit();
	  }
  
	function hardResetForm(form) {
	    var inputs = form.getElementsByTagName('input');
	    for (var i = 0; i<inputs.length; i++) {
	        switch (inputs[i].type) {
	          case 'text':
	                inputs[i].value = '';
	                break;
	        }
	    }
	jQuery('#businessAreaId').select2('val', '');
	jQuery('#active').select2('val', '');
	jQuery('#activeInSiteId').select2('val', '');
}
	function changeInactivesInSite(){
		
		jQuery("#inactiveInSiteId").select2().select2('val',
				jQuery('#inactiveInSiteId option:eq(0)').val());
		jQuery("#inactiveInSiteId").select2({width:'100%'});
	}
function changeActivesInSite(){
		jQuery("#activeInSiteId").select2().select2('val',
		jQuery('#activeInSiteId option:eq(0)').val());
		jQuery("#activeInSiteId").select2({width:'100%'});
	}
function trimDescription(){
	jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  }
  </script>
</head>
<body>
    <%
      Site site = SiteUtils.currentSite();
    %>
    
<div class="col-md-12">
	<div id="block" class="">
		<div class="row header">
		    <div class="col-md-6">
		    	<div class="nowrap">
					<h2><fmt:message key="templateQueryForm.title" /></h2>
				</div>
			</div>
		    <div class="col-md-6">
		    	<div align="right">
		  			<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Display Search</button>
		  			<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
				</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
		<div class="hidden-print col-sm-3 pull-right" style="padding-right:0px;">
		  <div style="text-align:right;">
			  
		  </div>
		</div>
	</div>
</div>
    


<div class="content" style="margin-top:5%">

						    <form id="queryForm"  class="form-horizontal group-border-dashed" style="border-radius: 0px;"  action="<c:url value="/risk/templateQueryResult.ajax" />" onSubmit="return search(this, 'resultsDiv'); ">
								<input type="hidden" name="calculateTotals" value="true" />
								  <input type="hidden" name="pageNumber" value="1" />
								  <input type="hidden" id="pageSize" name="pageSize" />
								  <input type="hidden" id="activeInCurrentSite" name="activeInCurrentSite" value="${site.id}"/>
  
								<div id="queryDiv">
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="businessArea" /></label>
									<div class="col-sm-6">
										<select id="businessAreaId" name="businessAreaId" style="width:400px">
                                      <option value="">Choose</option>
                                     <c:forEach items="${businessAreaList}" var="ba">
                                    <option value="<c:out value="${ba.id}" />" <c:if test="${businessArea.id == ba.id}">selected="selected"</c:if>><c:out value="${ba.name}" /></option>
                                    </c:forEach>
                                    </select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="template.name" /></label>
									<div class="col-sm-6">
									<input type="text" class="form-control" id="name" name="name">																				
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="template.active" /></label>
									<div class="col-sm-6">
										<select id="active" name="active" style="width:100px">
                                        <option selected="selected" value="">Choose</option>
                                        <option value="true" selected="selected"><fmt:message key="true" /></option>
                                        <option value="false"><fmt:message key="false" /></option>
                                        </select>	
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="template.activeInSites" /></label>
									<div class="col-sm-6">
										<select id="activeInSiteId" name="activeInSiteId" onchange="changeInactivesInSite()">
	      	                           <option selected="selected" value="">Choose</option>
	                                   <c:forEach items="${sites}" var="site">
                                    	<option value="${site.id}" <c:if test="${currentSite.id == site.id}">selected</c:if>><c:out value="${site.name}" /></option>
                                       </c:forEach>
	                                  </select>	
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="template.inactiveInSites" /></label>
									<div class="col-sm-6">
										<select id="inactiveInSiteId" name="inactiveInSiteId" onchange="changeActivesInSite()">
	      	                           <option selected="selected" value="">Choose</option>
	                                   <c:forEach items="${sites}" var="site">
                                    	<option value="${site.id}" ><c:out value="${site.name}" /></option>
                                       </c:forEach>
	                                  </select>	
									</div>
								</div>
								<div class="spacer2 text-center">
			                     <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryDiv(false);trimDescription();"><fmt:message key="search" /></button>
                                 <button type="reset" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);"><fmt:message key="reset" /></button>
			                  </div>
			                  </div>
			                  <div id="resultsDiv" ></div>
								
							</form>
						

 </div>

</body>
</html>
