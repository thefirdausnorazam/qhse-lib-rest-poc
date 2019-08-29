<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html">
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
<meta http-equiv="robots" content="noindex, nofollow, noarchive">


<c:set var="moduleColor" value="#a5b5d9" />
<!-- <style type="text/css" media="all">
/* 	@import "<c:url value='/css/default.css'/>"; */
/* 	h2, a, a:visited, table.viewForm a, div.menuContainer, table.viewForm tfoot tr td {color: <c:out value="${moduleColor}" />;} */
/* 	table.viewForm thead tr td {border-bottom-color: <c:out value="${moduleColor}" />; color: <c:out value="${moduleColor}" />; } */
/* 	div.menuTitle {background-color: <c:out value="${moduleColor}" />;} */
/* 	table.viewForm {border-color: <c:out value="${moduleColor}" />;} */
</style> -->
 <link rel="stylesheet" href="<scannell:resource value="/css/bootstrap-slider.css" />">   
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-slider.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/prototype.js" />" ></script> --%>
<script type="text/javascript">
jQuery(document).ready(function() {
	  var loc;
	  loc = jQuery('#levelOfCompliance').val();
	  jQuery('#ex6SliderVal').val(loc + '%');
	  
	  jQuery('#ex1').bootstrapSlider({
	    value: parseFloat(loc),
	    formatter: function(value) {
	      return 'Current value: ' + value;
	    }
	  });
	  
	  jQuery('#ex1').on('slide slideStop', function(slideEvt) {
	    jQuery('#ex6SliderVal').val(slideEvt.value + '%');
	    jQuery('#levelOfCompliance').val(slideEvt.value);
	  });
	  
	  jQuery('.custom-max-size').attr('maxlength','10000');
	});

function onBodyLoad(){
	//method created just to satisfy the obligation of popup decorator
}


</script>
<style type="text/css">
#ex1Slider .slider-selection {
	background: #4D90FD;
}
li {
	text-align: left; font-size: 100%; font-family: \'Open Sans\', sans-serif; 
}
</style>
</head>
<body ><br>
<div class="content"> 
<scannell:form id="myForm" onsubmit="document.getElementById('submit').disabled = 1;">
<h2 style="text-align: center; font-size: 100%; font-family: 'Open Sans', sans-serif; ">
	<strong>${command.checklistName}</strong>
	
</h2>

<h5 style="text-align: center; font-size: 100%; font-family: 'Open Sans', sans-serif; padding-top:2%">
	<strong><fmt:message key='thingsToConsider'/></strong>
	
</h5>
${command.thingsToConsider}
<div >
			<label class="col-sm-12 control-label scannellGeneralLabel" style="text-align:center">
				<fmt:message key="relevance" />
			</label>
			<div class="col-sm-12">
				<scannell:textarea path="relevance" cols="50" rows="10" cssStyle="width:100%" class="custom-max-size"/>
			</div>
		</div>
<div style="clear: both;"></div>
<div style="margin-top: 5px">
			<label class="col-sm-12 control-label scannellGeneralLabel" style="text-align:center">
				<fmt:message key="evaluationOfCompliance" />
			</label>
			<div class="col-sm-12">
				<scannell:textarea path="evaluationOfCompliance" cols="50" rows="10" cssStyle="width:100%" class="custom-max-size"/>
			</div>
</div>
	<div style="clear: both;"></div>
<div style="margin-top: 5px">
<c:if test="${command.locStatus}">
			<label class="col-sm-3 control-label scannellGeneralLabel ">
				<fmt:message key="levelOfCompliance" />
			</label>
			<div class="col-sm-4" style="padding-top:1%">			
			<input id="ex1" data-slider-id='ex1Slider' type="text" data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0"/> 		
			</div>
			<div class="col-sm-2" >			
			<input type='text' id='ex6SliderVal' class="form-control"  style="width:100%" readonly/>				
            </div>
</c:if>
<scannell:textarea path="levelOfCompliance" id="levelOfCompliance"  cssStyle="width:40%;float:left;" visible="false"/> 
	<div style="clear: both;padding-top:5%;"></div>
			<div class="spacer2  text-center footColor footer navbar-fixed-bottom" >
				<button id="submit" type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
			</div>
</div>
</scannell:form>
</div>

</body>
</html>
