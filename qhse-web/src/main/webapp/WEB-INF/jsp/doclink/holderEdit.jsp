<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="editDocLinkHolder" /></title>
<link href="<c:url value="/js/jsj/jquery.multiselect/css/multi-select.css" />" media="screen" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<c:url value="/js/jsj/bootstrap.multiselect/css/bootstrap-multiselect.css" />" />
<script src="<c:url value="/js/jsj/jquery.multiselect/js/jquery.multi-select.js" />" type="text/javascript"></script>
<script language="javascript" src="<c:url value="/js/selectBox.js" />" > </script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/docs.css" />" />
<script src="<c:url value="/js/utils.js" />"></script>
<script src="<c:url value="/js/docs.js" />"></script>

<style type="text/css">
.clickable{
cursor: pointer;
}
</style>
<style type="text/css">
  @media print {
  .tab-content > .tab-pane {display: block !important; opacity: 1 !important;}
 }
  </style>
    <style type="text/css" media="print">

.page     {
	font-size: .7em; 
	zoom: 1;
	overflow:hidden !important;size: landscape;
     }
.nowrap{}

div { width: 100%;     border: 0;   overflow: visible; size: auto;} 


body{width: 100%;}
</style>
<script type="text/javascript">
jQuery(document).ready(function () {
	setUpTabs();
	var showDocControl = false;
	jQuery(".popup-content+button").hide();
	try {
		opener.updateRequirements();
	} catch (err) {
	}
	onPageLoad();
});

function setUpTabs() {
    jQuery("#myTab li:eq(0) a").tab('show');
    
	jQuery('.nav-tabs > li ').hover( function(){
        if(jQuery(this).hasClass('hoverblock'))
            return;
        else
        	jQuery(this).find('a').tab('show');
   });

    jQuery('.nav-tabs > li').find('a').click( function(){
    	jQuery(this).parent()
        .siblings().addClass('hoverblock');
   });
    var url  = window.location.href;
    if(window.location.href.indexOf("#") >= 0){
    	var tab = url.split("#");
    	 $('a[href="#'+tab[1]+'"]').click();
    }
}

function onPageLoad() {
	var option;
	<c:forEach items="${command.links}" var="item">
		option = document.getElementById('<c:out value="link${item.id}" />');
		if (option) option.selected = true;
	</c:forEach>
	<c:forEach items="${command.documents}" var="item">
		option = document.getElementById('<c:out value="doc${item.id}" />');
		if (option) option.selected = true;
	</c:forEach>
	jQuery('#rightButton').click();
	jQuery('#rightButtonDocs').click();
	
}

function search(form, targetElementId, scrollToResults) {
	var targetId = '#unselected';
	if(targetElementId == 'docs') 
		targetId = '#unselectedDocs';	
	jQuery.ajax({
		   url:  jQuery(form).attr('action'),
		   type: "post",
		   dataType: "html",
		   data:jQuery(form).serialize(form),
		   success: function(returnData){
			   <%-- Hiding of Options inside select does not work in IE. so to handle this now we remove option and then add them when necessary. --%>
			   jQuery(targetId+" option").each(function()
				{
				   jQuery(this).remove();
				});
			   if(targetElementId == 'docs') {
					<c:forEach items="${distributedDocs}" var="item">  
						if((returnData.indexOf("<c:out value="${item.name}" escapeXml="false"/>") > -1) && (typeof jQuery("#documents option[value='<c:out value="${item.id}" />']").val() === "undefined")){
							jQuery(targetId).append(new Option("<c:out value="${item.name}" escapeXml="false"/>", "<c:out value="${item.id}" />"));
							
						}
					</c:forEach>	
			   }
			   else {	
					<c:forEach items="${links2}" var="item">   
						if((returnData.indexOf("<c:out value="${item.name}" escapeXml="false"/>") > -1) && (typeof jQuery("#links option[value='<c:out value="${item.id}" />']").val() === "undefined")){
							jQuery(targetId).append(new Option("<c:out value="${item.name}" escapeXml="false"/>( <c:set var="search" value="\\" /> <c:set var="replace" value="\\\\" /><c:out value="${fn:replace(item.url,search, replace)}" />)", "<c:out value="${item.id}" />"));
						}
					</c:forEach>	   
			   }
			
		   },
		   error: function(e){
		     alert('Error : '+e);
		   }
		});	
	return false;
}




