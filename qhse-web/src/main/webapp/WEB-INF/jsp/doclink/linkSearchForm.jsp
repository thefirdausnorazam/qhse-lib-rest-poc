<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="javascript" src="<c:url value="/js/utils.js" />"></script>
<style type="text/css" media="all">
@import "<c:url value='/css/docs.css'/>";
</style>
<script type="text/javascript">
	var contextPath = '<%=request.getContextPath()%>';

	jQuery(document).ready(
			function() {
				jQuery('#queryForm').addClass('form-horizontal group-border-dashed');

				if('${quickLink}' != '') {
					hardResetForm(document.getElementById('queryForm'));
					if('${selectedAttachmentType}' != '') {
						jQuery("#attachmentType").val('${selectedAttachmentType}').trigger('change');
					}
				}
				//jQuery('#queryForm').submit();
				
				jQuery('#queryTable').hide();
				jQuery("#queryTableToggleLink").text(SCANNELL_TRANSLATIONS.hideSearchCriteria);
				displayQueryTable(false);
				
				if('${quickLink}' == '') {
					onLoadFunction('queryForm');
				}else{
					jQuery('#queryForm').submit();
				}
			});
	
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
	function searchLinks(form, targetElementId) {
		var url = buildFormUrl("/doclink/linkSearch.htmf", form);
		getXMLDoc(url, targetElementId);
		return false;
	}

	function onSelectLink(linkId) {
		var url = contextPath + '/doclink/linkEdit.htm';
		if (linkId) {
			url = url + '?showId=' + linkId;
		}
		location.href = url;
		location.target = top;
	}
	function onSelectDoc(docId) {
	      var url = contextPath + '/doclink/editDocAttachment.htm';
	      if (docId) {
	        url = url + '?showId=' + docId;
	      }
	      location.href=url;
	      location.target=top;
	}
	function onIFrameClose() {
		document.getElementById("searchButton").click();
		var editFrame = document.getElementById("editFrame")
		editFrame.style.display = "none";
	}

	function toggleCategory(categoryName){
	// One of the biggest hack i have ever made i have done this because getElementsByName in IE keeps returning 0
		var tagstrs =	document.getElementsByTagName('tr');
		var lastfound;
		for (var i = 0; i < tagstrs.length; i++) {
			var tagid = tagstrs[i].id;
			var size = tagid.search('category-'+categoryName);
			if (size > -1) {
				if ($(tagid).visible()) {
					Effect.Fade(tagid);
				} else {
					Effect.Appear(tagid);
				}
				lastfound = tagid;
			}
		}
		var image = document.getElementById('toggle-' + categoryName);
		if (!$(lastfound).visible()) {
			image.src = '<c:url value="/images/minus.gif"/>';
		} else {
			image.src = '<c:url value="/images/plus.gif"/>';
		}
	}
	function restoreSearchCriteria(formId){
	     var categoryId = '<%=request.getSession().getAttribute("documentSearch.categoryId")%>';
	   	if(categoryId != 'null'){
	   		jQuery("#categoryId").val(categoryId);
	   	}
        setTimeout(function(){
    		var attachmentType='<%=request.getSession().getAttribute("documentSearch.attachmentType")%>';
    		if (attachmentType != 'null')
    			jQuery("#attachmentType").val(attachmentType).trigger('change');
        }, 2000);
	   	var name='<%=request.getSession().getAttribute("documentSearch.name")%>';
	   	if(name != 'null')
	   		jQuery("#name").val(name);
	   	var active='<%=request.getSession().getAttribute("documentSearch.active")%>';
	   	if(active != 'null'){
	   		jQuery("#active").val(active);
	   	}else {
	   		jQuery('#active').val(jQuery('#active option:eq(0)').val()).trigger('change');
	   	}
	   	var sortName='<%=request.getSession().getAttribute("documentSearch.sortName")%>';
	   	if(sortName != 'null')
	   		jQuery("#sortName").val(sortName);
	   	var pageSize='<%=request.getSession().getAttribute("documentSearch.pageSize")%>';
		if (pageSize != 'null')
			jQuery("#pageSize").val(pageSize);

		
	}
	function onLoadFunction(formId) {
		restoreSearchCriteria(formId);
		jQuery('#'+formId).submit();
		
	}

	function toggleQueryTable() {
		if (jQuery('#queryTable').is(':visible')) {
			jQuery('#queryTable').fadeOut("slow")
			jQuery('#queryTableToggleLink').text(SCANNELL_TRANSLATIONS.displaySearchCriteria);
		} else {
			jQuery('#queryTable').fadeIn("slow");
			jQuery('#queryTableToggleLink').text(SCANNELL_TRANSLATIONS.hideSearchCriteria);
		}
	}

	function hardResetForm(form) {
		var inputs = form.getElementsByTagName('input');
		for (var i = 0; i < inputs.length; i++) {
			switch (inputs[i].type) {
			case 'text':
				inputs[i].value = '';
				break;
			}
		}
		jQuery('#categoryId').val('').trigger('change');
		jQuery('#active').val(jQuery('#active option:eq(0)').val()).trigger('change');
		jQuery('#name').val('');
		jQuery('#attachmentType').val('').trigger('change');
		jQuery('#sortName').val('').trigger('change');
		
	}
	function setParam() {
		//jQuery('#docType').val(jQuery('#attachmentType').val())
		//alert(jQuery('#docType').val());
	}
	
	function openLinkFile(link) {
		
		window.open("openLinkFile.htm?link="+link);
		
		
	}
	
	function trimDescription(){
		jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
  	}
