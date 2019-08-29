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
		jQuery(document).ready(function() {
			// this is necessary for IE 9 - 10
			setTimeout(function() { cropImage(); }, 1500);
		});
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
	            	jQuery('#imageDiv').prepend('');
	            	jQuery("#imageDiv").show();
	            	jQuery('#imageDiv').prepend('<img id="theImg" src="e.target.result" alt="" border=3  style="max-height:500px" />');
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
      
     <tr id="contentRow" class="form-group"> 
		<td class="searchLabel"><fmt:message key="content" /></td>
		 <td class="search">
		 	<c:if test="${imageEncoded != '' }"><img id='theImg' name="theImg" style="max-height:500px"  src="data:image/jpg;base64,${imageEncoded}" alt="" border=3 /></c:if>
		</td>
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
