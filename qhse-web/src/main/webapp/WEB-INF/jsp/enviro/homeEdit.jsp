<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="expires"   content="0">
	<meta http-equiv="pragma"    content="no-cache">
	<meta http-equiv="copyright" content="&copy; Scannell Solutions">
	<meta http-equiv="robots"    content="noindex, nofollow, noarchive">	
	<style type="text/css">
	.small-screen-size {
			clear:both !important;
			display:block !important;
	}
.home-navbar-nav {
margin: 0;
}


.quick-buttons {
    position: relative;
    display: block;
    background: #06941F;
    padding: 20px 10px 0px 20px;
    margin-bottom: 10px;
    overflow: hidden;
    -webkit-border-radius: 5px;
    -webkit-background-clip: padding-box;
    -moz-border-radius: 5px;
    -moz-background-clip: padding;
    border-radius: 5px;
    background-clip: padding-box;
    -webkit-transition: all 300ms ease-in-out;
    -moz-transition: all 300ms ease-in-out;
    -o-transition: all 300ms ease-in-out;
    transition: all 300ms ease-in-out;
}

.quick-buttons .icon {
    color: rgba(0, 0, 0, 0.1);
    position: absolute;
    top: 1px;
    right: 5px;
    z-index: 1;
    opacity: .3;
}

.quick-buttons.tile-red {
  background: #f56954;
}
.quick-buttons.tile-red:hover {
  background: #f4543c;
}
.quick-buttons.tile-red .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-red .num,
.quick-buttons.tile-red h3,
.quick-buttons.tile-red p {
  color: #fff;
}
.quick-buttons.tile-green {
  background: #00a65a;
}
.quick-buttons.tile-green:hover {
  background: #008d4c;
}
.quick-buttons.tile-green .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-green .num,
.quick-buttons.tile-green h3,
.quick-buttons.tile-green p {
  color: #fff;
}
.quick-buttons.tile-blue {
  background: #0073b7;
}
.quick-buttons.tile-blue:hover {
  background: #00639e;
}
.quick-buttons.tile-blue .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-blue .num,
.quick-buttons.tile-blue h3,
.quick-buttons.tile-blue p {
  color: #fff;
}
.quick-buttons.tile-aqua {
  background: #00c0ef;
}
.quick-buttons.tile-aqua:hover {
  background: #00acd6;
}
.quick-buttons.tile-aqua .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-aqua .num,
.quick-buttons.tile-aqua h3,
.quick-buttons.tile-aqua p {
  color: #fff;
}
.quick-buttons.tile-cyan {
  background: #00b29e;
}
.quick-buttons.tile-cyan:hover {
  background: #009987;
}
.quick-buttons.tile-cyan .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-cyan .num,
.quick-buttons.tile-cyan h3,
.quick-buttons.tile-cyan p {
  color: #fff;
}
.quick-buttons.tile-purple {
  background: #ba79cb;
}
.quick-buttons.tile-purple:hover {
  background: #b167c4;
}
.quick-buttons.tile-purple .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-purple .num,
.quick-buttons.tile-purple h3,
.quick-buttons.tile-purple p {
  color: #fff;
}
.quick-buttons.tile-pink {
  background: #ec3b83;
}
.quick-buttons.tile-pink:hover {
  background: #ea2474;
}
.quick-buttons.tile-pink .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-pink .num,
.quick-buttons.tile-pink h3,
.quick-buttons.tile-pink p {
  color: #fff;
}
.quick-buttons.tile-orange {
  background: #ffa812;
}
.quick-buttons.tile-orange:hover {
  background: #f89d00;
}
.quick-buttons.tile-orange .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-orange .num,
.quick-buttons.tile-orange h3,
.quick-buttons.tile-orange p {
  color: #fff;
}
.quick-buttons.tile-brown {
  background: #6c541e;
}
.quick-buttons.tile-brown:hover {
  background: #584418;
}
.quick-buttons.tile-brown .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-brown .num,
.quick-buttons.tile-brown h3,
.quick-buttons.tile-brown p {
  color: #fff;
}
.quick-buttons.tile-plum {
  background: #701c1c;
}
.quick-buttons.tile-plum:hover {
  background: #5c1717;
}
.quick-buttons.tile-plum .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-plum .num,
.quick-buttons.tile-plum h3,
.quick-buttons.tile-plum p {
  color: #fff;
}
.quick-buttons.tile-gray {
  background: #e8e8e8;
}
.quick-buttons.tile-gray:hover {
  background: #e1e1e1;
}
.quick-buttons.tile-gray .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-gray .num,
.quick-buttons.tile-gray h3,
.quick-buttons.tile-gray p {
  color: #8f8f8f;
}
.quick-buttons:hover {
  background-color: #252a32;
}
.quick-buttons .icon {
  text-align: center;
  padding: 20px;
}
.quick-buttons .icon i {
  font-size: 80px;
  line-height: 1;
  margin: 0;
  padding: 0;
  vertical-align: middle;
}
.quick-buttons .icon i:before {
  margin: 0;
  padding: 0;
  line-height: 1;
}
.quick-buttons .icon i,
.quick-buttons h3,
.quick-buttons p {
  color: #fff;
}
.quick-buttons .title {
  background: #252a32;
  text-align: center;
}
.quick-buttons .title h3,
.quick-buttons .title p {
  margin: 0;
  padding: 0 20px;
}
.quick-buttons .title h3 {
  padding-top: 20px;
  font-size: 16px;
  font-weight: bold;
}
.quick-buttons .title p {
  padding-bottom: 20px;
  font-size: 11px;
  color: rgba(255, 255, 255, 0.85);
}