</script>

</head>
<body >
	<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div style="padding-left: 0px;" class="col-md-6"></div>
				<div class="col-md-12 col-sm-12">
					<div style="text-align: right;">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">
							<fmt:message key="search.displaySearchCriteria" />
						</button>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='docAttachmentEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="uploadLink" />
							</button>
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='linkEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="addLink" />
							</button>
						</c:if>
						<button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary">
							<i class="fa fa-print" style="color: white"></i>
							<span></span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<scannell:form id="queryForm" action="/doclink/linkSearch.htmf" onsubmit="return search(this, 'resultsDiv');">
			<input type="hidden" id="calculateTotals" name="calculateTotals" value="true">
			<scannell:hidden path="pageNumber" />
			<scannell:hidden path="pageSize" />
			<input type="hidden" name="docType" id="docType" value="" />
			<div id="queryTable">
				<div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">
						<fmt:message key="docChooseCat" />
					</label>
					<div class="col-sm-6">
						<scannell:select id="categoryId" class="form-control wide" path="categoryId" items="${categories}"
							itemValue="id" itemLabel="name" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">
						<fmt:message key="active" />
					</label>
					<div class="col-sm-6">
					<select id="active" name="active" class="form-control wide">
									<option value="true" ><fmt:message key="true" /></option>
									<option value="false"><fmt:message key="false" /></option>
								</select>
						<%--<scannell:select id="active" class="form-control wide" path="active" items="${active}" itemValue="value"
							itemLabel="key" /> --%>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">
						<fmt:message key="doclink.linkSearchForm.linkName" />
					</label>
					<div class="col-sm-6">
						<scannell:input id="name" path="name" cssStyle="width:100%" class="form-control wide" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">
						<fmt:message key="docType" />
					</label>
					<div class="col-sm-6">
						<scannell:select id="attachmentType" class="form-control wide" path="attachmentType" items="${docTypes}" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">
						<fmt:message key="doclink.linkSearchForm.sortName" />
					</label>
					<div class="col-sm-6">
						<scannell:select id="sortName" class="form-control wide" path="sortName" items="${sorts}" />
					</div>
				</div>


				<div class="spacer2 text-center">
					<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;setParam();trimDescription();">
						<fmt:message key="search" />
					</button>
					<button id="resetAll" type="button" class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);">
						<fmt:message key="reset" />
					</button>
				</div>


			</div>
			<div id="resultsDiv"></div>
		</scannell:form>
	</div>
	
</body>
</html>

