<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="thirdPartyTraineeEdit" />
<c:if test="${command.id == 0}">
  <c:set var="title" value="thirdPartyTraineeCreate" />
</c:if>
<title><fmt:message key="${title}" /></title>

</head>
<link rel="stylesheet" href="<c:url value='/css/crop/main.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/demos.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/jquery.Jcrop.css'/>" type="text/css" />
<script src="<c:url value='/js/crop/jquery.Jcrop.js' />"></script>

		<script type="text/javascript" >
		 
		 
		 
	function load_image(id,ext,input)
	  {
            
		if(validateExtension(ext) == false)
	     {
		    alert("Upload only JPEG, PNG, GIFF, GIF or JPG format ");
	        //document.getElementById("imagePreview").src = "#";
	        document.getElementById("content").focus();
	        document.getElementById("save").disabled = 1;
	        return;
	     }
	     document.getElementById("save").disabled = 0;
	     
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
	

	</script>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form enctype="multipart/form-data">
<input type="hidden" id="cropX" name="cropX" value="">
<input type="hidden" id="cropY" name="cropY" value="">
<input type="hidden" id="cropW" name="cropW" value="">
<input type="hidden" id="cropH" name="cropH" value="">
<div class="content"> 
<div class="table-responsive">
  <table class="table table-bordered table-responsive">
    <col />
    <tbody>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="name" />:</td>
        <td class="search"><input name="name" class="wide" /></td>
      </tr>
     <tr id="contentRow">
		<td class="searchLabel"><fmt:message key="content" /></td>
		 <td class="search"><input id="content" type="file" name="picture" class="wide" accept="image/*" onChange="load_image(this.id,this.value,this)"/>
        <div class="mandatoryFile" id="mandatoryFile" style="display:none" ><span class="requiredHinted">*</span></div>

		 <div class="image" id='imageDiv' style="width: 100; height: 100; ${command.id > 0 && imageEncoded != '' ? '' : 'display: none;'}">
		 	<c:if test="${command.id > 0 && imageEncoded != ''}"><img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${imageEncoded}" alt="" border=3 style="max-height:200px"/></c:if> 
		 </div>

	 </tr>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="company" />:</td>
        <td class="search"><input name="company" class="wide" /></td>
      </tr>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="address" />:</td>
        <td class="search"><input name="address" class="wide" /></td>
      </tr>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="phoneNumber" />:</td>
        <td class="search"><input name="phoneNumber" /></td>
      </tr>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="emailAddress" />:</td>
        <td class="search"><input name="emailAddress" /></td>
      </tr>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="2" align="center"><input id="save" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
      </tr>
    </tfoot>
  </table>
</div>
</div>
</scannell:form>

</body>
</html>