.fa-circle:hover {
    color: red;
}

.textPos { 
   position: absolute; 
   top: 10px; 
   left: 0; 
   width: 100%; 
}

h5 { 
   position: absolute; 
   top: 10px; 
   left: -150px; 
   width: 100%; 
}

h5 span { 
   color: white; 
   font: bold 16px/45px Helvetica, Sans-Serif; 
   letter-spacing: -1px;  
   background: rgb(0, 0, 0); /* fallback color */
   background: rgba(0, 0, 0, 0.7);
   padding: 10px; 
}
.iconPos {

    margin-left:-50px;
    margin-top: -300px;
}

.imgContainerDiv {
    height: 300px;
    width: 500px;
    background-size: 100px 100px;
    background-color:#333333;
    overflow: hidden;
    margin: 30px;
  
    background-repeat:repeat;
    z
}
	</style>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		
		jQuery(window).resize(function (){
			if(jQuery(".resize-object").length > 1){
				if((((jQuery(".object-length").first().width()*2)  * 100) / jQuery(window).width()) > 80){
					jQuery(".resize-object").addClass("small-screen-size");
				} else {
					jQuery(".resize-object").removeClass("small-screen-size");
				}
			}
		});
	});
	function saveLandingPage(){
		 var level1 = jQuery("#level1").is(":checked");
		 var level2 = jQuery("#level2").is(":checked");
		 var level3 = jQuery("#level3").is(":checked");
		 var level4 = jQuery("#level4").is(":checked");
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "landingPageEdit.json",
			  data: 'level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4,
			  success: function(data){
				  jQuery("#dialogAlert").text('');
				  jQuery("#dialogAlert").append('<fmt:message key="admin.general.savedLandingPage"/>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	 			  
	           
			  }
			}); 
	 }
	
	 function deleteQuickLink(id, link){
		 jQuery("#dialog").dialog({
			   buttons : {
			        "OK" : function() {
						 jQuery.ajax({
						 	  type: 'POST', 
							  dataType: "json",
							  url: "deleteQuickLink.json",
							  data: 'quickLink='+id,
							  success: function(data){
								  jQuery("#dialog").dialog('close');
								  if(link.parentNode.parentNode.className.indexOf("object-length") > -1){
									  link.parentNode.parentNode.parentNode.remove();
								  } else {
								  	link.parentNode.parentNode.parentNode.removeChild(link.parentNode.parentNode);
							  	}
							  }
							});            
			        },
			        "Cancel" : function() {
			        	jQuery(this).dialog("close");
			        }
			      }
			    });
	 }
	 
	 
	</script>
</head>

<body> 
<div id="dialog" title="Confirmation Required" style="display:none;">
  <fmt:message key="general.QuickViews.delete" />
</div>
<div id="dialogAlert" title="Confirmation" style="display:none;">
</div>
<div class="col-md-12">
	<div id="block" class="">
		<div>
			<div class="col-md-6">
			</div>
			<div class="col-md-12 col-sm-12">
				<div align="right">
				</div>				
			</div>
		</div>
   	</div>
</div>
<div id="block" class="block" > 
<form id="landingPageForm" action="<c:url value="/enviro/landingPageEdit.htm" />">
<div class="header">
<h3><fmt:message key="general.defaultLandingPage"/></h3>
</div>
<div class="row"> 
<div class="col-sm-3 col-xs-2"  align="center" > 
<h3><fmt:message key="general.defaultLandingPage.level1"/></h3><input id="level1"  name="level1" type="checkbox" onchange="saveLandingPage();" <c:if test='${landingPage.defaultLevelOne}'>checked</c:if>/>
</div> 
<div class="col-sm-3 col-xs-2" align="center" > 
<h3><fmt:message key="general.defaultLandingPage.level2"/></h3><input  id="level2"  name="level2" type="checkbox" onchange="saveLandingPage();" <c:if test='${landingPage.defaultLevelTwo}'>checked</c:if>/>
</div> 
<div class="col-sm-3 col-xs-2" align="center" > 
<h3><fmt:message key="general.defaultLandingPage.level3"/></h3><input  id="level3"  name="level3" type="checkbox" onchange="saveLandingPage();" <c:if test='${landingPage.defaultLevelThree}'>checked</c:if>/>
</div> 
<div class="col-sm-3 col-xs-2" align="center" > 
<h3><fmt:message key="general.defaultLandingPage.level4"/></h3><input id="level4"  name="level4" type="checkbox" onchange="saveLandingPage();" <c:if test='${landingPage.defaultLevelFour}'>checked</c:if>/>
</div> 
</div>
</form>
<br/>
<div id="block" class="block" > 
	
