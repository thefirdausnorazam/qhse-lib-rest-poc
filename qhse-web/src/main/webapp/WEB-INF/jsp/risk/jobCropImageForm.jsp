<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="thirdPartyTraineeCrop" />
<title><fmt:message key="${title}" /></title>
</head>
<link rel="stylesheet" href="<c:url value='/css/crop/main.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/demos.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/crop/jquery.Jcrop.css'/>" type="text/css" />
<script src="<c:url value='/js/crop/jquery.Jcrop.js' />"></script>
<script type="text/javascript" >
var cropImage, load_image, showCoords, validateExtension;
cropImage = function() {
  var H, W, h, w, x, x1, y, y1;
  w = 100;
  h = 100;
  W = jQuery('#theImg').width();
  H = jQuery('#theImg').height();
  x = W / 2 - (w / 2);
  y = H / 2 - (h / 2);
  x1 = x + w;
  y1 = y + h;
  jQuery('#theImg').Jcrop({
    onChange: showCoords,
    onSelect: showCoords,
    setSelect: [x, y, x1, y1],
    minSize: [100, 100],
    maxSize: [260, 260],
    aspectRatio: 1 / 1
  });
};

showCoords = function(c) {
  var actH, actW, actX, actY, hper, imageheight, imagewidth, wPer, xper, yper;
  imageheight = document.getElementById('theImg').naturalHeight;
  imagewidth = document.getElementById('theImg').naturalWidth;
  xper = c.x * 100 / jQuery('#theImg').width();
  yper = c.y * 100 / jQuery('#theImg').height();
  wPer = c.w * 100 / jQuery('#theImg').width();
  hper = c.h * 100 / jQuery('#theImg').height();
  actX = xper * imagewidth / 100;
  actY = yper * imageheight / 100;
  actW = wPer * imagewidth / 100;
  actH = hper * imageheight / 100;
  jQuery('#cropX').val(parseInt(actX));
  jQuery('#cropY').val(parseInt(actY));
  jQuery('#cropW').val(parseInt(actW));
  jQuery('#cropH').val(parseInt(actH));
};

load_image = function(id, ext, input) {  
  if (validateExtension(ext) === false) {
    bootbox.alert('Upload only JPEG, PNG, GIFF, GIF or JPG format ');
    document.getElementById('content').focus();
    document.getElementById('save').disabled = 1;
    return;
  }
  document.getElementById('save').disabled = 0;
  if (input.files && input.files[0]) {
	var reader = new FileReader;
    reader.onload = function(e) {
      jQuery('#imageDiv').prepend('');
      jQuery('#imageDiv').show();
      jQuery('#imageDiv').prepend('<img id="theImg" src="e.target.result" alt="" border=3  style="max-height:500px" />');
      jQuery('#theImg').attr('src', e.target.result);
      cropImage();
    };
    reader.readAsDataURL(input.files[0]);
  }
};

validateExtension = function(v) {
  var allowedExtensions, ct, sample;
  allowedExtensions = new Array('jpg', 'JPG', 'jpeg', 'JPEG', 'giff', 'GIFF', 'gif', 'GIF', 'png', 'PNG');
  ct = 0;
  while (ct < allowedExtensions.length) {
    sample = v.lastIndexOf(allowedExtensions[ct]);
    if (sample !== -1) {
      return true;
    }
    ct++;
  }
  return false;
};

jQuery(document).ready(function() {
  cropImage();
});
	

</script>
<body>
<scannell:form  enctype="multipart/form-data">
<input type="hidden" id="cropX" name="cropX" value="">
<input type="hidden" id="cropY" name="cropY" value="">
<input type="hidden" id="cropW" name="cropW" value="">
<input type="hidden" id="cropH" name="cropH" value="">
<div class="content">
  <table class="table  table-responsive">
    <col />
    <tbody>      
     <tr id="contentRow" class="form-group"> 
		<td class="searchLabel"><fmt:message key="content" /></td>
		 <td class="search">
		 	<c:if test="${imageEncoded != ''}"><img id='theImg' name="theImg" style="max-height:500px"  src="data:image/jpg;base64,${imageEncoded}" alt="" border=3 /></c:if>
		</td>
	 </tr>      
    </tbody>    
  </table>  
</div>
<div class="spacer2 text-center">
<input id="save" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
</div>
</scannell:form>

</body>
</html>