function editLinks() {
	openWindow(contextPath + "/doclink/linkSearchForm.htm", screen.width-50, screen.height-100, null, "allLinks", true);
}
window.onunload = function (e) {	
	try {
		window.parent.location.reload(true);
    } catch (err) {
    }

};
function onFormSubmit(){
	var links = document.getElementById("links");
	for (var i = 0; i < links.length; i++) {	
		
		links[i].selected = true;
	}
	var documents = document.getElementById("documents");
	for (var i = 0; i < documents.length; i++) {	
		
		documents[i].selected = true;
	}
	//Copy links/docs to form on other tab
	jQuery("#linkDocs").val(jQuery("#documents").val());
	jQuery("#docLinks").val(jQuery("#links").val());
	window.parent.jQuery('#dialogLinkDocs').dialog('close');
	if(getUrlParameter('reloadPage') == 'false') {		
		window.parent.onPopupClose();
	} 
	
	window.close();
}

function closeRedirect(searchForm){
	window.parent.jQuery('#dialogLinkDocs').dialog('close');
	var contextPath = '<%=request.getContextPath()%>';
		window.parent.location.href = contextPath
				+ searchForm;
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
    return 'true';
}
</script>
</head>
<body>
	<div class="content">
		<ul class="nav nav-tabs nav-justified " id="myTab" >
	        <c:if test="${fn:contains(licences, 'doccontrol')}">
	        	<li><a data-toggle="tab" href="#sectionA"><span class="tabHead"><fmt:message key="docControlMenu" /></span></a></li>
	        </c:if>
	        <li><a data-toggle="tab" href="#sectionB"><span class="tabHead"><fmt:message key="docsMenu" /></span></a></li>
	    </ul>
	    
	    <div class="tab-content">
	    <c:if test="${fn:contains(licences, 'doccontrol')}">
	    	<div  id="sectionA" class="tab-pane fade in active">
		        <div class="content"> 
						<form id="queryForm" class="window" action="<%=request.getContextPath()%>/doccontrol/documentSearchForHolder.htmf"
							onsubmit="return search(this, 'docs');" style="margin-top: 30px;">
							<input type="hidden" name="viewName" value="documentSearchHolderResults" />
							<input type="hidden" name="active" value="true" />
							<input type="hidden" name="statusActive" value="true" />
							<input type="hidden" name="wasDistributed" value="true" />
							<input type="hidden" name="sortName" value="name" />
					
							<div class="form-group" style="height:40px;">
								<%-- <label class="col-sm-3 control-label scannellGeneralLabel nowrap">
									<c:if test="${userInDocsRole}">
										<a onclick="closeRedirect('/doccontrol/documentSearchForm.htm?status=''')" class="link-color clickable">
											<fmt:message key="doccontrol.distributedDocuments.header" />
										</a>
									</c:if>
								</label> 
								<div class="col-sm-3" style="text-align: left;color:red;width:60%"> --%>
								<div style="text-align: center;color:red;width:100%">
									<fmt:message key="clickSearch" /></br>
									<fmt:message key="doccontrol.distributedDocuments.warning" />
								</div>
							</div>
					
							<div style="clear:both;"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="doccontrol.docGroupSearchForm.name" />:</label>
								<div class="col-sm-6">
									 <input name="name" id="name" class="form-control" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="description" />:</label>
								<div class="col-sm-6">
									 <input name="description" id="description" class="form-control" />
								</div>
							</div>
	
							<div class="text-center">
								<button type="submit" id="searchButton" class="g-btn g-btn--primary">
									<fmt:message key="search" />
								</button>
							</div>
	
						</form>
				
						<scannell:form  onsubmit="onFormSubmit()">
							<div class="spacer2 text-center;" style="clear: both;"></div>
							<div style="width: 800px;">
								<div  id="select" style="float: left; width: 300px; overflow: auto;">
									<c:set var="search" value="\\" />
						            <c:set var="replace" value="\\\\" />
									<input id="docLinks" type="hidden" name="links"/>
									<select id="unselectedDocs" name="unselectedDocs"  multiple="multiple" size="10"  onDblClick="moveSelectedOptions(this.form['unselectedDocs'],this.form['documents'])" style="min-width: 100% !important;width: 100% !important">
										<c:forEach items="${documents}" var="item">
											<option id="<c:out value="doc${item.id}" escapeXml="false"/>" value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>  
										</c:forEach>
									</select>
										</div>
										<div  style="float: left; width: 200px;">
										<input id="rightButtonDocs" class="g-btn g-btn--primary" type="button" name="right" value="&gt;&gt;" onclick="moveSelectedOptions(this.form['unselectedDocs'],this.form['documents'])" /><br>
											<input type="button" class="g-btn g-btn--primary" name="left" value="&lt;&lt;" onclick="moveSelectedOptions(this.form['documents'],this.form['unselectedDocs'])" /><br>
										</div>
										<div style="float: left; width: 300px; overflow: auto;">
										<select id="documents" name="documents"  multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['documents'],this.form['unselectedDocs'])"  style="min-width: 100%!important;width: 100% !important"></select>
								</div>
							</div>
							<div class="spacer2 text-center;" style="clear: both;"></div>
							<div class="spacer2 text-center;">
								<button type="submit" class="g-btn g-btn--primary" id="save">
									<fmt:message key="submit" />
								</button>
							</div>
						</scannell:form>
				
						<div style="clear: both;"></div>
					</div>			
			</div>
			</c:if>
			
			<div  id="sectionB" class="tab-pane fade">
			        <div class="content"> 
							<form id="queryForm" class="window" action="<%=request.getContextPath()%>/doclink/linkSearchForHolder.htmf"
								onsubmit="return search(this, 'select');" style="margin-top: 30px;">
								<input type="hidden" name="viewName" value="linkSearchHolderResults" />
								<input type="hidden" name="attachmentType" value="Link" />
								<input type="hidden" name="active" value="true" />
								
								<div class="form-group" style="height:40px;">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
										<c:if test="${userInRole}">						
											<a onclick="closeRedirect('/doclink/linkSearchForm.htm')" class="link-color clickable">
												<fmt:message key="editLinks" /> 
											</a>
										</c:if>
									</label>
									<div class="col-sm-3" style="text-align: left;color:red;width:60%">
										<fmt:message key="clickSearch" /></br>
										<fmt:message key="noAttachment" />
									</div>
								</div>
								
								<div style="clear:both;"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
										<fmt:message key="category" />
									</label>
									<div class="col-sm-6">
										<select name="categoryId" class="form-control" style="float:left;width:100%" >
											<option></option>
											<c:forEach items="${categories}" var="item">
												<option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
											</c:forEach>
										</select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
										<fmt:message key="name" />
									</label>
									<div class="col-sm-6">
										<input type="text" name="name" class="form-control" style="float:left;" />
									</div>
									
								</div>
	
								<div class="text-center">
									<button type="submit" id="searchButton" class="g-btn g-btn--primary">
										<fmt:message key="search" />
									</button>
								</div>
				
							</form>
				
							<scannell:form onsubmit="onFormSubmit()" enctype="multipart/form-data">
								<div class="spacer2 text-center;" style="clear: both;"></div>
									<div style="width: 800px;">
										<div  id="select" style="float: left; width: 300px; overflow: auto;">
											<c:set var="search" value="\\" />
								            <c:set var="replace" value="\\\\" />
											<input id="linkDocs" type="hidden" name="documents"/>
								            <select id="unselected" name="unselected"  multiple="multiple" size="10"  onDblClick="moveSelectedOptions(this.form['unselected'],this.form['links'])" style="min-width: 100% !important;width: 100% !important">
												<c:forEach items="${links}" var="item">
													<option id="<c:out value="link${item.id}" escapeXml="false"/>" value="<c:out value="${item.id}" />"><c:out value="${item.name}" />(<c:out value="${fn:replace(item.url,search, replace) }" />)</option>  
												</c:forEach>
											</select>
										</div>
										<div  style="float: left; width: 200px;">
												<input id="rightButton" class="g-btn g-btn--primary" type="button" name="right" value="&gt;&gt;" onclick="moveSelectedOptions(this.form['unselected'],this.form['links'])" /><br>
												<input type="button" class="g-btn g-btn--primary" name="left" value="&lt;&lt;" onclick="moveSelectedOptions(this.form['links'],this.form['unselected'])" /><br>
										</div>
										<div style="float: left; width: 300px; overflow: auto;">
											<select id="links" name="links"  multiple="multiple" size="10" ondblclick="moveSelectedOptions(this.form['links'],this.form['unselected'])"  style="min-width: 100%!important;width: 100% !important"></select>
										</div>
									</div>
									<div class="spacer2 text-center;" style="clear: both;"></div>
									<div class="spacer2 text-center;">
									<button type="submit" class="g-btn g-btn--primary" id="save">
										<fmt:message key="submit" />
									</button>
								</div>
							</scannell:form>
				
							<div style="clear: both;"></div>
						</div>
					</div>
		</div>
	</div>
</body>
</html>