<div class="header">
<h3><fmt:message key="general.QuickLinks"/></h3>
</div>


<div class="stats_bar">                
                
<div class="row"> 
	<c:forEach items="${links}" var="link" varStatus="status">
			<a href='<c:url value="/enviro/quickLinkEdit.htm?showId=${link.id}" />' >
				<div title="<c:out value ="${link.hint}"/>" class="col-sm-2 col-xs-4 quick-buttons tile-${link.bgcolour}" style="padding:0px;width:250px;height:110px;box-sizing:border-box;margin-left:15px"> 
					<span class="fa-stack fa-lg close-button" onclick='deleteQuickLink(${link.id},this);return false;' style="float: right" title="<fmt:message key="delete" />">
       					 <i class="fa fa-circle fa-stack-2x" style="color:black"></i>
       					 <i class="fa fa-times fa-stack-1x fa-inverse"></i>
   					 </span>
					<div class="quick-buttons tile-${link.bgcolour}" > 
					<div class="icon"><i class="fa fa-${link.symbol}"></i></div>  
					<h3><c:out value="${link.label}" /></h3> <p>&nbsp;</p>
					</div> 
					
				</div> 
			</a>
			<div class="clear visible-xs"></div> 
		</c:forEach> 
		<a href="<c:url value="/enviro/quickLinkEdit.htm" />" >
			<div class="col-sm-2 col-xs-4 tile-gray" style="padding:0px;width:250px;box-sizing:border-box;margin-left:15px"> 
				<div class="quick-buttons tile-gray">
				<div class="icon"><i class="fa fa-plus"></i></div>  
				<h3><fmt:message key="quickLink.add" /></h3> <p><fmt:message key="quickLink.newLink" /></p> </div> 
			</div>
		</a>  
</div> 
    

</div> 
<div class="content col-sm-12">
    
</div>
<div class="header">
<h3><fmt:message key="general.QuickViews"/></h3>
</div>	
	<div class="row" style="padding-bottom: 50px">
		<c:forEach items="${myImageLinks}" var="ilink" varStatus="status">
				<div  class="col-sm-6 col-xs-4 nowrap resize-object" align="center" >
 
					<h5><span ><c:out value="${ilink.label}" /></span></h5> <p>&nbsp;</p>
				<div class="col-sm-6 col-xs-4 box-images imgContainerDiv object-length"> 
					</h3> <p>&nbsp;</p>
					<a href='<c:url value="/enviro/quickViewEdit.htm?showId=${ilink.id}" />' >
						<%-- <img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${link.image}" alt="" border=3 style="max-height:150px"/> --%>
						<%-- <img src="../images/workspace/warehouse.PNG" alt="${link.hint}" /> --%>
						<img src="data:image/jpg;base64,${ilink.displayImage}"  style='height: 100%; width: 100%; object-fit: contain' title="${ilink.hint}" alt="${ilink.hint}"/>
					<span class="fa-stack fa-lg close-button iconPos" onclick='deleteQuickLink(${ilink.id},this);return false;' title="<fmt:message key="delete" />">
       					 <i class="fa fa-circle fa-stack-2x" style="color:black"></i>
       					 <i class="fa fa-times fa-stack-1x fa-inverse"></i>
   					 </span> 
					</a>
				</div> 
				</div>
			<div class="clear visible-xs"></div> 
		</c:forEach>

	  	<a href="<c:url value="/enviro/quickViewEdit.htm" />" class="resize-object">
			<div class="col-sm-6 col-xs-4" align="center"> 
			<h3 style="align:center">&nbsp;</h3> <p>&nbsp;</p>
			<div class="quick-buttons tile-gray" style="width:60%;height:200px" align="center">
			<div class="icon"><i class="fa fa-plus"></i></div>  
			<h3><fmt:message key="quickLink.add" /></h3> <p><fmt:message key="quickLink.newView" /></p> </div> 
			</div>
		</a> 
	</div>
</div>

</div>

</body>
</html>