<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="auditTypeQuestionEdit" />
	<c:if test="${command.id == 0}"><c:set var="title" value="inspectionProgrammeTypeQuestionCreate" /></c:if>
	<title><fmt:message key="${title}" /></title>
	<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<link rel="stylesheet" href="<c:url value='/css/crop/main.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/demos.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/jquery.Jcrop.css'/>" type="text/css" />
<script src="<c:url value='/js/crop/jquery.Jcrop.js' />"></script>
	<script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var ownerCount = ${fn:length(owners)};
		var maxListSize = 500;
	
	jQuery(document).ready(function() {	
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
		jQuery('#answerType').select2({width:'40%'});
		jQuery('#questionsLabel').select2({width:'40%'});
		jQuery('#answerType option').each(function (){
			if(jQuery(this).text() == 'Label'){
				jQuery(this).text('Group Name');
			}
		});
		if(jQuery("#questionsLabelTD").find(".select2-chosen").text().toLowerCase() == "label"){
			jQuery("#questionsLabelTD").find(".select2-chosen").text("Group Name")
		}
		jQuery('#answerType').on("change", function (){
			answerTypeOnChange();
		});
		jQuery('#answerType').trigger("onchange");
		answerTypeOnChange();
	});
	function answerTypeOnChange(){
		if(jQuery('#answerType').val() == "option"){
			jQuery('.questionsLabelRow').show();
		} else {
			jQuery('.questionsLabelRow').hide();
		}
	}
	function load_image(id,ext,input)
	  {
            
		if(validateExtension(ext) == false)
	     {
		    alert("Upload only JPEG, PNG, GIFF, GIF or JPG format ");
	        //document.getElementById("imagePreview").src = "#";
	        document.getElementById("content").focus();
	        //document.getElementById("save").disabled = 1;
	        return;
	     }
	     //document.getElementById("save").disabled = 0;
	     
	     if (input.files && input.files[0]) {
	            var reader = new FileReader();

	            reader.onload = function (e) {
	            	jQuery('#imageDiv').text('');
	            	jQuery("#imageDiv").show();
	            	jQuery('#imageDiv').prepend('<img id="theImg" src="e.target.result" alt="" border=3  style="max-height:200px" />');
	            	jQuery("#theImg").attr("src",e.target.result);
	            	//jQuery('#theImg').Jcrop();
	            	cropImage();
	            }

	            reader.readAsDataURL(input.files[0]);
	            setTimeout(function() { cropImage(); }, 1500);
	        }
	     
	  }
	function validateExtension(v)
	  {
	        var allowedExtensions = new Array("jpg","JPG","jpeg","JPEG", "giff", "GIFF", "gif", "GIF", "png", "PNG");
	        for(var ct=0;ct<allowedExtensions.length;ct++)
	        {
	            sample = v.lastIndexOf(allowedExtensions[ct]);
	            if(sample != -1){return true;}
	        }
	        return false;
	  }
	function cropImage(){			 
		 var w = 100;
	        var h = 100;
	        var W = jQuery('#theImg').width();
	        var H = jQuery('#theImg').height();
	        var x = W / 2 - w / 2;
	        var y = H / 2 - h / 2;
	        var x1 = x + w;
	        var y1 = y + h;

	        jQuery('#theImg').Jcrop({
	            onChange : showCoords,
	            onSelect : showCoords,

	            setSelect : [ x, y, x1, y1 ]
	            ,minSize : [ 100, 100 ] // use for crop min size
	            ,maxSize : [ 260, 260 ] // use for crop min size
	            ,aspectRatio : 1 / 1    // crop ration 
	        });
		    //jQuery('#theImg').Jcrop();
	        
		 }
	        
	 function showCoords(c) {
	      // get image natural height/width for server site crop image.
	        var imageheight = document.getElementById('theImg').naturalHeight;
	        var imagewidth = document.getElementById('theImg').naturalWidth;
	        var xper = (c.x * 100 / jQuery('#theImg').width());
	        var yper = (c.y * 100 / jQuery('#theImg').height());
	        var wPer = (c.w * 100 / jQuery('#theImg').width());
	        var hper = (c.h * 100 / jQuery('#theImg').height());

	        var actX = (xper * imagewidth / 100);
	        var actY = (yper * imageheight / 100);
	        var actW = (wPer * imagewidth / 100);
	        var actH = (hper * imageheight / 100);
	        jQuery('#cropX').val(parseInt(actX));
	        jQuery('#cropY').val(parseInt(actY));
	        jQuery('#cropW').val(parseInt(actW));
	        jQuery('#cropH').val(parseInt(actH));

	    };
	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form enctype="multipart/form-data">
<input type="hidden" id="cropX" name="cropX" value="">
<input type="hidden" id="cropY" name="cropY" value="">
<input type="hidden" id="cropW" name="cropW" value="">
<input type="hidden" id="cropH" name="cropH" value="">

<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >

<tbody>
	
	
	<tr class="form-group">
		<td class="searchLabel" style="width:40%"><fmt:message key="name" />:</td>
		<td class="search"><scannell:textarea path="name" id="name" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="type" />:</td>
		<td class="search" id="questionsLabelTD">
			<select name="answerType" id="answerType" items="${answerTypes}"
				itemValue="name" lookupItemLabel="true" class="wide" cssStyle="width:40%" />
				
		</td>
	</tr>
	<tr class="form-group" style="display:none">
		<td class="searchLabel nowrap"><fmt:message key="description" /> <fmt:message key="mandatory" />:</td>
		<td class="search">
			<scannell:checkbox  path="descriptionMandatory" id="descriptionMandatory" /> 
		</td>
	</tr>
	
	<tr class="form-group questionsLabelRow"  id="questionsLabelRow">
		<td class="searchLabel nowrap"><fmt:message key="groupName" />:</td>
		<td class="search" >
			<select name="parentQuestionLabel" id="questionsLabel" items="${questionsLabel}"
				itemValue="id" itemLabel="name" lookupItemLabel="true" class="wide" cssStyle="width:40%" />
		</td>
	</tr>
	<tr class="form-group questionsLabelRow" id="contentRow">
		<td class="searchLabel"><fmt:message key="chooseImage" /></td>
		 <td class="search"><input id="content" type="file" name="picture" class="wide" accept="image/*" onChange="load_image(this.id,this.value,this)"/>
        <div class="mandatoryFile"  id="mandatoryFile"  ><span class="requiredHinted"><c:if test="${imageSizeError}"><fmt:message key="imageSizeErrorRA"/></c:if> </span></div>

		 <div class="image" id='imageDiv' style="max-height: 200; ${imageEncoded!=null && imageEncoded != '' ? '' : 'display: none;'}">
		 	<c:if test="${imageEncoded!=null && imageEncoded != ''}"><img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${imageEncoded}" alt="" border=3 style="max-height:200px"/></c:if> 
		 </div>
		</td>
	 </tr>
	<tr class="form-group" style="${command.id > 0 ? '' : 'display:none'}">
		<td class="searchLabel nowrap"><fmt:message key="active" />:</td>
		<td class="search">
			<scannell:checkbox  path="active" id="active" />
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		
		<td colspan="2" align="center"><input type="button" onclick="location.href='auditTypeView.htm?id=${questionGroupId}'" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
