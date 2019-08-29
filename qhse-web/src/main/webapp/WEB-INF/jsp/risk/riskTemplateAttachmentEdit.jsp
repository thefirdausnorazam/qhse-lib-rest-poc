<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head><style type="text/css" media="all">
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}</style>
	<c:choose>
		<c:when test="${empty command.name}"><title><fmt:message key="riskMatrix" /></title></c:when>
		<c:otherwise><title><fmt:message key="riskMatrix" /></title></c:otherwise>
	</c:choose>
		<script type="text/javascript" >
		window.onload = function() {
			var url = '${filename}';
			var type = null;
			if (url != null && url != "" && url != "null") {
				jQuery("#file-info").html(url);
			} 
		}
		function getName(s) {
			var arr = s.split('\\');
			var name = arr[(arr.length - 1)];
			return name;
		}
		function changeFile() {
			var content = jQuery('#content').val();
			var name = getName(content);
			jQuery('#filename').val(name);
			jQuery("#file-info").html(name);
		}
	function load_image(id,ext, input)
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
	            	jQuery('#imageDiv').prepend('<img id="theImg" src="e.target.result" alt="" border=3  />');
	            	jQuery("#theImg").attr("src",e.target.result);
	            	
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
	
	var isNew = null;
	function onTypeChange() {
		var isAttachment = $("type").value == "attach";
		$("content").disabled = !isAttachment;
		$("externalUrl").disabled = isAttachment;

		if (isNew == null) {
			isNew = $("name").value == "";
		}

		if (isNew) {
			$("filenameRow").style.display = 'none';
		} else {
			$("type").disabled = true;
			if ($("filename").value != "") { // File attachment already exists
				$("contentRow").style.display = 'none';
				$("filenameRow").style.display = '';
				$("filename").disabled = true;
			} else { // File attachment does not already exists
				$("filenameRow").style.display = 'none';
			}
		}
	}
	// -->
	
	jQuery('#content2').val('test test')
	</script>
</head>
<body onload="onTypeChange();">
<scannell:form enctype="multipart/form-data">
<div class="mandatoryURL" id="mandatoryURL"  style="display:none" ><scannell:input id="type" path="type" /></div>
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-responsive table-bordered">
<col class="label" />
<tbody>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
		<td><scannell:input id="name" path="name" class="wide" /></td>
	</tr>
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="description" />:</td>
		<td><scannell:textarea path="description" cols="75" rows="3" /></td>
	</tr>

	<tr id="contentRow">
		<td class="scannellGeneralLabel"><fmt:message key="content" /></td>
		<td>
			<span class="g-btn g-btn--primary btn-file">
				Browse
				<input type="file" id="content" value="docLink.url" name="content" accept="image/*" onchange='load_image(this.id,this.value, this);changeFile()'>
			</span>
			<span class='label label-info' id="file-info"></span>
			<input type="hidden" id="filename" name="filename" />
		
	</tr>
	 
	<tr>
		<td class="scannellGeneralLabel"><fmt:message key="active" />:</td>
		<td><scannell:checkbox id="active" path="active" /></td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input id="save" type="submit" value="<fmt:message key="submit" />"></td>
	</tr>
	<tr>
		<td colspan="2" >
			<div class="image" id='imageDiv' style="width: 100; height: 100; text-align:center; ${matrix != '' ? '' : 'display: none;'}">
			<c:if test="${matrix != ''}">
		 	<img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${matrix}" alt="${attachment.name}"/></c:if> 
		 </div>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
<script type="text/javascript">

</script>
</body>
</html>
